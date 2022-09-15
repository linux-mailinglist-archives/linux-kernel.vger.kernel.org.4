Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9EBF5B9709
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 11:09:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbiIOJJF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 05:09:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbiIOJIe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 05:08:34 -0400
Received: from hutie.ust.cz (unknown [IPv6:2a03:3b40:fe:f0::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70CDC9675A;
        Thu, 15 Sep 2022 02:08:27 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cutebit.org; s=mail;
        t=1663232894; bh=5T7fANvbR8aOkxZKsm17t90nIE/N2i6lzPnLtMrGZng=;
        h=Subject:From:In-Reply-To:Date:Cc:References:To;
        b=Pcpl22EllOQGrrVzCCwI7v343ZqXYueCFtqmX2hj1JqswEZRjm7P/BAmKO20CTLCV
         kABvmE3rEUvznJVv/IG8M68id8aQqks6gQY7gk23+GQmdoAloa7/L73ZYsJtxSLkeG
         CKr1oQIv6VQW5MEikA70J8azkXsbCn/Ngkpdyz/M=
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.80.82.1.1\))
Subject: Re: [PATCH 04/10] ASoC: cs42l42: Split probe() and remove() into
 stages
From:   =?utf-8?Q?Martin_Povi=C5=A1er?= <povik+lin@cutebit.org>
In-Reply-To: <20220909135334.98220-5-povik+lin@cutebit.org>
Date:   Thu, 15 Sep 2022 11:08:11 +0200
Cc:     Charles Keepax <ckeepax@opensource.cirrus.com>,
        ChiYuan Huang <cy_huang@richtek.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Matt Flax <flatmax@flatmax.com>,
        - <patches@opensource.cirrus.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        asahi@lists.linux.dev
Content-Transfer-Encoding: quoted-printable
Message-Id: <A40F3F43-2052-4759-BAF0-3EE0EEA270DC@cutebit.org>
References: <20220909135334.98220-1-povik+lin@cutebit.org>
 <20220909135334.98220-5-povik+lin@cutebit.org>
To:     James Schulman <james.schulman@cirrus.com>,
        David Rhodes <david.rhodes@cirrus.com>,
        Lucas Tanure <tanureal@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        =?utf-8?Q?Martin_Povi=C5=A1er?= <povik+lin@cutebit.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_FAIL,T_SPF_HELO_TEMPERROR
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On 9. 9. 2022, at 15:53, Martin Povi=C5=A1er <povik+lin@cutebit.org> =
wrote:
>=20
> To prepare for adding SoundWire the probe must be split into three
> parts:
>=20
> 1) The bus-specific probe
> 2) Common bus-agnostic probe steps
> 3) Initialization of the peripheral registers
>=20
> Step (3) must be separate because on SoundWire devices the probe must
> enable power supplies and release reset so that the peripheral can be
> enumerated by the bus, but it isn't possible to access registers until
> enumeration has completed.
>=20
> The call to devm_snd_soc_register_component() must be done at stage =
(2)
> so that it can EPROBE_DEFER if necessary. In SoundWire systems stage =
(3)
> is not a probe event so a deferral at this stage would not result in
> re-probing dependencies.
>=20
> A new init_done flag indicates that the chip has been identified and
> initialized. This is used to prevent cs42l42_remove(), =
cs42l42_suspend(),
> cs42l42_restore() and cs42l42_irq_thread() from attempting register
> accesses if the chip was not successfully initialized. Although this
> cannot happen on I2C, because the entire probe would fail, it is
> possible on SoundWire if probe succeeds but the cs42l42 is never
> enumerated.
>=20
> Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
> Signed-off-by: Martin Povi=C5=A1er <povik+lin@cutebit.org>

Preparing the next iteration of the series, I noticed that I reset
the authorship of this patch in the course of git manipulations. The
author of this patch is of course Richard, apologies for that. It will
be fixed for v2.

Martin

