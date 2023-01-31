Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE300683448
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 18:49:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231302AbjAaRtO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 12:49:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbjAaRtL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 12:49:11 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2054.outbound.protection.outlook.com [40.107.237.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 892371739;
        Tue, 31 Jan 2023 09:49:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TWOjZYatK3IR5nXzPfY3Q10PLfz336pIqFyWUqDm/D4CE7pFHcvGUGk+NdFS58QR9SmPHe8r2WW3LzvPTX5yKQq+vaB8VUq1hsh08EkRLKfNVeFtf5xw9dmxaEuBwrC25sT3iIscYxMGowZz6xYLCngXBTFbL+ypJiMadaziycYSS+Tw99bU3p/mNjGB86V+SsZjLcm6fUhZczzAVJpx0tINeU83QbxP4op1wqvJb8kh+tIoZ4zw9PvhgVrtnMUK6QWww+33fGQiWre6QhUEPItyGX7JLzCktQTOEcZN8RO+uXY7sCxhTF3qo1f91OlXtzeOo+TxnGYFLsC1GmK5dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BTmFGEm6ORW6jn4JL1u/8/sBN/6OVq0b+gT+ghFfJuA=;
 b=JxKGZDtBn6HII++pO7Zav5qBLxSvZwC/N0GCLRvrSK3D83XbITj8EyeDB0/AP0Uy4fv/b4G4cL42zFtc++9mIP42HwmWy4Wjyw/GlFPhVEAIt322sBRNFyVdqnOcbSjc9Gq8KuLuq15vdUDvhSoA20xRQ3lWLEBBqiZAhKkXbo4te7ZRyOpKPYG7upYjMDlSD9LE4neOApCpvl5NNJ+GwKUGFa8YZO4BRwExrK70l8Y4JqSs6eICp+WO2/aFSB9JNc3nKQBFtRrluLeLW2d9uwQFhbZHAcZ3esjs9jezfcP/yKX4lTXm0Z4gtSOJLvMfnGoKDBB0M27ELx5gSYzLTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BTmFGEm6ORW6jn4JL1u/8/sBN/6OVq0b+gT+ghFfJuA=;
 b=DfC4Nn1KXn1fC79yG4CrI7ekD3/BCjZp0wfQb2xBLMIrf81QDrBVsNgi3Jf8GCWf3y0kQDE2l7jZAzNtvsWP1KcFQR6n6NqS0jDz2XRGxSRTituHqbadzRnslEr4XbjMXIsquDpdpTfZ4CbgZfkZO203qjXCZcfyHLGBJn5T/Jg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BY5PR12MB3876.namprd12.prod.outlook.com (2603:10b6:a03:1a7::26)
 by CH2PR12MB4325.namprd12.prod.outlook.com (2603:10b6:610:a9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.36; Tue, 31 Jan
 2023 17:49:06 +0000
Received: from BY5PR12MB3876.namprd12.prod.outlook.com
 ([fe80::4ac9:c4f8:b0f:a863]) by BY5PR12MB3876.namprd12.prod.outlook.com
 ([fe80::4ac9:c4f8:b0f:a863%7]) with mapi id 15.20.6043.033; Tue, 31 Jan 2023
 17:49:06 +0000
Date:   Tue, 31 Jan 2023 17:48:51 +0000
From:   Wyes Karny <wyes.karny@amd.com>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     Rafael J Wysocki <rafael@kernel.org>,
        Huang Rui <ray.huang@amd.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Viresh Kumar <viresh.kumar@linaro.org>, Perry.Yuan@amd.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Bagas Sanjaya <bagasdotme@gmail.com>,
        santosh.shukla@amd.com, Len Brown <lenb@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Ananth Narayan <ananth.narayan@amd.com>,
        gautham.shenoy@amd.com, Tor Vic <torvic9@mailbox.org>
Subject: Re: [PATCH v4 5/6] cpufreq: amd_pstate: Add guided mode control
 support via sysfs
Message-ID: <Y9lUgxevhdlv840K@beas>
References: <20230131052141.96475-1-wyes.karny@amd.com>
 <20230131052141.96475-6-wyes.karny@amd.com>
 <661a55c4-5703-ef84-728a-229997737416@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <661a55c4-5703-ef84-728a-229997737416@amd.com>
X-ClientProxiedBy: PN3PR01CA0175.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:de::20) To BY5PR12MB3876.namprd12.prod.outlook.com
 (2603:10b6:a03:1a7::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB3876:EE_|CH2PR12MB4325:EE_
X-MS-Office365-Filtering-Correlation-Id: ec70a19d-8270-4911-2e86-08db03b3721d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GjYnSH7BLVZZeQYiL31zmIo7fE6YYvCTr0ecRvHor8oXAaapEqdsIy/NIxmoOLmgSirpDumxq+1hr+fHKzWuQlPUgdYjacb40YZoBGwoBrqJTR/jKG5TVMCJCs1N0xi0TgMLEu3N+JZzmIrc2jRNTQqm26wZvF/qOrkA442DOyJeSlIXEhlaqZXwRtFpVjNzTsWL8fU7BCxYV7mxefx5QVMSbZAtwyRht8D1Jl3U/53rJPl6NZvMASPYbUNjP783/7xpu843tJNPaCP6u8mVSjOltCyIFNQoHv/hjXO7f/fcfsMCO+ITOGt8NMOMkWxgNlpDkECkSTSuqmBo7xlyusuLT7hqzn3fcxNLQCmBaC/r25MgVydUbo2FxYfCCDJsAgS6LQwvyQkm78myjfsi2VXdNMs0JdiQ0zIltm50Yr1tBsAZNFUM988dNqYZYV9FfXeiLDisoQwPUJLE0iKej2LGd3+FCgE8o9AANihd1q07qNzhuyl/+NA69TfoUoimgQN7Nwzc6PSjO34Rlyc0uO1k/kMBoAKBJgzgaq60r1qq0Oq/D+sE2VLhoa+hOK8KcoIYEHUi1nEOOjhzl39uQDAWNItGWkwCO8+Xag4xleglZAiDkgI1kMwjHv8Ac41NqErMfJNnqEewlTKBZPChvA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB3876.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(7916004)(366004)(346002)(396003)(376002)(39860400002)(136003)(451199018)(6666004)(4326008)(66946007)(8676002)(66556008)(8936002)(44832011)(83380400001)(6862004)(7416002)(53546011)(41300700001)(6506007)(5660300002)(316002)(54906003)(6636002)(478600001)(9686003)(186003)(6512007)(26005)(38100700002)(86362001)(66476007)(33716001)(6486002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PSYiIKNj76+RBs9y2gL2IqliBKugQ079BkCr0DVPRqpog1g41G3ogBj5iobQ?=
 =?us-ascii?Q?IcvZ0zlMm22m3DCZGRJu0tZH9jD75WosZGRfZTkmMsxnv+zzyErZ4KlP3VCC?=
 =?us-ascii?Q?FBMtX4Z3ahof8TpgHKmvlSywe4k6+/7D57RJbkz6yEmBx3agDhSevnvwoo1z?=
 =?us-ascii?Q?Ll1oYZbaV6njv+6vWRkeru+g9idSRiziIwn/bJmNobStQ6PgFgzN8CWP4SIP?=
 =?us-ascii?Q?mItf9yJJoeKBAdw/gTE8zV2eZaMQT89OUW9S4fu4F2EBc+l7uo5NEW3PJIav?=
 =?us-ascii?Q?QJKzXLmkHyvpS+qT7iUvY4VpeFtafU22neQSeQvEFzzslku3x7V/3SbCsY7C?=
 =?us-ascii?Q?lWML97fzdXSM112PP5mvwABq4d594PuOrn8uZV/y1X9uTFaS5KrzIYG2VGNp?=
 =?us-ascii?Q?lDjFRZ8SdyQuZHICOXuZjtFStKMbLS2pWIlefcJCqpevmjakD4weQv/X9zCI?=
 =?us-ascii?Q?GolAcWLNBr1p5iuT5RFokSAZSOPeINU5qKsiNh/B1ULr0Me3HupfiIr/xje8?=
 =?us-ascii?Q?dwbk7+qOXEzgl8VNfifw9+VD1mnk0Lxqs+mCxiIqLJw7BTIbzxrzJhk0LH3+?=
 =?us-ascii?Q?/nHCpjfJHIDZekkvi7tt8KVEUCBZqg9nvu4jzriS17XywVUsFj7U0TJLRQ59?=
 =?us-ascii?Q?M/GMFmhDnuSrPDOflxlX4trvSjm/rXrxiiCjObTsPjuGOLoKZZ1KuIpZfg9u?=
 =?us-ascii?Q?lu17o8zImcpS2JcFjBKvZkmlZnTtDP0X4SNm4Xq3bx4jNmzQGlTfpq7mtLkj?=
 =?us-ascii?Q?z4nahmO6zSU8/JWkugkQYls19HjeBgHuPPRPVTHn3ReR9zTryrxYD/ZrIjUG?=
 =?us-ascii?Q?Cx5dSk/AYV2jyJFjWhY6qrHq4kGbkPZdznwSygnCbcpDFlPdLk8Jq11lTxtU?=
 =?us-ascii?Q?4grgUhuYQZl2lWYd7S2c/L+609XyBASnN60F5WuGBPZVj9gOdMSHHEF4hXRy?=
 =?us-ascii?Q?q7ZG/VAR2v6/DDhhaiO4Jy6uBRaw9n6zXMUdc6sBfNbYZbuUmlzQyYYA+tyy?=
 =?us-ascii?Q?ALshgpUOs6YOZnsoeqJskmQHjCPv/hyTcEPSucitelmDFPmh294apT/01XDv?=
 =?us-ascii?Q?cwUTWiIiahfsSX8PS0a5FW+qLXeReHBLLsHy+OkH4r+8NoxRtPkZ2d5fQg5D?=
 =?us-ascii?Q?mJRoXMMq5UtPzCRd3CkJZyJqqM2QkX8i7NMoYjReiA2MwGOMkCGuuH+BM7ri?=
 =?us-ascii?Q?yfbKu0xOIm/z5Wi7Es9h7Z6b7UCoXMECtRW/yElvfobnMRKMnQtoBXk21rJL?=
 =?us-ascii?Q?XPYyIuWYzfmCNig+4h7coNGrCgGbGKjIXZcGKbvJKIQe/zwgKDraG5747h9d?=
 =?us-ascii?Q?Ngf7XphSumiOO5JIaO2cUp/tYdutm9/H674NoIq28oJWQQiK071cOh3vi2jb?=
 =?us-ascii?Q?rNB6b8oKWjOUZKcTEBBkTMgnE4vk/Sa+CyKcyWcVQVPzJKyxOMhHHIGRKZsj?=
 =?us-ascii?Q?oSX+3ienFrEV7Fn642Fd3jIVrt5vHvJtcQ+3bzBWNBPUbyK85XJtp0RknEw1?=
 =?us-ascii?Q?taj79bPrUXPKGARWv04QXaETnQPdsL1WtTlWPZc4sgEv0loBN3VPaoBINCX0?=
 =?us-ascii?Q?RzDD5VrQgBJOOAtf9jYPRXLjkwyU1C0ZIeiPfu06?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec70a19d-8270-4911-2e86-08db03b3721d
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3876.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2023 17:49:05.7226
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zVCxHBky/L4O9yXP9XXl/qZzbEGDGT8m1pccXHiraNOqpow6TVC802g4hd8yOeQsD5WnNvLJKR3WTnFehWXtqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4325
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31 Jan 07:45, Mario Limonciello wrote:
> On 1/30/23 23:21, Wyes Karny wrote:
> > amd_pstate driver's `status` sysfs entry helps to control the driver's
> > mode dynamically by user. After the addition of guided mode the
> > combinations of mode transitions have been increased (16 combinations).
> > Therefore optimise the amd_pstate_update_status function by implementing
> > a state transition table.
> > 
> > There are 4 states amd_pstate supports, namely: 'disable', 'passive',
> > 'active', and 'guided'.  The transition from any state to any other
> > state is possible after this change. Only if the state requested matches
> > with the current state then -EBUSY value is returned.
> 
> I realized this after I finished reviewing doc patch, but you probably want
> to explain -EBUSY return code in documentation patch too.

Yes, I'll add this to documentation. Thanks!

> 
> > 
> > Sysfs interface:
> > 
> > To disable amd_pstate driver:
> >   # echo disable > /sys/devices/system/cpu/amd_pstate/status
> > 
> > To enable passive mode:
> >   # echo passive > /sys/devices/system/cpu/amd_pstate/status
> > 
> > To change mode to active:
> >   # echo active > /sys/devices/system/cpu/amd_pstate/status
> > 
> > To change mode to guided:
> >   # echo guided > /sys/devices/system/cpu/amd_pstate/status
> > 
> > Signed-off-by: Wyes Karny <wyes.karny@amd.com>
> > ---
> >   drivers/cpufreq/amd-pstate.c | 150 +++++++++++++++++++++++++----------
> >   1 file changed, 108 insertions(+), 42 deletions(-)
> > 
> > diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> > index 48ab4684c3a5..6c522dec6967 100644
> > --- a/drivers/cpufreq/amd-pstate.c
> > +++ b/drivers/cpufreq/amd-pstate.c
> > @@ -65,6 +65,8 @@ static struct cpufreq_driver amd_pstate_epp_driver;
> >   static int cppc_state = AMD_PSTATE_DISABLE;
> >   struct kobject *amd_pstate_kobj;
> > +typedef int (*cppc_mode_transition_fn)(int);
> > +
> >   static inline int get_mode_idx_from_str(const char *str, size_t size)
> >   {
> >   	int i;
> > @@ -797,6 +799,105 @@ static ssize_t show_energy_performance_preference(
> >   	return sysfs_emit(buf, "%s\n", energy_perf_strings[preference]);
> >   }
> > +static void amd_pstate_driver_cleanup(void)
> > +{
> > +	amd_pstate_enable(false);
> > +	cppc_state = AMD_PSTATE_DISABLE;
> > +	current_pstate_driver = NULL;
> > +}
> > +
> > +static int amd_pstate_register_driver(int mode)
> > +{
> > +	int ret;
> > +
> > +	if (mode == AMD_PSTATE_PASSIVE || mode == AMD_PSTATE_GUIDED)
> > +		current_pstate_driver = &amd_pstate_driver;
> > +	else if (mode == AMD_PSTATE_ACTIVE)
> > +		current_pstate_driver = &amd_pstate_epp_driver;
> > +	else
> > +		return -EINVAL;
> > +
> > +	cppc_state = mode;
> > +	ret = cpufreq_register_driver(current_pstate_driver);
> > +	if (ret) {
> > +		amd_pstate_driver_cleanup();
> > +		return ret;
> > +	}
> > +	return 0;
> > +}
> > +
> > +static int amd_pstate_unregister_driver(int dummy)
> > +{
> > +	int ret;
> > +
> > +	ret = cpufreq_unregister_driver(current_pstate_driver);
> > +
> > +	if (ret)
> > +		return ret;
> > +
> > +	amd_pstate_driver_cleanup();
> > +	return 0;
> > +}
> > +
> > +static int amd_pstate_change_mode_without_dvr_change(int mode)
> > +{
> > +	int cpu = 0;
> > +
> > +	cppc_state = mode;
> > +
> > +	if (boot_cpu_has(X86_FEATURE_CPPC) || cppc_state == AMD_PSTATE_ACTIVE)
> > +		return 0;
> > +
> > +	for_each_present_cpu(cpu) {
> > +		cppc_set_auto_sel(cpu, (cppc_state == AMD_PSTATE_PASSIVE) ? 0 : 1);
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int amd_pstate_change_driver_mode(int mode)
> > +{
> > +	int ret;
> > +
> > +	ret = amd_pstate_unregister_driver(0);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = amd_pstate_register_driver(mode);
> > +	if (ret)
> > +		return ret;
> > +
> > +	return 0;
> > +}
> > +
> > +/* Mode transition table */
> 
> This seems to be a pointless comment to me.
> 
> > +cppc_mode_transition_fn mode_state_machine[AMD_PSTATE_MAX][AMD_PSTATE_MAX] = {
> > +	[AMD_PSTATE_DISABLE]         = {
> > +		[AMD_PSTATE_DISABLE]     = NULL,
> > +		[AMD_PSTATE_PASSIVE]     = amd_pstate_register_driver,
> > +		[AMD_PSTATE_ACTIVE]      = amd_pstate_register_driver,
> > +		[AMD_PSTATE_GUIDED]      = amd_pstate_register_driver,
> > +	},
> > +	[AMD_PSTATE_PASSIVE]         = {
> > +		[AMD_PSTATE_DISABLE]     = amd_pstate_unregister_driver,
> > +		[AMD_PSTATE_PASSIVE]     = NULL,
> > +		[AMD_PSTATE_ACTIVE]      = amd_pstate_change_driver_mode,
> > +		[AMD_PSTATE_GUIDED]      = amd_pstate_change_mode_without_dvr_change,
> > +	},
> > +	[AMD_PSTATE_ACTIVE]          = {
> > +		[AMD_PSTATE_DISABLE]     = amd_pstate_unregister_driver,
> > +		[AMD_PSTATE_PASSIVE]     = amd_pstate_change_driver_mode,
> > +		[AMD_PSTATE_ACTIVE]      = NULL,
> > +		[AMD_PSTATE_GUIDED]      = amd_pstate_change_driver_mode,
> > +	},
> > +	[AMD_PSTATE_GUIDED]          = {
> > +		[AMD_PSTATE_DISABLE]     = amd_pstate_unregister_driver,
> > +		[AMD_PSTATE_PASSIVE]     = amd_pstate_change_mode_without_dvr_change,
> > +		[AMD_PSTATE_ACTIVE]      = amd_pstate_change_driver_mode,
> > +		[AMD_PSTATE_GUIDED]      = NULL,
> > +	},
> > +};
> > +
> >   static ssize_t amd_pstate_show_status(char *buf)
> >   {
> >   	if (!current_pstate_driver)
> > @@ -805,57 +906,22 @@ static ssize_t amd_pstate_show_status(char *buf)
> >   	return sysfs_emit(buf, "%s\n", amd_pstate_mode_string[cppc_state]);
> >   }
> > -static void amd_pstate_driver_cleanup(void)
> > -{
> > -	current_pstate_driver = NULL;
> > -}
> > -
> >   static int amd_pstate_update_status(const char *buf, size_t size)
> >   {
> > -	int ret;
> >   	int mode_idx;
> > -	if (size > 7 || size < 6)
> > +	if (size > strlen("passive") || size < strlen("active"))
> >   		return -EINVAL;
> > -	mode_idx = get_mode_idx_from_str(buf, size);
> > -	switch(mode_idx) {
> > -	case AMD_PSTATE_DISABLE:
> > -		if (!current_pstate_driver)
> > -			return -EINVAL;
> > -		if (cppc_state == AMD_PSTATE_ACTIVE)
> > -			return -EBUSY;
> > -		ret = cpufreq_unregister_driver(current_pstate_driver);
> > -		amd_pstate_driver_cleanup();
> > -		break;
> > -	case AMD_PSTATE_PASSIVE:
> > -		if (current_pstate_driver) {
> > -			if (current_pstate_driver == &amd_pstate_driver)
> > -				return 0;
> > -			cpufreq_unregister_driver(current_pstate_driver);
> > -			cppc_state = AMD_PSTATE_PASSIVE;
> > -			current_pstate_driver = &amd_pstate_driver;
> > -		}
> > +	mode_idx = get_mode_idx_from_str(buf, size);
> > -		ret = cpufreq_register_driver(current_pstate_driver);
> > -		break;
> > -	case AMD_PSTATE_ACTIVE:
> > -		if (current_pstate_driver) {
> > -			if (current_pstate_driver == &amd_pstate_epp_driver)
> > -				return 0;
> > -			cpufreq_unregister_driver(current_pstate_driver);
> > -			current_pstate_driver = &amd_pstate_epp_driver;
> > -			cppc_state = AMD_PSTATE_ACTIVE;
> > -		}
> > +	if (mode_idx < 0 || mode_idx >= AMD_PSTATE_MAX)
> > +		return -EINVAL;
> > -		ret = cpufreq_register_driver(current_pstate_driver);
> > -		break;
> > -	default:
> > -		ret = -EINVAL;
> > -		break;
> > -	}
> > +	if (mode_state_machine[cppc_state][mode_idx])
> > +		return mode_state_machine[cppc_state][mode_idx](mode_idx);
> > -	return ret;
> > +	return -EBUSY;
> >   }
> >   static ssize_t show_status(struct kobject *kobj,
> 
> With one nit fixed,
> 
> Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
