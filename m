Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDF4F72544C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 08:33:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235053AbjFGGdE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 02:33:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234897AbjFGGcb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 02:32:31 -0400
Received: from mx0b-0039f301.pphosted.com (mx0b-0039f301.pphosted.com [148.163.137.242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BC38AA;
        Tue,  6 Jun 2023 23:32:19 -0700 (PDT)
Received: from pps.filterd (m0174681.ppops.net [127.0.0.1])
        by mx0b-0039f301.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3576E5q1016282;
        Wed, 7 Jun 2023 06:32:05 GMT
Received: from eur02-am0-obe.outbound.protection.outlook.com (mail-am0eur02lp2233.outbound.protection.outlook.com [104.47.11.233])
        by mx0b-0039f301.pphosted.com (PPS) with ESMTPS id 3r2a6c9cyx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 07 Jun 2023 06:32:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nS8veUv4IqLnmRZ3mxRWHeIKRk6gRcxivu2WWwRyp3V74HF15OY8LCLKDlKKLAhYMj4CXTltZ1Bpf+9CqXojNd17dXT4s4J++0u7cURiXEeMhLfsF6Esg3MKqvHQFMURIDvCMvMUhlbU78DRCURmsvmRlHUmK4e68TTgFFrT18NajXhWA6ydSk8IPaCVMsUPV2tDdkbeQAekg1fGwJcXJs8/pNaEktHl+nfH1lBjezVEsISEMGQQgvRS0cb9b7mFeCbjOcPr1pCGSMltrPke0kQXAjSCS1P1OulbOlpa0/4NEZ46gTgNRwFiArsNdcb486WUUZr4Xvf5cR5M7+bKVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jbzJC0oO3I6QxUhjlajFNCh/FbhW63iaWYS3+cMmIBc=;
 b=LZvIFMwiDntns9fOH0KKU+MC2mlmT0nsEcI3vYi7tzPyCcJcyMufsGWRzeYFnQol8YyZLxFMZxw4BfHoURdVY93Wj5c4h33I5VlW9HiczRMogPQucK+sMNGuIQJ0z073zq4wgyBk1dxHqbkt3hxcyNpXUtc4CGaDvcP2dRL/0j9xU3hMiu5rM+Z9cT8ZDJ3mdKFyNqc9VgHZv9IsY2OkK4QURKYRWUXBbMOlfg535joH4rk1T12NRLu/5bui63ubPQXKOpDohvNCsU38lplzqPyHcD34Om+wEU+i2PmiUnscBgZuQVppOtTdYCPODWtu8VQ2BingLlDbZEIt8UB6rA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epam.com; dmarc=pass action=none header.from=epam.com;
 dkim=pass header.d=epam.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jbzJC0oO3I6QxUhjlajFNCh/FbhW63iaWYS3+cMmIBc=;
 b=OG3005TSMDuslYIYxrwn0uJAvpCK9vWwb/0dZhxRveSH7Iv0fgJiCtl2Fq46iLGXUGEG23LH98S/24fxJCHD4hI33Nie4AW4zQ3wBZMmy0I5zkDRljNejPSCZWZAX2NBOryYRRwCBIpfL39ETpnBAiIhPfYV1UdCpzczQsrXGSS7h/owKV2DNd6xOolvg79lZz9MhM8GPwoUzJFX2QqEruG7NqjOAa2o4Io/zfxpCxX8vJVqhMyTAQvM5/OXIlpFRs+0oI3iduwYMVSg1ot0Zw6gxFqm3dK9kVuiA175UbL8uGi5vKptpYew5dxT1RD+v8SKA3tWfmTIij+OmoNi5w==
Received: from PA4PR03MB7136.eurprd03.prod.outlook.com (2603:10a6:102:ea::23)
 by AM9PR03MB6849.eurprd03.prod.outlook.com (2603:10a6:20b:285::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Wed, 7 Jun
 2023 06:31:59 +0000
Received: from PA4PR03MB7136.eurprd03.prod.outlook.com
 ([fe80::528d:e0b6:ecc6:25e5]) by PA4PR03MB7136.eurprd03.prod.outlook.com
 ([fe80::528d:e0b6:ecc6:25e5%4]) with mapi id 15.20.6455.030; Wed, 7 Jun 2023
 06:31:59 +0000
From:   Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>
To:     Michal Simek <michal.simek@amd.com>
CC:     Cristian Marussi <cristian.marussi@arm.com>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Peng Fan <peng.fan@oss.nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
Subject: Re: [RFC v2 1/3] firmware: arm_scmi: Add SCMI v3.2 pincontrol
 protocol basic support
Thread-Topic: [RFC v2 1/3] firmware: arm_scmi: Add SCMI v3.2 pincontrol
 protocol basic support
Thread-Index: AQHZeEK6SX8vcPOUbkqIYZzlwR9d3a9MJZqAgApEBICAAAT5gIAAPBmAgAAAZ4CAKHfngA==
Date:   Wed, 7 Jun 2023 06:31:58 +0000
Message-ID: <20230607063157.GA1152806@EPUAKYIW0A6A>
References: <cover.1682513390.git.oleksii_moisieiev@epam.com>
 <b4d60f3408f8fe839933fa3938ecdc9bfceb75d7.1682513390.git.oleksii_moisieiev@epam.com>
 <ZFVeY3jVNfAkW1G9@e120937-lin> <20230512083805.GA3424996@EPUAKYIW0A6A>
 <ZF3/Ge4b+49ni+e6@e120937-lin> <20230512123059.GA3497038@EPUAKYIW0A6A>
 <03faa36d-d444-593f-c814-40eb865e9f83@amd.com>
In-Reply-To: <03faa36d-d444-593f-c814-40eb865e9f83@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR03MB7136:EE_|AM9PR03MB6849:EE_
x-ms-office365-filtering-correlation-id: b0853f13-d9b3-4ba4-7659-08db6720e57a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2P7r/6GX9lq7pEu0Q3HdZwGfWiM/ZkHkc5Dqz+4wogjoH+7YVvhIWHSOzomYHed/UjGQGLY7VFGdnq1QjXraA8f3JJ7LycWC8eIVpLirnBkaA2wiUVbb2OD0VpiNnDgAqcTU8io93I2lh+C79Ef45Y8rMOL8/AXl0PoECin9GXngKdhrbzsl78P1ws3/OZcqzVUgI2zI5HdlJSFHP4sVe2YlCUadIXAKYnwoyprrr00VTv8eNnYRhraysavvIy+HbuDkXP+cHu3pE5sYIt6Lkayqp2hqAvfTvCLZuBYyBm3RfaU3yAXdEUbhKYmpED/TGeX90TRvnurZcevF3IJKCa87NXkKakfSd29DkaG2vd3exmJVgWSxCaGy0SzWEiuoL2mK8oH/OnugyAWQbd0PiMseKGYnX9Hi038JD52XinVoLadyvuLiIXOihmC33W9+IJlQx5lhdim0sQeZ/gTb2W1RNP5PT97Evdl7mbirkVD+FvWPSBZmGY5njrLATKPXzn4WeAnrDdbyejVeL/hZAqKCiowMou7+PBEsaSlObcZFckinLDTnq45sHWhXAl5f0prSMKMfdV9xkhOl6IQIzAjzHfMhAPKQekyFBPlPbR6M0W5Q/nT1YOfwsowOZIZj
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR03MB7136.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(7916004)(136003)(39860400002)(346002)(366004)(376002)(396003)(451199021)(33716001)(6506007)(9686003)(1076003)(186003)(26005)(6512007)(53546011)(83380400001)(6486002)(54906003)(2906002)(71200400001)(8676002)(8936002)(33656002)(478600001)(41300700001)(5660300002)(66446008)(122000001)(316002)(6916009)(38070700005)(86362001)(38100700002)(4326008)(66476007)(76116006)(66556008)(66946007)(91956017)(64756008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?HqBhMVmMBvFa/V9XHQTNd2gooCFt9g61YKZKLmnD67IutFB+f/c2Ledhmtmo?=
 =?us-ascii?Q?+ePR1PyCClyZ2qp8taU7hRD8XQBbTqZQxkb3pj2+Tloo5ObyjoU4CmIslj/W?=
 =?us-ascii?Q?1DqQ4lGDUrHcDDi/GyW1w9lty4W6Y67eDuds4NLG8/1mRupXVvFrgLhg9RzI?=
 =?us-ascii?Q?HRz98GHT08oJqg2QeVcBYhXjBbrDex9Y2ZqbDuTs1oRWuiZK1Oc2xo0Vyc9k?=
 =?us-ascii?Q?rKNKGaqygeulJlgrSz6kqKaauavrr6kdb/F+H9Rf5wieX2lgma0UiHNYtKJK?=
 =?us-ascii?Q?5H4SUTEjuiOU9+2veuRKi75fE7XCw7SPQFdZjFXlJTXGXEqF7kFKGRfIxFzB?=
 =?us-ascii?Q?JolezX1Ga4xEeZTUa/aqtDf/Axt05LCyIbhjufX1yZfowX8QZY+Ozpf+7P9G?=
 =?us-ascii?Q?yF/gqvDiDah4xM/shkW9Y7T5XBmFJJ3wT1TJYVU7VP9BFNtT6saXwwUz0VUu?=
 =?us-ascii?Q?scJUiVYrF0Se4nWn/7hFYTq4Exeo8VN8G+FUbzGzSMGTXiV5Dz4yZ8QllTzj?=
 =?us-ascii?Q?rzycqy5XUzzQKT31keBFI1hx5SnRAoa22+M/n9uAct5x4iN8rdIg7rNY/lxN?=
 =?us-ascii?Q?ayQ4RyGJeaWVhsjlpkfCD/KGywSACaJADiSAqg1S2qW2Ha83unqKAxWsY41j?=
 =?us-ascii?Q?0T4EXPOt56m8FFjE814IYJcZcLX4JQEdX2yL3/kCaLTZnTTY8u1ToUqFiFqe?=
 =?us-ascii?Q?kyxcwY4Zzzo2hEIgf+/9TAeDNvIifF3SdIyjos7/EK/0P6tLemYdS6Mfx/a0?=
 =?us-ascii?Q?0dDizh0N/6swl1KF3VbhNK93MweT1yWdsMPUt8BdOIOTC1O5aJmy8AbmJp4W?=
 =?us-ascii?Q?fXy4UW9Ellu+2U91+snkiXGERJgUOXdor9aVMH3KXG+A0ywgwrFEhSECer//?=
 =?us-ascii?Q?Vh3sSUXIlHPN537Skr8MRoi+rusopHCbxAuqWYJWR+geQ9KQBGD3gol3yBm6?=
 =?us-ascii?Q?AXj8OY6ZMCPRbcfEMgBq1+cy8vi1ZOFdL4W3kiS9//aL/36zrkDggIK5+f6Q?=
 =?us-ascii?Q?E1TDoF2bxbpe8zWThG7WXV4O9J/rNXAf7WvteVoEhgw0qxVVDv1cilLoCcHv?=
 =?us-ascii?Q?sn1x8qPjMPJIISlDpuAEk4Y1ZJNF+aP8ieOOqMySWudVX9fnUXXb8FOKFoY2?=
 =?us-ascii?Q?DYfzIPnRVj0StPRMHgAE1XDsm5BSFypJSvUkPzhX7PxwVUjK7oymsR4ho0ng?=
 =?us-ascii?Q?DCHOc5G+ZGyXaheQ/IJWX/qKSRU7A3cQRxXZ/qlpA8wa6lqEiqq97cg2ZJcn?=
 =?us-ascii?Q?rmJGEUqeLiP9ZXcB8CvrKqXfN4gFbO1RZW3rbvssel6QoZoWZQPr6+nMpPIP?=
 =?us-ascii?Q?QIDFT3DEctfEOnRE4OuIixOWatj9kHSm2Mqv0iKaKA0CcY6oPiMLXjLD6c1l?=
 =?us-ascii?Q?KiwAHtMzteENlPZ3vrWVmDtYlYIlc/ALrS0akgYCIW1AN2Zg5D5lxepP0UA7?=
 =?us-ascii?Q?Jk3G7xshZDLTbpI6KxvZcBydZkjoQ9BkRgNMK0GGH1f57KZCls1L0dRDsERh?=
 =?us-ascii?Q?O2CxYPlvWQ1/FydVN8qW+HeFH5cZXayRVAUjAfUhJFngZ/3SwitXt5p0O+S4?=
 =?us-ascii?Q?F4CFh2Ul9jW47BQXrYytecBv89I6PHNus8y+eq9G9Ryvgib3d8eEZtt4ItJQ?=
 =?us-ascii?Q?nA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <33356C174ABF46439E20276F3F5F1B3C@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR03MB7136.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0853f13-d9b3-4ba4-7659-08db6720e57a
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2023 06:31:58.9122
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ke9yEUS9s7UTXaQRznf/iW1zA7ZvGwwL/DgYd4evTAUXKVc2qZYun5R8cYX8v27L4Z16Y3AVNZUo6O132d1443QcyA4cyWXkOfoBATRcNYs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR03MB6849
X-Proofpoint-ORIG-GUID: 3d-ZfLBQaMpD-x_m56eR2S_Sd_nEtR-h
X-Proofpoint-GUID: 3d-ZfLBQaMpD-x_m56eR2S_Sd_nEtR-h
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-07_03,2023-06-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 mlxlogscore=999 suspectscore=0 spamscore=0 adultscore=0 lowpriorityscore=0
 mlxscore=0 clxscore=1015 bulkscore=0 impostorscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306070053
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 12, 2023 at 02:32:25PM +0200, Michal Simek wrote:
>=20
>=20
> On 5/12/23 14:31, Oleksii Moisieiev wrote:
> > On Fri, May 12, 2023 at 09:55:53AM +0100, Cristian Marussi wrote:
> > > On Fri, May 12, 2023 at 08:38:06AM +0000, Oleksii Moisieiev wrote:
> > > > On Fri, May 05, 2023 at 08:52:03PM +0100, Cristian Marussi wrote:
> > > > > On Wed, Apr 26, 2023 at 01:26:37PM +0000, Oleksii Moisieiev wrote=
:
> > > > > > scmi: Introduce pinctrl SCMI protocol driver
> > > > > >=20
> > > > > > Add basic implementation of the SCMI v3.2 pincontrol protocol
> > > > > > excluding GPIO support. All pinctrl related callbacks and opera=
tions
> > > > > > are exposed in the include/linux/scmi_protocol.h
> > > > > >=20
> > > > >=20
> > > > > Hi Oleksii,
> > > > >=20
> > > > > Thanks for this.
> > > > >=20
> > > > > I tried out this in an emulated setup and found just a minor issu=
e from
> > > > > the spec/functional point of view...then I reworked the extended =
names
> > > > > support using a modified hops->extended_name_get helper (as said =
the core
> > > > > SCMI support needed a small modification to support PINCTRL): I'l=
l reply
> > > > > to this mail thread with such core SCMI modification patch, so yo=
u can
> > > > > include this patch of mine in your next V3 and use it in your ser=
ies.
> > > > >=20
> > > > > Moreover, given that I wanted to test such rework of mine and a b=
unch
> > > > > of other cleanups I did (as detailed down below), and it seemed s=
illy
> > > > > to throw all away just to then having to detail all to you, I'll =
also
> > > > > include in another distinct reply the raw diff of what I changed =
in
> > > > > your series to use the new extended_name support and a few other =
cleanups,
> > > > > so that, if you want, you can just quickly merge that into your V=
3 patch
> > > > > (of course if you like it and tests fine also for you...)...these=
 are
> > > > > small changes, if you take it, no need to bother with authorship =
and
> > > > > attribution from my point of view.
> > > > >=20
> > > >=20
> > > > Hi Cristian,
> > > >=20
> > >=20
> > > Hi,
> > >=20
> > > > Thank you for the patches. I've applied them and tested with powerp=
c,
> > > > mx68 and clang environments (as test-robot complained about).
> > > >=20
> > >=20
> > > Yes, sure, they were just tentative fixes, needed cleanup.
> > > I forgot to add the RFC tag on my proposed fixes to avoid triggering =
the bots.
> > >=20
> > > > > > Signed-off-by: Oleksii Moisieiev <oleksii_moisieiev@epam.com>
> > > > > > ---
> > > > > >   MAINTAINERS                           |   6 +
> > > >=20
> > > > [snip]
> > > >=20
> > > > > >   SYSTEM RESET/SHUTDOWN DRIVERS
> > > > > >   M:	Sebastian Reichel <sre@kernel.org>
> > > > > >   L:	linux-pm@vger.kernel.org
> > > > > > diff --git a/drivers/firmware/arm_scmi/Makefile b/drivers/firmw=
are/arm_scmi/Makefile
> > > > > > index b31d78fa66cc..071ac65f22b9 100644
> > > > > > --- a/drivers/firmware/arm_scmi/Makefile
> > > > > > +++ b/drivers/firmware/arm_scmi/Makefile
> > > > > > @@ -3,6 +3,7 @@ scmi-bus-y =3D bus.o
> > > > > >   scmi-core-objs :=3D $(scmi-bus-y)
> > > > > >   scmi-driver-y =3D driver.o notify.o
> > > > > > +
> > > > >=20
> > > > > Do not add spurios lines.
> > > > >=20
> > > >=20
> > > > Thanks, removed
> > > >=20
> > > > > >   scmi-driver-$(CONFIG_ARM_SCMI_RAW_MODE_SUPPORT) +=3D raw_mode=
.o
> > > > > >   scmi-transport-$(CONFIG_ARM_SCMI_HAVE_SHMEM) =3D shmem.o
> > > > > >   scmi-transport-$(CONFIG_ARM_SCMI_TRANSPORT_MAILBOX) +=3D mail=
box.o
> > > > > > @@ -10,7 +11,7 @@ scmi-transport-$(CONFIG_ARM_SCMI_TRANSPORT_SM=
C) +=3D smc.o
> > > > > >   scmi-transport-$(CONFIG_ARM_SCMI_HAVE_MSG) +=3D msg.o
> > > > > >   scmi-transport-$(CONFIG_ARM_SCMI_TRANSPORT_VIRTIO) +=3D virti=
o.o
> > > > > >   scmi-transport-$(CONFIG_ARM_SCMI_TRANSPORT_OPTEE) +=3D optee.=
o
> > > > > > -scmi-protocols-y =3D base.o clock.o perf.o power.o reset.o sen=
sors.o system.o voltage.o powercap.o
> > > > > > +scmi-protocols-y =3D base.o clock.o perf.o power.o reset.o sen=
sors.o system.o voltage.o powercap.o pinctrl.o
> > > > > >   scmi-module-objs :=3D $(scmi-driver-y) $(scmi-protocols-y) $(=
scmi-transport-y)
> > > >=20
> > > > I've applied patches you provided and made a small fixes. I'm going=
 to
> > > > make patch:
> > > > "firmware: arm_scmi: Add optional flags to extended names helper"
> > > > as a separate and squach "Misc Fixes and refactor" to my changes in=
 V3 if you
> > > > don't mind.
> > >=20
> > > Sure, that's what I meant: include my general extended fixes at the
> > > start of your series and just squash the misc_fixes (additionally fix=
ed
> > > by you :D) in your series.
> > >=20
> > > A small nitpick I noticed later in scmi_protocol_ops Dox comment
> > >=20
> > > + * struct scmi_pinctrl_protocol_ops - represents the various operati=
ons provided
> > >=20
> > > should be
> > >    * struct scmi_pinctrl_proto_ops
> > >=20
> > > Thanks,
> > > Cristian
> > >=20
> >=20
> > Hi Cristian,
> >=20
> > Thank you very much for your help and your patches. I'm in the finishin=
g
> > line with V3. I'll send to you the unit tests (when I fix them to work =
with the
> > latest changes) I'm using to test my changes and driver for ATF.
> > Hope it will help you to test your environment.
>=20
> Is that ATF driver available somewhere?
>=20
> Thanks,
> Michal
>=20
>=20
Hi Michal,

I've posted a link in the v3 series. But be aware it's not ready for
upstream so may be a bit ugly.

Oleksii.=
