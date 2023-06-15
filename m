Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 967AA731AD9
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 16:09:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344898AbjFOOJQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 10:09:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344881AbjFOOJO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 10:09:14 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DA4A171C
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 07:09:13 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1b3db8f3d07so25966265ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 07:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686838153; x=1689430153;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bpIQMkZ9eOZ0j/nszbK2fYznfBdaL0kTvlpcwAx2HD0=;
        b=PYBiCNZHCfD/qpe+6EpESPPuD8WD9zVvsblqOh1yQf3mCU+6R+zP+DcmgS7/LE5yzv
         okoypXDWpEwrjTg6NzmVRFmzwCelmcItXVYNHoZDs5m5EvCurScfbSaEowS0LHS25Q0O
         eoUBiVQ8UZG2aKewzbfwLhsdQZgaaew8k/8iCPttpvhUNTWn9v145gBemhLqc8Av1DAC
         HtCaRKRg5cxklfETYgkK/Epwr0i6Bz6eFjli02ZH5m/aMRCIpXE2Q9lfymH+A0+568p5
         pBKW1wIokVKNx5NL7Y5AVhoEfeeLRBtFd1cCd+I1nXVb62PSunivg9LVojhybELqm4uP
         dhfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686838153; x=1689430153;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bpIQMkZ9eOZ0j/nszbK2fYznfBdaL0kTvlpcwAx2HD0=;
        b=XFcaXH+oTvx8PEvb83rVQ0dcXK13VCa1irt65LbE2YTm0CdTIUZEHiRcXas0hnUdxu
         KKahnicONgjhoq561M8ZN/Ts1cR8smUZdrS54RS8/3pCfbJrbPyZN0SksH+Mptu3ci0B
         lv5M3vk4y9KBY1xr64th6wUIA395gb7Lw6Kpk4HoDAcGpY4kQLuew/Q1t/+2M2B9AVY+
         Lf1lYnUA0db/A2f5Qilff5bjLo2iSxWRIGLrY5tMm2HbgyQmlt9rIHS+KzPq8HOVdO6C
         UhdXnhGyCFYGhbFbhE94E8ZRL6c408GEozBVBJ7k5X2+Gw+c4dVGVqF0yZHCD+l5K6ij
         ZDwQ==
X-Gm-Message-State: AC+VfDxuzVaLYAcrlIxd8bLvY+KJvImxbhXwtCUfUqWDC1oaxazaZMaP
        9P+DYXkUqrBT9r9XvIb8x2M=
X-Google-Smtp-Source: ACHHUZ5G1/D5Ky4nNf/bSMsNCqyAI5BF4KhmlYSGEm0yB5rYFhvXv7+XIxbpLini0oZU5rO/pbChSQ==
X-Received: by 2002:a17:903:120b:b0:1b0:2658:daf7 with SMTP id l11-20020a170903120b00b001b02658daf7mr16769592plh.36.1686838152870;
        Thu, 15 Jun 2023 07:09:12 -0700 (PDT)
Received: from yogi-Zephyrus ([103.251.210.211])
        by smtp.gmail.com with ESMTPSA id w8-20020a170902d70800b001ab1b7bae5asm3888613ply.184.2023.06.15.07.09.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jun 2023 07:09:12 -0700 (PDT)
Date:   Thu, 15 Jun 2023 19:39:08 +0530
From:   Yogesh Hegde <yogi.kernel@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@linaro.org>,
        Philipp Hortmann <philipp.g.hortmann@gmail.com>
Subject: Re: [PATCH v2 0/5] Trivial code cleanup patches
Message-ID: <20230615140908.GB37552@yogi-Zephyrus>
References: <cover.1686149467.git.yogi.kernel@gmail.com>
 <2023061532-fall-earthy-c429@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023061532-fall-earthy-c429@gregkh>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 15, 2023 at 12:36:45PM +0200, Greg Kroah-Hartman wrote:
> On Wed, Jun 07, 2023 at 08:31:19PM +0530, Yogesh Hegde wrote:
> > These patches remove variables in the struct rtllib_device that were 
> > set only once throughout the driver. Instead of using these variables, 
> > the patches modify the relevant code to directly call the corresponding 
> > functions, eliminating unnecessary indirection and removing CamelCase.
> > The patches are required to be applied in sequence.
> > 
> > Yogesh Hegde (5):
> >   staging: rtl8192e: Remove variable SetWirelessMode
> >   staging: rtl8192e: Remove variable SetBWModeHandler
> >   staging: rtl8192e: Remove variable LeisurePSLeave
> >   staging: rtl8192e: Remove variable InitialGainHandler
> >   staging: rtl8192e: Remove DRV_NAME definition in rtllib_debug.h
> > 
> >  drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c |  4 ++--
> >  drivers/staging/rtl8192e/rtl8192e/rtl_core.c   |  4 ----
> >  drivers/staging/rtl8192e/rtl819x_HTProc.c      |  8 ++++----
> >  drivers/staging/rtl8192e/rtllib.h              |  6 ------
> >  drivers/staging/rtl8192e/rtllib_debug.h        |  5 -----
> >  drivers/staging/rtl8192e/rtllib_rx.c           |  3 ++-
> >  drivers/staging/rtl8192e/rtllib_softmac.c      | 16 +++++++---------
> >  drivers/staging/rtl8192e/rtllib_softmac_wx.c   |  9 +++++----
> >  8 files changed, 20 insertions(+), 35 deletions(-)
> > 
> > -- 
> > 2.25.1
> > 
> > 
> 
> These break the build, as reported by the test robot, please fix up.

Hi Greg,

These patches do not work because this driver is divided into two
modules.

The driver is loaded in 2 different modules:
sudo insmod drivers/staging/rtl8192e/rtllib.ko
sudo insmod drivers/staging/rtl8192e/rtl8192e/r8192e_pci.ko

So this line is required:
priv->rtllib->SetWirelessMode = rtl92e_set_wireless_mode;
as one name is used in one module and one in the other module.

So when I suggested these fixes
1.  Patchset to combine both the modules into one module.
2.  Or resending v1 of the patchset.

to Dan Carpenter <dan.carpenter@linaro.org> and
Philipp Hortmann <philipp.g.hortmann@gmail.com>, in their opinion both the
suggested fixes are incorrect, which I agree with.

Link to conversation -
https://lore.kernel.org/linux-staging/90813181-02a1-b54f-132b-c68e7b797bb6@gmail.com/

I have yet to find a correct way to solve this problem. Please let me
know if you have any suggestions. 

Regards
Yogesh
