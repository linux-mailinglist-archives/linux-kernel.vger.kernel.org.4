Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23EAA5F2148
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Oct 2022 06:42:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229507AbiJBEm3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Oct 2022 00:42:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiJBEm0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Oct 2022 00:42:26 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 440093ECCD;
        Sat,  1 Oct 2022 21:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1664685743; x=1696221743;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=+SdsVvqyqw8nnN1qHzrf7qhGSZz7ujK7366e00me/+Q=;
  b=ba5KaBFOsWMkcrzQ1Ab9mfLt5zdj7ERwlyaE8mIoT2C7sqQ8KtVUKkCQ
   C2Zn1hBTp+xi6BU50pTCl2VY0CMtKPJRYSGn33nGLl0mtXLsJFOLq0gij
   UZ7VR6Cf/OTjjTVuYbf6RUeU8r8I7yVwUKAea4Uj/QOmrklPSRo3ypx3+
   xAm4j0/DJUQXYFbvucXh78B6vnvpH7SKVTqi+aWzSLEPi9q1DTpfq2HzL
   Z7oRXJfuRGS43bVCaPrruyb+Ca2TseXgKzTAy2fVM8i81IsJy8cbhXL0Y
   92Oof0uzWEMaV4fgrjCz4sXIFMZtYHN1q3fgR62jxztRBiPzY5Oiw2x/s
   A==;
X-IronPort-AV: E=Sophos;i="5.93,361,1654585200"; 
   d="scan'208";a="116430830"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 01 Oct 2022 21:42:21 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Sat, 1 Oct 2022 21:42:21 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12 via Frontend Transport; Sat, 1 Oct 2022 21:42:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c+KDVdSxIlGGbeym0lRO02kzJbULNpz+7NoFls5NTsBleY5PZ+dPmNi7xxDI+9vIaS6v52T9B47BdQX6fx+Cpugt58sBxaArG1YYuEKy5V7DUASAZwQtvgm8nPjwG3V620TwZ8dM+DIGj7h8YDNqDjXNy72ktTtGNrfVkvdYJYEZGdC6JKmSkt7BpkkYVFAE3gfn6LARyKFaBTvbcIbROjPj/OK2obDlPM3OOFI84RofO1Jx2XMUh+sVpeHUeOd5YVNy9oi/G13VBZ8j1rR44pjR/qvJWvIgJBgvt3wVcXYrPqKpPXGVufC++9TGExTOfnGY1wVYcMqzIVFk6iFm4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=35/oyZeYTAl7P2IhMM4RnC+9EdAsGHhMxtcDmJ4pjSo=;
 b=QPDd8GSMt/R1o6U/2imw2Fgw254+tAfofvt+vqJnXw8PP8mjS0O7hQDpG6wtQ/ASdq1+TX2d+F7C5+TaOFo+L3ZtbfTQNtFJnw8OZM6KyskHmyQ8D0aiTukOu/RavqGdNn8H99fY97NdI8E7YMQCQFQP2MgVwUKhrZ7zMaeOvF5FZcGTXSnCx8soAEZDEpEdTFgTMtRS6pKI2S+6PpKLtSggORg7Zs8Q6ZW38bHOa7znUuR3B3jh8rPuGXKsL0jayMmQgjhWTRW+rQw17bCUT9VNfyRM5aTZPGdn0UnnS+G5F8JEyoq+54CQwXUdbHXQgxN72K/qPxDQ0rHVlkyz0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=35/oyZeYTAl7P2IhMM4RnC+9EdAsGHhMxtcDmJ4pjSo=;
 b=sAqO7Cw/s1FGPE7Dv3Wzglot7giH5OeFjdALuG+i2voaPvzI6F3kA0ayCkq59bbvyKs2ZzXVWxH2rC3TUZHXlDzH7TWJaLgMZIuJV3RqnrWgy0K4t3g41IDTg1P7u47a/7lILmo4JATjQrrv5JDdihMVlIiB0TVDUToLWj2tVHo=
Received: from PH0PR11MB5611.namprd11.prod.outlook.com (2603:10b6:510:ed::9)
 by SN7PR11MB7090.namprd11.prod.outlook.com (2603:10b6:806:299::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.26; Sun, 2 Oct
 2022 04:42:06 +0000
Received: from PH0PR11MB5611.namprd11.prod.outlook.com
 ([fe80::f3c0:8863:2bf8:2f77]) by PH0PR11MB5611.namprd11.prod.outlook.com
 ([fe80::f3c0:8863:2bf8:2f77%7]) with mapi id 15.20.5676.024; Sun, 2 Oct 2022
 04:42:06 +0000
From:   <Shravan.Chippa@microchip.com>
To:     <sakari.ailus@iki.fi>
CC:     <paul.j.murphy@intel.com>, <daniele.alessandrelli@intel.com>,
        <mchehab@kernel.org>, <linux-media@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <Conor.Dooley@microchip.com>,
        <Prakash.Battu@microchip.com>
Subject: RE: [PATCH v4] media: i2c: imx334: support lower bandwidth mode
Thread-Topic: [PATCH v4] media: i2c: imx334: support lower bandwidth mode
Thread-Index: AQHYzK9awxPJcnRsMkKQ3xMPRpeBzK3oO6wAgAjvzMCAAMuUgIAHULEggAFQUwA=
Date:   Sun, 2 Oct 2022 04:42:06 +0000
Message-ID: <PH0PR11MB56110214AA9709893DD5100281589@PH0PR11MB5611.namprd11.prod.outlook.com>
References: <20220920051023.12330-1-shravan.chippa@microchip.com>
 <YymuoFhxHBQLAicQ@valkosipuli.retiisi.eu>
 <PH0PR11MB56118BCE8F6B5E045485A71C81529@PH0PR11MB5611.namprd11.prod.outlook.com>
 <YzHYi2FQN1R+Ge4w@valkosipuli.retiisi.eu>
 <PH0PR11MB5611B27A6A2EFA9ABD79AB5E81599@PH0PR11MB5611.namprd11.prod.outlook.com>
In-Reply-To: <PH0PR11MB5611B27A6A2EFA9ABD79AB5E81599@PH0PR11MB5611.namprd11.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5611:EE_|SN7PR11MB7090:EE_
x-ms-office365-filtering-correlation-id: 17394587-9ddf-41d3-a424-08daa430756d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4/ZniThi7sjOOhMoCesNGTgOtAJ6K7Q2plnV28+jlegCe9l4yJgla4RbjV36twdHsKSDtLBAqM4hvMhkmFhCwUvz0ni9Z5Ra0w1eAmcXAcXU454nWi9T6Rsrf9pwK830RWfHLs9izN6yv5WpB6/h+w/59a5SCE2YobTVhWMrWFlpAI46a8Hzbchs3X3+C18P1QstQjK5skK4G/2GQ8MMkniK3PqFUDFMchbW5QDDhBEBYuxEn1dlqvvp+Kg98tVLLUqgXmWV9GopsEFoI9gNyVNVTOXXa1d+6I83KoJmDhAjcqU0yuPox1IW4fcBNs6XWjKLJtuZypkJXA+GcDnEcn+GdxUbvsBoMa2QRJiTBIfmnqTSZ0Fw8cGzNe7lRRDhuf2oTpQtd6KieQprC/+mexzP7qz52L8BFq4fL5gwWxBBYGAKIySiVBIlsavq0DfiFKP9BNODbv1IoBzcyqTr3w6OsRFERDJbUNHmljoMIL6tIuIQWcSLERR2c0Yy4kSsHdKnU7kmqczCcOe/goD1KgU19S1or0lkPPweZ5PwLho44CpH6nsp++fjR3d+l1258lH61MRBuaHDvy2QWLa4UuwebtDrkdFTE364+mtF+r/kdEpWC+4ojeKCALgCZc4cNo4E1m5xZ63aop0t9I6LTRI9s+DbuaFFzlmC12liRpaJ8QMyoKKz+eC8b0Jiy2/I2MxIBYmdnNrZ91+dqYbhCXhFrURcVRCCYJzPnMI7AAowsRN3sA2ie1woj3Wm+RqSQCupN6fpCx5COkKNN5BR4w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5611.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(39850400004)(396003)(366004)(376002)(136003)(451199015)(54906003)(66946007)(66556008)(66446008)(55016003)(316002)(8676002)(64756008)(966005)(76116006)(478600001)(66476007)(38070700005)(71200400001)(2906002)(83380400001)(4326008)(107886003)(122000001)(52536014)(38100700002)(5660300002)(30864003)(53546011)(6506007)(7696005)(41300700001)(6916009)(26005)(86362001)(9686003)(186003)(8936002)(33656002)(579004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+rzdAWtG0HwHV0FKnzi9NgPqB+/PwnMy7KqBTNBrHbZs7qIvi+YiqpIrAT/2?=
 =?us-ascii?Q?QKAmeNLcUSpFv5/FPyD6PYyIzW/Tw3FGuTGSCnapyDRTRMSrU7E0pZL+BoIU?=
 =?us-ascii?Q?mqKzQvTf8wAuXOlx8RJSpk/kZj4azqAhQ/FOKkp1/PUk8bYA9gw/rNmUX142?=
 =?us-ascii?Q?i05ahHmjEI25fpHIQV4sCtw5KK0KjJfRB26G5j6Sg0AqqXyfaICbKlQMjxIF?=
 =?us-ascii?Q?kqGj/vVc9jOkLDMvPxwD9eCzpmYGiD30L5Y0HCTc50sxT/tMXWYarzzC0lXU?=
 =?us-ascii?Q?DQtlLKzxvyokMBBw3eMVXfBZ0YfykTZXCV/7kGa12CsSDakAb7jwMq60/ab/?=
 =?us-ascii?Q?YF+nNuK3Y7MskTW7Vk/GORo5jYipoRmL3aAiV7L+oVJ/SjI86qIdzJkGVyo5?=
 =?us-ascii?Q?Y64EmlpJQbz5hvmkMrsrGmQuORA06gWvHNbkkNfs36aSpoTfLAk+27jMJ659?=
 =?us-ascii?Q?6Ra8oREsBnYLeehuHocMIIOvPxIVVEB7EpY6Lb2gB3fVbfZtvQVfEbbMZJBi?=
 =?us-ascii?Q?/K/B7hehBwSXTofc4NXkrpYbvHizYeLZvPuw+/G6WxtvMoReUo4qNlLAq9UM?=
 =?us-ascii?Q?jL2vektmdYHVpMjdZrTnT+miu5H9lskbtC8+Dusx8e4IwBtepeO8unTGqnHe?=
 =?us-ascii?Q?E0hwtrs42I+vZeU/RB0wo30NxxXMPwkFX4dz5gEm/tewvboyMVqHJ68jkEeN?=
 =?us-ascii?Q?OZr/+t/pSsADA8zQyBV6TuZeZxZBqb9O+S+1WGxQ6rNncx9Dbgl1Te3pH+zV?=
 =?us-ascii?Q?Hy7xQTRTTpVsg69dCiTFo3L+NQ0TfvQCbebyk2b5BBIV7S1xLtJQ/SOiPlYJ?=
 =?us-ascii?Q?9PN+FzWqmuJJ+0YB9ItS+degobk9S3GquINupiUikqsNs+/gYnAbFU663ZTr?=
 =?us-ascii?Q?8uj6f59AMgTRj3z7WSv7f/hg1qA2XsE84L6lNUeKyjXhKUMink6jClU+7TKv?=
 =?us-ascii?Q?yp/POxAIDAOic2aH2Aj6x9IdyCpgVvZtf1HO7X0nVOV4JG7qgMXz85DFL1Jn?=
 =?us-ascii?Q?GlZKdWdVHd4T8wMEzQyb7WZSCFSIoNOH+l6+9AvRtBA9e4kg9e+jF2IypO2K?=
 =?us-ascii?Q?EhYR1IKH0SOqdwrn5rk9MoDH1fch7v9sxXHgpPIXyrqUBXUE4HWok50Kl6CA?=
 =?us-ascii?Q?fiSGyxGS/dgNJe8oc3IrlMV4FWfB8CLy+C5Gno//ON7N64/WR8jktpm+AwbC?=
 =?us-ascii?Q?pQb2y2MeSykjw9u+fch6DkdOcUmCDl281t1mtpDmiuVDjaXC+r6Kz08VIGZ4?=
 =?us-ascii?Q?3NCbEevRR/AUOpcoteoBNjuvVnmNeLwU3pJ9pCPiqsFCgK/a68f9RxqYVym4?=
 =?us-ascii?Q?yrCaMGmZZ5kSPrX3U8EqdHI5wjD7zFp+uaT8AfLwZVRCW0txBTy/dZLvgnHy?=
 =?us-ascii?Q?wRqJ44yWCEU6QjbRCbSG0Q+eXWsMyiMIWZlmXWSzr2PAfEV79ezzg+LLt0Mi?=
 =?us-ascii?Q?XxUnnNX+xywd4cgZeUP+kPLPbFortAuY8cBHRbKhU/TBf6hW2nf5ZuxejsJX?=
 =?us-ascii?Q?eQlEssxqkiKQf+Erj8o9d35zTV4M69SYsLGsbSPdNlbBIO1gbydHDb7clfcX?=
 =?us-ascii?Q?1G3IlKP+i1jiYqJ79vqZR3YD2+/nROpKHRIiRfOIG3BIMA2ZdikqHA+zhW4R?=
 =?us-ascii?Q?qw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5611.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17394587-9ddf-41d3-a424-08daa430756d
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Oct 2022 04:42:06.1226
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8M0H6IKeXDQA7qIx+bOX29CFg50r+fMiew/PMADEjQxEPci8adoGTe0ql8bt0SBX0HWbOtmTHt5wd/tqgHzD2ZePIggdXcaOPDCRIW/xDII=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7090
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: shravan Chippa - I35088
> Sent: 01 October 2022 02:22 PM
> To: Sakari Ailus <sakari.ailus@iki.fi>
> Cc: paul.j.murphy@intel.com; daniele.alessandrelli@intel.com;
> mchehab@kernel.org; linux-media@vger.kernel.org; linux-
> kernel@vger.kernel.org; Conor Dooley - M52691
> <conor.dooley@microchip.com>; Battu Prakash Reddy - I30399
> <Prakash.Battu@microchip.com>
> Subject: RE: [PATCH v4] media: i2c: imx334: support lower bandwidth mode
>=20
>=20
>=20
> > -----Original Message-----
> > From: Sakari Ailus <sakari.ailus@iki.fi>
> > Sent: 26 September 2022 10:21 PM
> > To: shravan Chippa - I35088 <Shravan.Chippa@microchip.com>
> > Cc: paul.j.murphy@intel.com; daniele.alessandrelli@intel.com;
> > mchehab@kernel.org; linux-media@vger.kernel.org; linux-
> > kernel@vger.kernel.org; Conor Dooley - M52691
> > <Conor.Dooley@microchip.com>; Battu Prakash Reddy - I30399
> > <Prakash.Battu@microchip.com>
> > Subject: Re: [PATCH v4] media: i2c: imx334: support lower bandwidth
> > mode
> >
> > [You don't often get email from sakari.ailus@iki.fi. Learn why this is
> > important at https://aka.ms/LearnAboutSenderIdentification ]
> >
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know
> > the content is safe
> >
> > Hi Shravan,
> >
> > On Mon, Sep 26, 2022 at 11:32:31AM +0000, Shravan.Chippa@microchip.com
> > wrote:
> > >
> > >
> > > > -----Original Message-----
> > > > From: Sakari Ailus <sakari.ailus@iki.fi>
> > > > Sent: 20 September 2022 05:44 PM
> > > > To: shravan Chippa - I35088 <Shravan.Chippa@microchip.com>
> > > > Cc: paul.j.murphy@intel.com; daniele.alessandrelli@intel.com;
> > > > mchehab@kernel.org; linux-media@vger.kernel.org; linux-
> > > > kernel@vger.kernel.org; Conor Dooley - M52691
> > > > <Conor.Dooley@microchip.com>; Battu Prakash Reddy - I30399
> > > > <Prakash.Battu@microchip.com>
> > > > Subject: Re: [PATCH v4] media: i2c: imx334: support lower
> > > > bandwidth mode
> > > >
> > > > [Some people who received this message don't often get email from
> > > > sakari.ailus@iki.fi. Learn why this is important at
> > > > https://aka.ms/LearnAboutSenderIdentification ]
> > > >
> > > > EXTERNAL EMAIL: Do not click links or open attachments unless you
> > > > know the content is safe
> >
> > This looks like a mail system problem.
> >
> > > >
> > > > Hi Shravan,
> > > >
> > > > Thanks for the patch.
> > > >
> > > > On Tue, Sep 20, 2022 at 10:40:23AM +0530, shravan kumar wrote:
> > > > > From: Shravan Chippa <shravan.chippa@microchip.com>
> > > > >
> > > > > Some platforms may not be capable of supporting the bandwidth
> > > > > required for 12 bit or 3840x2160 resolutions.
> > > > >
> > > > > Add support for dynamically selecting 10 bit and 1920x1080
> > > > > resolutions while leaving the existing configuration as default
> > > > >
> > > > > CC: Conor Dooley <conor.dooley@microchip.com>
> > > > > Signed-off-by: Prakash Battu <Prakash.Battu@microchip.com>
> > > > > Signed-off-by: Shravan Chippa <shravan.chippa@microchip.com>
> > > > > ---
> > > > >
> > > > > V3 -> V4
> > > > > - Make the 12 bit and 3840x2160 as default
> > > > > - Set bus code SRGGB12 if set format fails
> > > > >
> > > > > V2 -> V3
> > > > > - Fixed the warning reported by kernel test robot
> > > > >
> > > > > V1 -> V2
> > > > > - Addressed the review comment given by Jacopo Mondi,
> > > > >   Which has bug in imx334_enum_frame_size() loop function,
> > > > > - Renamed array codes[] to imx334_mbus_codes[]
> > > > > - Modified supported_modes[] to get higher resolution first
> > > > >
> > > > > ---
> > > > >  drivers/media/i2c/imx334.c | 302
> > > > > +++++++++++++++++++++++++++++++++----
> > > > >  1 file changed, 276 insertions(+), 26 deletions(-)
> > > > >
> > > > > diff --git a/drivers/media/i2c/imx334.c
> > > > > b/drivers/media/i2c/imx334.c index 062125501788..df2f1821569e
> > > > > 100644
> > > > > --- a/drivers/media/i2c/imx334.c
> > > > > +++ b/drivers/media/i2c/imx334.c
> > > > > @@ -79,7 +79,6 @@ struct imx334_reg_list {
> > > > >   * struct imx334_mode - imx334 sensor mode structure
> > > > >   * @width: Frame width
> > > > >   * @height: Frame height
> > > > > - * @code: Format code
> > > > >   * @hblank: Horizontal blanking in lines
> > > > >   * @vblank: Vertical blanking in lines
> > > > >   * @vblank_min: Minimal vertical blanking in lines @@ -91,7
> > > > > +90,6 @@ struct imx334_reg_list {  struct imx334_mode {
> > > > >       u32 width;
> > > > >       u32 height;
> > > > > -     u32 code;
> > > > >       u32 hblank;
> > > > >       u32 vblank;
> > > > >       u32 vblank_min;
> > > > > @@ -119,6 +117,7 @@ struct imx334_mode {
> > > > >   * @vblank: Vertical blanking in lines
> > > > >   * @cur_mode: Pointer to current selected sensor mode
> > > > >   * @mutex: Mutex for serializing sensor controls
> > > > > + * @cur_code: current selected format code
> > > > >   * @streaming: Flag indicating streaming state
> > > > >   */
> > > > >  struct imx334 {
> > > > > @@ -140,6 +139,7 @@ struct imx334 {
> > > > >       u32 vblank;
> > > > >       const struct imx334_mode *cur_mode;
> > > > >       struct mutex mutex;
> > > > > +     u32 cur_code;
> > > > >       bool streaming;
> > > > >  };
> > > > >
> > > > > @@ -147,6 +147,169 @@ static const s64 link_freq[] =3D {
> > > > >       IMX334_LINK_FREQ,
> > > > >  };
> > > > >
> > > > > +/* Sensor mode registers */
> > > > > +static const struct imx334_reg mode_1920x1080_regs[] =3D {
> > > > > +     {0x3000, 0x01},
> > > > > +     {0x3018, 0x04},
> > > > > +     {0x3030, 0xCA},
> > > > > +     {0x3031, 0x08},
> > > > > +     {0x3032, 0x00},
> > > > > +     {0x3034, 0x4C},
> > > > > +     {0x3035, 0x04},
> > > > > +     {0x302C, 0xF0},
> > > > > +     {0x302D, 0x03},
> > > > > +     {0x302E, 0x80},
> > > > > +     {0x302F, 0x07},
> > > > > +     {0x3074, 0xCC},
> > > > > +     {0x3075, 0x02},
> > > > > +     {0x308E, 0xCD},
> > > > > +     {0x308F, 0x02},
> > > > > +     {0x3076, 0x38},
> > > > > +     {0x3077, 0x04},
> > > > > +     {0x3090, 0x38},
> > > > > +     {0x3091, 0x04},
> > > > > +     {0x3308, 0x38},
> > > > > +     {0x3309, 0x04},
> > > > > +     {0x30C6, 0x00},
> > > > > +     {0x30C7, 0x00},
> > > > > +     {0x30CE, 0x00},
> > > > > +     {0x30CF, 0x00},
> > > > > +     {0x30D8, 0x18},
> > > > > +     {0x30D9, 0x0A},
> > > > > +     {0x304C, 0x00},
> > > > > +     {0x304E, 0x00},
> > > > > +     {0x304F, 0x00},
> > > > > +     {0x3050, 0x00},
> > > > > +     {0x30B6, 0x00},
> > > > > +     {0x30B7, 0x00},
> > > > > +     {0x3116, 0x08},
> > > > > +     {0x3117, 0x00},
> > > > > +     {0x31A0, 0x20},
> > > > > +     {0x31A1, 0x0F},
> > > > > +     {0x300C, 0x3B},
> > > > > +     {0x300D, 0x29},
> > > > > +     {0x314C, 0x29},
> > > > > +     {0x314D, 0x01},
> > > > > +     {0x315A, 0x0A},
> > > > > +     {0x3168, 0xA0},
> > > > > +     {0x316A, 0x7E},
> > > > > +     {0x319E, 0x02},
> > > > > +     {0x3199, 0x00},
> > > > > +     {0x319D, 0x00},
> > > > > +     {0x31DD, 0x03},
> > > > > +     {0x3300, 0x00},
> > > > > +     {0x341C, 0xFF},
> > > > > +     {0x341D, 0x01},
> > > > > +     {0x3A01, 0x03},
> > > > > +     {0x3A18, 0x7F},
> > > > > +     {0x3A19, 0x00},
> > > > > +     {0x3A1A, 0x37},
> > > > > +     {0x3A1B, 0x00},
> > > > > +     {0x3A1C, 0x37},
> > > > > +     {0x3A1D, 0x00},
> > > > > +     {0x3A1E, 0xF7},
> > > > > +     {0x3A1F, 0x00},
> > > > > +     {0x3A20, 0x3F},
> > > > > +     {0x3A21, 0x00},
> > > > > +     {0x3A20, 0x6F},
> > > > > +     {0x3A21, 0x00},
> > > > > +     {0x3A20, 0x3F},
> > > > > +     {0x3A21, 0x00},
> > > > > +     {0x3A20, 0x5F},
> > > > > +     {0x3A21, 0x00},
> > > > > +     {0x3A20, 0x2F},
> > > > > +     {0x3A21, 0x00},
> > > > > +     {0x3078, 0x02},
> > > > > +     {0x3079, 0x00},
> > > > > +     {0x307A, 0x00},
> > > > > +     {0x307B, 0x00},
> > > > > +     {0x3080, 0x02},
> > > > > +     {0x3081, 0x00},
> > > > > +     {0x3082, 0x00},
> > > > > +     {0x3083, 0x00},
> > > > > +     {0x3088, 0x02},
> > > > > +     {0x3094, 0x00},
> > > > > +     {0x3095, 0x00},
> > > > > +     {0x3096, 0x00},
> > > > > +     {0x309B, 0x02},
> > > > > +     {0x309C, 0x00},
> > > > > +     {0x309D, 0x00},
> > > > > +     {0x309E, 0x00},
> > > > > +     {0x30A4, 0x00},
> > > > > +     {0x30A5, 0x00},
> > > > > +     {0x3288, 0x21},
> > > > > +     {0x328A, 0x02},
> > > > > +     {0x3414, 0x05},
> > > > > +     {0x3416, 0x18},
> > > > > +     {0x35AC, 0x0E},
> > > > > +     {0x3648, 0x01},
> > > > > +     {0x364A, 0x04},
> > > > > +     {0x364C, 0x04},
> > > > > +     {0x3678, 0x01},
> > > > > +     {0x367C, 0x31},
> > > > > +     {0x367E, 0x31},
> > > > > +     {0x3708, 0x02},
> > > > > +     {0x3714, 0x01},
> > > > > +     {0x3715, 0x02},
> > > > > +     {0x3716, 0x02},
> > > > > +     {0x3717, 0x02},
> > > > > +     {0x371C, 0x3D},
> > > > > +     {0x371D, 0x3F},
> > > > > +     {0x372C, 0x00},
> > > > > +     {0x372D, 0x00},
> > > > > +     {0x372E, 0x46},
> > > > > +     {0x372F, 0x00},
> > > > > +     {0x3730, 0x89},
> > > > > +     {0x3731, 0x00},
> > > > > +     {0x3732, 0x08},
> > > > > +     {0x3733, 0x01},
> > > > > +     {0x3734, 0xFE},
> > > > > +     {0x3735, 0x05},
> > > > > +     {0x375D, 0x00},
> > > > > +     {0x375E, 0x00},
> > > > > +     {0x375F, 0x61},
> > > > > +     {0x3760, 0x06},
> > > > > +     {0x3768, 0x1B},
> > > > > +     {0x3769, 0x1B},
> > > > > +     {0x376A, 0x1A},
> > > > > +     {0x376B, 0x19},
> > > > > +     {0x376C, 0x18},
> > > > > +     {0x376D, 0x14},
> > > > > +     {0x376E, 0x0F},
> > > > > +     {0x3776, 0x00},
> > > > > +     {0x3777, 0x00},
> > > > > +     {0x3778, 0x46},
> > > > > +     {0x3779, 0x00},
> > > > > +     {0x377A, 0x08},
> > > > > +     {0x377B, 0x01},
> > > > > +     {0x377C, 0x45},
> > > > > +     {0x377D, 0x01},
> > > > > +     {0x377E, 0x23},
> > > > > +     {0x377F, 0x02},
> > > > > +     {0x3780, 0xD9},
> > > > > +     {0x3781, 0x03},
> > > > > +     {0x3782, 0xF5},
> > > > > +     {0x3783, 0x06},
> > > > > +     {0x3784, 0xA5},
> > > > > +     {0x3788, 0x0F},
> > > > > +     {0x378A, 0xD9},
> > > > > +     {0x378B, 0x03},
> > > > > +     {0x378C, 0xEB},
> > > > > +     {0x378D, 0x05},
> > > > > +     {0x378E, 0x87},
> > > > > +     {0x378F, 0x06},
> > > > > +     {0x3790, 0xF5},
> > > > > +     {0x3792, 0x43},
> > > > > +     {0x3794, 0x7A},
> > > > > +     {0x3796, 0xA1},
> > > > > +     {0x37B0, 0x37},
> > > > > +     {0x3E04, 0x0E},
> > > > > +     {0x30E8, 0x50},
> > > > > +     {0x30E9, 0x00},
> > > > > +     {0x3E04, 0x0E},
> > > > > +     {0x3002, 0x00},
> > > > > +};
> > > > > +
> > > > >  /* Sensor mode registers */
> > > > >  static const struct imx334_reg mode_3840x2160_regs[] =3D {
> > > > >       {0x3000, 0x01},
> > > > > @@ -243,20 +406,56 @@ static const struct imx334_reg
> > > > mode_3840x2160_regs[] =3D {
> > > > >       {0x3a00, 0x01},
> > > > >  };
> > > > >
> > > > > +static const struct imx334_reg raw10_framefmt_regs[] =3D {
> > > > > +     {0x3050, 0x00},
> > > > > +     {0x319D, 0x00},
> > > > > +     {0x341C, 0xFF},
> > > > > +     {0x341D, 0x01},
> > > > > +};
> > > > > +
> > > > > +static const struct imx334_reg raw12_framefmt_regs[] =3D {
> > > > > +     {0x3050, 0x01},
> > > > > +     {0x319D, 0x01},
> > > > > +     {0x341C, 0x47},
> > > > > +     {0x341D, 0x00},
> > > > > +};
> > > > > +
> > > > > +/*
> > > > > + * The supported BUS formats.
> > > > > + */
> > > > > +static const u32 imx334_mbus_codes[] =3D {
> > > > > +     MEDIA_BUS_FMT_SRGGB12_1X12,
> > > > > +     MEDIA_BUS_FMT_SRGGB10_1X10, };
> > > > > +
> > > > >  /* Supported sensor mode configurations */ -static const struct
> > > > > imx334_mode supported_mode =3D {
> > > > > -     .width =3D 3840,
> > > > > -     .height =3D 2160,
> > > > > -     .hblank =3D 560,
> > > > > -     .vblank =3D 2340,
> > > > > -     .vblank_min =3D 90,
> > > > > -     .vblank_max =3D 132840,
> > > > > -     .pclk =3D 594000000,
> > > > > -     .link_freq_idx =3D 0,
> > > > > -     .code =3D MEDIA_BUS_FMT_SRGGB12_1X12,
> > > > > -     .reg_list =3D {
> > > > > -             .num_of_regs =3D ARRAY_SIZE(mode_3840x2160_regs),
> > > > > -             .regs =3D mode_3840x2160_regs,
> > > > > +static const struct imx334_mode supported_modes[] =3D {
> > > > > +     {
> > > > > +             .width =3D 3840,
> > > > > +             .height =3D 2160,
> > > > > +             .hblank =3D 560,
> > > > > +             .vblank =3D 2340,
> > > > > +             .vblank_min =3D 90,
> > > > > +             .vblank_max =3D 132840,
> > > > > +             .pclk =3D 594000000,
> > > > > +             .link_freq_idx =3D 0,
> > > > > +             .reg_list =3D {
> > > > > +                     .num_of_regs =3D ARRAY_SIZE(mode_3840x2160_=
regs),
> > > > > +                     .regs =3D mode_3840x2160_regs,
> > > > > +             },
> > > > > +     }, {
> > > > > +             .width =3D 1920,
> > > > > +             .height =3D 1080,
> > > > > +             .hblank =3D 560,
> > > > > +             .vblank =3D 1170,
> > > > > +             .vblank_min =3D 90,
> > > > > +             .vblank_max =3D 132840,
> > > > > +             .pclk =3D 594000000,
> > > > > +             .link_freq_idx =3D 0,
> > > > > +             .reg_list =3D {
> > > > > +                     .num_of_regs =3D ARRAY_SIZE(mode_1920x1080_=
regs),
> > > > > +                     .regs =3D mode_1920x1080_regs,
> > > > > +             },
> > > > >       },
> > > > >  };
> > > > >
> > > > > @@ -506,10 +705,10 @@ static int imx334_enum_mbus_code(struct
> > > > v4l2_subdev *sd,
> > > > >                                struct v4l2_subdev_state *sd_state=
,
> > > > >                                struct v4l2_subdev_mbus_code_enum
> > > > > *code)  {
> > > > > -     if (code->index > 0)
> > > > > +     if (code->index >=3D ARRAY_SIZE(imx334_mbus_codes))
> > > > >               return -EINVAL;
> > > > >
> > > > > -     code->code =3D supported_mode.code;
> > > > > +     code->code =3D imx334_mbus_codes[code->index];
> > > > >
> > > > >       return 0;
> > > > >  }
> > > > > @@ -526,15 +725,22 @@ static int imx334_enum_frame_size(struct
> > > > v4l2_subdev *sd,
> > > > >                                 struct v4l2_subdev_state *sd_stat=
e,
> > > > >                                 struct
> > > > > v4l2_subdev_frame_size_enum
> > > > > *fsize)  {
> > > > > -     if (fsize->index > 0)
> > > > > +     unsigned int i;
> > > > > +
> > > > > +     if (fsize->index >=3D ARRAY_SIZE(supported_modes))
> > > > >               return -EINVAL;
> > > > >
> > > > > -     if (fsize->code !=3D supported_mode.code)
> > > > > +     for (i =3D 0; i < ARRAY_SIZE(imx334_mbus_codes); ++i) {
> > > > > +             if (imx334_mbus_codes[i] =3D=3D fsize->code)
> > > > > +                     break;
> > > > > +     }
> > > > > +
> > > > > +     if (i =3D=3D ARRAY_SIZE(imx334_mbus_codes))
> > > > >               return -EINVAL;
> > > > >
> > > > > -     fsize->min_width =3D supported_mode.width;
> > > > > +     fsize->min_width =3D supported_modes[fsize->index].width;
> > > > >       fsize->max_width =3D fsize->min_width;
> > > > > -     fsize->min_height =3D supported_mode.height;
> > > > > +     fsize->min_height =3D supported_modes[fsize->index].height;
> > > > >       fsize->max_height =3D fsize->min_height;
> > > > >
> > > > >       return 0;
> > > > > @@ -553,7 +759,7 @@ static void imx334_fill_pad_format(struct
> > > > > imx334 *imx334,  {
> > > > >       fmt->format.width =3D mode->width;
> > > > >       fmt->format.height =3D mode->height;
> > > > > -     fmt->format.code =3D mode->code;
> > > > > +     fmt->format.code =3D imx334->cur_code;
> > > > >       fmt->format.field =3D V4L2_FIELD_NONE;
> > > > >       fmt->format.colorspace =3D V4L2_COLORSPACE_RAW;
> > > > >       fmt->format.ycbcr_enc =3D V4L2_YCBCR_ENC_DEFAULT; @@ -591,6
> > > > > +797,21 @@ static int imx334_get_pad_format(struct v4l2_subdev
> > > > > +*sd,
> > > > >       return 0;
> > > > >  }
> > > > >
> > > > > +static int imx334_get_format_code(struct imx334 *imx334, struct
> > > > > +v4l2_subdev_format *fmt) {
> > > > > +     unsigned int i;
> > > > > +
> > > > > +     for (i =3D 0; i < ARRAY_SIZE(imx334_mbus_codes); i++) {
> > > > > +             if (imx334_mbus_codes[i] =3D=3D fmt->format.code)
> > > >
> > > > If you return here, you can remove the check below.
> > > This function taken ref from imx219 driver.
> > > And suggested by given by Jacopo Mondi Change in v2
> > > >
> > > > > +                     break;
> > > > > +     }
> > > > > +
> > > > > +     if (i >=3D ARRAY_SIZE(imx334_mbus_codes))
> > > > > +             i =3D 0;
> > > > > +
> > > > > +     return imx334_mbus_codes[i]; }
> > > > > +
> > > > >  /**
> > > > >   * imx334_set_pad_format() - Set subdevice pad format
> > > > >   * @sd: pointer to imx334 V4L2 sub-device structure @@ -609,7
> > > > > +830,13 @@ static int imx334_set_pad_format(struct v4l2_subdev
> > > > > *sd,
> > > > >
> > > > >       mutex_lock(&imx334->mutex);
> > > > >
> > > > > -     mode =3D &supported_mode;
> > > > > +     imx334->cur_code =3D imx334_get_format_code(imx334, fmt);
> > > >
> > > > This should be done only for the active format.
> > > Are you expecting  if condition to check the current bus code with
> > set_pad_fromat bus code?
> >
> > Only assign the cur_code field when setting the active format.
> I have taken reference from imx219 driver cur_code will update if the req=
uested
> format bus code maches with available bus_codes list if not mached with
> available bus_codes it will use defaults one only.
> am I missing any thing here ?

R u expecting to change the current bus code when get the V4L2_SUBDEV_FORMA=
T_ACTIVE requested?
I will try to modify in the next revision this case.

Thanks,
Shravan
 > >
> > > >
> > > > > +
> > > > > +     mode =3D v4l2_find_nearest_size(supported_modes,
> > > > > +                                   ARRAY_SIZE(supported_modes),
> > > > > +                                   width, height,
> > > > > +                                   fmt->format.width,
> > > > > + fmt->format.height);
> > > > > +
> > > > >       imx334_fill_pad_format(imx334, mode, fmt);
> > > > >
> > > > >       if (fmt->which =3D=3D V4L2_SUBDEV_FORMAT_TRY) { @@ -617,7
> > > > > +844,7
> > > > @@
> > > > > static int imx334_set_pad_format(struct v4l2_subdev *sd,
> > > > >
> > > > >               framefmt =3D v4l2_subdev_get_try_format(sd, sd_stat=
e, fmt->pad);
> > > > >               *framefmt =3D fmt->format;
> > > > > -     } else {
> > > > > +     } else if (imx334->cur_mode !=3D mode) {
> >
> > The mbus code no longer defines the mode. I think you'll need to take
> > this into account (pixel rate and link frequency?).
> >
> > > > >               ret =3D imx334_update_controls(imx334, mode);
> > > > >               if (!ret)
> > > > >                       imx334->cur_mode =3D mode; @@ -642,11
> > > > > +869,26 @@ static int imx334_init_pad_cfg(struct v4l2_subdev *sd,
> > > > >       struct v4l2_subdev_format fmt =3D { 0 };
> > > > >
> > > > >       fmt.which =3D sd_state ? V4L2_SUBDEV_FORMAT_TRY :
> > > > V4L2_SUBDEV_FORMAT_ACTIVE;
> > > > > -     imx334_fill_pad_format(imx334, &supported_mode, &fmt);
> > > > > +     imx334_fill_pad_format(imx334, &supported_modes[0], &fmt);
> > > > >
> > > > >       return imx334_set_pad_format(sd, sd_state, &fmt);  }
> > > > >
> > > > > +static int imx334_set_framefmt(struct imx334 *imx334) {
> > > > > +     switch (imx334->cur_code) {
> > > > > +     case MEDIA_BUS_FMT_SRGGB10_1X10:
> > > > > +             return imx334_write_regs(imx334,
> > > > > +raw10_framefmt_regs,
> > > > > +
> > > > > +ARRAY_SIZE(raw10_framefmt_regs));
> > > >
> > > > Please align to immediately right of the opening parenthesis. Same =
below.
> > > >
> > > > > +
> > > > > +     case MEDIA_BUS_FMT_SRGGB12_1X12:
> > > > > +             return imx334_write_regs(imx334,
> > > > > + raw12_framefmt_regs,
> > > > > +
> > > > > + ARRAY_SIZE(raw12_framefmt_regs));
> > > >
> > > > I think you'll also need changes to the pixel clock calculation.
> > > >
> > > In this driver pixel clock read only variable.
> > > Pixel clock change maybe in different series.
> >
> > Please address it in this patch.
> >
> > Is the link frequency affected by this patch as well?
>=20
> I will try to modify my patch with the default link frequency available i=
n the
> driver
>=20
> Thanks,
> Shravan
> >
> > --
> > Kind regards,
> >
> > Sakari Ailus
