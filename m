Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84C676A6122
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 22:19:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229947AbjB1VTg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 16:19:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbjB1VTe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 16:19:34 -0500
X-Greylist: delayed 579 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 28 Feb 2023 13:19:32 PST
Received: from relay01.th.seeweb.it (relay01.th.seeweb.it [5.144.164.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5EDE233EE
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 13:19:32 -0800 (PST)
Received: from [192.168.2.144] (bband-dyn207.178-40-209.t-com.sk [178.40.209.207])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id F3D6D1F4A4;
        Tue, 28 Feb 2023 22:09:48 +0100 (CET)
Date:   Tue, 28 Feb 2023 22:09:43 +0100
From:   Martin Botka <martin.botka@somainline.org>
Subject: Re: [PATCH v8 3/3] regulator: axp20x: Add support for AXP313a variant
To:     Shengyu Qu <wiagn233@outlook.com>
Cc:     wens@csie.org, martin.botka1@gmail.com,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Jami Kettunen <jamipkettunen@somainline.org>,
        Paul Bouchara <paul.bouchara@somainline.org>,
        Jan Trmal <jtrmal@gmail.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Andre Przywara <andre.przywara@arm.com>,
        Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Message-Id: <7S6TQR.JINNS1OA2FSY2@somainline.org>
In-Reply-To: <TY3P286MB261122217B621C53B6AC1B3198A69@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
References: <20230120184500.1899814-1-martin.botka@somainline.org>
        <20230120184500.1899814-4-martin.botka@somainline.org>
        <CAGb2v649yQVcNn7uv1eKtnEDnb=D4X9yGYB1eOC3zeAe+encFg@mail.gmail.com>
        <TY3P286MB261122217B621C53B6AC1B3198A69@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: geary/43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Shengyu,
On Sat, Feb 18 2023 at 06:08:06 PM +08:00:00, Shengyu Qu 
<wiagn233@outlook.com> wrote:
> Hi Martin,
> 
>> On Sat, Jan 21, 2023 at 2:45 AM Martin Botka
>> <martin.botka@somainline.org> wrote:
>>> The AXP313a is your typical I2C controlled PMIC, although in a 
>>> lighter
>>> fashion compared to the other X-Powers PMICs: it has only three DCDC
>>> rails, three LDOs, and no battery charging support.
>>> 
>>> The AXP313a datasheet does not describe a register to change the 
>>> DCDC
>>> switching frequency, and talks of it being fixed at 3 MHz. The BSP
>>> driver hints at a register being able to change that, but we haven't
>>> verified that, so leave that one out. It can be added later, if 
>>> needed
>>> and/or required.
>> The datasheet released by MangoPi says this isn't configurable. The
>> thing that is configurable is spread-spectrum operation, and mode
>> switching between fixed PWM and hybrid PFM/PWM. So just drop the
>> DCDC frequency stuff and use the default code path.
> 
> You could get full datasheet of AXP313A here:
> 
> https://github.com/YuzukiHD/YuzukiChameleon/blob/master/Datasheet/AXP313A_Datasheet_V1.0_cn.pdf

I do have the datasheet but maybe this one is more up to date somehow. 
Will have to check.
> 
> Btw I'm working on AXP15060 support mostly based on your series.
Lovely to hear. So sorry for the very very late reply. New semester 
began 3 weeks ago and been quite the ride.
Would love to get the series more up to date in the upcoming weeks :) I 
will see what time allows :)
> 
> 
> Best regards,
> 
> Shengyu
Best regards,

Martin


