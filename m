Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBB875F7AA4
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 17:36:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230061AbiJGPgs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 11:36:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbiJGPgq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 11:36:46 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BEE3B7EC8
        for <linux-kernel@vger.kernel.org>; Fri,  7 Oct 2022 08:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665157005; x=1696693005;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=yB20Cf6pacalmkdf3lUTMGWkeTT1sHVhQacidwwBAjs=;
  b=KDpRP5rMownnf3GWn5plq4lBuDSbx17qV7PgTKVfMImj/VkmvEBsHNKQ
   2fzjiHWQstmYqy/K6SiK9vg6MjuExvitVh/DD//gau3mVjIAlXbpdnGbH
   v4KjR7GLUZG9jhT7zaW5x7rhNbJ8bUPVG1OeqVWBfqQWmK0eiv4fvKMRx
   aAms7hQFq5KkOrZoR6U6orp/8oPD2HfEljM9Z0PSQbyzRw4nTLv4ouL1W
   i8H7emtH8y6H/x2O0ceQjfOlE6OjYfGw3q4fTntOpBEGknjmVEuSRc2QD
   2kg8lu45I0jmlNDOc6uw4GmWhfr8PXFGFKXF9kGJYuUNQNCHU5eUZp2dJ
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10493"; a="305344218"
X-IronPort-AV: E=Sophos;i="5.95,167,1661842800"; 
   d="scan'208";a="305344218"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2022 08:36:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10493"; a="800339948"
X-IronPort-AV: E=Sophos;i="5.95,167,1661842800"; 
   d="scan'208";a="800339948"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga005.jf.intel.com with ESMTP; 07 Oct 2022 08:36:44 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 7 Oct 2022 08:36:44 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 7 Oct 2022 08:36:43 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Fri, 7 Oct 2022 08:36:43 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.104)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Fri, 7 Oct 2022 08:36:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XQ/dcUndt+JcpyztzirTh0jXU0wYYtqIaBD2d+vg20h8zx6jJtCCSnIYAuuArUTd48alrWuvvOLI9bdEkNU/1bw1sjxSJ3hpxyeO0LHpC0wYEjPo+HFLhkBFXSjh4Z/fNZYx7K3VBdtvlTT9h3w+8g5VhJnyJ3bCW/sZLz0JQvM6Fk8krZNWvK+F2QVR8KZhbuyXee1oBUj0rWpZp58W6GhyLhgVGpVvijFo6oRAWNcPXb1dl+f5wD68b02l4xY4klDMNd375paaiSQl+U8ua5GjPHuzybOFGJMI/dvSdl+SffkeNEBB2WchPcWcEOvW2OHNlYUCrxe0mFXNViKX0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6CFmfmBcDfklUYXlMwSfCLBv2+/etv1ILm99j3Tu+7k=;
 b=NcIi5MwDwZaVSOC2b98CC+cs8ZvynPnKS4zulyovdNmmVYoVDMCIc/gBq49mm/8LOVqeGyHQ4Mq28StcHamasHR2B0TzQyumwNxfl1bH04FiuAHIgzCmhBYW/tlI04G8rlaDYivjqvTD+oI/1tKMrI7xPC3ZaWpqDUuot4ndx6GbgyDaSdoT0zTkepzQE1bAo5qdxoYTpl+3sAs5belXs7LbKIQdmsNCh1hzz9LOKBzTbRYvMEjIDPXMFR0Y0SXYmII8bR2WVEh1LnR8SZ5LSOWRvhBo7kXlktglh5RITMnApKTe4aZ5p+uhmhbcheSywj0HzZgFeutNX/7VN6v9aA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM5PR11MB1867.namprd11.prod.outlook.com (2603:10b6:3:10c::13)
 by MW5PR11MB5907.namprd11.prod.outlook.com (2603:10b6:303:1a1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.36; Fri, 7 Oct
 2022 15:36:40 +0000
Received: from DM5PR11MB1867.namprd11.prod.outlook.com
 ([fe80::7d5f:681d:2ff5:a7a7]) by DM5PR11MB1867.namprd11.prod.outlook.com
 ([fe80::7d5f:681d:2ff5:a7a7%10]) with mapi id 15.20.5676.036; Fri, 7 Oct 2022
 15:36:39 +0000
Message-ID: <b2e020b1-f6b2-e236-a042-4eb2fd27d8b0@intel.com>
Date:   Fri, 7 Oct 2022 08:36:37 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.3.1
Subject: Re: [RFD] resctrl: reassigning a running container's CTRL_MON group
Content-Language: en-US
To:     Peter Newman <peternewman@google.com>,
        Fenghua Yu <fenghua.yu@intel.com>
CC:     Stephane Eranian <eranian@google.com>,
        <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        James Morse <james.morse@arm.com>,
        Babu Moger <Babu.Moger@amd.com>,
        "Luck, Tony" <tony.luck@intel.com>
References: <CALPaoCj-zav4x6H3ffXo_O+RFan8Qb-uLy-DdtkaQTfuxY4a0w@mail.gmail.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <CALPaoCj-zav4x6H3ffXo_O+RFan8Qb-uLy-DdtkaQTfuxY4a0w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0173.namprd03.prod.outlook.com
 (2603:10b6:a03:338::28) To DM5PR11MB1867.namprd11.prod.outlook.com
 (2603:10b6:3:10c::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR11MB1867:EE_|MW5PR11MB5907:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b45de0f-c6c5-4912-0384-08daa879ba4a
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +VcVF4C1c9lwH2oE7blSeLKxjCJhsWCj84qBH5k0gTNeyeRA0GYKD5jVtgZ2J/R9R72jq4WqMLT/aJ2oRcL9JQAvUzzrZLVDY+QZ+itWiDXa+mxvcMKIHn5ngM5GCyBQITGeVYH8ECupqg6WBLTC5A5VuzL0rRkk2n/85hFYeNIEjRnb5Ef0m7fSEMWpVQfd0rlUxJuV+KlD4H+WXUmKvIbznbz5DO+ZNgXLrnGXKnELw0sZIO7k/0I29CsdB9NDtLG5YZnAqGBn0THn0heyDyruG3uI2x+J2i+6Z5HGyXn1CJZOOZORhuAjYCQm8UWCHDwCO9lKBs4tweFDEz3nZHRO6Z+GLsfYVUpF3nzcP0sghzoYkHKBC7IOS3D/lbmAOhG5mKFgN0DOOH+lnZhaCOOKkic52ShS1+tGvUr6nNHvHzEWZvNAohHrfADq7Zst0YDofJGJL18MafZHZ0U7FSKzbfHJ9AV8ZaZauyI0RHfbxLfcO4Sb875EA5lxOCvj3Lvt83+CFHERaCDJ30rBVNv6UBUrOUh576gGRiUTsZH9v20UyfHDvT69ueT19fHnU7dlxsGCVcYFGTOp35pamCbZXnU2kKek3z5ELJr0SYQ7/8t/9AhnkiPMrlSmiA/6O5cXpQPbbu4wUGoyEJc7OnGWt5PfXQzWd26/+TrXY+R+qu+MahdW1gujG2lF339OfdX8zI6NgsHkcuf/UMAnjQLdf2GM7+Dw1tMQro7NiHvhsGrFYbH1mhrwKq1jfJgzQ7BOCi87SnwSHi1jOqEIlfdLaHX6puDWtl+zkCdVk9U=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR11MB1867.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(136003)(346002)(396003)(376002)(366004)(451199015)(478600001)(38100700002)(82960400001)(31686004)(2616005)(54906003)(186003)(86362001)(316002)(110136005)(107886003)(6512007)(6506007)(26005)(6486002)(6636002)(31696002)(53546011)(41300700001)(4326008)(8936002)(66946007)(8676002)(83380400001)(66556008)(66476007)(2906002)(5660300002)(44832011)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T2o3QlQ3VU1lM1krc0FZb3hGbzFYdTlBM05wK1ZvUWJXSGUxNVk3ejRsV0tN?=
 =?utf-8?B?WFMzdWpkZ1BQWXNiT2pQK0dRRXR5aldVYW5rVjNzUjhYV2RyY212WG05UTgr?=
 =?utf-8?B?bm5VQUNUbklFUElpU3JIRHNnSkFIeXk3dDE3U3Q2b3RWQmFkL01ENUpiTnRG?=
 =?utf-8?B?U3c3emR3Ky85ZkdJcTQrZFpORkE0YWNtb2R2a0o2QUpsZWh0T1UwVmVvRlMw?=
 =?utf-8?B?VG11Mys2eWdzM0gwM0ZEVTR0Z2Vkb1FGMmlqRmRCY0JMSkYwejQwWDNUbHhV?=
 =?utf-8?B?SGJxNEZnaXdMTlZoUVhTZVcwRVc4ZFN0MnNIVmdIcVdzTU9PYStva3htKzlt?=
 =?utf-8?B?RTdqcC9UUi9NZ0hxRWJuMFoxUElSZ3lyWVVtRmZ4cG1YbTJyMFFUa0lnMWlM?=
 =?utf-8?B?Tm1aNjlibzNsck05SjlWalRGc2RrTFVMVSt5MHFLUDU5anF1amx4OFQ4eFZo?=
 =?utf-8?B?ODRYK2QxaGFVWkU1TWIvYlhua0lTS21aWFpQZHAzSWptZHdpaERaU0hlZnVi?=
 =?utf-8?B?dXlMK3RhdkpnUFpvN01PaVA5YWlMSVJZRk0xSlB6VWxnWmpGKzFHTmJrZWZw?=
 =?utf-8?B?M2JrclpVR0ozb2Z1VkMrWkZXUlB0aTZCejVRNjFmWjBpeTM0RitaRzJoaENB?=
 =?utf-8?B?ZlJsbS9KN3daV1ZxQWI0SjdXQi9pNXU5OE13T2xsdnBXdGlFRWsyalVTbkxo?=
 =?utf-8?B?Y1BQZEJYOTdqeHpZOUs3bEFtMTRYbU40R1hXYjhNN1RZMk9kbGtwdDA0c3l5?=
 =?utf-8?B?Wk5Fbmc5aE9YcFVVMEVBRFpXYmhhajV4TlVDeG03UU5tSXhzOVNOQUlyUTZq?=
 =?utf-8?B?dnk2a1dEN2RKSytaejgvYjdZSEpmZWxhK25CbGo3LzY4aExKeHQ5WE1vWHQw?=
 =?utf-8?B?b0hvWUtCTzNwSXd2SFNLY0JURVNtTnNyR2hmaGRBdmRQL3ZRaTZhZUdlYzdN?=
 =?utf-8?B?Q1U4QWl1V1JOSjlWNVpJaFQrQ3o3dTBOOXEyUzJsWDJ0STZnOXIzRjM2NzdY?=
 =?utf-8?B?b3I1SVd2L3BTdGxiK2x6dzlNL3dtdzM0YStXTThVK0xPS1FWdEk1SGtVMnhh?=
 =?utf-8?B?UWpuTmd3Ryt4djhRUnZVeTk1WUF5dGE2SFIvNXhhbHhIQlQ5UnZEcUV6ZGk2?=
 =?utf-8?B?TEpsMGVkY1pCSW5zL2UvS2RueWR0aTdva3NBT2k0OUt3eDJXNWJzbFJkODlZ?=
 =?utf-8?B?MXA0bHhRYStSdFU4ZSt1blE4OEdpQzYxTCtZVFgvcWQyZXdPSkNqZ2VvZmdX?=
 =?utf-8?B?cmtLSVQwSmk5ekg4eURpN3hTZjRRN3doSW4zeWMwdXlpOW9oQlcvWTJIVlBw?=
 =?utf-8?B?bVh3MC90OHJIcGhmVllybUhkVDNxMDJvNEtFdTdNREt4NUgxSjk3VTRRNCtX?=
 =?utf-8?B?UjQ3MGhUNE01UFhibE1COUVIa2NvNkJtaFBnZ3h5QzhUU3JPTTZyb3daYitX?=
 =?utf-8?B?dFE2Y2pnVDhndG5rL1JFcHBIM3pEVGg3VU5KQWRoVGhmQjBzUitKL0MzVHlW?=
 =?utf-8?B?RENKRGt2bWd4UThjOHI4TGhKZ1NNeTFHMnRsa3p0K21SK1Z1TFU4YnVyYnc5?=
 =?utf-8?B?UGJxNU8xVmptajlxdnVabGlERHczYWIrbElmV0hheVNlc05nMUJST2hQMFNQ?=
 =?utf-8?B?dkRlOEpiTDRCTnA4ajJpWUJ5eHdVMFpoWGZoRTlwbXZhUW40RDR4THlxM0Ju?=
 =?utf-8?B?TGh2N3lEUGQwVnlPRjYvY05CZ3E0QkJscnBjdzVZT1RwbWczRGxPWElxSFFI?=
 =?utf-8?B?L1RObGtWcjZvaks2ays5RkxDWkFqNEFzNlJXY0R2ZS9xUG5XTE5QUUN2cUNu?=
 =?utf-8?B?MnZLc3BCYTZiNkV5VWE5SzY1Z1N1NVJhUldoUWQ2T21ncDBnV21hSTgxZU83?=
 =?utf-8?B?aXlUT2pPaU1UUVhRa3F3T2pycHFBa1R5NTVsZkFuek9UdXlvZWVKUzNUU2VM?=
 =?utf-8?B?VGVqL2FyTEZ0T3hOT1U3WU1lWk42TlJqOU5UbGtwUjVUZ0cyQmE4TTFrUTFj?=
 =?utf-8?B?V3BlQTc5ajREcWdHeXJaVG9qNHhhK1pPeWJxT1ErUmZpdkliOFRKVUZGL1ZB?=
 =?utf-8?B?NldNMUdiYWtYbEE0Qmh1bFZSdjJ6T0JhVlp6S3lGRDdvMU1KUXlKLzRNQnJn?=
 =?utf-8?B?ck15alppdnc3VjUzendia1VLUzdwWXRLcVU4WVlwOUFoYjdyRzB3dk5Wai9i?=
 =?utf-8?B?Snc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b45de0f-c6c5-4912-0384-08daa879ba4a
X-MS-Exchange-CrossTenant-AuthSource: DM5PR11MB1867.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2022 15:36:39.8299
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FDNsgBjoUnHRqU6CgRKAj47UFOjQU0Poo4YoR3E0Qte3KNXGqEIB2wC9n1iSHmVYkutSH3YNO4fAGzv7E59YGQZqxWV0JlBMezPcH9UEO6w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5907
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Tony

On 10/7/2022 3:39 AM, Peter Newman wrote:
> Hi Reinette, Fenghua,
> 
> I'd like to talk about the tasks file interface in CTRL_MON and MON
> groups.
> 
> For some background, we are using the memory-bandwidth monitoring and
> allocation features of resctrl to maintain QoS on external memory
> bandwidth for latency-sensitive containers to help enable batch
> containers to use up leftover CPU/memory resources on a machine.  We
> also monitor the external memory bandwidth usage of all hosted
> containers to identify ones which are misusing their latency-sensitive
> CoS assignment and downgrade them to the batch CoS.
> 
> The trouble is, container manager developers working with the tasks
> interface have complained that it's not usable for them because it takes
> many (or an unbounded number of) passes to move all tasks from a
> container over, as the list is always changing.
> 
> Our solution for them is to remove the need for moving tasks between
> CTRL_MON groups. Because we are mainly using MB throttling to implement
> QoS, we only need two classes of service. Therefore we've modified
> resctrl to reuse existing CLOSIDs for CTRL_MON groups with identical
> configurations, allowing us to create a CTRL_MON group for every
> container. Instead of moving the tasks over, we only need to update
> their CTRL_MON group's schemata. Another benefit for us is that we do
> not need to also move all of the tasks over to a new monitoring group in
> the batch CTRL_MON group, and the usage counts remain intact.
> 
> The CLOSID management rules would roughly be:
> 
>  1. If an update would cause a CTRL_MON group's config to match that of
>     an existing group, the CTRL_MON group's CLOSID should change to that
>     of the existing group, where the definition of "match" is: all
>     control values match in all domains for all resources, as well as
>     the cpu masks matching.
> 
>  2. If an update to a CTRL_MON group sharing a CLOSID with another group
>     causes that group to no longer match any others, a new CLOSID must
>     be allocated.
> 
>  3. An update to a CTRL_MON group using a non-shared CLOSID which
>     continues to not match any others follows the current resctrl
>     behavior.
> 
> Before I prepare any patches for review, I'm interested in any comments
> or suggestions on the use case and solution.
> 
> Are there simpler strategies for reassigning a running container's tasks
> to a different CTRL_MON group that we should be considering first?
> 
> Any concerns about the CLOSID-reusing behavior? The hope is existing
> users who aren't creating identically-configured CTRL_MON groups would
> be minimally impacted. Would it help if the proposed behavior were
> opt-in at mount-time?
> 
> Thanks!
> -Peter
