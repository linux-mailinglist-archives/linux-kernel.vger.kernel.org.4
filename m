Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 396CB700846
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 14:43:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240727AbjELMnG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 08:43:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240360AbjELMnE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 08:43:04 -0400
Received: from mx0b-0039f301.pphosted.com (mx0b-0039f301.pphosted.com [148.163.137.242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFE121701;
        Fri, 12 May 2023 05:43:02 -0700 (PDT)
Received: from pps.filterd (m0174683.ppops.net [127.0.0.1])
        by mx0b-0039f301.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 34CAj2st001140;
        Fri, 12 May 2023 12:31:03 GMT
Received: from eur05-db8-obe.outbound.protection.outlook.com (mail-db8eur05lp2112.outbound.protection.outlook.com [104.47.17.112])
        by mx0b-0039f301.pphosted.com (PPS) with ESMTPS id 3qhfqm1jxp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 12 May 2023 12:31:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CtE32tiyxazSnM2SQgGKcuwpkG9wleiritUrtoctUW8mvDlxahS3F2T+r7XRAvMRNJg4mnbokc+Si+RA3FOgyxe1/0rVxMa5KAtfGnbySvnS7DppsMzvFRvdWVxS74w8Jbf/krJbLjzRNkpQsUWzkF88fsxOIIPzvfeDq15AE1KukGrbgK/i6yxfvfCmP6pfWOqtz2O7cSkVnDaFafSe7S+w/0OjHdPtyEGOtGJxCTSyw6SXJEVVa4jrVhe5fd6D2YnbmCxNcJAFR6y67bVbSI4w3y4AB3EfChdk9Y44HZAHuT3hgtdSVn5X+2rm3QN71lAUdptCvYzoXxkW4WrzRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aO2I6SdqWbYCGnGpLkgT/FpWbhR2EKaFGv42c7Ns5FI=;
 b=SiCXIKzvcahh1qBgnqdGU2OH+URq5YUemsp62HlUKpjj/nTZIZ6gAYqYuY+PzFlsGejsAnktzFKdATGqpkYBMJzVO+fSLRk/MQXObcPdiD2FtRIQ4C36Rgw5TdD2JEIxzunEVBsn487o6vGeBu0eK8iNVRbToDXRrBltWB9MKCbIALz4y3NnXJQtuCZTweUc/DyEgSKJ7MlRxLvnTtiFUX8FfML4gVUkOBP6x2Ayx3hTviBQC5H8moUjVFKZRjN+9D6G9qvLB8jHFUgx2cISKUz6E4b3notBPBBSsvKVLEWrZ2RomNM7e2KZBBMJGHBsqUzlyqOBggtIjPgLXrY4hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epam.com; dmarc=pass action=none header.from=epam.com;
 dkim=pass header.d=epam.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aO2I6SdqWbYCGnGpLkgT/FpWbhR2EKaFGv42c7Ns5FI=;
 b=Tin83iJ3Dh3p8xxHD8EnggMTQWp8mQM+yKKdVGTpoPSWicay4D6rpQPjaFj/kIIHdpigvXoxyp7RMjUDmGqpbzgVW01oYoDaPCmYR4wcD7FZ9xGSUHZsGmjpKbLvfsRQYlrdi3SRjbOUw8HVrbyM9a3j6vRLLo2l/nZX8Ps96/8n3M65HcRAuIKi5HxCebXpCjrzxal5qaCNEgrq/XDY746SsRFNz9AoWYV8ZvYkJ3qqm3lUM95Vel1oZPphN9EmW5YpJfr3NqVxzLUP4n43NR6Cu/jia7YLSL03XYVx678c6AZIVkDBbXcW+cH3PKS/dwwalYHWaprYKVzzHKJNcA==
Received: from PA4PR03MB7136.eurprd03.prod.outlook.com (2603:10a6:102:ea::23)
 by PA4PR03MB6848.eurprd03.prod.outlook.com (2603:10a6:102:f2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.20; Fri, 12 May
 2023 12:31:01 +0000
Received: from PA4PR03MB7136.eurprd03.prod.outlook.com
 ([fe80::bcf5:cd14:fd35:1300]) by PA4PR03MB7136.eurprd03.prod.outlook.com
 ([fe80::bcf5:cd14:fd35:1300%4]) with mapi id 15.20.6387.021; Fri, 12 May 2023
 12:31:00 +0000
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
Thread-Index: AQHZeEK6SX8vcPOUbkqIYZzlwR9d3a9MJZqAgApEBICAAAT5gIAAPBmA
Date:   Fri, 12 May 2023 12:31:00 +0000
Message-ID: <20230512123059.GA3497038@EPUAKYIW0A6A>
References: <cover.1682513390.git.oleksii_moisieiev@epam.com>
 <b4d60f3408f8fe839933fa3938ecdc9bfceb75d7.1682513390.git.oleksii_moisieiev@epam.com>
 <ZFVeY3jVNfAkW1G9@e120937-lin> <20230512083805.GA3424996@EPUAKYIW0A6A>
 <ZF3/Ge4b+49ni+e6@e120937-lin>
In-Reply-To: <ZF3/Ge4b+49ni+e6@e120937-lin>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR03MB7136:EE_|PA4PR03MB6848:EE_
x-ms-office365-filtering-correlation-id: ceb7863d-6b19-4365-48ba-08db52e4beb1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: O+cEnTEWfBK9fgjEIgHZf7+ww5f3qI247xVKsGBsX4FRrX9wzsMBQb5EI+okKpEdC+YPe6P4umkXbgmYUcM5ncPpQxH6Haw4R6vcM+uWgGQgBpV4qGEnQbhgOzYtvcIarbqRW1oVF3ONXv560/OCeXdi6VnHW6k60AUq5a7mrq+pjvZgV8ievytlWgoJT2H58u4rhcZAfd9ouq+bEMDkCjgNmuwKKhG2fBwPQmYkNovqTXTDy7DHpbt7HYY2/d1G91X7V2NJRzHDCBPPJBMKn3dS5/s6DQdVW1DyYI6uxVwv2yZQPTeqcIpx+/P10n8FELoyJb/fEyfnAGwK9DCc6JwSeLhN/cikxXaOPF6PnKwH57IGr6+mkQwwxxSllaadhfVZCFbQDCr9pghx+385w59OzQ8dA4OIc7MxZYmrXHBxjq/yStjDoCRpW2EqfGgQ8t9tPH3GLqN9soOSXL/5zIahbx/Pge9UhXx1ICe8x2YawSHKWgcgkK3v3pVcRG8ttUoVPIn/bvYp3CVjQrRZeW1B81OGjgXfTHjKfSRapBA5nl+zsAsWAXz8NrI+pZClMuOcdbmiYcfTNeOul9TOJgGCvpWTNTNHiNQtAS48yPCVod83qRe4Mg3eg2GgjR7A
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR03MB7136.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(4636009)(346002)(136003)(376002)(366004)(39860400002)(396003)(451199021)(6506007)(86362001)(83380400001)(76116006)(91956017)(478600001)(54906003)(5660300002)(4326008)(41300700001)(33656002)(8676002)(316002)(2906002)(6916009)(66946007)(66446008)(64756008)(8936002)(66476007)(66556008)(33716001)(9686003)(6512007)(71200400001)(1076003)(6486002)(38070700005)(26005)(122000001)(186003)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?f089g+hUqd3igRGvrEMFTWnHFvkaPwBWrEHsXOcnZdM0fZbWv332zoV5OyNE?=
 =?us-ascii?Q?4f+qE5bH9pHJUJyAXOaK+IcTJNKijd57zYoqEWBd3PN8i/r01BNJROhE7tAy?=
 =?us-ascii?Q?/hA7sOhkw3kfJ8/u9ZImtocEnZcGlZ2F0dK989MFB4Ok1GNptyaEbo0SR/d2?=
 =?us-ascii?Q?g1PQAQHkrk0jsKVeFjhKZtEpFVrObuwc//Z1r23V0q76hJWcYD6efI7kuwU/?=
 =?us-ascii?Q?XAt1JtozDK/u3Qbjik/UKHReUWRdG3uf3Swxg6mhtSfIvK6xuHj0ieMB+G16?=
 =?us-ascii?Q?/mi635HzM9aTd2jorw1U7slJk0oqqd0V8jsZPdU6x6YE70+D8uEzxNwSqosZ?=
 =?us-ascii?Q?OUW9i28BvJIr/2B8+Vy4On5K1QK/FOT411j6/L71wQAqQlpgyEClrzcOwvYH?=
 =?us-ascii?Q?Q0KHr60dsSymmwzpAt66KGt/5Qm4PEU5bRl/lUSK9tWPWcCUztRczD1EaR+C?=
 =?us-ascii?Q?+R8g9ZLwFJ2BZifLURNH2SJB9HgToTJDHtqBJwTR+6YMaNNPVF86FtKEQZ3a?=
 =?us-ascii?Q?JrkNxSuIbFPEoCyQ/JBy8ohn7oa6lDP/jABEm2MNyOnk2ivXPHbLOjbqStYu?=
 =?us-ascii?Q?Kg2vrUdnZwIYcpbD9C2NoMjFWIPjHJA+oo1lxBz5mMBNXtBQI2JSM1cJaEk7?=
 =?us-ascii?Q?pGJqlEwG5pkjPPlFNmd68vvIUkqmLXrd7W1FWBAV19mXPn81Wri8eIzrX1wC?=
 =?us-ascii?Q?X/Tyy8tAcwHa6XDgK2bme/2jEmtbOcYRLl4Pftm350F5QDWxYbxyeJKPB6+0?=
 =?us-ascii?Q?OcFmYlrtSTduQFaIsChPQ3cFgH1COUXLUPJdSt1ITxuSZovYHbY/HOEFWxhp?=
 =?us-ascii?Q?BtpJ85QhANUgOVJiTJXaNWe2GvBn72p2Nvr0wACjP1Ob+LMbjvY5ACJmvnRJ?=
 =?us-ascii?Q?pWLzJlzF9HxYNIcfiHV2eN51VrIU8ZzshFp0dffokPWTDmnmxkdowhg6gAqf?=
 =?us-ascii?Q?9nSDB4ZUOflVIS4qd0eddu9MAtnRlTbCQgpdZvNFMUQeu+lf/7/4NixcRmJp?=
 =?us-ascii?Q?kyfEmdb2lAVfk3woS/dtRrjcx++qaniTf2qwfe9+mAp8QqKc2mqMRu5Ktli4?=
 =?us-ascii?Q?cTE4W83KOwK6q07JpB9aDJ7UXvs0PlssS8DkQ41OcjqqlDiW9xAmC139aGI7?=
 =?us-ascii?Q?N2r5Cdd+Ak4kBYGcTy5VcrGwVeL+82b4ZvX4JrlueHSmJK0h4IqtGrOH/MHu?=
 =?us-ascii?Q?+ss0Yo8Ant6MrlLEOOasbxJ3+4ZDzVpjdyezlNo/4ksxY546tBdyjPVrR9jj?=
 =?us-ascii?Q?wqjJLCFY/5S9fGG8Z4CteDYT7Vs/FYea4V0rfso41K2mTqQ7hBhabDYjl6CW?=
 =?us-ascii?Q?C7ieK93L17tURduU7m+17YsZFCgBxTTADhOpOnRDMwJl7kLZvAikQ8GF54V9?=
 =?us-ascii?Q?fxz+G3ojU+D4AWnPJaSouSzUB3zEDjWqM/+6PIGaG++XTO+h4mt/SNthUX63?=
 =?us-ascii?Q?gNq+eETchLCK9Lg2fsuYoo5b2jr0pTH1iDmksR5L5eUYhQRCg+i5rlZLKF8Y?=
 =?us-ascii?Q?ZmhZza5K1GYiepFuxc/FLMRxq6VEf1QbczWLjqgAH2c7homsb6XO1i9C3mX0?=
 =?us-ascii?Q?W1HGUQ0FwVxV9fV8Idu/u3957hJo3C3a2THwVzVK/gr/GTuLXCFf45GZNOaI?=
 =?us-ascii?Q?Aw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E9F70458B700F14FA33B34FEFAA860C7@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR03MB7136.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ceb7863d-6b19-4365-48ba-08db52e4beb1
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2023 12:31:00.8110
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4FneXLEp7bSm7fF0izCZ6c2LqwIs/wYxLfLJj+jNnwRp0b4VveR1A5KmRlllXnb3XkCsxe//CdRVWURzkWNWfW+VxCtWdX/B73Q8LqlE2B0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR03MB6848
X-Proofpoint-GUID: TTT4CF6RRQWhQaMzgFRjA9eN3LCquyjH
X-Proofpoint-ORIG-GUID: TTT4CF6RRQWhQaMzgFRjA9eN3LCquyjH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-12_08,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 suspectscore=0
 impostorscore=0 bulkscore=0 priorityscore=1501 spamscore=0 clxscore=1015
 phishscore=0 mlxlogscore=999 malwarescore=0 lowpriorityscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305120104
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 12, 2023 at 09:55:53AM +0100, Cristian Marussi wrote:
> On Fri, May 12, 2023 at 08:38:06AM +0000, Oleksii Moisieiev wrote:
> > On Fri, May 05, 2023 at 08:52:03PM +0100, Cristian Marussi wrote:
> > > On Wed, Apr 26, 2023 at 01:26:37PM +0000, Oleksii Moisieiev wrote:
> > > > scmi: Introduce pinctrl SCMI protocol driver
> > > >=20
> > > > Add basic implementation of the SCMI v3.2 pincontrol protocol
> > > > excluding GPIO support. All pinctrl related callbacks and operation=
s
> > > > are exposed in the include/linux/scmi_protocol.h
> > > >=20
> > >=20
> > > Hi Oleksii,
> > >=20
> > > Thanks for this.
> > >=20
> > > I tried out this in an emulated setup and found just a minor issue fr=
om
> > > the spec/functional point of view...then I reworked the extended name=
s
> > > support using a modified hops->extended_name_get helper (as said the =
core
> > > SCMI support needed a small modification to support PINCTRL): I'll re=
ply
> > > to this mail thread with such core SCMI modification patch, so you ca=
n
> > > include this patch of mine in your next V3 and use it in your series.
> > >=20
> > > Moreover, given that I wanted to test such rework of mine and a bunch
> > > of other cleanups I did (as detailed down below), and it seemed silly
> > > to throw all away just to then having to detail all to you, I'll also
> > > include in another distinct reply the raw diff of what I changed in
> > > your series to use the new extended_name support and a few other clea=
nups,
> > > so that, if you want, you can just quickly merge that into your V3 pa=
tch
> > > (of course if you like it and tests fine also for you...)...these are
> > > small changes, if you take it, no need to bother with authorship and
> > > attribution from my point of view.
> > >=20
> >=20
> > Hi Cristian,
> >=20
>=20
> Hi,
>=20
> > Thank you for the patches. I've applied them and tested with powerpc,
> > mx68 and clang environments (as test-robot complained about).
> >=20
>=20
> Yes, sure, they were just tentative fixes, needed cleanup.
> I forgot to add the RFC tag on my proposed fixes to avoid triggering the =
bots.
>=20
> > > > Signed-off-by: Oleksii Moisieiev <oleksii_moisieiev@epam.com>
> > > > ---
> > > >  MAINTAINERS                           |   6 +
> >=20
> > [snip]
> >=20
> > > >  SYSTEM RESET/SHUTDOWN DRIVERS
> > > >  M:	Sebastian Reichel <sre@kernel.org>
> > > >  L:	linux-pm@vger.kernel.org
> > > > diff --git a/drivers/firmware/arm_scmi/Makefile b/drivers/firmware/=
arm_scmi/Makefile
> > > > index b31d78fa66cc..071ac65f22b9 100644
> > > > --- a/drivers/firmware/arm_scmi/Makefile
> > > > +++ b/drivers/firmware/arm_scmi/Makefile
> > > > @@ -3,6 +3,7 @@ scmi-bus-y =3D bus.o
> > > >  scmi-core-objs :=3D $(scmi-bus-y)
> > > > =20
> > > >  scmi-driver-y =3D driver.o notify.o
> > > > +
> > >=20
> > > Do not add spurios lines.
> > >=20
> >=20
> > Thanks, removed
> >=20
> > > >  scmi-driver-$(CONFIG_ARM_SCMI_RAW_MODE_SUPPORT) +=3D raw_mode.o
> > > >  scmi-transport-$(CONFIG_ARM_SCMI_HAVE_SHMEM) =3D shmem.o
> > > >  scmi-transport-$(CONFIG_ARM_SCMI_TRANSPORT_MAILBOX) +=3D mailbox.o
> > > > @@ -10,7 +11,7 @@ scmi-transport-$(CONFIG_ARM_SCMI_TRANSPORT_SMC) +=
=3D smc.o
> > > >  scmi-transport-$(CONFIG_ARM_SCMI_HAVE_MSG) +=3D msg.o
> > > >  scmi-transport-$(CONFIG_ARM_SCMI_TRANSPORT_VIRTIO) +=3D virtio.o
> > > >  scmi-transport-$(CONFIG_ARM_SCMI_TRANSPORT_OPTEE) +=3D optee.o
> > > > -scmi-protocols-y =3D base.o clock.o perf.o power.o reset.o sensors=
.o system.o voltage.o powercap.o
> > > > +scmi-protocols-y =3D base.o clock.o perf.o power.o reset.o sensors=
.o system.o voltage.o powercap.o pinctrl.o
> > > >  scmi-module-objs :=3D $(scmi-driver-y) $(scmi-protocols-y) $(scmi-=
transport-y)
> > > > =20
> >=20
> > I've applied patches you provided and made a small fixes. I'm going to
> > make patch:
> > "firmware: arm_scmi: Add optional flags to extended names helper"
> > as a separate and squach "Misc Fixes and refactor" to my changes in V3 =
if you
> > don't mind.
>=20
> Sure, that's what I meant: include my general extended fixes at the
> start of your series and just squash the misc_fixes (additionally fixed
> by you :D) in your series.
>=20
> A small nitpick I noticed later in scmi_protocol_ops Dox comment
>=20
> + * struct scmi_pinctrl_protocol_ops - represents the various operations =
provided
>=20
> should be=20
>   * struct scmi_pinctrl_proto_ops
>=20
> Thanks,
> Cristian
>=20

Hi Cristian,

Thank you very much for your help and your patches. I'm in the finishing
line with V3. I'll send to you the unit tests (when I fix them to work with=
 the
latest changes) I'm using to test my changes and driver for ATF.
Hope it will help you to test your environment.

Best regards,
Oleksii.=
