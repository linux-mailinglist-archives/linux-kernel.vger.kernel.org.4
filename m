Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0D237465C1
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 00:32:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230208AbjGCWcI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 18:32:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbjGCWcH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 18:32:07 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1267490;
        Mon,  3 Jul 2023 15:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=eZ6Gzs4f1s1uX6XyZuNRQFk10FJphKL4cNWsqk5e5i4=; b=38OfsZwUZeQ0jx8BECK9hDWayf
        REHh1SSh+ICcToamGGKVHk8kR8Roj/SAu1ViWp58tJPR5MkVuX5ARqiyIlcAEm6Q/XTT+DviJDsW7
        mjc/Bh4/Eo1R6eFWgU76undjmyTpOcBj7MdcfDxx9rX51pOpNhijnDazeSKvbROTSKR3ydram/v5x
        jEInUf1umcXy91Ax+HcRhgea0ANDi/fybamVptP/4h/CzPL90r2erijSebOFCttN9MqIuWFOzPr2W
        GUymJC8A8oVXtJVTjaDMh3lOHPjNUs7uEk+ZIHUkQ+B5wRkc1y8snwlMrpwtSnDWNldEn5ONqA4TG
        FKHJS6XA==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qGS5F-00BZ1F-2a;
        Mon, 03 Jul 2023 22:31:49 +0000
Message-ID: <acb675e6-0a41-8965-f1b9-da403d76b7ee@infradead.org>
Date:   Mon, 3 Jul 2023 15:31:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 1/4] lib/math: Move dvb_math.c into lib/math/int_log.c
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Mark Brown <broonie@kernel.org>,
        David Lin <CTLIN0@nuvoton.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        alsa-devel@alsa-project.org
Cc:     Jonathan Corbet <corbet@lwn.net>, Antti Palosaari <crope@iki.fi>,
        Sergey Kozlov <serjk@netup.ru>, Abylay Ospan <aospan@netup.ru>,
        Yasunari Takiguchi <Yasunari.Takiguchi@sony.com>,
        Michael Krufky <mkrufky@linuxtv.org>,
        Matthias Schwarzott <zzam@gentoo.org>,
        Akihiro Tsukada <tskd08@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
References: <20230703135211.87416-1-andriy.shevchenko@linux.intel.com>
 <20230703135211.87416-2-andriy.shevchenko@linux.intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230703135211.87416-2-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/3/23 06:52, Andy Shevchenko wrote:
> Some existing and new users may benefit from the intlog2() and
> intlog10() APIs, make them wide available.
> 
> Reviewed-by: Mauro Carvalho Chehab <mchehab@kernel.org>
> Acked-by: Mauro Carvalho Chehab <mchehab@kernel.org>
> Link: https://lore.kernel.org/r/20230619172019.21457-2-andriy.shevchenko@linux.intel.com
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  Documentation/core-api/kernel-api.rst                 |  7 +++++--
>  Documentation/driver-api/media/dtv-common.rst         |  9 ---------
>  drivers/media/dvb-core/Makefile                       |  2 +-
>  drivers/media/dvb-frontends/af9013_priv.h             |  2 +-
>  drivers/media/dvb-frontends/af9033_priv.h             |  2 +-
>  drivers/media/dvb-frontends/cxd2820r_priv.h           |  2 +-
>  drivers/media/dvb-frontends/cxd2841er.c               |  2 +-
>  .../dvb-frontends/cxd2880/cxd2880_tnrdmd_dvbt2_mon.c  |  2 +-
>  .../dvb-frontends/cxd2880/cxd2880_tnrdmd_dvbt_mon.c   |  2 +-
>  drivers/media/dvb-frontends/cxd2880/cxd2880_top.c     |  2 +-
>  drivers/media/dvb-frontends/dib7000p.c                |  2 +-
>  drivers/media/dvb-frontends/dib8000.c                 |  2 +-
>  drivers/media/dvb-frontends/dib9000.c                 |  2 +-
>  drivers/media/dvb-frontends/drxk_hard.c               |  2 +-
>  drivers/media/dvb-frontends/lgdt3305.c                |  2 +-
>  drivers/media/dvb-frontends/lgdt3306a.c               |  2 +-
>  drivers/media/dvb-frontends/lgdt330x.c                |  2 +-
>  drivers/media/dvb-frontends/m88ds3103_priv.h          |  2 +-
>  drivers/media/dvb-frontends/mn88443x.c                |  2 +-
>  drivers/media/dvb-frontends/mn88472_priv.h            |  2 +-
>  drivers/media/dvb-frontends/mn88473_priv.h            |  2 +-
>  drivers/media/dvb-frontends/or51132.c                 |  2 +-
>  drivers/media/dvb-frontends/or51211.c                 |  2 +-
>  drivers/media/dvb-frontends/rtl2830_priv.h            |  2 +-
>  drivers/media/dvb-frontends/rtl2832_priv.h            |  2 +-
>  drivers/media/dvb-frontends/si2165.c                  |  2 +-
>  drivers/media/dvb-frontends/stv0367.c                 |  2 +-
>  drivers/media/dvb-frontends/tc90522.c                 |  2 +-
>  drivers/media/dvb-frontends/tda10048.c                |  2 +-
>  include/{media/dvb_math.h => linux/int_log.h}         |  7 +++----
>  lib/math/Makefile                                     |  2 +-
>  .../media/dvb-core/dvb_math.c => lib/math/int_log.c   | 11 ++++++-----
>  32 files changed, 42 insertions(+), 48 deletions(-)
>  rename include/{media/dvb_math.h => linux/int_log.h} (92%)
>  rename drivers/media/dvb-core/dvb_math.c => lib/math/int_log.c (95%)

-- 
~Randy
