Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B7DE62374C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 00:11:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232036AbiKIXLS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 18:11:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232128AbiKIXK4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 18:10:56 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BD7B2CE32;
        Wed,  9 Nov 2022 15:10:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668035442; x=1699571442;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=24Ek6PsGVWO0nCtHmkK13OO4VH9Cg2Hkdu97iuHEI+c=;
  b=P+XQbCQxvOrpqg+CeGI814BhzjPeq2QxJhdgbLNquEi0MNVOUQeTBQHA
   Ok+EcFloP/kXChPS1kVV3GzabZJloh/5pvLwI8kHYJEahumZXoW8VydcD
   CR4kefQFOmkm1PNQZu7QgflCGQHYmTGmdxUqo+bUiUHQyhBtqwrAd2Ps8
   yKLLN+R2/n6KLH4/bGn5NnuE447F2IVsoNX9ft0fuG0w6rkV49jD0M3FY
   4ZSnLpalAxiGHD1xpPFd57cvaU7Lz+u2QnOOfAQcjO7LCkE2d7cJY6gdc
   692Ny63Led220cTIzV+wv1HOLABBaR/uJhJB+/Mh7imjlpWEqYQ5sTPw3
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10526"; a="290867736"
X-IronPort-AV: E=Sophos;i="5.96,152,1665471600"; 
   d="scan'208";a="290867736"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2022 15:10:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10526"; a="700556662"
X-IronPort-AV: E=Sophos;i="5.96,152,1665471600"; 
   d="scan'208";a="700556662"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga008.fm.intel.com with ESMTP; 09 Nov 2022 15:10:41 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 9 Nov 2022 15:10:41 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 9 Nov 2022 15:10:40 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 9 Nov 2022 15:10:40 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.46) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 9 Nov 2022 15:10:40 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BYkYCMEdPQpAfWt1HhRct1xH/IwJSnaB3USx80v6XsrN2bvZQVOFY8WbbulIJ1pgNafBkELIBFR8NsOi5UwoTJgfOUbYM7q3Q9D3yDlMm4SRLvCx6CduyyC9sEIk7MmKMe+rtSdfgrWIoR/Nsmt+J+GI21GC00eC1F2Pee1G3cuYqKOObYfwUVuJvsb9mw1QtECe/xMsp/vPlwl9oEYEMbQ93lMyIYuLF+ha3kuVzb67lshd2eRtrzm8KJHn0UGCevGW4Xt57WW2Mdngl9ROhKnFHVxy0XZppHn6QPufRSzp+55pIZGTIgyoswgS//D3Ytc7cE68rJzAv7JMUUhr6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Frd7T8LbEWzcxzcJuKpvkJvqK7tNkRZVmXD3VENcWyA=;
 b=KIdjjlUbPEAYv0x2YJeM769LBeDFuvWRK69N9PEMqQgIpc/i1osHvyvwQxZdiiM8UTJukYaWhRNIL5c66MKiwdBgCXpsWicWGRMiMAULZwrfWW5oC63jCZk9Yf/lH0oVP7nvB9HhaFnLrMU7nNemNQmwcl1ocut2KPxr9giNrsVcwt1p+fw2A/j5Hb8HmoxVyTwgq+dtg25sOuB2dXocWaGEy29KzTZdraJR6mLsSJdLbZoxwO1YepooxUQ1PGf3CPyeGIwJZN5BDwN5EFztqUfZlaq48K00X1QPDjbqCqGR+hvFMeq2pn5JHNfkbrVnoqCdTNR8NQNVy/KSOKLc1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by CY5PR11MB6140.namprd11.prod.outlook.com (2603:10b6:930:28::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.26; Wed, 9 Nov
 2022 23:10:38 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e475:190a:6680:232]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e475:190a:6680:232%7]) with mapi id 15.20.5791.027; Wed, 9 Nov 2022
 23:10:38 +0000
Message-ID: <affc2b90-9410-1757-d9e7-6dfe2a3e5be9@intel.com>
Date:   Wed, 9 Nov 2022 15:10:36 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH 10/14] platform/x86/intel/ifs: Add metadata validation
Content-Language: en-US
To:     Jithu Joseph <jithu.joseph@intel.com>, <hdegoede@redhat.com>,
        <markgross@kernel.org>
CC:     <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
        <gregkh@linuxfoundation.org>, <ashok.raj@intel.com>,
        <tony.luck@intel.com>, <linux-kernel@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>, <patches@lists.linux.dev>,
        <ravi.v.shankar@intel.com>, <thiago.macieira@intel.com>,
        <athenas.jimenez.gonzalez@intel.com>
References: <20221021203413.1220137-1-jithu.joseph@intel.com>
 <20221021203413.1220137-11-jithu.joseph@intel.com>
From:   Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <20221021203413.1220137-11-jithu.joseph@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0212.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::7) To BYAPR11MB3320.namprd11.prod.outlook.com
 (2603:10b6:a03:18::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3320:EE_|CY5PR11MB6140:EE_
X-MS-Office365-Filtering-Correlation-Id: cfd63b77-e678-4812-a401-08dac2a79d60
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qQo2xugNw05sh2mdnAVrbMfXuAReYJ8MiNWBS0btVtB9n9n4U+GIsb6xiE1YIoew7TULRn1XuRFZzJ+OhxESmFKGZs+9nyL47ckYxCGpQhXjy951P0HnfvY3FA03uEzqJFhj7Ohy19FzTdRQwJYvrTlkFiGx6LC6sG9BpkgM0RtMCt4YUc9/OEac097IzG/jAscq1baEFf3KerbrmsAKoc5jcA59jgl+6o6zphP0Of2/ht585r2/9IIBESpMeqGlkwKB81wXzbfWlhZWVyhzfXM+hLHHpve9DhZ9K0GNDOK/OuWenaQdQr2Pr3/HWstonG73ZOw3ca4l1enXoeGN3fd5lUQB/WQjZ4mXSMPcmz1LplMhT3VfX+2rdaG1TM7mZDocJsUQ/GtR2ffAR0yPWag451JGtFTu9qy5fWj+ENHyxdUVohuHCYt5bMH6AVooe8A93wAZs1LyYn9UfHBhdsbBkIp09sHJlCPXiy1/8BKihQTbkb3Oe6YXecOXFzv5vbfYmch0mVPsS+dgawJmzlyew+2XqjEV9bDM8gvEqqEA/JUzVXpqSzhnHk3L3JHjrr59BxEWXzaiqp/3N7XLqR0BWSUW8eLPe0reIPb/rgkLVZHb3QHxSbqYNJKsb2qDtQDWmWtsq7+zBUCYa9Bb0Tb7RGqKFdQ/anWyg21YJVYGP9rlEL+sVampocuXItbaUWXGcuBwyp73lK59lpL4my1Xhl3R1NFqtqODcgIEVYkrNA8s/IT12oa4Mi064j83KEgknTgSuBpzQwH5SqzCfaxOhbU9TrfCHWavrq21nu0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(39860400002)(396003)(376002)(366004)(136003)(451199015)(36756003)(31686004)(31696002)(86362001)(41300700001)(7416002)(44832011)(4744005)(82960400001)(38100700002)(53546011)(6506007)(2906002)(83380400001)(2616005)(186003)(26005)(6512007)(66946007)(66476007)(8676002)(5660300002)(478600001)(316002)(4326008)(8936002)(66556008)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V3ZCdnhYdWg4b2FGR2VFWFROQVY4Sk9FL0o4ZTFWQlJzZGlsU2hOT24zM3JN?=
 =?utf-8?B?YnprT0s2ZUswVTZrb09mc3pFNnZwTkFvaVF0L2o5ZmdWNUpjVlpUT0NUd0w3?=
 =?utf-8?B?Q0szQk5Nbm5seDRjY1BuQ1hRZEY2a3FIeFBxb3ZZYkMzajFxMmhXTUwvNFV6?=
 =?utf-8?B?M3VmSE5Tazd3NDVhYW1hR3ZVUnFXM3VVNE1tVWJub09nQjNhbU9BZnd1cjB4?=
 =?utf-8?B?WG8vRG8zbjFjYkNQV3E3R280NkoxOWoxR2xGaGQ1cUdiWm1LdTNKVXd3RzdM?=
 =?utf-8?B?L1pKY1h3NTdDZmthRzhCL0hvVUpSRkhZWDNGdjE1KzcwU1ZYc040bkZIOW1q?=
 =?utf-8?B?OXpPT0tkUUxlSzIwU2hKN0xjUUlyQ05rSGdESUh4VjVMcjFvOFZhTjFSNkpt?=
 =?utf-8?B?YnBHWVppbjRxSmM0RHRvUllGaUVqdFlFTGVZN2JSL1FlV0QwR1o1K0xGWXBL?=
 =?utf-8?B?ZDBoM3NZR2FZUS9qK3ROTVBuRkowaHQwaE5JOWdnTWErVm1QS0N1M3BlZ1p4?=
 =?utf-8?B?Zk9jaWdxM0prRHJ0MFh6ZTlXT29vU3BqWlc1Y1F1WTh5VHluZUZzRVRpU2Yw?=
 =?utf-8?B?eVVBc0RHK0pYL01Uc0dnUVlORUNZZkpZNXNkaFV1eHFOSjVUekZTTTVobW9i?=
 =?utf-8?B?enVMcFRvWHFOL1VuZnJWTWp6SnJ0dURrRUJpdDU0Z29KYnBPRGNLbGQ2cU5O?=
 =?utf-8?B?alBoV1FLVE5IdHUrSkVlZkptYWEvdFF2cXcvMVROT3kvMElnNHNJckpFWW1V?=
 =?utf-8?B?VVpIQW1LaTc5WCtsRlU0YkIyWWZjYnYrSXZJVkxqczdRamc0a21XNjZBR2Iw?=
 =?utf-8?B?VmlMRkJYVXE3UG9pQmRjLzY4MWNSOGZkM0dxRi9nSUd0TmhzdmM1TTdOeUVG?=
 =?utf-8?B?K1VGYThmZFphb0RHKzk5dnBsNkJjL1BkMTd3OXBFazd3ZjMwVmlhQ1RJU3R0?=
 =?utf-8?B?cS81eGQxYVUvaHFmTldMd1dtNk1GWXZqMzliRkJ0eWx2SEtHM0FXREJtNExC?=
 =?utf-8?B?ZWs4N2Vkc2s1cWhudmNwY0twL0dkUzROZU5QZ01McXd5eENIdVVyZUU0MWhS?=
 =?utf-8?B?b3JhMy9LaEpZOUNvMTRpeGhhbW9GZ1Urby95TGdva2xwVFNjYlhMcXVJYXBs?=
 =?utf-8?B?aHhJNUp1THpvbTJJcHA0M0twK3laaVkwQ2RtTUtBYjg3dWtaRkJSbTFRWEZ1?=
 =?utf-8?B?WWdzaGoycXcyWFNVZWRsUWFmZXdiQjNLRjBqZTk0REI0OXppOCs1VlNvQ3Mx?=
 =?utf-8?B?d3RHUHpGY3VUQjdMdVNEM1JqUHoxOVRFWW9kdmZTZ1drSG1ZM1BtaVRIMUl2?=
 =?utf-8?B?UEZacEIydEt6elFweGxnU2ZDeGd5cTNua0FaT0RVOWRqaTR1OHFUMGdyOG1R?=
 =?utf-8?B?eWZvZ2xaR1dMTm1VZFNCVnVXd2tRMFlLNXRYM05FRzVjS3AwdWFReUdkckhQ?=
 =?utf-8?B?bDJLQW5jTW13eE1mMnRoL0FpR242YXp4ZXRoNU54SXNnM1AyV0VKbHhCcVFa?=
 =?utf-8?B?dEVsam1DMzlMWE1wdmszMXh1SHZYODNidVBuYUluZXkyUVlOTmpMREhSOEp0?=
 =?utf-8?B?OFNBaEs2NmhDVlNDSDJoczBjMHBDelJrbno4VnVmUzRqWVlPd0l5b3I2RU1t?=
 =?utf-8?B?U3VuamRSUU0xUE1GVzVyV1pHWnNRSGUzTXA5REhuVGpjRXlsKzdRQTBwK2th?=
 =?utf-8?B?bkpqVmhOZ2p0SldrbkJGemkvUm1maVJ4bFFBZEMrZmVaenc3dm5OLzQ4MlVa?=
 =?utf-8?B?QTFwRS9QUnE2ZDc5dFFXbE93NStvTnBOL0RlL3RsSWphSWJZTXcxWml2WWNr?=
 =?utf-8?B?TExjTDF2VzlvVU1YaW0zWlpRR2M5NmxhVG5DUmhwS0daRk5IN2h0SGo2WmU0?=
 =?utf-8?B?aFFaQmRrcTE4V2pGOHg0OGVwblJNQklyMUVIdDhSM1h1cXhZTUdVbENkWDVr?=
 =?utf-8?B?U1NBT0VySEN3MXUzamhDcEhKanZFMk1DM09Vdk00WThKK2JlM2JZVmsxVWFP?=
 =?utf-8?B?dXpCQTE1QlA1L0JFUU1McW5PSFdaTkQ3eGxBNTFvSy9PbGh6YThXUG8zcnF1?=
 =?utf-8?B?TWJEZXpmekNEdEFNS0NST09IZmVpbEgwQkpZZHAxUGZyRS9Hd2J5cmwyRDU4?=
 =?utf-8?B?REJ5K0lrWUpiZXljNWNjSmFXVGhCRW1rYnh5UGxUQjBLeUNvSThSN0Y3anZH?=
 =?utf-8?B?YlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cfd63b77-e678-4812-a401-08dac2a79d60
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2022 23:10:38.3123
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JZ5P5AyK4WAe95ldkxIyutXrEAZlA5+X3SVBBYcbNmF3f5k78g+DqsMWLtCzTj97qFh6u4sqX5DIFDEIWTHmkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6140
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/21/2022 1:34 PM, Jithu Joseph wrote:
> The data portion of IFS test image file contains a meta-data
> structure in addition to test data and hashes.
> 
> Introduce the layout of this meta_data structure and validate
> the sanity of certain fields of the new-image before loading.
> 
> Tweak references to IFS test image chunks to reflect the updated
> layout of the test image.
> 

Can you provide some more information on the updated layout of the 
metadata structure?

Some parts of validate_ifs_metadata() like the ifs_test_image_ptr 
calculation would be easier to follow with that.
