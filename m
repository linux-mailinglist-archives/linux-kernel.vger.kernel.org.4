Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87C636C35FE
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 16:42:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231757AbjCUPmN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 11:42:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbjCUPmK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 11:42:10 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D0121ADD4;
        Tue, 21 Mar 2023 08:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1679413322; x=1710949322;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ZDAxBfsIImPPWOmP32Zo9xuTOu1W9Wk3SYz51VatI4k=;
  b=zfW2NdV0moeaS2yd1mP2FXytQn6qv9IEEdawLzSXjkkBPjca5sOBnzf2
   p/AiQKARpjUr0ULvFHwXfMTV+SkaGNQ/fY3UTGq5dF1hAIHuO1gP24nLA
   3UOildOAO94zXrBAMbBXAj4s35xMOTNKnzd+EhP35KaRwlrA5+i00iAtI
   lUM2n3uAPK6X1wCWP9KxAUH1beJTY1h4ZzjWVKDi4EKqs3hPa/c2r+t5+
   SiMrXD1WYiJsM2+Q453zVkKo5ZZubyTWc2lvBsW1TqfYRZqahvy/cDmR2
   V7CNR5gFeZXoYuTpHucbGlg9moPCy6V+yUsiqfuQG8D9XbKic7/bPAj16
   g==;
X-IronPort-AV: E=Sophos;i="5.98,279,1673938800"; 
   d="scan'208";a="206510004"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 21 Mar 2023 08:42:01 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 21 Mar 2023 08:41:53 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Tue, 21 Mar 2023 08:41:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dn1GQQ2nPfI+PXQRV87XAFmWWa+6KSy9osKwusJECNKVLnlLdtFC07F/71E7q622g8+IYGGhjulfTEjdNbRcyIkr7Iy8gIWkwtxIJvet+tHemn44RBaqoSeTYS8TMCBfQlnhSq1Us6UzMkLVqJCilBbZjMuhKDBhxhVrDR6rPZTns0CJsjpgkBAPuukfw3uQ098tOAK9hswo1TQu7rBO5MBOUaokGCbTNSz3XDPbki1i0uDpZZbH+8c6ojAootMoy5uPbcil09ezLQbh8ozM6WWau97txERrNzl/4b34JdrnH9QrNqxY8zAWuddKtn6Y04FwOcAtBxRCZbRyQnFDbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a3VeqdeHrKf3no/zroJy4m70/RfyiAds4O7cC2oCEvI=;
 b=heIk9chQJYp3tGD5byvll2i73dUuAQDijAeJIPNJStDy3jFutauTNIQ+Yf6WOfIymiplNQiZxSSyVK0XBE7GKEHEugDUbAHXdGuTqJh+0OlhEMbnwoKodPkIP5eJPkyvI7tv90RLXvZxZG8TiCfgmtCgFKprWFQGXa2pv+gLzpiub/Lb5uy+d8lgYGjQkMK7lOLCmhTgYiZppj4wd9nkUDFPlZL5QWORfMOdJN2DQZ7YROAE0wNgAOPF1660hDJ4AOk/hdnDPi0xHjSZbaW7UbcYrhGz4kSH7/bgFf916S1CO995SVYLh8IOx4AA1NrEXnfEZsvDkrjttTMOcnSgug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a3VeqdeHrKf3no/zroJy4m70/RfyiAds4O7cC2oCEvI=;
 b=Np4EK7ys2BzNFJuIs3SNA2Gsz+dn/ntvmCJswnZziuFi29jeFAXKTukRoNoj8lZspGQ5I8bBFP/HQytwoVOO7lQrd6P6MaXgxuCbcr9D3k9ONaNrDu9t1B29AzdQDr8uqDHeTT7FTO/PAw74twtrxpg7rBCvmLQ885LDArQYOnY=
Received: from PH0PR11MB5611.namprd11.prod.outlook.com (2603:10b6:510:ed::9)
 by PH8PR11MB6901.namprd11.prod.outlook.com (2603:10b6:510:22a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Tue, 21 Mar
 2023 15:41:50 +0000
Received: from PH0PR11MB5611.namprd11.prod.outlook.com
 ([fe80::d05b:4aca:cccb:a072]) by PH0PR11MB5611.namprd11.prod.outlook.com
 ([fe80::d05b:4aca:cccb:a072%8]) with mapi id 15.20.6178.037; Tue, 21 Mar 2023
 15:41:50 +0000
From:   <Shravan.Chippa@microchip.com>
To:     <sakari.ailus@iki.fi>
CC:     <paul.j.murphy@intel.com>, <daniele.alessandrelli@intel.com>,
        <mchehab@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <shawnguo@kernel.org>,
        <s.hauer@pengutronix.de>, <kernel@pengutronix.de>,
        <festevam@gmail.com>, <linux-imx@nxp.com>,
        <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH v12 5/5] media: i2c: imx334: update pixel and link
 frequency
Thread-Topic: [PATCH v12 5/5] media: i2c: imx334: update pixel and link
 frequency
Thread-Index: AQHZTBBlW3UhN6JX1k+chzEyKGiizq76t7iAgArC6LA=
Date:   Tue, 21 Mar 2023 15:41:50 +0000
Message-ID: <PH0PR11MB56114161FC09467BC60616F881819@PH0PR11MB5611.namprd11.prod.outlook.com>
References: <20230301073412.1204574-1-shravan.chippa@microchip.com>
 <20230301073412.1204574-6-shravan.chippa@microchip.com>
 <ZBDFcXYeK0eB9i1v@valkosipuli.retiisi.eu>
In-Reply-To: <ZBDFcXYeK0eB9i1v@valkosipuli.retiisi.eu>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5611:EE_|PH8PR11MB6901:EE_
x-ms-office365-filtering-correlation-id: 9852dbeb-6390-410a-0bfa-08db2a22c98f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: snV2o2fdmXEzeva3iLK66YbdERcKba70uJgpLGWFLfRgm0wSNIMc0/CgxAvJAtpL5M6AEv3OU35nQKVmRNAONqoPQdi7YJVEwKbzy0TunHx3dwaDJod7B6W5ezOFCLGtE3m+f8NM8GXCEjQTcTotpjeCIpbyasPM1UU/HP5Ac/i8HpC1y8wYEMFFMrDGI6tq1NZgkjhrSa6HKHtSFKaKsY1r+IrOobkSkIVSrRRp6/E+J0C7nIB6MqSqM9UXlYzY9cx6xn/s9fYFjzmpolqRxptubeDyZ6qg4iOGosPbaySGQCp0golFGCYCpQXYzB5iLMESgdnnCtFmtk0/qysjq6moLa3ELluK8flCS5TypfdHg2SD6gVk8KycBknvWCIu0XZL5BlJiqnnmR5lE0muzLqjVBLGeJKjo64zoBlAEnQrvwFl0YCypzkxQVM3mBKj05Zy+cvv5Q9N0D/aHqls01HjTF8mh7lnR7AD9NBN+9S7+jXqqJZgUTEYorpcLZpdzCMZg0PelkkcsKdcxn8tIlpxh1YRjM7126HI9JaQA2fR353XMiImYkdCUgleRUIzkIPr0hvn08r45dFzPGrXHwjOkhbvNBevNJxQxHMi9pXCtt4l4R8+PNY/SsdRxoy1s+a7YmhVbSBu45FuKk9l996loeTL/ZRsHz4cA3feLQ1oF9xGmLWO2UIbmXtjKGmDWAWr/kT5hlVe0yFZjJ7TnQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5611.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(396003)(39860400002)(376002)(136003)(346002)(451199018)(7696005)(83380400001)(54906003)(478600001)(86362001)(38070700005)(55016003)(38100700002)(15650500001)(66446008)(8936002)(64756008)(66476007)(4326008)(66556008)(8676002)(66946007)(2906002)(6916009)(41300700001)(52536014)(76116006)(122000001)(5660300002)(9686003)(6506007)(53546011)(71200400001)(7416002)(33656002)(26005)(316002)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?9GP3Gh127EKuACBWUpcAsDEc59XdOR0HcloyfJUmVW++CGj1QzzUWqj4PCW8?=
 =?us-ascii?Q?MYhULvvFHUpEQlDEdQe81h8Zi6YRQhCWUx63haNgwI+FI56QHQILrFcdqr8P?=
 =?us-ascii?Q?Cv4W/4sgbW7hgoAuGiHgZcnBLhY13k4zUA+CkM2bmMjDTM3sjZtD9vd0pcMx?=
 =?us-ascii?Q?lMp/14JnEYHHWdkCrn4cHOZ2h5tSCm01f1xcZKeaJZ8sKYm1tTxrwo3Zjp2s?=
 =?us-ascii?Q?8qpWlWlWTkQyp8ZZhQEaxbl5NEAtb+YlSPpxNKcYG8V97YPVRAF1W7VNQhLd?=
 =?us-ascii?Q?4D5os1LiidlNh+AcTA3Ruz8BGAa4wreotbRw1QFqdaVDXf8MoXH1cpawQ96c?=
 =?us-ascii?Q?Vl/mV3Q9ifbc3VcyiObsKWZ0ZmEFptyS+3iom2UQb+MsUrF0d9/ZQxEPvEni?=
 =?us-ascii?Q?U39ZG8qaNIfK5w4perg00/4E3S4NHdJyX92C0OpkkxGxDsBenBp522GGlDCf?=
 =?us-ascii?Q?FbEEFRBttUJuzcFXBFXPZT0RnhxFWg6efsGZd/fJBfE/+DZ0zd8NlppzvAdk?=
 =?us-ascii?Q?ncTY4QzCNV8MEnN5RgHw9oYtw4d9u2HAZWXa7v01fduA00vzio5fnMOruZbW?=
 =?us-ascii?Q?t25uy0TkyL9HnzG10N6/tq8dGUNAJW97lWIqS1ASt/CJ270bkl3tJLJkw2y7?=
 =?us-ascii?Q?GCYhLdNOHmzLB6S2q+Mdw38my46z/apG+WjK/i4Z2+/H2ltcVcifRC/xTWMj?=
 =?us-ascii?Q?ssEe5tEZFpfuz/yScrf0iidJqnKs31NQXZRDC7M2f2toqHJw6MFy3+uBki0Y?=
 =?us-ascii?Q?Ybnp8GFFCSVY4q6wH69iyyFZTK7b75uQY7hsBueRJYMrx4t200/K/st94Ava?=
 =?us-ascii?Q?joOZyUNeCwBu1IYZAD3tbfaqVptFzQuH4RyBqyD+4dhEdXdZp2y1dphnv8td?=
 =?us-ascii?Q?ahd58c/krsaJ2UVBmGjSjShzy774Bzvtr9v9tUvYqHKWjsSiarqIBLDYU77l?=
 =?us-ascii?Q?72uqc+dPVLkRlrVu5b46+7FA+eMJk9HxSpljkb/rYtO/JxsF5L3abCoCqP9D?=
 =?us-ascii?Q?429iBICYCrqet5IkTkww4uuBxD4wzC7IZuA7BH9X+kmPM9jUpKzh6rcQO6VM?=
 =?us-ascii?Q?OJsYAAHuXbXtZj8lqPMPcGRzIyIFGCuHzYMGzOOWtThgYkxA+MoG7gLshkmP?=
 =?us-ascii?Q?WGiS3wqUoBy39Xe20QcZtPuP09Bk1+w+Sx1eJp03smQK1N74UTPE7ckBA+UQ?=
 =?us-ascii?Q?lDvBApmsS8yEYqkgbdILqzDit7jFk7kJEHG5rs5lkmVeT0UbYrZFg6b5yzH0?=
 =?us-ascii?Q?pa9yIJu3amGAPtbzEccuZyjZLbM5243xHEPzBbfyESaBR9fcy4YO+nA0bOjE?=
 =?us-ascii?Q?QO5cRQhCRxNlul6ekEf+To7aymLp3gOc/o3mz15wjnFk52UAPv2QqnvniWTl?=
 =?us-ascii?Q?WyvEKay7jEHPGygFRvsscPqm7UeJw9wMmq2XJOiPKELpCUb/o+XS0uaBSTiS?=
 =?us-ascii?Q?MzOA8uC2Mh7Kjd2JL44kflliyJ8W6Y6kUs8tlKMeO8Y9+jN0NTW2N/xPPVXc?=
 =?us-ascii?Q?EvSD7grRm47o9JdHsEndTK2B661AEbbpPPOX2Mdu15qu6bZrW0wE3KoHcVrq?=
 =?us-ascii?Q?HCjBoMpddIXKqx+otvJpRbM8Z5/4tVfN2gHv8Fhy8yPgCoMHW6ToMPzhReKU?=
 =?us-ascii?Q?6g=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5611.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9852dbeb-6390-410a-0bfa-08db2a22c98f
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2023 15:41:50.1750
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XxNHmhpA5xt+Kb2z90RrNHYvXcPPXNp3Mp3+cgKnHwi9TYVjJ61/Waow8HFe3TwcsMBKnZ/5mlEbwdcc4AhlnK+BSAa99ohNqwKbeecbXv4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6901
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sakari,

> -----Original Message-----
> From: Sakari Ailus <sakari.ailus@iki.fi>
> Sent: 15 March 2023 12:35 AM
> To: shravan Chippa - I35088 <Shravan.Chippa@microchip.com>
> Cc: paul.j.murphy@intel.com; daniele.alessandrelli@intel.com;
> mchehab@kernel.org; robh+dt@kernel.org; krzysztof.kozlowski+dt@linaro.org=
;
> shawnguo@kernel.org; s.hauer@pengutronix.de; kernel@pengutronix.de;
> festevam@gmail.com; linux-imx@nxp.com; linux-media@vger.kernel.org; linux=
-
> kernel@vger.kernel.org; devicetree@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org
> Subject: Re: [PATCH v12 5/5] media: i2c: imx334: update pixel and link fr=
equency
>=20
> EXTERNAL EMAIL: Do not click links or open attachments unless you know th=
e
> content is safe
>=20
> Hi Shravan,
>=20
> On Wed, Mar 01, 2023 at 01:04:12PM +0530, shravan kumar wrote:
> > @@ -885,7 +895,13 @@ static int imx334_init_pad_cfg(struct v4l2_subdev
> *sd,
> >       struct v4l2_subdev_format fmt =3D { 0 };
> >
> >       fmt.which =3D sd_state ? V4L2_SUBDEV_FORMAT_TRY :
> V4L2_SUBDEV_FORMAT_ACTIVE;
> > -     imx334_fill_pad_format(imx334, &supported_modes[0], &fmt);
> > +     fmt->format.code =3D imx334->cur_code;
>=20
> This does not compile.
>=20
> > +     imx334_fill_pad_format(imx334, imx334->cur_mode, &fmt);
> > +
> > +     __v4l2_ctrl_modify_range(imx334->link_freq_ctrl, 0,
> > +                              __fls(imx334->menu_skip_mask),
> > +                              ~(imx334->menu_skip_mask),
> > +                              __ffs(imx334->menu_skip_mask));
>=20
> You're not holding imx334->mutex here, as you should. Also accessing
> imx334->cur_code should only be done while that mutex is acquired.
>=20
> What's the purpose of calling __v4l2_ctrl_modify_range() here, all these =
values
> are static once probe() function has been called, aren't they?

v4l2_ctrl_new_int_menu() function limiting only upper and lower frequencies=
 max and min, as of now only two frequencies no problem. If we have more fr=
equencies then we may need to use__v4l2_ctrl_modify_range() with skip mask =
value.

>=20
> I'm dropping this patch for now, taking the first four.

I will try to send it as a separate patch.
>=20
> >
> >       return imx334_set_pad_format(sd, sd_state, &fmt);  }
>=20
> --
> Kind regards,
>=20
> Sakari Ailus
