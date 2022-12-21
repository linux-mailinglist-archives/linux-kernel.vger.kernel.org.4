Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFBCF652EC3
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 10:44:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234599AbiLUJoZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 04:44:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234598AbiLUJoP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 04:44:15 -0500
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DE9821E02;
        Wed, 21 Dec 2022 01:44:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1671615853; x=1703151853;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=3jl2km6uswmPMXCJ+iIbkqKYQCjHCKbxqOhwnPkmvDU=;
  b=o6wOr64zh/QX11tbIA5Z3g0u4T0TT0rygBBQKoYlBuNi8DjO4T42/73E
   wULiRsvgLr/kvJa7IkklmvO9w0EdVu62ZTHO0/MvP8cfrMqn17+yCjLaf
   XT0RuOrhLSMiq7jhAOXHDY1HrGm7fcRobZxFqTW1Qapsqov4YMA1GB7gB
   QeNHUJ2m2tdQOsPM2MQnAn+B6h/OXzNsxVaCiouIBwbSdAaxbgDhpu2pX
   IRD9wf+VUjeQJ0PYgbNqT5LDnxTYjXcVLAILmjUIL2rjKlOt7wGX9L4P0
   HaDqSL5cGaAadbreL8SEe+JP0nj0Dztb9OEfvGcBjoyHhfqtSdAUJEGSs
   w==;
X-IronPort-AV: E=Sophos;i="5.96,262,1665417600"; 
   d="scan'208";a="217386030"
Received: from mail-dm3nam02lp2043.outbound.protection.outlook.com (HELO NAM02-DM3-obe.outbound.protection.outlook.com) ([104.47.56.43])
  by ob1.hgst.iphmx.com with ESMTP; 21 Dec 2022 17:44:11 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ECQ2JbvjOBUMjzHtJSAjl/I76CwbMgkpww7jkaVX7n6gXzWXbMdarWhMOb9rU8IdYBCbPdWaI2ell/aP9uvakhYNFuJcfoo2dqHZYYO8+cg8Xu//3oXoTdnGySEOwNynhfZFZoMngPtAVIEAzYhbPi7KIsMKuypTqTU/hnRkS206IKegVym5lo3yXCPHywGMkAAtEUXc68T7pS2QAfQtLunDV7ZCZCLb4Hc2v8vSl6TDlqIzT4UCascFCadrL/76w30rGWasANwEZ9/Ngey8fqRd0vkXNzONe4flWWm/piYJ6QZ0gH/AzbgNy5BzYHRbu4SuR/3CrvEPw+a9Wc569Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HJLWF5WhaqwFd1YSNs0kyZ3F2kKqvrg95F0KUI2WQLo=;
 b=aUkxbU3pIktmY4AYD1Q+NjmWwry7MWuOyTdxe/1/ikSaL4cGQ0ZNg8s3foYWpRi7xgLsixRMJD/+176A87GvGWvS7KVCYMxPGGDufc/W+LiNvIfNkzipJOmwsMTpW+gzfQ94CglPGIqO3ON8zAgmo+R95ZyJHMK6f1sfV0wJqKg9FHqOuC24RQSmFYXkjce/sEFN/6IlO+1S8ffNhU/ZrtbVMD/4ne7CYYwNkL9cRG1o7vBIMp9yUXILMs/9oGmhB6J7Bjek2wXAPzgbmgCbqYedMy/KtWTWKiNhEGJsXuFSW19BFpvnn9sx0yGrRSr9V7hlC+Gq5Q8xHGOnssOVFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HJLWF5WhaqwFd1YSNs0kyZ3F2kKqvrg95F0KUI2WQLo=;
 b=e2KWsQT3tmFD1e3aFueNzRfX4/zst2RyppMxLCX+zSgq8idvK8UJbOgX43emX5/mh1StYaAnN///3m3BtcHxZ1iL89jdRimEMP/eWg4PXvSjykHDZ44gm86sqjj1ar3aeQcWqivFKaLPrHz27U7DE0gI2CI7VpxOGL0ZQkQFjGM=
Received: from MN2PR04MB6272.namprd04.prod.outlook.com (2603:10b6:208:e0::27)
 by DM6PR04MB5787.namprd04.prod.outlook.com (2603:10b6:5:164::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Wed, 21 Dec
 2022 09:44:10 +0000
Received: from MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::a65a:f2ad:4c7b:3164]) by MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::a65a:f2ad:4c7b:3164%4]) with mapi id 15.20.5924.016; Wed, 21 Dec 2022
 09:44:09 +0000
From:   Niklas Cassel <Niklas.Cassel@wdc.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
CC:     Jason Yan <yanaijie@huawei.com>,
        John Garry <john.g.garry@oracle.com>,
        Xingui Yang <yangxingui@huawei.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxarm@huawei.com" <linuxarm@huawei.com>,
        "prime.zeng@hisilicon.com" <prime.zeng@hisilicon.com>,
        "kangfenglong@huawei.com" <kangfenglong@huawei.com>
Subject: Re: [PATCH] scsi: libsas: Grab the host lock in
 sas_ata_device_link_abort()
Thread-Topic: [PATCH] scsi: libsas: Grab the host lock in
 sas_ata_device_link_abort()
Thread-Index: AQHZFIO30NsjJ+GmMUOn/YRyM/YoSq53f2GAgAAjbwCAABWFAIAAK2AAgAAgpYCAABQpAA==
Date:   Wed, 21 Dec 2022 09:44:09 +0000
Message-ID: <Y6LVaE5e9iZNAYrF@x1-carbon>
References: <20221220125349.45091-1-yangxingui@huawei.com>
 <4ec9dbed-1758-d6b4-dc1d-ac42e8c22731@oracle.com>
 <c8387766-2ca0-51f3-e332-71492b13e5c1@opensource.wdc.com>
 <7347d117-6e0b-dd18-90a8-25685f757689@huawei.com>
 <4ff0ca00-31f5-2867-ff59-cecb5d6d1048@opensource.wdc.com>
 <755d7a9c-427e-024a-8509-449ebc5a00e6@huawei.com>
 <f77c7872-3711-2216-c17c-e23591f745c7@opensource.wdc.com>
In-Reply-To: <f77c7872-3711-2216-c17c-e23591f745c7@opensource.wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR04MB6272:EE_|DM6PR04MB5787:EE_
x-ms-office365-filtering-correlation-id: e19b6e84-08b7-4779-5c70-08dae337e8df
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +hsP7dPen0pZV1EuMGBzOctaoXBXmxQ/c5HoYPcPEMVFq9oKZABD6AhdNagltPZ+imrjrQAQs8hTWkby1P6UXc4ZaCD2s9Ctq1fjMdjQJa48kPIu/AIE6Dgs8/XG2idyeJzdFsY+BTPLGnOfwdVPLhsjufP4z4c/KMCnqezOmORnF1eblmrdEFvWANQ4B7TcYrcGWSItwNH7rZwcy/4b2y8Om7ymPUYSlDIwpoVPajsXkJ9Oow403y+Li3a57nDF5dEOmWG2a/HmjBuW4oOMynn5ocXIlOvaWDY3Aleum6X/ylvJw8nDK8rIpArS+zuspZokAb34hClbAx3rj+jBQy7x0iUHlVcEOJ2ngZDGQ9QRhq7GS1x2GAoUtEmS0ELtmYzdr/WOX8fDCq4/zpKatLTgd+DYklTFzKvlKcaWzxs0p+xCVDg+Rm+Od+YDqn9BhihKk0B0t2JpfvcBqAU5hd7xuW1Hty8ANMkvJFaDBe1cfFxOJHWBUukUdWmdXNtXpl6UgCXkQ0oZNlqU2r2bPofU/dvBfDBN6mBtDq+BLihozUk6LRUqtbWF0D6ro+BS5fOrNT/FBrpm6nyNZZRnfXSksiJ/Fv66g5TKFSdNLneNG4qRujzt2Gb8Bx9frw1TbDfofubkdSun/IHEr6MLSRfh9hMnJ3DscEBf6KxaGEVY4OscA2NsqoHFVkH1zdvo9o0HlnwMwdsWL9AvZ9ZhM8SXZLG4NwDgCEOhgl6FU/F4FV/AOa5WNu/6hbPELIMIVdTIeSBKN1AePvX0Az6zAw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR04MB6272.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(4636009)(136003)(39860400002)(366004)(396003)(346002)(376002)(451199015)(54906003)(6506007)(316002)(38070700005)(82960400001)(33716001)(966005)(66556008)(478600001)(6486002)(38100700002)(4326008)(8676002)(64756008)(91956017)(66946007)(86362001)(122000001)(76116006)(71200400001)(66446008)(7416002)(5660300002)(66476007)(83380400001)(8936002)(6862004)(2906002)(9686003)(41300700001)(186003)(26005)(6512007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?5Lull3Lz5U48/xYqQvHAxttXgNQvFjx4JCzEf0sd1T8GTS1lR8N7PxVYmt2e?=
 =?us-ascii?Q?LEQPSu+L031N5RttkgNovSiCUryzYXQK8XslxMfQGUAa9VWcQtS6Q9grZznz?=
 =?us-ascii?Q?nlfKQPoKA2H9+8HsYW3sqy/ic6iez7/gwFjOfbcy3HgN4onLBomfvJsx4Gh0?=
 =?us-ascii?Q?NSQsSfVRI/5VBmhYgqydK1YqD6rYbon/hGG92zaJh6W9KxuxMeeWsibVxiKi?=
 =?us-ascii?Q?HMP3RGyTSsykrzFzev1VzdgEm1zeM3N5Wlsa1Me61XCRC4ZYeS/nR54o+rKd?=
 =?us-ascii?Q?fWgpJH4lfLRkHcJyH+K9RM9OIukNi/mJowJXHETC59XqONE04QMXJ8G2UWI0?=
 =?us-ascii?Q?2cBqU6RZ99C+ItyKAhuoLcFh5AW2R7dzqJFQa8wEJ7fIBcWjXIwkm4xk86UE?=
 =?us-ascii?Q?XvaPf8LcgBVCBgae6DQnMWu7vzCD7FvBliufNXMnU6FfzIjED64WfEDUC+Ii?=
 =?us-ascii?Q?vTaH1DRilSX2afBz28RYMhedKleYL5sAgEhPMY1n0l2RAdn6JUD5ovYwgmiP?=
 =?us-ascii?Q?qSg0GXOfQ2RPqGX8evdHufg3wlOegBbOH32lELrkbf0ZzyaNcnIS/+qNduYJ?=
 =?us-ascii?Q?L1epgY3fh8uvyB005C29Je+KpMjSrysIfX/PhQbN1daljVswhUy4ju8tNjs7?=
 =?us-ascii?Q?CdI5Az3dsZnrVjkJ22OH/c8xhpQop/3Ie+UWZJoJhZJpnIOxiwjsSQDdvuZc?=
 =?us-ascii?Q?wmFtd1WkOjdXjQ6qnJuMmcQKp5f1PEAOCySqsHJ70s79TV8QRtBUPlrdIQDI?=
 =?us-ascii?Q?7f7AbBnWxF02C0SMi36XX9qEoCHZ0NTjiuVFYIORZ49B7JTadtQPQYyDjtnm?=
 =?us-ascii?Q?YPpmZyzkBM3NwgnRuoRJe69RcF9DRrbJe7k4mCbKMzW80Rzuj076tFyu9T2B?=
 =?us-ascii?Q?1EUY/hsbNIyM+LZ67KkY2v7/il8+2QZNBYPB6Km3TSQUE96D0AhaR06na6Zz?=
 =?us-ascii?Q?kv49G/0W6OtvNuHvWxK0Mh2G7nl8B1IGywVDNVQHaL4eonMb+KqWaF9SY50A?=
 =?us-ascii?Q?TFqk6bPEesXKLvhBUsFBqPRNSLYMdj/1lmXeJdqW/R+zMf+BVZYBuHtfHTbc?=
 =?us-ascii?Q?TAtQqy11vD3FaAOeQUV+Vo/ovixuVeZDa1+PpoCMAUyRQIXvdNOxM1r4ai8D?=
 =?us-ascii?Q?o7hayWgGGCy+0fPBHIGK//TkK3CDCUmEDlBPzXm5WBf9mUGapO+YUQ+qg7zx?=
 =?us-ascii?Q?aWNsfPxANBNM8pIinX2m+m7d8avNwaQ6p7pWp8UlAxfBaixLG9xTDFQwR1gG?=
 =?us-ascii?Q?CDJUqeL54uPfwa69RlzsjyZF0buBieyWRtrMr5bYmVYeq0aYm/IEaTD/qXZQ?=
 =?us-ascii?Q?a/ettR/EhkdabGuFNkp8LmP6oMFclVqlgxKWzSNPOkKhoPvwfJFItBCASz80?=
 =?us-ascii?Q?kIGW1XZZDrbULp5EuksNWs9kjRTOrjMux9TbUUK9XJJUDc67+lqoILLq4XiH?=
 =?us-ascii?Q?YOqdpaMGvHW5zGKoRqbjIDA7EWZleqp0r5g6Md78En0iWlTeFJ075Cv+NJ+l?=
 =?us-ascii?Q?itlFkD3gZn9X/mtCe5iG2/Udfb96JjO20CqqgzEBnmODLGc5Y7kCr8EDEs88?=
 =?us-ascii?Q?h+URVEKYUEUlPH9jWQp51C74OrIkJpM7ZH0GHERAT7AckrnikXNEgVKVA4u5?=
 =?us-ascii?Q?JA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F3868AF68ABB744E9D3684C2BFAD596C@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6272.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e19b6e84-08b7-4779-5c70-08dae337e8df
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Dec 2022 09:44:09.5536
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gPKUrOdV3oIHOcH6Sq7Uq15lT3z+gPtjvhymP1WguqHHsqiZah5PCrK2Ke+jK/+bpdEX+2gnqUDrXJVGZ8ynbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB5787
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 21, 2022 at 05:31:59PM +0900, Damien Le Moal wrote:
> >=20
> > What about the interrupt handler such as ahci_error_intr()? I didn't se=
e
> > the callers hold the port lock too. Do they need the port lock?
>=20
> It looks like it is missing for ahci_thunderx_irq_handler() but that one
> takes the host lock. Same for xgene_ahci_irq_intr(), again no port lock
> but host lock taken. And again for ahci_single_level_irq_intr() for the
> non MSI case. For modern MSI adapters, the port lock is taken in
>=20
> For other cases, ahci_multi_irqs_intr_hard) takes the port lock.
>=20
> So it looks like ahci_port_intr() needs to take the lock and some
> cleanups overall (the host lock should not be necessary in the command
> path. But nobody seems to have issues with the "bad" cases... Probably
> because they are not mainstream adapters.
>=20
> Definitely some work needed here.

ahci_multi_irqs_intr_hard() takes the ap->lock before calling
ahci_handle_port_interrupt(), which calls ahci_port_intr(),
so I don't think there is any work needed for multi IRQ AHCI.

For ahci_single_level_irq_intr() the host lock is taken before
calling ahci_handle_port_intr(), so I don't see why we need any
extra work for single IRQ AHCI.


Remember, while the default is that:
	ap->lock =3D &host->lock;
see:
https://github.com/torvalds/linux/blob/v6.1/drivers/ata/libata-core.c#L5305

In case of MULTI MSI, the ap->lock is using its own lock:
https://github.com/torvalds/linux/blob/v6.1/drivers/ata/libahci.c#L2460


So what is it that needs to be fixed for AHCI?

I haven't looked at ahci_thunderx_irq_handler() and xgene_ahci_irq_intr()
so I can't speak for these.


Kind regards,
Niklas=
