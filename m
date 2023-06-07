Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 804F472564F
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 09:48:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239031AbjFGHsG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 03:48:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239330AbjFGHrl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 03:47:41 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06F03212E;
        Wed,  7 Jun 2023 00:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=zx7QiNnFC0Cpwen1yiSTOeTK/8rpSNjru1sqAkfYhQU=; b=yAWYaRs/exv9l4aW3kRh15uGCe
        26FluPYMyAqbRNSSIKILK5H+P/HRb+mLP2AVCZD8Q6/dOrzSkIWCs7Epg5moTHRi1Pj0dpEWULnsO
        O7NYmBvnRZqEt+xSMqI3EI3MQfvt5yQ42VPSZsOOdcFokDphTUPA66kyZ6YO1YnkrYywoCHQYV3Ea
        0MDsIqEqxuTqVM0/S2p9YhiyYiGf5LX7u3r4ZZIlUTMCZAFMMuz8srwGclvl/WuS8PZXb9qms4iiV
        jkrDp65eAYRHr6bzEzcpMFs/3lcXVHwIJ6nXcIQysCnXcIa9qte7v7qw+LV/9Oskk3ET3QhPsIhKZ
        nl2txkrA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1q6ns0-004nZS-2l;
        Wed, 07 Jun 2023 07:46:16 +0000
Date:   Wed, 7 Jun 2023 00:46:16 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Demi Marie Obenour <demi@invisiblethingslab.com>
Cc:     Roger Pau =?iso-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>,
        Jens Axboe <axboe@kernel.dk>,
        Marek =?iso-8859-1?Q?Marczykowski-G=F3recki?= 
        <marmarek@invisiblethingslab.com>, xen-devel@lists.xenproject.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] xen-blkback: Inform userspace that device has been
 opened
Message-ID: <ZIA1yLiJyfcJ45vD@infradead.org>
References: <20230601214823.1701-1-demi@invisiblethingslab.com>
 <20230601214823.1701-3-demi@invisiblethingslab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230601214823.1701-3-demi@invisiblethingslab.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> --- a/drivers/block/xen-blkback/xenbus.c
> +++ b/drivers/block/xen-blkback/xenbus.c
> @@ -3,6 +3,20 @@
>      Copyright (C) 2005 Rusty Russell <rusty@rustcorp.com.au>
>      Copyright (C) 2005 XenSource Ltd
>  
> +In addition to the Xenstore nodes required by the Xen block device
> +specification, this implementation of blkback uses a new Xenstore
> +node: "opened".  blkback sets "opened" to "0" before the hotplug script
> +is called.  Once the device node has been opened, blkback sets "opened"
> +to "1".

This is a really odd comment style, and a really strange place for it.
To me it feels like this should just be a file in Documentation as it
relates to how to use the driver, and doesn't really explain the code.
