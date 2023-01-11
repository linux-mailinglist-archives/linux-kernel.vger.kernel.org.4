Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96026665673
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 09:49:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235849AbjAKIs6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 03:48:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232515AbjAKIsM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 03:48:12 -0500
X-Greylist: delayed 553 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 11 Jan 2023 00:48:09 PST
Received: from hutie.ust.cz (unknown [IPv6:2a03:3b40:fe:f0::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2189DF6A;
        Wed, 11 Jan 2023 00:48:09 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cutebit.org; s=mail;
        t=1673426330; bh=tYUkvP1LL/oKjpBzUtCikUMIK2n3hYe7+3rcbguWTLI=;
        h=Subject:From:In-Reply-To:Date:Cc:References:To;
        b=jB92gv8ARa5tL/VyJEF/uCMfvl1vtEXMwuAMJ+MMC63FMtUet8XBJLP3KY9UXwe7u
         crj5snAwBqlFuMS+Tg4NgOWDTEwk2mJl81z/lGeAJRQ0/GkSWMi0n5JMVz7EkJb2en
         3dIorM7Y2WBeYwV6O3Y6GSej5fdPsDMEIbI5b5Gs=
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
Subject: Re: [PATCH V9 4/5] ASoC: codecs: Aw883xx chip register file, data
 type file and Kconfig Makefile
From:   =?utf-8?Q?Martin_Povi=C5=A1er?= <povik+lin@cutebit.org>
In-Reply-To: <20230111020233.4306-1-wangweidong.a@awinic.com>
Date:   Wed, 11 Jan 2023 09:38:47 +0100
Cc:     lkp@intel.com, 13691752556@139.com,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        Mark Brown <broonie@kernel.org>, cezary.rojewski@intel.com,
        ckeepax@opensource.cirrus.com, daniel.beer@igorinstitute.com,
        devicetree@vger.kernel.org, flatmax@flatmax.com,
        james.schulman@cirrus.com, jonathan.albrieux@gmail.com,
        krzysztof.kozlowski+dt@linaro.org, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org, liweilei@awinic.com,
        llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        perex@perex.cz, pierre-louis.bossart@linux.intel.com,
        rf@opensource.cirrus.com, robh+dt@kernel.org,
        srinivas.kandagatla@linaro.org, steve@sk2.org, tiwai@suse.com,
        yangxiaohua@everest-semi.com, yijiangtao@awinic.com,
        zhaolei@awinic.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <5EA7B038-9B49-4E5D-8209-8689C0D03071@cutebit.org>
References: <202301100233.QuEJ8pyu-lkp@intel.com>
 <20230111020233.4306-1-wangweidong.a@awinic.com>
To:     wangweidong.a@awinic.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_FAIL,SPF_HELO_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On 11. 1. 2023, at 3:02, wangweidong.a@awinic.com wrote:
>=20
> On 09/01/2023 03:00, kernel test robot wrote:

>> All errors (new ones prefixed by >>):
>=20
>>>> ld.lld: error: undefined symbol: crc8_populate_lsb
>>>>> referenced by aw883xx_bin_parse.c:1049 =
(sound/soc/codecs/aw883xx/aw883xx_bin_parse.c:1049)
>>>>>              vmlinux.o:(aw883xx_dev_load_acf_check)
>> --
>>>> ld.lld: error: undefined symbol: crc8
>>>>> referenced by aw883xx_bin_parse.c:963 =
(sound/soc/codecs/aw883xx/aw883xx_bin_parse.c:963)
>>>>>              vmlinux.o:(aw883xx_dev_load_acf_check)
>>>>> referenced by aw883xx_bin_parse.c:1022 =
(sound/soc/codecs/aw883xx/aw883xx_bin_parse.c:1022)
>>>>>              vmlinux.o:(aw883xx_dev_load_acf_check)
>>>>> did you mean: crc4
>>>>> defined in: vmlinux.o
>=20
> This looks like a false positive. crc8_populate_lsb is defined in the =
lib/crc8.c file.
> I also could not reproduce it with GCC.

Hi,

the issue here would be that it=E2=80=99s possible to select your driver =
for compilation without
having selected the CRC8 functions, leading to the linkage error.

You can fix that by adding =E2=80=99select CRC8=E2=80=99 under the =
Kconfig section of your driver, similarly
to how the SND_SOC_SIGMADSP symbol selects CRC32.

Best regards,
Martin

>=20
> Best regards,
> Weidong Wang

