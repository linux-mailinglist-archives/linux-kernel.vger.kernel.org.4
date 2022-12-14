Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B201E64C319
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 05:16:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237258AbiLNEQt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 23:16:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236731AbiLNEQ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 23:16:27 -0500
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2075.outbound.protection.outlook.com [40.107.13.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 844E92793C;
        Tue, 13 Dec 2022 20:16:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fjFleDS1yuPEQuJOMYceSzTwV7ZR9M0qPaN97ZBecqxICOQRrgqxLyWkyOuJTI6qpTOR9y7nFZU++bEgDk35gnNVF5Zfgw8tJs8gkUQcOBdfqTS9IpZmhpl3UruPt2Ylo958a5SjAEz3gnpYP6hh49g+arJtA8MyuS8gkkQEOE4xte2Nz5OA9QClKSE/3Hn/dQBcD0mpOjnMf/bgTRHwltv56ZhtpYTqjz1p2EU3RHHLFCvtACZXkNCntsXvP6BeKcljMW8ANtcU6xB8hiVoYW7PSF15HXl4O2scB87SwH1mWrif8ozX/Ah+UMI+2+7Dtklfn7yuxRhBW7DUYbc/Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n/mQMnlXZGjF8ApvpGnB4atA8/E+6O3KFNPZkQ3SpXg=;
 b=XCWefs51WKLxXAJr7lrH8iMqpAWsXi48pIet8NYRlO2dK71XzfuXOq7Lz3E66AGZ0H75i1CdkfCr9JLOUqqGeJAevKI2RZlWJnJtGv8aNrld7GSBVHnOepFKoqlnkaMzwq4h0c5vkTK3cISOd0+wSf/1+OUzI578HZExSvJPgd1qT7494Mzb041L7hs2oJMvDomCj4sYQM1WNu7iPc/vpVsqlEtfMgO0JRrUqkHToMFkpCpqNlnxNlKqinyINcmbMAAGbhbmw2b5zynwZpOO/dI440m6yDmKN27OhCPXZz+RuF3HrndG1OytbExxBzOhVWz/ns5tQUTQT15+4CiLFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n/mQMnlXZGjF8ApvpGnB4atA8/E+6O3KFNPZkQ3SpXg=;
 b=Thfdiu/93goQH62PQ++eZMU3VXiq3SsCHK9KMJkdIkxFXF3fogiuHlK2TSojGZj+gk0DQC3yVHe3lgocIMZ4hBwv9ciJwFnmuWtDrlHI011gXmcNDd45jqF9awzAfE1+fbkDVI4jQRtoNN/GlgiMSQ+jLSBaFcTkwq0puDYpN8g=
Received: from HE1PR0401MB2331.eurprd04.prod.outlook.com (2603:10a6:3:24::22)
 by DBBPR04MB7770.eurprd04.prod.outlook.com (2603:10a6:10:1ed::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.11; Wed, 14 Dec
 2022 04:16:22 +0000
Received: from HE1PR0401MB2331.eurprd04.prod.outlook.com
 ([fe80::203a:e5da:a4a:7663]) by HE1PR0401MB2331.eurprd04.prod.outlook.com
 ([fe80::203a:e5da:a4a:7663%12]) with mapi id 15.20.5880.019; Wed, 14 Dec 2022
 04:16:21 +0000
From:   Frank Li <frank.li@nxp.com>
To:     Chanh Nguyen <chanh@amperemail.onmicrosoft.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
CC:     "balbi@kernel.org" <balbi@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "imx@lists.linux.dev" <imx@lists.linux.dev>,
        "linhaoguo86@gmail.com" <linhaoguo86@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>,
        Chanh Nguyen <chanh@os.amperecomputing.com>
Subject: RE: [EXT] Re: [PATCH v2 1/1] usb: gadget: Assign an unique name for
 each configfs driver
Thread-Topic: [EXT] Re: [PATCH v2 1/1] usb: gadget: Assign an unique name for
 each configfs driver
Thread-Index: AQHZDz7Xq5KKpC+MIEabnI9j9xs4gK5sY74AgABYmICAAAhLsA==
Date:   Wed, 14 Dec 2022 04:16:21 +0000
Message-ID: <HE1PR0401MB2331334C46777CD7D992496888E09@HE1PR0401MB2331.eurprd04.prod.outlook.com>
References: <20221213220354.628013-1-Frank.Li@nxp.com>
 <67878b69-89af-6a0c-24c6-ff111dae6ce6@wanadoo.fr>
 <f1bb6995-6901-3def-3ff0-a7438339625a@amperemail.onmicrosoft.com>
In-Reply-To: <f1bb6995-6901-3def-3ff0-a7438339625a@amperemail.onmicrosoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: HE1PR0401MB2331:EE_|DBBPR04MB7770:EE_
x-ms-office365-filtering-correlation-id: e5593416-e2cc-43f0-e61e-08dadd89f509
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kOyVlppMMgwf8lGn+KkFja9kBrNbTaD3G9x4PAJLrFCFoXIrjvF7fXDxifySjFe58u1OY4qBJ0jEpwadlc3Si9yL8QN5RgmAvm0TayZUYJoUbEjvPKlcChA0ZJ/IHUPq2VCp1yZ8wYRsay/ht3QyXB5mH6SUcQudO7HHQKaCNHijVom442nFawkKCBbYkuWgWpJc5NQfG7YDmSohYbStxTR5jjbwsKLylTndzolw0rd/yjz4OugWYOTp+ZqmZI3ui6ysimZ32oPqFMqsrijp2+6DyQtU+ZMe0U6036dtv6d2YJxNDtQa/KccFruN75RD+qAS+ldqz7ADP+BAMO2NQLTTDQc1gWSpHd7k69Lv05fjqqhmOIW9uA5M2QRihR8WFAHn1oav1uU6DiQ/g9RzYlf7vCYXrvFzUWuqujKWyt5aKErdLNfU+t9yzHZONZOEG+rcAfwdqq+3Sh03BbDk4mAceEI8Ld7LVwOw5OLFOtNacKJkX4SSRsYJ/mCBgEx09g/GPgy19ea0g9McxfsxBt8dCyc4GwE3khWxKK0TV/BfRrDzSrUXrTWrE5czt8mScP4mdkGohIUta0kYT4BhyUuR6mICr0g2fkwsun5nfW37N1eAGC4GtQ0fPic1Wpw4DCPZxHqeaykowSxuXsq0BtAHrGXft/V97NVCahaE5PcABLm5uvBf8TTzUOMFmua7rzyRGJ8FEtTfLz6oAbgjHDuUrwDNF3q52sisi1EwAgM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0401MB2331.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(396003)(346002)(366004)(376002)(39860400002)(451199015)(33656002)(54906003)(4326008)(110136005)(316002)(296002)(66556008)(8676002)(66946007)(41300700001)(64756008)(38070700005)(66476007)(76116006)(66446008)(83380400001)(38100700002)(122000001)(55016003)(86362001)(6506007)(7696005)(71200400001)(52536014)(8936002)(7416002)(5660300002)(2906002)(44832011)(26005)(966005)(186003)(478600001)(45080400002)(55236004)(9686003)(53546011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?NH3MZS+A2QNL44njjK8GJOyxpXa4sgQkpyUN7KnVhnHedZdRqPk827CIdH?=
 =?iso-8859-1?Q?AdaNAe5KsouhfQhvOcka3RwtifqoktaeLgPIM5M+vPODSTR5USaOb/EsaN?=
 =?iso-8859-1?Q?C4AxEVwL5kDPRJYX5QEQCqQJDyoIjf48y3lz1feiX9JzJ4gIF1Wfc2SpG3?=
 =?iso-8859-1?Q?JyeDl8yaEJMM0Qfk+pNxd9Kboxb1pAsuRfYsNEPBLrbbO2ETwB8NVUsJGB?=
 =?iso-8859-1?Q?XA6ro/KotiuHdaRYJovBL2L4Kn2i5unoyOWabIxMqgbXfLa/WQVRgQUDKo?=
 =?iso-8859-1?Q?h1ATaoGYw13LP4pHrvwtjwf2ufb9Fa8Q7bM1YNQqVDYVWzMECj590xDm+o?=
 =?iso-8859-1?Q?N7Q8eK2zg2nwVPzV6EBsxm2oogGEBL+2eVZcvso7DM8xkTa7I4xR4ZwoHG?=
 =?iso-8859-1?Q?rxMIrfACVDTgQSAIVmVR+7M2qlNFfRNREeV/KqSZFKbV0/JMCO3AscoX9t?=
 =?iso-8859-1?Q?xaWmBaZG33+yja6J3ryDjtdbWScxe3MT2QV/xElCaHi7+6XMKBpqd/BfSD?=
 =?iso-8859-1?Q?Op/Xxkrcf9qUQACw55ffYp/s1+tQNhca7drDO2kTEYzttVFS/GBV+Xk6xt?=
 =?iso-8859-1?Q?fKj4DGleLj+2VyDrjR56+R7RNLef2myUGMPkaWRPjuLvJCUMvNvK1ZIz/V?=
 =?iso-8859-1?Q?oFDQduEQwr0Cls9yfa+Ka2X2QpP/speqFujHTwmIpoXjj66CLThQN0zoQI?=
 =?iso-8859-1?Q?Lds6P8XqDzyTKD++sO7pAqrZQlF1lOWfZUCJud55ecpNhTTlKNcbWdJD9C?=
 =?iso-8859-1?Q?+JssV+OqOkO8wqCXbtmZV/KD1qAAObydjr/cXtNEPqa0BYbvr+pN0Wpnp+?=
 =?iso-8859-1?Q?KPzleMkC06QR5ac8Uy2aIufV0vYEP53h+6XvwgjfRSbG56EVmjljF8579e?=
 =?iso-8859-1?Q?FGLsB25ottsW8w3X/YnL1gp+kcE2blVfiy86bTtJ8jNz1au/PThgYRM5sV?=
 =?iso-8859-1?Q?J3aQK8hl28xcToCJW0EzWaWVeP1Lu8mQ3DeNhDSy4PevL8K7PxDhGA8FcR?=
 =?iso-8859-1?Q?yucegi+FeRHaFrzhqfgL6K2gIz5Piy4Fd05wYTA3/23YpCJpIts2OBUnHB?=
 =?iso-8859-1?Q?aS4/OvtfQwZQezkQnH4CCxnOY9Rkps4049oROZNa5KELNE2fGHkokyMrwt?=
 =?iso-8859-1?Q?kRcbN+1WOtJguVGEmhxFy73ctzOn7q+bQIy1+P502mvEZcxcMYi4K3aDJN?=
 =?iso-8859-1?Q?4Mgp9OmsMoKFXiC3B/JTBS3Gqkr96h3C4vPw/I6IDeUAxEyo+vO+EXXLLa?=
 =?iso-8859-1?Q?Y89fv/APvITgp3yp+whXY9Tp/bU+91DscgyOHaeMlofkB6yz90haE+P7jC?=
 =?iso-8859-1?Q?sn7l2Wse+kk+7y9vg7n8NNcapY//OKhfgBjYlvDl1wZuRremRcvUUuDySs?=
 =?iso-8859-1?Q?zljDmGfg1vMhqGByU/CFfVkNhWIhUxPOUSMo2ucq4uIxivnL1Lcxk144AP?=
 =?iso-8859-1?Q?FBrFXsyPxd9IvXqge2tj2k4eDw8TLodZ9iDobyC5y8aDX7K//jE5ps+HN1?=
 =?iso-8859-1?Q?pY2vU3ebJrUSpEW5+FFjBKdhdwJ+Js9Cs8MNZa9GgmV7LheRw0bbFxeY6Y?=
 =?iso-8859-1?Q?G9AglFjpUTWcPW9jnnpu+8STjsimV3sj6JNuSBW1xuqQFbrRhlWp4reRQn?=
 =?iso-8859-1?Q?zRJE2mhg/pMUc=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0401MB2331.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5593416-e2cc-43f0-e61e-08dadd89f509
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2022 04:16:21.7358
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ArPpzgYORuaoNaxjEdc0zhTTRWlhkBOniYrOjJOZXHvsZeublKn6IwuL77z24Yp5e6QtsDw/6LO+X0+/GFI4BA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7770
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Chanh Nguyen <chanh@amperemail.onmicrosoft.com>
> Sent: Tuesday, December 13, 2022 9:38 PM
> To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>; Frank Li
> <frank.li@nxp.com>
> Cc: balbi@kernel.org; gregkh@linuxfoundation.org; imx@lists.linux.dev;
> linhaoguo86@gmail.com; linux-kernel@vger.kernel.org; linux-
> usb@vger.kernel.org; stern@rowland.harvard.edu; Chanh Nguyen
> <chanh@os.amperecomputing.com>
> Subject: [EXT] Re: [PATCH v2 1/1] usb: gadget: Assign an unique name for
> each configfs driver
>=20
> Caution: EXT Email
>=20
> On 14/12/2022 05:20, Christophe JAILLET wrote:
> > Le 13/12/2022 =E0 23:03, Frank Li a =E9crit :
> >> From: Rondreis <linhaoguo86@gmail.com>
> >>
> >> When use configfs to attach more than one gadget.
> >>
> >> Error: Driver 'configfs-gadget' is already registered, aborting...
> >>
> >>     UDC core: g1: driver registration failed: -16
> >>
> >> The problem is that when creating multiple gadgets with configfs and
> >> binding them to different UDCs, the UDC drivers have the same name
> >> "configfs-gadget". Because of the addition of the "gadget" bus, naming
> >> conflicts will occur when more than one UDC drivers registered to the
> >> bus.
> >>
> >> It's not an isolated case, this patch refers to the commit f2d8c260682=
5
> >> ("usb: gadget: Fix non-unique driver names in raw-gadget driver").
> >> Each configfs-gadget driver will be assigned a unique name
> >> "configfs-gadget.N", with a different value of N for each driver
> >> instance.
> >>
> >> Fixes: fc274c1e9973 ("USB: gadget: Add a new bus for gadgets")
> >>
> >> Signed-off-by: Rondreis <linhaoguo86@gmail.com>
> >> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> >> ---
> >>
> >> This patch is based on
> >>
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flore.=
k
> ernel.org%2Flkml%2F20220907112210.11949-1-
> linhaoguo86%40gmail.com%2F&amp;data=3D05%7C01%7CFrank.Li%40nxp.com
> %7C1c0810ddd7e94971373208dadd849636%7C686ea1d3bc2b4c6fa92cd99c5c3
> 01635%7C0%7C0%7C638065858780321185%7CUnknown%7CTWFpbGZsb3d8e
> yJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D
> %7C3000%7C%7C%7C&amp;sdata=3DdDLDGL9ie0hzjPa44qHt2oAnIurcZo01Mcz
> xBAjUoQk%3D&amp;reserved=3D0
> >> fixed the all greg's comments.
> >>
> >> I met the same issue.  Look likes Rodrieis have not continue to work t=
his
> >> patch since Sep, 2022.
> >>
> >> I don't know full name of Rondreis.
> >
> > Hi,
> >
> > Also, out of curiosity, any link with this patch:
> >
> >
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flore.=
k
> ernel.org%2Fall%2F20221213041203.21080-1-
> chanh%40os.amperecomputing.com%2F&amp;data=3D05%7C01%7CFrank.Li%4
> 0nxp.com%7C1c0810ddd7e94971373208dadd849636%7C686ea1d3bc2b4c6fa9
> 2cd99c5c301635%7C0%7C0%7C638065858780321185%7CUnknown%7CTWFpb
> GZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI
> 6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=3DHuD9mWg4D%2B%2BOPjUA6b
> 0DoktyubY52TwtWdEpMuMfuk0%3D&amp;reserved=3D0
> > ?
> >
> > Not exactly the same, but not very different.
> >
> > (adding Chanh Nguyen in cc)
> >
>=20
> What a coincident :-)
>=20
> I did not aware there are some similar attempts to fix the same issue
> and see both patches posted same time.
>=20
> We start to see the issue when OpenBMC started to adopt kernel 6.0 and
> try to fix the issue since then (beginning of Oct 2022)
>=20
> We then could be able to identify the issue and try to fix it follow the
> commit f2d8c2606825317b77db1f9ba0fc26ef26160b30
>=20
> Going forward, as we have both Frank and Rondreis interested in the
> patch, we are really happy if you both could review and share the
> comment. I'd really appreciate if you could help with that part.
>=20
> FYI, we have reviewed and made some changes based on CJ's comment in
> my
> last patch (v1) yesterday. We are trying to test it as much as possible.
> If it looks good we will re-post it as v2 shortly for further comment.

I almost just reused rondreis patch.=20
I can review your v2 version. =20

I prefer move kfree(gi->composite.gadget_driver.driver.name) into
 gadget_info_attr_release,  just before free(gi).

Best regards
Frank Li

>=20
> Thanks a lot for interesting in the patch.
> - Chanh
>=20
> >
> >>
> >>   drivers/usb/gadget/configfs.c | 30 ++++++++++++++++++++++++++----
> >>   1 file changed, 26 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/drivers/usb/gadget/configfs.c
> >> b/drivers/usb/gadget/configfs.c
> >> index 3a6b4926193e..785be6aea720 100644
> >> --- a/drivers/usb/gadget/configfs.c
> >> +++ b/drivers/usb/gadget/configfs.c
> >> @@ -4,12 +4,17 @@
> >>   #include <linux/slab.h>
> >>   #include <linux/device.h>
> >>   #include <linux/nls.h>
> >> +#include <linux/idr.h>
> >>   #include <linux/usb/composite.h>
> >>   #include <linux/usb/gadget_configfs.h>
> >>   #include "configfs.h"
> >>   #include "u_f.h"
> >>   #include "u_os_desc.h"
> >> +#define DRIVER_NAME "configfs-gadget"
> >> +
> >> +static DEFINE_IDA(driver_id_numbers);
> >> +
> >>   int check_user_usb_string(const char *name,
> >>           struct usb_gadget_strings *stringtab_dev)
> >>   {
> >> @@ -46,6 +51,7 @@ struct gadget_info {
> >>       struct usb_composite_driver composite;
> >>       struct usb_composite_dev cdev;
> >> +    int driver_id_number;
> >>       bool use_os_desc;
> >>       char b_vendor_code;
> >>       char qw_sign[OS_STRING_QW_SIGN_LEN];
> >> @@ -392,6 +398,8 @@ static void gadget_info_attr_release(struct
> >> config_item *item)
> >>       WARN_ON(!list_empty(&gi->string_list));
> >>       WARN_ON(!list_empty(&gi->available_func));
> >>       kfree(gi->composite.gadget_driver.function);
> >> +    kfree(gi->composite.gadget_driver.driver.name);
> >> +    ida_free(&driver_id_numbers, gi->driver_id_number);
> >>       kfree(gi);
> >>   }
> >> @@ -1571,7 +1579,6 @@ static const struct usb_gadget_driver
> >> configfs_driver_template =3D {
> >>       .max_speed    =3D USB_SPEED_SUPER_PLUS,
> >>       .driver =3D {
> >>           .owner          =3D THIS_MODULE,
> >> -        .name        =3D "configfs-gadget",
> >>       },
> >>       .match_existing_only =3D 1,
> >>   };
> >> @@ -1581,6 +1588,7 @@ static struct config_group *gadgets_make(
> >>           const char *name)
> >>   {
> >>       struct gadget_info *gi;
> >> +    int ret =3D 0;
> >>       gi =3D kzalloc(sizeof(*gi), GFP_KERNEL);
> >>       if (!gi)
> >> @@ -1622,16 +1630,30 @@ static struct config_group *gadgets_make(
> >>       gi->composite.gadget_driver =3D configfs_driver_template;
> >> +    ret =3D ida_alloc(&driver_id_numbers, GFP_KERNEL);
> >> +    if (ret < 0)
> >> +        goto err;
> >> +    gi->driver_id_number =3D ret;
> >> +
> >> +    gi->composite.gadget_driver.driver.name =3D
> >> +        kasprintf(GFP_KERNEL, DRIVER_NAME ".%d", gi-
> >driver_id_number);
> >> +
> >>       gi->composite.gadget_driver.function =3D kstrdup(name, GFP_KERNE=
L);
> >>       gi->composite.name =3D gi->composite.gadget_driver.function;
> >> -    if (!gi->composite.gadget_driver.function)
> >> -        goto err;
> >> +    if (!gi->composite.gadget_driver.function) {
> >> +        ret =3D -ENOMEM;
> >> +        goto err_func;
> >> +    }
> >>       return &gi->group;
> >> +
> >> +err_func:
> >> +    kfree(gi->composite.gadget_driver.driver.name);
> >> +    ida_free(&driver_id_numbers, gi->driver_id_number);
> >>   err:
> >>       kfree(gi);
> >> -    return ERR_PTR(-ENOMEM);
> >> +    return ERR_PTR(ret);
> >>   }
> >>   static void gadgets_drop(struct config_group *group, struct
> >> config_item *item)
> >
