Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 132635F0F33
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 17:48:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231442AbiI3PsE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 11:48:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230156AbiI3Pr6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 11:47:58 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2097.outbound.protection.outlook.com [40.107.220.97])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3C0A1A88D2
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 08:47:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JJfpOVyOGXzfoLwH2geCoxo0P2kB/Cq3KiAtz+VTYE2gmZfl1bxRnlEWj2yYaCy1VjyCJehiKolRHSchU6mcjIMg+nPvo9Bl6876tGeibodAX2mS5JUsmuF5FQNbrK3JNUGNfD50VpCg7YdCIhtJ7zf3QONxbkxLhAFdAG40tMgxQzewDbTytMdXsbqKAOf7t4foPvQW0L0ydSgFo6YZLCcxF1a26n8Zm0xGgb5ffZNoS5vFFbpefSwemPPTRJR9jUWz1drGtDdHz57Ggr9jfaQP/kICiak5R2dWSYJmXeP3/+GnnUPlArHfpJAzpq1UTsRNNMA7xXsy4hv1kPvscg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BRv4sehao+mEoYezsgfbTHg0t4iclwjORe2gl04VEdE=;
 b=Y/UEEChp9QBGo14XAu0t/KX5+Zhwr0eRJt00qeWjdhbAIQoM0LXaZpVG2G9nj3VVRBfPnECAbxutEjVjvhsKBk0j5qR6xy36zVYud5TGRwGPNS/8Tq0JQole3HKG5P6WZoWNGimiK9oHlpHmkKP8zXS8Eu/agTjQm4MSAzYC9xFRMKZG/ypGS7Uvhnkrh2FczSx9Q/NQiG5EHG60B+BK083oqCWGoDkRIvEKpty8Kpi6EyuCy0nh3KBlDcONdCzB+cldwW1JCyR98HKbCxD4DsRKfcMqh2ktaAq7TDTQJ5Ww/YXUYn4W9BVh+p+n/qWdpDU09zbccLt0UGFm1GCUYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BRv4sehao+mEoYezsgfbTHg0t4iclwjORe2gl04VEdE=;
 b=Ijh9GcldgSZ4DfjIfO8UQjQeuD7DFcDBbEom4lxAQcjhZcksLwwSCPjIERYsptyWCsSoUuNJ8utcNyO3J6s55018szq+mKyuNv00EE6MjJXNHNz6LyUqkF6+6jN28gKPSfUqowyOtp1M60yrVYJYbjmTIejFOcGZHeBuRZAh7qM=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by MN0PR21MB3439.namprd21.prod.outlook.com (2603:10b6:208:3d0::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.3; Fri, 30 Sep
 2022 15:47:49 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::17f5:70e:721f:df7e]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::17f5:70e:721f:df7e%5]) with mapi id 15.20.5709.001; Fri, 30 Sep 2022
 15:47:48 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Christoph Hellwig <hch@lst.de>
CC:     "kbusch@kernel.org" <kbusch@kernel.org>,
        "axboe@fb.com" <axboe@fb.com>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/1] nvme: Fix IOC_PR_CLEAR and IOC_PR_RELEASE ioctls for
 nvme devices
Thread-Topic: [PATCH 1/1] nvme: Fix IOC_PR_CLEAR and IOC_PR_RELEASE ioctls for
 nvme devices
Thread-Index: AQHYzwfnGfxDj3U900qrqA7s0JL6/63y5VSAgAVD9AA=
Date:   Fri, 30 Sep 2022 15:47:48 +0000
Message-ID: <BYAPR21MB168828B36AA2022585AC7AA6D7569@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <1663908549-118490-1-git-send-email-mikelley@microsoft.com>
 <20220927072101.GC16285@lst.de>
In-Reply-To: <20220927072101.GC16285@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=fc4d8d24-1ee0-4128-9151-498ed02a7109;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-09-30T15:45:32Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|MN0PR21MB3439:EE_
x-ms-office365-filtering-correlation-id: 1a377236-95a6-4dce-b965-08daa2fb1fe3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZDeT8nXODC1Lv9T6368nXmUZjXOjAgwSuTsgM16ax2qG+xB8NH/KrgfJE0rPUAdjrYVjTM3reVX4cuDZU0fdfMmKDCWbJ61so10IfRTj2C4HGfzlQ4mNprONHDj1ikOt6v66lSxKPl46Q3kEEq0p0qDe1cDcfaVtGDlDUFXjPTbTQm+vI5k22kt1NlOi/+vX4FHxL0PpnybvAjGGNcp/rzhzywU0mHckKGDzHLhQzL/abqyubngzChVYWao5Wdm52fZRw2U4yoc8YdTpUB+XbTBApHx/8vknaBi1RlNat9cBP1rWl7+9LSRfa/oLXPuRNWJv1ByiMrBHgdgDtHPJJI1AEs7h9+8e4eOv6FTrZxpCC/lIjmaX+Y/hL7nFnEvxJEccH9Scf2vM6ITRXrhxo3b+YoW7WXBywGiYmfz5B5Z1Zbh4meHkwX1dIdpCLQ0DXZpfWauxULwRHApTfkwhOPY5gr5AU0qm4K/FTF41WMj7BkLS3Du0YjDzERa9SLb6rhVSm2AOXZkXDqKYKEwOkX+QnS7oL86Xji/5XDoJWyaJ5WWsspPJaD+R012OnXcoR2zjdVVWKFHN2f0ngfnii+amcw/py9uxeEu5uxSx8hQJA3pR8XeRYHd8YUwkaC6RrHRbgJVvAXv1Yztkpc3RgwuMpmVa+QAy4UG7VT6UopMFR1qrFDyKUIh5PRWTktGuf9xKw5enfak5Lz8w5VCwD84MeLjR69ExJDigO3fjAH3EKBztMtE34Y96kkkRBn0yC0FuamWhK0Bdu/O0yL9GJ2uDtGkjN0C61NdLh2yF7hckLD3xuVJdaRXjgNBNvHc1
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(136003)(39860400002)(346002)(366004)(376002)(451199015)(54906003)(6916009)(10290500003)(86362001)(55016003)(478600001)(316002)(71200400001)(52536014)(53546011)(26005)(8936002)(41300700001)(66556008)(66476007)(66946007)(76116006)(4326008)(8676002)(64756008)(66446008)(5660300002)(9686003)(4744005)(33656002)(2906002)(7696005)(6506007)(186003)(8990500004)(122000001)(38100700002)(82950400001)(82960400001)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?fgB6DLLP8hGV9WgvZYM6YRjvfQnclfO8yx/gw3Rg5rNNDhLEq/Ann2Qm2mVc?=
 =?us-ascii?Q?/P832yO0dPjMov8oTgPd/zUaDCVrLq42zPPMCgCdI4PxSf/FAXwdxFMPbIIi?=
 =?us-ascii?Q?7rYHnFZOZTmI1VFWB9mvCDCd/nP6aPPMnely1r/TPwycuGNXaUNMG90K45fd?=
 =?us-ascii?Q?gWuDlLpBjGzEq+cpdyEcEgglArf5Gxfaea2ye6eT3RtpXglZboRzfoIyKtMF?=
 =?us-ascii?Q?TefSqjRVbXt20RiStUTV0y4XIqxTf//8udYDFbZuvIITAXoVcWnmfwdYH29z?=
 =?us-ascii?Q?jm+fT68PHhEElE2fkD0ugcjLmtv8QQ+9K5NISb+CJIHE7oPOuEHyL7vwurU+?=
 =?us-ascii?Q?hj6GEozUbkAf4kyPDBdFuEid28gJ4S3BZHy8ZsZyDr9Z54zunzP485WBYTPD?=
 =?us-ascii?Q?EpP7whzvrgfwHUO67SUqT9sN2JezZXRf+Huo9xh0W2wVS5i6ctARWsW/ufAL?=
 =?us-ascii?Q?Fre75cocK8GAmxmsdTCDFgNdbxFsJaY48Xxg5ZZN8yZ/99YSoRV1raUnwAei?=
 =?us-ascii?Q?YlpbtYfhTd84OtryNBq1Bh3BtPX2nIyqVPgZ3WwDbNzdIcUZdlMvhGnvufn7?=
 =?us-ascii?Q?6M00nASKmAx7KC+IxgY4obzaWnrVggo3vqFf9LRPH7tnZ6iUqw8nDzkA7nP/?=
 =?us-ascii?Q?KHd1mbbe9WyKShKlnJ/n19/F812FvWy4kw2Mi2/lpgkMYl+z9UHQcSvVu8gX?=
 =?us-ascii?Q?ZV7DbF12XhPUUCoij6MkD9Fv1EpNKTabRvbyjECNTh3+2b2vXDz/5eYQR1MM?=
 =?us-ascii?Q?ulSB8BpNF5fxqkyy1V2vSyCNU9oUpQFdH8AgqFRKr92UdAiPIk/Jp4G6MGyk?=
 =?us-ascii?Q?qRB0bKzgpMIB5up3evo+CXxpLS67TyiPjVL+yxx4WZvsklDCerb+fVmxXAIb?=
 =?us-ascii?Q?yY0O1UJb8jXAeNQpIqYJOdSiopb+c0hfeqLjTipKArTkZY0OO0w11/v2Yn9P?=
 =?us-ascii?Q?qLzNE4CwZ48EO05Q88M5Qqm9oKwSeYPVuBUWCbP40sykuqDFIS13lTLfHyqd?=
 =?us-ascii?Q?CnSr5nhfakLhAi775LLbAhHp/vuQOZo76Km5JtUp/KJpz520DPRLadlDg1a0?=
 =?us-ascii?Q?EufyxphOnNks+dJYYgfQ55D252FgrWOGZJT7N1+wHikpSy96yqWPscPovI9H?=
 =?us-ascii?Q?b99xlGORBTbpnNOb68j15Ss2AoBH6rmH3mFG1jAlRQgrWwpb56tIomXhm9EB?=
 =?us-ascii?Q?uTPzlFlgdqqq180f4AGKyYoEV9+oKerhBcJE0ABF2K1YazvQ2zt1dLoqHF7B?=
 =?us-ascii?Q?5mBXKzBuFh3gLKgLtf4H78Tv/Y5J3WS0dsh0OMcOolP9vscMZWtqXSErvkSp?=
 =?us-ascii?Q?IIPogWH7vq+jHCiLuw/3tYVNPUSt/oE4BaUskJ7GXvQOHIKiS4vbSXZ0TRgk?=
 =?us-ascii?Q?8y7BvT/piwYs6hsSBzrh42BRYMDPdcn+67R3sbSpa5EHgbgq1GgFGfKgykix?=
 =?us-ascii?Q?5Yqm0rNTQywEcH4c2t/uOBAD4Fi+rAKRPb+eFZawlGhGmepaEtPYE38wrVnZ?=
 =?us-ascii?Q?v7XFelOQbCrxpFbn0eM41qyr9foZvPcMOMozGdZqdkA56RwVgPSUe2qoXd9c?=
 =?us-ascii?Q?N1zIwLFBbUluW0O0Gh9ydSCfgbFEETVipVk5jcnsrLQWqNkVlE/b6Q6SpsZW?=
 =?us-ascii?Q?yw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a377236-95a6-4dce-b965-08daa2fb1fe3
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2022 15:47:48.1542
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: u0wU1d27AUs6BpbY/KcrsJpBelzDaw8m1vgf46af8LyDefeudNzH/Hy9A1fkKWTi4ZXey6I32wD9lAdN/v7cnyXYJ7AGtk9l6z9WVINH2DQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR21MB3439
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christoph Hellwig <hch@lst.de> Sent: Tuesday, September 27, 2022 12:2=
1 AM
> To: Michael Kelley (LINUX) <mikelley@microsoft.com>
> Cc: kbusch@kernel.org; axboe@fb.com; hch@lst.de; sagi@grimberg.me; linux-
> nvme@lists.infradead.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH 1/1] nvme: Fix IOC_PR_CLEAR and IOC_PR_RELEASE ioctls=
 for
> nvme devices
>=20
> Thanks,
>=20
> applied to 6.0.

Christoph -- where did this get applied?  I'm not seeing it in either the l=
inux
or linux-next trees. =20

Michael
