Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00C8163E9D5
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 07:21:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbiLAGVe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 01:21:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbiLAGVb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 01:21:31 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC08FAB001;
        Wed, 30 Nov 2022 22:21:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5874061E8F;
        Thu,  1 Dec 2022 06:21:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC4F8C433D6;
        Thu,  1 Dec 2022 06:21:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669875689;
        bh=1TShYY6JkDucSJo1cjYSsWtnGpEz8gTWzbxvY/gsAVc=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=Nmr6EadOg/rHV11uZ4icZPKLjWkG9u5exEWuXjcet49ziPi6lKPVIKjGUOYp6CcWx
         Y12Z/NwkhsvhLIEHSbtm15Y2RB65kw6eZsRUaz2Phq9LxaG7FxUh1g9l8+F7qBS+HD
         CGeOtlLQauyAR3MBwsA3p8GfaCD9Z9dbk/yh4BUovT3UVpuVYIqfDFshlSc0Qsgaat
         xX1b8CE466ljiqmJHjjcrMiKQTkwBAH9gx4pQ3hDXQLOp5daBTG65U9wqGD+K0uJkf
         MbDMzGCSBHmedPkE/bR2v0ikovVSHk5K7DiOGBkIqQXcHADL1iSgVygFDQE1SThq5o
         Rv80Q+9vzjyTA==
Date:   Thu, 01 Dec 2022 06:21:25 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Walker Chen <walker.chen@starfivetech.com>,
        Conor Dooley <conor.dooley@microchip.com>
CC:     linux-riscv@lists.infradead.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 3/4] soc: starfive: Add StarFive JH71XX pmu driver
User-Agent: K-9 Mail for Android
In-Reply-To: <e0cf51d3-ba58-36a7-5c70-1d070e5fb12a@starfivetech.com>
References: <20221118133216.17037-1-walker.chen@starfivetech.com> <20221118133216.17037-4-walker.chen@starfivetech.com> <Y3giSQ0YccyY2tVk@spud> <95b05ac3-31a9-50dc-8eeb-eb3a9f883a6b@starfivetech.com> <Y4CkVnmdEhCsyckH@wendy> <e0cf51d3-ba58-36a7-5c70-1d070e5fb12a@starfivetech.com>
Message-ID: <42D09618-DB39-4A8B-9327-4C6CC9DA2000@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Walker,

Apologies for my formatting here=2E=20

On 1 December 2022 03:56:27 GMT, Walker Chen <walker=2Echen@starfivetech=
=2Ecom> wrote:
>On 2022/11/25 19:17, Conor Dooley wrote:
>> On Fri, Nov 25, 2022 at 06:04:59PM +0800, Walker Chen wrote:
>>> On 2022/11/19 8:24, Conor Dooley wrote:
>>> > On Fri, Nov 18, 2022 at 09:32:15PM +0800, Walker Chen wrote:
>>=20
>>> >> +void starfive_pmu_hw_event_turn_off(u32 mask)
>>> >> +{
>>> >> +	pmu_writel(mask, HW_EVENT_TURN_OFF_MASK);
>>> >> +}
>>> >> +EXPORT_SYMBOL(starfive_pmu_hw_event_turn_off);
>>> >=20
>>> > Where are the users for these exports? Also, should they be exported=
 as
>>> > GPL?
>>> >=20
>>> > Either way, what is the point of the extra layer of abstraction here
>>> > around the writel()?
>>>=20
>>> The two export functions are only prepared for GPU module=2E But accor=
dint to
>>>  the latest information, it seems that there is no open source plan fo=
r GPU=2E=20
>>> So the two functions will be drop in next version of patch=2E
>>=20
>> That's a shame!
>
>Need to comply with certain commercial terms=2E
>
>>=20
>>> >> +static int starfive_pmu_get_state(struct starfive_power_dev *pmd, =
bool *is_on)
>>> >> +{
>>> >> +	struct starfive_pmu *pmu =3D pmd->power;
>>> >> +
>>> >> +	if (!pmd->mask) {
>>> >> +		*is_on =3D false;
>>> >> +		return -EINVAL;
>>> >> +	}
>>> >> +
>>> >> +	*is_on =3D __raw_readl(pmu->base + CURR_POWER_MODE) & pmd->mask;
>>> >=20
>>> > Is there a specific reason that you are using the __raw variants her=
e
>>> > (and elsewhere) in the driver?
>>>=20
>>> Will use unified function '__raw_readl' and '__raw_writel'
>>=20
>> No no, I want to know *why* you are using the __raw accessors here=2E M=
y
>> understanding was that __raw variants are unbarriered & unordered with
>> respect to other io accesses=2E
>>=20
>> I do notice that the bcm driver you mentioned uses the __raw variants,
>> but only __raw variants - whereas you use readl() which is ordered and
>> barriered & __raw_readl()=2E
>>=20
>> Is there a reason why you would not use readl() or readl_relaxed()?
>
>Your question led me to deeply understand the usage of these io accessors=
=2E
>__raw_readl / __raw_writel denotes native byte order, no memory barrier=
=2E
>readl / writel do guarantee the byte order with barrier, ensure that prev=
ious writes are done=2E
>Seem that non-raw accessors are more safe=2E

Yeah, if there's no good reason to use these "raw"  versions then please u=
se readl/readl_relaxed=2E


>> No worries, looking forward to getting my board :)
>>=20
>Have you purchased a VisionFive 2 board online? =20

I have :)
