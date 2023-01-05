Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 643DE65E195
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 01:32:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234837AbjAEAcn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 19:32:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235409AbjAEAcA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 19:32:00 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13BB2574FB;
        Wed,  4 Jan 2023 16:30:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672878600; x=1704414600;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=LaEUpsPi66h5meDI3l4P44uEuu+W+4yiLkMXXysu/F8=;
  b=ZoWtlWEYq1GVr/y1rCNeuXGZqUlrHE9wsSrnWGf6rd8zgoBMDXGvjjj2
   uPAiWtUbzyyLxD6EW1av/IBJWA/GcqT5HVL9jTe71e2fpZZOzzhrJnQiK
   Zg7gi3GAC0kQuB5/ZV9aBtB1y/2i/ru++r+oy1UDxgJHygamgqFewHJVs
   JXcBr5FRaThrf7iFSze+REfyeEY6jUJY8YcfeUGbS52GQ/9RCjrBauU4+
   rEdSuTESaUK8WcCgZ/DGGB2+PafbHsqQj/Rf0hpqBWQybB55xfhOr5A8p
   Lf8p6NL/HiPyyBhzsuDzqm6i7GVc04J8743hZXHqLrSkMH3ZMxGllImsP
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10580"; a="324081321"
X-IronPort-AV: E=Sophos;i="5.96,301,1665471600"; 
   d="scan'208";a="324081321"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2023 16:29:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10580"; a="900750951"
X-IronPort-AV: E=Sophos;i="5.96,301,1665471600"; 
   d="scan'208";a="900750951"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga006.fm.intel.com with ESMTP; 04 Jan 2023 16:29:56 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 4 Jan 2023 16:29:55 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 4 Jan 2023 16:29:55 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 4 Jan 2023 16:29:55 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.173)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 4 Jan 2023 16:29:55 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VSXG8dn0CzzTEjGD6E8ReR6tSFVIqZ1WMbGz0RLlzM24UlRbhbPTAOgdN1TDiJDqpE4pdfCdgAxWZhuQST3IgNODtb8385acBBderFJJynGiCRfRuO2MPGA3ayTKxa5taKM7i7ZNJMhyDRQeLRGj55bG3YwtHyd6t5QKSIK4cdsSN3n/tBsBQLeV3g9opBnaepuKBknypK3iZfBaejh4if9u+9NbktlDuh/Gt2oZE2eiySO+GLtkLKGgcghL8n7iqLysvmPn6b25ZxSg0TjtDmVvGDqLUnshAiyJQJgIqvXz+/dVkDrh/Rtn6uXdlWFQBw7HRvpLy/RBMdKtMzfStQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ITmjr4vh7C9kdwK27QogFVism7GclX/daGb6Jiyn9SE=;
 b=TXCQI6C0Ox4p/CxHZucpUeRIWut5k41QGDyPi22ZAl+pWqdJxXhp9XW3WDxiDUhXkmDYrlczjklGfXo3/bEE7R1N2jg8DzxrJO0ciiecTSzwE2PUMr3q4vosU88HS7Ubup6tBlrp5z4nJ957Ou4A/l4gv8grqWi5IXECJEq8pDGqyrkI7Ev92BUz9yP4orDD5t728713vO8KTYvGKpudffAZZNZF/waWZhsMcyCNIz0kcSqE9FcABgqv9dftIUCE0M4b3iQOeNLEEB9hjcTcP7hAHj+yghx0706c6HC8vNeDIKn9WHdcljg2yfCHIn4ypv+bk5U9EJp1E4+H8OVqhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by DS0PR11MB7507.namprd11.prod.outlook.com (2603:10b6:8:150::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Thu, 5 Jan
 2023 00:29:48 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::a1f7:e4c4:e60:c5b3]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::a1f7:e4c4:e60:c5b3%6]) with mapi id 15.20.5944.019; Thu, 5 Jan 2023
 00:29:48 +0000
Message-ID: <3dc31a6d-5485-746d-3c49-df7dcd1827e3@intel.com>
Date:   Wed, 4 Jan 2023 16:29:44 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.6.1
Subject: Re: [PATCH v10 11/13] x86/resctrl: Add interface to write
 mbm_total_bytes_config
To:     Babu Moger <babu.moger@amd.com>, <corbet@lwn.net>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>
CC:     <fenghua.yu@intel.com>, <dave.hansen@linux.intel.com>,
        <x86@kernel.org>, <hpa@zytor.com>, <paulmck@kernel.org>,
        <akpm@linux-foundation.org>, <quic_neeraju@quicinc.com>,
        <rdunlap@infradead.org>, <damien.lemoal@opensource.wdc.com>,
        <songmuchun@bytedance.com>, <peterz@infradead.org>,
        <jpoimboe@kernel.org>, <pbonzini@redhat.com>,
        <chang.seok.bae@intel.com>, <pawan.kumar.gupta@linux.intel.com>,
        <jmattson@google.com>, <daniel.sneddon@linux.intel.com>,
        <sandipan.das@amd.com>, <tony.luck@intel.com>,
        <james.morse@arm.com>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <bagasdotme@gmail.com>,
        <eranian@google.com>, <christophe.leroy@csgroup.eu>,
        <jarkko@kernel.org>, <adrian.hunter@intel.com>,
        <quic_jiles@quicinc.com>, <peternewman@google.com>
References: <20221222233127.910538-1-babu.moger@amd.com>
 <20221222233127.910538-12-babu.moger@amd.com>
Content-Language: en-US
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20221222233127.910538-12-babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0201.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::26) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|DS0PR11MB7507:EE_
X-MS-Office365-Filtering-Correlation-Id: b4fb942b-75ae-4018-61c9-08daeeb3f3c8
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /PKxuGVEHzu9w2PwwgQZ9dwADZQoAMb1Hu0XORtXDbch2uiZvlpadzrv6n0cd/xD73Wwr/u0hqT3zM/LY793CGFQjN1hDaM4h35mb0VGvIHg89gyrGKbtblWfJW2WeZ+4Jbzh05d97wcMgFaWlfY5jG4IyLmRb69bY1LN7sjAHrJ3E7ot8hlR+t753fzyhtSLcZ7gZt3MkdxVPldvSA89rS6xlf2bbidWzYvjrRtyCKYB8NYGW3r4PyaHA45wpGy5fgNlURXHuDO8Go0G0RFe/nnBtYWjTmydrb+hPLzpxZqlQQfq3wamGQYywjytV6aoGcnQsERiNk7gKZq/QHP3QEWi4dIrx/PqbckJAHtUdeijMQuBlap9Z5NZ6COaHpBc61wajQ0KoweS4pGXvQscufKPu8vqNfNXJiBDGZHt7j59EWI5iQ5lG2II9Wynb9P3ffMyx+MTjpVjXhjYY0J+FkivnWXLuO6LLughKJhVPNcLXO8okJWpe5vPPj/CoiEIoBfzQDBtkERoCqim99wPKf0T7uGmmkdFVw0g8T58tZgGjAvnWnT0tDZSMbI247shtu3QJA1oFEdfvtTkIhnVEQJcX4pixZBB08/C0YcuIHMWVRfoLRLrd3OH8ypCOwGFqd0WX5lORPqhUl2XFO4fZsdrqVz/V2xLZcC0RQwDA/kl9qrZ/ds9cjqkJkBPU0eUYYnip4W2WgzLh6wlWdq3RGL4wvCp9s0PLWwEqbbwZE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(366004)(39860400002)(376002)(346002)(136003)(451199015)(83380400001)(2616005)(31696002)(86362001)(82960400001)(316002)(4744005)(36756003)(38100700002)(31686004)(2906002)(44832011)(8936002)(4326008)(66946007)(41300700001)(7416002)(7406005)(66476007)(66556008)(8676002)(5660300002)(53546011)(6512007)(186003)(26005)(6666004)(6486002)(478600001)(6506007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dVNJTU1YdWo2TFJ0cmhxL29xU2J1ZVRHaE9OQUh1NC9IbWkxYU5BS3dXR1pD?=
 =?utf-8?B?UVpwbGt3K3VlTGlWaXpBdlIxcS82WGdtUmM3Y0QvWGxYSEo3NGs0VEl6SFIv?=
 =?utf-8?B?TUl3Q01yUFdlcUdMRnVnRldFV3J0Uzk5SUt1RUNNcmRrNkV5YkxnTzRTMjB1?=
 =?utf-8?B?R0ZJeXpkSU5aZHRRNHNVQWtPL0h2Mjg2UWcyd09GSTk0d3MrNXFvckxiVlUw?=
 =?utf-8?B?aUV2cmNvN3JHMUNhUmlYa2NvQ20vQzVodTZvcnVzSElybjVIU2U3THhuTjhR?=
 =?utf-8?B?VllPR0tCS3JaTTNBQ3EyUEpmM1FicXRqbHB6SWV3S2Q5a1hHbC9zTUxFM3lY?=
 =?utf-8?B?K3FKK29tOGJpSXU5ZnFmVVlZaW1Rak9CaEV4R0h5YVd6VjVKQVQ5UnVTUm0z?=
 =?utf-8?B?dXQrZDJBUUxjRkhaelF3L0VaTFVFMlZRQndxd0NTaVFnMzRKMm51SjZUdlBN?=
 =?utf-8?B?TTh3alJRbExCY3ZPV09nTHJVTTR0TlI4R25aR1FueXBuVjhIZm00aURJTXI0?=
 =?utf-8?B?SzlIL3NoUWJvUUtPRVlMOElaVzc4aEZqVlUrZGNTaHR0dHpkVGNwN2dPcXB1?=
 =?utf-8?B?MERxK29PNXdQNWN0bVAzSThOeG4xMCtxK2RyWUIrUnYxQXZHL01RdUYwV1RW?=
 =?utf-8?B?b0xyMW5nMVhkWlpGcVVJZDlPNTVxMlhsajB4YWZMRUNtOGdXSTNPaklGMFAz?=
 =?utf-8?B?L1RtTEVSeklIWjVKQjhoelNLdmJTMXZoNzRxV0VVZGxNbVN0MnVvV3NmdUpp?=
 =?utf-8?B?NzIrd0dId050dFZ6bDdYVkxXOVlWNFhwcDRBUi9aSmNSK01SNXB1eWFaZzRs?=
 =?utf-8?B?QlJPOHFuODFiYUpZdy9FWFFiS1Q5OXpsTkpWUmxOWlpaOE40Z2FuR0VDcXFE?=
 =?utf-8?B?Wk1ocHBXUEE1UWo1dkNxNmkzNUh0Q2N0TmF0d3F5Z0FxZlVCQzIzaHU5Zjdq?=
 =?utf-8?B?WVM3WTV6a2h2empjUXRLS0hVRzVFRlkreGY0UEx5OHZsOWVFc0NjYTFsTU5H?=
 =?utf-8?B?NEUxRS9TRVdsM1BFeXJoWWdoL1A4cEtPWUQ4QktSRG1jQU5XVHFjWDFTdmNB?=
 =?utf-8?B?d0V6OUV4Y0RyNlRsb2tqMmFJQlZkelQweUhvYVl0dE9ZcGx4QjgvQndXUVhU?=
 =?utf-8?B?Wk9KbTZXSXZiME41dGRuK0p5em0vcDJnL0tlTjk0VFR1NW5zSEd1QTNOK0hr?=
 =?utf-8?B?Vi93UThyd0g0WkI2dlYvVTF0WVZ2NVJYSUJQcHVSYTIwRDIrMkVteXdXajNs?=
 =?utf-8?B?RUFzVUVGMXlRK1ZzVVhsOTVyaUdKOTExaC9Od2pTZVdDUGJFVjR0cHpiMWlh?=
 =?utf-8?B?SitGM053RHNHY1FaNGFBSk9TMmRBSEduQnIvaUl2dER3djU0QXludE9rUjRQ?=
 =?utf-8?B?bVZTd012aFQ3aVZIVTNaRzNRc2dlSmRtV3R2VTl1SlMzc3hyUXFwRkEvQ1hQ?=
 =?utf-8?B?ejlkajhvaFJTVlZSU2FGMkJXVHRMeldqc2RuUWUzS3NNbjlvR3ZBSVYrVnZS?=
 =?utf-8?B?T1BHTGRtVFR5QkxudUhYbjBzMVJYOXBZVGlZTHhkdG1kTXVjc1dVV0FZNEhW?=
 =?utf-8?B?VVJsWEF4OFVHWVFueWc3dWxPK3d4bGloeGc5dkpwMGowbW5LaHVaZEVWMlNH?=
 =?utf-8?B?NEJMdWMxWitmMysyUGJFekx4VDRoTnBkVForN3NJMVdDN05HaTJGeWsvWGRF?=
 =?utf-8?B?cFVNeVNEZksvVHVleW5NTkhhaXRnbXBQN3JvbG82dnZXQkplN0xaaG1UczRM?=
 =?utf-8?B?OVd6NXhMeHc2cDR1Z2JacFVRYjRsQm9yTENoaEQra0Vwa3pDUHpTV3RtSk9q?=
 =?utf-8?B?ZGRaWWFEaXh3SFJQa1JLUGtRTlc4bTRHNWFVSFdxSi9GL2lGeExEMDVjYjFq?=
 =?utf-8?B?SUtYSllsTXFlR2toZHQ0L1AyVW9GWUVRdGxMNkZZcGRTblRINzk1cnk3cVRm?=
 =?utf-8?B?R3dQUXFWT09DZjZDSnVTdVlqR0I1dEJVS2ZpbWJBY1N0WmNpR2hsUG16NU04?=
 =?utf-8?B?WFNjdEtoYkluUGU5V1ZKTENsT2o1bTFNM05qMjJiRVk0bWpsYVJpdXFBemh4?=
 =?utf-8?B?WkRQMnhuQkJTUjNuWDI3NUp6bG84NnZJVnBLOHExY3JURmtDS2FNOGdPM202?=
 =?utf-8?B?ckVvd2o2aDFQWHhwUnZ6eEJ6RU5ySTVGOHlnWWV3OVJkcCs5WStJWmRUMExL?=
 =?utf-8?B?Wmc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b4fb942b-75ae-4018-61c9-08daeeb3f3c8
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2023 00:29:48.4929
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZqQaWX1f9Qa2UrxwM1fSL0+XbM/q3mK+FZH8eQTNRZNeJsRtH3WwNLs3WGuWPduV7m/Y8vE8AN5Z7h9I46JePrcnhMIkpr9HJ6anRbu6Pk8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7507
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Babu,

On 12/22/2022 3:31 PM, Babu Moger wrote:

...

> +static ssize_t mbm_total_bytes_config_write(struct kernfs_open_file *of,
> +					    char *buf, size_t nbytes,
> +					    loff_t off)
> +{
> +	struct rdt_resource *r = of->kn->parent->priv;
> +	int ret;
> +
> +	/* Valid input requires a trailing newline */
> +	if (nbytes == 0 || buf[nbytes - 1] != '\n')
> +		return -EINVAL;
> +
> +	cpus_read_lock();

Could you please elaborate why this lock is needed here as
well as in the following patch?

Reinette

