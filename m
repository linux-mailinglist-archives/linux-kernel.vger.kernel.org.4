Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B4A068FDBB
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 04:09:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231430AbjBIDJ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 22:09:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232579AbjBIDJA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 22:09:00 -0500
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2115.outbound.protection.outlook.com [40.107.215.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B39F39BA3
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 19:05:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GcBd3x7qnRsLEHbOeFy9ZD8s54ePKl535SULrD2iFIssxNrRcQ7uoge7GHLCxVmPOegWawT/Rindg/1iRwmCTlcaQrVHmyO8DBB15XXk6ttuJNbMLF7h4c1QXnEVpv0gXPOVXcLmKKSDWlC0XZwKVyKaYP5R0xw8xCKzck25N9Pu/DhPIKbgoB5ULfC+jNkZoIakTaOqbufR/DXwg+5sOq+Tg3+zKC0hmv6MLGwUdvl391LdY+uec1LsQLkQESDp9twB4nuaIUm5oJf1D8h/QUKmnhrFtYaht3W/7aMI9GIbkyaOVpT3o20b0U/DVlClZaHjyz4rlPRZ5ZFneGXrHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z2sLLYYVsob9tZZbM4NEmsEPunuN2m7PcJkWTsWjQcs=;
 b=AJkH1f1AttPDZOVHu3sZRf7eMtmLzefzVLie94jqTFWfit9b9mH+x5VAQ76aACGk4Pk3QMdm60uSxiOSA613Krci3uale0P2m9nPnC3602m/7RY44wsJKqWXN2b9U5vMtg9ff3MQB4b2LcU2ZJ17Hqt06IbJnif3+Zum2Hh4piFCRJIe34Nq5W3hY8cd/Z3CrgVG08cI6MHDLQofN4SB1zv8KpDULo5kR5pi2pmYdluYNF+iFU6QptBeu/woF/evmyP8BAIF5eRAHuveLIKaQ81j/I57wis5ju47se2WXYOcbwUvdA57mP+sIUB2p4ucWbquci0SxY/SHxdu0FNqEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z2sLLYYVsob9tZZbM4NEmsEPunuN2m7PcJkWTsWjQcs=;
 b=ETWhNDfxX13yFZMaLJXKHq9ysiWQDYGiKbDcBEUTfUX0Uok/QP1ehQSoXYKL/lz8dw5hzNgzSh7Mad6isAFzc3PMd8wUfASsyjzMDd9R6MMSGhHO5kWt/VuMXktuUjosU5+LrgrcMdMjEIsa+k7LZzPMKJYzKRuhI5N3EMKnix8=
Received: from OS3PR01MB6641.jpnprd01.prod.outlook.com (2603:1096:604:10b::11)
 by OS3PR01MB5605.jpnprd01.prod.outlook.com (2603:1096:604:b5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.18; Thu, 9 Feb
 2023 03:05:35 +0000
Received: from OS3PR01MB6641.jpnprd01.prod.outlook.com
 ([fe80::9438:5139:7952:d8b0]) by OS3PR01MB6641.jpnprd01.prod.outlook.com
 ([fe80::9438:5139:7952:d8b0%9]) with mapi id 15.20.6086.019; Thu, 9 Feb 2023
 03:05:35 +0000
From:   David Rau <david.rau.zg@renesas.com>
To:     Guenter Roeck <linux@roeck-us.net>
CC:     Mark Brown <broonie@kernel.org>, "perex@perex.cz" <perex@perex.cz>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "support.opensource@diasemi.com" <support.opensource@diasemi.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] ASoC: da7219: Fix pole orientation detection on OMTP
 headsets when playing music
Thread-Topic: [PATCH] ASoC: da7219: Fix pole orientation detection on OMTP
 headsets when playing music
Thread-Index: AQHY/Wc8EHyTvYawJkGeL+1XJ6BDpa6jYNiAgAIOc/CAANeEgIASDP8AgAAoZACAAGKRgIADYrqAgAAUigCAABqigIAAD+IAgALjMQCAAlK64IAAtqWAgADI8OCAAp6eAIAAjg2Q
Date:   Thu, 9 Feb 2023 03:05:35 +0000
Message-ID: <OS3PR01MB66413DBF9B68A28A14B5F40ECDD99@OS3PR01MB6641.jpnprd01.prod.outlook.com>
References: <38f09c4d-70d1-f65f-6e9b-4ad84eda4059@roeck-us.net>
 <Y9kE1cSUg2CQM5vq@sirena.org.uk> <20230202155101.GB1373010@roeck-us.net>
 <Y9vtIISfmpICi+9u@sirena.org.uk>
 <8f89eeac-b3ef-4137-80df-6cf044873b05@roeck-us.net>
 <Y9wQygzbFyOWl54r@sirena.org.uk> <20230204154222.GA877819@roeck-us.net>
 <OS3PR01MB6641CA1DB8524BCA0F9867D9CDDA9@OS3PR01MB6641.jpnprd01.prod.outlook.com>
 <1ba5cedb-0f0f-69a9-96f0-d93ba060745e@roeck-us.net>
 <OS3PR01MB6641BD5C3B3BA89F82245627CDDB9@OS3PR01MB6641.jpnprd01.prod.outlook.com>
 <20230208180406.GB3065515@roeck-us.net>
In-Reply-To: <20230208180406.GB3065515@roeck-us.net>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB6641:EE_|OS3PR01MB5605:EE_
x-ms-office365-filtering-correlation-id: 95fce3af-8e71-43af-f457-08db0a4a8362
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KX4ulZokIKPcn9r58YHr+12hve//iSJj0UWL/dS8L2QUzPpRk+GYRcdRC5CZZwSheUfBbbvjx5SC06Cqd5PNIOnWLL+DFVN2IlTnx/tnIDxP/ktaRiN8pJhAwabvky0rzQopzgUsnm1cTpZRgymWTG9Lyw0wxCtguG7xyNS0LRit/UdlITQoIuvOoP7wlBWOlKRFBUBfh2rMumuT3PdLivsSMgLHDihrTTHifOEIhCCFDwLXrqnp+ziO4TODwVnLyLtxG0rmKxgKOErWKw4lzxB9WdtM/53Pj2ndfwiYJQSi9HfqHUU5UEEhQ6WeMYN0ozIjlDfWYXe/JS8MUtF8ZB4hWmV9YS5tT2XAP/UKxJxmCs0rLN6qKt7X4M661enwnaprG+ssbM9mr9kCr2Wew1+Y61cvQC4tetfQvfeNlKm6es9xFMji+iz7MD0By6CPbb+c4FLdNU8qHVpCu9GSezNW34QbWopsuTy/dvz60Q2V6NhUMC1Vmap92rZFZGoXCSYdY9GT/yMv5c66nMjgPbBiItg6vT4lq8jmqgvlOzZg8Q+kX29FxG38nXd551zNbfrfgvmeTVmETBDIH4c5NlPOirJnb2CvZMzDuHQOlIdCrzBjgJNe9rK+O1t083SWa/gKaNMVWTR+O0STGNC6oipTzYCxrj5yX54H9agg7t8kr0CQfBeFL42aA/cfvRfSV5gYAc/T2X9mg2XfXdHTaw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB6641.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(366004)(346002)(396003)(376002)(136003)(451199018)(2906002)(52536014)(186003)(86362001)(122000001)(26005)(8936002)(5660300002)(38070700005)(55016003)(71200400001)(7696005)(478600001)(55236004)(53546011)(6506007)(83380400001)(33656002)(38100700002)(9686003)(41300700001)(316002)(66946007)(4326008)(64756008)(66446008)(66476007)(66556008)(6916009)(8676002)(54906003)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2XSq4Mef8zKCCta3Ov+KYr/GAl+PmLbK70d4faJqd3O4072nfdmmpAtYgDut?=
 =?us-ascii?Q?3QLhu90Wya4RPq4fA213zvKvUojXSjXt0sNvbUn37AaN/0GDi+ej4CbFGKIq?=
 =?us-ascii?Q?5y+/1A79j7Hm8OuqEbXjbS7051foipZU5o5obNRsww9YdGCK7qd5tvfBniaW?=
 =?us-ascii?Q?8RzHbSEjq0EIlCoYlRoCUPHQivIpgw7IbGqpySmZNSUNJMV1vVFpuuL8ZA/T?=
 =?us-ascii?Q?j7KyhV5LKxdVsnKnIN0+4bTcOy8X0NnhDQZTI00W1ml8NuIvlVeK85PI28cz?=
 =?us-ascii?Q?bpKyg/TbwskmMPqkFFLPrbT2xdtpd/aeVIw8peQAHMEqGVmfN8fUOv/Pf+oL?=
 =?us-ascii?Q?jzQiee9ynl7/K/Ns8kIYJDVZ0fGMF6DQdlsrUfmjVRPbXya/CTpNVd9Jl+3t?=
 =?us-ascii?Q?BV1p9D3bfoSMFNWJxrdwUJPvOeeuOhDfDXmW7zFJR+yCN8B1mJkVKNZfXq5A?=
 =?us-ascii?Q?LWzQU/AcL8uX25YEQ/AiPuaQ6D65uYPw6fwjAZZ6q6nUDf7CdLXhlgvx+8F4?=
 =?us-ascii?Q?3qwBONcVf11JzEOCO2IyPKjdnAaYOa1PyIKktr9oXdsHcZshkXxyEflkyXih?=
 =?us-ascii?Q?Re1KN4KASIHi5S6TnGXdZ7VPSfb3pvm2aiOCQKcUGqfElRz8C/NCmg6udaAm?=
 =?us-ascii?Q?qXo8aQCQDJ6Br3oAGhQFVetYLpjkr1QR9Mfjjceec1uPcKlwD+h6RMBCYBw7?=
 =?us-ascii?Q?RH4lGssk7IyOqU3zfd/jpgluVxhbIrT/cG+7XYEgDPYU3OvNkHpHTWSoEpNz?=
 =?us-ascii?Q?OcrTK9r9BUFhoBQQEXiSzkmu4An9BMtdamwd9UiISqhkCS+xGA0EgjBwLC3Z?=
 =?us-ascii?Q?EGkp4nGSFUYaZB5c/lOW65HLFdFmJ+gOoUGzBsG+4PDUAB1jHEBAPAMaZRcU?=
 =?us-ascii?Q?e37DLS3mXUgtP+gC+WDSZm2KBnOvdjJKj+9FjHxoAJlbMRUNMX+0UEAsIpLk?=
 =?us-ascii?Q?pHhY+D41OghrQ8LLRTpBiMh1b82Pwy+8EZDhADj4ieL4HmlnFrcj71eSq0qs?=
 =?us-ascii?Q?1M8rhLUmHJGHAwpr85v89GojZRwuYVYb8Wq/mT0FXlXuhZrUosOcVkpPAD6C?=
 =?us-ascii?Q?mwgc63x0CmWhgIuJnyDRMhuPWHZDWWJEPOmJRLDpNCWe1c19KeqoRhhW+f5J?=
 =?us-ascii?Q?9+tzDQ0rbk+6ty9Gb1HpWMxVphQH4ei77xeY5es1vb2jDDSl1w/BrLIQs+Ft?=
 =?us-ascii?Q?XLsIf2qfqQ+d0x+hRE9uxF/nNp6JgkQlbogFKxSxItmlvfHpVV8+ZyMkIzMf?=
 =?us-ascii?Q?6cX2A7mUp3eGXqW87+2tdm9pSP+obLHchbcg/SjWqnm1btdRAHfeN/LqedWD?=
 =?us-ascii?Q?SeI60P0J/Yw7/Sh96WZTY2qPPjrywHoKQYYhs1iToSR24BUSo+1qXMxRNgT7?=
 =?us-ascii?Q?Iv4jK+UUbjPVJ5vlaxzczE+Sw7l3GzG2vhucclXKm3LQ0nx177ksbWa6Znjp?=
 =?us-ascii?Q?UCvg5qtz2WgNHfE5Cz5l3MVuyfg4xT5K8ol+hwudah1RLSNsxjP/CxQb2mXR?=
 =?us-ascii?Q?V5FAicHQqiq3jbhr+gfKgxxtWEnouS79wp0JZAkSf9/h6anuWGDVv4Msa1OO?=
 =?us-ascii?Q?Ao0QR/BPb80BK8fL3f+18iMOxiV8aHY6qVM+Q656?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB6641.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95fce3af-8e71-43af-f457-08db0a4a8362
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Feb 2023 03:05:35.0590
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SlIT6x/wuwnzkXq7goglqZB/Yl/3BCmjp8QGj5XzLsIZHFCEZBu7SoxG/QXBDkuv52acAdYsuF1VpEp7MFCwNLjjfNltCF/K8KHnPIDy2ws=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB5605
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



-----Original Message-----
From: Guenter Roeck <groeck7@gmail.com> On Behalf Of Guenter Roeck
Sent: Thursday, February 9, 2023 02:04
To: David Rau <david.rau.zg@renesas.com>
Cc: Mark Brown <broonie@kernel.org>; perex@perex.cz; lgirdwood@gmail.com; t=
iwai@suse.com; support.opensource@diasemi.com; alsa-devel@alsa-project.org;=
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: da7219: Fix pole orientation detection on OMTP h=
eadsets when playing music

On Tue, Feb 07, 2023 at 02:42:14AM +0000, David Rau wrote:
>>=20
>> > You mean just keep the above two patches and revert 969357ec94e6 ?
>> > Sure, I can do that, but feedback from the field would take some
>> > 2-3 months. Is that what you recommend to do for now ?
>>=20
>> > Thanks,
>> > Guenter
>>=20
>> Thanks for the feedback.
>> What I mean is just do rollback to remove the "sleep" patch I did in you=
r repository.
>>=20
>> After the rollback, could you please let me know the average number of c=
rashes per affected system with the same test conditions?
>> Will it still take some 2-3 months?
>>=20
>The msleep() patch has been reverted in R111 and dev releases of ChromeOS.=
 I did not get permission to land the revert in R110, meaning we'll continu=
e to see the crashes there.=20
>R111 is expected to go to Beta shortly, so we should get _some_ feedback i=
n the next few weeks.
>Still, it would be great to get a more permanent fix for the underlying pr=
oblem. Also, the msleep() patch is still upstream, so a solution is still n=
eeded there.
>I can try to get and play with one of the affected Chromebooks, but I don'=
t think that would help much since we still don't know what the undocumente=
d ground switch is supposed to do.
Enable the GND switch earlier is needed to ensure the stable and smooth Jac=
k detection.

>Thanks,
>Guenter

Thanks for the kind explanation and feedback.
I am verifying another method which do the msleep() in the individual sched=
ule work to avoid such crash issue.

Would you please let me know how to reproduce this crash phenomenon?
Then I can ensure the new solution is stronger and solve this problem as we=
ll.

Thanks.
David
