Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CA2A666887
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 02:43:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235969AbjALBnb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 20:43:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234628AbjALBn2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 20:43:28 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CAD539F88
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 17:43:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673487807; x=1705023807;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=U3Ez1C1rDRv6RrUrkPrHeD2WlGg/w/+tzDkg/K4h2vY=;
  b=W6eY0GQCRjnmWiW8L/iXbz7leGVwkHt0mgk5mvhqf784o0errvOfYW0K
   uQ/RFIDXM6Qs01tYYfbV4HKzSTVPMy/AFxq5VYU5qoXu/mnYFhTYbTtpu
   W6TtnRNKcpmDIVfch7C6aNjacjxWDO8a9Drm3TsoABpmFUbZZOqUYlQX7
   IuCPhS3b7w1haPnyrsiCfjRHCS+zmEx52fs63jz0j0FYEWMBu4sNKrxcX
   SbQ+b601j4YlZF1Kq4rPnj3LPwiqD+5IEXGT5ru+lCqnV2gTKcwa9Fb3v
   KXCFO7Zb/s7czMlq5T5NiyVSx95smYvh0t0pt4ZZKqAWmXWi62Tbm/Zpn
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="307107912"
X-IronPort-AV: E=Sophos;i="5.96,318,1665471600"; 
   d="scan'208";a="307107912"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2023 17:43:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="800035071"
X-IronPort-AV: E=Sophos;i="5.96,318,1665471600"; 
   d="scan'208";a="800035071"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga001.fm.intel.com with ESMTP; 11 Jan 2023 17:43:26 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 11 Jan 2023 17:43:25 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 11 Jan 2023 17:43:25 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 11 Jan 2023 17:43:25 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 11 Jan 2023 17:43:24 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PbjfokMWiN6PsqOzpxfnh5FwZvmHiTsXO5aHwd3xvTBIpjSCUimhvNarVkozE7bqVyM85CFMfwIhS23gLTSOAEiJ/0qq+9VIH90bu8EK8lF9dfL6G6VKj9K2Agf/s7FpdZqoHhfh60qJwOqKrvV5e7lJOcj02+BdRA7V1QdBb/jxUYgY7aDD6CU2Om/m8dGjxRhAxoPRB0tfN4Xa++aYX4irPuRi9OKDhv8dJeNXZi2wgfG0Mnh6M7KNYTKuEiQVkDAikoaVfabldrzBGUeaVZEI01Y0h7bCjY01OHphakKq6NaWim6P3GCzk4HmToTTBT1cek/BA+doLNOQiFX0LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ExON+H/h38088MrscGCmykXbq4k3fv87OgOwkfsebCI=;
 b=f4J9OFX/IwCzn5Xg+oJyLdihq/5bs2n1W8SOGgBpLJ2fMt56kLTBMHTuIdP+fTCWBF/XV37mjzYZJ/d2BvSqreXRumvJRlAHcPbWiVSjSgctAcsrvDyYLCvAVYLv2VWQkmP/l7eXND8eIVcLxZBVFGPq8zVGhW1S9YB0LQFvX2ggyNcGxWQMbM51M/L0zKDQ3xfSZKBV6M8hc8ET0/dWJq7y1SyUTUhA86TK1kefT3VVl7g/3nzVz5rLOa71/5Nrz4YyLUIUrn5MQO/pP4vEsksZ5epLhB481EQ2oaHX5lwyr3MBUnECoEjqjV7fs3ON8wIbAfh5qokWyXn3KsFRnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB5262.namprd11.prod.outlook.com (2603:10b6:5:389::10)
 by SN7PR11MB7017.namprd11.prod.outlook.com (2603:10b6:806:2ac::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Thu, 12 Jan
 2023 01:43:21 +0000
Received: from DM4PR11MB5262.namprd11.prod.outlook.com
 ([fe80::1fe5:3ce9:9a3a:7de7]) by DM4PR11MB5262.namprd11.prod.outlook.com
 ([fe80::1fe5:3ce9:9a3a:7de7%4]) with mapi id 15.20.5986.018; Thu, 12 Jan 2023
 01:43:21 +0000
Message-ID: <adf3a609-656f-82a2-6a4e-199a12de298b@intel.com>
Date:   Wed, 11 Jan 2023 17:43:18 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.6.1
Subject: Re: [PATCH 4/7] x86/vsyscall: Setup vsyscall to compromise LASS
 protection
Content-Language: en-US
To:     Sohil Mehta <sohil.mehta@intel.com>,
        <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ravi Shankar <ravi.v.shankar@intel.com>,
        "Tony Luck" <tony.luck@intel.com>, Paul Lai <paul.c.lai@intel.com>
References: <20230110055204.3227669-1-yian.chen@intel.com>
 <20230110055204.3227669-5-yian.chen@intel.com>
 <c2012105-0af6-6720-5a24-719dec775fed@intel.com>
From:   "Chen, Yian" <yian.chen@intel.com>
In-Reply-To: <c2012105-0af6-6720-5a24-719dec775fed@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0360.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::35) To DM4PR11MB5262.namprd11.prod.outlook.com
 (2603:10b6:5:389::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB5262:EE_|SN7PR11MB7017:EE_
X-MS-Office365-Filtering-Correlation-Id: 577fc941-6007-4194-5b41-08daf43e62d3
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SDTh9+Darh3jb/9STVlw5HtZYS4+B9G9+igg2dGrGTIGD3rwVV51yw5kG2yeo5V+yIvALlQsIGXr7uShoZusnv18NsxhlOH1AziIS4tFzWL6THsL1MjbU0DT1lIXcB3LWtZ7yXJUF/f8RRmBtx0ESavmmCv4Eh4MXUMThHMahGSPCEekzdBc5rHf5WZIFtdKau6KYCprOwsifVJSjNTo3XkZpqpFXrVRvOlPqPLtJCzS+8EtysMm01G7nOd1joJAjN7yCGqfbBnKz9z3kbkrV0ZOMZYobZmTprt73KCcX1Wnx8Hg5l4LO9EtKqxUWwnfcFTUXxuOhdIi2kzpvOf4+sGMD9yKmOj6egE0ZLsuYEXYyMIijvxVRUrNjMadY2vQaPCoT7w/+hWtQSN2hOnIyl4HJ79ZamliYmUTWN2m8u0LwxPs8+7nPtWRF+uoc6KcVO0xmCKu0GvybkAb3kv6QPFqRr5HFC1JHTr1rbHbLdCcHmqSMkDZtTQVlTcoB5PiKZ5b4Qm6vRKshmlErzoVL2iKRAv30BNwnuzQEf6+VqdjRi4nmL3+6CYlISO3MpC5VHAtx0AqPkDZpEXw1s6m2v4oFVgWE7FtCZbY3lLrt7tsh15qBmknOctJ3du0HULqGjObUf4dFU5QRB1jqwsz7WCGeIIVuczvjb657iTu6fKYElWbX0TJxQt8dcIBZ2KrXai9WDBxMImyGSsH9bh/i1NWqt7RsVTilP9nqdcGujk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5262.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(39860400002)(136003)(346002)(396003)(366004)(451199015)(66476007)(41300700001)(31686004)(66556008)(66946007)(8676002)(5660300002)(82960400001)(110136005)(6636002)(8936002)(316002)(2906002)(86362001)(38100700002)(6486002)(478600001)(36756003)(6666004)(186003)(26005)(31696002)(53546011)(6506007)(2616005)(6512007)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WVFCbzF1V2NKZ3hGMlZ5cGRFNjBGcjhBODhVWjhwUFlUSWJlVzFyS1J0OGZx?=
 =?utf-8?B?ZDNSZXF0OEVmTnJzYlRRc0JTR21wU251MUtXck1ZbHl5VmNHWEo2S0tveEVn?=
 =?utf-8?B?KzBGVmdBZ2hSTVVwQ21tU0RjTFExWW9PQ0JTL1gzSkk3MWhDYS9CaEZqOG9s?=
 =?utf-8?B?eFN5dUpGYzliK3h6MURyZmRVNmxGRjZLZStvd2s2RDZVQ0dMVUVNdDloTmRy?=
 =?utf-8?B?SXh5bVNsVVVxUVdJbFdRanNmWEpwcHVleHZsM25jZ2RNbys2YWUwODVPODRT?=
 =?utf-8?B?c3ZoWkltUS9DVDJORXo1NDV0a0lKblpyNDhwNFRDMnVuczZQemI0N0ZOM2hp?=
 =?utf-8?B?czhKYkx4YVI1M3ZnSHVCU29BbkUyZ2V1YXhvSklzQUphYVBoSWNLbHNZUFlX?=
 =?utf-8?B?bXA0aU11UmZzRnpKRlZ3M2ptOUFabXhtR28yTThsU3ltdTlKcU9BMm9GbHRv?=
 =?utf-8?B?SVpNV1RwdFd1STRmM3ZxMWxVSzJJWVJsTlJYVktHa1R4YXEzYWo5TjkwZ0dX?=
 =?utf-8?B?NVNJbkNObUdrQm5HTm1xaEZYVWlURnp5UUNnbVh2d3dTWXNvSnRSMWdiR1k1?=
 =?utf-8?B?ejAvdFV1d1pFMW9JMTZaaWlVTkM4UjY3K0N5UGMxdnY1M0lLSEZvemtiV3ps?=
 =?utf-8?B?VGFkV1NIZWJKQzlxL3RTK0EvMTRQd2drQkd2RWZVNmVwaENPOE9NZVR0dnZU?=
 =?utf-8?B?ZmRpYlVGNXFHeU5pTnQzZWZRREptM0cvRFhQb0dsVWx6WDQ0OFBYOUVWU3pG?=
 =?utf-8?B?elBDa1N0TmZZSDVNeWVVQ2lWTFJGb0ZOTy80aHlPdDhaZE9MdjAxSzJIbWdB?=
 =?utf-8?B?eTVpbFpGWnJyNFJVMzVHQ3cwb3dlOVVScDhNNlhTZVdVaFR3MHlXbG05cFZ6?=
 =?utf-8?B?YkdCeCsrbDZxZStrUTYxZ0ZXQkdrYmdtRUp4T1FONG5mNllPVnZiV1BPR01T?=
 =?utf-8?B?OFRHc01JNkUvVVUrNlM4UDNnWU9vNndVdDRiTGIzRWNZT2NQNmY4a3dPdXdo?=
 =?utf-8?B?ejNQSUFPSS81SFp0NXpVRlA2cXNyL3gxc0d6Wlk0ZUVQYlk2RWtJd3FtYXly?=
 =?utf-8?B?eHJJZkhQSEdnVDJ3TXFweFk2WUFjSi9teXRXYncvaE5hUUdXNmduMnFtTDgy?=
 =?utf-8?B?S1p0K080WWtSS2hoanJvZmVBRy9WRkplSUdYOWVXL2FOUjFMcEt1NGtWckVK?=
 =?utf-8?B?SjdOUlJpZjhSR2xRbU1wNGl4MmFxRERzakNtZXFRZ0FHeGN1RVMzRmdPdS9Z?=
 =?utf-8?B?Z2hBaHFoM1BkWWgzMGtEb3IxVnhrdTF4ZnZkQ2pBZUdFTUVSMTlvZmI2NmpV?=
 =?utf-8?B?VmViQWtzQVRubWJwTjdiUSsvbEx0TzB5MUhuN3d4Mkpaay92aGJabEloTFFR?=
 =?utf-8?B?UjVXZXltazRJOFJKelIzcmVYOENtd0p2U2l2YXpuKzMwTExuN050eUtLVk1i?=
 =?utf-8?B?alI4YURralh0VDdWVnpCc1Y4dTZWTXpObXJFYXhMMDVkdGFiMUM5K3hxd3NJ?=
 =?utf-8?B?MmNzM0xxNkJDTi9GZW11Y0FSQWIwK2s2bHF6aHRjNlhkSUIxR1d6dGJYWG9V?=
 =?utf-8?B?d1Y3WEdDcnI4c3FOc1ZkdGFuL2NMUDJ0YVE1Wmx1TjU5TUY2V2xaTGJlQU8r?=
 =?utf-8?B?T0ZSVXJULzFMTjFaN2Rsb0p6TFZ2RUlVejFxQUIwQnZvS2lKRDBBNHJUY3VH?=
 =?utf-8?B?RSs5U2hTUUNkVFA4Y2N4K2tDdjNMTUt4cDR5QWthQ3kwc1FFU0VSMXdVZmEw?=
 =?utf-8?B?TTZwMzJCOG13YUt4T0hCNTlKZjQ1RCtibFJhdi8xaG1yS0x3dlNiMlQwL3Vp?=
 =?utf-8?B?Z2RxZFlxRCt0QzNvK1RDWjNTWk9xUkhvVDJaeHV4elEyZ0dua3A5YVY1KzZu?=
 =?utf-8?B?bWlEemJ0YWxUektSdUZneDRNREFTRDJzQTQwNWdtMC9jeU82TGVsQmhTcmI1?=
 =?utf-8?B?clVBRnRnVjFIQmRkeGtUbFRCamY3Z0ZMSUhNeFZjQ3huVlV6Y3A5am81SnpH?=
 =?utf-8?B?L2hYS0VpNVp0cTI4YU4xd2YvVU1sWjN3dHllVGpiYTRNZHgvMmxCeWJKdDBR?=
 =?utf-8?B?UTJGS3pyc092bXB2VzFGbDdwOFJidlp0WVpoazI4U3dOS2JMaGczNEQ2VUZU?=
 =?utf-8?Q?OY6tzhrhNT9wSJuxiRj8Tmi33?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 577fc941-6007-4194-5b41-08daf43e62d3
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5262.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2023 01:43:21.0622
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RbcVFAlrRH2tabmQlj6uZnaglEV5MKXHqPBn4CnAkOlAOR1cMgFIW7BIhgh5tzXrndEMOs9vIX+ghFTsuu0imQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7017
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/10/2023 4:34 PM, Sohil Mehta wrote:
> On 1/9/2023 9:52 PM, Yian Chen wrote:
> 
>> The user can also opt-out LASS in config file to build kernel
>> binary.
> 
> This line is unnecessary.
> 
Sure, this line can be dropped.

>> Signed-off-by: Yian Chen <yian.chen@intel.com>
>> Reviewed-by: Tony Luck <tony.luck@intel.com>
>> ---
>>   Documentation/admin-guide/kernel-parameters.txt | 12 ++++++++----
>>   arch/x86/entry/vsyscall/vsyscall_64.c           | 14 ++++++++++++++
>>   2 files changed, 22 insertions(+), 4 deletions(-)
>>
>> diff --git a/Documentation/admin-guide/kernel-parameters.txt 
>> b/Documentation/admin-guide/kernel-parameters.txt
>> index 6cfa6e3996cf..3988e0c8c175 100644
>> --- a/Documentation/admin-guide/kernel-parameters.txt
>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>> @@ -6755,10 +6755,14 @@
>>               versions of glibc use these calls.  Because these
>>               functions are at fixed addresses, they make nice
>>               targets for exploits that can control RIP.
>> -
>> -            emulate     [default] Vsyscalls turn into traps and are
>> -                        emulated reasonably safely.  The vsyscall
>> -                    page is readable.
> 
> The existing documentation here is incorrect. The default vsyscall mode 
> is actually xonly. This has been so since:
> commit 625b7b7f79c6 (x86/vsyscall: Change the default vsyscall mode to 
> xonly)
>
Yes, you are right. but this patch can overwrite and correct existing 
one. I am assuming we don't need to correct the existing document first 
before update it for LASS.

>> +            In newer versions of Intel platforms that come with
> 
> Words such as "newer" in the kernel start losing meaning very quickly. 
> Also, this comment looks out of place in between the vsyscall sub-options.
> 
>> +            LASS(Linear Address Space separation) protection,
>> +            vsyscall is disabled by default. Enabling vsyscall
>> +            via the parameter overrides LASS protection.
>> +
Sure, I will take out this part change.
> 
> 
> IIUC, you are making the default mode somewhat dynamic.
> 
> vsyscall = xonly (if LASS is not enabled)
> vsyscall = none (if LASS is enabled)
> 
Yes, this looks better.

> The decision to disable vsyscall doesn't happen at compile time but it 
> is taken at runtime when the LASS feature is detected. This would make 
> the system behavior highly platform dependent.
> 
> Instead of doing this dance, can we provide a simplified behavior to the 
> user/admin and move the decision making to compile time?
> 
Current strategy is to disable vsyscall by default only for LASS capable 
platforms. So that the dynamic decision is likely a necessary.

> Option 1: A bigger hammer
> Set the default vsyscall option as CONFIG_LEGACY_VSYSCALL_NONE. 
> CONFIG_X86_LASS is set by default. Changing the compile time VSYSCALL 
> option would disable LASS.
>
This means to disable vsyscall by default for all platforms, doen't 
matter LASS. I am not sure if we want to go that far.

> Option 2: A smaller hammer
> CONFIG_X86_LASS is off by default. Vsyscall default stays as 
> CONFIG_LEGACY_VSYSCALL_XONLY. Selecting LASS automatically chooses 
> CONFIG_LEGACY_VSYSCALL_NONE. In this case, even if the hardware doesn't 
> support LASS, vsyscall would still remain disabled.
> 
This turns out to disable LASS by default. Then the LASS may not be 
taken in the first place.

> In both of these cases, any command line input to override the vsyscall 
> behavior can disable LASS as well.
> 
> 
>> +            emulate     [default if not LASS capable] Vsyscalls
>> +                    turn into traps and are emulated reasonably
>> +                    safely.  The vsyscall page is readable.
>>               xonly       Vsyscalls turn into traps and are
>>                           emulated reasonably safely.  The vsyscall
>> diff --git a/arch/x86/entry/vsyscall/vsyscall_64.c 
>> b/arch/x86/entry/vsyscall/vsyscall_64.c
>> index 4af81df133ee..2691f26835d1 100644
>> --- a/arch/x86/entry/vsyscall/vsyscall_64.c
>> +++ b/arch/x86/entry/vsyscall/vsyscall_64.c
>> @@ -63,6 +63,12 @@ static int __init vsyscall_setup(char *str)
>>           else
>>               return -EINVAL;
>> +        if (cpu_feature_enabled(X86_FEATURE_LASS) &&
>> +            vsyscall_mode != NONE) {
>> +            setup_clear_cpu_cap(X86_FEATURE_LASS);
>> +            pr_warn("LASS disabled by command line enabling 
>> vsyscall\n");
> 
> A warning seems too drastic here. A pr_info() should probably suffice.
> 
sure I will modify it to use pr_info.

>> +        }
>> +
>>           return 0;
>>       }
>> @@ -379,6 +385,14 @@ void __init map_vsyscall(void)
>>       extern char __vsyscall_page;
>>       unsigned long physaddr_vsyscall = __pa_symbol(&__vsyscall_page);
>> +    /*
>> +     * When LASS is on, vsyscall triggers a #GP fault,
>> +     * so that force vsyscall_mode to NONE.
>> +     */
> 
> This comment doesn't make much sense nor does it provide the full 
> picture. Some of the reasoning from the cover letter/commit log can be 
> duplicated here.
> 
sure, How about a more detail inline comment as following:
+	/*
+        * When LASS protection is on, user space vsyscall triggers
+        * a #GP fault since the vsyscall page is
+        * 0xffffffffff600000-0xffffffffff601000,
+	 * so that force vsyscall_mode to NONE and disable this mapping.
+	 */

>> +    if (cpu_feature_enabled(X86_FEATURE_LASS)) {
>> +        vsyscall_mode = NONE;
>> +        return;
>> +    }
>>       /*
>>        * For full emulation, the page needs to exist for real.  In
>>        * execute-only mode, there is no PTE at all backing the vsyscall
> 
Thanks,
Yian

