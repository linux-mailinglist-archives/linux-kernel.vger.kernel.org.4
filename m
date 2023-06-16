Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 466BD732798
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 08:31:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244259AbjFPG3h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 02:29:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243365AbjFPG3T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 02:29:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5439D3C12
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 23:27:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BFEA06224C
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 06:26:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACF5CC433C0;
        Fri, 16 Jun 2023 06:26:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686896799;
        bh=4EcwEMgkYRLzLNB8TT17Qj49hQBObCXTzX9tf4q8nj0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wcLikNmDoL/EG5uIxXebAZ2s3HmSlkpaH6h6wY5MWa83gC5KF0hp9TVw6cFA8II9C
         cxPuCeche5rIdnr/6afFokMv4m3W9BkYq0m6nUA4wcOAZzFYBOQvcwcaIeVihdaEk1
         i2/Qjet8/symdFiZK/sn0FnTb3FHacgzozM7Zw50=
Date:   Fri, 16 Jun 2023 08:26:36 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Alison Wang <alison.wang@nxp.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        leoyang.li@nxp.com, xuelin.shi@nxp.com, xiaofeng.ren@nxp.com,
        feng.guo@nxp.com
Subject: Re: [PATCH 1/8] ethosu: Add Arm Ethos-U driver
Message-ID: <2023061638-lushness-jeeringly-314d@gregkh>
References: <20230616055913.2360-1-alison.wang@nxp.com>
 <20230616055913.2360-2-alison.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230616055913.2360-2-alison.wang@nxp.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 16, 2023 at 01:59:06PM +0800, Alison Wang wrote:
> +static int ethosu_buffer_release(struct inode *inode,
> +				 struct file *file)
> +{
> +	struct ethosu_buffer *buf = file->private_data;
> +
> +	dev_info(buf->edev->dev, "Buffer release. handle=0x%pK\n", buf);

Oh, and please remove your debugging code that you have here, and all
over the place in the driver.  When drivers work properly, they are
quiet, NOT printing out to the information log.

Are you sure that all of those people reviewed this thing?

greg k-h
