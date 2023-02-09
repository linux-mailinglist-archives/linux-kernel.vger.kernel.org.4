Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39DED691049
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 19:25:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbjBISZt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 13:25:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbjBISZr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 13:25:47 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2047.outbound.protection.outlook.com [40.107.237.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4102C6031C;
        Thu,  9 Feb 2023 10:25:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=feEKwgqEKG4x2RqH1XdZTnMt7wvAyWy/vAvTXclX4IH/1wAeDEyH8z2Ss9D3ZHFyq1IT6ZYXUVujZV+EtTwGBH81GPwbFinz5vbgxDyE8E7OnftahVZO3e2yrUkE+M6fE3Mf6Z2wCDxbk26L90gizOCq4JG8etGM/8y86RdLgeeOB5jwA305NmGDzTPQATvFNjFW4KQPv4ulBn85nQXX8Xuymyv5ootfVaePw7zXD2QnS2c8y/KRPSUgF+ksLxRGlftApip7BbZrYH7aPR5eL56419mbdSfSNvC97i4Y3UHZ/RakFMxGHCZ89CalJDRhOV/Qj7GD8bfkDdGyPLmxyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E39ZTjCfFXnKNGGYa4h05QrAQUodp08K26DJSLQduIk=;
 b=YTzdzQHgeMbypHMrYZlsFO/YLkwXZnDH0afgin9lk0swRCNQYYZRQsOAv7LRXcDgaDEnqKN+8K2+R/rnGXVHJTLPuTd61yXPtUlN0gxtOloQuS4MFttDuUydp9awdJtxoaoKuBwQS6Wgq2DJiXE8zQvSXHda7YTu+cZw7g7snoITiumb/ztGu6jOtW6U4pmidtcXWgsOhKIxx8D+ySQiJVQQyvyMyzn1SSLCzhiazGZi7vtdGdgKz+503u9C3knkoOc0dAKnaJQw2R9XUI4sNSC9HT3M49KHKBn7tPMtGtTL3cDykDkefvZJOI/W64fSuACUhQxNlnG7zdeRdST8Dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E39ZTjCfFXnKNGGYa4h05QrAQUodp08K26DJSLQduIk=;
 b=iejb8rXGCQHr+1Wssw5/6Ktj0zucdcjEnquFU76qmJKVzoyNIltVUUQZfoCcjhOU0QF5WBczDxPoQRGPzL8OD/hUxv2KIhIj3GuVc0bgBggdyGfq5zfZkMStY2M4COlcB9lZTl8QFRpXQ4gIPixIk0eR96qe9zLp76WBu7uAsoo=
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by IA1PR12MB8408.namprd12.prod.outlook.com (2603:10b6:208:3db::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.19; Thu, 9 Feb
 2023 18:25:39 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::a59e:bafb:f202:313c]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::a59e:bafb:f202:313c%6]) with mapi id 15.20.6086.017; Thu, 9 Feb 2023
 18:25:39 +0000
From:   "Limonciello, Mario" <Mario.Limonciello@amd.com>
To:     Grzegorz Jaszczyk <jaz@semihalf.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rafael@kernel.org" <rafael@kernel.org>
CC:     "dmy@semihalf.com" <dmy@semihalf.com>,
        "tn@semihalf.com" <tn@semihalf.com>,
        "dbehr@google.com" <dbehr@google.com>,
        "zide.chen@intel.corp-partner.google.com" 
        <zide.chen@intel.corp-partner.google.com>,
        "seanjc@google.com" <seanjc@google.com>,
        "upstream@semihalf.com" <upstream@semihalf.com>,
        "hdegoede@redhat.com" <hdegoede@redhat.com>,
        "markgross@kernel.org" <markgross@kernel.org>,
        "dtor@google.com" <dtor@google.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>
Subject: RE: [RESEND RFCv2 1/1] platform/x86: Add virtual PMC driver used for
 S2Idle
Thread-Topic: [RESEND RFCv2 1/1] platform/x86: Add virtual PMC driver used for
 S2Idle
Thread-Index: AQHZPJo6TXhZgi1Iw0Sny1/s70pc067G7lAQ
Date:   Thu, 9 Feb 2023 18:25:38 +0000
Message-ID: <MN0PR12MB61010A5D6EA7526F88E85AEFE2D99@MN0PR12MB6101.namprd12.prod.outlook.com>
References: <20230209152123.3186930-1-jaz@semihalf.com>
 <20230209152123.3186930-2-jaz@semihalf.com>
In-Reply-To: <20230209152123.3186930-2-jaz@semihalf.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-02-09T18:25:37Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=68e4c70f-497c-4a8f-ac87-63a67a9a43fd;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2023-02-09T18:25:37Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: eceba765-4b9c-412b-9640-fdce06dcc6e0
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB6101:EE_|IA1PR12MB8408:EE_
x-ms-office365-filtering-correlation-id: 6f9f2fa4-8982-46f1-0d01-08db0acb0b6d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +3VnMikGJfa8+cgViuiJWChp9pWJoV7zfOci5O1V+BglF6haGDhrPGBgiBare147SWLy5WXmvPbBJgzFNwuORC6mldb1rjdSyC1A+RpVYZYW6rpjOTCdtF3bUMKMs7H8hgNmDCYsWHtlqaU9y737lnDZehHGg/9W+0nnLHfI0gzatGz6GTnYeYbNehCrEOmcAq2zZgAjrsiWL5Fe+acZ5d9u65jTSdElL+7L0TjsJqqFL7+uU/zHEA1I+qZB90uDAq37e1X1YtUA362+XKxl5zHSmidCCJIaSd811plBHymHz3o1J9kYIjw8la+MTgxdOXvT+tL4TRcXzMNNH/I8CcfcAo2NLNEwVFWD/I6THjI7HznV8PB94xv2V7FNI9SOVCt1FxR2UozwOgCxXfu4cgyo6yO8hY4dHVCwgso/A1POdj21q5paLbROKHhRS0C0dYKvTCDMFGD4PYiZFJwOHkW7AggH0snnZC5/QEoOGE1XP+Lk9eLyooG+PQDud7sA0fJFo8Im6qsCC377aVn8IURTf1NV8jHexz41kDEKO6i7GytwKKGxp9zSlVA+bjQvwXdwl/KUOYs9UWaLbQdreBHrR63etOTW9z1jQApPkKxuhOlKLZKhgFKo8kEdxtZM4fKM4N84m3EJAXkfsmXTLY81iBAKMANw0/Eg8B7pUTFNPHq+3d4bS8/DIKkTfjBD3+x4VjTbIzap1TZJQr5F8w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(366004)(39860400002)(136003)(346002)(396003)(451199018)(38100700002)(122000001)(64756008)(8936002)(86362001)(33656002)(38070700005)(4326008)(8676002)(2906002)(52536014)(41300700001)(7416002)(5660300002)(55016003)(66556008)(66476007)(66446008)(83380400001)(6506007)(186003)(53546011)(26005)(54906003)(316002)(9686003)(110136005)(478600001)(66946007)(76116006)(7696005)(71200400001)(21314003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?AjfP7WB+5h1LraK85yqdQaC+LyZQmxL/qr3C3r5W+VA00Wgsj2RCjfxd3K4u?=
 =?us-ascii?Q?FpSsgriMBy9mmTrLxVPbpdj09VoZO+1b4CpoD/h09lT9wtytJ2sFZvDUeqq5?=
 =?us-ascii?Q?8R5xw407piAC25NOhxZdjVC8zhUuy4sImkAD+TQ8uWDTJeIGatSwCbtLzmxL?=
 =?us-ascii?Q?EC6s07yURrHB+qQZVMIuPJI5rdJBaKCozncMtpsxC4LB18zCx2Ua0fZeEeSR?=
 =?us-ascii?Q?xu3cx3hiDnPrsznKc0O35m/tUuB8JbIRD8Xq18I/X8xbw6+H+ih/fgS/tXsw?=
 =?us-ascii?Q?Y/JCnR3K0hEB72x/caBAD5vXxHErnEInWUOPmEp5Ej24JWYhTiCfUMC6w9hL?=
 =?us-ascii?Q?Zlw2L1OHaMHeGpjgnfkUbNtmGKhZl6k4CYqXn8iFj1+HI8B+YCXf37Cuf099?=
 =?us-ascii?Q?7OInOdlK1gAZ3SwfZyH0lQnfkdZWgPkuwGpjEv9pSe+zKOGlqFXT5LUTkrdg?=
 =?us-ascii?Q?UuDXc2Xv2IaVOEZbPQ4aJYNQg25F0Y9koLVLfFaBeXiolHeXhCkXmOx5yNhV?=
 =?us-ascii?Q?IrJ/ZPK1NGQVdEu2gDKxUEAB8QyO/+aeaVxgxWxgCJNEU8K3nq89Fzwk/j60?=
 =?us-ascii?Q?9SVewY6LhMpTJKf4PDrYSdmAOHaAt3697V1REjNn84CTM9H/EezQ9pUxPJY7?=
 =?us-ascii?Q?VWu5QSMjROCCxj4PVDfZzznDFfUHtCHXqKZDQ4IpWP7zaq4VvjpsIbZVHelN?=
 =?us-ascii?Q?ADw4nT9gBGsl//7y0YBVqZ7uP07DfS503OgF3V+4BQxDanjm0BsJOtzjtf1n?=
 =?us-ascii?Q?5cD4A7cluOGOsWVYEMSKqf5jpy8cIzbWG8vIBbGaTsIzOfEBIndCF/aCRsQ5?=
 =?us-ascii?Q?NsS6guGiVnFCjEUzdaH+ORG/9QWC6hpzrTQFDvdH3PdX88Axc9FtzVexcOlb?=
 =?us-ascii?Q?3Ay3l9DS7+iSVCgh5PEncaU/UvjbVY6YBfmR02CAcGKeT3iniQpdDyHD5GsF?=
 =?us-ascii?Q?uVhI5coqEKx5p/PaPkPAnkqXCAo0t/GINLmtBgSSHTBLg4iFMgAZgyaO9e9J?=
 =?us-ascii?Q?gpDo1V2XsjK3KtYckHma8o/t15JjIaU9LGwj4Alqg2d8Oq6V55C+IgxdQtOj?=
 =?us-ascii?Q?bxPvpNVXHyZU0Hym2qOuxRPeOwaBnlNRpQIXiTVUUbvkAWysT9BAl66SzoXx?=
 =?us-ascii?Q?9XSeFlbvSC2lS4JZkhacSsZBC0qY1V3fkAv3Um3Gc1nS+0nTmeL+4R4lZu/+?=
 =?us-ascii?Q?fJxhjS8wggupkugY2dcZJToZRaJRZ5ZTcPzY59IUvCyCwJdoPcss2tTufKI0?=
 =?us-ascii?Q?2LJvPgdUNXT0dYbbXugNVgqA4aLsNlyKv/5rhYXAvrFEZe7DtBbveHEFLBJl?=
 =?us-ascii?Q?m4nLt32FasndABXkiy7rGrZ7eyv3GrPQz99VLY7i2jK+uNz5aXk66u6YCcGA?=
 =?us-ascii?Q?bPCW24ajalnmJxt3jKpwiOn1hXQeyGjrGJhzYty+rOulfDlFrrgFo6AMvwQZ?=
 =?us-ascii?Q?IBwE0TiiUcSu7ABT97pxbJ3OtKIZZn8VHayO7uqVtB4OW64FWqlKeYjK1L7G?=
 =?us-ascii?Q?2YY2SMZePrVZemRrZRcfwhAUhMRC0DnmEuSfDIs53MYAVowtsm60Jy9KYzWg?=
 =?us-ascii?Q?Lc80XiVmKDPHsyJ943c=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f9f2fa4-8982-46f1-0d01-08db0acb0b6d
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Feb 2023 18:25:38.9235
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5IuXr6ugnvQicNij3IjQ4iJr2leTvtjNMsqoN7ba1Bg2sj1+gyO6t5s8Pby7v6b+Iz1yIx1Kq7MyqwcPOAE9sA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8408
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[AMD Official Use Only - General]



> -----Original Message-----
> From: Grzegorz Jaszczyk <jaz@semihalf.com>
> Sent: Thursday, February 9, 2023 09:21
> To: linux-kernel@vger.kernel.org; rafael@kernel.org
> Cc: dmy@semihalf.com; tn@semihalf.com; dbehr@google.com;
> zide.chen@intel.corp-partner.google.com; seanjc@google.com;
> upstream@semihalf.com; hdegoede@redhat.com; markgross@kernel.org;
> dtor@google.com; Limonciello, Mario <Mario.Limonciello@amd.com>; linux-
> pm@vger.kernel.org; x86@kernel.org; platform-driver-x86@vger.kernel.org;
> Grzegorz Jaszczyk <jaz@semihalf.com>
> Subject: [RESEND RFCv2 1/1] platform/x86: Add virtual PMC driver used for
> S2Idle
>=20
> Virtual PMC driver is meant for the guest VMs for the S2Idle
> notification. Its purpose is to register S2Idle dev ops check handler,
> which will evaluate ACPI _DSM just before the guest enters S2Idle power
> state.
>=20
> This allows to trap on MMIO access done as a consequence of _DSM
> evaluation and therefore notify the VMM about the guest entering S2Idle
> state.
>=20
> Signed-off-by: Grzegorz Jaszczyk <jaz@semihalf.com>
> ---
> Changelog v1..v2:
> - Take advantage of acpi_s2idle_dev_ops's check() instead of notify()
> ---
>  drivers/platform/x86/Kconfig    |  7 ++++
>  drivers/platform/x86/Makefile   |  3 ++
>  drivers/platform/x86/virt_pmc.c | 73
> +++++++++++++++++++++++++++++++++
>  3 files changed, 83 insertions(+)
>  create mode 100644 drivers/platform/x86/virt_pmc.c
>=20
> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
> index 5692385e2d26..b7c3f98031d7 100644
> --- a/drivers/platform/x86/Kconfig
> +++ b/drivers/platform/x86/Kconfig
> @@ -1099,6 +1099,13 @@ config WINMATE_FM07_KEYS
>  	  buttons below the display. This module adds an input device
>  	  that delivers key events when these buttons are pressed.
>=20
> +config VIRT_PMC
> +	tristate "Virt PMC"
> +	depends on ACPI && SUSPEND
> +	help
> +	  The Virtual PMC driver is meant for the guest VMs and its main
> +	  purpose is to notify about guest entering s2idle state.
> +
>  endif # X86_PLATFORM_DEVICES
>=20
>  config P2SB
> diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefil=
e
> index 1d3d1b02541b..c4d3056cf4ea 100644
> --- a/drivers/platform/x86/Makefile
> +++ b/drivers/platform/x86/Makefile
> @@ -129,6 +129,9 @@ obj-$(CONFIG_INTEL_SCU_WDT)		+=3D
> intel_scu_wdt.o
>  obj-$(CONFIG_INTEL_SCU_IPC_UTIL)	+=3D intel_scu_ipcutil.o
>  obj-$(CONFIG_X86_INTEL_LPSS)		+=3D pmc_atom.o
>=20
> +# Virtual PMC
> +obj-$(CONFIG_VIRT_PMC)			+=3D virt_pmc.o
> +
>  # Siemens Simatic Industrial PCs
>  obj-$(CONFIG_SIEMENS_SIMATIC_IPC)	+=3D simatic-ipc.o
>=20
> diff --git a/drivers/platform/x86/virt_pmc.c
> b/drivers/platform/x86/virt_pmc.c
> new file mode 100644
> index 000000000000..daf9c9ed86e5
> --- /dev/null
> +++ b/drivers/platform/x86/virt_pmc.c
> @@ -0,0 +1,73 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Virtual Power Management Controller Driver
> + *
> + * Author: Grzegorz Jaszczyk <jaz@semihalf.com>
> + */
> +
> +#include <linux/acpi.h>
> +#include <linux/platform_device.h>
> +
> +#define ACPI_VIRT_PMC_DSM_UUID	"9ea49ba3-434a-49a6-be30-
> 37cc55c4d397"
> +#define ACPI_VIRT_PMC_NOTIFY 1
> +
> +static acpi_handle virt_pmc_handle;
> +
> +static void virt_pmc_s2idle_notify(void)
> +{
> +	union acpi_object *out_obj;
> +	static guid_t dsm_guid;
> +
> +	guid_parse(ACPI_VIRT_PMC_DSM_UUID, &dsm_guid);
> +
> +	out_obj =3D acpi_evaluate_dsm(virt_pmc_handle, &dsm_guid,
> +					0, ACPI_VIRT_PMC_NOTIFY, NULL);
> +
> +	acpi_handle_debug(virt_pmc_handle, "_DSM function %u
> evaluation %s\n",
> +			  ACPI_VIRT_PMC_NOTIFY, out_obj ? "successful" :
> "failed");
> +
> +	ACPI_FREE(out_obj);
> +}
> +
> +static struct acpi_s2idle_dev_ops amd_pmc_s2idle_dev_ops =3D {
> +	.check =3D virt_pmc_s2idle_notify,
> +};
> +
> +static int virt_pmc_probe(struct platform_device *pdev)
> +{
> +	int err =3D 0;
> +
> +	virt_pmc_handle =3D ACPI_HANDLE(&pdev->dev);
> +
> +	err =3D acpi_register_lps0_dev(&amd_pmc_s2idle_dev_ops);
> +	if (err)
> +		dev_warn(&pdev->dev, "failed to register LPS0 sleep
> handler\n");
> +

Besides registering, I would think you also want to have a query to the
_DSM to determine what functions are available.  It could allow this to
scale better if you're going to need to introduce a new function again
later for a different reason.

> +	return err;
> +}
> +
> +static int virt_pmc_remove(struct platform_device *pdev)
> +{
> +	acpi_unregister_lps0_dev(&amd_pmc_s2idle_dev_ops);
> +
> +	return 0;
> +}
> +
> +static const struct acpi_device_id virt_pmc_acpi_ids[] =3D {
> +	{"HYPE0001", 0}, /* _HID for XXX Power Engine, _CID PNP0D80*/
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(acpi, virt_pmc_acpi_ids);
> +
> +static struct platform_driver virt_pmc_driver =3D {
> +	.driver =3D {
> +		.name =3D "virtual_pmc",
> +		.acpi_match_table =3D ACPI_PTR(virt_pmc_acpi_ids),
> +	},
> +	.probe =3D virt_pmc_probe,
> +	.remove =3D virt_pmc_remove,
> +};
> +
> +module_platform_driver(virt_pmc_driver);
> +
> +MODULE_DESCRIPTION("Virtual PMC Driver");
> --
> 2.39.1.519.gcb327c4b5f-goog
