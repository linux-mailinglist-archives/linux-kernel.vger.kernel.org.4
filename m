Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1483A6154BC
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 23:08:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbiKAWIb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 18:08:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229827AbiKAWI1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 18:08:27 -0400
Received: from hermod.demsh.org (hermod.demsh.org [45.140.147.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64F593B2;
        Tue,  1 Nov 2022 15:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=demsh.org; s=022020;
        t=1667340498;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JsVluRGEduZjuSL7d5lIwtKYLmOrWX8w9pS3D6z92D4=;
        b=sJ4eoiXtddqyC/Dyuvh4ok/Fwveg9Ty/0izU3Hq28nZ/giEhgJ3ecg6wt6SusiUI7SbSSD
        ZZkFZXxyRIzWJUemGo+E8GAOKcYzz0hAp5XxqtSgNLzsMbWtk9dZ+laqYeB4cTvwsXLMzN
        PrmrPEVeTDFL2yyRjSBeV2yHmCSIVWByuRhwCeJYFXgf725ErNVh5QhC8pzRhGBePNRn5W
        E4RkCWRL6CqMazree2ftIHBOWoMG9Z3J9jRwlVKsOG5BCOLNgKwacEyCCpHCwjdCoIGtyn
        heXuZhiLtezfhH4Bibc+1wA2JNqrx5YC1eZpK5IMH7ThUUYdNhf21kFQLH8BIQ==
Received: from xps.demsh.org (algiz.demsh.org [94.103.82.47])
        by hermod.demsh.org (OpenSMTPD) with ESMTPSA id fd305621 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO) auth=yes user=me;
        Tue, 1 Nov 2022 22:08:18 +0000 (UTC)
Date:   Wed, 2 Nov 2022 01:08:26 +0300
From:   Dmitrii Tcvetkov <me@demsh.org>
To:     Keith Busch <kbusch@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Song Liu <song@kernel.org>,
        linux-raid@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [bisected] RAID1 direct IO redirecting sector loop since 6.0
Message-ID: <20221102010826.12dcb4bb@xps.demsh.org>
In-Reply-To: <Y2GNHEtDnoybz+fW@kbusch-mbp>
References: <20221101001558.648ee024@xps.demsh.org>
        <Y2FVzdcro8HCfODK@kbusch-mbp>
        <20221101235144.06a3dbd3@xps.demsh.org>
        <Y2GNHEtDnoybz+fW@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=0.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,SPF_HELO_NONE,SPF_PASS,URIBL_BLACK autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Nov 2022 15:18:20 -0600
Keith Busch <kbusch@kernel.org> wrote:
> Oh shoot, sorry about that! Should have been this:
> 
> @@ -703,6 +702,7 @@ void disk_stack_limits(struct gendisk *disk,
> struct block_device *bdev, pr_notice("%s: Warning: Device %pg is
> misaligned\n", disk->disk_name, bdev);
> 
> +       blk_queue_dma_alignment(t, queue_logical_block_size(t) - 1);
>         disk_update_readahead(disk);
>  }
>  EXPORT_SYMBOL(disk_stack_limits);

This didn't change behaviour, second guest still hangs.
