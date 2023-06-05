Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 045C2722C37
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 18:10:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234312AbjFEQKQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 12:10:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232322AbjFEQKO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 12:10:14 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2080.outbound.protection.outlook.com [40.107.94.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 849A3EA;
        Mon,  5 Jun 2023 09:10:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zj9K9j76vvRVvmRSsclowwHGeWJlyUX/obQdZ4uxjmBpqVG7hdw0lW55+59OQj07gemTRZWtcAU1QvSn4Ui5Vi1MQixKyX1JzkVbztPttkCmKFfbe+9NJ0OSDvBj26p1iTVjGddFVVQ+mha0/vcpuClEfHG+VGQiVzacBuRhVPuFPTqZGKmkTe/iH3f0cJ1fGAz4BomKsp8AkOVOd4TD+fu0f8sZxfi55soDHrZYbevhHizdSDgJlnZOvCFLeclD/lryWyiY2F/9qNYw+Cp+X0SrxwMTXig0t91JKayiCTVxMWoUVyv4lqeFLW8vt6ngnqaTo8xbMa4fY+Jji3FBeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RYEP2WgfEZEPA3+4UX2QRR1v8UobsNpnqZ3YyBuQgKk=;
 b=ar4n7LN7RM8XJRmU7ShpzW4P0RY35br+xudUeySZ9WFjtbkYnaG2Q/PZ7XYLM0WFd9dcghKfv760bEeB4RHeMSPJCcDABcMb7v5NwTeZEoh4qBca0MeJ4wbHvS2wJmrQSHV3xLUCqAumQtJrhxPjNC9th9WD5itdjzp745upJz7c/d5nDbK3t18UeHP58lUg601XXGAy6zqHpUp/drHZRRNZqTdDg25AKU4AX1JS2LDy1IJyzcPF6dQodIwpf9tQc6gscFvMEQy/GYYgKChHzNHPUng2RtEA3TU3zUHOku8iiYGx2m3x8zcmqYgeFN7D6McpIbgnxAa8QC3wWfnHLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RYEP2WgfEZEPA3+4UX2QRR1v8UobsNpnqZ3YyBuQgKk=;
 b=e0+0Fwu3cousgvT0tbgXqpJlBX0+h7+tPrFvX5u1EwNuCLPt5IJJ+VTTtYAKU/bNFfcF45Z+oe8iulnRhDuvUra13hZSWlqG1uzlhYUkPVJ6/ZanejnXxvuXCd/HCaSqDn4rhKd/of+iO9vkhRuEM02yTQOJmh/E+Q8OWnz7Jxg=
Received: from CYYPR12MB8655.namprd12.prod.outlook.com (2603:10b6:930:c4::19)
 by CH3PR12MB9217.namprd12.prod.outlook.com (2603:10b6:610:195::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Mon, 5 Jun
 2023 16:10:06 +0000
Received: from CYYPR12MB8655.namprd12.prod.outlook.com
 ([fe80::6239:f594:96fd:2af3]) by CYYPR12MB8655.namprd12.prod.outlook.com
 ([fe80::6239:f594:96fd:2af3%4]) with mapi id 15.20.6455.030; Mon, 5 Jun 2023
 16:10:06 +0000
From:   "Yuan, Perry" <Perry.Yuan@amd.com>
To:     "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        "Huang, Ray" <Ray.Huang@amd.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
CC:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Robert Moore <robert.moore@intel.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "devel@acpica.org" <devel@acpica.org>,
        "Shenoy, Gautham Ranjal" <gautham.shenoy@amd.com>,
        "Karny, Wyes" <Wyes.Karny@amd.com>
Subject: RE: [PATCH 0/4] Enable amd-pstate active mode by default
Thread-Topic: [PATCH 0/4] Enable amd-pstate active mode by default
Thread-Index: AQHZl8AYgGk+ncCZWUSMrNFXSaXP9K98YIJw
Date:   Mon, 5 Jun 2023 16:10:06 +0000
Message-ID: <CYYPR12MB8655792CB568638FC8AEF7A99C4DA@CYYPR12MB8655.namprd12.prod.outlook.com>
References: <20230605151133.2615-1-mario.limonciello@amd.com>
In-Reply-To: <20230605151133.2615-1-mario.limonciello@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=704ad91b-7089-4fe0-ac6c-8621b854aa0d;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-06-05T16:08:45Z;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYYPR12MB8655:EE_|CH3PR12MB9217:EE_
x-ms-office365-filtering-correlation-id: 4d617a70-8438-4846-897f-08db65df5444
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sP+FXzffh2XAFgM4bBwvk6pIXpzCuxNpb+NdaSTjMbFuf+F379QOeZZBeLvVhBKnwt4nqpXr9OBqE1aP3sWIPPcD3CGAmJELVJaBhMmIUXNbp2IxDCbmVdgL/zEMGVwc+8JFedaCKwsTqipW3g7H8/W/xr3Jx+jpI1xfkniA46ewcjtqoEim6BW1R8FhsgWlxb6XdkKSNhyXDmiMeZbBtsMKIIxkCw1NkOm245xE1sK+0hYYVoLensF7hb9KdIX0gcrv7POn6hEE70UTVlJwrKnd3Yc+/Lcw6FdBRjOR43KklBHWt6qcUNPH55YlItMNY9EXMErfeAaqTPVWexqPDV55wt+T7KuTt5CJme7/arJ90bFpgzElIKUufiCmrfXyGvhyVK4pnpVb3uHHCrKg4Qaevpu9E8MA8XNk4G1OH1MJJkCuonQd8yH7dQcYpdcRLfBAtYC7Das/lSEXOIZCt/QKVuinw5o7R63gR08DnUu9SqISWoPeJrXm/9x2OsfTG0y95+2252kX41irmG+uBgjoH+000UvcjqWagz/c2uUSpeYM8BzXZtMrrPY2Cmi6hiNqGfmrrQTb9Qzr8nzND9aUX/7Vy6XLBVqR3mGqt24OTNXaLw6x+/ioBEeiDrF6
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8655.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(346002)(366004)(136003)(39860400002)(451199021)(54906003)(110136005)(71200400001)(478600001)(52536014)(8936002)(8676002)(5660300002)(38070700005)(33656002)(2906002)(86362001)(4326008)(64756008)(66446008)(66476007)(66556008)(122000001)(76116006)(316002)(66946007)(55016003)(38100700002)(41300700001)(83380400001)(6506007)(26005)(53546011)(9686003)(186003)(7696005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?EOfsSqIjFTKFWRMx1KV5FJVzkQy51EEPXr4emFyhYMmL+J/EB0Ixa8DeAJYQ?=
 =?us-ascii?Q?JvGHMDypWGYiYhjs84QUWzdZ/ctSIrz09dzq6t4p1e4SEuKsHNqv1kRu0mZC?=
 =?us-ascii?Q?numtuzezK9nnw+Q7Gaf7QPfxA1BZ5uIOECjgnInzAqbb2y4tmIlGIYTN9ib+?=
 =?us-ascii?Q?u0Eft403WV5FGJYVbdj0g3c4/QrnLGu4w+jG39EwVFkwl3+IpFuv/pIoGSzp?=
 =?us-ascii?Q?3jFqANKT9ZnHM1L40pTdv8UvsM0g4N6csED6u4QarEbew7yLDlcGifHVOXwr?=
 =?us-ascii?Q?vgIDOjjTmFXhjhs2XMcO1xgqX5iEniplLOr0W6Tgy/xCXbEhw6+B/SOG1bc/?=
 =?us-ascii?Q?lGwtIP9Yw6uvPh7WidmOpAGmlH3ABuAEmHOoD6LcIIygLmSPIJm4PhigFLBx?=
 =?us-ascii?Q?fuHHOvnp02idZFoHMRHKKeaJ9aMZUknf7KfBzYrY0d0nDexHEHYoO2cbpwQu?=
 =?us-ascii?Q?cHXr7Gu6YMgWhH9MCkE5eh5JIJBt0axdd7cn97pI0OL9fxVee+08wSt3k+zu?=
 =?us-ascii?Q?ObcCFvSV8tpdRzl0lTtE0DcoJFI92Q7ENhLh8Zoms8qRwNhef+mK6HP5BIEb?=
 =?us-ascii?Q?dSmOBnQ85ilvDJ9BezfnAkLBevDYfpw8q5/mnLvp1NPEGg15MQWscg1m7s3b?=
 =?us-ascii?Q?xdFv/wR4ghwYsNwhK4WaEXlwUz1JHWotPVoCKApqlNsRwzkC7rh/0/Shtehk?=
 =?us-ascii?Q?+uZH3b+6pvSryeXFwcFyp8yelmkQV+Ax1+T+TLfXEE2b5Argzp172+Hdp+xG?=
 =?us-ascii?Q?P0nu+sqtesB85h1WT3BHJUT/cg+dQeArYGTRjbtC+J5CTzduj71FkcDRdz2c?=
 =?us-ascii?Q?B/rrIrWRqqLvSAWXi+jwBRTWUFClw+ePNaFsTLasM9jY6zJlcbgK19JrE3q1?=
 =?us-ascii?Q?piE99RR3aVXtaUtwSmRn2I97v2LowWK7kUeIRC9dZTzg+AfI1bxxyB/pc4fm?=
 =?us-ascii?Q?8N1hG0qj4rqOy/TH2KbyQ9lcZxqgD2ppafJpWrc0KKPQx0Qca0fkTfUD8Jlo?=
 =?us-ascii?Q?1uaPPFOVI2rnd2o8gTSzub+WtCfrtmg5G14paCuS74ji0RhN7ekmUaiSk2pd?=
 =?us-ascii?Q?3y/obl5UVuvqhJbFqhxbt3eknvEZDcIEZYR3x7i/Rg+hAdB1ZCx00iYYyUth?=
 =?us-ascii?Q?GQxRTI/g8zC7x1kxQYr5LC92e4yYHNsfbBruRvzZQBZ7O4Yi4Zrx4LU+efOG?=
 =?us-ascii?Q?P2WcXc6zxqL+FyuYuNRSzYEVDLDk9+eOn/a+SZVBg3Exs+pPNxByz6iBxc3V?=
 =?us-ascii?Q?h0Sb6nJ3u0VbcdniuglgfvaEPVoE4UuPGq1YSIP7R2qp34T/vd0NkaF+l/ER?=
 =?us-ascii?Q?Fk10y+zmGHCLCMid7Hq5qrfJ8HAqtc8ytUgGWE4f16VMg71rdorPald2zR5L?=
 =?us-ascii?Q?w2euUBoWI2AETN4j4AUFFZtLK8x0l9pC46II4el7sbCbZuCyDeziEqmZc0iO?=
 =?us-ascii?Q?eavQ0Ubcz0Gi0kGkJMmifvh1cIbSjIQaiVDL1r/6zPk+vkvx5L2ffp07z1LZ?=
 =?us-ascii?Q?Txiv4s8V0ODbe+a096GiFfJ0u7Omuxr5Lj1VLgh91xkjn4ESFcRMvFYl78iI?=
 =?us-ascii?Q?Dxmzhf9TSFVZxKvNBFY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8655.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d617a70-8438-4846-897f-08db65df5444
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2023 16:10:06.8857
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wuq53uA/FqERENprD14GRKCpbkpv5ZbIwyiXH8rTbXLpz3cTtiOAgmBW5Eud+E/OZyoMyQe6orSkPYz+04A4ig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9217
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[AMD Official Use Only - General]

Hi Mario, Rafael,

> -----Original Message-----
> From: Limonciello, Mario <Mario.Limonciello@amd.com>
> Sent: Monday, June 5, 2023 11:11 PM
> To: Huang, Ray <Ray.Huang@amd.com>; Srinivas Pandruvada
> <srinivas.pandruvada@linux.intel.com>
> Cc: Rafael J . Wysocki <rafael@kernel.org>; Len Brown <lenb@kernel.org>;
> Viresh Kumar <viresh.kumar@linaro.org>; Robert Moore
> <robert.moore@intel.com>; linux-acpi@vger.kernel.org; linux-
> kernel@vger.kernel.org; linux-pm@vger.kernel.org; devel@acpica.org; Sheno=
y,
> Gautham Ranjal <gautham.shenoy@amd.com>; Karny, Wyes
> <Wyes.Karny@amd.com>; Yuan, Perry <Perry.Yuan@amd.com>; Limonciello,
> Mario <Mario.Limonciello@amd.com>
> Subject: [PATCH 0/4] Enable amd-pstate active mode by default
>
> Active mode for amd-pstate has shown enough success now that it makes
> sense to enable it by default on client systems.
>
> This series introduces a new kernel configuration option to set the defau=
lt
> policy for amd-pstate modes for a kernel.
>
> Server systems will by identified by the PM preferred profile and still b=
e set as
> disabled by default for now.
>
> Mario Limonciello (4):
>   ACPI: CPPC: Add a symbol to check if the preferred profile is a server
>   cpufreq: amd-pstate: Set a fallback policy based on preferred_profile
>   cpufreq: amd-pstate: Add a kernel config option to set default mode
>   cpufreq: intel_pstate: Use the acpi_pm_profile_server() symbol
>
>  drivers/acpi/cppc_acpi.c       | 34 +++++++++++++++
>  drivers/cpufreq/Kconfig.x86    | 17 ++++++++
>  drivers/cpufreq/amd-pstate.c   | 80 ++++++++++++++++++++++------------
>  drivers/cpufreq/intel_pstate.c | 17 +-------
>  include/acpi/actbl.h           |  3 +-
>  include/acpi/processor.h       | 10 +++++
>  include/linux/amd-pstate.h     |  4 +-
>  7 files changed, 121 insertions(+), 44 deletions(-)
>
> --
> 2.34.1


Sorry for the typo, send again.

The series is tested with commit 7736c431466abb54a2679dc257f739fddfa84295 (=
linux-pm/bleeding-edge)

Default option will enable EPP mode without any parameters added to kernel =
command line, If user adds "amd_pstate=3Dpassive" to kernel command line, t=
hey still can choose other modes to use.

Based the testing result.
Tested-by: Yuan Perry <Perry.Yuan@amd.com>

Perry.

