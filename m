Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBEC370D0BA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 03:58:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231796AbjEWB6C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 21:58:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbjEWB6B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 21:58:01 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E0A5CA
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 18:58:00 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1ae615d5018so44066765ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 18:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684807080; x=1687399080;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T5cOI+ye5ZCld7XQmpU4XJbU8qLqZl9B8hKE1Vzf+Mo=;
        b=Df69KUR/emv3GBQ0d2NKF8iX7ImzJ4DRsXufcY46ex6tOGyGYf7azEiy9HtJCZ/PvO
         9GZO8NdjrxGXjenW6c81ItX9NxySJko53/cglIEw3rAky2GBabgM4Cdvq4Sw8dAa23Zk
         cGqhlPYDTkmxcFTUAscDt/F2Vc86dT9Qg54pzk1WqadJgnNp9XRgvyBB/FrLdh9fOdUd
         O4ce34o7yfWo2Mb6/n+kpTSz4iFzhENnDu4jB1M3xm39+Ueh0gtxNQkbkQTNCsbpqYgB
         QEFna13VIjILd72RYzUbZJLhwMaWFc8isEiXB0SmWjvVileDqmu2wyePYImAnd5mOQZO
         U0ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684807080; x=1687399080;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T5cOI+ye5ZCld7XQmpU4XJbU8qLqZl9B8hKE1Vzf+Mo=;
        b=kkQWj8qWkH/5yz3QeUywhlMJUUTRBIbCdJq5ddoEOnSCq9akVGtFAblB+pZSaQRMyR
         87ldhCBj/f+10eXH/7hYZ2Q+ogp4jOFaIyUSeOGTmz8DW8fVIksiquH4V0wj8gAVXElJ
         0XxEp/Kr6dnzHrF0SRnBt6vbj77k0+/qnHK+6+xJxWOmXHtcIKfnV4pAyLX1U4whSc47
         s1t0bNmtDWhJYGAN/GYXSMOgNdrBbsEGaCH8tR62W0eZmZqr+QFPLZmIvU9jz5UksGNO
         hGAQbCh/dPBocBKxUcbjy3qLH/KB6KuZDjAx3BMAW86ZqbU02pPREODr8zTDpvXUlTpU
         pfAg==
X-Gm-Message-State: AC+VfDxbP5Tv684yQc62ZytrQw/PMUR+PiYE4cLCJ5/HQdwBRxizBwBu
        gMQInfdnTw/nEvjQ49qg8QA=
X-Google-Smtp-Source: ACHHUZ6jF22XnzOSUIIA6icB6A9EF+a+6SzpMrho2Akf4oa6Lj8jCYVNtqgo2QdNnKruiCqovhesYQ==
X-Received: by 2002:a17:902:a589:b0:1ad:dd21:2691 with SMTP id az9-20020a170902a58900b001addd212691mr14084231plb.10.1684807079951;
        Mon, 22 May 2023 18:57:59 -0700 (PDT)
Received: from localhost ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id q10-20020a170902bd8a00b001a1a82fc6d3sm5424615pls.268.2023.05.22.18.57.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 22 May 2023 18:57:59 -0700 (PDT)
Date:   Tue, 23 May 2023 10:05:58 +0800
From:   Yue Hu <zbestahu@gmail.com>
To:     Gao Xiang <hsiangkao@linux.alibaba.com>
Cc:     linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
        Sandeep Dhavale <dhavale@google.com>, huyue2@coolpad.com,
        zhangwen@coolpad.com
Subject: Re: [PATCH] erofs: use HIPRI by default if per-cpu kthreads are
 enabled
Message-ID: <20230523100558.00007b78.zbestahu@gmail.com>
In-Reply-To: <3177581a-2252-04a0-1933-fc4cf100046d@linux.alibaba.com>
References: <20230522092141.124290-1-hsiangkao@linux.alibaba.com>
        <20230523085226.00006933.zbestahu@gmail.com>
        <3177581a-2252-04a0-1933-fc4cf100046d@linux.alibaba.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 May 2023 09:53:06 +0800
Gao Xiang <hsiangkao@linux.alibaba.com> wrote:

> On 2023/5/23 17:52, Yue Hu wrote:
> > On Mon, 22 May 2023 17:21:41 +0800
> > Gao Xiang <hsiangkao@linux.alibaba.com> wrote:
> >   
> >> As Sandeep shown [1], high priority RT per-cpu kthreads are
> >> typically helpful for Android scenarios to minimize the scheduling
> >> latencies.
> >>
> >> Switch EROFS_FS_PCPU_KTHREAD_HIPRI on by default if
> >> EROFS_FS_PCPU_KTHREAD is on since it's the typical use cases for
> >> EROFS_FS_PCPU_KTHREAD.
> >>
> >> Also clean up unneeded sched_set_normal().
> >>
> >> [1] https://lore.kernel.org/r/CAB=BE-SBtO6vcoyLNA9F-9VaN5R0t3o_Zn+FW8GbO6wyUqFneQ@mail.gmail.com
> >> Cc: Sandeep Dhavale <dhavale@google.com>
> >> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> >> ---
> >>   fs/erofs/Kconfig | 1 +
> >>   fs/erofs/zdata.c | 2 --
> >>   2 files changed, 1 insertion(+), 2 deletions(-)
> >>
> >> diff --git a/fs/erofs/Kconfig b/fs/erofs/Kconfig
> >> index 704fb59577e0..f259d92c9720 100644
> >> --- a/fs/erofs/Kconfig
> >> +++ b/fs/erofs/Kconfig
> >> @@ -121,6 +121,7 @@ config EROFS_FS_PCPU_KTHREAD
> >>   config EROFS_FS_PCPU_KTHREAD_HIPRI
> >>   	bool "EROFS high priority per-CPU kthread workers"
> >>   	depends on EROFS_FS_ZIP && EROFS_FS_PCPU_KTHREAD
> >> +	default y  
> > 
> > How about removing this config option?  
> 
> I tend to leave it as is.

Okay.

Reviewed-by: Yue Hu <huyue2@coolpad.com>

> 
> Thanks,
> Gao Xiang

