Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D606636C39
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 22:19:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237323AbiKWVS7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 16:18:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235288AbiKWVS5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 16:18:57 -0500
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 886155E3D2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 13:18:56 -0800 (PST)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-3691e040abaso186471287b3.9
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 13:18:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=W6C7qv1eJ7qa2Du5dHzN1Fjf/Nj8aikV4ptLqLHX0vs=;
        b=Ck9gI6yZlGyNjFrQKSsTz1XybUaSp6mnps+4dlur+2Ge1WRrjHBgQGdfMVGILUwCt5
         lccQDd/tjiIbWGqQvK0E+wj5himEckU1/ffz3I3AbA0419bn4d+4MLtEwu05w0IVxeHj
         g/gWdjlT05oXa7w4RcyxWbPMCxutdUnsVMUfzahL8CQJm3UM8QBW2AM1e2d1zWNkvxXQ
         FtcxotEbWPV5Vd70GQ/fr1ZJKa/ji5YbwoXjBVT7BubWgRn4awEgHJq+N3tcInF0smx+
         Sw8DA+f209tt9deFkXQT7P4hyQ0FlRyea5PjZgktdPmdzrqkZ8QA+feBKktSCddGUQXd
         TUCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W6C7qv1eJ7qa2Du5dHzN1Fjf/Nj8aikV4ptLqLHX0vs=;
        b=XZbvV0C7C4m+/mTER2B5ri+jLXzZPpQULbZkCpapsFYIRQxiQ82RBU209LcNedK3/T
         18eqp50P4v33pOKbxSd/XwwWlSiLZAOyz+5JXfAu/KnjkibejN5okgLr8UngMGiA07lO
         q6tlnxjIVlDuy4bLHNr8pI/wco5Mw1MDxlafBZX7SHR6xHUbtmgz282tFsll8JaXh49n
         vP57akJGRm0fUYuyw8u1IdOaQrXMDSnpBb5zYdHil4Rg+75uVnBp6OImd/4RnvVDyM65
         hIiKrbJJQ7BzNFqAaPqU84OqeUoXf5IX7N0DnHkF//o0L4JEYlaKikiarGtD5HMkXYfD
         pLiw==
X-Gm-Message-State: ANoB5pm6LQIbxulZZyphruCCIS3xdtufRUmS7fid4BAESfP+vl43Ln3m
        97VB3LJxb8Gz3Dbb6pEr+i6jf5ocVVqySlSXUZlPPQ==
X-Google-Smtp-Source: AA0mqf6HLM/A8CnHB2XzssV+QH1/rTnpGGlMB12IexeRgd8CAXHREUFMoF1QrLKlBUTNB3FoMOcXuVMAR5UqMZGRXPw=
X-Received: by 2002:a81:5748:0:b0:3b1:eee3:32a with SMTP id
 l69-20020a815748000000b003b1eee3032amr2969067ywb.325.1669238335822; Wed, 23
 Nov 2022 13:18:55 -0800 (PST)
MIME-Version: 1.0
References: <20221123021153.205291-1-xiafukun@huawei.com>
In-Reply-To: <20221123021153.205291-1-xiafukun@huawei.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 23 Nov 2022 22:18:44 +0100
Message-ID: <CACRpkdayR=02Q_su3Vq=K1tgY64EE+Q1411-fM2gxMSX=WC0Sw@mail.gmail.com>
Subject: Re: [PATCH -next] usb: fotg210: Fix build error when
 CONFIG_USB_FOTG210_UDC=y && CONFIG_USB_GADGET=m
To:     Xia Fukun <xiafukun@huawei.com>
Cc:     gregkh@linuxfoundation.org, renzhijie2@huawei.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Xia,

thanks for your patch!

On Wed, Nov 23, 2022 at 3:15 AM Xia Fukun <xiafukun@huawei.com> wrote:

> The combination of CONFIG_USB_FOTG210_UDC=y and
> CONFIG_USB_GADGET=m results in the following error:
(...)
> Make USB_FOTG210_UDC depends on USB_GADGET=y to fix this.
>
> Fixes: 1dd33a9f1b95 ("usb: fotg210: Collect pieces of dual mode controller")
> Signed-off-by: Xia Fukun <xiafukun@huawei.com>

Isn't this patch that Greg already merged fixing this issue
more thoroughly?
https://lore.kernel.org/linux-usb/20221111144821.113665-1-linus.walleij@linaro.org/

Please have a look & test!

Yours,
Linus Walleij
