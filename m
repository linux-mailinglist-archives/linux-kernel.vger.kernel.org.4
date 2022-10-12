Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2BCA5FC30F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 11:28:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbiJLJ2J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 05:28:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiJLJ2G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 05:28:06 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62A6D6DFA4;
        Wed, 12 Oct 2022 02:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1665566885; x=1697102885;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=qhjlf4VP4KU87PnsBPh/fqq0oXQyFaow7NJ5J2AW6zQ=;
  b=rQXMSy6ivOk/YhlKcO/5DMuyYWRadeM9RtnjKzRsqN1SVUP+Nw7mZblK
   02i9th/fOqkdja6MnBM+kvZqBPeO2vOcrKShoHb0PlrZDxvnMdmQhmOND
   EQoqzmlmLuqFSoOjUmrl+B6iWgUgpOCvivzl+9AzB1BTTbhysmIIOCuiy
   NdpoS7eD6q+OKBr3Gka135jKGFMMHLv84Wot3Pe1zXpKDTW+jgLNG9w7N
   PBN2OSbKHysv68LC+o4ioy4vCfXxC6a1p8t1IinBP8E9nM9hOkm9GwvSN
   I3ZWEiPXRyUfUZic1pDx1gIsrAwCPp1/DCA5pmHzW3WDfEPTvTgV/QqgX
   g==;
X-IronPort-AV: E=Sophos;i="5.95,178,1661842800"; 
   d="scan'208";a="118159012"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 12 Oct 2022 02:28:04 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Wed, 12 Oct 2022 02:28:00 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12 via Frontend Transport; Wed, 12 Oct 2022 02:27:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D4DX2KVt/QawKK88D/jXhukg4tyTQrp6u19xC3jKtttgQsAMPdPPFKrfQo5pazcReAjhy02QhhuRBHYpnl7A2vaTr7jwJQIdBxJNfSYyc91eg3tKHjDxoeJTiVdnk+p3i6+nJ4tMOd2TMHV9mRfgW83AKnwyB7AE+WH9ZG6QvDjOY/8q1+1XYYgTkWLv3dj93k3sUsHqMtvMbr8qISVSSDq7O0RDE0FmJDCDD1xoCSTlpvha8xVRkXFQFp8rwMDMGTM0IWhqASjTEi8U8a7UJDAgYF3Yttl/z1Mqhn5b8nYVyvpOrWIvFnX54DY/Bna75lFc0cS0NVEAKEJbdsm2ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7iRhWY4TOUueHH+bPhzv6B4yeDWd1qauYA4MUMrBiXA=;
 b=MtL+Nm2Qu1Na8BMi57yPn4c7L9UdaknOKy4LvL7PhfBh7COZIR0AvpUy3+NUipxosl5EtoiLTP5gyCFGxNmaLAev2nzApOm01COoeOIsfLr0OFNY+YKWND0rQj6wUxSex1IOzqMTvyDfsNO+ZrdxJGu2mZHi6cHzfy7Y1Eiu4uzY/wpve8DIsYuRZYx/QBUKXj1AjZTZG61B3Xv/yDvIQdQ4fS4RMBcKbaBu5Fbbwv/9JUwhO+9a1f719RfLiPIMi5givANUi0NJTEyipAx2/KFlgiAhZ7cs8ORq+bzSQdSuOZaUHxR6lBxRMLacxuh8XSXIKWhHrwt8VofH41VwsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7iRhWY4TOUueHH+bPhzv6B4yeDWd1qauYA4MUMrBiXA=;
 b=P+kVnt2dDfA0XxOqseF4J5wuz4z1FMJ0aGNPiCzhkImd7fJJRNk9b9/SgOAb7NP1cqKBz48v9A1gPjA3u92GPyxE77YTucGKH1JP90GIM2cocfJzc/X0m66ag/FovFfG/dO8H+uuZ1l1AJARtoY2lElF0kRWIKE1GGJxRUT45QA=
Received: from PH0PR11MB5611.namprd11.prod.outlook.com (2603:10b6:510:ed::9)
 by BL1PR11MB6027.namprd11.prod.outlook.com (2603:10b6:208:392::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Wed, 12 Oct
 2022 09:27:58 +0000
Received: from PH0PR11MB5611.namprd11.prod.outlook.com
 ([fe80::f3c0:8863:2bf8:2f77]) by PH0PR11MB5611.namprd11.prod.outlook.com
 ([fe80::f3c0:8863:2bf8:2f77%9]) with mapi id 15.20.5709.022; Wed, 12 Oct 2022
 09:27:58 +0000
From:   <Shravan.Chippa@microchip.com>
To:     <sakari.ailus@iki.fi>
CC:     <paul.j.murphy@intel.com>, <daniele.alessandrelli@intel.com>,
        <mchehab@kernel.org>, <linux-media@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <Conor.Dooley@microchip.com>,
        <Prakash.Battu@microchip.com>
Subject: RE: [PATCH v4] media: i2c: imx334: support lower bandwidth mode
Thread-Topic: [PATCH v4] media: i2c: imx334: support lower bandwidth mode
Thread-Index: AQHYzK9awxPJcnRsMkKQ3xMPRpeBzK3oO6wAgAjvzMCAAMuUgIAHULEggAHT6YCAD4HEwA==
Date:   Wed, 12 Oct 2022 09:27:58 +0000
Message-ID: <PH0PR11MB5611BE11C6F670971DCED30681229@PH0PR11MB5611.namprd11.prod.outlook.com>
References: <20220920051023.12330-1-shravan.chippa@microchip.com>
 <YymuoFhxHBQLAicQ@valkosipuli.retiisi.eu>
 <PH0PR11MB56118BCE8F6B5E045485A71C81529@PH0PR11MB5611.namprd11.prod.outlook.com>
 <YzHYi2FQN1R+Ge4w@valkosipuli.retiisi.eu>
 <PH0PR11MB5611B27A6A2EFA9ABD79AB5E81599@PH0PR11MB5611.namprd11.prod.outlook.com>
 <YzmD+yNv0Ryj/8IC@valkosipuli.retiisi.eu>
In-Reply-To: <YzmD+yNv0Ryj/8IC@valkosipuli.retiisi.eu>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5611:EE_|BL1PR11MB6027:EE_
x-ms-office365-filtering-correlation-id: 7df2b3a1-fc36-4ef9-e460-08daac340d00
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: q1lzu/WFWrf0w/OwVDiRrn3gYZewEoE1IZGouXLsnFhkO7VCZWVa6Gua5vkHJkNMoOSakq7rAZ4m1DA4cUYT2GHgHxpqkTUwqM59I49Z89w+iHUjgM21XMQcB8bGTQ1I3mAMdsyuRjyjMYtgdLHXDeofvEkTXX5ZG2+BSMEr11kOtpoOF50MxtjYkINFgcM38e8M9dEqqUAxXN/TX75Nc1aLSpJ1IZmhy4Sx8VvCwAmMKZrdcdCNXpNfM5DW3G75K4MDO+CknK9uIqLUX+KQfOq474EJMiaUJEeaWZmGbqlydhAhOlTc2FDHdR1s/9oNDTewhwbwALDl2Lg+Le7G+5Yjwq2MkjuyzJ1k2M9xdWTRCH7mo9MYFxq/RfNtw+ZoLLw73HvJwW+nCerugstB6tgLjDLlhUtMNI3dGJ7Whbcf6s7SWeCjF7fQWZn8h0inrg+MkZp/J/SQ34xUEnUFZBTaqA9o3l+YxUBcsqu3I47kIpKyFzCy3fn+V6X3wlCrz40wr02La1bVb7ZOCbeHqsMvqUFQNa9yRQlzaVdxq9Hh4i/aRSgn5Bd525NuDn5HVGBlf5KY9dCYw3IVgikuyxhHPFzaRmiOHOZ2CB6j7o5TX6JrIX1ki0WqMUVeKxS96R6L6PbWq2/v6ky+O1t6N7afkBxighRLn0QJlAue3Z/PqNFKRv0lr3V3vFdpqU6u4bfA7rydWsStVpmJvwiCwfUhM/O4Hr8T9e7Id2tBCkQbuMsNYqBXB7kcnYZimCgy60kwdfk2F2016NBizF8aSA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5611.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(396003)(376002)(136003)(346002)(366004)(451199015)(55016003)(107886003)(26005)(53546011)(8936002)(86362001)(41300700001)(2906002)(5660300002)(4326008)(33656002)(66946007)(66556008)(66446008)(66476007)(64756008)(52536014)(76116006)(316002)(6916009)(54906003)(478600001)(8676002)(71200400001)(38070700005)(6506007)(122000001)(83380400001)(9686003)(38100700002)(7696005)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?zSZQEF0UB7Lh8e7IDsbBbpWtB8VwhrI7u2yJk7TCRZZ00/XlDA900nCHFg5M?=
 =?us-ascii?Q?ZedMVo98wFbD14ffRet7Ati68KIFg25FOLlSg0GbB4ccfLJr/IydtWR+7kxo?=
 =?us-ascii?Q?1svuSZgF8NjR+oSM4/l9HNOSPizgq2zWr+I4LNTM+3daWyUzVaOR/Dx8nDDn?=
 =?us-ascii?Q?ygqDUhoUaRBYRqdXhx9jTdqsFq0r5YyGFXGGZ0qytWPVOXyuXn/tKVH5Ucdo?=
 =?us-ascii?Q?58oKsz5HScw4EaujmNkTOzseNORSpShhN+61HmgMSWpmVUCiYPPQbzxSZ20A?=
 =?us-ascii?Q?8ntoAcDt9F6n3sHFn932JOSCwJeFNvd5AljpUxBS1nDgbx+VEGGlePNtmtbv?=
 =?us-ascii?Q?Hf/sj6RBP3UgCVDDB8Ohva3Q7w01e8fjKNgVOlbOJSdtjxXEEKp1mutOp0Y/?=
 =?us-ascii?Q?FVvpcsMBQTItMRL3SRaftcREsMz2Q7Sgf6jbByGmtCcy6FC0kDBOqDm4xi6b?=
 =?us-ascii?Q?HEU/Hh/qk0pt+1SZHCImhY14+VMdrw2was/fMBnHRYajNAx86duXbnHr/0zU?=
 =?us-ascii?Q?VQCrHbRiehDxuSjSlfhXy8TXLHURY2OKF1M2T0/AubWm2DEqUquh6zQvYkEE?=
 =?us-ascii?Q?zx37L7kXkFm7dd9eCJsJGM6tAKe8YfXWBIZe923kR1RikqVdeNyHIq15lVsI?=
 =?us-ascii?Q?J26rCiz83WoHYpY6husZtdTxzKJ6ktz+Xbjq3ZB+5UHSvuxY1xCg/p6UatT2?=
 =?us-ascii?Q?LQpBvWJz3fY1L08+I21drLX4D7hjmCwEu6R3oLNn0KiA3ZGg/Nh19G1J4mjF?=
 =?us-ascii?Q?8B3QnqKaMU4kL+84TSFDo6F9Ter+4m18sZD7hB7JkOqYFeufD6My+AgVXMxW?=
 =?us-ascii?Q?Z4rGeDQ+qYdJruZQWXirCj8Du8daO85nj01lQJsoEW7K6UnXyntz4ecPTCTu?=
 =?us-ascii?Q?t62nXJp3z/OHM+G+S60oDZD6zBVbLuhL6LjAAc15xm8WZZMJaB3jegnXYgCN?=
 =?us-ascii?Q?Hio8+ugb6/Ockp7YD9XClGab7lblViPePKdK91FIQju153SZIOqfXnncTlyF?=
 =?us-ascii?Q?Bil26XTdwEkBZozNUZ5RQShI5NSNk2tMctiZFY1rH1i0ASE4Oa56VKi363nI?=
 =?us-ascii?Q?+8cGf/Z/qxZaGOl/JatL+5oswMkofZhsNbtSTbQbiP1KEWpdKAbto8cCHZjG?=
 =?us-ascii?Q?GTBs51h2MhWcCjkEXpUOw4+aARnYWdRFZBLcQAmbJLE0hxKbOwCteX/buy85?=
 =?us-ascii?Q?Z05jkKWhFIJZWkl12fbT9FG4Y+bjjtFwyulotR5q/BSwJcypimC3+jpQNwuN?=
 =?us-ascii?Q?lufP1nX5JDShDMv3esEQ9Mq6BwGt46Bd/Ggdpwjym0x8WygC4dGQYcKertyt?=
 =?us-ascii?Q?AQPM9yEfPbiOsJsnS8EYbFhPUntMc18hrNXhEcjl/bfQz6oB7oWCWhH5rWcz?=
 =?us-ascii?Q?ox2ImaPqQT7yd4eLghZC6LCxJKfN6Tvkx1wens9U1pzbD75hT1XVq87vNisW?=
 =?us-ascii?Q?ZE13/AKxoS6tHNLyK/x5bmTCu18nkH7led6Ay7D6T59h3yUdsJYAwIysVsHo?=
 =?us-ascii?Q?9UmgbS5t3B8L+Cy5IxDI6kYR0p4mqFLmntvmf37xpgRcs8EsqDqBvsXY8Cz4?=
 =?us-ascii?Q?Rnr8OcQ+5wN/Zw5pNC0J2uqnd2D5fsTMBpvGdKqU?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5611.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7df2b3a1-fc36-4ef9-e460-08daac340d00
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2022 09:27:58.2629
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LDViVAlQ221GZQCwE9Eum7D2+87VzgAok6GfGhtuqQSS/BhsNsY4/Ue4QGqmCADgf9PohU6cQFTT8dB3zRww2ike4LyQgq39qUOlC8xtFMY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB6027
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Sakari Ailus <sakari.ailus@iki.fi>
> Sent: 02 October 2022 05:59 PM
> To: shravan Chippa - I35088 <Shravan.Chippa@microchip.com>
> Cc: paul.j.murphy@intel.com; daniele.alessandrelli@intel.com;
> mchehab@kernel.org; linux-media@vger.kernel.org; linux-
> kernel@vger.kernel.org; Conor Dooley - M52691
> <Conor.Dooley@microchip.com>; Battu Prakash Reddy - I30399
> <Prakash.Battu@microchip.com>
> Subject: Re: [PATCH v4] media: i2c: imx334: support lower bandwidth mode
>=20
> EXTERNAL EMAIL: Do not click links or open attachments unless you know th=
e
> content is safe
>=20
> On Sat, Oct 01, 2022 at 08:51:46AM +0000, Shravan.Chippa@microchip.com
> wrote:
> > > > > > +     case MEDIA_BUS_FMT_SRGGB12_1X12:
> > > > > > +             return imx334_write_regs(imx334,
> > > > > > + raw12_framefmt_regs,
> > > > > > +
> > > > > > + ARRAY_SIZE(raw12_framefmt_regs));
> > > > >
> > > > > I think you'll also need changes to the pixel clock calculation.
> > > > >
> > > > In this driver pixel clock read only variable.
> > > > Pixel clock change maybe in different series.
> > >
> > > Please address it in this patch.
> > >
> > > Is the link frequency affected by this patch as well?
> >
> > I will try to modify my patch with the default link frequency
> > available in the driver
>=20
> Also check the frequencies the driver enables will be available in link-
> frequencies.

This patch is not affecting the default link frequency 891Mbps with input c=
lock frequency (24Mhz)
I have cross-checked with the present supported 3840x2160 resolution and im=
x334 UG.

Thanks,
Shravan

>=20
> --
> Sakari Ailus
