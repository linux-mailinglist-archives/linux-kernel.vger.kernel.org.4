Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69A28668BC0
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 06:51:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbjAMFuj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 00:50:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236478AbjAMFt3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 00:49:29 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 890F658321;
        Thu, 12 Jan 2023 21:48:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZkKfZR0Ev5l+zdnC8e7pBusnJHH0hyuCeL52/dw+dN70bVSfpdXSVI1Rrcaj0wtCjz+JfS24Y3a34Me2VcO3Ci5RjvfX4Gz5QvrkM81LnIx3t3/bS+gUUw/Fd0IodvHV7AFkxxxi/ENjdmTwKPj3+XNHfUwG9WWyDZCO5XOf/aTRVvm5ECKbP2YB61pPLcvhT0qzRwljUoXo0cqQEhRCIqm4ioNY9jdXwdhw0R36mKSSq28SoKMsB89Rydx5W6touPfZHHVxUUxACeuuMo1ldVf1J/7xUtFynbhrz0rSV1G0xl9JJK5Mzw7+OdPzTylsTbIokbmtBR5qLGi1jLz0xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ax06owXcKAXJV+aOVww14fnwJikHZLBDfiZG0Co7cwM=;
 b=hSgu90NnXIsbGCY5w5auvu9tTVGuvEQWsU4lK0dv0yzyDBmxERGRXnfikpDJ677/poHTXSDTUPt4tGQo4yVRI75zHeWZDjE7xsVd+R1EsQIhuayBsQmNUv1EdwkPsycpyFThPNxRuPwHXVw5GpRxJXlXTy9T78bwIyVfgoJh9BheyVsKR0xU80gD4nPR02LrkSCSkPwCNyJUpBPujexRDJHToPxnZdJWQK7SRp7/beWM9+pBuPA0/dlo46fSgTGVfpWY7aybQynqPJyvwy+dUOVcuwmzCKswfRADFuEyuVDCDcBNrdJtUhIPWZ64NkiuMXEViKfDmCW+ZU1iwhazwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ax06owXcKAXJV+aOVww14fnwJikHZLBDfiZG0Co7cwM=;
 b=JqNn7b59MHFnhws1Tshqnm914J2aqTS+DH1zMfSemNg7BExzW7BX6ZgOch/E4VFVB6r8DiqjDzH64D9afs3E6B+W9ZuWvRHKNid0bJkU9DfcAV3m1vmOu+xpMCN6+eqbxBd4o7QS3IpmAjyTGN8FwspZWPimrShxUKEEh+7ItAQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by MW4PR12MB7285.namprd12.prod.outlook.com (2603:10b6:303:22e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13; Fri, 13 Jan
 2023 05:48:21 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::ff3c:2d37:75f3:442a]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::ff3c:2d37:75f3:442a%7]) with mapi id 15.20.5986.018; Fri, 13 Jan 2023
 05:48:21 +0000
Message-ID: <00f4f977-b381-1b1a-a9a5-e2d342979b83@amd.com>
Date:   Thu, 12 Jan 2023 23:48:18 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v2 5/6] cpufreq: amd_pstate: Add guided mode control
 support via sysfs
Content-Language: en-US
To:     Wyes Karny <wyes.karny@amd.com>,
        Rafael J Wysocki <rafael@kernel.org>,
        Huang Rui <ray.huang@amd.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Viresh Kumar <viresh.kumar@linaro.org>, Perry.Yuan@amd.com,
        Ananth Narayan <ananth.narayan@amd.com>, gautham.shenoy@amd.com
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Bagas Sanjaya <bagasdotme@gmail.com>,
        santosh.shukla@amd.com
References: <20230113052141.2874296-1-wyes.karny@amd.com>
 <20230113052141.2874296-6-wyes.karny@amd.com>
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20230113052141.2874296-6-wyes.karny@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7PR03CA0121.namprd03.prod.outlook.com
 (2603:10b6:5:3b4::6) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|MW4PR12MB7285:EE_
X-MS-Office365-Filtering-Correlation-Id: e4706a3d-1ef6-46fc-2631-08daf529c735
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ApvzGfPAkSmatzLAUMKnK+x5uw2WwDbtvm2Nv0hm7UkqBAEXp5NrMULVRI73M/onj/HDZGtJUQFO5BH00qRA8gCcpWHz0IXoyA7G5MSAIfupfFsNmm6PD0w1QieU6iu9Gi4XJKMiP3P5ujpSQ/VxwMhWuaL9tnbB9cVmB24IF5M34O/j254tq3nvsPjbtN8XPCB7eEpVeUYh77swgQ6rbwBxk3NAiL5XyYC3Ba3dwD0h73+h79DBSmS8/iS+k2hMBr9oAtsloWxID1pZ+19DZsGvf3rmlwqnRnhBHWTB6W+bH+ncnoMNZxYqAMHe5jbc20cWOsaA45xOwiiIM0wR8p2rMGE2a85Cv9f3VxOBmQJDP4x3Ls0kb+KIh8d1MWSooPMMNgaWnCYHFxQ1T6yBNbWFKDPkeZQsvdyWzC4vAxYcKsy6XhlkxdUSANCKLE/0IjGDCVTKuuuGqu/NFO0B/0RyDMYU8Bx+AcjykiBziLtjJ2p3fosPLg6DTOAnoH72//mw7bca3mEhOb9IIwT65Mo/UykwQ9qKtRPz0gklu7X/NkYzISeP56+Q1qIUDSyxXrQK/wdBnAt52lXp2i0vxHtPDYo3KdYbPnRO4EhjHptOX1WruYXbo6mA2v5yGXH32ff7dOs/Bh75tW3f8HXhSiuRH4VwfmxceiGv9PnGB+W5SBzB9JWiKnmqBUj2jKFtIw6ecpBkIbHHWNNzmiMFe25nJs5tQ8FE679MRJcegoE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(346002)(396003)(366004)(39860400002)(451199015)(6506007)(36756003)(6666004)(186003)(6512007)(53546011)(6486002)(478600001)(38100700002)(31696002)(86362001)(83380400001)(2616005)(5660300002)(8936002)(41300700001)(2906002)(44832011)(31686004)(316002)(6636002)(110136005)(66476007)(66556008)(66946007)(4326008)(8676002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UGtyS1VhL1cyZ3FDa2YvTnhWY1hqMHh5cDA0bEdwSng2VEJma1hRcHpuK2g4?=
 =?utf-8?B?bU9JVVd6SUJOdk9WaWZiWnhEck9lQXJ2T0hqREQrNWxtd052WHQ0bGxrTkZJ?=
 =?utf-8?B?dEFBM0hVSEMrb2N5UDVlbEJmMmxpejNHMk1kTU53b3F4QUd4R1EvMW1ON1FQ?=
 =?utf-8?B?eWpKN1FzTTlwYTQzVE1Ld0ZmczFiVDk4K0IwbEdmdVRoQVF0ZGVWcElyRkxC?=
 =?utf-8?B?b3FQUnNtNW1ELytrUmpDZzVUaFB3bmVTUFZmWWgwTmhKZWNURGYvVk1FRXhp?=
 =?utf-8?B?Z0pnT3NjWWhBSlM2Z2ZuaGtDQ2kxT1orUlQvSElMTVdGUkhNRGhKKzNXRmI0?=
 =?utf-8?B?OEN1UnQ0TlI3RU9TdDgrMzNtaU5PNkErZDN6WlgzZ1NDV2dwVlFtdERCWXNO?=
 =?utf-8?B?R1VPREtrZG9aNFFrQSt6eWNlMndsTWNDdmdQNnZhTXNZWmlLMXBRZWo4WjJ3?=
 =?utf-8?B?bkY1eFJOV3l4cmQwUjl6cFZxYmVuQVFNWXpUL0JvV3lPMGRXbXJnZ1B4aW43?=
 =?utf-8?B?TlZicUcwKzM4YkR1cFJmWVdpODI5SFB5MUs2anZvTWw5TDREU3FxM0p5UlNP?=
 =?utf-8?B?Wjk2Snp4MWlOQkFicTZRZ2xZdUtpMUtlbExRRnZVQnBXQ2NkZzFUcHpvRDlD?=
 =?utf-8?B?U2k4b2xyTjVKNkhROVpnUllVN0tya1I5REJVMXZhMC8rRHREQkpXSTA0WFRj?=
 =?utf-8?B?OEZsQSt5Zzg5a1lQWFNzc2pXSTE3RFZUa3NLbmhtdTA0ZXFscFlWcHNyV0I0?=
 =?utf-8?B?aVlrcGhFQUU4OUNLcjkyN3NmclY3NmhNdmpmVU1VRFZ1QWdHWGFsb2I1b0E2?=
 =?utf-8?B?OE1vdWIyU0M0amxWeldhdnBlbFphM2hhRUJvdlFQV25mYjBZQjhPQksvKzBJ?=
 =?utf-8?B?MGFiNDg5S2trUHdSMlFMYzdhcXY0WVlYemZsUU5EcDRjemNacVpFaG1lcWVD?=
 =?utf-8?B?N3dGT1NrWHYvbWdRTGthcUQ1NHhIOGo5Sy9lN2p5MmFaZmxtSG1GdUowUUtX?=
 =?utf-8?B?R3NEc2kvYkwzd1VMcGxyaWV3Yk1kYzF2M3grcDE0bWw4ZXBMcmtiOXJwVXBa?=
 =?utf-8?B?eDJpVE1yVlN0TVI5SUZBMkpsTlYwa1I5Y0djcXVDOS9Dc052aDQ2djVMNEN4?=
 =?utf-8?B?cWRiV3hmVnpLUTE2Mk9qRk1WRUwrc0x6OHY2Z0lleUlZeVZZdFN5WE9pZEQ1?=
 =?utf-8?B?cmNXOVNRVExGNnlvcWp5SEZDMThVSU1JU0U5U2IzVmc5MDYrZFRvN0R5b3Ft?=
 =?utf-8?B?RmNJdm03c3R3dVp1VHpSeWErS2ZxTmEreU5EeHl5UmtRbWxXdVIxUXV0R0hW?=
 =?utf-8?B?MnJQdEJIV1hIbXg2ckRqRm5POU1qSGF3M2NrUmxRS3pkWDk0RmgzN2ZZOWMy?=
 =?utf-8?B?emlNeVZEWEMveW9yTi91T1VqYXIvSzhpNWpoa1hRak9pRHRub0tPTjN3dUdq?=
 =?utf-8?B?cjhabnNxK1o3YXFZRHJnc1lGY1psZUN3RXRlRkdVTGgvbkYvanBvWHFqaG1U?=
 =?utf-8?B?OXJZejBrL0tPMkZqMVhEZ09Dd0VwajFmSGYyeVhpOXdDVTNnOWRqQXYyZDRB?=
 =?utf-8?B?KzlQdFFZWWJJUE9Ock9BTXVrSGdmZHdsTXp0RGJxbzM5Ui9wdkd1VmQrc2hy?=
 =?utf-8?B?K0lpcGN5Wm9ndTFpUjBvU0ZHMUxpdFZRcWFrNVFMR2djVGFubHAxanh2K0pY?=
 =?utf-8?B?eE1OeGdGSFRSUWp0NVUwd1ZockRZbmFaTUZsQUxldXZCZmdRTnRaRHRHdWMx?=
 =?utf-8?B?cGFDMGtrY3R1RlNYbS9hcm1hTWt3dDlMR2p1OExsMlJCTGZ2aTBFRkV2WUt0?=
 =?utf-8?B?UHhJYjlpa2kxN0x6Wk9qSEVtTFlRVUlJaG5qZEtrQUxqNkt5dFk0QndrTXBD?=
 =?utf-8?B?TVprUkJDNlNsd1VzSFpWdTJBZjBzZ0ZoYWxFdkk0MXJFckFyOWdFMTJCaU1a?=
 =?utf-8?B?YWk1d0JGbWc3QkxLRE16MWlwY2VpSDVncjR3TU5ET0dydGN6T1pqRVp0ZTVZ?=
 =?utf-8?B?alhyZDlKQ203WUg2ZGp2aExmSFcxSHk3bEUxcEF6dEFaaWdCOFdJeW9NOE50?=
 =?utf-8?B?WDVtUEtEc01UeDVBK2dCdTZxcmtSTzRLUjdaN09GUU9peXk3dlBGYVlVaEZq?=
 =?utf-8?B?KzMycWMvNHdMdEZpRlkvWHlZaHlINGFFWVExYTJHMEZWS0hOQ2o5LytSWlhU?=
 =?utf-8?Q?Qp7MRl7BYGY6bymMafX6XxkRbQwdzqbvoXf8fBWoU6ii?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4706a3d-1ef6-46fc-2631-08daf529c735
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2023 05:48:21.2834
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NomPFwtGp4LKfmpi2L7Dc/pVb87E5PptZFvyr4K1Kr73OkKcoepIqfIb4VcPliyK/heII4fvjE8uuIBq5kivnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7285
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/12/23 23:21, Wyes Karny wrote:
> amd_pstate driver's `status` sysfs entry helps to control the driver's
> mode dynamically by user. After the addition of guided mode the
> combinations of mode transitions have been increased (16 combinations).
> Therefore optimise the amd_pstate_update_status function by implementing
> a state transition table.
> 
> There are 4 states amd_pstate supports, namely: 'disable', 'passive',
> 'active', and 'guided'.  The transition from any state to any other
> state is possible after this change. Only if the state requested matches
> with the current state then -EBUSY value is returned.
> 
> Sysfs interface:
> 
> To disable amd_pstate driver:
>   # echo disable > /sys/devices/system/cpu/amd_pstate/status
> 
> To enable passive mode:
>   # echo passive > /sys/devices/system/cpu/amd_pstate/status
> 
> To change mode to active:
>   # echo active > /sys/devices/system/cpu/amd_pstate/status
> 
> To change mode to guided:
>   # echo guided > /sys/devices/system/cpu/amd_pstate/status
> 
> Signed-off-by: Wyes Karny <wyes.karny@amd.com>
> ---
>   drivers/cpufreq/amd-pstate.c | 144 ++++++++++++++++++++++++++---------
>   1 file changed, 109 insertions(+), 35 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 20d78dad712d..4a2b559fd712 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -65,6 +65,8 @@ static struct cpufreq_driver amd_pstate_epp_driver;
>   static int cppc_state = AMD_PSTATE_DISABLE;
>   struct kobject *amd_pstate_kobj;
>   
> +typedef int (*cppc_mode_transition_fn)(int);
> +
>   static inline int get_mode_idx_from_str(const char *str, size_t size)
>   {
>   	int i;
> @@ -806,55 +808,127 @@ static ssize_t amd_pstate_show_status(char *buf)
>   
>   static void amd_pstate_driver_cleanup(void)
>   {
> +	amd_pstate_enable(false);
> +	cppc_state = AMD_PSTATE_DISABLE;
>   	default_pstate_driver = NULL;
>   }
>   
> -static int amd_pstate_update_status(const char *buf, size_t size)
> +static int amd_pstate_register_driver(int mode)
>   {
>   	int ret;
> -	int mode_idx;
>   
> -	if (size > 7 || size < 3)
> +	if (mode == AMD_PSTATE_PASSIVE || mode == AMD_PSTATE_GUIDED)
> +		default_pstate_driver = &amd_pstate_driver;
> +	else if (mode == AMD_PSTATE_ACTIVE)
> +		default_pstate_driver = &amd_pstate_epp_driver;
> +	else
>   		return -EINVAL;
> -	mode_idx = get_mode_idx_from_str(buf, size);
>   
> -	switch(mode_idx) {
> -	case AMD_PSTATE_DISABLE:
> -		if (!default_pstate_driver)
> -			return -EINVAL;
> -		if (cppc_state == AMD_PSTATE_ACTIVE)
> -			return -EBUSY;
> -		ret = cpufreq_unregister_driver(default_pstate_driver);
> +	ret = cpufreq_register_driver(default_pstate_driver);
> +	if (ret) {
>   		amd_pstate_driver_cleanup();
> -		break;
> -	case AMD_PSTATE_PASSIVE:
> -		if (default_pstate_driver) {
> -			if (default_pstate_driver == &amd_pstate_driver)
> -				return 0;
> -			cpufreq_unregister_driver(default_pstate_driver);
> -			cppc_state = AMD_PSTATE_PASSIVE;
> -			default_pstate_driver = &amd_pstate_driver;
> -		}
> +		return ret;
> +	}
>   
> -		ret = cpufreq_register_driver(default_pstate_driver);
> -		break;
> -	case AMD_PSTATE_ACTIVE:
> -		if (default_pstate_driver) {
> -			if (default_pstate_driver == &amd_pstate_epp_driver)
> -				return 0;
> -			cpufreq_unregister_driver(default_pstate_driver);
> -			default_pstate_driver = &amd_pstate_epp_driver;
> -			cppc_state = AMD_PSTATE_ACTIVE;
> +	cppc_state = mode;
> +	return 0;
> +}
> +
> +static int amd_pstate_unregister_driver(int dummy)
> +{
> +	int ret;
> +
> +	ret = cpufreq_unregister_driver(default_pstate_driver);
> +
> +	if (ret)
> +		return ret;
> +
> +	amd_pstate_driver_cleanup();
> +	return 0;
> +}
> +
> +static void amd_pstate_change_mode_without_dvr_change(int mode)
> +{
> +	int cpu = 0;
> +
> +	cppc_state = mode;
> +	if (!boot_cpu_has(X86_FEATURE_CPPC)) {

You can save some indentation by inverting the check and calling "return".

> +		if (cppc_state == AMD_PSTATE_PASSIVE) {
> +			for_each_present_cpu(cpu) {
> +				cppc_set_auto_sel(cpu, 0);
> +			}
> +		} else if (cppc_state == AMD_PSTATE_GUIDED) {
> +				for_each_present_cpu(cpu) {
> +					cppc_set_auto_sel(cpu, 1);
> +				}
>   		}
> +	}
> +}
>   
> -		ret = cpufreq_register_driver(default_pstate_driver);
> -		break;
> -	default:
> -		break;
> -		ret = -EINVAL;
> +static int amd_pstate_change_driver_mode(int mode)
> +{
> +	int ret;
> +
> +	if ((mode == AMD_PSTATE_GUIDED && cppc_state == AMD_PSTATE_PASSIVE) ||
> +			(mode == AMD_PSTATE_PASSIVE && cppc_state == AMD_PSTATE_GUIDED)) {
> +		amd_pstate_change_mode_without_dvr_change(mode);
> +		return 0;

This feels like you're duplicating your logic of your mode transition 
table.  How about having the mode transition table call the function for 
changing modes without a driver change directly instead for those cases?

>   	}
>   
> -	return ret;
> +	ret = amd_pstate_unregister_driver(0);
> +	if (ret)
> +		return ret;
> +
> +	ret = amd_pstate_register_driver(mode);
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +/* Mode transition table */
> +cppc_mode_transition_fn mode_state_machine[AMD_PSTATE_MAX][AMD_PSTATE_MAX] = {
> +	[AMD_PSTATE_DISABLE]         = {
> +		[AMD_PSTATE_DISABLE]     = NULL,
> +		[AMD_PSTATE_PASSIVE]     = amd_pstate_register_driver,
> +		[AMD_PSTATE_ACTIVE]      = amd_pstate_register_driver,
> +		[AMD_PSTATE_GUIDED]      = amd_pstate_register_driver,
> +	},
> +	[AMD_PSTATE_PASSIVE]         = {
> +		[AMD_PSTATE_DISABLE]     = amd_pstate_unregister_driver,
> +		[AMD_PSTATE_PASSIVE]     = NULL,
> +		[AMD_PSTATE_ACTIVE]      = amd_pstate_change_driver_mode,
> +		[AMD_PSTATE_GUIDED]      = amd_pstate_change_driver_mode,
> +	},
> +	[AMD_PSTATE_ACTIVE]          = {
> +		[AMD_PSTATE_DISABLE]     = amd_pstate_unregister_driver,
> +		[AMD_PSTATE_PASSIVE]     = amd_pstate_change_driver_mode,
> +		[AMD_PSTATE_ACTIVE]      = NULL,
> +		[AMD_PSTATE_GUIDED]      = amd_pstate_change_driver_mode,
> +	},
> +	[AMD_PSTATE_GUIDED]          = {
> +		[AMD_PSTATE_DISABLE]     = amd_pstate_unregister_driver,
> +		[AMD_PSTATE_PASSIVE]     = amd_pstate_change_driver_mode,
> +		[AMD_PSTATE_ACTIVE]      = amd_pstate_change_driver_mode,
> +		[AMD_PSTATE_GUIDED]      = NULL,
> +	},
> +};
> +
> +static int amd_pstate_update_status(const char *buf, size_t size)
> +{
> +	int mode_idx;
> +
> +	if (size > 7 || size < 3)
> +		return -EINVAL;

The compiler typically inlines strlen.  Perhaps to make this more 
obvious what these boundaries are maybe do this:

size > strlen("passive") || size < strlen("off")

> +	mode_idx = get_mode_idx_from_str(buf, size);
> +
> +	if (mode_idx < 0 || mode_idx >= AMD_PSTATE_MAX)
> +		return -EINVAL;
> +
> +	if (mode_state_machine[cppc_state][mode_idx])
> +		return mode_state_machine[cppc_state][mode_idx](mode_idx);
> +
> +	return -EBUSY;
>   }
>   
>   static ssize_t show_status(struct kobject *kobj,

