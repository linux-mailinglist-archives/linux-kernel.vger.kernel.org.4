Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE13574555C
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 08:18:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230043AbjGCGS3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 02:18:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbjGCGS0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 02:18:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D76B2BF;
        Sun,  2 Jul 2023 23:18:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7485B60DC6;
        Mon,  3 Jul 2023 06:18:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36CFFC433C8;
        Mon,  3 Jul 2023 06:18:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688365104;
        bh=b02O7hMAe/0cdSzPP3WCdlJ3T6kG6Hi5gr453ff6ODI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=AaWAZ0MzR5WlM8LsDfCGcJYsVnapu6kw3CisOBlzAeBV65fsgiHj4cTCvUVhiPIXg
         OWZalDz2U4a5HKVY1ries+snvEPAN5HyGHqmrzszj1Tsai1ox2Wns/gdYr+nnOXCkN
         hSoOzk1I0NMqkaFaP9CvULBEZ+pw4Cnt1hmw6Yctc6sxyRegJ0XgDy3Q/2nvH7qLUe
         lXK15gu9WWAliwPVRDZWqp8FG1w7v7J73PeQpU1dmRKdTp1gtpuqigtK6c2oa6xSyg
         GHkI4K0Bsl8GHo4vYtDDdrF+8+xgRj04wNrn+uNUySINBhEzFIfI2OtIm3OrbcFGHZ
         cJBJvLinemqQQ==
Date:   Mon, 3 Jul 2023 08:18:16 +0200
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Uwe =?UTF-8?B?S2xlaW5lLUs=?= =?UTF-8?B?w7ZuaWc=?= 
        <u.kleine-koenig@pengutronix.de>, Mark Brown <broonie@kernel.org>,
        David Lin <CTLIN0@nuvoton.com>, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        Antti Palosaari <crope@iki.fi>, Sergey Kozlov <serjk@netup.ru>,
        Abylay Ospan <aospan@netup.ru>,
        Yasunari Takiguchi <Yasunari.Takiguchi@sony.com>,
        Michael Krufky <mkrufky@linuxtv.org>,
        Matthias Schwarzott <zzam@gentoo.org>,
        Akihiro Tsukada <tskd08@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Subject: Re: [PATCH v1 0/4] ASoC: remove copy of intlog10()
Message-ID: <20230703081816.37028ab7@sal.lan>
In-Reply-To: <20230619172019.21457-1-andriy.shevchenko@linux.intel.com>
References: <20230619172019.21457-1-andriy.shevchenko@linux.intel.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, 19 Jun 2023 20:20:15 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> escreveu:

> The first three patches moves intlog10() to be available in entire
> kernel. The last one removes copy of it in one driver. Besides already
> good Lines of Code (LoC) statistics the upcoming users, if any, can
> utilize the exported functions.
> 
> The series can be routed either via ASoC tree or media tree.
> 
> Note, int_log.h is separated from math.h due to licensing.
> I dunno if we can mix two in a single header file. In any
> case we may do it later on.
> 
> Andy Shevchenko (4):
>   lib/math: Move dvb_math.c into lib/math/int_log.c
>   lib/math/int_log: Use ARRAY_SIZE(logtable) where makes sense
>   lib/math/int_log: Replace LGPL-2.1-or-later boilerplate with SPDX
>     identifier
>   ASoC: nau8825: Replace copied'n'pasted intlog10()

It probably makes sense to apply it at ASoC tree, as the relevant
change is there.

I have just one small nit on patch 1/4, which should be trivial to
solve. Once done, feel free to merge it with  my ack:

Acked-by: Mauro Carvalho Chehab <mchehab@kernel.org>

> 
>  Documentation/driver-api/media/dtv-common.rst |  2 +-
>  drivers/media/dvb-core/Makefile               |  2 +-
>  drivers/media/dvb-frontends/af9013_priv.h     |  2 +-
>  drivers/media/dvb-frontends/af9033_priv.h     |  2 +-
>  drivers/media/dvb-frontends/cxd2820r_priv.h   |  2 +-
>  drivers/media/dvb-frontends/cxd2841er.c       |  2 +-
>  .../cxd2880/cxd2880_tnrdmd_dvbt2_mon.c        |  2 +-
>  .../cxd2880/cxd2880_tnrdmd_dvbt_mon.c         |  2 +-
>  .../media/dvb-frontends/cxd2880/cxd2880_top.c |  2 +-
>  drivers/media/dvb-frontends/dib7000p.c        |  2 +-
>  drivers/media/dvb-frontends/dib8000.c         |  2 +-
>  drivers/media/dvb-frontends/dib9000.c         |  2 +-
>  drivers/media/dvb-frontends/drxk_hard.c       |  2 +-
>  drivers/media/dvb-frontends/lgdt3305.c        |  2 +-
>  drivers/media/dvb-frontends/lgdt3306a.c       |  2 +-
>  drivers/media/dvb-frontends/lgdt330x.c        |  2 +-
>  drivers/media/dvb-frontends/m88ds3103_priv.h  |  2 +-
>  drivers/media/dvb-frontends/mn88443x.c        |  2 +-
>  drivers/media/dvb-frontends/mn88472_priv.h    |  2 +-
>  drivers/media/dvb-frontends/mn88473_priv.h    |  2 +-
>  drivers/media/dvb-frontends/or51132.c         |  2 +-
>  drivers/media/dvb-frontends/or51211.c         |  2 +-
>  drivers/media/dvb-frontends/rtl2830_priv.h    |  2 +-
>  drivers/media/dvb-frontends/rtl2832_priv.h    |  2 +-
>  drivers/media/dvb-frontends/si2165.c          |  2 +-
>  drivers/media/dvb-frontends/stv0367.c         |  2 +-
>  drivers/media/dvb-frontends/tc90522.c         |  2 +-
>  drivers/media/dvb-frontends/tda10048.c        |  2 +-
>  include/{media/dvb_math.h => linux/int_log.h} | 18 +---
>  lib/math/Makefile                             |  2 +-
>  .../dvb-core/dvb_math.c => lib/math/int_log.c | 26 ++----
>  sound/soc/codecs/nau8825.c                    | 93 +------------------
>  32 files changed, 45 insertions(+), 150 deletions(-)
>  rename include/{media/dvb_math.h => linux/int_log.h} (63%)
>  rename drivers/media/dvb-core/dvb_math.c => lib/math/int_log.c (84%)
> 
