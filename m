Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34C7A64983C
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 04:29:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230386AbiLLD3y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Dec 2022 22:29:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbiLLD3w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Dec 2022 22:29:52 -0500
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2062.outbound.protection.outlook.com [40.107.102.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA166CE0D;
        Sun, 11 Dec 2022 19:29:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gjOLTV1w0SE8fn0ZlXZaAK7n2urm4PQnNtnCOx3zyO3xYYdgT6jE+9pT/9ofl/vyvIrjd8WZA7qmDnnJ9F83W9FjSSGPYIOw7s0pG4ZdnIA5cQG3iKbSRE4B4zREoDUdprh99GNoyjDg4RAQnswuuYjKIPCag3NXYKmgz63VG8qY3XXS/iOj8N93CPXAaYwibHDYm84UKY9LPNlxM/drP7Sqz/XyVWRn+CRZEHsIS8dr9n2bCLNrvMosReYmvZAzhpJwZ3SfdxkbL0BL65ERJhRXQDot8HTxu3rB3COdDde3rflADiR3ZElTblDkRdQ3bWMprLMRPHmHtcNrUY0Mdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3pf51QYKAn3rT6ZkBhFyNvyVzwwEgTy5sUgs25LQQ5I=;
 b=Lceh8GxFfdaYbO3CWDfgz0pfH3U/CFLKvbmR5w4x7hvq2FDoim5BywOdNZvBtg6YXkodaBWaEDecQL0AIpMGQI3Pbxx/tz4gv05mCrQQfEnHZqDYR9Xam1i5i+X4LVemraVELIOMagTUi6i68UD+IKV27YtFyy6HE1APuwXPLDfWyMS9XbvkRfoAwB+6YoV04ZoE3f3bH1ZcBsEPO3lb0MBd/MqiMFX18xqKAejuyUuhNQK+Q6WpGqRIThA37K50JHd3xgB7dBRqAZ8lL7f+V+xryv3F3dDo/ZfDv2LTIKKJqAt/6Q6Yo/LJy5Z/W+Fu/JEoWl3IZv4yx3nOBmHTww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3pf51QYKAn3rT6ZkBhFyNvyVzwwEgTy5sUgs25LQQ5I=;
 b=dnXC1vg5rpiLuIQ4bWl0VNMzle6HfdCr8GFFsnWBTo696qtwtBZkblzZyeR+PlakHrrDRwbjsviZWJDCxr6SfbfiIWq8hFgY/dGSfyAc+rGaWKWkBzMn7keEfetpHl8yveVQUkmQH+b13audkIra5LsYeqa658B9BAm3MRZ4v44=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2504.namprd12.prod.outlook.com (2603:10b6:4:b5::19) by
 CH0PR12MB5122.namprd12.prod.outlook.com (2603:10b6:610:bd::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5880.19; Mon, 12 Dec 2022 03:29:49 +0000
Received: from DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::2443:424:1c7c:17cc]) by DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::2443:424:1c7c:17cc%6]) with mapi id 15.20.5857.023; Mon, 12 Dec 2022
 03:29:49 +0000
Date:   Mon, 12 Dec 2022 11:29:28 +0800
From:   Huang Rui <ray.huang@amd.com>
To:     "Yuan, Perry" <Perry.Yuan@amd.com>
Cc:     "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>,
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
Subject: Re: [PATCH v7 01/13] ACPI: CPPC: Add AMD pstate energy performance
 preference cppc control
Message-ID: <Y5agGGNf1r3Dn9bc@amd.com>
References: <20221208111852.386731-1-perry.yuan@amd.com>
 <20221208111852.386731-2-perry.yuan@amd.com>
 <Y5Lp1n3ZuSsWjeEx@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y5Lp1n3ZuSsWjeEx@amd.com>
X-ClientProxiedBy: TYCP286CA0224.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c5::8) To DM5PR12MB2504.namprd12.prod.outlook.com
 (2603:10b6:4:b5::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR12MB2504:EE_|CH0PR12MB5122:EE_
X-MS-Office365-Filtering-Correlation-Id: b1eaf12a-c1d7-4428-a1a2-08dadbf11f7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rYP62w+DokM9+eIDGii6p72axceGy415av6LX5MZArnTCoVWKm2QIVlQkr2495H+dqcOKZmrxu0tG4QjfqhtpZ2qBIy1VNA91QgH/QE0DL5nQlj/zpEbB7ZXavHnB9PEkIoQl4ZHYbKNPFqKbmfiu35v390u79nrfmraRb98cGoqJFeEI9PLUB+Jo8qawexriYPFpokC0Pe09gqTHNVsQotOHKg6zNpLGwmONXz5PKZNdReDRwFwcVR0dITfQK+47uSkIXitSyfB4NGPjYUsgIfOKjerAd20FEldVOL7BFQEc2HSXEeLwMg5Qzamwqv2VS3uNidq9Wwjy7rmWtOyeIdO1DL9ourGkiBsGMHQW6i3l9POoVaTVbE3JIPVysIdy54Mhe0lX9yI+2g/4oS13liy/v7qKYzgZPZM/Jbtm9aTLyVAW+CK5Tji9TVoSt5iaqte+MNkh/NpmcopqBho3DDihxSe3a4B+i1IanqC14Yzsbta0+CnxV7+nt6cr8doadFzlnatkDC10WmPADWUfQE/x/zp6FulhwQtvHWHISnH5Wr537W7tQ3H/OWIbi5B7fohWsZarMzXOvjGpS+E9bEQ2OIgyYVDA3s4T4VJJpUuBQXQpTuvoacTVtiFUq2G034tGwNok1bj/1jctMF0YQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB2504.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(366004)(396003)(376002)(346002)(451199015)(316002)(37006003)(54906003)(6636002)(6666004)(2906002)(26005)(86362001)(8676002)(66476007)(4326008)(36756003)(66556008)(6862004)(2616005)(6512007)(8936002)(83380400001)(38100700002)(478600001)(186003)(6486002)(66946007)(5660300002)(41300700001)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mqnpMOrmHGBmdAsAfOWcTEqaIlyU1ecLfnIaJffL6g9xWnqqVcSZ23KZ8TYo?=
 =?us-ascii?Q?o/4ecKkLLKGITDO/9qEW13oK3oY1f/HY/vxmHNc4C9ah1yBDBSMyQU15BKPq?=
 =?us-ascii?Q?5zAu9t0d6IyQsmmhKhfnBoRu7yIsGwY1bHEYBDg8+G8Fpg/nCFu5Fmr5QtVR?=
 =?us-ascii?Q?TMbu91hHAUdOacEP+QI3golHpYLxecUdlWOSomZx0vreFjpAjGpPxFewehAT?=
 =?us-ascii?Q?Xrj2h1DeVXOu9UxqNZ78cvPjh6XUdd5fD6l6mU7WHUVrzkn+XODlY7G94mlH?=
 =?us-ascii?Q?vEz4IkrqLJE/Dz72eDe96+nrNtJ2da+bsSnUF3aa8GR3yXp/ZRBGhiqRoYOp?=
 =?us-ascii?Q?mbEwuGeOUu5BMJKGz1aV8YN9uzZEcJTctX9Wb0U/09840mbE+iDHQad6qPeW?=
 =?us-ascii?Q?CNQvK23rBQDOsKhFe1roWfdCerw8QNgjrstQ+AymOgABBaQjRpS8wXa6V7U4?=
 =?us-ascii?Q?zmg5RZP0OqEymT/4L9eWiSJaqHhxW/HhxqMi+V40ktpVxgyDbQrERmXWn9OZ?=
 =?us-ascii?Q?3uqRCXGwDVSVPozCABior5osBHdmi3aEM634bcHThRhnmTXQdDOe+SQL5H14?=
 =?us-ascii?Q?GprC1R5ji3SSF86tDQHNevxc42N4sVBVKp76TkoLlX0YGFz3u+U3iOhxNnuW?=
 =?us-ascii?Q?tsKtGEeVS5lXIkPi6ZPV1xmlh79skRgFOoIEKX6W8EdzJyy090pd3lLFip3b?=
 =?us-ascii?Q?LMwBkDmB3Y0WPFcclhWMkezomEVOANuHaHvIzi2iAMR2Yv8DgQbbAct8ZtsY?=
 =?us-ascii?Q?m2TK8qT95NE179PJKPjXSJwrZNdUtzMPNSLVghnvUWW4sehMTSq7GKP6WIET?=
 =?us-ascii?Q?OJXiQD3wIgR7NGvvP6f5xAGjQlsEhXW4LMK4RcfKn9T0YOBtwpFC+6IrWryI?=
 =?us-ascii?Q?RojOot5Noip4DYePhYwf65dKbXSNGieZ4vg0Ro2DvC1oRVE4+qxdwXzdWtV4?=
 =?us-ascii?Q?Gqac3BEDAqOR1amUH/0koeX67llAdbJn6sLRQJf/VpiKYelRCtKTpmY8+8Ps?=
 =?us-ascii?Q?O0ILqotrlRP8L1qk3KwJhW+D5VrVrFlURrMHFkMul8xYRFz1TRL4XcxQuB7s?=
 =?us-ascii?Q?U7f6ypLXpCa6pD7NUIfl5VI5hihXbnP3cTmwmRn4jALVCVITqJDatR5UN0tz?=
 =?us-ascii?Q?oCH+HhjDfrKd1ut/qHR5nvQwF7IjOYyZhGll1Sjb7L3Nc5Y0rrPOYNNE8HRw?=
 =?us-ascii?Q?0XQ399NprJPGoq7mguOz7qoQ9VaW2954PNkCAx44zNZzD4laB1KOsWIIJbj3?=
 =?us-ascii?Q?klXYfQQzfJrj20I54tFHaBZc5PHyhIGvhWYG0CYzEDYDl+5nTfuP0UmLqc1K?=
 =?us-ascii?Q?iMIVlV2fBGaDkzDJftNR+vRTSGH9g6SfZ12B/MSp2Gyyvmudns75zF3W+6HS?=
 =?us-ascii?Q?99yT+QQp5msrhBoyzj1FU9ckR58FB3aupSl7d6UuB6ZOe3WxwD4Ukd5VvrHv?=
 =?us-ascii?Q?ki44sD92t4DrUlzEHy2TvIa15Q6MsTGPGmS04jfZNt4FG5uneJcsJHs8x3vy?=
 =?us-ascii?Q?ZDq6bSgsAH4aZNpiqNOIHIpOxBsU0K7iaSo4mawn7sbxe78xFGTVQAd5psW4?=
 =?us-ascii?Q?hFaF24WosLDzRM4WmmkF5etU1/ZIv5DpnPZNpP+j?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1eaf12a-c1d7-4428-a1a2-08dadbf11f7a
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2504.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2022 03:29:49.0109
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FSrL6oMbTdFb7nh73QW/4EllLBVuQVfc1AecmDNQoo43GPRlxlkga0j24Msgb+Cou48d4zMTnDFa7vKGQQrxmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5122
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 09, 2022 at 03:55:28PM +0800, Huang Rui wrote:
> On Thu, Dec 08, 2022 at 07:18:40PM +0800, Yuan, Perry wrote:
> > From: Perry Yuan <Perry.Yuan@amd.com>
> > 
> > Add support for setting and querying EPP preferences to the generic
> > CPPC driver.  This enables downstream drivers such as amd-pstate to discover
> > and use these values
> > 
> > Downstream drivers that want to use the new symbols cppc_get_epp_caps
> > and cppc_set_epp_perf for querying and setting EPP preferences will need
> > to call cppc_set_auto_epp to enable the EPP function first.
> > 
> > Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
> 
> Acked-by: Huang Rui <ray.huang@amd.com>
> 
> > ---
> >  drivers/acpi/cppc_acpi.c | 114 +++++++++++++++++++++++++++++++++++++--
> >  include/acpi/cppc_acpi.h |  12 +++++
> >  2 files changed, 121 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> > index 093675b1a1ff..37fa75f25f62 100644
> > --- a/drivers/acpi/cppc_acpi.c
> > +++ b/drivers/acpi/cppc_acpi.c
> > @@ -1093,6 +1093,9 @@ static int cppc_get_perf(int cpunum, enum cppc_regs reg_idx, u64 *perf)
> >  {
> >  	struct cpc_desc *cpc_desc = per_cpu(cpc_desc_ptr, cpunum);
> >  	struct cpc_register_resource *reg;
> > +	int pcc_ss_id = per_cpu(cpu_pcc_subspace_idx, cpunum);
> > +	struct cppc_pcc_data *pcc_ss_data = NULL;
> > +	int ret = -EINVAL;
> >  
> >  	if (!cpc_desc) {
> >  		pr_debug("No CPC descriptor for CPU:%d\n", cpunum);
> > @@ -1102,10 +1105,6 @@ static int cppc_get_perf(int cpunum, enum cppc_regs reg_idx, u64 *perf)
> >  	reg = &cpc_desc->cpc_regs[reg_idx];
> >  
> >  	if (CPC_IN_PCC(reg)) {
> > -		int pcc_ss_id = per_cpu(cpu_pcc_subspace_idx, cpunum);
> > -		struct cppc_pcc_data *pcc_ss_data = NULL;
> > -		int ret = 0;
> > -
> >  		if (pcc_ss_id < 0)
> >  			return -EIO;
> >  
> > @@ -1125,7 +1124,7 @@ static int cppc_get_perf(int cpunum, enum cppc_regs reg_idx, u64 *perf)
> >  
> >  	cpc_read(cpunum, reg, perf);
> >  
> > -	return 0;
> > +	return ret;
> >  }
> >  
> >  /**
> > @@ -1365,6 +1364,111 @@ int cppc_get_perf_ctrs(int cpunum, struct cppc_perf_fb_ctrs *perf_fb_ctrs)
> >  }
> >  EXPORT_SYMBOL_GPL(cppc_get_perf_ctrs);
> >  
> > +/**
> > + * cppc_get_epp_caps - Get the energy preference register value.
> > + * @cpunum: CPU from which to get epp preference level.
> > + * @perf_caps: Return address.
> > + *
> > + * Return: 0 for success, -EIO otherwise.
> > + */
> > +int cppc_get_epp_caps(int cpunum, struct cppc_perf_caps *perf_caps)

Take a look at the patch again, due to the energy_perf is actually one of
the members in struct cppc_perf_caps. It's better to modify the existing
cppc_get_perf_caps() to get the epp value as well.

Thanks,
Ray

> > +{
> > +	struct cpc_desc *cpc_desc = per_cpu(cpc_desc_ptr, cpunum);
> > +	struct cpc_register_resource *energy_perf_reg;
> > +	u64 energy_perf;
> > +
> > +	if (!cpc_desc) {
> > +		pr_debug("No CPC descriptor for CPU:%d\n", cpunum);
> > +		return -ENODEV;
> > +	}
> > +
> > +	energy_perf_reg = &cpc_desc->cpc_regs[ENERGY_PERF];
> > +
> > +	if (!CPC_SUPPORTED(energy_perf_reg))
> > +		pr_warn_once("energy perf reg update is unsupported!\n");
> > +
> > +	if (CPC_IN_PCC(energy_perf_reg)) {
> > +		int pcc_ss_id = per_cpu(cpu_pcc_subspace_idx, cpunum);
> > +		struct cppc_pcc_data *pcc_ss_data = NULL;
> > +		int ret = 0;
> > +
> > +		if (pcc_ss_id < 0)
> > +			return -ENODEV;
> > +
> > +		pcc_ss_data = pcc_data[pcc_ss_id];
> > +
> > +		down_write(&pcc_ss_data->pcc_lock);
> > +
> > +		if (send_pcc_cmd(pcc_ss_id, CMD_READ) >= 0) {
> > +			cpc_read(cpunum, energy_perf_reg, &energy_perf);
> > +			perf_caps->energy_perf = energy_perf;
> > +		} else {
> > +			ret = -EIO;
> > +		}
> > +
> > +		up_write(&pcc_ss_data->pcc_lock);
> > +
> > +		return ret;
> > +	}
> > +
> > +	return 0;
> > +}
> > +EXPORT_SYMBOL_GPL(cppc_get_epp_caps);
> > +
> > +/*
> > + * Set Energy Performance Preference Register value through
> > + * Performance Controls Interface
> > + */
> > +int cppc_set_epp_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls, bool enable)
> > +{
> > +	int pcc_ss_id = per_cpu(cpu_pcc_subspace_idx, cpu);
> > +	struct cpc_register_resource *epp_set_reg;
> > +	struct cpc_register_resource *auto_sel_reg;
> > +	struct cpc_desc *cpc_desc = per_cpu(cpc_desc_ptr, cpu);
> > +	struct cppc_pcc_data *pcc_ss_data = NULL;
> > +	int ret = -EINVAL;
> > +
> > +	if (!cpc_desc) {
> > +		pr_debug("No CPC descriptor for CPU:%d\n", cpu);
> > +		return -ENODEV;
> > +	}
> > +
> > +	auto_sel_reg = &cpc_desc->cpc_regs[AUTO_SEL_ENABLE];
> > +	epp_set_reg = &cpc_desc->cpc_regs[ENERGY_PERF];
> > +
> > +	if (CPC_IN_PCC(epp_set_reg) || CPC_IN_PCC(auto_sel_reg)) {
> > +		if (pcc_ss_id < 0) {
> > +			pr_debug("Invalid pcc_ss_id\n");
> > +			return -ENODEV;
> > +		}
> > +
> > +		if (CPC_SUPPORTED(auto_sel_reg)) {
> > +			ret = cpc_write(cpu, auto_sel_reg, enable);
> > +			if (ret)
> > +				return ret;
> > +		}
> > +
> > +		if (CPC_SUPPORTED(epp_set_reg)) {
> > +			ret = cpc_write(cpu, epp_set_reg, perf_ctrls->energy_perf);
> > +			if (ret)
> > +				return ret;
> > +		}
> > +
> > +		pcc_ss_data = pcc_data[pcc_ss_id];
> > +
> > +		down_write(&pcc_ss_data->pcc_lock);
> > +		/* after writing CPC, transfer the ownership of PCC to platform */
> > +		ret = send_pcc_cmd(pcc_ss_id, CMD_WRITE);
> > +		up_write(&pcc_ss_data->pcc_lock);
> > +	} else {
> > +		ret = -ENOTSUPP;
> > +		pr_debug("_CPC in PCC is not supported\n");
> > +	}
> > +
> > +	return ret;
> > +}
> > +EXPORT_SYMBOL_GPL(cppc_set_epp_perf);
> > +
> >  /**
> >   * cppc_set_enable - Set to enable CPPC on the processor by writing the
> >   * Continuous Performance Control package EnableRegister field.
> > diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
> > index c5614444031f..a45bb876a19c 100644
> > --- a/include/acpi/cppc_acpi.h
> > +++ b/include/acpi/cppc_acpi.h
> > @@ -108,12 +108,14 @@ struct cppc_perf_caps {
> >  	u32 lowest_nonlinear_perf;
> >  	u32 lowest_freq;
> >  	u32 nominal_freq;
> > +	u32 energy_perf;
> >  };
> >  
> >  struct cppc_perf_ctrls {
> >  	u32 max_perf;
> >  	u32 min_perf;
> >  	u32 desired_perf;
> > +	u32 energy_perf;
> >  };
> >  
> >  struct cppc_perf_fb_ctrs {
> > @@ -149,6 +151,8 @@ extern bool cpc_ffh_supported(void);
> >  extern bool cpc_supported_by_cpu(void);
> >  extern int cpc_read_ffh(int cpunum, struct cpc_reg *reg, u64 *val);
> >  extern int cpc_write_ffh(int cpunum, struct cpc_reg *reg, u64 val);
> > +extern int cppc_get_epp_caps(int cpunum, struct cppc_perf_caps *perf_caps);
> > +extern int cppc_set_epp_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls, bool enable);
> >  #else /* !CONFIG_ACPI_CPPC_LIB */
> >  static inline int cppc_get_desired_perf(int cpunum, u64 *desired_perf)
> >  {
> > @@ -202,6 +206,14 @@ static inline int cpc_write_ffh(int cpunum, struct cpc_reg *reg, u64 val)
> >  {
> >  	return -ENOTSUPP;
> >  }
> > +static inline int cppc_set_epp_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls, bool enable)
> > +{
> > +	return -ENOTSUPP;
> > +}
> > +static inline int cppc_get_epp_caps(int cpunum, struct cppc_perf_caps *perf_caps)
> > +{
> > +	return -ENOTSUPP;
> > +}
> >  #endif /* !CONFIG_ACPI_CPPC_LIB */
> >  
> >  #endif /* _CPPC_ACPI_H*/
> > -- 
> > 2.34.1
> > 
