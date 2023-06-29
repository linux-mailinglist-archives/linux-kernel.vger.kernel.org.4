Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96BF47423E9
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 12:22:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231281AbjF2KWh convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 29 Jun 2023 06:22:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230119AbjF2KWe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 06:22:34 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1602C131
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 03:22:31 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-156-pPX-EROVOembC7vWITh1PA-1; Thu, 29 Jun 2023 11:22:15 +0100
X-MC-Unique: pPX-EROVOembC7vWITh1PA-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Thu, 29 Jun
 2023 11:21:06 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Thu, 29 Jun 2023 11:21:06 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Mark Brown' <broonie@kernel.org>
CC:     'Sameer Pujar' <spujar@nvidia.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "perex@perex.cz" <perex@perex.cz>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "jonathanh@nvidia.com" <jonathanh@nvidia.com>,
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
Thread-Index: AQHZqkh8hA8hSCOxA0KruUap8XcLma+hdFowgAAKboCAABMH0A==
Date:   Thu, 29 Jun 2023 10:21:06 +0000
Message-ID: <953c899d04e543f681e44daad4ec2ff7@AcuMS.aculab.com>
References: <1688015537-31682-1-git-send-email-spujar@nvidia.com>
 <1688015537-31682-4-git-send-email-spujar@nvidia.com>
 <bae9f041867e4625ad293d284566bb4f@AcuMS.aculab.com>
 <550e5c8f-0bfb-4ffc-9a43-1ecb153c6a02@sirena.org.uk>
In-Reply-To: <550e5c8f-0bfb-4ffc-9a43-1ecb153c6a02@sirena.org.uk>
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

From: Mark Brown
> Sent: 29 June 2023 11:11
> 
> On Thu, Jun 29, 2023 at 08:38:09AM +0000, David Laight wrote:
> > From: Sameer Pujar
> 
> > > Following prints are observed while testing audio on Jetson AGX Orin which
> > > has onboard RT5640 audio codec:
> > >
> > >   BUG: sleeping function called from invalid context at kernel/workqueue.c:3027
> > >   in_atomic(): 1, irqs_disabled(): 128, non_block: 0, pid: 0, name: swapper/0
> 
> > My 'gut feel' is that this will just move the problem elsewhere.
> 
> > If the ISR is responsible for adding audio buffers (etc) then it is
> > also not unlikely that the scheduling delays in running a threaded ISR
> > will cause audio glitches if the system is busy.
> 
> What makes you think this is anything to do with audio glitches?  The
> bug is literally what is described, it is not valid to sleep in atomic
> contexts and if we ever actually try things are likely to go badly.

What I mean is that deferring the ISR to process context
is likely to generate audio glitches on a busy system.

I realise that sleeping in an ISR goes badly wrong.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

