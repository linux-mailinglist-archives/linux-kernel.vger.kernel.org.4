Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 169B9700291
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 10:38:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240204AbjELIiZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 04:38:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233460AbjELIiX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 04:38:23 -0400
Received: from mx0b-0039f301.pphosted.com (mx0b-0039f301.pphosted.com [148.163.137.242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF7B52D48;
        Fri, 12 May 2023 01:38:21 -0700 (PDT)
Received: from pps.filterd (m0174682.ppops.net [127.0.0.1])
        by mx0b-0039f301.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34C6Qd8u025420;
        Fri, 12 May 2023 08:38:10 GMT
Received: from eur02-am0-obe.outbound.protection.outlook.com (mail-am0eur02lp2238.outbound.protection.outlook.com [104.47.11.238])
        by mx0b-0039f301.pphosted.com (PPS) with ESMTPS id 3qgpqddu4v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 12 May 2023 08:38:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pze8ULfWMVXs3zuJKX/+eVsuR9RmRIj/SMmIM30QHpnNZYwwm3cgAPkTfjVUJ/HoustKBPsRCr3iUE2cLeAHiBqqpVs1EWIZb3RDrkvWyIHFQB9ULb1zjm5BIh70pvdj5u8b8mtItgrZS0mhUXklBAWBaxnTKBolHpIXZ9wLqxpsyq34oUu4o/r5bBJp5q/ukTIQC+IoePJxESzG0jfXpQ2Y9OlVqDpyKaUo7oF/dePCZrsW+bIX2mz2UYCXqTx8vNNkScFmbnqygiyzk8Lh0+FY9L96VE2Ew05zUR5ODtuyld+k0DmmTgW5+/nGHphFZPR7rIqMdR78AFjvO08ImA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qRTXVkaOrrSBhrhNsMz2zOATDoRBMEkDRRlXmr+1juY=;
 b=BpVzGCG8M6HS1BU4QOFd39rqXNr/KxE3dQ6Os58XGGifZxfF1hr58dRUmweyRf0S2oa89ItR271jnWpUY7pHpBiZgx/ndD2yAKaxMzHBXMQtNzyXxhqMl14GOAO+nxJA3piD4SoFxHGHPEiEfcFqu4iLuVmVHPsbaWRmGY3uXOrd+dtr87Ggbh/KxXVEZ58RHF50AVJyPnhuAilvnqvHuZqopxtlilmp4Zv/BBf0ya2mUZ53xgadI/KVal/ap6IX7XUmLWL2UFJNCeh80k9A90g2ZvmQq2XDCNnWKAyNm8auGliGXiUXU2ErkMMKQsvRqUnxBnc6fvJi5Ybe1EzRkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epam.com; dmarc=pass action=none header.from=epam.com;
 dkim=pass header.d=epam.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qRTXVkaOrrSBhrhNsMz2zOATDoRBMEkDRRlXmr+1juY=;
 b=aOuY4XEN8evDCg3SY9zL9PZpsbwDZiJmcD7m3A/zMp4Is29HzRt1FylM7nfpMHrjyfnD9StkH4LF7jwVjWm4gsMr+NTA3vSErlmRwmA9NpjQ7qutNIMx5Jw/SBKbv7P/h3noGwahTEN75026Xj+/POzfLxbRb/RHVQIwyowIWWCN9KAyaQ/TG3m4Nbsk0UEDwFK2KP9H+5oHLUFXIqQFRU72DedxNjO33Zw8a6qYRT3EhYCFRCIgPqKbCTpIFD+erWjnG6T2J2vhve7hrQahsuQuFRPNm96TRTtOZwLrXZfXv0iCh86FDGwCg/njvdiTWmJkbis7DxHDTZc9FH0+zQ==
Received: from PA4PR03MB7136.eurprd03.prod.outlook.com (2603:10a6:102:ea::23)
 by AM9PR03MB7443.eurprd03.prod.outlook.com (2603:10a6:20b:2de::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.20; Fri, 12 May
 2023 08:38:07 +0000
Received: from PA4PR03MB7136.eurprd03.prod.outlook.com
 ([fe80::bcf5:cd14:fd35:1300]) by PA4PR03MB7136.eurprd03.prod.outlook.com
 ([fe80::bcf5:cd14:fd35:1300%4]) with mapi id 15.20.6387.021; Fri, 12 May 2023
 08:38:06 +0000
From:   Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>
To:     Cristian Marussi <cristian.marussi@arm.com>
CC:     "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Peng Fan <peng.fan@oss.nxp.com>,
        Michal Simek <michal.simek@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
Subject: Re: [RFC v2 1/3] firmware: arm_scmi: Add SCMI v3.2 pincontrol
 protocol basic support
Thread-Topic: [RFC v2 1/3] firmware: arm_scmi: Add SCMI v3.2 pincontrol
 protocol basic support
Thread-Index: AQHZeEK6SX8vcPOUbkqIYZzlwR9d3a9MJZqAgApEBIA=
Date:   Fri, 12 May 2023 08:38:06 +0000
Message-ID: <20230512083805.GA3424996@EPUAKYIW0A6A>
References: <cover.1682513390.git.oleksii_moisieiev@epam.com>
 <b4d60f3408f8fe839933fa3938ecdc9bfceb75d7.1682513390.git.oleksii_moisieiev@epam.com>
 <ZFVeY3jVNfAkW1G9@e120937-lin>
In-Reply-To: <ZFVeY3jVNfAkW1G9@e120937-lin>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR03MB7136:EE_|AM9PR03MB7443:EE_
x-ms-office365-filtering-correlation-id: 19d08c19-902a-41fc-4a93-08db52c43554
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Hem2hGT657TMaEoDcz2jOGhP5rx/sszYC39EnTlKBiqUjeilhTaD9+Iu1tDtutmVO4bX0ejHewkyVILBocWy7uYMQaeMvqiW2NLPhGGFf9416p+369j2iPM+IjIeAIp2R3j+r6cvun+dvXHrn7w8Vd3kz+59SjWRsOH1COpepZ/GHguZPmLfA6kb7uV7aEpSaDrHpr7jpsomMoJj8nngWdzXv7RKzFGiokZy4f/jRM/Tm7aOZ9nrrCQ1TiBL10kyhqB+/DTsWDY6VhqOV9fpa49hvLpcUVlzwvSkBjy79RAlA6m4qhjR7cLEkaLD8q2oXWroc0lC2o0CCDaOJMzA4TTiNaQFqU84bV+0490Hun75CBoeaTSys3hD53lgZd/I+vkcwLusntxe36B6FlU9JiIjlyMrf2kbXqob4WKqFwyw3nbvaTsNYlBcDai4SPuahguCcfPXmDhbONTq+SUuKUNi/ExxZaaQLK7cH3JYrH61G4HKoRlfgFFn7fksFPwLGLUerLymx27pQYGvol55E54vT5aDWmjZC6eieN3AXoCsp621U5cq7GfjU/AiUiCWMXQBXUCabc7rKGxrrVK0s4zwGQuwOYMuJs4BLdhJTc5yN4+ZbhXupRyr07je8JPJ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR03MB7136.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(7916004)(39860400002)(136003)(346002)(396003)(376002)(366004)(451199021)(6916009)(316002)(54906003)(478600001)(91956017)(86362001)(6486002)(76116006)(66556008)(4326008)(64756008)(66946007)(66476007)(66446008)(83380400001)(33716001)(8676002)(41300700001)(122000001)(33656002)(8936002)(38100700002)(38070700005)(26005)(71200400001)(2906002)(186003)(6512007)(1076003)(6506007)(9686003)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?zIPU3UQnxT4PqB5UxDUI7NrwEZjR/LVkBf9qP7RmdXBEVJnhNn7l1ybJoJbp?=
 =?us-ascii?Q?0ApyxV06nuenfsnYxN/jrLLtPck2d3L6rwyXdcj0TekmjYCqOCul09lTiEPr?=
 =?us-ascii?Q?e4OaR0DtvcjssYHzLKuPHi+c6XrqBnT7Ioim5KGp/gAnRS9qyaDyH3HaDT5n?=
 =?us-ascii?Q?8Q83KD2Fj4fosApqIyzQ0K12/5fPBc5N4oc1/UWRqFsfW+ikMYPEJxUgzHzo?=
 =?us-ascii?Q?pAmmFJ8Bi+4ewZqJ8HVV1W/yQwcFRCFeELTHc7GnSmSkuo3DBBGL5VAAah3G?=
 =?us-ascii?Q?tDFCD59V1LdM0l6HafpkBYfNB/RQjmTNt1Qjb/xnIZlFzALSYnj8v3Pu6lmD?=
 =?us-ascii?Q?585Qhd/79U0lUnywue6NsRT6VuMs3kDtLYcRj2Gw+hWwUKE2dk77m/J4bn+p?=
 =?us-ascii?Q?0Kgf9ORbFm0sP26LFprd1ywfdS4jGqJPEEurIr6VYK+VsiIDX27WqzBp4fha?=
 =?us-ascii?Q?thTQJarHGzwkfO8jBqFltXYuEQQ03HSItvJ9oTM/UAA6Y/eEqop4HXlKRxLw?=
 =?us-ascii?Q?smS0iqYiYhajLcvf0TApLZYgnrORWjfJRYTX/GNnbK/q4GWHS9343cbscOwa?=
 =?us-ascii?Q?reN9SxTWlU6NRQKRFiirO8vwLm7fVawOUzZ9fCW4krxKGVEoJEgOuiSmwsQG?=
 =?us-ascii?Q?FE48EaNxwRqecnSUWkPS/UwOp0vVpqN/1g1mdy2p4nZN5lBKdyms4iw7qDqo?=
 =?us-ascii?Q?zTq+qTkXpsTYqGLdfiG7NODdbovs8ZP0Y9CvGF8oDz5BLUVUYnJRN68hXJP/?=
 =?us-ascii?Q?eaVO7y/E0SNPnrrSgqe2tXd0T1AjeOSZcTZxbJ4z5hZOE2U0p8K9l7BAeCOv?=
 =?us-ascii?Q?xGZd3YjBGJaZr7Vlkk2ErCPnPn40nOFNg324ctWxMh1Udw7JAqvFRV+f7+g4?=
 =?us-ascii?Q?fSGBu+ydXT5RVJaPn6batltAqJu1QbYtXcUxK5qMnjN88gCajPJUcWalntuJ?=
 =?us-ascii?Q?KxxhCQ3zQFoq83IeF3KgLxgbq42t79kcsjR40MFkINDcujpCTNSvMbt2hxlv?=
 =?us-ascii?Q?xU3ystJMgUsVCoO9v4JrL5+xlbUlK8TCAfxvWtnofzgadfhzrQ+AGbrNBuqW?=
 =?us-ascii?Q?EryzClw4hfBUUnoXmIS6L6qAt3QxnJumS7KhXVGP3XJ0hGrtu8bC47d7GhhE?=
 =?us-ascii?Q?mz3ZlpN53aOKhlIm2+OHHG0KdBRyoDRncrDVCQvLon6durwAG3SmBQPbfzKW?=
 =?us-ascii?Q?JzsBZ2yEId+VvnWDq9ojkEKMgBOgAfMVcmSuYAfwTgNE8RXJckPCAxAi2PEa?=
 =?us-ascii?Q?Nsn4vSy0uNujr06Pr8hCk9eG65+w/CtZkAQN2dXsnqkghA4qyV/db1RLhcTQ?=
 =?us-ascii?Q?xNKzY2rE2Ep6AQg1NxVwFpgpJhpLYcQsEgvvP40p5NVb5vIw4U+w2VuzypCD?=
 =?us-ascii?Q?Tw4GLKPmMUj2VJ3QmJKF6fsgunPyi2pbtgFLCIryqIqL6P+UekRORYnZYhsq?=
 =?us-ascii?Q?+IaYaKS0XLa21jQSHy7GqSzo+sI924XABfqAYWGKQWoFXMHfwFsothQhRdw6?=
 =?us-ascii?Q?G+bxMaSgMjje6P4GT3YiLsdHl+riWHNyIALpJlkl1HHhmwMcwuXf8T3s3NQs?=
 =?us-ascii?Q?f80FnyVaw3frXd+oe/EK7IzRIs+pyPBFzga5aIULFFTuI46ysP6EISbNaHDJ?=
 =?us-ascii?Q?Gw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <BC0EBB552B7F2D43A0E6CCB1E0E5CF2F@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR03MB7136.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19d08c19-902a-41fc-4a93-08db52c43554
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2023 08:38:06.4455
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1EhACI63Go7ontxaxxsTW6MQoujeGMHf5hUEr68WUgA/vZfANtU95IETiyIUyvCXNLEE0ZjVZcCS2vxRj2b5COmc5rUMobO8xVGQ1vN388M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR03MB7443
X-Proofpoint-GUID: 7Mvs4snPXURI6vUKt2duy-L_8J6ZPpyn
X-Proofpoint-ORIG-GUID: 7Mvs4snPXURI6vUKt2duy-L_8J6ZPpyn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-12_05,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 mlxlogscore=999 phishscore=0 spamscore=0 priorityscore=1501 malwarescore=0
 bulkscore=0 adultscore=0 mlxscore=0 lowpriorityscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305120072
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 05, 2023 at 08:52:03PM +0100, Cristian Marussi wrote:
> On Wed, Apr 26, 2023 at 01:26:37PM +0000, Oleksii Moisieiev wrote:
> > scmi: Introduce pinctrl SCMI protocol driver
> >=20
> > Add basic implementation of the SCMI v3.2 pincontrol protocol
> > excluding GPIO support. All pinctrl related callbacks and operations
> > are exposed in the include/linux/scmi_protocol.h
> >=20
>=20
> Hi Oleksii,
>=20
> Thanks for this.
>=20
> I tried out this in an emulated setup and found just a minor issue from
> the spec/functional point of view...then I reworked the extended names
> support using a modified hops->extended_name_get helper (as said the core
> SCMI support needed a small modification to support PINCTRL): I'll reply
> to this mail thread with such core SCMI modification patch, so you can
> include this patch of mine in your next V3 and use it in your series.
>=20
> Moreover, given that I wanted to test such rework of mine and a bunch
> of other cleanups I did (as detailed down below), and it seemed silly
> to throw all away just to then having to detail all to you, I'll also
> include in another distinct reply the raw diff of what I changed in
> your series to use the new extended_name support and a few other cleanups=
,
> so that, if you want, you can just quickly merge that into your V3 patch
> (of course if you like it and tests fine also for you...)...these are
> small changes, if you take it, no need to bother with authorship and
> attribution from my point of view.
>=20

Hi Cristian,

Thank you for the patches. I've applied them and tested with powerpc,
mx68 and clang environments (as test-robot complained about).

> > Signed-off-by: Oleksii Moisieiev <oleksii_moisieiev@epam.com>
> > ---
> >  MAINTAINERS                           |   6 +

[snip]

> >  SYSTEM RESET/SHUTDOWN DRIVERS
> >  M:	Sebastian Reichel <sre@kernel.org>
> >  L:	linux-pm@vger.kernel.org
> > diff --git a/drivers/firmware/arm_scmi/Makefile b/drivers/firmware/arm_=
scmi/Makefile
> > index b31d78fa66cc..071ac65f22b9 100644
> > --- a/drivers/firmware/arm_scmi/Makefile
> > +++ b/drivers/firmware/arm_scmi/Makefile
> > @@ -3,6 +3,7 @@ scmi-bus-y =3D bus.o
> >  scmi-core-objs :=3D $(scmi-bus-y)
> > =20
> >  scmi-driver-y =3D driver.o notify.o
> > +
>=20
> Do not add spurios lines.
>=20

Thanks, removed

> >  scmi-driver-$(CONFIG_ARM_SCMI_RAW_MODE_SUPPORT) +=3D raw_mode.o
> >  scmi-transport-$(CONFIG_ARM_SCMI_HAVE_SHMEM) =3D shmem.o
> >  scmi-transport-$(CONFIG_ARM_SCMI_TRANSPORT_MAILBOX) +=3D mailbox.o
> > @@ -10,7 +11,7 @@ scmi-transport-$(CONFIG_ARM_SCMI_TRANSPORT_SMC) +=3D =
smc.o
> >  scmi-transport-$(CONFIG_ARM_SCMI_HAVE_MSG) +=3D msg.o
> >  scmi-transport-$(CONFIG_ARM_SCMI_TRANSPORT_VIRTIO) +=3D virtio.o
> >  scmi-transport-$(CONFIG_ARM_SCMI_TRANSPORT_OPTEE) +=3D optee.o
> > -scmi-protocols-y =3D base.o clock.o perf.o power.o reset.o sensors.o s=
ystem.o voltage.o powercap.o
> > +scmi-protocols-y =3D base.o clock.o perf.o power.o reset.o sensors.o s=
ystem.o voltage.o powercap.o pinctrl.o
> >  scmi-module-objs :=3D $(scmi-driver-y) $(scmi-protocols-y) $(scmi-tran=
sport-y)
> > =20

I've applied patches you provided and made a small fixes. I'm going to
make patch:
"firmware: arm_scmi: Add optional flags to extended names helper"
as a separate and squach "Misc Fixes and refactor" to my changes in V3 if y=
ou
don't mind.

-- Oleksii=
