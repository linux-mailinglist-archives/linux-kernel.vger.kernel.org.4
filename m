Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E47E600CEF
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 12:52:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbiJQKwg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 06:52:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230061AbiJQKwd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 06:52:33 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49AEA606B5;
        Mon, 17 Oct 2022 03:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1666003952; x=1697539952;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=mNgxW4K7g+j6bJL8oBIzok44qPe4GsjQTj24QbS1bP4=;
  b=kp7JmEQJElFSZIVi6ifvyeaKj3vl2MtKFrePNRZYZWL2Fb+/NE92Ny6J
   fkiKhN9+FBzsh8itWMKraHiHvKcl95YZV+t9no/ipvT0py3cS53O4VV1Q
   Eou6WFkNtfakHHH9GEa2G02lNvx4/1+Dccn/Wh4S8/ResDrw6GDIkG7pN
   4Ov/Cu8ucoW3FzRB0BJPIViwJ2w2p1iYrLLtc+zrcqUWbVgsptiXIXgvZ
   aaMvymxWCLheK1xZhyZ+UTWtsJTck1dUbd3FVFGFMbrGroRaKk1ln3Zgt
   JHXCqEtw6ex56KYuAoSC9gDZuWeeEOMSkgDhFKmCXUhfxw4YjqjwpeQJb
   Q==;
X-IronPort-AV: E=Sophos;i="5.95,191,1661788800"; 
   d="scan'208";a="214396490"
Received: from mail-bn7nam10lp2105.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.105])
  by ob1.hgst.iphmx.com with ESMTP; 17 Oct 2022 18:52:30 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qwoop4N0JpE0HQEZrI9gRYQ48LpAYcD/64a2EEgnVhHJMzYdNNx9sYod9Pj0n1BnRSQH582j05kr0dLSGr0qKRIOv/yXYK1riExcYMkV+a48/lU/MMLeg5l4t7L0iM6pNK6PSV1vg2dEaX86PNU6uW/OapwACZsk7s6uqxpgpvaiYctHmGi38U3ReB+j5NnE9FPsX7B7ZyMu9yr8OUADaO7F/azDBMGnieRAodwJ3Cseqjot4EtWIz6kawGQnRIcwGuS30oz0ao64PDltNCUO3FtXxcd7cXtze/mMc4VkrVCPasHRL7aGBaZYzaUcjTRyoArW6u+VlRrjvDVvI0T4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mNgxW4K7g+j6bJL8oBIzok44qPe4GsjQTj24QbS1bP4=;
 b=TGNJLkpQ39CM49Ix3jcLpaUwchFuVXDK5MxUvSn22s+CablL8baCYHXzLQtR4lBl4tdyCSmB2UYDsSIixG+TJ6me6VtCyJsH/eQxBwZ25dkjIHbUrtmm/hvp9yeTEGoJl6rjhzVi6IrDUX5BJEYC4y8RmDDQ7pYl/TvWSvw+uumz/sx0PUBciyN+F8rHSi2L7Jtu1200vZWLnFvg8+R8Ap4iws4D5djVvhNCd+bSCQqAM2lRxKkVRcSrsQK8FX4EQ6BgUCN3dWQB0V+Jg9UaI5+N1eBY6qWMiQ1lllRLVLaFGVR4DIA5wwcmK8TIs+nIgRoKLkk4SEpAhVqhLHwOWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mNgxW4K7g+j6bJL8oBIzok44qPe4GsjQTj24QbS1bP4=;
 b=AX+CxCdiY6IuNIkFSZZ0wFiKkMTWek2UdhpLjdeuF+T8Hf+jHZ/dNSWvzWHdGUvXUwjDsSYjzHz1r36FSmCp+h2ayBWrFAsxtn1L20oWxbJIa/3UR1gynvEQfOC2CsNtkJDMYpAAahl/oq4XtVq8lr/zzrqo9XDCXfB8eQKPQyo=
Received: from MN2PR04MB6272.namprd04.prod.outlook.com (2603:10b6:208:e0::27)
 by DM6PR04MB5529.namprd04.prod.outlook.com (2603:10b6:5:126::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.26; Mon, 17 Oct
 2022 10:52:28 +0000
Received: from MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::966:8440:b721:5425]) by MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::966:8440:b721:5425%6]) with mapi id 15.20.5709.015; Mon, 17 Oct 2022
 10:52:28 +0000
From:   Niklas Cassel <Niklas.Cassel@wdc.com>
To:     John Garry <john.garry@huawei.com>
CC:     "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "jinpu.wang@cloud.ionos.com" <jinpu.wang@cloud.ionos.com>,
        "damien.lemoal@opensource.wdc.com" <damien.lemoal@opensource.wdc.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxarm@huawei.com" <linuxarm@huawei.com>,
        "yangxingui@huawei.com" <yangxingui@huawei.com>
Subject: Re: [PATCH v6 1/8] scsi: libsas: Add sas_ata_device_link_abort()
Thread-Topic: [PATCH v6 1/8] scsi: libsas: Add sas_ata_device_link_abort()
Thread-Index: AQHY4gV+7g5jXbze8Uy/Hj5IPrr9tq4SaQyA
Date:   Mon, 17 Oct 2022 10:52:28 +0000
Message-ID: <Y00z68i9V/p/0tuI@x1-carbon>
References: <1665998435-199946-1-git-send-email-john.garry@huawei.com>
 <1665998435-199946-2-git-send-email-john.garry@huawei.com>
In-Reply-To: <1665998435-199946-2-git-send-email-john.garry@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR04MB6272:EE_|DM6PR04MB5529:EE_
x-ms-office365-filtering-correlation-id: e4b9cd9d-44a3-4659-0e67-08dab02daf34
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FPq7HRdVaJ8hFgThubCtzn0ryM3kt9OvRSbeM59M5JNharDFMDx+BYNih9YFib7BqMPAsAQ3qsvq3kQ8DcnqIkaHUc3xgkqJAOHz+oQl6uJWR/hahqKtaDq8vtOuII1pourqWeEwIjWKi52acRPOFz1RkKh2v2hcXZ5ySGfmseXqZ5OtfIHsVuqshzYzywxdiiumJBmfBljkXqQRSpnPYb8rskLJtgleRTBWjis5MZFsvh7BaJnwthJpfc8UMFLn/g4Zg5Zd5ceXp+TpiTdhFSsq0HAsgiT29Z3DUZsXyNzln+kYVqBgA8rVZgj4eJkAObYhoWUeHgf5kYVXYAS2mY6B5kqshaw3bHC7sC03vIa7v8leHwCkOnVtKxTLYVnRGJ1VxWpJfoOO43m7SkbbJeUhJ/8eJGCf75nG16+GjmksLRE4FqfeFurv/Ec8qDSpHOgzcXuBwXym5DUaMCpqtEKy0wLkDG3As20vJxbXSuDFNxvc86NP24RGOQVWETXz19pqPG/Bry2+mem407DjXbS3on6K7EvJlxBT4L9ay4n8gxSmWHd7CRXwZTUUbQUPIUi2PJcGyzaIrs6K4DRk+GhVKODeoRsIEe4Wvr39tsK5PKJuRn8fhmSnDQpEN1a6TJqXy77V/N0w/ImCdBtgVPfe5R6eqdvBq0/7RO7XgLvEMqjeX+thtq6Ec6Wurr+bbjgkHHO+xzghNVBa+pDjofM6nucjKsoNBfbqTmuqaP26m5YFHQOi7z10J7U36PcSk8fPyGjRrU5HKeLWeqa5+A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR04MB6272.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(7916004)(396003)(366004)(346002)(376002)(136003)(39860400002)(451199015)(6916009)(71200400001)(54906003)(478600001)(316002)(66476007)(76116006)(4326008)(66446008)(66946007)(64756008)(8676002)(91956017)(6486002)(66556008)(9686003)(6506007)(41300700001)(2906002)(8936002)(33716001)(6512007)(5660300002)(186003)(38070700005)(38100700002)(86362001)(82960400001)(122000001)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?79KHopc8sRiPRVtYp+qGOn8+PQ6CH5cuQ/K3DZzfmwUHx0ZlUkT6rZ1U3a21?=
 =?us-ascii?Q?TaeVCZGI8B3OBOxrehbB+Fbl4fFW/ONSOZsH8Wx2dQEoTSqAgY1T3bhVGyny?=
 =?us-ascii?Q?cKd1EiuLxuyPMUdkDaiN+YfEsBi0YBNy56hW6af2DyfDdgqxVZlYx9hz94Mt?=
 =?us-ascii?Q?BJ9GHrAeFqUo2uLqzriIkZWPrJ9f2BxcNvVYrG3EhUIMHawW8aJqT6UR69wO?=
 =?us-ascii?Q?dvEZ0hDNND1r5/EzW5SiAINo6+2nB4LUy373OzjY0lU9+T7/ALOHi0a1Zjfv?=
 =?us-ascii?Q?72IBDd8PWEK3C/x3KBEKOni2kD+OKxeor+6JHbWIXUqw1EuQMtwfK4WkwCLQ?=
 =?us-ascii?Q?erfwG5eW92KnGzDnQw6L3kuySLTmXAxS/MhzjfUvRjf11B058lP+tdcnQP29?=
 =?us-ascii?Q?DmeFwgZox9wbYwLuxHVwOiDXr0Pqok6W+YVp1BRzdhLJlFe+s5cIstq0ayWL?=
 =?us-ascii?Q?q6j4DfEmfceBEmHuMLv3NmLIoBpnVoLFvSyDh2CZn+qwojmbeD1cUe/jIB4x?=
 =?us-ascii?Q?/Rzmnr9w4xUlEG0L2aAT8WGRLmH6U3zMAca5xNuT7ZXULLTn+zLpGXRfKcVZ?=
 =?us-ascii?Q?lZ1b8DAK55gc851SzsezOjjumTG3HLVlr9fjF8oUt+UVuvI6d5CJERQWteXM?=
 =?us-ascii?Q?l364GkTXfNEC9zLLAmJfV7sWKlwlKj9h4cpghFAg28kcPl2QxIgDSi9IO6DN?=
 =?us-ascii?Q?6WyUxs1C8/rlwEYT1ycnoiqR7JPJRXaI55n70AuXMCfgmUiQ8Uqsii8zkEu6?=
 =?us-ascii?Q?HczjSIeyBAB9kAvlEDdDiEmM9yQ6f5wyDGIrrKgtrLPoFDNnoM3hIADtoZ5a?=
 =?us-ascii?Q?ooa3dpIUMQ5+zJ0N0yf/eBoAYLo3WckjqZ+oxSJnN0hUrgcPPRre0a5LE3zF?=
 =?us-ascii?Q?SIjQFF4fdk+Eut5q+bT5zT1HqBEg7XTDz8ZO4FUrrJh3z3i3rEhZr773NsNo?=
 =?us-ascii?Q?6SNIe4g+ozDyDYiHPXPtuytdVMFpBftdtGvPizWw1zj3Z9Z5n5lRC7KnRuCP?=
 =?us-ascii?Q?pjBlOMstu99o+UIHRzmgb6PD1hrZbWjpbw4INQQ+CNBWRDhpw/+TFdt/2cCt?=
 =?us-ascii?Q?6dns5nCVwwa+JZ8c4G8PeJGpYAZj1vks6wm00q8ViPyqSseS5c80nGTGaJRL?=
 =?us-ascii?Q?1SumXpEaHYU9AfXh96CjO+w3D/Mj8yGdjt1+fsg0to/ug90zlaWUpuQvayCk?=
 =?us-ascii?Q?WaYhdQKbk4Sx85/n1iBnJWo9xBx2b57yF7hKjdjXaB/woxJ+Re8TZ6el2ecR?=
 =?us-ascii?Q?VNcmo5vD5lja0d6HRUyXeKuTvmOYIZjqyoZLXQTtaLkYdp2o2FShtSX9ld5A?=
 =?us-ascii?Q?WBaKsvm1itW222Pm2LKKyc2EYyZGr8FHYrjXeej9BrJYt1rtTuePdiihYd9a?=
 =?us-ascii?Q?jqXDz8GFSs2xDrefZ/28FUJXstR5zF8vJ7AJzcWMjgB30maMU95amYDk2hcS?=
 =?us-ascii?Q?KZ/p8gnX4TU/ZaxF2Y6FfgPwUjMpPabhaX60pB71CcwRydftbiXC8/Nkl73U?=
 =?us-ascii?Q?owt9LGwrPxzy/O+Edsw7gFKEaaXHfLi5g9wDGVj/jEhGCnnkNBONb5vTQuO3?=
 =?us-ascii?Q?fZrDkKrAz9uWkRdtPeOPN8vclDAFcXnjXJTemmo0Jl4cxKjtqD6XGvE0s2A4?=
 =?us-ascii?Q?3w=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <DBB5F17AD8636E47B2A2D4F03B37BA20@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6272.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4b9cd9d-44a3-4659-0e67-08dab02daf34
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2022 10:52:28.5631
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DQV6KGPCyZIsdl1NBQu86a4NHHMMmeVTHSvVQoUCTZIxidYaLLDF04pMH5IhV/++/Mjz/7wNyypFyoLcfFQGUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB5529
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 17, 2022 at 05:20:28PM +0800, John Garry wrote:
> Similar to how AHCI handles NCQ errors in ahci_error_intr() ->
> ata_port_abort() -> ata_do_link_abort(), add an NCQ error handler for LLD=
Ds
> to call to initiate a link abort.
>=20
> This will mark all outstanding QCs as failed and kick-off EH.
>=20
> Note:
> A "force reset" argument is added for drivers which require the ATA error
> handling to always reset the device.
>=20
> A driver may require this feature for when SATA device per-SCSI cmnd
> resources are only released during reset for ATA EH. As such, we need an
> option to force reset to be done, regardless of what any EH autopsy
> decides.
>=20
> The SATA device FIS fields are set to indicate a device error from
> ata_eh_analyze_tf().
>=20
> Suggested-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> Suggested-by: Tested-by: Niklas Cassel <niklas.cassel@wdc.com>

Nit: is this perhaps a typo?
(Since there is another Tested-by tag later in the list.)

Checkpatch doesn't complain, so I guess no biggie,
but might be worth fixing if you decide to roll a v7.


Kind regards,
Niklas

> Signed-off-by: John Garry <john.garry@huawei.com>
> Tested-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> Reviewed-by: Jason Yan <yanaijie@huawei.com>
> Tested-by: Niklas Cassel <niklas.cassel@wdc.com> # pm80xx=
