Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E54326DD1A1
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 07:32:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229916AbjDKFcY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 01:32:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjDKFcV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 01:32:21 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A88C1BF7
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 22:32:20 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id e18-20020a17090ac21200b00246952d917fso5331434pjt.4
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 22:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681191140;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=a3iisXOwnW30rx/icPEO9C3iesK5xJm+Bm4Sb697nfw=;
        b=J3l2SMAICYB7v1q28i3RFC+ooRtjGJi0QAACX2G8OeI/usTLeirCQa4vgZ+tpYBoQC
         Xex2IyjR1DENvhHbvtFD8W69RfUSdryq5mi8UK8qsJEVXSZry3VW32Dslrwn8B20keW+
         yO+KQRhrnT+lbQXYyytDZHVkI8x5/bc21NQp6sVnIMFT0ZYWI/P4PJgf2kLAgjC4Pvuc
         AyoAeAsRkzHkJcJc4mmNOkBa3+eLmauFHKarxkY7DN5xU9BgvycpEUMM3Fa9Rp7HgBcB
         MEHSdBdLQkJLTdFDnXhNwf266SePCXzrWTe5qKXXfQxlqnB9pGwwpJMIruWEpPhzhdXv
         diYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681191140;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a3iisXOwnW30rx/icPEO9C3iesK5xJm+Bm4Sb697nfw=;
        b=DsVBKyz/dWwKL6bJrY8F/QxMe3F5M38Mwx/Vmh8KBee1Fm6RU1jxS8XgzQ9Dqxxvg7
         TKmKclGvofMMzeURZADjCJHgROjQK67juGMbJBcu9GReYvMvlzlu7DJznGn/m6NZ5DlA
         uIQLgXdjGPCR8jzwGbCWDEUvk/kheLnSX2V3qkAcrOGa7MDR4x2TW0pxnM5nxYyTX4Q3
         6pvkHkPgAPLZIS/QmD6nip/1xyWb8+1S/9OaXoMVu7RPFJvqzz7Z/FRr7/4/QqtA2IK0
         4kex/cceXzZq7mZIDlkUPZ4sYXd0qaNFlgk7XPlbfuqRYXhOr6j3ACvsAZEz7Ttm8Z53
         n0/Q==
X-Gm-Message-State: AAQBX9eTTsrCjGC0rNlttRg55UQP/05xx371z+qV5P1uldiVtUrG3t7f
        HIx/NBkjBXhlXAaHOtdU7F53DMkzrMnSnQ==
X-Google-Smtp-Source: AKy350YWU1FeN5xKtAzXQu/m0zO5LpTxMjlXqA0xlFLDYLlz/x3LSBcYovPGoy7rrOUDYxE8l+KdfA==
X-Received: by 2002:a05:6a20:4a1e:b0:d9:c3f5:2933 with SMTP id fr30-20020a056a204a1e00b000d9c3f52933mr13424365pzb.20.1681191139912;
        Mon, 10 Apr 2023 22:32:19 -0700 (PDT)
Received: from sumitra.com ([59.95.151.140])
        by smtp.gmail.com with ESMTPSA id n21-20020aa78a55000000b00638f5b2d34fsm2375178pfa.32.2023.04.10.22.32.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Apr 2023 22:32:19 -0700 (PDT)
Date:   Mon, 10 Apr 2023 22:32:15 -0700
From:   Sumitra Sharma <sumitraartsy@gmail.com>
To:     Alison Schofield <alison.schofield@intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8192e: Fix logical operator continuations
Message-ID: <20230411053215.GA265224@sumitra.com>
References: <20230408171803.GA262580@sumitra.com>
 <ZDSksGyxnu5eIo+1@aschofie-mobl2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZDSksGyxnu5eIo+1@aschofie-mobl2>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 10, 2023 at 05:07:12PM -0700, Alison Schofield wrote:
> On Sat, Apr 08, 2023 at 10:18:03AM -0700, Sumitra Sharma wrote:
> > Fix logical operator continuation as suggested by Linux kernel
> > coding-style. Check reported by checkpatch:
> > 
> > CHECK: Logical continuations should be on the previous line
> > 
> > Signed-off-by: Sumitra Sharma <sumitraartsy@gmail.com>
> 
> Hi Sumitra,
> 
> That commit message can be explicit, like "Move logical operator
> to previous line"
>

Hi Alison

Okay I will change it. Thank you.

Regards
Sumitra

> Alison
> 
> 
> > ---
> >  drivers/staging/rtl8192e/rtl8192e/rtl_ps.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_ps.c b/drivers/staging/rtl8192e/rtl8192e/rtl_ps.c
> > index 5a1cd22f5e25..58ed394202ae 100644
> > --- a/drivers/staging/rtl8192e/rtl8192e/rtl_ps.c
> > +++ b/drivers/staging/rtl8192e/rtl8192e/rtl_ps.c
> > @@ -209,8 +209,8 @@ void rtl92e_leisure_ps_enter(struct net_device *dev)
> >  					&priv->rtllib->pwr_save_ctrl;
> >  
> >  	if (!((priv->rtllib->iw_mode == IW_MODE_INFRA) &&
> > -	    (priv->rtllib->state == RTLLIB_LINKED))
> > -	    || (priv->rtllib->iw_mode == IW_MODE_ADHOC) ||
> > +	    (priv->rtllib->state == RTLLIB_LINKED)) ||
> > +	    (priv->rtllib->iw_mode == IW_MODE_ADHOC) ||
> >  	    (priv->rtllib->iw_mode == IW_MODE_MASTER))
> >  		return;
> >  
> > -- 
> > 2.25.1
> > 
