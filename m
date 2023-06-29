Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7796742274
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 10:43:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232634AbjF2Ims convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 29 Jun 2023 04:42:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230255AbjF2IlQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 04:41:16 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E5DD4202
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 01:38:12 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-86-mCyGUWdvOzqOD0rili5ykg-1; Thu, 29 Jun 2023 09:38:10 +0100
X-MC-Unique: mCyGUWdvOzqOD0rili5ykg-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Thu, 29 Jun
 2023 09:38:09 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Thu, 29 Jun 2023 09:38:09 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Sameer Pujar' <spujar@nvidia.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "perex@perex.cz" <perex@perex.cz>,
        "tiwai@suse.com" <tiwai@suse.com>
CC:     "jonathanh@nvidia.com" <jonathanh@nvidia.com>,
        "mkumard@nvidia.com" <mkumard@nvidia.com>,
        "sheetal@nvidia.com" <sheetal@nvidia.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Oder Chiou <oder_chiou@realtek.com>
Subject: RE: [PATCH v2 3/5] ASoC: rt5640: Fix sleep in atomic context
Thread-Topic: [PATCH v2 3/5] ASoC: rt5640: Fix sleep in atomic context
Thread-Index: AQHZqkh8hA8hSCOxA0KruUap8XcLma+hdFow
Date:   Thu, 29 Jun 2023 08:38:09 +0000
Message-ID: <bae9f041867e4625ad293d284566bb4f@AcuMS.aculab.com>
References: <1688015537-31682-1-git-send-email-spujar@nvidia.com>
 <1688015537-31682-4-git-send-email-spujar@nvidia.com>
In-Reply-To: <1688015537-31682-4-git-send-email-spujar@nvidia.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,PDS_BAD_THREAD_QP_64,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sameer Pujar
> Sent: 29 June 2023 06:12
> 
> Following prints are observed while testing audio on Jetson AGX Orin which
> has onboard RT5640 audio codec:
> 
>   BUG: sleeping function called from invalid context at kernel/workqueue.c:3027
>   in_atomic(): 1, irqs_disabled(): 128, non_block: 0, pid: 0, name: swapper/0
>   preempt_count: 10001, expected: 0
>   RCU nest depth: 0, expected: 0
>   ------------[ cut here ]------------
>   WARNING: CPU: 0 PID: 0 at kernel/irq/handle.c:159 __handle_irq_event_percpu+0x1e0/0x270
>   ---[ end trace ad1c64905aac14a6 ]-
> 
> The IRQ handler rt5640_irq() runs in interrupt context and can sleep
> during cancel_delayed_work_sync().
> 
> Fix this by running IRQ handler, rt5640_irq(), in thread context.
> Hence replace request_irq() calls with devm_request_threaded_irq().

My 'gut feel' is that this will just move the problem elsewhere.

If the ISR is responsible for adding audio buffers (etc) then it is
also not unlikely that the scheduling delays in running a threaded ISR
will cause audio glitches if the system is busy.

> 
> Fixes: 051dade34695 ("ASoC: rt5640: Fix the wrong state of JD1 and JD2")
> Cc: stable@vger.kernel.org
> Cc: Oder Chiou <oder_chiou@realtek.com>
> Signed-off-by: Sameer Pujar <spujar@nvidia.com>
> ---
>  sound/soc/codecs/rt5640.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/sound/soc/codecs/rt5640.c b/sound/soc/codecs/rt5640.c
> index 0ed4fa2..e24ed75 100644
> --- a/sound/soc/codecs/rt5640.c
> +++ b/sound/soc/codecs/rt5640.c
> @@ -2567,9 +2567,10 @@ static void rt5640_enable_jack_detect(struct snd_soc_component *component,
>  	if (jack_data && jack_data->use_platform_clock)
>  		rt5640->use_platform_clock = jack_data->use_platform_clock;
> 
> -	ret = request_irq(rt5640->irq, rt5640_irq,
> -			  IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
> -			  "rt5640", rt5640);
> +	ret = devm_request_threaded_irq(component->dev, rt5640->irq,
> +					NULL, rt5640_irq,
> +					IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
> +					"rt5640", rt5640);

You need a comment saying this must be a threaded IRQ because the ISR
calls cancel_delayed_work_sync().

	David

>  	if (ret) {
>  		dev_warn(component->dev, "Failed to reguest IRQ %d: %d\n", rt5640->irq, ret);
>  		rt5640_disable_jack_detect(component);
> @@ -2622,8 +2623,9 @@ static void rt5640_enable_hda_jack_detect(
> 
>  	rt5640->jack = jack;
> 
> -	ret = request_irq(rt5640->irq, rt5640_irq,
> -			  IRQF_TRIGGER_RISING | IRQF_ONESHOT, "rt5640", rt5640);
> +	ret = devm_request_threaded_irq(component->dev, rt5640->irq,
> +					NULL, rt5640_irq, IRQF_TRIGGER_RISING | IRQF_ONESHOT,
> +					"rt5640", rt5640);
>  	if (ret) {
>  		dev_warn(component->dev, "Failed to reguest IRQ %d: %d\n", rt5640->irq, ret);
>  		rt5640->irq = -ENXIO;
> --
> 2.7.4

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

