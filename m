Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A7C26FD337
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 02:07:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234838AbjEJAHP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 20:07:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjEJAHN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 20:07:13 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E542273D
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 17:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683677232; x=1715213232;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=kwZ/+DJ9HGCNs1MYC59nlm7gqHmziAySv3iLgNwvuFU=;
  b=C82pkRQnz66CQA38i/qeD7hQ102+DS+N87P1cUBFzIrM7lrCLwKYgRGf
   1b9y8JEefXLhpthCMG0NFcCZphn9OyBmS07aOQZtZMkKg/wR/XMdr8+Zd
   /IyCZEI/Pas5ga7y5PA9aY9YdwBdXf2iX1Ddc36u4GSYM2rqlat7EZ2gx
   H8DcADHmPlwlJvQrpAWpgWaD9CTsOqp+AMPfU0xWM/kZPgpXiclhDyghm
   OS2NRO6B4XDHWMbSqeIvJdAftJUYp+ZHVHf616ZUxyRcJX+5BiyoTBwtl
   yROqX0I2gfnrr9VA84+95tHUOsSx6Y1HiC4Qd/JZYB7Rh4u/K1IAJwj6E
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10705"; a="413372629"
X-IronPort-AV: E=Sophos;i="5.99,263,1677571200"; 
   d="scan'208";a="413372629"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2023 17:07:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10705"; a="823335395"
X-IronPort-AV: E=Sophos;i="5.99,263,1677571200"; 
   d="scan'208";a="823335395"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga004.jf.intel.com with ESMTP; 09 May 2023 17:07:11 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 9 May 2023 17:07:10 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 9 May 2023 17:07:10 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Tue, 9 May 2023 17:07:10 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Tue, 9 May 2023 17:07:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Euvq4GFWOqy5w8sY1/J6P1a9tXnocExAYa6oNSxxjmj1aQQhhyizGMSBk7RBEXzA+rsUA+VL+Mb8iR8XXSFXdcodu824q3IKjf479NdQB15jBCOXe/jwy14/LSBGTdI9l//9IknNwPVRe0ZTXBqRCbaIvh0HUju2IaCi5MsovyNEcfkL8BokMjEEWw9ERtCxpycSEq/olgvpaxBiePSKpuZ+R/veGnc3dQ7N2z9cHeqiF4IJ6Z/d+TtiaaiVPSXuNr2K9BVVbnB5J5P2HWYX+INPgclbSZ1W10i0NCp1E/x4DhwyYR0SRuGrIXoXW87z1/6jyjQ8dz5+ZVKyv9w/4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FC4jHj/XAFBV6YsKSHEJc1vlqGPCbOs5tiA/aoQPau4=;
 b=JHy/5FocaTw09g2DnA4gntrx1vWGuXdR3fc8skoOjC3/IwkzNYuWcVlZt+FvkHcMEUFhpHBXsLxim0oCkTmo9FcR5XPEwkxExn4NE/tLW7UIRc6JzI7MUyBhd2QP3y97LwbyqnDDobNlFI2tVt0FNiRDQGvzrIuW7B9aSpuEO5/GjWkUA4JN6r36EF63tBGQYZFRaATwY1KB7BwFLo991ni30zFqkt/e+/MEC5LqRW+Qklh9zF7Smny9UJdbgxrqBzYo2TfM4Tj1yWXYLx4XH+QDVdHKICSp40e/W6r1W5UP9bq43SwqhfyxTunOoAt1PcwyERTNiH9C/fm1h6kPaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by CY5PR11MB6318.namprd11.prod.outlook.com (2603:10b6:930:3e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Wed, 10 May
 2023 00:07:08 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::591f:4873:fd80:9a6d]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::591f:4873:fd80:9a6d%6]) with mapi id 15.20.6363.032; Wed, 10 May 2023
 00:07:08 +0000
Message-ID: <ae3cbde7-1137-1b33-dbb8-ae8892abddc7@intel.com>
Date:   Tue, 9 May 2023 17:07:05 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.10.1
Subject: Re: [RFC PATCH 0/7] Add driver registration i/f to resctrl
Content-Language: en-US
To:     "Luck, Tony" <tony.luck@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Shaopeng Tan <tan.shaopeng@fujitsu.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        James Morse <james.morse@arm.com>,
        "Babu Moger" <babu.moger@amd.com>
CC:     "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20230420220636.53527-1-tony.luck@intel.com>
 <c0755752-ce84-b5f9-6ac6-97812e98b8c3@intel.com>
 <SJ1PR11MB60832074F3140B38C1B08596FC719@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <237603b3-f553-2ede-5725-239b65626c69@intel.com>
 <SJ1PR11MB6083CFFA8CBDD296E966EC85FC769@SJ1PR11MB6083.namprd11.prod.outlook.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <SJ1PR11MB6083CFFA8CBDD296E966EC85FC769@SJ1PR11MB6083.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0180.namprd03.prod.outlook.com
 (2603:10b6:a03:338::35) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|CY5PR11MB6318:EE_
X-MS-Office365-Filtering-Correlation-Id: 199e5386-2e21-49de-4e5c-08db50ea7ea5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zxNjd7NEiv1koxH4sahzFU39212OVtY209bOFfIyh+GFQRe5Nc1jf0+J2BhEkqki2WkIHWeXNYel3l6vGvbue/SEwQZA6y9ZGD30rfebWsmLoMq9Igf3h179C8YtzGyKRyMY8oypt3Q+ReHOB1eAz85h/RF093Mqij1Kwie/7FNaDLgsRnZyTLw4/2vLFA3MhHbznn/Xx7QLPu+4bMXEu3UzdHIZktbOSn6xtBzmWM2NXq/QwZHRBlwf4nYnWShD+hdzChM46Ny/0VMPwmc3lQdgyZQnxBDLXnPkhxEAE8B9j+eTBSHpXU9ADx4s6owqY/us7jLAH8piPLrKEccuMysgEyAlHq4ZQ8uOcN8SqiIwwKoCvHNYqNC6zHef8zGNb4M5pym4rEbAjbVfTAerUjFz5eYl1BR4NInTPzpmI/YqR+eXcwjY0wsccqdrULTdDM5aSQcWK2PIxPLjuUWy8hI58p0bNraxXj1LRhTMonxeLkZzI/2/JNtGHsYL6ijI/XNtji9EXZyELBBXc8tgT2lv98Jsye9MYJAAGVwU7/WLzQ76hQFIYeSSVcWFZ1wldu6AOk8Pt1vGNo5Kx0C3dC8dx3MFh8gXnRd85VTRvP1V69PTrj/fwEiLz9imIakjdZz+JhcVHdnKGHLOHw50WY50kfqjc4bMcsKCN3MlsJc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(366004)(376002)(39860400002)(346002)(136003)(451199021)(31686004)(478600001)(4326008)(316002)(6486002)(66946007)(110136005)(66476007)(54906003)(86362001)(66556008)(36756003)(31696002)(83380400001)(6512007)(6506007)(2616005)(53546011)(26005)(6666004)(5660300002)(44832011)(2906002)(7416002)(41300700001)(8676002)(8936002)(38100700002)(82960400001)(921005)(186003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bG1hNmw5VmwrUGJ6UE5nM2N5Zks4Q1g4c3JtQ0g5T0ZwWnBiemZnK0FTVDZV?=
 =?utf-8?B?MHVXYzFKb3JmQmRBZmk5N3p4aHBRTHJRKzVyeld5VU9QNHRiS29Jd2xETzE2?=
 =?utf-8?B?S3J4UnNNWWkxVjVFWE4rTmtKM21nTzU2aWl3K084dUZWVWdnNS9FMGx1QlBt?=
 =?utf-8?B?VzYyb1piMk5tSjhnRTB3Y1F0dERjMjlGRGVNTHhaQmowMEtSZXlpV0g1bHFo?=
 =?utf-8?B?Q3BiaXYxSDh1ZU51LzNXLzdDNHlWUUdESHA1Uy9XdDdEUmVUTGxFdm1RMGFi?=
 =?utf-8?B?aXdNMVBsc1djUkJXVFdtYy9vNEs0em9NVUwrN1B2S3k3amJHd1VwR1hrK3U0?=
 =?utf-8?B?RW1RRGwvKzdQYnFoTEpUUit4c01jbXVEMXM3cGVxR2txQzArbTh6c1g5d2M4?=
 =?utf-8?B?enF5QkRyU044QzN3YU5qNStWOXU2M3k5MCtpYi9HeDBEemgrcGRRMTJQWTRC?=
 =?utf-8?B?M1Jwc1hMbFhsVllMRnFQNWI2K0FzM1dLalM5NVpoQkZFWnJvdzRHamYzNWg2?=
 =?utf-8?B?dXg5NGhRb0doV1BySHZHM2hVcm16b2xPWHRCSlJvdFR0NXFDSk5nWkwwd3FX?=
 =?utf-8?B?Q0NRMHNySUtGTGVnQktrWUVUVUpHUjlGeFVBazVKeHhIUndKd3hwRmQ4NnBN?=
 =?utf-8?B?bStOeEVUUEZpRkxDMUhLUHlwUlNLbldjSHkvS1FDTk1GUWtreTJRVCt1b240?=
 =?utf-8?B?S1pMd1l5K294dGJaTzdiRjF6dFR2aEdOT3ZWTytISzNSazlHVEVGSFhsL2ZD?=
 =?utf-8?B?enIyQmJ6RlQyQVhENFpTY2U1S0JMK2pndzVjL05JdUxyZnE5YTNrSGxWc0ht?=
 =?utf-8?B?ZkVzeWJuUmFwaXZIYUFOVEExK0kwWmZiaTA1OXlSUVVOZytJaXdIZ3JKRHJi?=
 =?utf-8?B?b21WdFAzR0Y0U1ZOQXVyR1VPMFZZLzJOTlZCUVZqQy9YcnNUc0VyenZXUk05?=
 =?utf-8?B?bWtnVGdEa00xbkZpYmo1NDRrQzRCeHZuQlpkRFEycGZOMXVGemtDMGM3bE9w?=
 =?utf-8?B?YzZXQ3RaMGUvTUE2WDFUNjZYTzV0RnZGUTdQcFJnQkZZT3Y1cEZoUE81cUQ1?=
 =?utf-8?B?Uml5bGtCejFqazE2aUYrS0p5eGM2YWIyQUxudHFDV2FkVkI5b2M5ODlQRkFS?=
 =?utf-8?B?WFlLUkl0emJ1cWxPRHVhRy9PQkMwems0WjhiaGJCd0pJQVFtdm52MW5nRmN4?=
 =?utf-8?B?Y05kb3Yrb0MyeDlHQ0sreDVra3pFR0Q0QTI0OUY3N0xGQnFuU1QySlkwRmRn?=
 =?utf-8?B?V1RqeWtYcVlpeHJEaTAxcGN4YXdiWTRJS3ZFOVV3VE9ja2JyRzJiVyszeWxE?=
 =?utf-8?B?Yjh1b09Jb3BmbkFKVy8rMi9PQlVPcDBnY0dzeTRCRjFDaTJwckwwZVIxNVNL?=
 =?utf-8?B?cTZ0eVFOMnlkeVBKaGE4cVVoL08vYkZBS2tmUFpib01GYlNTWHRyZkZubjJM?=
 =?utf-8?B?QS95aUxJamNjK0YwL3VweGc5WVdOelU3em5hZUQ4bmtaOUJTMnU3SWpHRGxT?=
 =?utf-8?B?K1RaNHpqeEtRQkNiblF3YWtxckR3bUtTVEFXWm13aGxuS2l5Q0Q4SXJ0K1JL?=
 =?utf-8?B?VzBnMDArejNYSmNYYTExdU1iRnFBN0xGeFZDUE9oZ3dheG5ZVHlhSndhbmk1?=
 =?utf-8?B?NVV3VVVtdzc2NXZhSWhRcXZ4cDVIUDZaRnY2WUhYM1pUSytFQzlYd216WEFw?=
 =?utf-8?B?dXZxeHB6QmV0REhZK1JKSzF2RExBQ1M2ODdlbjNFWWhqalNVc0lkb2VhQS9N?=
 =?utf-8?B?MFFtTnEyN3NUamhYaU1tU0M1NlpmRGJFcVoyblNKa0lSRGkxL2RLYnp0MXgr?=
 =?utf-8?B?ZTZTZGZHdjRNV3BsRjVOQlNVdTlZMlRUWHhCWVFOS1NDTDNzZHduTXJNSnl4?=
 =?utf-8?B?QS93Y1JrdDFDNXZzL3gwVFBIa2VnNWRNWkVZK0xJdEs3eExRdTdIQlFLMXBp?=
 =?utf-8?B?cnkyRjJGNStGdGN2SXBJSmZ5akwzR3FMMVJlcHBzWmlKR2h3UUlCR0U2VnBS?=
 =?utf-8?B?cEZCNS9LN2VlaktsK09UN2lWZVdKTWtEYmFlbFBUMDRpQ3NZWE05RlYwTzdy?=
 =?utf-8?B?ekJFdTdKMUtlV2RWY0dTaEs3bmVsZDg3Y29XOUl5RDE0NXhmNU16dCtiM1dk?=
 =?utf-8?B?M2dWaWRHcjFBOExTcTVnMjFmYUFDWGJSNzNtTHRDUjEwaUFsY0NLVVkvYnly?=
 =?utf-8?B?c3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 199e5386-2e21-49de-4e5c-08db50ea7ea5
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2023 00:07:08.1996
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2/fYHLM5wzM/FLMLOmbviGLQ4JJD5HGORs2D5Rd0CvjynkgSVCSNYhlf/8GjjLhRr8Aej3BYIW7tE8AMk6QLohUcWvmMolFLUPuLK3VhlHo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6318
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tony,

On 5/9/2023 4:35 PM, Luck, Tony wrote:
>>> Intel has always had some model specific "RDT" features that we have
>>> not attempted to push to upstream. Rationale is that architectural features
>>> have lasting value across CPU generations. Once the code is upstream it
>>> "just works" (TM) for all time. Cluttering up core code with features that are
>>> only applicable to one or two CPU generations seemed like a recipe for
>>> disaster from a long-term maintenance perspective.
>>
>> Could you please elaborate how this seems like a "recipe for disaster"? I
>> can certainly see how removing a driver is easy when it is decided that
>> something is "end of life". I rarely see "end of life" in practice
>> though and viewing removal of obsolete code from a driver as a "disaster"
>> is not clear to me. Re-factoring code occurs frequently.
> 
> I'm thinking of the amount of code under arch/x86/kernel/cpu/resctrl. In
> v6.4-rc1 it looks like:
> 
> $ wc -l $resctrl/*.[ch]
>    996 arch/x86/kernel/cpu/resctrl/core.c
>    581 arch/x86/kernel/cpu/resctrl/ctrlmondata.c
>    560 arch/x86/kernel/cpu/resctrl/internal.h
>    845 arch/x86/kernel/cpu/resctrl/monitor.c
>   1600 arch/x86/kernel/cpu/resctrl/pseudo_lock.c
>     43 arch/x86/kernel/cpu/resctrl/pseudo_lock_event.h
>   3733 arch/x86/kernel/cpu/resctrl/rdtgroup.c
>   8358 total
> 
> Fenghua did a built-in implementation for one of the features that I'd
> like to implement as a driver and the bottom line of "git diff --stat" for
> his series of patches was:
> 
> 9 files changed, 1300 insertions(+), 10 deletions(-)
> 
> Projecting forward a few CPU generations there may be 2-3 different
> versions of that code. Plus all the other model specific features that
> we'd like to support. The core resctrl architectural code is going to
> disappear in the maze of "do this for CPU models X & Y, but do that
> for CPU model Z". 

It is hard to tell from just a diffstat how this implementation impacts
the core. A similar diffstat for the driver implementation may
help. "1300 insertions(+), 10 deletions(-)" does not seem like a lot of 
core refactoring.

>>> Q2) What about exclusive groups?
>>> A2) I didn’t try to handle in this RFC. Additional bits will be needed.
>>
>> It seems like every time a driver needs "additional bits" it would impact
>> all the other drivers.
> 
> It depends. If the new hook is just some additional callback function, then
> existing drivers would have an implied ".newfunc = NULL," in the registration
> structure. So wouldn't need any changes.
> 
> The hooks I implemented in my RFC series are the union of the requirements
> of each driver. But each driver just sets up the hooks that it needs. E.g. my
> silly example driver only used the "add files to the ctrlmon directories" hook.

My point is that the hooks themselves appear to be made safe by just providing
limited information (no pointers back to structures maintained by resctrl) and
thus when a new driver has different requirements it would have broad impact.
Similar to the example driver that you provided, if I understood correctly it
already pointed out that there may be a missing parameter of the group type
(control vs monitor).

>> The second part of my original question was "Where would it be decided whether
>> the overriding driver should be loaded and why can that logic not be in
>> enumeration within resctrl?" It is the user that needs to determine that there are
>> conflicting resources?
> 
> The horror of model specific features is appalling, or non-existent, enumeration.
> In the dim and distant past of resctrl there was once a point where it did
> sting compares of model strings against a list of specific SKUs that supported
> early RDT features.

My question was trying to understand where this logic is moved to (re. "Where would
it be decided whether the overriding driver should be loaded"). The feature will
remain model specific whether it is implemented in the core or a driver, so these
checks will need to be done somewhere, no? 

> 
>>> Q6) Domain awareness of drivers.
>>> A6) This is a challenge. Especially as the domain for a driver may not match up
>>> with any existing resource scope (e.g. driver may be socket scoped, which may
>>> not be the same as "L3 cache" scoped). After I posted this series I added
>>> an entry in the resource table with socket scope to handle this. Dynamically adding
>>> a new resource with a custom scope has challenges (because the domain lists
>>> attached to that resource are maintained by the resctrl cpu hot plug callbacks as
>>> CPUs come online and go offline.
>>
>> My comment was not about a need to make drivers "domain aware". My assumption was that
>> drivers are not domain aware since I did not see any related information shared
>> with the drivers and since the drivers override the schemata entries I thus assumed
>> that the schemata entries use some driver specific scope.
>> The challenge to add a resource with a custom scope seems like the biggest problem
>> raised thus far. Is this perhaps what started the venture down this driver interface?
> 
> New domain scopes wasn't a driving motivation, just a thing that was found along
> the implementation journey. After playing with some ways to have each driver keep
> track of scope I found that I'd replicated some of the core domain tracking cpuhp
> code and decided that juat making the core keep track of a socket scoped resource
> with call backs to the driver(s) for socket add/delete was the cleanest way to go.
> 
> That might mean asking the core to track other scopes (like "tile") in future if some
> control/measure feature has that scope. Having created a "node" scope in my
> patch series for SNC[1], it then is quite trivial to add additional resources
> with any scope needed.

I see. I thought that tracking scope was the hardest problem needing solving
in the driver.

Reinette
