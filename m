Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AD3B6509FE
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 11:21:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231720AbiLSKV1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 05:21:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231630AbiLSKVV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 05:21:21 -0500
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2080.outbound.protection.outlook.com [40.107.95.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5B352DF6;
        Mon, 19 Dec 2022 02:21:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XwaIQEwOZjUlR2y4zlA/oGnGHP6IBdor/tOD7hN6zX1OrhSK3h8cF4sbyiMzeFmBybyPNBfjpz87Qf1/p8QTi/W6PnsRQrTJZwVVrgQ+lqG/2ZbETPP88yREpdOusK2YSSjFiBq1fqBuvCV7H2Aays7ptzgoS7jB5LQgDHZybh4tPq5vZUVLUzts2EFZT4BUj9rSRfOD/wzRWmMuKgTkf6PQvW6toAmxlpEXvdC/etO+FASRFREOXKcmn9895j2KgMFDncI9ceHJjk5wQZGWt6Y7osyYO/iNja9yZgsQaToSQORdbPFOcIsL9nTPvukKt8SfFwqS1VniNwNgjkQbvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CnVcf0GNqdSSYjDTlDSXM4FCaPiZ0pttgCRxj0qfk1o=;
 b=cDbaImQVGtRwXydAMpCI/Gl+cEPlbY5AfjS4z5i/NynGHUgLRfN0zSDzt34HA6zE6lPp+KGelgUE2Pml23Y3AI+Rbn/t8eepnfuH0JEdZZgvSE2i8MQPwA+L0sr50F9I9mM0xfvkAfCEr5/fXEBP0+DFsro7dnCHDa3MDfqlWFLn3cFbEjkG5gsrkYUWGj+ACotcKZQ0Fv7KNDf4Gqoa2TYexMRitLu52XdKwrsEoRxVBXO8Gr9AplY05+ul7y/H7TJvuqwhLpApcDgB1C2IibCUveoUfWV5xGa2XUSoLOtXWdP6e/wQPoW7knYEgYWd/WpfY5P/9Zbf3pysgQ+l4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CnVcf0GNqdSSYjDTlDSXM4FCaPiZ0pttgCRxj0qfk1o=;
 b=rEtvfRbZE+X+zBcQdtzubbqsM/e+u7bTyEx7WAJHrqYaXpv0fSGequqxTINk1GrKBdB3bEKVrumroVa7fWmWsDQkgOvGFS6iBMyBGI+KXgWerpHg7luVnjq2/KualcO30xjtJRLYzXAgnTuaZelajXN+ThjzAh8cwrY9CHYOXvE=
Received: from DM4PR12MB5278.namprd12.prod.outlook.com (2603:10b6:5:39e::17)
 by CY5PR12MB6574.namprd12.prod.outlook.com (2603:10b6:930:42::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Mon, 19 Dec
 2022 10:21:15 +0000
Received: from DM4PR12MB5278.namprd12.prod.outlook.com
 ([fe80::960b:6963:b27e:f9ed]) by DM4PR12MB5278.namprd12.prod.outlook.com
 ([fe80::960b:6963:b27e:f9ed%8]) with mapi id 15.20.5924.016; Mon, 19 Dec 2022
 10:21:15 +0000
From:   "Yuan, Perry" <Perry.Yuan@amd.com>
To:     "Huang, Ray" <Ray.Huang@amd.com>,
        "Huang, Shimmer" <Shimmer.Huang@amd.com>,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        "Liang, Richard qi" <Richardqi.Liang@amd.com>
CC:     "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        "Sharma, Deepak" <Deepak.Sharma@amd.com>,
        "Fontenot, Nathan" <Nathan.Fontenot@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Huang, Shimmer" <Shimmer.Huang@amd.com>,
        "Du, Xiaojian" <Xiaojian.Du@amd.com>,
        "Meng, Li (Jassmine)" <Li.Meng@amd.com>,
        "Karny, Wyes" <Wyes.Karny@amd.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v7 05/13] cpufreq: amd-pstate: implement Pstate EPP
 support for the AMD processors
Thread-Topic: [PATCH v7 05/13] cpufreq: amd-pstate: implement Pstate EPP
 support for the AMD processors
Thread-Index: AQHZCvcWNMhvu9JOLUevScdSkWliVq5p9pIAgAsB/4A=
Date:   Mon, 19 Dec 2022 10:21:14 +0000
Message-ID: <DM4PR12MB527835D9808FEE13284F36F79CE59@DM4PR12MB5278.namprd12.prod.outlook.com>
References: <20221208111852.386731-1-perry.yuan@amd.com>
 <20221208111852.386731-6-perry.yuan@amd.com> <Y5bqWMJPqke5gdL1@amd.com>
In-Reply-To: <Y5bqWMJPqke5gdL1@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-12-19T08:52:40Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=72e54dee-f29f-4009-aca5-42b93f130f88;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2022-12-19T10:21:09Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: e2234383-7992-489c-94ca-0b81254535da
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5278:EE_|CY5PR12MB6574:EE_
x-ms-office365-filtering-correlation-id: e57df658-ad5a-4fe2-7329-08dae1aac278
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kEDsHrmQPBglFACyB1elv7peDHxQatxuwxeEMDDD2f0HA6SpPMcYG77uvpFf40GSLfwV3at+Jp+Yz2TkzMM1ieWyW7oTDZR7bVeno1ThBGCP8JHTzmFsM1cSOCYW19Q57bOtMqqCFpHiCSoM/anpQTiHiN2KpgviLYjBkBd0r8xev8/+3c/ItU//r8dlsN96RYq38vBiiR19Iy18FhUzv7xnGFwizV07jVQWfsNa/fOaQRWNAfrvGqdNws6e1jlW+yTNmmST1/94jQV03JAmTultxW/ox0Fy3rzSE/z4Bhf7n6pgUuzET0x0LshwA8l7CFkxWH/+nb6z24iFBx+lepeCkD3cASG+hP8BTnLEgjJEK46sVkpCuZUEFDk/5iLxsDkiZHBSv/TFyB+vWCH2YbHG/Ilk9VYUiog8vZOgM56Yg1IZTppQ4ugh8U/0SNg6hBkVGbfp0E67RsIdVRx2qIUB3HtGcybwR2Dpvyz+7gxzMkdD/8vI2asEoYtxGMdPjj+wC2C/deKn7E0b5PH4BQnuXoiC0t67mO93uKDNvkjAYh2j9gFjgnohGM13heJmUERKC98Bn4CosRPfxZEH6QQa/5A+zFqw5ctEyUP/Rk9klb/ckTpgdY7x8Irp/7oveFCD5klF0d/vEJyuiauknr7JaL7SZvwUI5Qx+pHXHi4sxUQ7EvOuTK8pyx2OTd2UIkuI8SljtdseERJbYUZP/g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5278.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(376002)(346002)(39860400002)(136003)(366004)(451199015)(33656002)(8936002)(5660300002)(52536014)(83380400001)(30864003)(186003)(41300700001)(55016003)(26005)(9686003)(2906002)(316002)(478600001)(38070700005)(6506007)(53546011)(7696005)(6636002)(54906003)(86362001)(66946007)(76116006)(66556008)(64756008)(122000001)(66476007)(66446008)(71200400001)(38100700002)(4326008)(110136005)(8676002)(559001)(579004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?FjAC4hW1ZKYsDfwqUfyH1QBG/YS+7gTz5GH6Bjr4oZTby7e0y6aOvzgHSsyb?=
 =?us-ascii?Q?JsuNWei7UIOYP5PmjwQRRjORKKV3TAqDXhOjwKvNWK3fCNsLeD4JwkBF9BSR?=
 =?us-ascii?Q?zhoviyqPLGHOwoQkDw7uolLD8WkHp9JVwuJT9UQuMV7D3qo97DJbQ/V7GfYj?=
 =?us-ascii?Q?KlNDE7WmOfDqnDPNhW4DHukmn57cceOhzWWIdNOUnyxk39bDDNZ7XikdcTGj?=
 =?us-ascii?Q?HVdk5kXvPbfD5xxE98WslkxPSuOlU64lAFl3V1ETWQSNEsiLIn3Awj74ovrd?=
 =?us-ascii?Q?RzgfPZGagTW4whiIsgjB2I5ZRxBu/6zqN5O5GSQW2NZqFb5P9yD9EnbGrcn7?=
 =?us-ascii?Q?Vh9yLt6v/YwsbV9VTyJXFTnzvxwvUuFifp4jRZAbJkwLKTb3ZOZiBz46qDPe?=
 =?us-ascii?Q?r2M+ZCC8ujHner11yKAnYrqvwX5b+hmwZtT8bOrGfGlHqpY+N3h7aOxRq/W9?=
 =?us-ascii?Q?sVs5f5RzFWVWmQiGXAYadta8m4faLTZ4otIzPtSX6FX3Ym2Rdp3yYEX/jqTE?=
 =?us-ascii?Q?ZhYONxixxGKso4v39tk2x5jx+VyJ0QK2aplQyIRTbqjqvDoPE0lPGkpi8tO2?=
 =?us-ascii?Q?zRHK0IF2ZBi9gVB0v1/7irilPYQtCwwpbujbXVsmmkGYUuw6vtkeSAACdBEW?=
 =?us-ascii?Q?6Q8o2lTzELIGqF3iCGFcB8CimL0j4fNXp3l5vCsW2zWpI/INxZgjZ4B7FQd3?=
 =?us-ascii?Q?n6381mzGyueWQycgjhS+9TBmqnX9PezSupxp7wdpChkwrnulVfCprZp50svt?=
 =?us-ascii?Q?l2wSnZ+VGloSEHQrJwmS5PKDCFasO8lZGObQnVeazB/qHosPWHuJ0R4nEypw?=
 =?us-ascii?Q?2J4513tLsyUVgfnsvWazCVwiOEloZO/EHZ0VmXFbUrD5Q93RfbHd+wE6adGh?=
 =?us-ascii?Q?XrTA1lmWewtrcaLrNZ44ycAbPlR3vJnzE8nPrY8UC3JR0WEgI7VSVwel+jwm?=
 =?us-ascii?Q?LtpzWgNuEpTomN81sZW8iResBoaGNcC/mxGZQuD7hh6zVhDpla2dZEyAAxQj?=
 =?us-ascii?Q?d5W58gZh5BNtRhWjPEHF2Sh4ah/YVQwyNZj93849JinYP52dudwXdo3u4QS9?=
 =?us-ascii?Q?rEEa0xtjOBOOrE4MYhxpIjRQe6QRshb6s7ZM9aUv2lejjo5rioCiTypTEiTl?=
 =?us-ascii?Q?TPb1ri+zRwTk8rkHlcm/wU4PVINLaaQTTXCUhoDz7WbJmf8ZczIlGVl6Ii0U?=
 =?us-ascii?Q?GdwTtDYVb2CoFRpJT9st3wBrU55gNcKkIz7rLF9RTdQZfM3+y3TJ6ZiRnJgs?=
 =?us-ascii?Q?BVRv4CF/JMgrqY2MgkpOlitzb+TxpEKypAJMcoGPSusG2+i9t/CqVqMfQREj?=
 =?us-ascii?Q?qW6I7NsfxEJMWpMYbmP6bRYlwkVeOvRxHb6McmRaervXo6GqwtpEkKcl9vZb?=
 =?us-ascii?Q?mp02/+vAI9LbvlhItNvXsMObaJ4Y4ztFokb8nZk65/UHD75SxrlMEJzmHyP8?=
 =?us-ascii?Q?/+gMrmtJenheOhzM6YZDCD5AacG/81XGb+dUgLDA6ZDiJkeS2YNxNDry82z9?=
 =?us-ascii?Q?N/VZae3yqvXRJOr6B/RUkUy6f6sR/mv18979mj1ggppSPfoOgGrrzUbEsNjH?=
 =?us-ascii?Q?3YuLLlpY8G22cISlDIyx/GOrWQINuTd8ZUISMX4z?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5278.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e57df658-ad5a-4fe2-7329-08dae1aac278
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2022 10:21:14.9085
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JNuYUWS3JBF6Vi8DUbpTvHtdg2KV3oo7mePtDltmkIih7TMJl3qGyBbgPCJ9z3wKAxtqcrpJe1RmGAK/VIYgpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6574
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

HI ray.=20

> -----Original Message-----
> From: Huang, Ray <Ray.Huang@amd.com>
> Sent: Monday, December 12, 2022 4:47 PM
> To: Yuan, Perry <Perry.Yuan@amd.com>
> Cc: rafael.j.wysocki@intel.com; Limonciello, Mario
> <Mario.Limonciello@amd.com>; viresh.kumar@linaro.org; Sharma, Deepak
> <Deepak.Sharma@amd.com>; Fontenot, Nathan
> <Nathan.Fontenot@amd.com>; Deucher, Alexander
> <Alexander.Deucher@amd.com>; Huang, Shimmer
> <Shimmer.Huang@amd.com>; Du, Xiaojian <Xiaojian.Du@amd.com>; Meng,
> Li (Jassmine) <Li.Meng@amd.com>; Karny, Wyes <Wyes.Karny@amd.com>;
> linux-pm@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH v7 05/13] cpufreq: amd-pstate: implement Pstate EPP
> support for the AMD processors
>=20
> On Thu, Dec 08, 2022 at 07:18:44PM +0800, Yuan, Perry wrote:
> > From: Perry Yuan <Perry.Yuan@amd.com>
> >
> > Add EPP driver support for AMD SoCs which support a dedicated MSR for
> > CPPC.  EPP is used by the DPM controller to configure the frequency
> > that a core operates at during short periods of activity.
> >
> > The SoC EPP targets are configured on a scale from 0 to 255 where 0
> > represents maximum performance and 255 represents maximum efficiency.
> >
> > The amd-pstate driver exports profile string names to userspace that
> > are tied to specific EPP values.
> >
> > The balance_performance string (0x80) provides the best balance for
> > efficiency versus power on most systems, but users can choose other
> > strings to meet their needs as well.
> >
> > $ cat
> >
> /sys/devices/system/cpu/cpufreq/policy0/energy_performance_available_p
> > references default performance balance_performance balance_power
> power
> >
> > $ cat
> >
> /sys/devices/system/cpu/cpufreq/policy0/energy_performance_preference
> > balance_performance
> >
> > To enable the driver,it needs to add `amd_pstate=3Dactive` to kernel
> > command line and kernel will load the active mode epp driver
> >
> > Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
> > ---
> >  drivers/cpufreq/amd-pstate.c | 631
> ++++++++++++++++++++++++++++++++++-
> >  include/linux/amd-pstate.h   |  35 ++
> >  2 files changed, 660 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/cpufreq/amd-pstate.c
> > b/drivers/cpufreq/amd-pstate.c index c17bd845f5fc..0a521be1be8a
> 100644
> > --- a/drivers/cpufreq/amd-pstate.c
> > +++ b/drivers/cpufreq/amd-pstate.c
> > @@ -37,6 +37,7 @@
> >  #include <linux/uaccess.h>
> >  #include <linux/static_call.h>
> >  #include <linux/amd-pstate.h>
> > +#include <linux/cpufreq_common.h>
> >
> >  #include <acpi/processor.h>
> >  #include <acpi/cppc_acpi.h>
> > @@ -59,9 +60,125 @@
> >   * we disable it by default to go acpi-cpufreq on these processors and=
 add
> a
> >   * module parameter to be able to enable it manually for debugging.
> >   */
> > -static struct cpufreq_driver amd_pstate_driver;
> > +static bool cppc_active;
> >  static int cppc_load __initdata;
> >
> > +static struct cpufreq_driver *default_pstate_driver; static struct
> > +amd_cpudata **all_cpu_data; static struct amd_pstate_params
> > +global_params;
> > +
> > +static DEFINE_MUTEX(amd_pstate_limits_lock);
> > +static DEFINE_MUTEX(amd_pstate_driver_lock);
> > +
> > +static bool cppc_boost __read_mostly;
> > +
> > +static s16 amd_pstate_get_epp(struct amd_cpudata *cpudata, u64
> > +cppc_req_cached) {
> > +	s16 epp;
> > +	struct cppc_perf_caps perf_caps;
> > +	int ret;
> > +
> > +	if (boot_cpu_has(X86_FEATURE_CPPC)) {
> > +		if (!cppc_req_cached) {
> > +			epp =3D rdmsrl_on_cpu(cpudata->cpu,
> MSR_AMD_CPPC_REQ,
> > +					&cppc_req_cached);
> > +			if (epp)
> > +				return epp;
> > +		}
> > +		epp =3D (cppc_req_cached >> 24) & 0xFF;
> > +	} else {
> > +		ret =3D cppc_get_epp_caps(cpudata->cpu, &perf_caps);
> > +		if (ret < 0) {
> > +			pr_debug("Could not retrieve energy perf value
> (%d)\n", ret);
> > +			return -EIO;
> > +		}
> > +		epp =3D (s16) perf_caps.energy_perf;
>=20
> It should align the static_call structure to implement the function. Plea=
se
> refer amd_pstate_init_perf. I think it can even re-use the init_perf to g=
et the
> epp cap value.

The  amd_pstate_init_perf() is only called when driver registering,
However the amd_pstate_get_epp() will be called frequently to update the EP=
P MSR value and EPP Min/Max  limitation.=20
So I suggest to keep using the amd_pstate_get_epp() to update EPP related v=
alues as it is.

Static_call method can do that for MSR and Shared memory  API  call, but am=
d_pstate_get_epp() is simple  enough for now. No need to make this=20
Epp update function also using static call method.=20
Considering the tight schedule and merge window, I would like to keep the c=
urrent way to update EPP, Otherwise the Customer release schedule will be d=
elayed.=20

Perry.


>=20
> > +	}
> > +
> > +	return epp;
> > +}
> > +
> > +static int amd_pstate_get_energy_pref_index(struct amd_cpudata
> > +*cpudata) {
> > +	s16 epp;
> > +	int index =3D -EINVAL;
> > +
> > +	epp =3D amd_pstate_get_epp(cpudata, 0);
> > +	if (epp < 0)
> > +		return epp;
> > +
> > +	switch (epp) {
> > +	case HWP_EPP_PERFORMANCE:
> > +		index =3D EPP_INDEX_PERFORMANCE;
> > +		break;
> > +	case HWP_EPP_BALANCE_PERFORMANCE:
> > +		index =3D EPP_INDEX_BALANCE_PERFORMANCE;
> > +		break;
> > +	case HWP_EPP_BALANCE_POWERSAVE:
> > +		index =3D EPP_INDEX_BALANCE_POWERSAVE;
> > +		break;
> > +	case HWP_EPP_POWERSAVE:
> > +		index =3D EPP_INDEX_POWERSAVE;
> > +		break;
> > +	default:
> > +			break;
> > +	}
> > +
> > +	return index;
> > +}
> > +
> > +static int amd_pstate_set_epp(struct amd_cpudata *cpudata, u32 epp) {
> > +	int ret;
> > +	struct cppc_perf_ctrls perf_ctrls;
> > +
> > +	if (boot_cpu_has(X86_FEATURE_CPPC)) {
> > +		u64 value =3D READ_ONCE(cpudata->cppc_req_cached);
> > +
> > +		value &=3D ~GENMASK_ULL(31, 24);
> > +		value |=3D (u64)epp << 24;
> > +		WRITE_ONCE(cpudata->cppc_req_cached, value);
> > +
> > +		ret =3D wrmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ,
> value);
> > +		if (!ret)
> > +			cpudata->epp_cached =3D epp;
> > +	} else {
> > +		perf_ctrls.energy_perf =3D epp;
> > +		ret =3D cppc_set_epp_perf(cpudata->cpu, &perf_ctrls, 1);
>=20
> Since the energy_perf is one of members of struct cppc_perf_ctrls, could =
we
> use cppc_set_perf as well?

cppc_set_epp_perf() can handle the EPP value update correctly,=20
cppc_set_perf() is used for desired perf updating with a very high updating=
 rate for governor such as schedutil governor.
And it has two Phase, Phase I and Phase II,  implement the EPP value update=
 in this function, I  have concern that we will meet some potential=20
Firmware or performance drop risk.=20
The release schedule and merge window is closing for v6.2 and this change r=
equest happened after six  patch review series.
I afraid of that we have no enough time to mitigate the risk for this new c=
ode change.
We can consider to continue optimize this in the following patch.

Perry.

>=20
> > +		if (ret) {
> > +			pr_debug("failed to set energy perf value (%d)\n",
> ret);
> > +			return ret;
> > +		}
> > +		cpudata->epp_cached =3D epp;
> > +	}
> > +
> > +	return ret;
> > +}
>=20
> The same with above, the helpers for different cppc types of processors s=
uch
> as MSR or share memory should be implemented by static_call.
>=20
> > +
> > +static int amd_pstate_set_energy_pref_index(struct amd_cpudata
> *cpudata,
> > +		int pref_index)
> > +{
> > +	int epp =3D -EINVAL;
> > +	int ret;
> > +
> > +	if (!pref_index) {
> > +		pr_debug("EPP pref_index is invalid\n");
> > +		return -EINVAL;
> > +	}
> > +
> > +	if (epp =3D=3D -EINVAL)
> > +		epp =3D epp_values[pref_index];
> > +
> > +	if (epp > 0 && cpudata->policy =3D=3D CPUFREQ_POLICY_PERFORMANCE)
> {
> > +		pr_debug("EPP cannot be set under performance policy\n");
> > +		return -EBUSY;
> > +	}
> > +
> > +	ret =3D amd_pstate_set_epp(cpudata, epp);
> > +
> > +	return ret;
> > +}
> > +
> >  static inline int pstate_enable(bool enable)  {
> >  	return wrmsrl_safe(MSR_AMD_CPPC_ENABLE, enable); @@ -70,11
> +187,21
> > @@ static inline int pstate_enable(bool enable)  static int
> > cppc_enable(bool enable)  {
> >  	int cpu, ret =3D 0;
> > +	struct cppc_perf_ctrls perf_ctrls;
> >
> >  	for_each_present_cpu(cpu) {
> >  		ret =3D cppc_set_enable(cpu, enable);
> >  		if (ret)
> >  			return ret;
> > +
> > +		/* Enable autonomous mode for EPP */
> > +		if (!cppc_active) {
> > +			/* Set desired perf as zero to allow EPP firmware
> control */
> > +			perf_ctrls.desired_perf =3D 0;
> > +			ret =3D cppc_set_perf(cpu, &perf_ctrls);
> > +			if (ret)
> > +				return ret;
> > +		}
> >  	}
> >
> >  	return ret;
> > @@ -418,7 +545,7 @@ static void amd_pstate_boost_init(struct
> amd_cpudata *cpudata)
> >  		return;
> >
> >  	cpudata->boost_supported =3D true;
> > -	amd_pstate_driver.boost_enabled =3D true;
> > +	default_pstate_driver->boost_enabled =3D true;
> >  }
> >
> >  static void amd_perf_ctl_reset(unsigned int cpu) @@ -592,10 +719,61
> > @@ static ssize_t show_amd_pstate_highest_perf(struct cpufreq_policy
> *policy,
> >  	return sprintf(&buf[0], "%u\n", perf);  }
> >
> > +static ssize_t show_energy_performance_available_preferences(
> > +				struct cpufreq_policy *policy, char *buf) {
> > +	int i =3D 0;
> > +	int offset =3D 0;
> > +
> > +	while (energy_perf_strings[i] !=3D NULL)
> > +		offset +=3D sysfs_emit_at(buf, offset, "%s ",
> > +energy_perf_strings[i++]);
> > +
> > +	sysfs_emit_at(buf, offset, "\n");
> > +
> > +	return offset;
> > +}
> > +
> > +static ssize_t store_energy_performance_preference(
> > +		struct cpufreq_policy *policy, const char *buf, size_t count) {
> > +	struct amd_cpudata *cpudata =3D policy->driver_data;
> > +	char str_preference[21];
> > +	ssize_t ret;
> > +
> > +	ret =3D sscanf(buf, "%20s", str_preference);
> > +	if (ret !=3D 1)
> > +		return -EINVAL;
> > +
> > +	ret =3D match_string(energy_perf_strings, -1, str_preference);
> > +	if (ret < 0)
> > +		return -EINVAL;
> > +
> > +	mutex_lock(&amd_pstate_limits_lock);
> > +	ret =3D amd_pstate_set_energy_pref_index(cpudata, ret);
> > +	mutex_unlock(&amd_pstate_limits_lock);
> > +
> > +	return ret ?: count;
> > +}
> > +
> > +static ssize_t show_energy_performance_preference(
> > +				struct cpufreq_policy *policy, char *buf) {
> > +	struct amd_cpudata *cpudata =3D policy->driver_data;
> > +	int preference;
> > +
> > +	preference =3D amd_pstate_get_energy_pref_index(cpudata);
> > +	if (preference < 0)
> > +		return preference;
> > +
> > +	return sysfs_emit(buf, "%s\n", energy_perf_strings[preference]); }
> > +
> >  cpufreq_freq_attr_ro(amd_pstate_max_freq);
> >  cpufreq_freq_attr_ro(amd_pstate_lowest_nonlinear_freq);
> >
> >  cpufreq_freq_attr_ro(amd_pstate_highest_perf);
> > +cpufreq_freq_attr_rw(energy_performance_preference);
> > +cpufreq_freq_attr_ro(energy_performance_available_preferences);
> >
> >  static struct freq_attr *amd_pstate_attr[] =3D {
> >  	&amd_pstate_max_freq,
> > @@ -604,6 +782,424 @@ static struct freq_attr *amd_pstate_attr[] =3D {
> >  	NULL,
> >  };
> >
> > +static struct freq_attr *amd_pstate_epp_attr[] =3D {
> > +	&amd_pstate_max_freq,
> > +	&amd_pstate_lowest_nonlinear_freq,
> > +	&amd_pstate_highest_perf,
> > +	&energy_performance_preference,
> > +	&energy_performance_available_preferences,
> > +	NULL,
> > +};
> > +
> > +static inline void update_boost_state(void) {
> > +	u64 misc_en;
> > +	struct amd_cpudata *cpudata;
> > +
> > +	cpudata =3D all_cpu_data[0];
> > +	rdmsrl(MSR_K7_HWCR, misc_en);
> > +	global_params.cppc_boost_disabled =3D misc_en & BIT_ULL(25);
>=20
> I won't need introduce the additional cppc_boost_disabled here. The
> cpufreq_driver->boost_enabled and cpudata->boost_supported can manage
> this function.

The cppc_boost_disabled is used to mark if the PMFW Core boost disabled,=20
If some other driver for example thermal, performance limiting driver disab=
le the core  boost.
We need to update the flag to let driver know the boost is disabled. =20

* boost_supported is used to change CORE freq boost  state.=20
* EPP driver did not use the cpufreq core boost sysfs node.  So the boost_e=
nabled is not used here.=20

>=20
> I believe it should be the firmware issue that the legacy ACPI Boost stat=
e will
> impact the frequency of CPPC. Could you move this handling into the
> cpufreq_driver->set_boost callback function to enable boost state by defa=
ult.
>=20
> > +}
> > +
> > +static bool amd_pstate_acpi_pm_profile_server(void)
> > +{
> > +	if (acpi_gbl_FADT.preferred_profile =3D=3D PM_ENTERPRISE_SERVER ||
> > +	    acpi_gbl_FADT.preferred_profile =3D=3D PM_PERFORMANCE_SERVER)
> > +		return true;
> > +
> > +	return false;
> > +}
> > +
> > +static int amd_pstate_init_cpu(unsigned int cpunum) {
> > +	struct amd_cpudata *cpudata;
> > +
> > +	cpudata =3D all_cpu_data[cpunum];
> > +	if (!cpudata) {
> > +		cpudata =3D kzalloc(sizeof(*cpudata), GFP_KERNEL);
> > +		if (!cpudata)
> > +			return -ENOMEM;
> > +		WRITE_ONCE(all_cpu_data[cpunum], cpudata);
> > +
> > +		cpudata->cpu =3D cpunum;
> > +
> > +		if (cppc_active) {
>=20
> The cppc_active is a bit confused here, if we run into amd-pstate driver,=
 the
> cppc should be active. I know you want to indicate the different driver m=
ode
> you are running. Please use an enumeration type to mark it different mode
> such as PASSIVE_MODE, ACTIVE_MODE, and GUIDED_MODE (Wyes
> proposed).

Aligned with Wyse, I add one new patch to support enumerated working mode i=
n V8


>=20
> > +			if (amd_pstate_acpi_pm_profile_server())
> > +				cppc_boost =3D true;
> > +		}
> > +
> > +	}
> > +	cpudata->epp_powersave =3D -EINVAL;
> > +	cpudata->epp_policy =3D 0;
> > +	pr_debug("controlling: cpu %d\n", cpunum);
> > +	return 0;
> > +}
> > +
> > +static int __amd_pstate_cpu_init(struct cpufreq_policy *policy) {
> > +	int min_freq, max_freq, nominal_freq, lowest_nonlinear_freq, ret;
> > +	struct amd_cpudata *cpudata;
> > +	struct device *dev;
> > +	int rc;
> > +	u64 value;
> > +
> > +	rc =3D amd_pstate_init_cpu(policy->cpu);
> > +	if (rc)
> > +		return rc;
> > +
> > +	cpudata =3D all_cpu_data[policy->cpu];
> > +
> > +	dev =3D get_cpu_device(policy->cpu);
> > +	if (!dev)
> > +		goto free_cpudata1;
> > +
> > +	rc =3D amd_pstate_init_perf(cpudata);
> > +	if (rc)
> > +		goto free_cpudata1;
> > +
> > +	min_freq =3D amd_get_min_freq(cpudata);
> > +	max_freq =3D amd_get_max_freq(cpudata);
> > +	nominal_freq =3D amd_get_nominal_freq(cpudata);
> > +	lowest_nonlinear_freq =3D amd_get_lowest_nonlinear_freq(cpudata);
> > +	if (min_freq < 0 || max_freq < 0 || min_freq > max_freq) {
> > +		dev_err(dev, "min_freq(%d) or max_freq(%d) value is
> incorrect\n",
> > +				min_freq, max_freq);
> > +		ret =3D -EINVAL;
> > +		goto free_cpudata1;
> > +	}
> > +
> > +	policy->min =3D min_freq;
> > +	policy->max =3D max_freq;
> > +
> > +	policy->cpuinfo.min_freq =3D min_freq;
> > +	policy->cpuinfo.max_freq =3D max_freq;
> > +	/* It will be updated by governor */
> > +	policy->cur =3D policy->cpuinfo.min_freq;
> > +
> > +	/* Initial processor data capability frequencies */
> > +	cpudata->max_freq =3D max_freq;
> > +	cpudata->min_freq =3D min_freq;
> > +	cpudata->nominal_freq =3D nominal_freq;
> > +	cpudata->lowest_nonlinear_freq =3D lowest_nonlinear_freq;
> > +
> > +	policy->driver_data =3D cpudata;
> > +
> > +	update_boost_state();
> > +	cpudata->epp_cached =3D amd_pstate_get_epp(cpudata, value);
> > +
> > +	policy->min =3D policy->cpuinfo.min_freq;
> > +	policy->max =3D policy->cpuinfo.max_freq;
> > +
> > +	if (boot_cpu_has(X86_FEATURE_CPPC))
> > +		policy->fast_switch_possible =3D true;
>=20
> Please move this line into below if-case.


Fixed In V8

>=20
> > +
> > +	if (boot_cpu_has(X86_FEATURE_CPPC)) {
> > +		ret =3D rdmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ,
> &value);
> > +		if (ret)
> > +			return ret;
> > +		WRITE_ONCE(cpudata->cppc_req_cached, value);
> > +
> > +		ret =3D rdmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_CAP1,
> &value);
> > +		if (ret)
> > +			return ret;
> > +		WRITE_ONCE(cpudata->cppc_cap1_cached, value);
> > +	}
> > +	amd_pstate_boost_init(cpudata);
> > +
> > +	return 0;
> > +
> > +free_cpudata1:
> > +	kfree(cpudata);
> > +	return ret;
> > +}
> > +
> > +static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy) {
> > +	int ret;
> > +
> > +	ret =3D __amd_pstate_cpu_init(policy);
>=20
> I don't see any reason that we need to define a __amd_pstate_cpu_init()
> here. Intel P-State driver's __intel_pstate_cpu_init() is used both on
> intel_pstate_cpu_init and intel_cpufreq_cpu_init.

Fixed in V8.

>=20
> > +	if (ret)
> > +		return ret;
> > +	/*
> > +	 * Set the policy to powersave to provide a valid fallback value in
> case
> > +	 * the default cpufreq governor is neither powersave nor
> performance.
> > +	 */
> > +	policy->policy =3D CPUFREQ_POLICY_POWERSAVE;
> > +
> > +	return 0;
> > +}
> > +
> > +static int amd_pstate_epp_cpu_exit(struct cpufreq_policy *policy) {
> > +	pr_debug("CPU %d exiting\n", policy->cpu);
> > +	policy->fast_switch_possible =3D false;
> > +	return 0;
> > +}
> > +
> > +static void amd_pstate_update_max_freq(unsigned int cpu)
>=20
> Why do you name this function "update max frequency"?
>=20
> We won't have the differnt cpudata->pstate.max_freq and
> cpudata->pstate.turbo_freq on Intel P-State driver.
>=20
> I think in fact we don't update anything here.

When core frequency was disabled, the function will update the frequency li=
mits.=20
Currently the boost sysfs is not added, so the max freq is not changed.
Could we keep the code for the coming patch to add the sysfs node for boost=
 control ?
It has no harm to the EPP driver.=20

>=20
> > +{
> > +	struct cpufreq_policy *policy =3D policy =3D cpufreq_cpu_get(cpu);
>=20
> struct cpufreq_policy *policy =3D cpufreq_cpu_get(cpu);
>=20
> > +
> > +	if (!policy)
> > +		return;
> > +
> > +	refresh_frequency_limits(policy);
> > +	cpufreq_cpu_put(policy);
> > +}
> > +
> > +static void amd_pstate_epp_update_limits(unsigned int cpu) {
> > +	mutex_lock(&amd_pstate_driver_lock);
> > +	update_boost_state();
> > +	if (global_params.cppc_boost_disabled) {
> > +		for_each_possible_cpu(cpu)
> > +			amd_pstate_update_max_freq(cpu);
>=20
> This should do nothing in the amd-pstate.

Currently the boost sysfs is not added, so the max freq is not changed.
Could we keep the code for the coming patch to add the sysfs node for boost=
 control ?
It has no harm to the EPP driver.

>=20
> > +	} else {
> > +		cpufreq_update_policy(cpu);
> > +	}
> > +	mutex_unlock(&amd_pstate_driver_lock);
> > +}
> > +
> > +static int cppc_boost_hold_time_ns =3D 3 * NSEC_PER_MSEC;
> > +
> > +static inline void amd_pstate_boost_up(struct amd_cpudata *cpudata) {
> > +	u64 hwp_req =3D READ_ONCE(cpudata->cppc_req_cached);
> > +	u64 hwp_cap =3D READ_ONCE(cpudata->cppc_cap1_cached);
> > +	u32 max_limit =3D (hwp_req & 0xff);
> > +	u32 min_limit =3D (hwp_req & 0xff00) >> 8;
>=20
> We can use cpudata->max_perf and cpudata->min_perf directly.

Iowait boost code removed from V8.

>=20
> > +	u32 boost_level1;
> > +
> > +	/* If max and min are equal or already at max, nothing to boost */
>=20
> I believe this is the only case that max_perf =3D=3D min_perf, not at max=
.

Iowait boost code removed from V8.

>=20
> > +	if (max_limit =3D=3D min_limit)
> > +		return;
> > +
> > +	/* Set boost max and min to initial value */
> > +	if (!cpudata->cppc_boost_min)
> > +		cpudata->cppc_boost_min =3D min_limit;
> > +
> > +	boost_level1 =3D ((AMD_CPPC_NOMINAL_PERF(hwp_cap) +
> min_limit) >> 1);
> > +
> > +	if (cpudata->cppc_boost_min < boost_level1)
> > +		cpudata->cppc_boost_min =3D boost_level1;
> > +	else if (cpudata->cppc_boost_min <
> AMD_CPPC_NOMINAL_PERF(hwp_cap))
> > +		cpudata->cppc_boost_min =3D
> AMD_CPPC_NOMINAL_PERF(hwp_cap);
> > +	else if (cpudata->cppc_boost_min =3D=3D
> AMD_CPPC_NOMINAL_PERF(hwp_cap))
> > +		cpudata->cppc_boost_min =3D max_limit;
> > +	else
> > +		return;
>=20
> Could you please elaborate the reason that you separate the min_perf
> (cppc_boost_min) you would like to update into cppc_req register as these
> different cases? Why we pick up these cases such as (min + nominal)/2, an=
d
> around nominal? What's the help to optimize the final result? - I am thin=
king
> the autonomous mode is handled by SMU firmware, we need to provide
> some data that let us know it influences the final result.
>=20

Iowait boost code removed from V8.

> > +
> > +	hwp_req &=3D ~AMD_CPPC_MIN_PERF(~0L);
> > +	hwp_req |=3D AMD_CPPC_MIN_PERF(cpudata->cppc_boost_min);
> > +	wrmsrl(MSR_AMD_CPPC_REQ, hwp_req);
>=20
> Do we need an update for share memory processors? In other words, epp is
> also supported on share memory processors. - again, we should use static
> call to handle the msr and cppc_acpi stuff.
>=20
> > +	cpudata->last_update =3D cpudata->sample.time; }
> > +
> > +static inline void amd_pstate_boost_down(struct amd_cpudata *cpudata)
> > +{
> > +	bool expired;
> > +
> > +	if (cpudata->cppc_boost_min) {
> > +		expired =3D time_after64(cpudata->sample.time, cpudata-
> >last_update +
> > +					cppc_boost_hold_time_ns);
> > +
> > +		if (expired) {
> > +			wrmsrl(MSR_AMD_CPPC_REQ, cpudata-
> >cppc_req_cached);
> > +			cpudata->cppc_boost_min =3D 0;
> > +		}
> > +	}
> > +
> > +	cpudata->last_update =3D cpudata->sample.time; }
> > +
> > +static inline void amd_pstate_boost_update_util(struct amd_cpudata
> *cpudata,
> > +						      u64 time)
> > +{
> > +	cpudata->sample.time =3D time;
> > +	if (smp_processor_id() !=3D cpudata->cpu)
> > +		return;
> > +
> > +	if (cpudata->sched_flags & SCHED_CPUFREQ_IOWAIT) {
> > +		bool do_io =3D false;
> > +
> > +		cpudata->sched_flags =3D 0;
> > +		/*
> > +		 * Set iowait_boost flag and update time. Since IO WAIT flag
> > +		 * is set all the time, we can't just conclude that there is
> > +		 * some IO bound activity is scheduled on this CPU with just
> > +		 * one occurrence. If we receive at least two in two
> > +		 * consecutive ticks, then we treat as boost candidate.
> > +		 * This is leveraged from Intel Pstate driver.
>=20
> I would like to know whether we can hit this case as well? If we can find=
 or
> create a use case to hit it in our platforms, I am fine to add it our dri=
ver as
> well. If not, I don't suggest it we add them at this moment. I hope we ha=
ve
> verified each code path once we add them into the driver.

Sure, no problem.=20
Iowait boost code removed from V8.


>=20
> > +		 */
> > +		if (time_before64(time, cpudata->last_io_update + 2 *
> TICK_NSEC))
> > +			do_io =3D true;
> > +
> > +		cpudata->last_io_update =3D time;
> > +
> > +		if (do_io)
> > +			amd_pstate_boost_up(cpudata);
> > +
> > +	} else {
> > +		amd_pstate_boost_down(cpudata);
> > +	}
> > +}
> > +
> > +static inline void amd_pstate_cppc_update_hook(struct update_util_data
> *data,
> > +						u64 time, unsigned int flags)
> > +{
> > +	struct amd_cpudata *cpudata =3D container_of(data,
> > +				struct amd_cpudata, update_util);
> > +
> > +	cpudata->sched_flags |=3D flags;
> > +
> > +	if (smp_processor_id() =3D=3D cpudata->cpu)
> > +		amd_pstate_boost_update_util(cpudata, time); }
> > +
> > +static void amd_pstate_clear_update_util_hook(unsigned int cpu) {
> > +	struct amd_cpudata *cpudata =3D all_cpu_data[cpu];
> > +
> > +	if (!cpudata->update_util_set)
> > +		return;
> > +
> > +	cpufreq_remove_update_util_hook(cpu);
> > +	cpudata->update_util_set =3D false;
> > +	synchronize_rcu();
> > +}
> > +
> > +static void amd_pstate_set_update_util_hook(unsigned int cpu_num) {
> > +	struct amd_cpudata *cpudata =3D all_cpu_data[cpu_num];
> > +
> > +	if (!cppc_boost) {
> > +		if (cpudata->update_util_set)
> > +			amd_pstate_clear_update_util_hook(cpudata->cpu);
> > +		return;
> > +	}
> > +
> > +	if (cpudata->update_util_set)
> > +		return;
> > +
> > +	cpudata->sample.time =3D 0;
> > +	cpufreq_add_update_util_hook(cpu_num, &cpudata->update_util,
> > +
> 	amd_pstate_cppc_update_hook);
> > +	cpudata->update_util_set =3D true;
> > +}
> > +
> > +static void amd_pstate_epp_init(unsigned int cpu) {
> > +	struct amd_cpudata *cpudata =3D all_cpu_data[cpu];
> > +	u32 max_perf, min_perf;
> > +	u64 value;
> > +	s16 epp;
> > +
> > +	max_perf =3D READ_ONCE(cpudata->highest_perf);
> > +	min_perf =3D READ_ONCE(cpudata->lowest_perf);
> > +
> > +	value =3D READ_ONCE(cpudata->cppc_req_cached);
> > +
> > +	if (cpudata->policy =3D=3D CPUFREQ_POLICY_PERFORMANCE)
> > +		min_perf =3D max_perf;
> > +
> > +	/* Initial min/max values for CPPC Performance Controls Register */
> > +	value &=3D ~AMD_CPPC_MIN_PERF(~0L);
> > +	value |=3D AMD_CPPC_MIN_PERF(min_perf);
> > +
> > +	value &=3D ~AMD_CPPC_MAX_PERF(~0L);
> > +	value |=3D AMD_CPPC_MAX_PERF(max_perf);
> > +
> > +	/* CPPC EPP feature require to set zero to the desire perf bit */
> > +	value &=3D ~AMD_CPPC_DES_PERF(~0L);
> > +	value |=3D AMD_CPPC_DES_PERF(0);
> > +
> > +	if (cpudata->epp_policy =3D=3D cpudata->policy)
> > +		goto skip_epp;
> > +
> > +	cpudata->epp_policy =3D cpudata->policy;
> > +
> > +	if (cpudata->policy =3D=3D CPUFREQ_POLICY_PERFORMANCE) {
> > +		epp =3D amd_pstate_get_epp(cpudata, value);
> > +		cpudata->epp_powersave =3D epp;
>=20
> I didn't see where we should have epp_powersave here. Only initial this, =
but
> it won't be used anywhere.

epp_powersave   var was removed from V8.


>=20
> > +		if (epp < 0)
> > +			goto skip_epp;
> > +		/* force the epp value to be zero for performance policy */
> > +		epp =3D 0;
> > +	} else {
> > +		if (cpudata->epp_powersave < 0)
> > +			goto skip_epp;
> > +		/* Get BIOS pre-defined epp value */
> > +		epp =3D amd_pstate_get_epp(cpudata, value);
> > +		if (epp)
> > +			goto skip_epp;
> > +		epp =3D cpudata->epp_powersave;
> > +	}
> > +	/* Set initial EPP value */
> > +	if (boot_cpu_has(X86_FEATURE_CPPC)) {
> > +		value &=3D ~GENMASK_ULL(31, 24);
> > +		value |=3D (u64)epp << 24;
> > +	}
> > +
> > +skip_epp:
> > +	WRITE_ONCE(cpudata->cppc_req_cached, value);
> > +	amd_pstate_set_epp(cpudata, epp);
> > +}
> > +
> > +static void amd_pstate_set_max_limits(struct amd_cpudata *cpudata) {
> > +	u64 hwp_cap =3D READ_ONCE(cpudata->cppc_cap1_cached);
> > +	u64 hwp_req =3D READ_ONCE(cpudata->cppc_req_cached);
> > +	u32 max_limit =3D (hwp_cap >> 24) & 0xff;
> > +
> > +	hwp_req &=3D ~AMD_CPPC_MIN_PERF(~0L);
> > +	hwp_req |=3D AMD_CPPC_MIN_PERF(max_limit);
> > +	wrmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ, hwp_req); }
> > +
> > +static int amd_pstate_epp_set_policy(struct cpufreq_policy *policy) {
> > +	struct amd_cpudata *cpudata;
> > +
> > +	if (!policy->cpuinfo.max_freq)
> > +		return -ENODEV;
> > +
> > +	pr_debug("set_policy: cpuinfo.max %u policy->max %u\n",
> > +				policy->cpuinfo.max_freq, policy->max);
> > +
> > +	cpudata =3D all_cpu_data[policy->cpu];
> > +	cpudata->policy =3D policy->policy;
> > +
> > +	if (boot_cpu_has(X86_FEATURE_CPPC)) {
> > +		mutex_lock(&amd_pstate_limits_lock);
> > +
> > +		if (cpudata->policy =3D=3D CPUFREQ_POLICY_PERFORMANCE) {
> > +			amd_pstate_clear_update_util_hook(policy->cpu);
> > +			amd_pstate_set_max_limits(cpudata);
> > +		} else {
> > +			amd_pstate_set_update_util_hook(policy->cpu);
> > +		}
> > +
> > +		mutex_unlock(&amd_pstate_limits_lock);
> > +	}
> > +	amd_pstate_epp_init(policy->cpu);
> > +
> > +	return 0;
> > +}
> > +
> > +static void amd_pstate_verify_cpu_policy(struct amd_cpudata *cpudata,
> > +					   struct cpufreq_policy_data *policy)
> {
> > +	update_boost_state();
> > +	cpufreq_verify_within_cpu_limits(policy);
> > +}
> > +
> > +static int amd_pstate_epp_verify_policy(struct cpufreq_policy_data
> > +*policy) {
> > +	amd_pstate_verify_cpu_policy(all_cpu_data[policy->cpu], policy);
> > +	pr_debug("policy_max =3D%d, policy_min=3D%d\n", policy->max, policy-
> >min);
> > +	return 0;
> > +}
>=20
> amd_pstate_verify_cpu_policy and amd_pstate_epp_verify_policy can be
> squeezed in one function.

Fixed in V8.=20

>=20
> > +
> >  static struct cpufreq_driver amd_pstate_driver =3D {
> >  	.flags		=3D CPUFREQ_CONST_LOOPS |
> CPUFREQ_NEED_UPDATE_LIMITS,
> >  	.verify		=3D amd_pstate_verify,
> > @@ -617,8 +1213,20 @@ static struct cpufreq_driver amd_pstate_driver =
=3D
> {
> >  	.attr		=3D amd_pstate_attr,
> >  };
> >
> > +static struct cpufreq_driver amd_pstate_epp_driver =3D {
> > +	.flags		=3D CPUFREQ_CONST_LOOPS,
> > +	.verify		=3D amd_pstate_epp_verify_policy,
> > +	.setpolicy	=3D amd_pstate_epp_set_policy,
> > +	.init		=3D amd_pstate_epp_cpu_init,
> > +	.exit		=3D amd_pstate_epp_cpu_exit,
> > +	.update_limits	=3D amd_pstate_epp_update_limits,
> > +	.name		=3D "amd_pstate_epp",
> > +	.attr		=3D amd_pstate_epp_attr,
> > +};
> > +
> >  static int __init amd_pstate_init(void)  {
> > +	static struct amd_cpudata **cpudata;
> >  	int ret;
> >
> >  	if (boot_cpu_data.x86_vendor !=3D X86_VENDOR_AMD) @@ -645,7
> +1253,8 @@
> > static int __init amd_pstate_init(void)
> >  	/* capability check */
> >  	if (boot_cpu_has(X86_FEATURE_CPPC)) {
> >  		pr_debug("AMD CPPC MSR based functionality is
> supported\n");
> > -		amd_pstate_driver.adjust_perf =3D amd_pstate_adjust_perf;
> > +		if (!cppc_active)
> > +			default_pstate_driver->adjust_perf =3D
> amd_pstate_adjust_perf;
> >  	} else {
> >  		pr_debug("AMD CPPC shared memory based functionality is
> supported\n");
> >  		static_call_update(amd_pstate_enable, cppc_enable); @@ -
> 653,6
> > +1262,10 @@ static int __init amd_pstate_init(void)
> >  		static_call_update(amd_pstate_update_perf,
> cppc_update_perf);
> >  	}
> >
> > +	cpudata =3D vzalloc(array_size(sizeof(void *), num_possible_cpus()));
> > +	if (!cpudata)
> > +		return -ENOMEM;
> > +	WRITE_ONCE(all_cpu_data, cpudata);
>=20
> Why we cannot use cpufreq_policy->driver_data to store the cpudata? I
> believe the cpudata is per-CPU can be easily get from private data.

cpufreq_policy->driver_data can do that, but global data can have better ca=
ched hit rate especially=20
for the server cluster.
So I would prefer to use the global cpudata to store each CPU data struct.=
=20
Could we keep it for EPP driver ?


>=20
> >  	/* enable amd pstate feature */
> >  	ret =3D amd_pstate_enable(true);
> >  	if (ret) {
> > @@ -660,9 +1273,9 @@ static int __init amd_pstate_init(void)
> >  		return ret;
> >  	}
> >
> > -	ret =3D cpufreq_register_driver(&amd_pstate_driver);
> > +	ret =3D cpufreq_register_driver(default_pstate_driver);
> >  	if (ret)
> > -		pr_err("failed to register amd_pstate_driver with
> return %d\n",
> > +		pr_err("failed to register amd pstate driver with
> return %d\n",
> >  		       ret);
> >
> >  	return ret;
> > @@ -677,8 +1290,14 @@ static int __init amd_pstate_param(char *str)
> >  	if (!strcmp(str, "disable")) {
> >  		cppc_load =3D 0;
> >  		pr_info("driver is explicitly disabled\n");
> > -	} else if (!strcmp(str, "passive"))
> > +	} else if (!strcmp(str, "passive")) {
> >  		cppc_load =3D 1;
> > +		default_pstate_driver =3D &amd_pstate_driver;
> > +	} else if (!strcmp(str, "active")) {
> > +		cppc_active =3D 1;
> > +		cppc_load =3D 1;
> > +		default_pstate_driver =3D &amd_pstate_epp_driver;
> > +	}
> >
> >  	return 0;
> >  }
> > diff --git a/include/linux/amd-pstate.h b/include/linux/amd-pstate.h
> > index 1c4b8659f171..888af62040f1 100644
> > --- a/include/linux/amd-pstate.h
> > +++ b/include/linux/amd-pstate.h
> > @@ -25,6 +25,7 @@ struct amd_aperf_mperf {
> >  	u64 aperf;
> >  	u64 mperf;
> >  	u64 tsc;
> > +	u64 time;
> >  };
> >
> >  /**
> > @@ -47,6 +48,18 @@ struct amd_aperf_mperf {
> >   * @prev: Last Aperf/Mperf/tsc count value read from register
> >   * @freq: current cpu frequency value
> >   * @boost_supported: check whether the Processor or SBIOS supports
> > boost mode
> > + * @epp_powersave: Last saved CPPC energy performance preference
> > +				when policy switched to performance
> > + * @epp_policy: Last saved policy used to set energy-performance
> > +preference
> > + * @epp_cached: Cached CPPC energy-performance preference value
> > + * @policy: Cpufreq policy value
> > + * @sched_flags: Store scheduler flags for possible cross CPU update
> > + * @update_util_set: CPUFreq utility callback is set
> > + * @last_update: Time stamp of the last performance state update
> > + * @cppc_boost_min: Last CPPC boosted min performance state
> > + * @cppc_cap1_cached: Cached value of the last CPPC Capabilities MSR
> > + * @update_util: Cpufreq utility callback information
> > + * @sample: the stored performance sample
> >   *
> >   * The amd_cpudata is key private data for each CPU thread in AMD P-
> State, and
> >   * represents all the attributes and goals that AMD P-State requests a=
t
> runtime.
> > @@ -72,6 +85,28 @@ struct amd_cpudata {
> >
> >  	u64	freq;
> >  	bool	boost_supported;
> > +
> > +	/* EPP feature related attributes*/
> > +	s16	epp_powersave;
> > +	s16	epp_policy;
> > +	s16	epp_cached;
> > +	u32	policy;
> > +	u32	sched_flags;
> > +	bool	update_util_set;
> > +	u64	last_update;
> > +	u64	last_io_update;
> > +	u32	cppc_boost_min;
> > +	u64	cppc_cap1_cached;
> > +	struct	update_util_data update_util;
> > +	struct	amd_aperf_mperf sample;
> > +};
> > +
> > +/**
> > + * struct amd_pstate_params - global parameters for the performance
> > +control
> > + * @ cppc_boost_disabled wheher the core performance boost disabled
> > +*/ struct amd_pstate_params {
> > +	bool cppc_boost_disabled;
> >  };
>=20
> This should not be defined in include/linux/amd-pstate.h, because it's on=
ly
> used in amd-pstate.c.

Moved into amd-pstate.c, Fixed in V8.=20

>=20
> Thanks,
> Ray
