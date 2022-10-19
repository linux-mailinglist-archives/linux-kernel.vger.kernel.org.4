Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D8BF60543D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 01:55:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbiJSXy5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 19:54:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbiJSXys (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 19:54:48 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75AD45603B
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 16:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666223686; x=1697759686;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=mr77sjMY/nw7xwWRV+ASrCIyn0YhezTqLsVX9GyiNEk=;
  b=jyRmAUUnsPGhKgt0dqIkbOYDEv7+vYA4zqcyY7cDY1AOD8dHSXspdPqc
   zxNnrsF/aRO6iSpTlmwhCBi0jXEqWD3EJEl5ttr8agevJ4jfSa5utXPh9
   9X4DPmJbWBjpdWzT2uedEEZdKOVNiym6FNif2YXNJooGHx9r7PGlaeCC2
   HOZFzdqbVKhbP97S03/v3Pe2oV0vsVFVSs2dS5sYEyDvW4mjLC8XbllB2
   dcOwuSa3I96C+UrAUEc0RJGP9pxkvR6p4nBoQ0JQmCwebs5KWk7D4P+L1
   1sCi0Uii+FFyYX8nfylTo2zO0VslOW4KIZN9OSwyXNFU9mGVxwq9sQ5c9
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10505"; a="392863318"
X-IronPort-AV: E=Sophos;i="5.95,196,1661842800"; 
   d="scan'208";a="392863318"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2022 16:54:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10505"; a="660590916"
X-IronPort-AV: E=Sophos;i="5.95,196,1661842800"; 
   d="scan'208";a="660590916"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga008.jf.intel.com with ESMTP; 19 Oct 2022 16:54:37 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 19 Oct 2022 16:54:36 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 19 Oct 2022 16:54:36 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 19 Oct 2022 16:54:36 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.102)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 19 Oct 2022 16:54:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gyOgA8la21MI/9bx/x2wJX7CGMPYqZgwpA3K3uLzHRODDZKvM9Pmw7J3uLD/Y9+2sUylOvqh9xuyGd4SokmDp3UzA1vxmGXgRPk7tBCI34saEF8RMffwlCr4LHsVLsLDBbN1EvoluD91eEa+JNsRK1PRJ/ZFxc7CkrR+oq9wkHqDDbqrdnGcSCYGtjSPiOov/MYhc3+JGlAiJltrtuNahB7Io/pUuwYQplQeI2Pq9DvcJd+aHzBU0znz4AcwvTRSPD7X7Y8pZX74N7YaZfLOr4J3SRfiW096s6vktP12RcGumrbjhc/Fu2l8BymCOMlR8md9YlnrFKYQYqUm0z+dng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DnJgQhKM0hA61QgCHZ9yzAXw6mi44t0zw2ExWQ2dVXg=;
 b=Y363mJ2bgQMxQ7Sr8OGXb3g8TATCM0fQCeU05N6iKLqVjkVrWKa86sAS834P57PRXbuYoz8p2M1Hc5gItLZzoS4D+bfUdeHXqq5YkAwdmrIdrQOHthEGmsjBf+8SXbM3JLhn5FjSmIUO8EuU9+Q2v9bh2zVv6VtB5SEZzWou0d9kJ4oP7HmqDlmFu34kl6Ue9mEosx1Q97jezUlLodQS1Ma4CsLoaXJbjmyJuDj5Dk0A49x7mIfjGBOs5c/zQUoAhTSpTYvx8jr0B0blVfPQRh9o82ypQusWjsPZTmB3yca+STFkDurhU3GI1+kJMM0NBBx63pm2dsN2J20bugsU3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by DM4PR11MB5341.namprd11.prod.outlook.com (2603:10b6:5:390::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.34; Wed, 19 Oct
 2022 23:54:32 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::207e:ab0b:9e29:6a4b]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::207e:ab0b:9e29:6a4b%12]) with mapi id 15.20.5723.033; Wed, 19 Oct
 2022 23:54:32 +0000
Message-ID: <b931062a-1a70-2331-03cc-6bfa69a51bee@intel.com>
Date:   Wed, 19 Oct 2022 16:54:30 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.3.3
Subject: Re: [RFD] resctrl: reassigning a running container's CTRL_MON group
Content-Language: en-US
To:     Peter Newman <peternewman@google.com>
CC:     Tony Luck <tony.luck@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "Eranian, Stephane" <eranian@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "James Morse" <james.morse@arm.com>,
        Babu Moger <Babu.Moger@amd.com>,
        "Gaurang Upasani" <gupasani@google.com>
References: <CALPaoCj-zav4x6H3ffXo_O+RFan8Qb-uLy-DdtkaQTfuxY4a0w@mail.gmail.com>
 <b2e020b1-f6b2-e236-a042-4eb2fd27d8b0@intel.com>
 <IA1PR11MB6097236CFF891041DBA42ECB9B5F9@IA1PR11MB6097.namprd11.prod.outlook.com>
 <Y0BhzKkksSjSeE3W@agluck-desk3.sc.intel.com>
 <81a7b4f6-fbb5-380e-532d-f2c1fc49b515@intel.com>
 <CALPaoCjdeRjyX5L6BBX688ZM21eMwetuL9QLF1+GEDUskGcU2w@mail.gmail.com>
 <7b09fb62-e61a-65b9-a71e-ab725f527ded@intel.com>
 <CALPaoCg4zrODVoXF2y2b+LRYq_+jnV8yv5qB+T_3Z264cV82GQ@mail.gmail.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <CALPaoCg4zrODVoXF2y2b+LRYq_+jnV8yv5qB+T_3Z264cV82GQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0080.namprd03.prod.outlook.com
 (2603:10b6:a03:331::25) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|DM4PR11MB5341:EE_
X-MS-Office365-Filtering-Correlation-Id: 0462b296-4500-424f-503c-08dab22d44e3
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Aax5XpHI7Q+eqi3u8UIBDiJdc+lx7SoGgGI3iA8TMe1drN0c0WIbt00q3dAYDJgte4NIhlfvGEo71WiEwb2SB+TD+wMW0MTcd/HOTput2S65D822VfFO7SiSD4IAK0GI5S8M/Tsng4CJn06hadIjEpY22HPvcm0OF6UoaEK90Rd2ZJw8Gl/OCTONGlO38CSqE+NDLAHM9oosiUSL0Y6ycIiUKiBYrOBwkRzPmqOl+f2eNzpjtCKflev+4JDJ+eMMS+/VN9oe8TyyR4uEQ0fPI2HiK6OwYwf8jUj+jbMSUmI+0hrvoAMraiD7drRvheQKwoB2pbey+b7JSQOnQUxoabxYVcPvV1hj2wOmbmP3yAtPIhDtukt7Q4zSomayYyEsycrxPg9uYswHXTMmtKzIlhoWgLo2Yo5m6CqY6nmsjeKrUeL47hKZh+0yDU7AmUT1vkajijyGMAZbdvMpj6znF4yx7rEs63Y6zTxpVueeDBD7OFHwDMHVhVKyPcE96GXvuyQ5DrdSdfxmnbkpE8qjlzXlAn2bH8FksICgxMA4IHkdE/i7oTo/sFDi0/ChgEZb0NwRxWOCltVvuIGj/TkWTr/fHD14aWZLqPfH8L17h7d6dO6oZdHprnPL2bHiQKlx4bjCxJkoZ4iX0gMck2dyyzz3G/p8mLuk8sCrdWwZLZMnSg6MGvGFeR0sane5epU1CYbxmd84KP4fE2U+/NtA3Evng5NNqQ9vg3fPNYe+K/isOJvXFC2jk7o1dUaNoEP/Pbr8sMY8J3n082t/N55n6nG+BlYV4X6ZhByvxU5Xnjo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(39860400002)(396003)(376002)(346002)(136003)(451199015)(2906002)(44832011)(31696002)(4326008)(66476007)(41300700001)(5660300002)(38100700002)(8936002)(66556008)(8676002)(86362001)(82960400001)(6506007)(6512007)(26005)(2616005)(53546011)(36756003)(54906003)(6916009)(186003)(6486002)(478600001)(66946007)(316002)(83380400001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RFAzSlgxZHRUNTF4MUpmeEptR1Rlc0NFczRXMnRnTVZrem12Q0wxeEN0TmRP?=
 =?utf-8?B?WmhqR0t3WDc3SmNIMEVZYkF4bXlBTHpOejBuMHBSVFpGMWFUSUJNUHNabnlW?=
 =?utf-8?B?REpWSXJEbm95OU1IQWJiYnN3ek1NOEQ2NzliSWVDZmtrTWZ2YUd5S253ZDhh?=
 =?utf-8?B?NjR2YmZCOVd5SDVsZWR2aXJIcTZDSG1ZTE1CTE82c3l5SUxzb1paZk1MclV1?=
 =?utf-8?B?TDJOS1ZKS212R0tyWnlBbG9ZRmtabmlCOUNRTHNQWEZJRk91eG53eGpGZDc0?=
 =?utf-8?B?bjZTNEd6dE9iUW1qaWxMMk9tL3JiMUZ1SDdtTTZMYjMxQUxQaGQ0UlFpYjN1?=
 =?utf-8?B?UVd3NzJEaC9mZTFuR1lHN2o2M0tRZjhiOXFXczlGQWpXVmpPYmVmRXl5Rkgr?=
 =?utf-8?B?bUtpVWRYQzU2Y2NPR1dGRnpmSU5yYjBmTlUvakZmaVIycHJnVE9GMWdQaWpm?=
 =?utf-8?B?R2RiSmxHd1hPcUw5emtZNEs5b0svNXcrd2VuWVN3MmpRejBQTVhzWnBYaTFj?=
 =?utf-8?B?QVJUSU9SYzlsSmV0MDBwSmJWZkJQaXg5TThlMEw1RFE5UG9NYUxyQ01lOHpF?=
 =?utf-8?B?Vk50L0FPSEgxdVdSNGxsLzh4U1pNN2hhMEZMYTY5N1RpMVJwa1BjWnRvazQx?=
 =?utf-8?B?VmgxbEdXblZ6T1YzR1B3NkovRmc0QmNudjVGeFA0dERsZkdXSHJTSXVYbHVD?=
 =?utf-8?B?YlY3S01NNzNEZHlYd0V1cXZEQXNNd2k4WUNTS1c4Zis4WEhlVGg5VlZUczN2?=
 =?utf-8?B?MVBWT1h6VWUzenRFcm1lQWk4VGlMMm1ZWnNDZm0rWDJBaWFRamloUkVlalpZ?=
 =?utf-8?B?R05TbjJSS0hJbUltdEtsbjQ1cnh4dFJ5QWFqRTY4NnZCSTdtcVhzSitidHgv?=
 =?utf-8?B?VFhORWl5eTJvaUlPelkydkFzUEZRNEl5SzFVVmc0WjZyVzk4R0NTdkVkNkVt?=
 =?utf-8?B?Z0xYT0tsRTBmMzBVdDNycWJUci8wdXBySDZja0RtRjhHcVp3cnE5VWFzS1pO?=
 =?utf-8?B?aXV0cG5WMmFJZDA1Ynp2ZGJiK1Qvd2VMaytFWTdrU2pYd1B6UlBkRXZZUzJQ?=
 =?utf-8?B?ekhGaGFKUmRscE5Kb0daQTJkc3hTNldkeEE0bGpPOXgwU1NQWnljRVp5WkVN?=
 =?utf-8?B?ajBRc3AxeENCbysxOTArK2pqRnNFeUd2aTZ3Y0dUL0xaSlU1NmhGRTRkN2Rw?=
 =?utf-8?B?YVd2dmZaMGF4Mkt6RFdQMGVHYmJETG9MMTVVdHJXTGV1N3Z3RllvTkVZbm4w?=
 =?utf-8?B?aXVGYXJ5d1I4cy9MS0FGNDZsZWUxYVJrYWVrTUhEamdrK25RQldxZlZqanFy?=
 =?utf-8?B?VTNkYnVFQUluV0ZRWnhqREp1QnVQNG5md2hNazVWdUIzZGNrK054eHZuUW02?=
 =?utf-8?B?ZnBhc0R4bWdDSHdKdDdmTFZ5RktRcVZYenArQlYzdEJIZlVneEcxcVhpZEgr?=
 =?utf-8?B?MmV1LytYcU1QTldYWlkwUXpGSVdrNkZjcnE1VkV3Q1JqT3lteU1Na2FDVmM4?=
 =?utf-8?B?RFJ0ZDRRcDFzYk52RnBPNDQxdWRqdDdIL2F5UDZyQkoxbElVUm5nWDRXVkdu?=
 =?utf-8?B?S3hDQjFyNmZVeUhJRkRCYVJYVUZwOUtCNDJqbGpTNFJZOHBOcmExWFRXKytp?=
 =?utf-8?B?bjAyT09Dc1lSSXhxaFlCRjE5RVAvcXp3V0ZHakpmRkhHU3lMSGs0VGxpVWRz?=
 =?utf-8?B?ZW9PRWIxTGpudjZxVnVzRzEvNVNVNElIQkE3Q01Gd1RJd2ZjWjVJRHBzempQ?=
 =?utf-8?B?NDBjNmE0VnJ2OHZ2VWFTd1FaeERaUDNkbEhwMi9icEFMUkVtWmJrQldmd2ow?=
 =?utf-8?B?elRnb3h0c2NzZzR0L2h4OFVlZnVWb25NOFNjNXcvZGFxdFdNMkEwajdnbmFV?=
 =?utf-8?B?enR6ajlLajdkc2I0QytRS1A5K253dkh6MDdkUTZBZStLc3VzK3kzS2k0N3VC?=
 =?utf-8?B?dWt6ajBOZkM3N0daeXBaa1JoTnU4TkgwUmhVa2tUZEt6UmRFR3BNaHVST0xP?=
 =?utf-8?B?d3NSSFVuMkhjVWJkUFhZenRXSFo2Vnh0VG9GbHpMSFhCY0ZKeE5jdURqb3Vj?=
 =?utf-8?B?MzA4WlNKaUZrTkU3Q0czR2pXVWxnMUFsMEV6b1NnaXlROW5nbGNsd1ViajhH?=
 =?utf-8?B?TkwzQmE3dVRBM3pJZVlEbjFVR29NdU0rT2dXWmJ6VFZ4ZWwrTG9MTk80STVU?=
 =?utf-8?B?T0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0462b296-4500-424f-503c-08dab22d44e3
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2022 23:54:32.7397
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vlyQeUTP40ERy6e4ytIzsvKrsqLnlZ4GPcXtV9gUnMBTY0WU58E8gbQdNO4ZhWSintQ6RRTJotA4AfE+5/e4lQbxxGvT4RfvyFPQ+XF35Ag=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5341
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On 10/19/2022 2:08 AM, Peter Newman wrote:
> Hi Reinette,
> 
> On Wed, Oct 12, 2022 at 7:23 PM Reinette Chatre
> <reinette.chatre@intel.com> wrote:
>> What if resctrl adds support to rdtgroup_kf_syscall_ops for
>> the .rename callback?
>>
>> It seems like doing so could enable users to do something like:
>> mv /sys/fs/resctrl/groupA/mon_groups/containerA /sys/fs/resctrl/groupB/mon_groups/
>>
>> Such a user request would trigger the "containerA" monitor group
>> to be moved to another control group. All tasks within it could be moved to
>> the new control group (their CLOSIDs are changed) while their RMIDs
>> remain intact.
> 
> I think this will be the best approach for us, since we need separate
> counters for every job. Unless you were planning to implement this very
> soon, I will prototype it for the container manager team to try out and
> submit patches for review if it works for them.

I do not have plans for work in this area.

It is still not clear to me how palatable this will be on Arm systems. 
This solution also involves changing the CLOSID/PARTID like your original
proposal and James highlighted that it would "mess up the bandwidth counters"
because of the way PARTID.PMG is used for monitoring. Perhaps even a new
PMG would need to be assigned during such a monitor group move. One requirement
for this RFD was to keep usage counts intact and from what I understand
this will not be possible on Arm systems.  There could be software mechanisms
to help reduce the noise during the transition. For example, some new limbo
mechanism that avoids re-assigning the old PARTID.PMG, while perhaps still
using the old PARTID.PMG to read usage counts for a while? Or would the
guidance just be that the counters will have some noise after the move?

Reinette
