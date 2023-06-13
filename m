Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F64872DEA3
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 12:00:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239060AbjFMJ7j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 05:59:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242119AbjFMJ7F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 05:59:05 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6AF91726;
        Tue, 13 Jun 2023 02:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686650332; x=1718186332;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=9R5LBd3L4b+dJfw5mKqgp54lmUhvQyvD8/JkBFBQgt0=;
  b=h+15f9fyQtNyG4mbo92/FM4Xn1iuiU2w26fg179piOb2zPmvMsiPxoJD
   9GXJ83zTmTscYcR+qpcvqe/HWdo9ttIHwZ5BYif2Mrydsmh18GOYqmBsp
   cTbKS5glKT9lqGa7koU87+tTnRrlfjtq30tJAMpkV8FgUjgkfDKrz0ni4
   B8qB9bHV2KbAUxyy75eRg7nxOruc+9o9YRsCHbo0mKgJiC2hqbZcRk9ol
   WXNyUF5hwfxSeG+IwexltOtBe3ZI/dxmNxuYbZGdLJ2vUWAkP54nxbSR2
   i0kFg2K5AWMR0j4Z0IKcoxLAb9ib9F1s0wSGrcRSKYdAxAh9NNaLEvQzF
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="386679329"
X-IronPort-AV: E=Sophos;i="6.00,239,1681196400"; 
   d="scan'208";a="386679329"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2023 02:57:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="705747952"
X-IronPort-AV: E=Sophos;i="6.00,239,1681196400"; 
   d="scan'208";a="705747952"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga007.jf.intel.com with ESMTP; 13 Jun 2023 02:57:53 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 13 Jun 2023 02:57:53 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 13 Jun 2023 02:57:53 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Tue, 13 Jun 2023 02:57:53 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.106)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Tue, 13 Jun 2023 02:57:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GMLpLBfV+5Xzf/owo+FtORDtrQ9/viEO2PZiSmu4MyZbiWCIkXIhCuC8admJWS81OmppuyN+obbvKr6BrBk+jhB3lyAH9Mj0H7dTqRxwsrUSqNH9O58ERFrIJr1aVJyJlgde2iNUP0zsYozwUoXXULDI5qwC6YkPeM94j4S6sTEiKtBfOjthd8mHkB7ARAdmZ6mM6rFwmnsYfZgPXGIO/aQnyH0O5U9b0r4yNoL0DVE4WCRbBY5x/M+UV6b+GFzVy/5g+A4iRD57L73l3AKbPj5Z3mf7xE/scIySXiPrAcTIjfVe8aoEm2N4yxpz7B7QLyfOUbCea0ogJ/6ZGy/uMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nCJ2p9DhY0MjtoOZsUnPJSxvndoAUJWzC6PhvYbK31o=;
 b=SbyjT3HHh5RVmKHcH7amY8DLzY7M0/kG7zG5SytZ5Z/C3t9k7geCsDA/GQIJv0naLIdSCqmaWpfInz05eY1OHeTitadOYMMo5IeRg08LEIGIWvzUKsrHOTaGERyDzdudQn9ZiETLegHiVO2EUry0yVNN5M4iKNCEn8MiHmT+buii3Cywou+0p2v7E0T1Eu4W704qW2E7PVWmatDytCFdIM5YTmbQ3ITWa0J75RKpJjh0fh0bX4E1oSfMOobXsHtLb41Zomxu5vMGM/jvWuYohLIH2d1CruBVx98w9ES9T2e10wOeZHaUV0Ax+n04CwZKxOgWbaRLJrkqkCtn6YiUGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO6PR11MB5603.namprd11.prod.outlook.com (2603:10b6:5:35c::12)
 by DM4PR11MB7351.namprd11.prod.outlook.com (2603:10b6:8:104::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Tue, 13 Jun
 2023 09:57:51 +0000
Received: from CO6PR11MB5603.namprd11.prod.outlook.com
 ([fe80::4287:6d31:8c78:de92]) by CO6PR11MB5603.namprd11.prod.outlook.com
 ([fe80::4287:6d31:8c78:de92%6]) with mapi id 15.20.6455.039; Tue, 13 Jun 2023
 09:57:50 +0000
Message-ID: <5dde33b8-75ee-3de4-d694-d5700b9cc0a6@intel.com>
Date:   Tue, 13 Jun 2023 11:57:43 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v1] platform/x86/dell/dell-rbtn: Fix resources leaking on
 error path
Content-Language: en-US
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC:     <linux-acpi@vger.kernel.org>, <rafael@kernel.org>,
        <andriy.shevchenko@intel.com>, <pali@kernel.org>,
        <hdegoede@redhat.com>, <markgross@kernel.org>,
        <fengguang.wu@intel.com>, <dvhart@linux.intel.com>,
        <platform-driver-x86@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20230612090250.1417940-1-michal.wilczynski@intel.com>
 <27dfd35-1d9d-b52f-ee7-1a5b9b25794@linux.intel.com>
From:   "Wilczynski, Michal" <michal.wilczynski@intel.com>
In-Reply-To: <27dfd35-1d9d-b52f-ee7-1a5b9b25794@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0029.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1c::22) To CO6PR11MB5603.namprd11.prod.outlook.com
 (2603:10b6:5:35c::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR11MB5603:EE_|DM4PR11MB7351:EE_
X-MS-Office365-Filtering-Correlation-Id: cf25fdb7-7774-4db0-8b79-08db6bf4a5ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z44JZAQX2IpGTlfqftpIq04wa8FG6uqNE6DbX/rM0gXffZvm/k4+fXG+k9N1oOqvUB0mXJV8Ad6rf+qbK+9WMLaW7YgMV3NlXu1Aw5uonDF5yYX8LBQqRei+bGnVSCZ0a0u8UmbFh3DPMABFX62qhRhQd2ML9+L/ReR4QtxWjNQmMs7jc4wNoVUVKis/sDXMSbn60zX8R4iqi86AmTiDlN0A6TDlLJ7uu3kzlhhvG+QYpsi75MP2LXC635ksvzpKSscpA2EZPMxcVkotjPE8Gg55TJ49LHKOB0AtwVHOJAj/WGUXc2jugh0sl7qgAcpenBWMzEfDiDZTUB+acH/PMhQSsiK44ZMG/TSEMdCyxpOGPi4WxEltAywAyJIoaxBlcUwNiOMqJ26mc4OBO+vAhPJP1+bFtR86vEXhitxvMybzfuvfZN77YfdbT2i8OLeRXbA4AlXxw1s7WA3z+67XKsW3fr3VKX7j1olKTdhqJR/KRPTJf9iewhdW7lUmdd9RrCn5Osxn7xtJ1am+NKx6F3Cir2DQXnNEd9rNtuG0nY+QD2cXKLYjIz0mI25APggr8UaxEcCyVXNRna7bxx6g4IHgKG7jKozdulDY/Sl1h6M4hBYib4sXFTwCRXqOfvsUNvhxMTef5walJxQflXQz+Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(346002)(366004)(396003)(136003)(39860400002)(451199021)(6506007)(53546011)(6512007)(38100700002)(2616005)(41300700001)(6666004)(31686004)(6486002)(26005)(83380400001)(66574015)(186003)(82960400001)(478600001)(6916009)(66476007)(66556008)(316002)(5660300002)(8936002)(4326008)(8676002)(66946007)(86362001)(2906002)(36756003)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Sk9NMVpnOWtZUDkxQXIwQXk3bnlpTWs1UytjNWJwekxpNC9qb3lWT3puZ0dY?=
 =?utf-8?B?R0ZsNlR2L1pNZEF5OFNuRXkxNzRvSk5YT3E1SGZlYnc1emF6QUVNR3RkSld6?=
 =?utf-8?B?SnpsaEFnN2tKcFZYVFRsb0FHZGphTEx3bXNtZGpFZjc3aHlQeVM0Y2ppSkRn?=
 =?utf-8?B?N2lRcS9zY083Nnh0R0NoNkJjbURoY1BCTVdKeFpsMit6WXVGbVVBVUV4cmw1?=
 =?utf-8?B?VElUT04ybUc2L09qQnJvekUzNGlFVjFuMDlIQkRSNW1TRzJGQW8xUHZ5NUM5?=
 =?utf-8?B?YmdrRWczc2lHYWxVWXIyWDFjUUNLeFByakJidjZ2cnc4Zkh5TnA3MnhoT0lD?=
 =?utf-8?B?NnVQTjFFa3RnaG5hMWdzOC80UGw1bXgreHJHSVRRQkJaWTI1bmdRQTdNeVNZ?=
 =?utf-8?B?Q1d5NkxwcUYyU2tUdTRWTXFlaXFkL2VqS3hPZ1ZFOXBWQkM0UTVhTUUyOEk5?=
 =?utf-8?B?VGprbVFsdVlhS3R1RVVkN3FMZGVTcTFjcGVLR29iZjRkM24yWGFPbE9PVE9N?=
 =?utf-8?B?Vy9GcUNkaGlxc2lxLy9wSkRreXE4Zmw1ci94Rk9GeVczcHRhWVR1cmVuMEV6?=
 =?utf-8?B?dGZ1SWFRSmNrMzI1bElNY0g2V2RaSzV3V2swVjVNMXhZQ1Bic0NDNHhCc1pz?=
 =?utf-8?B?eHp6QXFISUhNTmxpVmw1QXpMclR5bStkTTU0Yzg2dEQzc1JWUTIyUmM0cjdF?=
 =?utf-8?B?c1hvNGVISTFrUFI3MDI0a1FtQjc3ZTUrdW1pVS85em5vazEyUDFxY0pqdEtR?=
 =?utf-8?B?SFp6azNXemZZS25oMksyOXFESDVOMXBjTmFZSXRmMVhuQkMyTjdxSjZVZGgv?=
 =?utf-8?B?REdvejc2aitFNnJOUk9hUFB2eW1CM2tpdmw4c0JEZVNxTmJiRk81MUk2c0lI?=
 =?utf-8?B?Y1V0ekREQ05SNlBGZFlaZEtZK3hHblFJNlVyUmxkQ2J0VUFMaHJWQmJ0UTdD?=
 =?utf-8?B?T3Z1QVluVVpkZkpZUmZCdU15R254RU9HdnhoR0ZnZjE0NlFjZGlwSXZtekV2?=
 =?utf-8?B?bFZSQVZqTzk2aFNxNVNxK2hWNG56WS9NdUJIc0VJeHhnRWFwYlNvUkpEYWVL?=
 =?utf-8?B?ZWhwWnMwUHh2UUt0aG9vWC9ua3lNQ2dPTThicEhUaTcvTEMvU0puSW5GNGhU?=
 =?utf-8?B?dHg4NWg1M2lOYlZUb2F2aFZWRkRYbG1DcVFLOUlLTzRxU3kzRGxXMWorNmRo?=
 =?utf-8?B?ejFXVHhWeVY3UlJpem1zRGUxNnJUdFdPVHd3eXBiUmtXQ2tLYmg0REpJcm9G?=
 =?utf-8?B?a21MSGp4RjRJc0J1NmZ3QzUremFEYXFHWFBaSDFOUDZ1WDU3Q1VmUXlmWEJE?=
 =?utf-8?B?TTF4UlhHWWEzc1RlcC9yVkNqdDdPQ0QrQkJzTC9OQ1h1NDBzSkF4dFNwcEFs?=
 =?utf-8?B?NUlTd3BoeWxOY1RsWG9nZGpFcENkN2IzeGFBZ1RibGVpMmZWVGowdnV4eUIx?=
 =?utf-8?B?a1d3RVIwSkZLeXhIczlIR0VMcmdGK09NdEllVjR5elRwb0doaGFpOVdWM2pX?=
 =?utf-8?B?ZnlNUXlLekRIQm9ld3VnUloxSEh6SlBhd3Vsc2hGeUg2d21sVFV3eDNINGV2?=
 =?utf-8?B?NkU2aVhUS1BWYkc1eEpFRUdNcXNSWkNwZzB2N3F5QXlXL3RZTUptYWprZThm?=
 =?utf-8?B?Z1VheGxxYktNTTJsMER0cVF6MUx6eXZzaTBPNjZuT1czS0k5TGViaUkvUFA3?=
 =?utf-8?B?Q0FJcVg4UWdMTXJCQkRJRm5SZkxyQUY3TUZwNFVwUWNjaGw4djJGbE8rSUFS?=
 =?utf-8?B?U3ptczdQRzVyZnRUdXEzT1Q5SVRSOU93L3E4dWRVa3cxc3kvKzdpRTRjR0h2?=
 =?utf-8?B?ODJDQUdYcWZHMHdwV0tDQWtNTnZGRjVXcDBEUzY3RHArdlNRMWxNckZOR1Y4?=
 =?utf-8?B?bW5jd1ZreEc1UGkyKzNnYllJM3d6clQrRWdQbGRlcUdTVWdMbmV2WjVRVkVO?=
 =?utf-8?B?c2dmSzFKSVlIK0Q3a3NYOXhiRDdrTnNtVnVhdkJ4TUpidVdKekJaSmtHdGpL?=
 =?utf-8?B?Vml6MU41amo2TXlzZnFldERxZ3NaTCtWak0rZzhQTXdTV1pKRjVSMFZudUJv?=
 =?utf-8?B?bVdsdlEvbVdVZVh4Uk5KVW53Q3BnZTdtbkVzdmY5cHlQUmV5V0RvQ0Iwc3BH?=
 =?utf-8?B?MThnSXZIZ3RSbWNiWGN3U1Y5UUdoaWxnZ05peSsySHM5WmNFbWdFUEc0dWVI?=
 =?utf-8?B?R0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cf25fdb7-7774-4db0-8b79-08db6bf4a5ba
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2023 09:57:50.2462
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5iDBq0C6SwseLfu/JVhq0DGy/7A88qbWHmB0lSE9epb+t/CGfMC9z0GQh/0IZiHCyD4/94JkBcsg73NNwq2XGMkXUXogEyvnj9NB/JbjI+c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7351
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/13/2023 11:28 AM, Ilpo Järvinen wrote:
> On Mon, 12 Jun 2023, Michal Wilczynski wrote:
>
>> Currently rbtn_add() in case of failure is leaking resources. Fix this
>> by adding a proper rollback. While at it, remove unnecessary assignment
>> of NULL to device->driver_data and unnecessary whitespace, plus add a
>> break for the default case in a switch.
>>
>> Suggested-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
>> Fixes: 817a5cdb40c8 ("dell-rbtn: Dell Airplane Mode Switch driver")
>> Signed-off-by: Michal Wilczynski <michal.wilczynski@intel.com>
>> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>> ---
>>  drivers/platform/x86/dell/dell-rbtn.c | 5 +++--
>>  1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/platform/x86/dell/dell-rbtn.c b/drivers/platform/x86/dell/dell-rbtn.c
>> index aa0e6c907494..e9b3f9c3ab7d 100644
>> --- a/drivers/platform/x86/dell/dell-rbtn.c
>> +++ b/drivers/platform/x86/dell/dell-rbtn.c
>> @@ -420,10 +420,12 @@ static int rbtn_add(struct acpi_device *device)
>>  		break;
>>  	default:
>>  		ret = -EINVAL;
>> +		break;
>>  	}
>> +	if (ret)
>> +		rbtn_acquire(device, false);
>>  
>>  	return ret;
>> -
>>  }
>>  
>>  static void rbtn_remove(struct acpi_device *device)
>> @@ -442,7 +444,6 @@ static void rbtn_remove(struct acpi_device *device)
>>  	}
>>  
>>  	rbtn_acquire(device, false);
>> -	device->driver_data = NULL;
>>  }
>>  
>>  static void rbtn_notify(struct acpi_device *device, u32 event)
> I'm a bit worried the stable people might not like "these while at it 
> parts". Those changes too are all good but unrelated to the actual fix so 
> they should appear in their own patches.

Hi, thanks for you input,
Changes seemed really minor and inconsequential, so it seemed to me like it would be an
overkill to create a separate patch for a cosmetic change.


>

