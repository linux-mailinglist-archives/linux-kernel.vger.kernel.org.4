Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A90EF6CDCBC
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 16:36:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230242AbjC2Og3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 10:36:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230189AbjC2OgM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 10:36:12 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC8E65B9F;
        Wed, 29 Mar 2023 07:31:57 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id l37so9072836wms.2;
        Wed, 29 Mar 2023 07:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680100257;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zr4X6wyMqM3FaFSlbgRQtbKkzLVZE5bqrrVko5Rwa5c=;
        b=KJT9KupMr4SgFRMB1R5Wh5QGDCXLeuHnE241gzx/vFvAdIk7ppT8Z1/BqjTEoZZmS3
         d0UPUn97r+cPBj80NygNM4gSJapGqb40vqiqV/fTx2iV5ugnPU5vY/faJZvPrGkmrZDS
         c2QVM/zfy5rAU1MQyTTHQMC5gtuuv2cEYSGLeg0aSDPPb28Jpac1WFoATQgNDbUxtRrb
         1Dsv+flWW5VqXfHEWEZUqj6H47QO7/vRO2p84ZitrI76Bei2hzLJmi6IV3oYcfXh8/Fa
         9M5LMdLzkNT5HOijXWkxgFHo3Iu/3GpRKKCJDTSMrLF8MwLTucF0eMahk8cAZxVEgDt8
         xb+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680100257;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zr4X6wyMqM3FaFSlbgRQtbKkzLVZE5bqrrVko5Rwa5c=;
        b=6tho7DpQAWs7WQD5ArcuHIXzMnHXGb3w7O16rhLrIv9Ot6NYClo+LVYXY1RZYPv9+n
         gujm9qlnnl5BPOLQm4qpTs3ByMRnEtBL4rjlfi3vm43NyLmb+jEqbsbrwXX7kb46LRV5
         2D7BKOpWlYnASRp7k54bF5YsuE1KGbwZRxi7LrT1HRNVRI5OV8MU0LrY1RqNZKCLlGh6
         z53cWD+flmPXSlZanKvFqZ8Pb86Yefr5CcAnl7vNsxli37NSzaIoPdaXXPRtTasETmeU
         xKw9REz7iHVqGnQ3DCrKa4C0wLJKYD9xO5ODsblua5HxyKZQ5dfgUXhAlpwR8VtKQogT
         z39w==
X-Gm-Message-State: AO0yUKUG38XmZLDKF4LzDHoIR0bP/ATCxcT6y3IYVS/bm1nSx5WYaySp
        YU/B67lJ4ZQuNVG8Yac2ikw=
X-Google-Smtp-Source: AK7set8CpQuhy+NQhip4nyXlgZTJ/O7V2iF8vnlal0JCs0FmkIvo0kzZyO6if4P9x6msOc2ZGFi4mg==
X-Received: by 2002:a05:600c:2043:b0:3ee:4678:dde with SMTP id p3-20020a05600c204300b003ee46780ddemr15533132wmg.27.1680100256938;
        Wed, 29 Mar 2023 07:30:56 -0700 (PDT)
Received: from suse.localnet (host-95-248-13-140.retail.telecomitalia.it. [95.248.13.140])
        by smtp.gmail.com with ESMTPSA id v8-20020a05600c470800b003ef71d7d64asm2670516wmo.6.2023.03.29.07.30.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 07:30:56 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Kloudifold <cloudifold.3125@gmail.com>
Cc:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Teddy Wang <teddy.wang@siliconmotion.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, outreachy@lists.linux.dev,
        linux-staging@lists.linux.dev, alison.schofield@intel.com
Subject: Re: [PATCH v6] staging: sm750: Rename sm750_hw_cursor_* functions to
 snake_case
Date:   Wed, 29 Mar 2023 16:30:54 +0200
Message-ID: <1854722.CQOukoFCf9@suse>
In-Reply-To: <ZCQeyWW3+d7+qT+b@CloudiRingWorld>
References: <ZCQeyWW3+d7+qT+b@CloudiRingWorld>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On mercoled=EC 29 marzo 2023 13:27:04 CEST Kloudifold wrote:
> sm750 driver has sm750_hw_cursor_* functions, which are named in
> camelcase. Rename them to snake case to follow the function naming
> convention.
>=20
> - sm750_hw_cursor_setSize  =3D> sm750_hw_cursor_set_size
> - sm750_hw_cursor_setPos   =3D> sm750_hw_cursor_set_pos
> - sm750_hw_cursor_setColor =3D> sm750_hw_cursor_set_color
> - sm750_hw_cursor_setData  =3D> sm750_hw_cursor_set_data
> - sm750_hw_cursor_setData2 =3D> sm750_hw_cursor_set_data2
>=20
> Reported-by: kernel test robot <lkp@intel.com>
> Link:
> https://lore.kernel.org/oe-kbuild-all/202303110849.X24WnHnM-lkp@intel.com/

Delete the last two lines.

As Greg made you notice, it was not the Kernel Test Robot that had reported=
=20
you an issue for which you decided to make a patch to fix it.

The reason you made this patch is because you know that the Linux kernel st=
yle=20
guide wants developers to avoid camel-case symbols.

Before your "Signed-off-by" tag, you should only credit those tools and/or=
=20
services (checkpatch.pl, Coccinelle, Smatch, Syzkaller/Syzbot, GCC, Clang, =
and=20
so on) that had noticed that Linux has a problem that predates the first=20
version of your patch and that your first version has the purpose to fix th=
at=20
problem.

You made this patch because _checkpatch_ had reported issues with camel-cas=
e=20
improper use, so you decided to convert some names to snake-case. You are=20
invited to credit only _checkpatch_ for you patch ("Reported by=20
checkpatch.pl.").

That credit is part of the commit message so, when you credit that tool, pu=
t a=20
blank line after the credit and before the "Signed-off-by" tag.=20

> Signed-off-by: Kloudifold <cloudifold.3125@gmail.com>
>=20

Instead, you should delete this blank line after your sign.

> ---
> Changes in v6:
> - Include missed recipients in v5, no functional change to the code
>=20
> Changes in v5:
> - Include missed recipients in v4, no functional change to the code
>=20
> Changes in v4:
> - Update the commit msg (Deepak)
> - Use tabs replace 8 spaces
>=20
> This v4 patch was prompted by 2 errors, 2 warnings and 1 checks reported
> by the scripts/checkpatch.pl, which detected the style problem.
>=20
> Changes in v3:
> - Add this changelog (Philipp)
> - Move lkp tags and link to the correct location in commit log (Alison)
> - Update the commit msg (Philip)
> - Update the commit log (Bagas, Julia)
>=20
> Changes in v2:
> - Use new function names in call sites (LKP)

This is the place to credit the Kernel Test Robot for noticing that you mad=
e=20
mistakes with v1 and that v2 is for fixing them.

Therefore, give credit here to the Robot:

Reported-by: kernel test robot <lkp@intel.com>
> Link:
> https://lore.kernel.org/oe-kbuild-all/202303110849.X24WnHnM-lkp@intel.com/

Thanks,

=46abio

P.S.: Someone suggested to drop the "sm750_" prefix. I don't think you shou=
ld=20
do anything like this because I don't see "static" functions prefixed by=20
"sm750_" in your patch. However, later you may check if they can be "static=
"=20
and, if so, drop the prefix and make them "static" (in a follow up patch). =
=20



