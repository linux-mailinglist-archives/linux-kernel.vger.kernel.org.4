Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64A006265BD
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 00:54:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233750AbiKKXyS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 18:54:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230105AbiKKXyQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 18:54:16 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2062.outbound.protection.outlook.com [40.107.220.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6C7922BDB;
        Fri, 11 Nov 2022 15:54:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hcIRTtekrRTEusTWBjBwkb7Nj8UHUQiYmgjbCe3mu0SwwqZwEwiDVjY5Ta8ZxdK9RO+lncauDZAiLhi/P+GxQC8doClNbIqcqZrfpkHUExHzCQb6z8FsqpKhs0gW14prasocCs54L/8ZgqHDdrYgkiGHxAdjPYqtfQV8LJcVf4I8/xQ7TsXZ7N+MNCP/jlHZ/9KQ8sJHBkdMcvkcL90dkVcff14roT4lQ0u2kP5vb4F7W7CcbFCdIWn0J84UoiyPIloTOCfWi0BjASdfRjvbDVVt1Nc6+Ly8rga6C6nIXBH6tEZUKbQHkOG4rzEfnS3b6CojtmbEyszJRFZ1OSAopQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FCnPf3me1ThSTIqzekxX7BSQSu0EixhkGFkYEN25fSs=;
 b=lF8HFih5vDEfV2vETJlnq84ke1hWdmX4+xvH3N4Ipvy+6+NbPDSaklsvUL6DM16zlxoNz0ETEvEBjNeb00XMom0+5l3FotQz0azkAA8UMH0Xnq8v3OLtV4oxKgeCGhJTHMKnfSU+0lUbTpXipdt/w9tjfdsbX9en7EOeLchVSQ97C6WJsj9UoozLCGRQkU08PLO3wOqmoM4VR1FDH30g21l3VR/W7Mxaajsq5Ok0uZxK4fcHg6UshlJ4Ri/35MxxC9QjPQ/6hzaQ3tfDnBF19VIuDUs0Lgd81zUZrhLW9xeD0o4Gui+pALumndg7CfnDocArMsF9vL2HOh8+KxETpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FCnPf3me1ThSTIqzekxX7BSQSu0EixhkGFkYEN25fSs=;
 b=HBJRSB4Wxww5yrfWuzZtD7r5D5Xkf9xvbJarubX6Ce+q+S//W7/iB4L4U1TFFS+ApAP8DM6HSq1Tv/vV06XBG4GIDdOXaawm/LbbRkJpcciR9FLQWmHs+XJLpoqOpP0PfBo0wmE/76+u/SKsCv6vUbSnrKkjzFHwapPJ55mKykQXSZaoTVwZmZ2lkgZ8Qc4zd0/vXcbGa/EFGArszaIGDkbLZsrO5rWpSHKxmRfgaVmJhJ3Xrb12GB2wg152bv/Gv3j/E3z+dso1Hy68y3Gr2JRhntIWQCWOIJ+sVIuRY5q/huzJvYv+Mx5KTzqhKR14NzKgrBDVa4Ks5EPbKPAv1A==
Received: from SJ0PR12MB5676.namprd12.prod.outlook.com (2603:10b6:a03:42e::8)
 by CH0PR12MB5203.namprd12.prod.outlook.com (2603:10b6:610:ba::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.13; Fri, 11 Nov
 2022 23:54:07 +0000
Received: from SJ0PR12MB5676.namprd12.prod.outlook.com
 ([fe80::46c4:5346:c449:9bd4]) by SJ0PR12MB5676.namprd12.prod.outlook.com
 ([fe80::46c4:5346:c449:9bd4%3]) with mapi id 15.20.5791.027; Fri, 11 Nov 2022
 23:54:07 +0000
From:   Besar Wicaksono <bwicaksono@nvidia.com>
To:     Will Deacon <will@kernel.org>
CC:     "rafael@kernel.org" <rafael@kernel.org>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "guohanjun@huawei.com" <guohanjun@huawei.com>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        Thierry Reding <treding@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Vikram Sethi <vsethi@nvidia.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH v2] ACPI: ARM Performance Monitoring Unit Table (APMT)
 initial support
Thread-Topic: [PATCH v2] ACPI: ARM Performance Monitoring Unit Table (APMT)
 initial support
Thread-Index: AQHY05p5Zh4pJFmZEk6UwzpU+Lc4ma40EgWAgAaXIeA=
Date:   Fri, 11 Nov 2022 23:54:07 +0000
Message-ID: <SJ0PR12MB5676DF8011687CFB0E124FC7A0009@SJ0PR12MB5676.namprd12.prod.outlook.com>
References: <20220929002834.32664-1-bwicaksono@nvidia.com>
 <20221107191034.GB21991@willie-the-truck>
In-Reply-To: <20221107191034.GB21991@willie-the-truck>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR12MB5676:EE_|CH0PR12MB5203:EE_
x-ms-office365-filtering-correlation-id: 4cf9d7ea-9945-46f6-44f4-08dac4400591
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xZEg0PMipPGaV4m3/N3aamaA4IZF2ZnBkGQrFFs7S4meGSTdEiqkuZTkK7NqnudhGbedwI6QkdQiesblLAobvYrlYEpvQcq0sKx57uP+b9oZyVEEOwD00L/9L2loBD8PQMm+pCvHdJAE8h7xEmjIpkZNw24VauQCelFlEbKllc7nIYlECc0Yyuf3rosOEN2qGyfgv8j2D1HaULXODGTuvz49Q9x7k4JZHWGaRt47i6n6A7UAcsh6STIXVWwJ6OGtu4N1Zs22nIkTCi95b8xOh/BsiOdoo3zLH+1NH0IihgdDZ9NDnVpmVfhNDR1LieU8Edb1K6uH9dBxZnwPMWURSUhbyVQxTcfK6cqmFNc7W1s8CdFRGYfWeKL1JNjwcHnlVoeJ8/uK3EAzCsmdAxoV5p/YGie9haTc7z9MhQNIaHwVSSShqP5pv6IifyWuspgsrkTn/6fw/aPJ8md2my58zAzaxn9bYiX3Xn9G/PlTERJnRVQJluAURmtIwTHczu6W2miH/p28JesakFW8Zp99WB7MQIxGMCY9MbS6Kyv0+GdUzXleAzfjaUSKOSMXJijYPMNXAf1LAHA76Cfc3J9Qqxvoc+jQeY7Q1tCEF7Cgu19I6zYkm4F717rEUKX6AwzAjnUJX56cLeusBgbPsjqLzeMiKdhq5Le0Xw0Djn9JBCeliTMXAs26qcp8uaXJog40rakU14g10nWaW0E2SRNt+MUXJCf3c6028Jjt7d78J7DYSOLc6r2iBgQqaaMqtTvtb9T89nm5NQWhcKA9XTdRYfNx21H9fNly9z+bOcAF9mnwZdMaOR4eeleMekL3+368CuVxTIur6BGhWv/G3BBVA1Gzocv/rAPrSUWCkobNIjs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR12MB5676.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(376002)(366004)(136003)(346002)(451199015)(6916009)(316002)(54906003)(122000001)(86362001)(66946007)(66446008)(66476007)(76116006)(66556008)(186003)(64756008)(8676002)(38100700002)(4326008)(2906002)(7416002)(478600001)(9686003)(8936002)(52536014)(71200400001)(33656002)(41300700001)(38070700005)(83380400001)(26005)(5660300002)(55016003)(53546011)(7696005)(6506007)(966005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?nT/5x8uOewOPBSiIVScWpxdnUGyatLJjXnRRZunv7f6iJx3ofxxUGYxuvZjG?=
 =?us-ascii?Q?siBpSh26S4loBmljAZNEMrIH2xeKX3ujL2+Dr581sPJg2O7qUQbC0X34JYVh?=
 =?us-ascii?Q?HkhCQo4D3XCEy24AHgXMg38iPbR5jxy/p2S8B4twBpcaXb+85tWiB+CbOCN3?=
 =?us-ascii?Q?vfaF9Am80aVMEpNS5WRCIXXNVXEg1brAg0IFp/PnoPfIKKu/WPWCWcKhmIhw?=
 =?us-ascii?Q?JZ/HHX59g3qDAB38Bu7EdkYml7At28R7PAg/jlihJI1HTB/HJy+dy+l0tf4Z?=
 =?us-ascii?Q?weYcFTHX6Z74yUIT4Jsep57GltbqCbMESgmHNk1O1ULulvtdQIMcs/SyHT4V?=
 =?us-ascii?Q?noGmlIzC8HCm+qU72yBXlPCaTeRmfN9J2U0SoW5H9P/A//2hGdtY+uHT4itj?=
 =?us-ascii?Q?5QYXo7C0QlHA747i/2GnUKlW3mnPh4ZPhaXfjub6EttTNHNLuHK/V9EN/XQq?=
 =?us-ascii?Q?1AFIMBv6I/9nR34/Y1m5KzTpeybHL2E3Zjkv+VbdVvvXSl6qiCu0ij4V62IN?=
 =?us-ascii?Q?doaO6aNX3RNXAvvW1wg3iMbO9vBkV4zuZsHYPO/J9xwHcxDncMaGmsQIu0uT?=
 =?us-ascii?Q?SJ4UMQS7CFL8wHxMF0dYzOz17OdUq23zJ6omZbb3L77/4vUC8L2WwozFg38M?=
 =?us-ascii?Q?XCXPB8i/gTN/2PpCfOPzICHP7TM0FoWikEZlhbBI01qF0X9yzfdrTqzVI+7A?=
 =?us-ascii?Q?ZjiSARU3nzyfNxSWLQkdcXyc4kebAv5I4/xvqaEwwelZD2hboluwwPbVtMU5?=
 =?us-ascii?Q?877xrx02DGL4ePgVBwQpcDye3gT78ZbCzVreAZ3N75JD0Jclgh9B1T8FSpu7?=
 =?us-ascii?Q?scxp0h4rboHJ6xBNi7B64Mlt6p81d9oSEk2KiaGN0ZYLvuXzYko/JSkhba5S?=
 =?us-ascii?Q?vt2hMysSZg8vXnYpWWX++h0M3In0s+NDp27jqTO7Vb81nwrtE7u/MVgx9Tqs?=
 =?us-ascii?Q?GdwiDYYS26q9XajYAS1gAN+k+jRGzlufm07bjWrMdWidPYwceJMjMhNea0IX?=
 =?us-ascii?Q?Y4BpGrhJb78SdT0CCnyClWbejQ5zbvc67x2n5/MLqSUJK0jWagyoeIC7PZ0P?=
 =?us-ascii?Q?hblbQgM3jZekJDL10MGLxPokzFXUbGp5JAW8DfR3lx4DKdWbvLaIK5vt6Mqv?=
 =?us-ascii?Q?ZtFRiud1GEIBmDh99mL1oKGdkhwifD3fo/m98D9YAdBpQByb8SDRf8camlqo?=
 =?us-ascii?Q?lbwLkMawcoa9QsVhKdfLPe2oDmtFfQIFI3M0CB+sb/LTIQYMak66zKq9iMeY?=
 =?us-ascii?Q?YiqKDJ+nfI3AL0gGm/6t5o4zaxG0pYfjZXCGRs6+rF/FlJ7sndRcSfMSxLFD?=
 =?us-ascii?Q?8BC/gaCZb3+bStnmqTMe+QeJb+rWgXNH/7SxDSHdJg6YvvlREpN+S9Rm9zZd?=
 =?us-ascii?Q?jOk+P6zyHor45pB06Vh5W+yz3mn1o1wozRo5odxBMK1RcqD5OCcj9/8r9K7a?=
 =?us-ascii?Q?gIk4zmCCKImSavGYr+42rR3HKhVhKhpsfvK9LxKRBmFP2JeGJ2UcqTvzRZAl?=
 =?us-ascii?Q?8T2+wTp3QHCghK5jB2UN278sqsQuoqX/Zp+KGVTOQLRalnZ/CskrHPBth1/o?=
 =?us-ascii?Q?ykBYfv22jwkQmhOBge7XcWbaRdhW9zW3MrGE85Pb?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB5676.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cf9d7ea-9945-46f6-44f4-08dac4400591
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2022 23:54:07.6079
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: f3DrQh94E2/t1g3d1X2GuFGZQyZ84YL/jaGt1PLoMZWeQV6k/MKSr7IBFZZamFSUtAqv5YNNF5o5S5DcWq6exQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5203
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Will,


> -----Original Message-----
> From: Will Deacon <will@kernel.org>
> Sent: Monday, November 7, 2022 1:11 PM
> To: Besar Wicaksono <bwicaksono@nvidia.com>
> Cc: rafael@kernel.org; lenb@kernel.org; catalin.marinas@arm.com;
> lorenzo.pieralisi@arm.com; guohanjun@huawei.com;
> sudeep.holla@arm.com; linux-tegra@vger.kernel.org; Thierry Reding
> <treding@nvidia.com>; Jonathan Hunter <jonathanh@nvidia.com>; Vikram
> Sethi <vsethi@nvidia.com>; linux-acpi@vger.kernel.org; linux-
> kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org
> Subject: Re: [PATCH v2] ACPI: ARM Performance Monitoring Unit Table
> (APMT) initial support
>=20
> External email: Use caution opening links or attachments
>=20
>=20
> On Wed, Sep 28, 2022 at 07:28:34PM -0500, Besar Wicaksono wrote:
> > diff --git a/drivers/acpi/arm64/apmt.c b/drivers/acpi/arm64/apmt.c
> > new file mode 100644
> > index 000000000000..f55167ca51e7
> > --- /dev/null
> > +++ b/drivers/acpi/arm64/apmt.c
> > @@ -0,0 +1,177 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * ARM APMT table support.
> > + * Design document number: ARM DEN0117.
> > + *
> > + * Copyright (c) 2022, NVIDIA CORPORATION & AFFILIATES.
> > + *
> > + */
> > +
> > +#define pr_fmt(fmt)  "ACPI: APMT: " fmt
> > +
> > +#include <linux/acpi.h>
> > +#include <linux/acpi_apmt.h>
> > +#include <linux/init.h>
> > +#include <linux/kernel.h>
> > +#include <linux/platform_device.h>
> > +
> > +#define DEV_NAME "arm-cs-arch-pmu"
> > +
> > +/* There can be up to 3 resources: page 0 and 1 address, and interrupt=
. */
> > +#define DEV_MAX_RESOURCE_COUNT 3
> > +
> > +/* Root pointer to the mapped APMT table */
> > +static struct acpi_table_header *apmt_table;
> > +
> > +static int __init apmt_init_resources(struct resource *res,
> > +                                           struct acpi_apmt_node *node=
)
> > +{
> > +     int irq, trigger;
> > +     int num_res =3D 0;
> > +
> > +     res[num_res].start =3D node->base_address0;
> > +     res[num_res].end =3D node->base_address0 + SZ_4K - 1;
> > +     res[num_res].flags =3D IORESOURCE_MEM;
> > +
> > +     num_res++;
> > +
> > +     res[num_res].start =3D node->base_address1;
> > +     res[num_res].end =3D node->base_address1 + SZ_4K - 1;
> > +     res[num_res].flags =3D IORESOURCE_MEM;
> > +
> > +     num_res++;
> > +
> > +     if (node->ovflw_irq !=3D 0) {
> > +             trigger =3D (node->ovflw_irq_flags &
> ACPI_APMT_OVFLW_IRQ_FLAGS_MODE);
> > +             trigger =3D (trigger =3D=3D
> ACPI_APMT_OVFLW_IRQ_FLAGS_MODE_LEVEL) ?
> > +                     ACPI_LEVEL_SENSITIVE : ACPI_EDGE_SENSITIVE;
> > +             irq =3D acpi_register_gsi(NULL, node->ovflw_irq, trigger,
> > +                                             ACPI_ACTIVE_HIGH);
> > +
> > +             if (irq <=3D 0) {
> > +                     pr_warn("APMT could not register gsi hwirq %d\n",=
 irq);
> > +                     return num_res;
> > +             }
> > +
> > +             res[num_res].start =3D irq;
> > +             res[num_res].end =3D irq;
> > +             res[num_res].flags =3D IORESOURCE_IRQ;
> > +
> > +             num_res++;
> > +     }
> > +
> > +     return num_res;
> > +}
> > +
> > +/**
> > + * apmt_add_platform_device() - Allocate a platform device for APMT
> node
> > + * @node: Pointer to device ACPI APMT node
> > + *
> > + * Returns: 0 on success, <0 failure
> > + */
> > +static int __init apmt_add_platform_device(struct acpi_apmt_node
> *node,
> > +                                                     struct fwnode_han=
dle *fwnode)
>=20
> I queued this already, but my testing kicked up a nit that 'fwnode' is no=
t
> described in the kerneldoc. Please can you send a follow-up fix for that,
> based on for-next/acpi? The indentation is also pretty weird with extra
> parameter.
>=20

Thanks for getting this patch. I have sent the follow-up fix with:
https://lore.kernel.org/linux-arm-kernel/20221111234323.16182-1-bwicaksono@=
nvidia.com/

Regards,
Besar

> Will
