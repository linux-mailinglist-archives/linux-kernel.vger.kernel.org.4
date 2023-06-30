Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 915E9744130
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 19:27:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232982AbjF3R1K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 13:27:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233014AbjF3R1G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 13:27:06 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D41D919A9;
        Fri, 30 Jun 2023 10:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688146024; x=1719682024;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=bpR4/cEsxQbTtH5M2BP2X5m8okdcBOoRCUtqUoM4/ms=;
  b=eB2dJ5rpAsp80/f3xePfyO9zcjVCge3RWb+qTBPSI35RTr9isDRrL1MB
   HzRcU6h3VO6Sy+PafLm+rOXes0bJ8QBD9ddOT5cjBFu3kdaOaU+TYIVqT
   ubaGyR9UOPACNzRu44TOIjX8DfPO+MxzJGqxoYTHzHqSgxkkVixDw/AL7
   8z62EDoYpqeleJmxuRrEBHL2iisNeza5XsSQJgRg6ZNE83faD9/slVS/A
   E/dWCw9lFR9BwiiN2orhr7QlbkV78qrqHuA0QHzwOPfGJmZCLHLMm3hBt
   CO2z0/Je9itURlfO7VAoniXwS2Y+C0FENBGqgE/J+/3p6iKJVYP32l50i
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10757"; a="347229214"
X-IronPort-AV: E=Sophos;i="6.01,171,1684825200"; 
   d="scan'208";a="347229214"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2023 10:27:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10757"; a="668025638"
X-IronPort-AV: E=Sophos;i="6.01,171,1684825200"; 
   d="scan'208";a="668025638"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga003.jf.intel.com with ESMTP; 30 Jun 2023 10:27:00 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 30 Jun 2023 10:27:00 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 30 Jun 2023 10:26:59 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 30 Jun 2023 10:26:59 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.107)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 30 Jun 2023 10:26:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xe9tlgLWxRcCzxV+rcQ5oF5x7sAxqdCG/euT+CwZJsokPFA/gaBbp7YASkV3ecf7C2YeJKfLCmPF0Fm6PzPhdPZYagZa0dOWkvv/1k1vAh0MdebfP17svltvpclCk9c7R2IN4Z6vMyr3J4/Gk2LoEUCxOiC4K1OWuQTQUscO4GoJ7YfSnTpvYi0VytiIO6vjKV/kx0Vk2dTzIVUMu+NpKJqAHSakGXdN/NkjWqsrvO7Ia0j1MrDzh/80b2MVPIdoxEhHrCbk+de+2mIDtXFqG0aZeo82fGnzf/i/XsY7BSj4BB67+XWXh84mVsRAgYWZBjpbmXy1h06PWZ2rGs8YvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1RNth9IYINRb4fX4YjzO9lYQpja/TSFtTQAeqzxUOeI=;
 b=kHPhmuQn/Ii4/8R8rxjdG8X+G3UKBXotBbOo5wQ+xPKZFqVFJqQKFZc8gZhSHmg7nIft3lnBD0/ta9D66cl1cMZfNpO8ve41yeknYX4Hm676uZZJDeWIu3A9AK5QCmQxVE9iBKhVAcqvqSIJX3jxMjcKecyI9azXC2V87BErVVlUYgDrHFdmYARvho5rm/p+tzHjpkhk8hm0s7KuoaT7qoeSKjZI1o136/lpb7TbRPoo5RjX1yVbKHoA07JmQ0Q7DMNytfUDbpzJ/UYUcYL9oD8naKNnRdjDNCDb0p06mxART50/tKgiB3p65IxB2Ea3IK0ovAAtlWao+40JSZh0IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO6PR11MB5603.namprd11.prod.outlook.com (2603:10b6:5:35c::12)
 by PH7PR11MB7606.namprd11.prod.outlook.com (2603:10b6:510:271::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Fri, 30 Jun
 2023 17:26:56 +0000
Received: from CO6PR11MB5603.namprd11.prod.outlook.com
 ([fe80::4287:6d31:8c78:de92]) by CO6PR11MB5603.namprd11.prod.outlook.com
 ([fe80::4287:6d31:8c78:de92%6]) with mapi id 15.20.6544.019; Fri, 30 Jun 2023
 17:26:56 +0000
Message-ID: <2ba19723-8050-0550-c56a-39f7a73518b8@intel.com>
Date:   Fri, 30 Jun 2023 19:26:49 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v5 09/10] acpi/nfit: Move handler installing logic to
 driver
Content-Language: en-US
To:     Dan Williams <dan.j.williams@intel.com>,
        <linux-acpi@vger.kernel.org>
CC:     <rafael@kernel.org>, <vishal.l.verma@intel.com>, <lenb@kernel.org>,
        <dave.jiang@intel.com>, <ira.weiny@intel.com>,
        <rui.zhang@intel.com>, <linux-kernel@vger.kernel.org>,
        <nvdimm@lists.linux.dev>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
References: <20230616165034.3630141-1-michal.wilczynski@intel.com>
 <20230616165034.3630141-10-michal.wilczynski@intel.com>
 <649def832ce1f_11e68529491@dwillia2-xfh.jf.intel.com.notmuch>
 <81dbbc8f-fc05-754d-56bf-5e74169b8dc8@intel.com>
 <649f0ea3bfae4_11e685294f2@dwillia2-xfh.jf.intel.com.notmuch>
From:   "Wilczynski, Michal" <michal.wilczynski@intel.com>
In-Reply-To: <649f0ea3bfae4_11e685294f2@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0493.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:7e::19) To CO6PR11MB5603.namprd11.prod.outlook.com
 (2603:10b6:5:35c::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR11MB5603:EE_|PH7PR11MB7606:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ac23a7a-bb87-4261-a159-08db798f33e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UlBj+vygsxsDT8Du5NGSDSfB8VQ9GVIPcT6YhpbJ3LZWUmH6OrH47aQKA68faNPJyXOSZ+e17I3AWqIPVdZOL3Yks6W6yRWfB8Dv1ix/wroXjzpTRgShzuKXG5yAm0AEaL/ExWnujmT6aYmr1IaSyT3yjGO0HgHHTyGfHV+4BAlq9cRyjEjjLX3Yr5+CXBEqnmLGp4D5Yj2K8l9agC4awPWOc8aV8dWpFxUqVHvz7O3JwDk5CGGGWKEf/UQLwUVTkKJ1eD49z8OYDJknKhIRAZLPMiGZ36zpvDm6/D/7tX3dvMOXlFLEuD0DpAJjN0NGjqgLgxEdOGk/xfn1RIXRG/ZflSO6r/I+HTcsMzD0E9S8p7SvYfnj9PV/WZxW/Kpj7hJVmZyscr9oTI2z3GlekztJOx2KFU1fpR+z9aLA4g4ekf/VxHxi0XLwNppVlEW4Ztz8FdbIhajmu2yYlNSQ1S46bFgC4/2cIGApXmbQbaGpCTXXpubOJI7lTF2D1HXEEnM+D8XDF5c3ELbHRGA1OK3P6EIupy/Swok3sqlIU1OKv35kL2PisYIEna2/JFq3YiqPrmCM+HCWGCYVcp19SxzfntYbNtTL2bYgQoorpREPMsITURdd2mVorgEannNW3z1r6lCWnybkPnh9UD5xwA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(136003)(346002)(39860400002)(396003)(376002)(451199021)(26005)(6512007)(2906002)(86362001)(6486002)(6666004)(186003)(53546011)(38100700002)(83380400001)(107886003)(2616005)(82960400001)(31696002)(41300700001)(4326008)(478600001)(36756003)(316002)(66946007)(66556008)(66476007)(31686004)(5660300002)(8936002)(8676002)(6506007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V2dYNmlDUWcvYUNMTXd0d2hhblNCZ3M5NjQ2Z3dQaTZCdStFb0MyRGRUdUFU?=
 =?utf-8?B?MjBZTm94VExuQmNFZ3prREw1NUx6T2p1MW9IOGlvMHFtQUFJeDQ2MEc1L0du?=
 =?utf-8?B?ZmJkbUE1OWJKQW1Fakc5TzBhVWpIYkR6NXlkNGlheEh1QlAxd011NFJMZWFr?=
 =?utf-8?B?aWpvcU8yYWI3TVA1YVRTeDA1SndzMTdsYkVBKzlTcVh1RFFQZGsxdW5YU091?=
 =?utf-8?B?UUpMZnFWZURSM01wVjJhS3U0Y0RhTCtuTlVCSG5IQzc2Z2x1bjFQNmRSQ1R0?=
 =?utf-8?B?NTlDZGg5MlVDbzNwT1hwT2VRUkdSMWdYY1ZCMmMzTW00TXhsZDRJY0diMnFs?=
 =?utf-8?B?Qk1zZXBZOGx6L2xTZVB2c0F0S0NWM0swKzVpVzhWaXByZ2ZkRnRpNVdQdGhm?=
 =?utf-8?B?Tm1UQzFaQ2tyYzZTSjhhOUVHbzZteUpKZ1JvM0RhOG1zYmZ1ZTQxVFVoaitt?=
 =?utf-8?B?YUNKbHU4dWhqNUsvdHF2TndrSUhjRFlDSVpFVGgxSjYzalVnRmFHb01tTXhr?=
 =?utf-8?B?OU1SODJ4eHA0LzhMTVNaOUYvTmtvcVhCV0xadkxJVldPT3pWWG1pekR3SGY5?=
 =?utf-8?B?T0pmK0VtZTZIV2tNaXpEbnh0RVpuaHB3aStmS3FIOW1aYUpUV3cwOTBMekRh?=
 =?utf-8?B?eGlVVGRPV2ZLNFlpWTViQlFpdXdxRys5WVUybUMrOG5IQlJrdG0rWDNFOXVl?=
 =?utf-8?B?elUxUDFzY1N6MUVvdTlNUHBuWlNKOFNFbG1Pc0paUlJhVEU0aGZlblErRHUx?=
 =?utf-8?B?QlpMQmxLTUxVYWt3UCtJYno0aTNHdGFoQ1VpVFlHNlFSK2pITmtuM0N5RmFJ?=
 =?utf-8?B?aXpIbWNBcncyQ3I3cExSYUV1RU90ZFJxQ2h1WFVkc0kxdEY2aE4xM1p5M2JU?=
 =?utf-8?B?cVhKRTdybU1IOXdJMFQ1VnovUHdYS0RXUmY3c3NMUSt6VU5Vc3RtWGlTSGJX?=
 =?utf-8?B?VWl1cXllQTBjMlNQSHhBZFRWN3VVaGhKdER1OE1SRi9uSlYyOUtXVHJhRVJH?=
 =?utf-8?B?anhCZDE1ekNDMDFRMHYwaDRTdU1ZRjdQemhBZVRPMjcyR3VpcW00U1Vhd2dW?=
 =?utf-8?B?L0crWmh6blk3TjQ2TXc3cG5wSUw0ellWTDBYcTNsVkpGVzhBdWl5YjFhNENL?=
 =?utf-8?B?aHIxNmhLOXdYUVBnZy9oYVR1bFJrK0k0a3ZSY3FjVFFTeHBnUEcwNm93UmRG?=
 =?utf-8?B?TnFwZytjcGRFQmVZNVBlbS9MQ0s4MjhDWExDOEwzckUvYnJoaEgvRDVjWEc0?=
 =?utf-8?B?MzVQYlljakZya1VRZHVGRW4veE5tS3I2RjlneEhhMWtETjNGOGFBYld6N1lZ?=
 =?utf-8?B?VjRvQWdSUFdPNWhWdHlaNjFxNlBqU3lzL2pOMHZlY0FxMXUvRnMzeGFDOFNN?=
 =?utf-8?B?a1FhM1ZIakNKZkN1QWN4ZDNRUll0eVlkdXVLZG1weUhMM2NNTWJzVDRkRmtt?=
 =?utf-8?B?TkJJTjhmeDdUb3luS3dxQjVyYVFzZ29ldWEyNEMwY0JJNXZ3L29NR0p0bUNX?=
 =?utf-8?B?ODY1Ylg1MXQ1NFIxRVc5c1Z2UGcrMldWbTRIc1htcXRpcUhzVmdiWnNCZEZL?=
 =?utf-8?B?eTdUQnEwdU92bnFpSkZ0eEdmR1lrdzNCVFV6bkNVeUZsQVZpZlFsUDdTb0hU?=
 =?utf-8?B?ZmVxdm9PWGpUaXZVTUdWV3VnSFQxUnBEZ1ZnZkhXS2VSU3JpQk9pRmRFakx4?=
 =?utf-8?B?WjRWZUgxa0NaMFVhTGdVemZIZTZhZkZxRmdNNEVHMUswRUlPSC9teTZaRE9q?=
 =?utf-8?B?dkFSUklnZDZPVmtGRVBVdGxxZi9PZDM2TDZuaHcxMkRBV3hYYjA2U1o1QkhD?=
 =?utf-8?B?N2ZLSlZHai9RbUY4dmJwc2ZDTnQvRkI1NmFIUVViaEFUN0U0Q3RLeklCa2xI?=
 =?utf-8?B?SVdmVHl0ZHZsR3gvQTQybWNTV0RWSHJWR0RPSi8xS3dkS2ZIR1JVNVR4Z3Yr?=
 =?utf-8?B?MXY3V3FyOGwvU1FTK25hR2ZCckFUS2dLby91SUhRRWx2L1FjQzFWZmxHQjdY?=
 =?utf-8?B?NFJSd3pFaE5VeGZnK3Z6R2JMNFowb04yYUpXTklJOGxLd0N1ZkdhTmZ4ckJX?=
 =?utf-8?B?RHJjYjhyWU5MZFJhZnkrN0tTMmxmY0VmY1l2aWQ2ekVtMHlJakJ4K0g5UjZ0?=
 =?utf-8?B?VUhqSWxJdnBwQk9UUnk3bWd4SUVEOUY3Zzk3N3dYYnRPLzlWRmlSckJCZ1Ra?=
 =?utf-8?B?WWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ac23a7a-bb87-4261-a159-08db798f33e2
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2023 17:26:56.3235
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ra0mzaiyhdqxuOx6dCOEDpHPd1UaeUmZghO1HbHyo488XUsQfSdnvyh8jjCC94cqT9eatLZNPDbdU9VPc0apkHwQmRpLRsPPHfFPVuY8gak=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7606
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/30/2023 7:19 PM, Dan Williams wrote:
> Wilczynski, Michal wrote:
>>
>> On 6/29/2023 10:54 PM, Dan Williams wrote:
>>> Michal Wilczynski wrote:
>>>> Currently logic for installing notifications from ACPI devices is
>>>> implemented using notify callback in struct acpi_driver. Preparations
>>>> are being made to replace acpi_driver with more generic struct
>>>> platform_driver, which doesn't contain notify callback. Furthermore
>>>> as of now handlers are being called indirectly through
>>>> acpi_notify_device(), which decreases performance.
>>>>
>>>> Call acpi_dev_install_notify_handler() at the end of .add() callback.
>>>> Call acpi_dev_remove_notify_handler() at the beginning of .remove()
>>>> callback. Change arguments passed to the notify function to match with
>>>> what's required by acpi_install_notify_handler(). Remove .notify
>>>> callback initialization in acpi_driver.
>>>>
>>>> Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>>> Signed-off-by: Michal Wilczynski <michal.wilczynski@intel.com>
>>>> ---
>>>>  drivers/acpi/nfit/core.c | 24 ++++++++++++++++++------
>>>>  1 file changed, 18 insertions(+), 6 deletions(-)
>>>>
>>>> diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
>>>> index 95930e9d776c..a281bdfee8a0 100644
>>>> --- a/drivers/acpi/nfit/core.c
>>>> +++ b/drivers/acpi/nfit/core.c
>>>> @@ -3312,11 +3312,13 @@ void acpi_nfit_shutdown(void *data)
>>>>  }
>>>>  EXPORT_SYMBOL_GPL(acpi_nfit_shutdown);
>>>>  
>>>> -static void acpi_nfit_notify(struct acpi_device *adev, u32 event)
>>>> +static void acpi_nfit_notify(acpi_handle handle, u32 event, void *data)
>>>>  {
>>>> -	device_lock(&adev->dev);
>>>> -	__acpi_nfit_notify(&adev->dev, adev->handle, event);
>>>> -	device_unlock(&adev->dev);
>>>> +	struct acpi_device *device = data;
>>>> +
>>>> +	device_lock(&device->dev);
>>>> +	__acpi_nfit_notify(&device->dev, handle, event);
>>>> +	device_unlock(&device->dev);
>>>>  }
>>>>  
>>>>  static int acpi_nfit_add(struct acpi_device *adev)
>>>> @@ -3375,12 +3377,23 @@ static int acpi_nfit_add(struct acpi_device *adev)
>>>>  
>>>>  	if (rc)
>>>>  		return rc;
>>>> -	return devm_add_action_or_reset(dev, acpi_nfit_shutdown, acpi_desc);
>>>> +
>>>> +	rc = devm_add_action_or_reset(dev, acpi_nfit_shutdown, acpi_desc);
>>>> +	if (rc)
>>>> +		return rc;
>>>> +
>>>> +	return acpi_dev_install_notify_handler(adev,
>>>> +					       ACPI_DEVICE_NOTIFY,
>>>> +					       acpi_nfit_notify);
>>>>  }
>>>>  
>>>>  static void acpi_nfit_remove(struct acpi_device *adev)
>>>>  {
>>>>  	/* see acpi_nfit_unregister */
>>>> +
>>>> +	acpi_dev_remove_notify_handler(adev,
>>>> +				       ACPI_DEVICE_NOTIFY,
>>>> +				       acpi_nfit_notify);
>>> Please use devm to trigger this release rather than making
>>> acpi_nfit_remove() contain any logic.
>> I think adding separate devm action to remove event handler is not
>> necessary. I'll put the removal in the beggining of acpi_nfit_shutdown() if you
>> don't object.
> How do you plan to handle an acpi_dev_install_notify_handler() failure?
> acpi_nfit_shutdown() will need to have extra logic to know that it can
> skip acpi_dev_remove_notify_handler() in some cases and not other..
> Maybe it is ok to remove a handler that was never installed, but I would
> rather not go look that up. A devm callback for
> acpi_dev_remove_notify_handler() avoids that.

Sure, I looked at the code and it seems to me that trying to remove a callback that doesn't
exist shouldn't cause any problems. But maybe it's not very elegant and we shouldn't rely
on that behavior.

Will add separate devm action for that then.


