Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1031860C0DA
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 03:19:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230468AbiJYBTy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 21:19:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231485AbiJYBS7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 21:18:59 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BC50F5D;
        Mon, 24 Oct 2022 17:41:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666658506; x=1698194506;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Lisigb4C5r3emz6Fcjrs6zdmEWlzyRVBBAy//EAuLn8=;
  b=dVpcHU3rx782FROUKAOrGtYnjF3U5mACsyjAk5sap4eWAmusIAqqer2L
   DZrIpNe0dROevF5nVHN3dMVK02+8YMTqc2B4bQAgjanVOm3J/pfQqY80d
   a23FIqVBBnNjULxdKQjV01sM1PVCsxUfMIFeK+l0N/PCYlG4tTt27g+9Y
   N5980v12M/dfp+rg+FayuJ/hzWY/I1NHA5hUQMZw86tDgAKu3uojMarTx
   1zOl3BbTnTBcfW4JktQiZ1XXOkDMHYAiQBfOKcapigbj76o9P0d/vpbCR
   SB9wshHX8AfAKVUFGx10CoMBfukcJ+CbAii6vuqOAyEKXEa2L8dfq99FN
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="308648166"
X-IronPort-AV: E=Sophos;i="5.95,210,1661842800"; 
   d="scan'208";a="308648166"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2022 17:41:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="736616430"
X-IronPort-AV: E=Sophos;i="5.95,210,1661842800"; 
   d="scan'208";a="736616430"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga002.fm.intel.com with ESMTP; 24 Oct 2022 17:41:45 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 24 Oct 2022 17:41:45 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 24 Oct 2022 17:41:44 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Mon, 24 Oct 2022 17:41:44 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.171)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Mon, 24 Oct 2022 17:41:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DeuMCVaRkcmA/PUbLQ2jm0knB2blLdipHpjj7T3zJ7GgcwtLQnWD+hsppUm2NrOIfF5d8En2c2hUU/vAcmQbuEXrBaBTGHlSrrQYyLBytQ2xgcqc6NODqEhaV0ewqTMdta7vztD8YkTp/B6J1Up2bj/Cm5f902PfiFjJzO+MTJXOfdR1RbjkufLXTxXFakUD7tOFhV5jR0l9NtfLwrcuLTNe7QjfzCfph4uIP9I7L0CoYpKunnn2bdRHtDow0Tc6rR4Rb//IFjhL3kalsZ3TdegQJ9kwYKDjbiBYYpSnbBVTFTxcyIzZXPEiYzW2/E/AK1CIVSzWetYD/6ZSXja57Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7qklIuE6Vt/AcB3phdZbrOvOv+GbzAiNKeYGrt3NKyY=;
 b=cJ6MnnZC/R62sqgx6yL0Obh4ehV9iVlHpaswJ9QTQLYZ3TM7GBCZlLoIr8rwcn109/4EKYMh8dUeQLx1yCtCNDwjFO791/YkGk/1eAXPgh+BeRvXcSBm+g3YlbxfRmDbEEmW3EO53y8Fu38R2+OO/FcGkOqqhHk3teXCZ6zC2kkA5kgnsLCgSJKtknTkgXQ7Wco6YIey4gFz1cyVfz0VHkUOMCbUONipl0SF1qwyT8bplsY9B9462rI2G5BwS2qCxkl3wRJZiWx4NM8R8NXAEqr4mkhaj9nGkYvgWEYvXVWBFcWtOe3EoNQVzvgSnfEUIgqdDIjCzXh1vxNuLvPayg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3768.namprd11.prod.outlook.com (2603:10b6:a03:fa::20)
 by BN9PR11MB5484.namprd11.prod.outlook.com (2603:10b6:408:105::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.35; Tue, 25 Oct
 2022 00:41:42 +0000
Received: from BYAPR11MB3768.namprd11.prod.outlook.com
 ([fe80::f98a:551a:1689:d091]) by BYAPR11MB3768.namprd11.prod.outlook.com
 ([fe80::f98a:551a:1689:d091%7]) with mapi id 15.20.5746.026; Tue, 25 Oct 2022
 00:41:42 +0000
Message-ID: <2fce55c1-20cb-39c1-52ac-d9b3e2247296@intel.com>
Date:   Mon, 24 Oct 2022 17:41:38 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH 04/14] platform/x86/intel/ifs: Remove image loading during
 init
Content-Language: en-US
To:     Sohil Mehta <sohil.mehta@intel.com>
CC:     <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
        <gregkh@linuxfoundation.org>, <ashok.raj@intel.com>,
        <tony.luck@intel.com>, <linux-kernel@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>, <patches@lists.linux.dev>,
        <ravi.v.shankar@intel.com>, <thiago.macieira@intel.com>,
        <athenas.jimenez.gonzalez@intel.com>, <markgross@kernel.org>,
        <hdegoede@redhat.com>
References: <20221021203413.1220137-1-jithu.joseph@intel.com>
 <20221021203413.1220137-5-jithu.joseph@intel.com>
 <ec2a2799-9db5-8810-7a41-f9f6ca1b360b@intel.com>
From:   "Joseph, Jithu" <jithu.joseph@intel.com>
In-Reply-To: <ec2a2799-9db5-8810-7a41-f9f6ca1b360b@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR04CA0001.namprd04.prod.outlook.com
 (2603:10b6:a03:40::14) To BYAPR11MB3768.namprd11.prod.outlook.com
 (2603:10b6:a03:fa::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3768:EE_|BN9PR11MB5484:EE_
X-MS-Office365-Filtering-Correlation-Id: 6701a17a-65c5-42d1-7cf8-08dab621afb7
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ys7woI0CeftZINibp5nTHXuK2YuvggcNnZsSRny7p3YbeMv8XzLoI9F6xNPgJfiJbntXw2PGsAacfbMOLVijeoSG2a9Qzf12Drgb0Wj9jE9X4p6omUxQJqNGh9UlqCdiuhYBYjuaK5qRIfWKTsjGgj/mlRJqz4GJGctHY3+J8nu19oNemkZqo2tn5T3Ux9asjVuyYOTpRCAhUNWlrNMaCfDDjCNiMaoAIGZX6gLIINfpRsjI/elkp6ARRTQ1C0iq9pM7xLEGEG5z+1mrvVdLCt3nwMu4UKbNi9gwDjiwrvQrlKADoMD6gyYAy/j9qZIYHq9jCnm4G7hVBVwq3mAPcCY1rqL+MiC+Yji7lmSB8z2mo12A71Qd/zK1KsMq8z/PCpYYqNFoSoQBncWMZ8WWKf7uZ5W0BylfmaSbUiQqGkaTfOEILiTeJH4iLEMNJcHNACPcDsAPNPTNt+LStRQIOHwPw98fV6kXbfSCd8WUEf1db3aWsnGu9HNYc7zWmtSBJ0xJZr8DLNwcNlU/JMznT4nbs7liyiURbfnAbvxlee729ZqeZ8QHcNqwc1Qxn1vN7lFAe+VJZowJi6muqhdY4XfiVR7TvLs8tNGZpv1Rn3/ST5RA/9XtckLO17sQ3CneauDQeFUVxRwGaLLkzt3EtBuM8MKxKiM3Yh4yUrFIJm+1CqqeVXV3AU/tVmIMZNN+sUvVHL63JDcDqC3oN/4DR3bP0suTf/oqvjTlulL/n+3DKF8Vqx6PCirD7HBbzgGrdGs08O79g3dcL05blS1W7VDlh1Arno0IUO3GwoncoJ4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3768.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(346002)(366004)(396003)(376002)(136003)(451199015)(5660300002)(6666004)(38100700002)(7416002)(186003)(8936002)(2616005)(2906002)(36756003)(66476007)(53546011)(6862004)(6506007)(4326008)(66946007)(66556008)(8676002)(41300700001)(6512007)(26005)(31696002)(6486002)(478600001)(31686004)(37006003)(86362001)(316002)(6636002)(82960400001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MXpvZ0dOenFIR1hlM2gvVUtIOXRlbGFucTNTdkpOaTVuYWtUM29hWjRKUVpC?=
 =?utf-8?B?VGtBMTlZaXNEbVNGQzVwSGJnbmFrc2FJZ29RZW91NVdNK0Izc1dnY3JWTWZK?=
 =?utf-8?B?VnB6T2g2dmpQMlhlNmJkR053bmRSUUMrZy9jeFV2M2VmdlBQUXdZTlBhRStj?=
 =?utf-8?B?a0hDb1hNZTBBYXVaWWxvM3B0Q2hJUUhBUmVjRnpFUkZBK1IrWW9rZEN4eUx4?=
 =?utf-8?B?Z0lVb1d2RCtyaHpTcXViUE9Fd2haSUJaSFZUY0RaR3NjZUkxQ3gzRnoraXdT?=
 =?utf-8?B?dHBJMFV6ZlJ0VEdrODE5K1BZR3hNQnFNZ1JPV1ZqWjN0bCtoV0NkNnpxZlZX?=
 =?utf-8?B?QVdKMU5DTzZPazBnSERtaTczbW9uMmEvcEJFMXlnMzFJOHozNU8vU0ZZNEV0?=
 =?utf-8?B?V1JTd3NzUGJjdzFsTXA5ak9KcmtTQnBKMXhHSlZheG5qMFRnNndzanRWVklU?=
 =?utf-8?B?VjJWU1d3dnlVczNyWnhKbUFWM3h6My9CQ1UxakovVElnbkN2ZCtVdFhrVFA4?=
 =?utf-8?B?d3BOVlVSejFYMGoxdGxHaCtwaVZvNDRiVnN3ek4vY1cwK1ZDQkx2am5nUjRv?=
 =?utf-8?B?QTVYcldiNXdKcHdmclZPNVBvUTVjZnJrSjFGK2hSUE9hTlk5TFFkaEI3NlZr?=
 =?utf-8?B?SXA3bUpUb0xmanA3SVhEM0orMFJvS05rMCttbEpCVnZHbS9mTjlCN2dLZzND?=
 =?utf-8?B?WnJnbkJ0KzVHVG1JM3g3K1NmVDZzc05RL0JNa2VQWm1OMzdZajAwaGF4Mlcv?=
 =?utf-8?B?bXZUQ2hacWxnT2NMSGxRK01WREQyM0ZicjZsd092UUtJTG5USDBHUWtZMEhH?=
 =?utf-8?B?SXE5bjQ2T2s3d1hBSGs2VStlVWdFRzRNRUtVZCsxa2QrSm5HS1MyTDRYVnhM?=
 =?utf-8?B?ZnFTVC9wT1JidW5RSk1rZlh5RlFVcURKeUQ1ejJFT0VsajBQekd6Z3M4Q2N6?=
 =?utf-8?B?QWxaTDhWTDR2bERZbDI4WUREWkV4Wm5IQmEyQys1WDNoTVAzWlRpQ3BQVGU3?=
 =?utf-8?B?QWNrWUgxK3RTTnlzT0ZWN1BQYmsydEpVYzRVS2prd3NmZWNtUGdLM0xnTTZo?=
 =?utf-8?B?ZTRUdzN6djdvSENtTW0wa2ZML0I3NlBsZ3VPM1pyZ25JcXlhYWhzR1QyRXR1?=
 =?utf-8?B?R2xQUG1qQWt6Rm1sbkIxZUpsVVRUTW1DN0swVXJYZko1aktZN2Fvb3NPVzRG?=
 =?utf-8?B?Nk1kM1ZqYkQvcFBVd0FhM2tJSitWK0pBeTNFeFo3UmphaVhDZWlKWU5tbVVZ?=
 =?utf-8?B?em5qMG1MQzJ5cTl4YStVbmlDTjVmb3dhRnlhbWE4T3g5eG4vVVdHTWtQblhz?=
 =?utf-8?B?TVBna0tPVnVrbnJZN3czLzRrMFJwYkxjaVExUXYyZ3pDTitmZHl4YjJYRCtq?=
 =?utf-8?B?d0kzTjRhdUNJSlJiRUJhcyt5OWtjRDhWMW9kaFRDb1J1VDBGVy9GSEN0dnc5?=
 =?utf-8?B?VkxqTFAxaTJFUU1zQzF2NTNLdzYwbkltSnVLUXd3QlAzWFQ2UDIyYjlzbkt2?=
 =?utf-8?B?dVlhdkdBa2RHb1U3ZVJuT2liSExqckJMYkh2ZDZBQkh4K1ozRHo2dThxSHds?=
 =?utf-8?B?cFFJZVlHL29uRDlDVnJUajlZR0RCdDkwM3VCSWNZRm51NHlYbUJSK21yZ0dX?=
 =?utf-8?B?NHpYQkFoM0k0K0pSd0pQdFdJd3FNNzI3ZFdwZkgyemhhWXFiMmpIeXo4dkNX?=
 =?utf-8?B?bDFyOTFtQXJYWDErTnhXeGlkMGdwYnBITmZHOUJZN0gvcjNwc0tiTjBxdVE0?=
 =?utf-8?B?WkJCd0dMSTYxZEdxUUlOUkh5Y1RBa2JtS1pwR200aUZiVkRhV2pSaWlaTTJS?=
 =?utf-8?B?MWhyeXU4Umgxc1FUYm9MOWVpVm9jbmVJaWU5YU9nYThmcTZtMVY3K2xBSmJK?=
 =?utf-8?B?OVlnRlFERnFnTTFvMzJiWE84bEFSQVRqbzZhK1MwUEYyc1hldTgrZENGRlh0?=
 =?utf-8?B?UkRPOXowc1dLOWYxRHVWeUsxMUdJRFVTeURpMHc2aVEwb1Z6ZWNVMFBKRnpR?=
 =?utf-8?B?cnZlWDdOcFZWWW9zSlgycGdGUU5KN1g4ZlZkZ1p6RWFpeU82U2xsSFREeEV4?=
 =?utf-8?B?cHJGTFBOSW1zdWNwa2hld1NJR1hXaUREd1ZPWEdvRnh4by91RnBpcVdrR0pk?=
 =?utf-8?B?Rkx4cVorcllzdzdMcmppdUhPZEY2QVhKU3IzRmpNUGZiWGcxRHNoY0xFdTc2?=
 =?utf-8?B?ZVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6701a17a-65c5-42d1-7cf8-08dab621afb7
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3768.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2022 00:41:42.6278
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QLMEhklCQSU+dQ0Zz5hHG97iIHX9pHPPsYxdgjyHqyAlwEn5oYWeXUcnpOTlXWJKngXg+lebk4qk6wLTOH79mw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5484
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/24/2022 4:50 PM, Sohil Mehta wrote:
> On 10/21/2022 1:34 PM, Jithu Joseph wrote:
>> Existing implementation loads IFS test image during the driver
>> init flow.
>>
>> Dropping test image loading from the init path improves
>> module load time.
>>
>> Prior to starting IFS tests, the user has to load one of
>> the IFS test images by writing to the current_batch sysfs file.
>>
> 
> The kernel is still unaware of the 'current_batch' sysfs file. It will be introduced in patch 12. You can avoid the reference here.

ok will remove the current_batch reference and mention that user has to explicitly load test images

> 
>> Removing IFS test image  loading during init also allows us to
>> make ifs_sem static as it is used only within sysfs.c.
>>
> 
> Does something like this sound better?
> 
> IFS test image is unnecessarily loaded during driver initialization. The user has to load one when starting the tests.
> 
> Drop image loading during ifs_init() and improve module load time. As a consequence, make ifs_sem static as it is only used within sysfs.c

Will adopt this, Thanks

> 
>> diff --git a/drivers/platform/x86/intel/ifs/core.c b/drivers/platform/x86/intel/ifs/core.c
>> index 27204e3d674d..5fb7f655c291 100644
>> --- a/drivers/platform/x86/intel/ifs/core.c
>> +++ b/drivers/platform/x86/intel/ifs/core.c
>> @@ -51,12 +51,8 @@ static int __init ifs_init(void)
>>       ifs_device.misc.groups = ifs_get_groups();
>>         if ((msrval & BIT(ifs_device.data.integrity_cap_bit)) &&
> 
> Is there a reason to store the integrity cap constant in the device.data global structure?
> 
> .data = {
>     .integrity_cap_bit = MSR_INTEGRITY_CAPS_PERIODIC_BIST_BIT,
> },

This was originally added so that, when future additional tests are supported by the driver, support can be checked using  the same if ((msrval & BIT(ifs_device.data.integrity_cap_bit)
Different tests would have different integrity_cap_bit assigned in the ifs_device[] array  (today it is just a single element and not an array

Note that the current series doesn't introduce this



Jithu
