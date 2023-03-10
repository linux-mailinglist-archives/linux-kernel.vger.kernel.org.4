Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA0E86B3F1E
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 13:25:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230236AbjCJMZ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 07:25:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbjCJMZz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 07:25:55 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4919112584
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 04:25:53 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id d41-20020a05600c4c2900b003e9e066550fso3289778wmp.4
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 04:25:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678451152;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MHl+AGoIadXu/jEHuWQbNUD1NdGyTe9l6pWhk1p94DQ=;
        b=H44JNO2BWh725FN2ZYYZRSQV7Yga5fxC4w/R7S2Wv4lGP/0V/zYen8/3i2IYXlx/ky
         1Q2jlTpNDVekWV7+C2H/qaIkldkRi/8C4uX3W00XtPiFPqNP9Yu0LdlvSquxqnIit4iZ
         dihwuNmSf4e2mBc0HJyMz4f1v67gCnZ8s3ecfJgRYhsMyNivL3iG/+hdrHiOt/H4zYfM
         Lp7K2Tv01C/xlAEvgdmEXD88c66i1oDr2p4L+7chfCgJtMt9wJP1ML2JY+0K3zw5datk
         XWQcGp+5Ri261+VlrsKne0QQiZiby+QzENFPP/zHNDbxPq68xEjke7yiQO4jaf1CmiWz
         1p6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678451152;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MHl+AGoIadXu/jEHuWQbNUD1NdGyTe9l6pWhk1p94DQ=;
        b=gTSIosqm12UkHUJqbFObCHZy8xJniG6PZR3BA2Okcb87nxRWaNtvSzQWsJrAcJpmMy
         L73SVPNWLpgK/5FG/D2xeZXvC9sVWMGkWAMdVyUSXuycVDK3YTBBvOjKhv9j076omrKs
         P0eB/Z2SEfaR9ZGLU8B9o3ipr7XrqUjGlkl+LSLcfYpK7Kbh7jiAwDCLx2qzEeOIF+cb
         z/sSGIVuo2KGov7Pbybdl/zJZ/NoZV2fYoJe3pFkE/aWRgc7olfhTO+KGOBfEfUkNMz+
         r7T7hOlT04TmarT0ijrXZ8BMpDOMW7DBAANttIhj2ucBq+CSyUNpJyhMa7pIfk/52JDc
         W+qg==
X-Gm-Message-State: AO0yUKU7nUSd5/IZM6dy3DZIamyhi/r95KKkEIhtCAEsMrNNQGC55M0h
        dDlK1TEhNYGQFePIugieYto=
X-Google-Smtp-Source: AK7set/kEV7hq38ykRFtbYi+1WWB5H9MDXeg/UhyAGEyIAm7diXnIw8C0IrGGDzPPbDoMLxUZ0Iv7A==
X-Received: by 2002:a05:600c:a11:b0:3dc:433a:e952 with SMTP id z17-20020a05600c0a1100b003dc433ae952mr2451081wmp.33.1678451152189;
        Fri, 10 Mar 2023 04:25:52 -0800 (PST)
Received: from suse.localnet (host-95-235-93-126.retail.telecomitalia.it. [95.235.93.126])
        by smtp.gmail.com with ESMTPSA id t15-20020a05600c198f00b003e21dcccf9fsm3078157wmq.16.2023.03.10.04.25.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 04:25:51 -0800 (PST)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Dan Carpenter <error27@gmail.com>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Khadija Kamran <kamrankhadijadj@gmail.com>,
        Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        paskripkin@gmail.com, gregkh@linuxfoundation.org,
        outreachy@lists.linux.dev
Subject: Re: [PATCH] Staging: r8188eu: Fixed block comment
Date:   Fri, 10 Mar 2023 13:25:50 +0100
Message-ID: <3436236.som1txNFv6@suse>
In-Reply-To: <bb4e7ac8-5ddf-46c7-8c5a-08839794c5d0@kili.mountain>
References: <Y+8p7Hyaf4LhO/Sw@khadija-virtual-machine> <10238267.qUNvkh4Gvn@suse>
 <bb4e7ac8-5ddf-46c7-8c5a-08839794c5d0@kili.mountain>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On venerd=EC 10 marzo 2023 13:09:54 CET Dan Carpenter wrote:
> On Fri, Mar 10, 2023 at 12:52:55PM +0100, Fabio M. De Francesco wrote:
> > On venerd=EC 17 febbraio 2023 08:17:00 CET Khadija Kamran wrote:
> > > Fixed block comment by adding '*' in each line. The Check message was
> > > shown by using checkpatch.pl script.
> > >=20
> > > Signed-off-by: Khadija Kamran <kamrankhadijadj@gmail.com>
> > > ---
> > >=20
> > >  drivers/staging/r8188eu/core/rtw_br_ext.c | 19 ++++++++++---------
> > >  1 file changed, 10 insertions(+), 9 deletions(-)
> >=20
> > Hi Khadija,
> >=20
> > As Greg said this driver is not here any longer. This makes me think th=
at
> > you
> > forgot at least two things...
> >=20
> > 1) Please pull and rebase the staging tree every day while working on
> > patches
> > during this period of the Outreachy project. If you had done so, you wo=
uld
> > have noticed that your patch cannot any more be applied.
>=20
> This patch was sent long before the driver was deleted...  The patch was
> fine and would have been applied if the driver hadn't been removed.
>=20
> regards,
> dan carpenter

I'm sorry I did not look at the day of the submission.
I took for granted that this patch had been sent after the contribution per=
iod=20
start date, March 6th 2023.

Thanks Dan for making me notice this mistake.

Regards,

=46abio



