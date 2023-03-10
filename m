Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C132D6B3E69
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 12:53:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229584AbjCJLxE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 06:53:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjCJLxC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 06:53:02 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2284C1725
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 03:52:59 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id p23-20020a05600c1d9700b003ead4835046so4834960wms.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 03:52:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678449177;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vnnitKm8ItU8z8UrLfELFTzSkVG2XnAG/fMiiC7+9Kw=;
        b=Wz0mqDYqd17E6Wn7L3/29NOx03d1Pqhz9S3gEmC6srrIH0w/inGiKDVH3OW99iGsp1
         idNHqx0KLHxiXvRmEHMzkKoqLslBjgBc10bciShO7DJkyKrlPGB2Q9Gh5bX+vGXWPRCi
         aW8Ol13JUNUlH26E+f7SobZSoMAFRunTcTLBwucLlY7NJXC4+qDa0k3k/e/eUdiNA3mN
         twyMAjC2MZCdO2GX173ex6jxe6/RmfdOCDL/oNlOWScn2AGbL0m2/Ex8hbDs+UrHyVXe
         955auGgApdlM29wm439j7ukwW5qlz6PqnPxvtj2IuRPoGy5lDpK5gSVGN74xdVv2odCK
         XUzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678449177;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vnnitKm8ItU8z8UrLfELFTzSkVG2XnAG/fMiiC7+9Kw=;
        b=bt4LXd15b9EEplgPB/RRfYlfgm+hBDV5wM0R5vfWC+AEnuujdUC6Viig/vukQo5U9s
         KaHzoXFE5WB5R25r7sVqudhjw/nBYqq8OSZ12nE2Xm+vVU2/k4h6KOzmQIpCgYUJ4wtK
         xFTdadiaW4lmsCShGc6IEEZUAiOMDR4jW8B6em6heMLD2PDetbAKGCl7e87YyGWU1IMB
         ZjSPrWoP7q/meqUEFiOpj/J0bMU77oGQ5DbBess5zBSIACRcUZiblpBZvczqtg49xfck
         OKkCvvXM9VQfwf9ZT/RGjLy8/Yt957vg7t4WSo7YhDEADv0m/+NsfynzQcrWg1ft4WPZ
         W0zQ==
X-Gm-Message-State: AO0yUKUn/D2gqhY7ajswzekQHWZPGoTxQ7bhPwOLyHkxRstSoqKV5ijE
        citrmeplM/+zt4wnnpobsgs=
X-Google-Smtp-Source: AK7set8E+XSGSa2CFpzjmVNdJGqPvK4JPcy5i1Xt68mjbNUB8UxMiBGww5GdmStnIKmwkCL2gZQ7KA==
X-Received: by 2002:a05:600c:5104:b0:3ea:dbdd:66df with SMTP id o4-20020a05600c510400b003eadbdd66dfmr2458024wms.2.1678449177369;
        Fri, 10 Mar 2023 03:52:57 -0800 (PST)
Received: from suse.localnet (host-95-235-93-126.retail.telecomitalia.it. [95.235.93.126])
        by smtp.gmail.com with ESMTPSA id r26-20020a05600c2f1a00b003e11f280b8bsm2801519wmn.44.2023.03.10.03.52.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 03:52:56 -0800 (PST)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Khadija Kamran <kamrankhadijadj@gmail.com>
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        paskripkin@gmail.com, gregkh@linuxfoundation.org,
        outreachy@lists.linux.dev
Subject: Re: [PATCH] Staging: r8188eu: Fixed block comment
Date:   Fri, 10 Mar 2023 12:52:55 +0100
Message-ID: <10238267.qUNvkh4Gvn@suse>
In-Reply-To: <Y+8p7Hyaf4LhO/Sw@khadija-virtual-machine>
References: <Y+8p7Hyaf4LhO/Sw@khadija-virtual-machine>
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

On venerd=EC 17 febbraio 2023 08:17:00 CET Khadija Kamran wrote:
> Fixed block comment by adding '*' in each line. The Check message was
> shown by using checkpatch.pl script.
>=20
> Signed-off-by: Khadija Kamran <kamrankhadijadj@gmail.com>
> ---
>  drivers/staging/r8188eu/core/rtw_br_ext.c | 19 ++++++++++---------
>  1 file changed, 10 insertions(+), 9 deletions(-)
>=20

Hi Khadija,

As Greg said this driver is not here any longer. This makes me think that y=
ou=20
forgot at least two things...

1) Please pull and rebase the staging tree every day while working on patch=
es=20
during this period of the Outreachy project. If you had done so, you would=
=20
have noticed that your patch cannot any more be applied.

2) I saw this patch by pure luck because you forgot to Cc the Outreachy lis=
t.=20
Therefore, please don't ever forget to Cc that list. Most mentors don't=20
subscribe the linux-staging list.

Thanks,

=46abio

P.S.: Please use an imperative tone, both in the subject and in the commit=
=20
message. For example this patch could have been written the following way:

staging: axis-fifo: Add "*" to multi-line comment

Add asterisks to each line of a multi-line comment to conform to the Linux=
=20
development guidelines. Warning reported by checkpatch.pl.

Signed-off-by: [...]




