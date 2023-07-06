Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2697749EA4
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 16:10:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232984AbjGFOKO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 10:10:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232257AbjGFOKM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 10:10:12 -0400
Received: from mx0b-0039f301.pphosted.com (mx0b-0039f301.pphosted.com [148.163.137.242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2E5CDB;
        Thu,  6 Jul 2023 07:10:09 -0700 (PDT)
Received: from pps.filterd (m0174682.ppops.net [127.0.0.1])
        by mx0b-0039f301.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 366E0Vvu031766;
        Thu, 6 Jul 2023 14:09:42 GMT
Received: from eur05-vi1-obe.outbound.protection.outlook.com (mail-vi1eur05lp2169.outbound.protection.outlook.com [104.47.17.169])
        by mx0b-0039f301.pphosted.com (PPS) with ESMTPS id 3rny0er279-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Jul 2023 14:09:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BCe9en5N2lNkd20egNuNgUJtlZGrhfjnu2BNSsobH9bBwR43BF9xKT2SINVW5+QbcdztZiGMFPdMmebGu7XE5vchiBXaDedJyODLnY0+1J+17n8FenZ/dXY5DVkkXYN2FuXpoE2NmSfYV//XbPUKeNIGvURdybQOBcV+cxjrW52a81slnbfuyHPnDmuHOLiMPR0EmrtJjjhL2kIeekQ7obiG4ycH4WyM/s9hjzqKSbJCqLEDenQEBk0ujIYpteAb44L8AhmGEg+WiVbOK/+whc1E8bGWtvWxDzShSfM/DoFK16KdIf6vgPOB1THpBhLHt7l6AXEaikG27pislSljxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GY8mImJXfkmcapswyyAMxgzjb9XQChNvbX9RBJj4Npo=;
 b=nAIIA3qLGC6zb4Jo95NHQjrMY9Q87jKHFyFQlYahqQYyTLuRsIiqRgVN+/w4zOKHPSPCZC8JWZjNty+6ok87RSv29ygVHkoLJP8dkmrffV3mT6EPS3dZ8A6PilbNlcCGHfqtml9+8mUB97isHd3/uZYpy0slw5xUsxSxvNbjmfs6Gi8PIOwaTuFKrFwlSz6g4U9KWtSVn4cGTG2N8OE1q/hEWnEjq/7PqOUKhIeSGYP/w9jiEfGvPp6Xjqu78Q97cQL5YNZ1i8YAxN7R+/oIu+/2EzcsVr+5NEjyl9KAlINRMDuNsgCGfb1M/xLQjWXxJ2RftUYC0AA2X1JJITPtvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epam.com; dmarc=pass action=none header.from=epam.com;
 dkim=pass header.d=epam.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GY8mImJXfkmcapswyyAMxgzjb9XQChNvbX9RBJj4Npo=;
 b=EoleIk5Yn51MKNtrAu0zo7LgG/vKPK+ry8dIr6yVv0dYhhZjYm1IOwvdqLVuno/doiA2rJKoKgu7D2sWN9jgY1W5Q/pPuyRXBG80cF18chUjajCv419sGQtOqDTo2FppvDPwniI4WyT9rXzRPdILhxcr7Jv+N9+78o3awWBku7TKBLvaL0YgJOtg6ymbEejSVtF9AQ5+ghW0mFP7bvVQtslUfLXK7Ey8BNOwMrKU/yEvDGWwvATwHNCYiTGUMvZRnR2JGy4PoTEW2SZBvNsjoprjhL+gMBetTdMoHl4FrIRk+mLglwTB6k/BpH9fI+6+eCfmZ6X2SMLvgkqh/srutg==
Received: from PA4PR03MB7136.eurprd03.prod.outlook.com (2603:10a6:102:ea::23)
 by DB3PR0302MB9157.eurprd03.prod.outlook.com (2603:10a6:10:43f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Thu, 6 Jul
 2023 14:09:38 +0000
Received: from PA4PR03MB7136.eurprd03.prod.outlook.com
 ([fe80::528d:e0b6:ecc6:25e5]) by PA4PR03MB7136.eurprd03.prod.outlook.com
 ([fe80::528d:e0b6:ecc6:25e5%4]) with mapi id 15.20.6565.016; Thu, 6 Jul 2023
 14:09:38 +0000
From:   Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>
To:     Cristian Marussi <cristian.marussi@arm.com>
CC:     "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
Subject: Re: [PATCH v3 2/4] firmware: arm_scmi: Add SCMI v3.2 pincontrol
 protocol basic support
Thread-Topic: [PATCH v3 2/4] firmware: arm_scmi: Add SCMI v3.2 pincontrol
 protocol basic support
Thread-Index: AQHZmJMVZdZ9jTlnl0a4bbb/rGp54K+n/cyAgAT4DIA=
Date:   Thu, 6 Jul 2023 14:09:38 +0000
Message-ID: <20230706140937.GA821831@EPUAKYIW0A6A>
References: <cover.1686063941.git.oleksii_moisieiev@epam.com>
 <d388c7af3f72fd47baffe0de8c6fec8074cb483c.1686063941.git.oleksii_moisieiev@epam.com>
 <ZKKgD1QxF085kE+c@e120937-lin>
In-Reply-To: <ZKKgD1QxF085kE+c@e120937-lin>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR03MB7136:EE_|DB3PR0302MB9157:EE_
x-ms-office365-filtering-correlation-id: 579725a9-c1c6-4112-aded-08db7e2aa291
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0Wul8vBpFZRmr2nO3AgnJBohQsL5+30BPgR8xA61jPdkN5ucJTNi5Iaiabi5rgapgFfaN/8BwN3uo92PQQxKV/AYVEIqGXnOGG9C8MC9j0DUoUPCZuJ8GAfVP53zs85d4tCZlsS88dtWHtTkFOitKC+eGTwr7IdaPTdoQqWEZEPGBDWU4Hmfelyz+gK4IMvVv13GChlf6b9IFCjI7MRVms86guIFb4iTGvo8xvIXnCMKbbvPjDPBaUX1/bzLjG8A7STSAMg/HueDLXhL6mJ0j9X18hDXWBrOwirKaqVJWD4fHq7tuzleOEF102HMBwL/uxRa1jljhpyZSpz2962ZFVcBWd75LNdS1NTwRsrFs2XwaQfVMEf/DkbeLuQjklB793uDOWrE6/kbNF2vwDiF5SM+gcwj/pfIMm0wmRLmF/jD0gAgnHqf1P/4PIQt8fSvRejgGNBL18PszySdU07O8GyRadRmrRhgc6wlF3H78sHyEYpcz9PcDslKdOSIrvavEoAgtW4m7dIXz/VexFJpWc7Pckr9x1VoKGtZvWnu6ul8mtB6GgX6RrhN/KbV67aMEJbuhFvgmOY8OxUUSyjNDDlbgdJuTjK+hgjEI7hzisI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR03MB7136.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(7916004)(136003)(396003)(366004)(376002)(39860400002)(346002)(451199021)(66476007)(54906003)(478600001)(6512007)(1076003)(966005)(9686003)(26005)(6506007)(186003)(86362001)(71200400001)(6486002)(316002)(83380400001)(38100700002)(76116006)(4326008)(66556008)(64756008)(122000001)(66446008)(91956017)(6916009)(66946007)(5660300002)(7416002)(8676002)(8936002)(38070700005)(30864003)(41300700001)(2906002)(33716001)(33656002)(559001)(579004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3smjrsSqh92qP6ZGcviZIwn+UV3Tc1/Nysin88g2hxcMZx8NVAksgGNQ/ZGI?=
 =?us-ascii?Q?3tQWGXzmXa6RAJo8a7lvEccdyDrTcVePJW0ZupHFV4b0Jmaq7gG9o4wvBIpA?=
 =?us-ascii?Q?ZYmUU0xNIK/TBNiGVDkgxdviraLA7dhvWJThazClQTU4DInWI5EzLGWRI3mD?=
 =?us-ascii?Q?thWHAoJeLfwy0yRQypgEpnaIQ9xl/hceEHH+jlwLrIv4NGDyQ+Lo8oroKhsz?=
 =?us-ascii?Q?negYChHk7rXsjOQKCkyapiyhihhpGFxuFjIWhxB5H+5//Ndml/kJzgSbc2Dh?=
 =?us-ascii?Q?1mRWIl1xcN4lTyFgQU1YepM4PDRiB44nooMwYzfNFIf4OUnaJahtpp4HIgda?=
 =?us-ascii?Q?gNzjginM0egjqNgq7RUQHJI8+1Xhyk8Qvhjuk8CuvvwL6rGBLiTfUO2aC1GO?=
 =?us-ascii?Q?58A/jHhU1okigTWPydVhZzS+AwhBsrkzJLyfuT9na8NcGs58atcgnWc68IJ1?=
 =?us-ascii?Q?p+Bo+nXZZcktv3etVrFdn5zWhMJhKQXNYx279Z9vi7zz/zfgAikV0XzysFlo?=
 =?us-ascii?Q?TqsrTbILE2vp8IXgjm23Df2mRyswyFzgiGmhws4w/up5LejGAvUyIGtDWapN?=
 =?us-ascii?Q?MVkL9hu2GOC1QKNW6iUWA4FkhsqQTnTIrwQebHw7JRvgX0wfExkgQavYIqzH?=
 =?us-ascii?Q?Zwaiy8r/eJHDm7M9imcrdOO/ZTQJK3CG06G+rBfo0Zk3j+Fd188UX4/Ve6kw?=
 =?us-ascii?Q?l5p3RrQSoFVvv50EpuoZmccff5KJS76Rb343hjWk41V4W9DQEW9P1lF6stu5?=
 =?us-ascii?Q?Oh3TMyX9/QUiA7rXCnilUPsWRdHZrOxZsLl9WFz4TzlDzN/41ZZgP6hyD3XH?=
 =?us-ascii?Q?s0lFsoWYHB39ocM4kj1apv0NlsFFb83kwVqWr4Mgw8nzkFQJyTu1lAJWMyoD?=
 =?us-ascii?Q?g0id4yZ4kUYKJtiC+gYgR+fA3rGSSPCdU0vWEWzz9pIfwNCQDTs9wx9QfRNG?=
 =?us-ascii?Q?RzRS/Kh3DgFZE1ZykbC8WUP2FrwUyfzT/Yqs7PESjqAUxXvbOyGQ9wTqeMrc?=
 =?us-ascii?Q?jiIOQgQREApkLUAfiwT6vxA4wuNYALhkoyftaNcjpS5LLpM2dWE4ywaxz4RK?=
 =?us-ascii?Q?f3G9vsTQ/4M3QQEzIyVjLvzsF9yN0vA7rFPA9LCHwE0xeKXXFcerYIFGSqQk?=
 =?us-ascii?Q?HMvhtxJNIWPHNQyqk9xDi1hJPNtllErf3SJ/a1TSf8zRwWLCv7gcnfDGq8w7?=
 =?us-ascii?Q?AO7id1qWqR5d7fVx0Fq0hhpcDVZmTLfOs4FPhiPp9ebXFd7BaElFff8GrqY8?=
 =?us-ascii?Q?WWmPqtKKz3kfSKDe+LecUhuSGnuRxC73jNUwm/BrHYq4dABXRneijf/w42oT?=
 =?us-ascii?Q?/89CpSvvNbvXgyB0siWgmkllWXGJDorA/5CM7nTHYrIwYA0S+FBetYDPP6Ah?=
 =?us-ascii?Q?gVZLuDinESgpcCh1ZlrTmW7ptrXp7cZL4ZsEl1UTwT660m/Ez8GoyxyWZQtI?=
 =?us-ascii?Q?TiDEPEXpkPR4afPqyb+lHZaUaiKHEHKv8j/cDih4S1wLcsvj0dVQXmP8roDt?=
 =?us-ascii?Q?0iCImaOFBNVAEfX5k4YS2hdI5qYCP+qM5Juc3HA8hAthOpmyWlc+CdBH6oNZ?=
 =?us-ascii?Q?P9v4y+FnyQtIVz1lKemA2sNuLkCHKWLvXHvOUUMsz9DMERGTe0MBKJqE4589?=
 =?us-ascii?Q?Ew=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <62E652B3E0739E40B5A7104612CA27BE@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR03MB7136.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 579725a9-c1c6-4112-aded-08db7e2aa291
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2023 14:09:38.3658
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xMA+XhE3uz1rtr+FDSPDDxqROKTrJggwZmDxuh/mL0LROX5YoagYfa3ae0bmRgobRqPWzBp8uz1ON+OcMzjbEgWAxSToM+EdfL7PWgjMUaA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0302MB9157
X-Proofpoint-ORIG-GUID: GvPGu0JSzVbhGrB4enj-Va8tWwIRP47J
X-Proofpoint-GUID: GvPGu0JSzVbhGrB4enj-Va8tWwIRP47J
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-06_10,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 priorityscore=1501 malwarescore=0 lowpriorityscore=0 mlxlogscore=999
 phishscore=0 spamscore=0 impostorscore=0 bulkscore=0 adultscore=0
 mlxscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307060127
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Cristian,

Sorry for late answer.
Please see below.

On Mon, Jul 03, 2023 at 11:16:47AM +0100, Cristian Marussi wrote:
> On Tue, Jun 06, 2023 at 04:22:27PM +0000, Oleksii Moisieiev wrote:
> > scmi: Introduce pinctrl SCMI protocol driver
> >
>=20
> Hi Oleksii,
>=20
> spurios line above.

Yep thanks, I will remove.

>=20
> > Add basic implementation of the SCMI v3.2 pincontrol protocol
> > excluding GPIO support. All pinctrl related callbacks and operations
> > are exposed in the include/linux/scmi_protocol.h
> >=20
>=20
> As Andy said already, you can drop the second sentence here, but I would
> ALSO drop the GPIO part in the first sentence, since there is nothing
> specific to GPIO in the SCMI spec and this patch is about the SCMI protoc=
ol
> not the pinctrl driver.
>

I've added few words about GPIO because in v2 series Michal Simek asked
about it: https://lore.kernel.org/linux-arm-kernel/5bf0e975-d314-171f-b6a8-=
c1c1c7198cd3@amd.com/
So I've decided to mention that there is still no GPIO support in the
commit message to avoid this type of questions in future. But I agree
that the commit message looks weird and will try to rephrase it.

> > Signed-off-by: Oleksii Moisieiev <oleksii_moisieiev@epam.com>
> > ---
> >  MAINTAINERS                           |   6 +
> >  drivers/firmware/arm_scmi/Makefile    |   2 +-
> >  drivers/firmware/arm_scmi/driver.c    |   2 +
> >  drivers/firmware/arm_scmi/pinctrl.c   | 836 ++++++++++++++++++++++++++
> >  drivers/firmware/arm_scmi/protocols.h |   1 +
> >  include/linux/scmi_protocol.h         |  47 ++
> >  6 files changed, 893 insertions(+), 1 deletion(-)
> >  create mode 100644 drivers/firmware/arm_scmi/pinctrl.c
> >=20
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 0dab9737ec16..297b2512963d 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -20522,6 +20522,12 @@ F:	include/linux/sc[mp]i_protocol.h
> >  F:	include/trace/events/scmi.h
> >  F:	include/uapi/linux/virtio_scmi.h
> > =20
> > +PINCTRL DRIVER FOR SYSTEM CONTROL & POWER/MANAGEMENT INTERFACE (SCPI/S=
CMI)
>=20
> SCPI is a leftover here I suppose...
>=20

Thanks. I'll fix it.

> > +M:	Oleksii Moisieiev <oleksii_moisieiev@epam.com>
> > +L:	linux-arm-kernel@lists.infradead.org
> > +S:	Maintained
> > +F:	drivers/firmware/arm_scmi/pinctrl.c
> > +
> >  SYSTEM RESET/SHUTDOWN DRIVERS
> >  M:	Sebastian Reichel <sre@kernel.org>
> >  L:	linux-pm@vger.kernel.org
> > diff --git a/drivers/firmware/arm_scmi/Makefile b/drivers/firmware/arm_=
scmi/Makefile
> > index b31d78fa66cc..603430ec0bfe 100644
> > --- a/drivers/firmware/arm_scmi/Makefile
> > +++ b/drivers/firmware/arm_scmi/Makefile
> > @@ -10,7 +10,7 @@ scmi-transport-$(CONFIG_ARM_SCMI_TRANSPORT_SMC) +=3D =
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
> >  obj-$(CONFIG_ARM_SCMI_PROTOCOL) +=3D scmi-core.o
> > diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_=
scmi/driver.c
> > index 5be931a07c84..a9fd337b9596 100644
> > --- a/drivers/firmware/arm_scmi/driver.c
> > +++ b/drivers/firmware/arm_scmi/driver.c
> > @@ -3025,6 +3025,7 @@ static int __init scmi_driver_init(void)
> >  	scmi_voltage_register();
> >  	scmi_system_register();
> >  	scmi_powercap_register();
> > +	scmi_pinctrl_register();
> > =20
> >  	return platform_driver_register(&scmi_driver);
> >  }
> > @@ -3042,6 +3043,7 @@ static void __exit scmi_driver_exit(void)
> >  	scmi_voltage_unregister();
> >  	scmi_system_unregister();
> >  	scmi_powercap_unregister();
> > +	scmi_pinctrl_unregister();
> > =20
> >  	scmi_transports_exit();
> > =20
> > diff --git a/drivers/firmware/arm_scmi/pinctrl.c b/drivers/firmware/arm=
_scmi/pinctrl.c
> > new file mode 100644
> > index 000000000000..fc0fcc26dfb6
> > --- /dev/null
> > +++ b/drivers/firmware/arm_scmi/pinctrl.c
> > @@ -0,0 +1,836 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * System Control and Management Interface (SCMI) Pinctrl Protocol
> > + *
> > + * Copyright (C) 2023 EPAM
> > + */
> > +
> > +#include <linux/module.h>
> > +#include <linux/scmi_protocol.h>
> > +#include <linux/slab.h>
> > +
> > +#include "protocols.h"
> > +
> > +#define REG_TYPE_BITS GENMASK(9, 8)
> > +#define REG_CONFIG GENMASK(7, 0)
> > +
> > +#define GET_GROUPS_NR(x)	le32_get_bits((x), GENMASK(31, 16))
> > +#define GET_PINS_NR(x)		le32_get_bits((x), GENMASK(15, 0))
> > +#define GET_FUNCTIONS_NR(x)	le32_get_bits((x), GENMASK(15, 0))
> > +
> > +#define EXT_NAME_FLAG(x)	le32_get_bits((x), BIT(31))
> > +#define NUM_ELEMS(x)		le32_get_bits((x), GENMASK(15, 0))
> > +
> > +#define REMAINING(x)		le32_get_bits((x), GENMASK(31, 16))
> > +#define RETURNED(x)		le32_get_bits((x), GENMASK(11, 0))
> > +
> > +enum scmi_pinctrl_protocol_cmd {
> > +	PINCTRL_ATTRIBUTES =3D 0x3,
> > +	PINCTRL_LIST_ASSOCIATIONS =3D 0x4,
> > +	PINCTRL_CONFIG_GET =3D 0x5,
> > +	PINCTRL_CONFIG_SET =3D 0x6,
> > +	PINCTRL_FUNCTION_SELECT =3D 0x7,
> > +	PINCTRL_REQUEST =3D 0x8,
> > +	PINCTRL_RELEASE =3D 0x9,
> > +	PINCTRL_NAME_GET =3D 0xa,
> > +	PINCTRL_SET_PERMISSIONS =3D 0xb
> > +};
> > +
> > +struct scmi_msg_conf_set {
> > +	__le32 identifier;
> > +	__le32 attributes;
> > +	__le32 config_value;
> > +};
> > +
> > +struct scmi_msg_conf_get {
> > +	__le32 identifier;
> > +	__le32 attributes;
> > +};
> > +
> > +struct scmi_msg_pinctrl_protocol_attributes {
> > +	__le32 attributes_low;
> > +	__le32 attributes_high;
> > +};
> > +
> > +struct scmi_msg_pinctrl_attributes {
> > +	__le32 identifier;
> > +	__le32 flags;
> > +};
> > +
> > +struct scmi_resp_pinctrl_attributes {
> > +	__le32 attributes;
> > +	u8 name[SCMI_SHORT_NAME_MAX_SIZE];
> > +};
> > +
> > +struct scmi_msg_pinctrl_list_assoc {
> > +	__le32 identifier;
> > +	__le32 flags;
> > +	__le32 index;
> > +};
> > +
> > +struct scmi_resp_pinctrl_list_assoc {
> > +	__le32 flags;
> > +	__le16 array[];
> > +};
> > +
> > +struct scmi_msg_func_set {
> > +	__le32 identifier;
> > +	__le32 function_id;
> > +	__le32 flags;
> > +};
> > +
> > +struct scmi_msg_request {
> > +	__le32 identifier;
> > +	__le32 flags;
> > +};
> > +
> > +struct scmi_group_info {
> > +	bool present;
> > +	char name[SCMI_MAX_STR_SIZE];
> > +	unsigned int *group_pins;
> > +	unsigned int nr_pins;
> > +};
> > +
> > +struct scmi_function_info {
> > +	bool present;
> > +	char name[SCMI_MAX_STR_SIZE];
> > +	unsigned int *groups;
> > +	unsigned int nr_groups;
> > +};
> > +
>=20
> A small note related to Andy remarks about directly embedding here pinctr=
l
> subsystem structures (like pingroup / pinfucntion) that I forgot to say
> in my reply to him.
>=20
> These structs above indeed are very similar to the Pinctrl ones but this =
is
> the protocol layer inside SCMI, I would not mix here stuff from the Pinct=
rl
> subsystem which is, at the end the, one of the possible users of this lay=
er
> (via the SCMI pinctrl driver) but not necessarily the only one in the
> future; moreover Pinctrl subsystem is not even needed at all if you think
> about a testing scenario, so I would not build up a dependency here betwe=
en
> SCMI and Pinctrl by using Pinctrl structures...what if these latter chang=
e
> in the future ?
>=20
> All of this to just say this is fine for me as it is now :D
>=20
I agree with you.
What we currently have is that scmi pinctrl protocol is not bound to
pinctrl-subsystem so in case of some changes in the pinctrl - no need to
change the protocol implementation.
Also, as I mentioned in v2: I can't use pincfunction it has the following g=
roups
definition:
const char * const *groups;

Which is meant to be constantly allocated.
So I when I try to gather list of groups in
pinctrl_scmi_get_function_groups I will receive compilation error.

Pinctrl subsystem was designed to use statically defined
pins/groups/functions so we can't use those structures on lazy
allocations.


> > +struct scmi_pin_info {
> > +	bool present;
> > +	char name[SCMI_MAX_STR_SIZE];
> > +};
> > +
> > +struct scmi_pinctrl_info {
> > +	u32 version;
> > +	int nr_groups;
> > +	int nr_functions;
> > +	int nr_pins;
> > +	struct scmi_group_info *groups;
> > +	struct scmi_function_info *functions;
> > +	struct scmi_pin_info *pins;
> > +};
> > +
> > +static int scmi_pinctrl_attributes_get(const struct scmi_protocol_hand=
le *ph,
> > +				       struct scmi_pinctrl_info *pi)
> > +{
> > +	int ret;
> > +	struct scmi_xfer *t;
> > +	struct scmi_msg_pinctrl_protocol_attributes *attr;
> > +
> > +	if (!pi)
> > +		return -EINVAL;
>=20
> You can drop this, cannot happen given the code paths.
>

Ok. thanks.

> > +
> > +	ret =3D ph->xops->xfer_get_init(ph, PROTOCOL_ATTRIBUTES,
> > +				      0, sizeof(*attr), &t);
> > +	if (ret)
> > +		return ret;
> > +
> > +	attr =3D t->rx.buf;
> > +
> > +	ret =3D ph->xops->do_xfer(ph, t);
> > +	if (!ret) {
> > +		pi->nr_functions =3D GET_FUNCTIONS_NR(attr->attributes_high);
> > +		pi->nr_groups =3D GET_GROUPS_NR(attr->attributes_low);
> > +		pi->nr_pins =3D GET_PINS_NR(attr->attributes_low);
> > +	}
> > +
> > +	ph->xops->xfer_put(ph, t);
> > +	return ret;
> > +}
> > +
> > +static int scmi_pinctrl_get_count(const struct scmi_protocol_handle *p=
h,
> > +				  enum scmi_pinctrl_selector_type type)
> > +{
> > +	struct scmi_pinctrl_info *pi;
> > +
> > +	pi =3D ph->get_priv(ph);
> > +	if (!pi)
> > +		return -ENODEV;
>=20
> You dont need to check for NULL here and nowhere else.
> You set protocol private data with set_priv at the end of protocol init
> which is called as soon as a user tries to use this protocol operations,
> so it cannot ever be NULL in any of these following ops.
>=20

And what if I call set_priv(ph, NULL) on init stage?
As I can see there is no check for NULL in scmi_set_protocol_priv. So
theoretically I'm able to set ph->priv =3D NULL. Or did I missed some check=
 in
SCMI driver? Or maybe priv =3D NULL is expected scenario and I shouldn't
return error here?
> > +
> > +	switch (type) {
> > +	case PIN_TYPE:
> > +		return pi->nr_pins;
> > +	case GROUP_TYPE:
> > +		return pi->nr_groups;
> > +	case FUNCTION_TYPE:
> > +		return pi->nr_functions;
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +}
> > +
> > +static int scmi_pinctrl_validate_id(const struct scmi_protocol_handle =
*ph,
> > +				    u32 identifier,
> > +				    enum scmi_pinctrl_selector_type type)
> > +{
> > +	int value;
> > +
> > +	value =3D scmi_pinctrl_get_count(ph, type);
> > +	if (value < 0)
> > +		return value;
> > +
> > +	if (identifier >=3D value)
> > +		return -EINVAL;
> > +
> > +	return 0;
> > +}
> > +
> > +static int scmi_pinctrl_attributes(const struct scmi_protocol_handle *=
ph,
> > +				   enum scmi_pinctrl_selector_type type,
> > +				   u32 selector, char *name,
> > +				   unsigned int *n_elems)
> > +{
> > +	int ret;
> > +	struct scmi_xfer *t;
> > +	struct scmi_msg_pinctrl_attributes *tx;
> > +	struct scmi_resp_pinctrl_attributes *rx;
> > +
> > +	if (!name)
> > +		return -EINVAL;
> > +
> > +	ret =3D scmi_pinctrl_validate_id(ph, selector, type);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret =3D ph->xops->xfer_get_init(ph, PINCTRL_ATTRIBUTES, sizeof(*tx),
> > +				      sizeof(*rx), &t);
> > +	if (ret)
> > +		return ret;
> > +
> > +	tx =3D t->tx.buf;
> > +	rx =3D t->rx.buf;
> > +	tx->identifier =3D cpu_to_le32(selector);
> > +	tx->flags =3D cpu_to_le32(type);
> > +
> > +	ret =3D ph->xops->do_xfer(ph, t);
> > +	if (!ret) {
> > +		if (n_elems)
> > +			*n_elems =3D NUM_ELEMS(rx->attributes);
> > +
> > +		strscpy(name, rx->name, SCMI_SHORT_NAME_MAX_SIZE);
> > +	}
> > +
> > +	ph->xops->xfer_put(ph, t);
> > +
> > +	/*
> > +	 * If supported overwrite short name with the extended one;
> > +	 * on error just carry on and use already provided short name.
> > +	 */
> > +	if (!ret && EXT_NAME_FLAG(rx->attributes))
> > +		ph->hops->extended_name_get(ph, PINCTRL_NAME_GET, selector,
> > +					    (u32 *)&type, name,
> > +					    SCMI_MAX_STR_SIZE);
> > +	return ret;
> > +}
> > +
>=20
> [snip]
>=20
> > +
> > +static int scmi_pinctrl_get_group_info(const struct scmi_protocol_hand=
le *ph,
> > +				       u32 selector,
> > +				       struct scmi_group_info *group)
> > +{
> > +	int ret;
> > +
> > +	if (!group)
> > +		return -EINVAL;
> > +
> > +	ret =3D scmi_pinctrl_attributes(ph, GROUP_TYPE, selector,
> > +				      group->name,
> > +				      &group->nr_pins);
> > +	if (ret)
> > +		return ret;
> > +
> > +	if (!group->nr_pins) {
> > +		dev_err(ph->dev, "Group %d has 0 elements", selector);
> > +		return -ENODATA;
> > +	}
> > +
> > +	group->group_pins =3D devm_kmalloc_array(ph->dev, group->nr_pins,
> > +					       sizeof(*group->group_pins),
> > +					       GFP_KERNEL);
> > +	if (!group->group_pins)
> > +		return -ENOMEM;
>=20
> This is a lazy-allocation happening outside of the protocol init path so =
you
> are rigthly tracking it manually here and in protocol_deinit, BUT you
> should not use devm_ helpers, it is fuorviating even though harmless;
> just plain kmalloc/kcalloc/kfree will do. (As I said oin the reply to
> Andy I miss this previously, apologies)
>=20

Thank you and Andy for the observations. I will refactor.

> > +
> > +	ret =3D scmi_pinctrl_list_associations(ph, selector, GROUP_TYPE,
> > +					     group->nr_pins, group->group_pins);
> > +	if (ret) {
> > +		devm_kfree(ph->dev, group->group_pins);
>=20
> kfree
>=20

Ok.

> > +		return ret;
> > +	}
> > +
> > +	group->present =3D true;
> > +	return 0;
> > +}
> > +
> > +static int scmi_pinctrl_get_group_name(const struct scmi_protocol_hand=
le *ph,
> > +				       u32 selector, const char **name)
> > +{
> > +	struct scmi_pinctrl_info *pi;
> > +
> > +	if (!name)
> > +		return -EINVAL;
> > +
> > +	pi =3D ph->get_priv(ph);
> > +	if (!pi)
>=20
> Ditto.
>=20
> > +		return -EINVAL;
> > +
> > +	if (selector > pi->nr_groups)
> > +		return -EINVAL;
>=20
> selector >=3D  ?
>

Right. Thanks.

> > +
> > +	if (!pi->groups[selector].present) {
> > +		int ret;
> > +
> > +		ret =3D scmi_pinctrl_get_group_info(ph, selector,
> > +						  &pi->groups[selector]);
> > +		if (ret)
> > +			return ret;
> > +	}
> > +
> > +	*name =3D pi->groups[selector].name;
> > +
> > +	return 0;
> > +}
> > +
> > +static int scmi_pinctrl_get_group_pins(const struct scmi_protocol_hand=
le *ph,
> > +				       u32 selector, const unsigned int **pins,
> > +				       unsigned int *nr_pins)
> > +{
> > +	struct scmi_pinctrl_info *pi;
> > +
> > +	if (!pins || !nr_pins)
> > +		return -EINVAL;
> > +
> > +	pi =3D ph->get_priv(ph);
> > +	if (!pi)
> > +		return -EINVAL;
>=20
> Ditto.
>=20
> > +
> > +	if (selector > pi->nr_groups)
> > +		return -EINVAL;
> > +
>=20
> selector >=3D  ?
>=20

Yes, thanks.

> > +	if (!pi->groups[selector].present) {
> > +		int ret;
> > +
> > +		ret =3D scmi_pinctrl_get_group_info(ph, selector,
> > +						  &pi->groups[selector]);
> > +		if (ret)
> > +			return ret;
> > +	}
> > +
> > +	*pins =3D pi->groups[selector].group_pins;
> > +	*nr_pins =3D pi->groups[selector].nr_pins;
> > +
> > +	return 0;
> > +}
> > +
> > +static int scmi_pinctrl_get_function_info(const struct scmi_protocol_h=
andle *ph,
> > +					  u32 selector,
> > +					  struct scmi_function_info *func)
> > +{
> > +	int ret;
> > +
> > +	if (!func)
> > +		return -EINVAL;
> > +
> > +	ret =3D scmi_pinctrl_attributes(ph, FUNCTION_TYPE, selector,
> > +				      func->name,
> > +				      &func->nr_groups);
> > +	if (ret)
> > +		return ret;
> > +
> > +	if (!func->nr_groups) {
> > +		dev_err(ph->dev, "Function %d has 0 elements", selector);
> > +		return -ENODATA;
> > +	}
> > +
> > +	func->groups =3D devm_kmalloc_array(ph->dev, func->nr_groups,
> > +					  sizeof(*func->groups),
> > +					  GFP_KERNEL);
> > +	if (!func->groups)
> > +		return -ENOMEM;
>=20
> Same as above...lazy allocation properly tracked BUT do not use devm_
> variants.
>
Ok.

> > +
> > +	ret =3D scmi_pinctrl_list_associations(ph, selector, FUNCTION_TYPE,
> > +					     func->nr_groups, func->groups);
> > +	if (ret) {
> > +		devm_kfree(ph->dev, func->groups);
> > +		return ret;
>=20
> kfree
>=20
> > +	}
> > +
> > +	func->present =3D true;
> > +	return 0;
> > +}
> > +
> > +static int scmi_pinctrl_get_function_name(const struct scmi_protocol_h=
andle *ph,
> > +					  u32 selector, const char **name)
> > +{
> > +	struct scmi_pinctrl_info *pi;
> > +
> > +	if (!name)
> > +		return -EINVAL;
> > +
> > +	pi =3D ph->get_priv(ph);
> > +	if (!pi)
> > +		return -EINVAL;
>=20
> Ditto.
>=20
> > +
> > +	if (selector > pi->nr_functions)
> > +		return -EINVAL;
>=20
> selector >=3D  ?
>=20
Ok. thanks.
> > +
> > +	if (!pi->functions[selector].present) {
> > +		int ret;
> > +
> > +		ret =3D scmi_pinctrl_get_function_info(ph, selector,
> > +						     &pi->functions[selector]);
> > +		if (ret)
> > +			return ret;
> > +	}
> > +
> > +	*name =3D pi->functions[selector].name;
> > +	return 0;
> > +}
> > +
> > +static int scmi_pinctrl_get_function_groups(const struct scmi_protocol=
_handle *ph,
> > +					    u32 selector,
> > +					    unsigned int *nr_groups,
> > +					    const unsigned int **groups)
> > +{
> > +	struct scmi_pinctrl_info *pi;
> > +
> > +	if (!groups || !nr_groups)
> > +		return -EINVAL;
> > +
> > +	pi =3D ph->get_priv(ph);
> > +	if (!pi)
> > +		return -EINVAL;
>=20
> Ditto.
>=20
> > +
> > +	if (selector > pi->nr_functions)
> > +		return -EINVAL;
>=20
> selector >=3D  ?
>=20
Ok. thanks.=20
> > +
> > +	if (!pi->functions[selector].present) {
> > +		int ret;
> > +
> > +		ret =3D scmi_pinctrl_get_function_info(ph, selector,
> > +						     &pi->functions[selector]);
> > +		if (ret)
> > +			return ret;
> > +	}
> > +
> > +	*groups =3D pi->functions[selector].groups;
> > +	*nr_groups =3D pi->functions[selector].nr_groups;
> > +
> > +	return 0;
> > +}
> > +
> > +static int scmi_pinctrl_set_mux(const struct scmi_protocol_handle *ph,
> > +				u32 selector, u32 group)
> > +{
> > +	return scmi_pinctrl_function_select(ph, group, GROUP_TYPE,
> > +					    selector);
> > +}
> > +
> > +static int scmi_pinctrl_get_pin_info(const struct scmi_protocol_handle=
 *ph,
> > +				     u32 selector, struct scmi_pin_info *pin)
> > +{
> > +	int ret;
> > +	struct scmi_pinctrl_info *pi;
> > +
> > +	if (!pin)
> > +		return -EINVAL;
> > +
> > +	pi =3D ph->get_priv(ph);
> > +	if (!pi)
> > +		return -EINVAL;
>=20
> Ditto.
>=20
> > +
> > +	ret =3D scmi_pinctrl_attributes(ph, PIN_TYPE, selector,
> > +				      pin->name, NULL);
> > +	if (ret)
> > +		return ret;
> > +
> > +	pin->present =3D true;
> > +	return 0;
> > +}
> > +
> > +static int scmi_pinctrl_get_pin_name(const struct scmi_protocol_handle=
 *ph,
> > +				     u32 selector, const char **name)
> > +{
> > +	struct scmi_pinctrl_info *pi;
> > +
> > +	if (!name)
> > +		return -EINVAL;
> > +
> > +	pi =3D ph->get_priv(ph);
> > +	if (!pi)
> > +		return -EINVAL;
>=20
> Ditto.
>=20
> > +
> > +	if (selector > pi->nr_pins)
> > +		return -EINVAL;
>=20
> selector >=3D  ?
>=20
Ok. thanks.=20
> > +
> > +	if (!pi->pins[selector].present) {
> > +		int ret;
> > +
> > +		ret =3D scmi_pinctrl_get_pin_info(ph, selector,
> > +						&pi->pins[selector]);
> > +		if (ret)
> > +			return ret;
> > +	}
> > +
> > +	*name =3D pi->pins[selector].name;
> > +
> > +	return 0;
> > +}
> > +
> > +static int scmi_pinctrl_get_name(const struct scmi_protocol_handle *ph=
,
> > +				 u32 selector,
> > +				 enum scmi_pinctrl_selector_type type,
> > +				 const char **name)
> > +{
> > +	switch (type) {
> > +	case PIN_TYPE:
> > +		return scmi_pinctrl_get_pin_name(ph, selector, name);
> > +	case GROUP_TYPE:
> > +		return scmi_pinctrl_get_group_name(ph, selector, name);
> > +	case FUNCTION_TYPE:
> > +		return scmi_pinctrl_get_function_name(ph, selector, name);
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +}
> > +
> > +static const struct scmi_pinctrl_proto_ops pinctrl_proto_ops =3D {
> > +	.get_count =3D scmi_pinctrl_get_count,
> > +	.get_name =3D scmi_pinctrl_get_name,
> > +	.get_group_pins =3D scmi_pinctrl_get_group_pins,
> > +	.get_function_groups =3D scmi_pinctrl_get_function_groups,
> > +	.set_mux =3D scmi_pinctrl_set_mux,
> > +	.get_config =3D scmi_pinctrl_get_config,
> > +	.set_config =3D scmi_pinctrl_set_config,
> > +	.request_pin =3D scmi_pinctrl_request_pin,
> > +	.free_pin =3D scmi_pinctrl_free_pin
> > +};
> > +
> > +static int scmi_pinctrl_protocol_init(const struct scmi_protocol_handl=
e *ph)
> > +{
> > +	int ret;
> > +	u32 version;
> > +	struct scmi_pinctrl_info *pinfo;
> > +
> > +	ret =3D ph->xops->version_get(ph, &version);
> > +	if (ret)
> > +		return ret;
> > +
> > +	dev_dbg(ph->dev, "Pinctrl Version %d.%d\n",
> > +		PROTOCOL_REV_MAJOR(version), PROTOCOL_REV_MINOR(version));
> > +
> > +	pinfo =3D devm_kzalloc(ph->dev, sizeof(*pinfo), GFP_KERNEL);
> > +	if (!pinfo)
> > +		return -ENOMEM;
> > +
> > +	ret =3D scmi_pinctrl_attributes_get(ph, pinfo);
> > +	if (ret)
> > +		return ret;
> > +
> > +	pinfo->pins =3D devm_kcalloc(ph->dev, pinfo->nr_pins,
> > +				   sizeof(*pinfo->pins),
> > +				   GFP_KERNEL);
> > +	if (!pinfo->pins)
> > +		return -ENOMEM;
> > +
> > +	pinfo->groups =3D devm_kcalloc(ph->dev, pinfo->nr_groups,
> > +				     sizeof(*pinfo->groups),
> > +				     GFP_KERNEL);
> > +	if (!pinfo->groups)
> > +		return -ENOMEM;
> > +
> > +	pinfo->functions =3D devm_kcalloc(ph->dev, pinfo->nr_functions,
> > +					sizeof(*pinfo->functions),
> > +					GFP_KERNEL);
> > +	if (!pinfo->functions)
> > +		return -ENOMEM;
> > +
> > +	pinfo->version =3D version;
> > +
> > +	return ph->set_priv(ph, pinfo);
> > +}
> > +
> > +static int scmi_pinctrl_protocol_deinit(const struct scmi_protocol_han=
dle *ph)
> > +{
> > +	int i;
> > +	struct scmi_pinctrl_info *pi;
> > +
> > +	pi =3D ph->get_priv(ph);
> > +	if (!pi)
> > +		return -EINVAL;
>=20
> Ditto. You never get even here if protocol init had not succesfully
> completed.
>=20
> > +
> > +	for (i =3D 0; i < pi->nr_groups; i++)
> > +		if (pi->groups[i].present) {
> > +			devm_kfree(ph->dev, pi->groups[i].group_pins);
>=20
> kfree..you are managing these.
>=20
> > +			pi->groups[i].present =3D false;
> > +		}
> > +
> > +	for (i =3D 0; i < pi->nr_functions; i++)
> > +		if (pi->functions[i].present) {
> > +			devm_kfree(ph->dev, pi->functions[i].groups);
>=20
> kfree..you are managing these.
>=20
> > +			pi->functions[i].present =3D false;
> > +		}
> > +
> > +	return 0;
> > +}
> > +
> > +static const struct scmi_protocol scmi_pinctrl =3D {
> > +	.id =3D SCMI_PROTOCOL_PINCTRL,
> > +	.owner =3D THIS_MODULE,
> > +	.instance_init =3D &scmi_pinctrl_protocol_init,
> > +	.instance_deinit =3D &scmi_pinctrl_protocol_deinit,
> > +	.ops =3D &pinctrl_proto_ops,
> > +};
> > +
> > +DEFINE_SCMI_PROTOCOL_REGISTER_UNREGISTER(pinctrl, scmi_pinctrl)
> > diff --git a/drivers/firmware/arm_scmi/protocols.h b/drivers/firmware/a=
rm_scmi/protocols.h
> > index b3c6314bb4b8..674f949354f9 100644
> > --- a/drivers/firmware/arm_scmi/protocols.h
> > +++ b/drivers/firmware/arm_scmi/protocols.h
> > @@ -346,5 +346,6 @@ DECLARE_SCMI_REGISTER_UNREGISTER(sensors);
> >  DECLARE_SCMI_REGISTER_UNREGISTER(voltage);
> >  DECLARE_SCMI_REGISTER_UNREGISTER(system);
> >  DECLARE_SCMI_REGISTER_UNREGISTER(powercap);
> > +DECLARE_SCMI_REGISTER_UNREGISTER(pinctrl);
> > =20
> >  #endif /* _SCMI_PROTOCOLS_H */
> > diff --git a/include/linux/scmi_protocol.h b/include/linux/scmi_protoco=
l.h
> > index 0ce5746a4470..97631783a5a4 100644
> > --- a/include/linux/scmi_protocol.h
> > +++ b/include/linux/scmi_protocol.h
> > @@ -735,6 +735,52 @@ struct scmi_notify_ops {
> >  					 struct notifier_block *nb);
> >  };
> > =20
> > +enum scmi_pinctrl_selector_type {
> > +	PIN_TYPE =3D 0,
> > +	GROUP_TYPE,
> > +	FUNCTION_TYPE
> > +};
> > +
> > +/**
> > + * struct scmi_pinctrl_proto_ops - represents the various operations p=
rovided
> > + * by SCMI Pinctrl Protocol
> > + *
> > + * @get_count: returns count of the registered elements in given type
> > + * @get_name: returns name by index of given type
> > + * @get_group_pins: returns the set of pins, assigned to the specified=
 group
> > + * @get_function_groups: returns the set of groups, assigned to the sp=
ecified
> > + *	function
> > + * @set_mux: set muxing function for groups of pins
> > + * @get_config: returns configuration parameter for pin or group
> > + * @set_config: sets the configuration parameter for pin or group
> > + * @request_pin: aquire pin before selecting mux setting
> > + * @free_pin: frees pin, acquired by request_pin call
> > + */
> > +struct scmi_pinctrl_proto_ops {
> > +	int (*get_count)(const struct scmi_protocol_handle *ph,
> > +			 enum scmi_pinctrl_selector_type type);
> > +	int (*get_name)(const struct scmi_protocol_handle *ph,
> > +			u32 selector,
> > +			enum scmi_pinctrl_selector_type type,
> > +			const char **name);
> > +	int (*get_group_pins)(const struct scmi_protocol_handle *ph,
> > +			      u32 selector,
> > +			      const unsigned int **pins, unsigned int *nr_pins);
> > +	int (*get_function_groups)(const struct scmi_protocol_handle *ph,
> > +				   u32 selector, unsigned int *nr_groups,
> > +				   const unsigned int **groups);
> > +	int (*set_mux)(const struct scmi_protocol_handle *ph, u32 selector,
> > +		       u32 group);
> > +	int (*get_config)(const struct scmi_protocol_handle *ph, u32 selector=
,
> > +			  enum scmi_pinctrl_selector_type type,
> > +			  u8 config_type, unsigned long *config_value);
> > +	int (*set_config)(const struct scmi_protocol_handle *ph, u32 selector=
,
> > +			  enum scmi_pinctrl_selector_type type,
> > +			  u8 config_type, unsigned long config_value);
> > +	int (*request_pin)(const struct scmi_protocol_handle *ph, u32 pin);
> > +	int (*free_pin)(const struct scmi_protocol_handle *ph, u32 pin);
> > +};
> > +
>=20
> Can you move all of these before .notify_ops where all others protocol
> ops lives ? ... and rename all pinctrl_ops to match the ".<object>_<verb>=
"
> pattern like other ops (i.e. count_get/name_get ... instead get_count/get=
_name)
>

I will do this.

> >  /**
> >   * struct scmi_handle - Handle returned to ARM SCMI clients for usage.
> >   *
> > @@ -783,6 +829,7 @@ enum scmi_std_protocol {
> >  	SCMI_PROTOCOL_RESET =3D 0x16,
> >  	SCMI_PROTOCOL_VOLTAGE =3D 0x17,
> >  	SCMI_PROTOCOL_POWERCAP =3D 0x18,
> > +	SCMI_PROTOCOL_PINCTRL =3D 0x19,
> >  };
> > =20
>=20
> Thanks,
> Cristian


Thanks,
Oleksii.=
