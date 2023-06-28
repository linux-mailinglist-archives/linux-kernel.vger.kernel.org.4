Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA4AB74101B
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 13:32:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231361AbjF1Lcs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 07:32:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230409AbjF1Lcq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 07:32:46 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 694872D52
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 04:32:45 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-3141140f51bso116943f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 04:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687951964; x=1690543964;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+6lmlFVNjM5Cb5lXMgqZptXE+TaesBmngRzxOeWBOik=;
        b=JlBQyc2fxVlmFPJeEW2Z+eQfudAVjmJUIoIj1qGOSKvUZ8xM1ZVFMz23V3M2ydeONX
         wO3D4yb5czNNMecSMdcX8ebAp/FAnUjzl19G6epxzU6AmKgqcV8RnQLoRcAlww9WOI1k
         DjoaRQgStmJ4bWdHyaqPsrbcw0N6fbV2eWSbH6WITqWeM3AB5RRVUIVygyT+bZZ799Fb
         /LZtwGmdN+ppMkgFdflpjLsXtEVA68JK3I4vUaUmd3Q3fHTGgr9y1FJFIcKEaoEMF1uT
         8ekTtsiGjiFddrrNbghZFNN8gHHArU3YadXa9nBD1Qi3Ropmvo14UUbhje9Nl1M0Es8b
         /aKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687951964; x=1690543964;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+6lmlFVNjM5Cb5lXMgqZptXE+TaesBmngRzxOeWBOik=;
        b=I0s9X//mkaJV6CtoCw6JsAcybcmD5vSvzjZtZih53wsQ2t05C7ZJrvSlFIlPJtYJ3A
         2lTBiarIjYcvzJno2rccOj24h+X5Uv1ciS3vJaJAeQb3V1psUW+yQGb0LFMDdE+FFa7g
         3QqMTvSEhHvOEgXpKNVqYsZzKT81slTHCThFjSlrM5fv1bH7g5WPH4xw6FoXaVoCQJFF
         WGR4CYsJ/2gBCbAHa3QSOR6ijMoGb8ukuEmLhqxoVlwRnsreXZi6QrqpzLkBBUds8ZE9
         rjtg4uDx2yzF/x88UTXcwfdxJ6L6JY6Zm7adY0xV/wrI0IaIQACAgrG2Qeabnr5XDEXk
         orTA==
X-Gm-Message-State: ABy/qLbjt3jR/EZhDEq8qlxI3j2gKbdN2WfNtasprnxFTEamNOpTpx7R
        dBqUIQmTgq0DrxSX69JHrxVFhUaCBuNa6R3KuTs=
X-Google-Smtp-Source: APBJJlEd16N1IdgVeUSMC3DSgUMRguMJCgvwLvoV49jy+a/9p6nQCX4M9XVETFgkz+OSmdXgnGIdo+6M7mBhbmDYEU0=
X-Received: by 2002:adf:e4d0:0:b0:314:1025:96fd with SMTP id
 v16-20020adfe4d0000000b00314102596fdmr637013wrm.47.1687951963757; Wed, 28 Jun
 2023 04:32:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230628105250.40874-1-dg573847474@gmail.com> <2023062851-gutter-rudder-5c2d@gregkh>
In-Reply-To: <2023062851-gutter-rudder-5c2d@gregkh>
From:   Chengfeng Ye <dg573847474@gmail.com>
Date:   Wed, 28 Jun 2023 19:32:32 +0800
Message-ID: <CAAo+4rX5nJo63ZF64d3rf7_QC+1pR+-EBH7_5JrsrJn1nhpkfQ@mail.gmail.com>
Subject: Re: [PATCH] misc: bcm_vk: Fix potential deadlock on &vk->ctx_lock
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     scott.branden@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
        arnd@arndb.de, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the reply! V2 patch is sent including more detail of the static
analyzer and testing process.

Best Regards,
Chengfeng

Greg KH <gregkh@linuxfoundation.org> =E4=BA=8E2023=E5=B9=B46=E6=9C=8828=E6=
=97=A5=E5=91=A8=E4=B8=89 19:00=E5=86=99=E9=81=93=EF=BC=9A
>
> On Wed, Jun 28, 2023 at 10:52:50AM +0000, Chengfeng Ye wrote:
> > As &vk->ctx_lock is acquired by timer bcm_vk_hb_poll() under softirq
> > context, other process context code should disable irq or bottom-half
> > before acquire the same lock, otherwise deadlock could happen if the
> > timer preempt the execution while the lock is held in process context
> > on the same CPU.
> >
> > Possible deadlock scenario
> > bcm_vk_open()
> >     -> bcm_vk_get_ctx()
> >     -> spin_lock(&vk->ctx_lock)
> >         <timer iterrupt>
> >         -> bcm_vk_hb_poll()
> >         -> bcm_vk_blk_drv_access()
> >         -> spin_lock_irqsave(&vk->ctx_lock, flags) (deadlock here)
> >
> > This flaw was found using an experimental static analysis tool we are
> > developing for irq-related deadlock.
> >
> > The tentative patch fix the potential deadlock by spin_lock_irqsave().
>
> how was this tested?  As per the file,
> Documentation/process/researcher-guidelines.rst, you have to show this.
>
> thanks,
>
> greg k-h
