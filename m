Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6555B6F8CBD
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 01:19:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231848AbjEEXTj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 19:19:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231609AbjEEXTg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 19:19:36 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAD994C1D
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 16:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683328775; x=1714864775;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Z4Xiair6M40rer+PIC7j/tF9jyQifYvqjwJK9uGQcec=;
  b=gLB9i9SqLAfYRpm21Pv8JG2odffKKsd7KsQfqPL4y4ULJrkBv7fWBuqB
   J66l9appVpmcC1ORE5gr5yOOoKOZcf3A2omPAzSyttK0bjK4Y9GqzS08i
   nVY2Ni//rWz1I67AgO1yuXned7l9PKkPv57clYon9XXmNPjRQSvgPQC1r
   D8VTqYyBX4hPeHQ2JpO2tnheOWoAwIniD3XSGPwXPmDDdz2O5Mm/ZpoY/
   dgf+HEiUtwk2HZ2Ob5SDrIXHaMbngBOWG95JjcTvRdnK0oHNacyr9jXRy
   FQpAk6BG6IDj5jr0kQFy0bzSN/9qsJiV0quwKKRaUf6TZPTlfR3KsdV6j
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10701"; a="377398243"
X-IronPort-AV: E=Sophos;i="5.99,253,1677571200"; 
   d="scan'208";a="377398243"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2023 16:19:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10701"; a="809450649"
X-IronPort-AV: E=Sophos;i="5.99,253,1677571200"; 
   d="scan'208";a="809450649"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga002.fm.intel.com with ESMTP; 05 May 2023 16:19:35 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 5 May 2023 16:19:34 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 5 May 2023 16:19:34 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Fri, 5 May 2023 16:19:34 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Fri, 5 May 2023 16:19:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P/D3TWk57wIyAqqOuhlyWbgW2sJjsE283J+utnJxKPCXIj55Nb/h3B81AsYqaieDY5XNiP8TZ/pI3ZY78r7DnsGrM9IqmCMgs88lWi65EclwsH26PPDn8vkV/Yx8rD1L4cc1JtV/Vy5feHgCPQn2Pio7GaZWES3NfOp/pM2x/z2tmlfBC3rSv9u/46bydKPXePFSpeHycOf4iAfMKlT+zikdXCScaxEjWIk6Y8NMszfqnKUaexR3DQE+dab1IC3gKmKSVN2MuiN6jIlR65tXHXyhxxeOnL2c+QxCEMoAM+ADP/H6cWXEg3q1Kiw6Xv0qmC6RXoIpp/RiZ6oEKibDMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fP2+ysX0umkA88PI5lMDChT7MHf0f6ZohN1Ch2claYc=;
 b=IRVk1L/UWf2tAq/FyyCdj4Twd/zi1ATzlGkEpawjBehNPHyoGu+BA0twakRQrzXyRVACs1QA6dqChFN7Vhxu0if9t8cukIwmHnNIQIDJ+0YliksypS2pBuINy6QyAml5YJBOjzpaU0BuxkqSzeVt5s1SvaX3OcCLsD6wrmoaqn0kTHozQArCGVNiMKX0O83ID0xalT1N7oN2dXVjlcNG+qy4yzSMdOSEQpy4HMh20ldBrIiLO8m+3l1eo1VPqX8XJxcctpaJyqwzVQEcoMi+cXgdbxqB/WVSaqsQ9i9sp2gWkpfG6Gx1SipqfGZk8dEqpz/kyhgYH3vdgar6QcjS5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by BL1PR11MB5953.namprd11.prod.outlook.com (2603:10b6:208:384::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.26; Fri, 5 May
 2023 23:19:32 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::591f:4873:fd80:9a6d]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::591f:4873:fd80:9a6d%6]) with mapi id 15.20.6363.022; Fri, 5 May 2023
 23:19:32 +0000
Message-ID: <54538ac1-c700-bd0b-2a1d-bcbe84067a0c@intel.com>
Date:   Fri, 5 May 2023 16:19:29 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.10.1
Subject: Re: [RFC PATCH 3/7] x86/resctrl: Add driver callback when directories
 are removed
Content-Language: en-US
To:     Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Shaopeng Tan <tan.shaopeng@fujitsu.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        James Morse <james.morse@arm.com>,
        "Babu Moger" <babu.moger@amd.com>
CC:     <x86@kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230420220636.53527-1-tony.luck@intel.com>
 <20230420220636.53527-4-tony.luck@intel.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20230420220636.53527-4-tony.luck@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0123.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::8) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|BL1PR11MB5953:EE_
X-MS-Office365-Filtering-Correlation-Id: 4187b0a8-ba4a-4eaf-1823-08db4dbf2ead
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qq8mSRLuz/nlUT5b2YstDQEo9LdO891PTSRHXkgXf/UmAMbadJtyjaHKawtPdM5H9I4yBsPu4vLfYsZDyOsnswedpTz7u4kvelLDpouCMhAaNxW/1scHS9l7P/Gf8m8e0oNf/4PRHe+uXAoJHATv9uqGSOvh3HkeW48MyTPb9kxQNtMJGVCwmSZvIVbBPb4giF21iqnb+kORjw1yAMF2GBZscj5RlGwW/x/K1CQJ0Ytqxngr1pHScEMLwGYcembsNh4ryl76AU2UkZKQIS2uCw2VPmi/hDch6v1KwkLOiM91HHt0Dsp7NatSi7j1oVnOr484nTai5MS89nn7ijPTzYswkpFjRyItu2xCEUjxQnXIRyoqd1vcBZ6JXcXVyBHlrZWM+Pn0MIjX0Cb5uhCFjWIGx5+7GjvD3wa8wX3PbPTK4dzvzP6CMlC1W6L355OFLgvRkb4NFBXojuReEw5DZXlpKThl6JJ/8B8AlGFlqSNTYUkuN1A/YrTPTlwIH8LDDK+IbJ4m9zIOMomibr57Ks0JTEShIQw6dWsemP/eYSar5cksR2viGjMkfzFMGaHORFoD8qMss/ULcRivvydYiTpveAbN+BBVMCFhHBKgryLn4N+lvxNeORKFOBdOI6r3MiE8nufEPCN3UOCE5OnXlhmWq3rCmBG73aY2NDkULwA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(396003)(366004)(39860400002)(376002)(346002)(451199021)(6512007)(53546011)(6506007)(26005)(31696002)(186003)(2616005)(31686004)(110136005)(83380400001)(36756003)(6486002)(6666004)(2906002)(82960400001)(316002)(8936002)(5660300002)(478600001)(4326008)(38100700002)(7416002)(86362001)(8676002)(44832011)(66476007)(41300700001)(66556008)(921005)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZmNkcXRoMU5jNTd0QkdNYmxPY2hVM2U4S3IzVEM1dXhMMU1SeUtyL0d2K0Y1?=
 =?utf-8?B?VmR1TitlY3RETGhVaEVCdkMxUzZacm50M0ZCVFNtMGI1MGl4TmxCbzlZOWpJ?=
 =?utf-8?B?TStMS2VEUndXTnl3T0hHc1ZIcWhPVnNQeERmOGEyM1dubVJ0Y3RacjlscTQr?=
 =?utf-8?B?ZDRTZzBXVzVnTndrVml2RlpTdWIwS2JMUWxzL3VSUm5FZXpVak1oK01TemNH?=
 =?utf-8?B?UzZYcDNmQldtNnlpUTIzckxoc2xaeDdmdmN2TGNtODVMYWo1NkNqbGh4NHNv?=
 =?utf-8?B?YkFqdkJmazFkM0ZMaFZKdmNmWDVYTGQ2SVlyYkNmSGNIOXRGVnVod0RjaVlt?=
 =?utf-8?B?N2lXdHp0bmtsTE1OajljQzdYcUVjY2o2eW1WbE5XVG9tcDgySkVOQmVYSVdY?=
 =?utf-8?B?ZU4zL2hpdGFzZVpvUTNCNi9HTTRXaTNJTkN5bTIyZmJBUGc4TUl1VS9kand2?=
 =?utf-8?B?VElweDlFc2RCOFJTait4cTF5MlNheG9rOUtVMmFtNzFlSmMvLzZkMzJUY3Iv?=
 =?utf-8?B?OUo0RHEvZlFpY2RZcTNXMDRyaitodUxzV3QxL0I3RERCZ29zY0xNZ0NNQlZh?=
 =?utf-8?B?OHE1OUt0NS81dG4xRXZEWnpxTTBOZ1hicGZpazVDMFY2Y1NRQVB2eXJPV1lF?=
 =?utf-8?B?SGlJWlBvcTZoOTFrWTJqN1U3OHNXcytxZEdQa2xjeTNIZUJPNGRvcFpzajBX?=
 =?utf-8?B?NzFxNmxCeUhwdWZCazM5MXJ5Mkg2OUlQc2R5cHRzMlhDSzlNUjA0YmdIQmhM?=
 =?utf-8?B?SmVUc2xoNk5NVmpxTlE2Z0N6anMvdkFKQ2RkMDlVS0pwN0FDR3d2NHdQcWRM?=
 =?utf-8?B?V0txZkRXRzh6UVFvZ0g4ZXJrN3hTWlc0SndYeG1IK2w0VjU3bWdKcHJuR253?=
 =?utf-8?B?WmROalNUTkcvckJIZ1owQzZxQVRKNXhjaGhVMFo2NUk4SHkxMk54WHkzdmVw?=
 =?utf-8?B?cVNIb1B4S0QzQSs2cHlKS25xNUNLSnhhRlJieXI3cEJFQ2ErbU1YeUFjM0pk?=
 =?utf-8?B?cFhuLzF2STg3d1VLaGViaGRSNEVTMnEzbWxpV2JZeHB2OENWb3RQQjY2MDE4?=
 =?utf-8?B?dE5DK3N2a2h3Z1pXS1d6WEcwTUUveEtGemNMalIrYVRTcHREalFVejB1WGRY?=
 =?utf-8?B?YnN1L01CZmZvT281NEUwVmgzWGJhU0VLU0gwMFBXczZRV1h1N0loTEVTWm92?=
 =?utf-8?B?QWtLc2JuWmlRVTNpVU9Ubk03VzQ5Z21jL2drdHBIRy9WOHBGa3BoRWhseEpP?=
 =?utf-8?B?MWdVc2haR0tJZytVVUo2Umt5T0RLUTVBZzFLdDhCWDd5K0FacmFwdWIwQUxX?=
 =?utf-8?B?N2Q3UkZzc2QzMFpEYkVDc2RZd3ZEMUZpaEE3YWNLUFY2Y0VjT2pMcXlNRG41?=
 =?utf-8?B?Uk0yL1ZWNGJyZFdHVlQvYTdwQ2J6eXBQYXJKNUsxclZMREREVGtJNk82TzF4?=
 =?utf-8?B?Rm1Wc0h2QUJzMlFwc2xlaGlXMUhtZzRJRG45RzdhSXNFMEpxd0tGMkE3SDlq?=
 =?utf-8?B?RzcvV3NsQTk4cmp4RlhBbXVqSUJBYjQrQTZrdmMzdkdsblNPelZEVUhqUkh6?=
 =?utf-8?B?Q1hkbXc3Q2pzcndFVHVCUWNJcExMUk41eEZ3cFR3VWErRnhDWXprdVM0SllM?=
 =?utf-8?B?bWkvVEp0aENaOFpqZ0RTVC8xTVE5U0NZMjZsbW43UWgxdm1hY0hSWGhjV1Rw?=
 =?utf-8?B?TjZaMk1vNnVqbEJGd0RxTGpXOHhESjN6bzdCSnhiUnBMeDRQbFFHVzBrNm1R?=
 =?utf-8?B?SEx2MGJ5RmNPYWQ1a2JocmlacHdUdWhtRzE1b25uN3Y5UUZmc2lxTzZhdVFu?=
 =?utf-8?B?cmlOTDA5WVQ0dlliYXYzZkpYc2FndmtyUUJabm40cXdQd0Fud0lNYTdnc0l3?=
 =?utf-8?B?TmVFaGU2bllVRGkyOTNWdTd3Y1ZqM1UzL1hlR0xxaTVodGZMZXY3RDg4bHlo?=
 =?utf-8?B?cVhMZDlwN0hXNEN2V3U4bXMySDdnZVRMeitoWkYyNW9TNTBWUjZ4aVdKY1lS?=
 =?utf-8?B?T3ZQdWtlNC9VK1JiMExNd0pMY3VXT3FObStFcWNIVVc5b2Z2dHdUVE1LVUtJ?=
 =?utf-8?B?NDhHN1BZRWdmQm1pellhWDVLbXZ5M0NCeW1YK0lUVHo3TGNBTzNhQU9RR0th?=
 =?utf-8?B?UEdVbS8vZjZVYzdyaVdEM0hvVTZXa05KNzZpcWVYaWFZSVI4aDdnRXE1ei9O?=
 =?utf-8?B?VXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4187b0a8-ba4a-4eaf-1823-08db4dbf2ead
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2023 23:19:32.0989
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ok1fYJ9nt1A5FRKDh1REAVRHoXQS5LBCfvU0XoUucYd78RQrGRVbc6CPQgOQ5kbCAWpuWjzRL5wLkujKQsLAKFB8tH5L8zsNKy/3vq0RnyY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5953
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-8.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tony,

On 4/20/2023 3:06 PM, Tony Luck wrote:
> When a resctrl directory is removed, entities attached to that
> directory are reassigned with the CLOSID and RMID of the parent
> directory.

Could you please elaborate what you mean with "entities"? In
resctrl there are tasks needing to move but that is done in resctrl.
Would drivers be doing any manipulation of the tasks' closid/rmid?

> 
> Add a callback function so a driver can reset the CLOSID and RMID
> of any resources attached to the removed directory.

I expect this behavior to be different between the removal of
a monitoring group vs a control group (more later) ...


> @@ -3495,11 +3495,18 @@ static int rdtgroup_mkdir(struct kernfs_node *parent_kn, const char *name,
>  static int rdtgroup_rmdir_mon(struct rdtgroup *rdtgrp, cpumask_var_t tmpmask)
>  {
>  	struct rdtgroup *prdtgrp = rdtgrp->mon.parent;
> +	struct resctrl_driver *d;
>  	int cpu;
>  
>  	/* Give any tasks back to the parent group */
>  	rdt_move_group_tasks(rdtgrp, prdtgrp, tmpmask);
>  
> +	list_for_each_entry(d, &drivers, list) {
> +		if (d->rmdir)
> +			d->rmdir(rdtgrp->closid, rdtgrp->mon.rmid,
> +				 prdtgrp->closid, prdtgrp->mon.rmid);
> +	}
> +

This seems tricky ... if I understand correctly the API provides
limited properties directly to driver to keep things safe but at the
same time the properties need to accommodate all driver usages. All drivers
would need an update if something new is needed.

For example, this seems to ignore whether a resource group is exclusive
or not - could group removal trigger behavior that can circumvent this
restriction?

>  	/* Update per cpu rmid of the moved CPUs first */
>  	for_each_cpu(cpu, &rdtgrp->cpu_mask)
>  		per_cpu(pqr_state.default_rmid, cpu) = prdtgrp->mon.rmid;
> @@ -3535,6 +3542,7 @@ static int rdtgroup_ctrl_remove(struct rdtgroup *rdtgrp)
>  
>  static int rdtgroup_rmdir_ctrl(struct rdtgroup *rdtgrp, cpumask_var_t tmpmask)
>  {
> +	struct resctrl_driver *d;
>  	int cpu;
>  
>  	/* Give any tasks back to the default group */
> @@ -3544,6 +3552,11 @@ static int rdtgroup_rmdir_ctrl(struct rdtgroup *rdtgrp, cpumask_var_t tmpmask)
>  	cpumask_or(&rdtgroup_default.cpu_mask,
>  		   &rdtgroup_default.cpu_mask, &rdtgrp->cpu_mask);
>  
> +	list_for_each_entry(d, &drivers, list) {
> +		if (d->rmdir)
> +			d->rmdir(rdtgrp->closid, rdtgrp->mon.rmid, 0, 0);
> +	}
> +
>  	/* Update per cpu closid and rmid of the moved CPUs first */
>  	for_each_cpu(cpu, &rdtgrp->cpu_mask) {
>  		per_cpu(pqr_state.default_closid, cpu) = rdtgroup_default.closid;

... is the expectation that the driver would look at the latter parameters to
determine if a monitor or control group is removed? I think that may be troublesome
since API like this relies on driver needing to have a lot of insight into
internal implementation choices of resctrl (which could potentially change?).
If I understand correctly the driver makes assumptions like: (a) default control group
always is assigned closid 0 and rmid 0 and (b) default control group is never removed.
I think that it should not be required for drivers to have knowledge like this
(and then also risk that these assumptions may change).

Reinette
