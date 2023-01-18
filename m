Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DB19671D38
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 14:14:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230114AbjARNOA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 08:14:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230101AbjARNN3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 08:13:29 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2055.outbound.protection.outlook.com [40.107.92.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47AD63757C;
        Wed, 18 Jan 2023 04:36:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CTlJz2dF3+zv9Dc86scnPlwzLRrNKQo3fzDkqE4OtAd+H8GaT6oa2mKUQcHfdvE69unTvy8bgG1+/crQJYqWeCJzsZWhy3nb9wqNCyhvKejHKBBf0QM5EjaqMGFZk4Tsb19qmo6jchAM2Oye7/V2LOFLFI7hnTcOvgfjpUjpSaoe4919lZ7HugCh4EFRcnChIV2u2AngMa4n5audo/wSo5keS/EkkcKUz7ZYTS8755CymsDo9B3RXRzUOAdLaaa1QtaDRgV0/Xk2o/uGiOirlBFsSMVx66t1pRXsXx4KXwlJmY93xsz2bk/ce/TZAdKmYqoIcDdr1hXs0AIOg8XAGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N3SJ2FM5wMgl0WWWfOd0kmcod8KLhMjyuUAWXo9wdx4=;
 b=Of0QcHzz/hfFcJSdfn5kQXHT99wQ+sDG9zeYUeT6Tj3qQKkt6ScBV6cCgLDHk+PtmWPn/CXT9KKTIpjylbpqcXb8e6i8zxixW2O1WlPu0dWYYdifgGRdHscj/gD+FmFRMk9+VWoYBwr4yqX9LgVFev0QF+aWtPBd+s76+RrBDzf8cFclZ9/ALiOLzdrz8vSwktNITR2G0Bi8U3+zgzY7l6knG/LmED1WPMrmmyJSBmMK2Dj0GMp0r55vvkGvwEy42PguZMCqV+A8ulFmtmF6EjhYCVqR0+evhClNqN3MVjqUCtbTwIawPd9YsU4s4rkwRf8LDblshDLuLSv89KgKjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N3SJ2FM5wMgl0WWWfOd0kmcod8KLhMjyuUAWXo9wdx4=;
 b=wfFCZSj7byO3eNMGhMvhQ9S9M4Wk7QzFZhdex94ec0Ko5AsrE8jhO/1sbt1/yU9YyksTBG8eOLtosHsRPj9UXz042RIRq6rMuhhuHHxr67KDFwIRrg6wz3E5xYaN8bpaZ30VeJrbZVeLb9E7XazcygbB5XzdMNCRqeSY2FUMa4Y=
Received: from DM6PR12MB3082.namprd12.prod.outlook.com (2603:10b6:5:11b::12)
 by CH0PR12MB5139.namprd12.prod.outlook.com (2603:10b6:610:be::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.23; Wed, 18 Jan
 2023 12:36:13 +0000
Received: from DM6PR12MB3082.namprd12.prod.outlook.com
 ([fe80::12bb:9697:46d5:c65d]) by DM6PR12MB3082.namprd12.prod.outlook.com
 ([fe80::12bb:9697:46d5:c65d%6]) with mapi id 15.20.6002.024; Wed, 18 Jan 2023
 12:36:13 +0000
From:   "Gupta, Nipun" <Nipun.Gupta@amd.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "eric.auger@redhat.com" <eric.auger@redhat.com>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "cohuck@redhat.com" <cohuck@redhat.com>,
        "song.bao.hua@hisilicon.com" <song.bao.hua@hisilicon.com>,
        "mchehab+huawei@kernel.org" <mchehab+huawei@kernel.org>,
        "maz@kernel.org" <maz@kernel.org>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
        "jeffrey.l.hugo@gmail.com" <jeffrey.l.hugo@gmail.com>,
        "saravanak@google.com" <saravanak@google.com>,
        "Michael.Srba@seznam.cz" <Michael.Srba@seznam.cz>,
        "mani@kernel.org" <mani@kernel.org>,
        "yishaih@nvidia.com" <yishaih@nvidia.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>, "jgg@nvidia.com" <jgg@nvidia.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "masahiroy@kernel.org" <masahiroy@kernel.org>,
        "ndesaulniers@google.com" <ndesaulniers@google.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kbuild@vger.kernel.org" <linux-kbuild@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "okaya@kernel.org" <okaya@kernel.org>,
        "Anand, Harpreet" <harpreet.anand@amd.com>,
        "Agarwal, Nikhil" <nikhil.agarwal@amd.com>,
        "Simek, Michal" <michal.simek@amd.com>,
        "git (AMD-Xilinx)" <git@amd.com>
Subject: RE: [PATCH 05/19] bus/cdx: add cdx controller
Thread-Topic: [PATCH 05/19] bus/cdx: add cdx controller
Thread-Index: AQHZKnmRfGvPVzFHXUOcaBUUcw80Ha6ipecAgAFpN5A=
Date:   Wed, 18 Jan 2023 12:36:12 +0000
Message-ID: <DM6PR12MB30827F763B25B96BF1EB1E3EE8C79@DM6PR12MB3082.namprd12.prod.outlook.com>
References: <20230117134139.1298-1-nipun.gupta@amd.com>
 <20230117134139.1298-6-nipun.gupta@amd.com> <Y8asSo2daSm5AWfR@kroah.com>
In-Reply-To: <Y8asSo2daSm5AWfR@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-01-18T12:36:10Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=38feb0c8-5940-488c-94b6-6cce715de383;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB3082:EE_|CH0PR12MB5139:EE_
x-ms-office365-filtering-correlation-id: 200f4e61-722e-4fe7-fa0b-08daf95095ac
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zl+draeSE1qwAiUAVwy4sZYKKj/t12JgGyABeDvcMrOowLSPo6gleiS8JFOTCp+z1jlLx25O417X8906A4JKJttnkBnSaCD17UvYF+EzpOpiuT+qBTXMd7nwGQdGyA60B36H2diMYEznvmj1hpvSeMeQ5ycSewnhtg9IigZZ5K/BbXbe4sUuoMMgEEI1FlWuiwUOI1T+fuakKd4X7JXNQjO01y11zYOPMzHCGI4VnzKtenVGK3EuZI0+fmaco9B3PNLMcKKtdR/xRIoRTWomBYOloK+N9JK6f0tFEnrj1WTZDqcJKrdWad2CCOYmaeQSFzU073H7Bodw7OxKlC4YmvUfM07tHrzodM70cfW/5XAPuGANpfWdD0croe6MfRnI5SVYZmeYEu6UBR2/mHQ7rFMd2UZOCo1Pj0+Kdlyl0V4TMBEjk/D0/F0PMYIrZcmJUD721FSvGMXfR35ap5I0imgWnChMM7NqSkLypt+0xd88Djowr0uC4GAh4WUfOqFm/cYzkgOTTJh0liC9QP9CPsxiym7QvP7LnEvESjw9MpnOheU/t2ilTPEYqn0Mt5R5iL7EkdXkFbK5z1sKWEzvlWtY6OvuaKYVrCjeIwH6Er7cu4Wld81U5a2tk6H8dDheSXzED+xRR8KoHSGHbQWT0zl+CxPFi9BVPaHr6RzIJFpqp+fltBwnQ/CnhJAp12aR8A6tInm1yQsL90KLu8tsQw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3082.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(366004)(39860400002)(396003)(346002)(376002)(451199015)(2906002)(52536014)(8936002)(5660300002)(7416002)(66446008)(83380400001)(8676002)(64756008)(66476007)(66946007)(76116006)(66556008)(86362001)(6916009)(4326008)(33656002)(54906003)(316002)(71200400001)(41300700001)(7696005)(26005)(186003)(6506007)(53546011)(55016003)(9686003)(38070700005)(38100700002)(478600001)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?noF0YesvFfF0jT2iPRYSFRHM+t7gQVzRmWr7S8/vL1PEHQgjxwLJynBFXH8y?=
 =?us-ascii?Q?CfcRXwJASQpK7i1S3k9H/tlH8SL2DsflVSpYiGj5GdzY/3EMnNCJ0JimAmfx?=
 =?us-ascii?Q?9biWo5mlYXFt4FRXvxpvOG81povJqUzvALW6XnivfAhCgra0SEWhr+tEnC+H?=
 =?us-ascii?Q?DNFpquGffR6igRWk3nxTGwzUfDKY7q9mmkdoIqLSjKNY8RRfrW4E25ZcFOVY?=
 =?us-ascii?Q?jOy/lQHpe6NWCz/3a3sFEeB7hiYnRCPhRUX111iBoGn+bfHBQHj3exHXmQh2?=
 =?us-ascii?Q?7yfv5fLs6dxgbLQo9PZv3oHLPeOO8h48g+rC/3KlvjegFIivU9SjJCjr3DJU?=
 =?us-ascii?Q?ITe0fPlPr5YZpF4ACiYN2G+UnqEE0UAjabaZm2t6Mf9LIj53jvZ4WvQSjup8?=
 =?us-ascii?Q?S9EB8AIlkRF4YBPGbnbh7a2LcpajikE2K4CdyGmHkVNGYwEKfdDVGmubySAZ?=
 =?us-ascii?Q?mtgpZxPPGWBWWIBEvyVnOdhzbGgDeBz5fb/rbbnwOOIThFknvVQzh5BLFget?=
 =?us-ascii?Q?15jQiEIR6NdZTqhyPF8xARP4FL+PwlOhXm3UVWpPoPCcqBqeIvvjCIuZbBH+?=
 =?us-ascii?Q?7bzFoPUXZzTo/zQO6o0atP1YgXIFR25DDv5qgc/fkJ+m583lWeOaTbmmL9Db?=
 =?us-ascii?Q?y9E17DXnaBFmRE6+aiuucei5bX90t1DyTDI6Og9i/Sv5c8cT/Osp/Ljw2QAl?=
 =?us-ascii?Q?ufrVDJwevQFZn0J0+8HIgN/SH7SLCNj7vsKaBrwTwobBvRpxsEdDwNwzqftI?=
 =?us-ascii?Q?S00EVEUYgqL3n34yCzwsVMAnCD/SWHgoMouZJ0qgE6q+VbtFNGU/xDSh0okf?=
 =?us-ascii?Q?tPzsUCS4qQSFgRoxMpW8T1pIwZsVVSEJMnkjMThqpFRO9dnzlRQ27y+24dMi?=
 =?us-ascii?Q?/RdZnsVn9gRc2U5frJ0yjTW8Sng5sc7QjrobQdVQGsSPyJllYFcT1V9O2oXo?=
 =?us-ascii?Q?+C3+kLHaYEfzrhb8/DRQJ2QUNEjF/Z6YsyU4/By5gjn1xZNLnCglpOApopUS?=
 =?us-ascii?Q?g0V2OcWWq4SoUuVn+OK0ZLy+7/DkoUHKjSzee2Q1SOAf0Rv4YUtUmT6ev28c?=
 =?us-ascii?Q?ozaYkjdHZui8fL70w/m+oCCq2thUu/eHcxHFVzRp9+IGyesoC+f41oPgcmyA?=
 =?us-ascii?Q?XEdyJJ55tCLoiFV4ziagZcWf5142j6eoNQRt5OcBtJWsWuKgu1BmcbJnJg4J?=
 =?us-ascii?Q?XM8vD9UzQZTQg9zOl/XPAVrVmcfK9L0yuAFx2yI2OIP9khg4QVPDxkS1y6Rd?=
 =?us-ascii?Q?2xzrrplmvETuhPQo6h1whhkU7OCIJRO6UEGnSNUCFgHGRR6BuZQwBeFVW5ks?=
 =?us-ascii?Q?85MbO6FcUJhFTbLy+Svl8VwJ/qi09+BQ8wfX5jKh7/1tcm+HJxK/dEqcPX5m?=
 =?us-ascii?Q?M2Yk1YbXog6N2j89VzYREb/b2v99mLkgoQJ3iawYeGk6jJ7SW4w5/GeDmqsw?=
 =?us-ascii?Q?XJvtMiHtyV8vYL3s945rMnrv7wwIGDG2v7w+isXKjHB40mAlJ41jMb2mz92R?=
 =?us-ascii?Q?nGpjhUFPFBfxuQq2VG/TGLzaJwP3hwtV6ddF/0KTf58VxAoPN0OWyZpYmn66?=
 =?us-ascii?Q?9USUOWNyU3CxnKk3cdY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3082.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 200f4e61-722e-4fe7-fa0b-08daf95095ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jan 2023 12:36:12.9875
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uIUmMVYfa9v/C9uU+fIHQHNqfs7b6lNawIe/cGyTb040+M9RGLaVWVeZMEz4rRNR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5139
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[AMD Official Use Only - General]



> -----Original Message-----
> From: Greg KH <gregkh@linuxfoundation.org>
> Sent: Tuesday, January 17, 2023 7:40 PM
> To: Gupta, Nipun <Nipun.Gupta@amd.com>
> Cc: robh+dt@kernel.org; krzysztof.kozlowski+dt@linaro.org; rafael@kernel.=
org;
> eric.auger@redhat.com; alex.williamson@redhat.com; cohuck@redhat.com;
> song.bao.hua@hisilicon.com; mchehab+huawei@kernel.org; maz@kernel.org;
> f.fainelli@gmail.com; jeffrey.l.hugo@gmail.com; saravanak@google.com;
> Michael.Srba@seznam.cz; mani@kernel.org; yishaih@nvidia.com;
> jgg@ziepe.ca; jgg@nvidia.com; robin.murphy@arm.com; will@kernel.org;
> joro@8bytes.org; masahiroy@kernel.org; ndesaulniers@google.com; linux-arm=
-
> kernel@lists.infradead.org; linux-kbuild@vger.kernel.org; linux-
> kernel@vger.kernel.org; devicetree@vger.kernel.org; okaya@kernel.org;
> Anand, Harpreet <harpreet.anand@amd.com>; Agarwal, Nikhil
> <nikhil.agarwal@amd.com>; Simek, Michal <michal.simek@amd.com>; git
> (AMD-Xilinx) <git@amd.com>
> Subject: Re: [PATCH 05/19] bus/cdx: add cdx controller
>=20
> Caution: This message originated from an External Source. Use proper caut=
ion
> when opening attachments, clicking links, or responding.
>=20
>=20
> On Tue, Jan 17, 2023 at 07:11:37PM +0530, Nipun Gupta wrote:
> > --- /dev/null
> > +++ b/drivers/bus/cdx/controller/cdx_controller.c
> > @@ -0,0 +1,243 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Platform driver for CDX bus controller.
>=20
> Why is this a platform driver?  Shouldn't it also be on some type of bus
> so that you can find it?

This is host controller for CDX bus similar to PCI controller which is also=
 on
the platform bus.
Since CDX bus controller is based on communication with RPU firmware we
need to have references to remoteproc device in CDX controller node to use
the RPMsg device.

>=20
> > +MODULE_VERSION("1.0");
>=20
> There's never need for any module versions once the code is in the
> kernel tree as then they make no sense at all.  Please drop them from
> this series.

Sure. Will remove.

>=20
> thanks,
>=20
> greg k-h
