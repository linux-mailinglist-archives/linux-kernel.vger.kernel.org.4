Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 745186F72EF
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 21:09:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230301AbjEDTJU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 15:09:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230302AbjEDTI5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 15:08:57 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7390A76A0;
        Thu,  4 May 2023 12:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683227290; x=1714763290;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=6WfK8zbFGpJ519aLY7l/5dBdm/Cd5rxYvaBj3XjR9Ac=;
  b=crLiSpzc5IKbDRpbP6ICzk2bcy46te6YL35Ebt8Jka3HJXheHjg+gOfE
   TCAO/5RlyG4xvZQzdYGMSXexjWtJ8vtmKqfBzbeQh92MlWU0dV2GdZnEA
   iYBYe6jjrTf1jGhFYURHbPi035ou1IjJVvBDCaLUTyp/S4ZZ5WEwgBYt3
   xbuKMfCH8JNof2UAvW9304gs9zw4IM2lenV1dso+NIc1FGo8T8SVfj6t6
   ZWWZ3Gs+MHHY5gzeccIfpSJabIPmvqYpJ3JBp3PHF5NLlm1sf1OknVWr5
   OD3pdnTY7pHv8TFTTjmWBQTQ8K0T+Fa1mEpjpCDzYYRiliX+BQ+KK/zsj
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10700"; a="414542542"
X-IronPort-AV: E=Sophos;i="5.99,250,1677571200"; 
   d="scan'208";a="414542542"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2023 11:58:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10700"; a="808864975"
X-IronPort-AV: E=Sophos;i="5.99,250,1677571200"; 
   d="scan'208";a="808864975"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga002.fm.intel.com with ESMTP; 04 May 2023 11:58:40 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 4 May 2023 11:58:40 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 4 May 2023 11:58:39 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 4 May 2023 11:58:39 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.49) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 4 May 2023 11:58:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kjGKZgmtrI2sC/sBC3FfpjUjhlBKbzBNvhBNsa0psmXIDJrBmtVdLJeJZVlZXiq2k/5PtY4poi4ziKvBJtfewGBFlRd8mYU+69EH85bPJ+lkhN+XlAzV81M6YBIY/OTL6e3zpkeCosqXuRusGVGwLjX72Bbfn4BLRbZDFCveJyYF8G/RbCw8Y+58F8fZT4rIywXjsgeLW+vGZfwqFikPgC7KzxXUmTVUJA6VEl0XylPAuIW+Z3zaHgoIWHqvCLHmCRzsg4hEfuRs+bkHhwi+oJtTu7L9Qy3vYHc5G73/eflFKif54DltXegw4ykxnOt5/eMR+1v7DVjEu0g+j7Xs1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6WfK8zbFGpJ519aLY7l/5dBdm/Cd5rxYvaBj3XjR9Ac=;
 b=HgS33NeepEK+VS0v/6KM1WPIseSfqIqwSub0Lwp7QshiLt/HwCELOr8+qjLvgoWQZpFkjqdqjBOx0UvSCbI0f1NkxbospiV+z5XJMYhTl6gkqF5clPmgZBP6fcnSBmRFSlgJVwfgdsgSv3LjyXoMFgaoynOwNotSFT+pHe8M5beJ+cw7dvZA3ytTx6c2nQyza8jbDgti03x6pF5w9B1nyv09ynd/zXRDlblmy7ppDYHUdiVkQAAbUTx+TbrvAPL5py+3AKBWtfK8FwH4VgkVo2UBRcJxWROGYvZtb3JHhOqNduYmlXrwIC1Fup46NU7eBwNwY34+TL+4KM0ehJ7d0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by PH0PR11MB4870.namprd11.prod.outlook.com (2603:10b6:510:34::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.26; Thu, 4 May
 2023 18:58:36 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::591f:4873:fd80:9a6d]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::591f:4873:fd80:9a6d%6]) with mapi id 15.20.6363.022; Thu, 4 May 2023
 18:58:36 +0000
Message-ID: <4275aa91-5834-2c03-f455-f1d3d666fec7@intel.com>
Date:   Thu, 4 May 2023 11:58:34 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.10.1
Subject: Re: [PATCH v4 2/7] x86/resctrl: Remove unnecessary rftype flags
Content-Language: en-US
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
References: <168177435378.1758847.8317743523931859131.stgit@bmoger-ubuntu>
 <168177445556.1758847.5029687867896978170.stgit@bmoger-ubuntu>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <168177445556.1758847.5029687867896978170.stgit@bmoger-ubuntu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR06CA0057.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::34) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|PH0PR11MB4870:EE_
X-MS-Office365-Filtering-Correlation-Id: aad20bd2-6e6c-4ffe-61e0-08db4cd190cb
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cwsaRxH//9bvrM+Z7IYng3XNNJbfOxo0P2vhW5BfTYSi9nFZjUQuvA+HDUjLW1Rl4yBs8O7Nm2LZvJ8do6xZlz7pk96XNTaK17WbA+vE8xzfiMksGgPi0PduRjVKmnHPnkKenlw8Em/G6WZ6YpF0TXvToqcSf0MOp8iwcEpUgWSZtT1HmOM3yIGgk7ePNP2Gj9gXkgvs6b82YXSpc7XE3CbEqfD3RYHj9h/a4C9JgWAFUHiGlHxaZR6IAhvcmB8e2Cs/QXsRbZZCKafP4K1R7AslyUZXl/OhpC5EXGU8FJsvEouzCtuUvVV538EoJiIFliKMWOwg53KSG8f0gd2ysj9Kzx7cJ8weFn7m13dE0D9oTrHcnCYW9cRtpkYLo1N/LksggthMBBqaNcDJO2AWhvvV4e4MJQRyF0gGZUknN1Jp0lFnjIho/y7X2pY7WWEf0L3GkfswgWA4mGB4sldEYXGZMg3RC32Udv1D//maKO4jTv/Jd61uqy0G4E8YiLo+PinfbFXRUoOMtBA0oqMXxAnY4+6Mmklyp/VdhZC+x55P1s4YYtVzSb+lRJS1HgIAXvkH6MLOB7EDxb9J7NVyzAMqzr9uFHNSRkgI9a1JE/BweEFP2VyNiXg0tsx7BVxSKxWQSH6b0xmSadq1PZuvkA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(396003)(136003)(346002)(39860400002)(366004)(451199021)(478600001)(6486002)(2616005)(26005)(53546011)(186003)(6506007)(6512007)(44832011)(7406005)(7416002)(2906002)(36756003)(5660300002)(38100700002)(558084003)(4326008)(66476007)(66946007)(41300700001)(66556008)(8676002)(8936002)(31696002)(316002)(86362001)(82960400001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RTkxeHozM01mY013NW9USGtqcEIrbXcxQzdhODh2SmdGTTdBKytCZ2lDQWR3?=
 =?utf-8?B?djhoSllGaGcwaGlFM09Nb1hqZHY3Nis3Nm1pVjJkWlM4Q0tQTG5JY3AxaEdO?=
 =?utf-8?B?VFlvSHI0YTNUek42QzNFSDhFQXVuZmtQTzVNdmxpN2hqd2xrNEEraVBzVzdj?=
 =?utf-8?B?N3hSWkcyUGtrdnZ5UDFPSmtJR25ncUxaME82dGFZN091cDJCa28ra3cxTzRD?=
 =?utf-8?B?R0lTalFtUlBxQnY4UUtWY0lYOUJnSVBseWV0U0pWLzM5UHpDTGtsa2loanNH?=
 =?utf-8?B?c2VEMnVaMVRPUmdpWXloU3g2V2orTVkveVFHMDFmUlZVd3Nla2xxR0tnSmF5?=
 =?utf-8?B?QzF0cUsrMTNMTnJOdnNzczZVMDNnOHJwYTZqcHF5MXkxV2pwbnZ6Q2JhZzJM?=
 =?utf-8?B?WnU4ME5lS3B4VEtkY2pRc1lTTm5XOEV4Y2ZPZFVwM3JNR1dRSkc0bVIrLzJT?=
 =?utf-8?B?eXhWTU8yZ3NuM0RBbEVaTFRqeGpDYTFzNkxpOEpTRUxSZDdlMnk4Ny9PZ3V3?=
 =?utf-8?B?V1pDajlOalZVNmc3VmtUTDgyYU1FOXhHVG1qakNPY3V1aUg4N0cvTGMzSzht?=
 =?utf-8?B?VHNmM3ZBYXVDUW01QkFuOGxmRzZQN3VnWFRrVVBrd2xaT2NTR3VZbU83NXNt?=
 =?utf-8?B?L2IzNFVVcE5wc3hFRjdHRGIzTHhrdzB4TzhlaEo5MFpFaGd3WERLRkpXNklP?=
 =?utf-8?B?blJxV2Rydi9NY2pkUXdqTzBoSG1QaGZHaXVtK1NSMnAxZjB2bUJsZnpUY0pD?=
 =?utf-8?B?b0xGbGxzbldaQjJLazBrQ3QycmxPWkZ5VWQ2QzhXajQvQ0d4K0UrV2JaeERL?=
 =?utf-8?B?UXNrR0p0aDlBUFltRnRXZlhEQkdsSStvY0ZtT2RYNDhwU05CT0o2ZTRjYXZ0?=
 =?utf-8?B?eDhWWERKV0w2QkVKZVo1UTRQeGpXeGNYUTBMc2hQL2NsSmM4WklJcTJmTjhk?=
 =?utf-8?B?WEZSSTlLaFJZS1M5eXJqU0MweEhtenI4TGdVSDFJQzJTWDhGNlNFT2ZjZ2RX?=
 =?utf-8?B?c0gzZW9UMjVXR0pHcjEwUi9kRjRycXR6Ui91MkRiMFJGYWd6TEhyWW5Ic01F?=
 =?utf-8?B?Tzl5akVmSjM1WWJQejVvbzNxRXZRS0NxWURZS1NzMzJWR2JRMDZTYm5wc0dp?=
 =?utf-8?B?N245dVJzOUMrN0pGTDFiMTF1S2FZam14SnF5YTF6ZktTUWxaUFllL240TWFJ?=
 =?utf-8?B?VlVMbjBVZnlGV09RNVRJWVIzSTAzR1o4TlZFelJNdlU2S0x1SzFzT3FZb0lO?=
 =?utf-8?B?cFZxQ3JqMkxsVjF6L1FxaXFOSnZDSHFWZUlQeW5SMmV4NURjcnU2eDRGVnA2?=
 =?utf-8?B?T1liN1NDbFhZcFFXSHAzZHpNcFhDampOYlZJR2I5RHkyVXNNa0ZaTS9KV2VF?=
 =?utf-8?B?dHRCc2JuRGJtZjhvUE1BNXVkQlRQcXBsTUx0bW1tNXNrcHhGU2g0Mmc1TUh5?=
 =?utf-8?B?NWhrVlI4ZVpXMW42cUZPbUFNSlZQYjhrU2l1VXg2OE9XTnFNeVdUV2JXUlFm?=
 =?utf-8?B?M3Q3bU9tVmZiOWozejhwdzQxUFJXbUtVZk9DT1h4bzhRblZQdnh6ZDhZU2dD?=
 =?utf-8?B?dUt6TUdmaG1XWG1xd3FSV2UwTjZUejlTNGRIdUNneitFUTJwQ1E1aVhIQzZ4?=
 =?utf-8?B?R0pxaTFjRDM4eDlXK0JsL0JhZmFkSlB6RnBHLzJDVGQvVnBYZU1wYUVaT2F1?=
 =?utf-8?B?eGE2VFpaaDRaT2JNQmFUYmFwVG5wT0swQUJFMjZVSU9VQmlldWxxczcreXFO?=
 =?utf-8?B?TG9OKzg5ZGtVaG9DQkdrTDhPL094WmJ2c1laaWhXeDZMcC9OMENsVkE0Y2xL?=
 =?utf-8?B?VVVBODhDZUVRNmRYRU9QSEVMdFZISGgxbS9EMWFNYVpkVStRblFySWJ6dlYy?=
 =?utf-8?B?b0JiQ1JoSHNCaEc4c1FNdksxZmtQSDRnYmlGZ3dLR0VtZmQ4SnkyaDUxdzFr?=
 =?utf-8?B?Z0svWkdsMDduR1RJZUVTd24wbmMxdERVVFFIK2p2WXVzVkRKSHdnblNTYmcz?=
 =?utf-8?B?a2lXdnBFSHdJWFBMaVJTbmdtRExpRzFTZkwvVmNlTkxWbFhUbEVWZnQxYWlV?=
 =?utf-8?B?TXY4bUJJV0lUSmV2SUpEZ0tZSlljbFRZeEN0YmlUZVNQSkRmRUJqRGtZU3dN?=
 =?utf-8?B?cGZBZUlpZGU2K0QrWXU3d2dyUXN0QXN3L0ZNUlIwMkdZMk5RWlNQS09QNGVs?=
 =?utf-8?B?V1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: aad20bd2-6e6c-4ffe-61e0-08db4cd190cb
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2023 18:58:36.6917
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z2syaCinCuKyPC4oeKQACzPlbbQdmF2hLnFS0A8CVI1Bdvmd7TwBN3Of9ZpQXuVsxPvdwJfU7g/DlX2rVTc4YvG0VIQFE6trii7TxosHFPo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4870
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-8.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Babu,

On 4/17/2023 4:34 PM, Babu Moger wrote:
> Remove unnecessary rftype flags to avoid multiple indirection.

Could you please elaborate what makes these flags unnecessary?


Reinette
