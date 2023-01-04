Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A40365DA9B
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 17:46:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239894AbjADQpx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 11:45:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240001AbjADQod (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 11:44:33 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E972C43A0B;
        Wed,  4 Jan 2023 08:43:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672850598; x=1704386598;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=RoKhTym7Dq1psjLvZwfgrbU101+rCzR7M7VzfJqr/1g=;
  b=JEzcf6bVwA1WtNpjScj1Wh3lgzCkUDD2VhG5FvOJ3wqC0LfH5gGWmxkr
   q2bd4SI1BKRfBFTg33FEpmn2CP4tl491m6+9T0QDewvkX456GlzTJydfx
   3o5A13t2FmVwSswfFXfAKST1OxnC65suWyjeW0Jc5EY0ZdtDq3zMjVmAm
   +Q0a2VsVfKfMHgFy/fGdGgOUCECWYt1EgK7xr0pC/Ow56UYGuK1ps9W60
   035eTR9abDbTv5Pm3yTvuGPNcrNuELI3Wd7ImbsnQYCavHsuinTDiODud
   i1RiC0THQmdDNPGJIpa22GZuw8akN3GXlcMd9Cvzdl0Rbw7WNznEddR5U
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10580"; a="301668298"
X-IronPort-AV: E=Sophos;i="5.96,300,1665471600"; 
   d="scan'208";a="301668298"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2023 08:43:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10580"; a="762729664"
X-IronPort-AV: E=Sophos;i="5.96,300,1665471600"; 
   d="scan'208";a="762729664"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga002.fm.intel.com with ESMTP; 04 Jan 2023 08:43:16 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 4 Jan 2023 08:43:15 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 4 Jan 2023 08:43:15 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 4 Jan 2023 08:43:15 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 4 Jan 2023 08:43:12 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TWzzL+mOnL3tPv+lprA/jB+8w8/drLXfMi2JDltW1/iWmwpRpZfHdY8VLm+X4qaUbwWVMZvHUFHawkNCP9VAn964vNbsBb1b2jqbnwyNsBzd7Oypyq0jiFi79SgVL4pfbSWhdZoh/qSN2m7wDmQjfMpK95QqxcQG/AUTDhC+mkkMMp4sOda6lCzx7nrAjrocg38mZ/CTz+OUkqgyhVNq2xzNswjSYCfInqk4Wts1sYJYdSG+5VKwSy9HOWDqVZyvBuvs/YkSEcUmSvHtj2mDBNlw7ySOKww6Neh/CzkSRq5FnC22+70ulL9d4guwmOKCBANYz7Pea4rkrvCo29Gvhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0x12yxLeESJG0uKdQUaO9dDPYFsHLKD+bNHpaXP4v64=;
 b=CS8JdF4vSL/Ax3/3nC4OimNjJJYuON/LI4xOeZU/Fj0vP36axOq+eOVSAJikTiIduEc/H7Haa92h5mbzH6dsGmOQwWLSTcpipSIaLdT4a7x9VAqDQquRwvQdQf0K5EuQKqUciW2yzgg9hk1zsTZjbwr9kfT5wls/+pBJBjPtvDZnhy5emdRVf9xfpZ7BO8RPFC4VVAJXadrCWZYOuRL//TjZBvsC9J3LiDJSH0Hke4rs7bwBKmVXEFKeYZYktC5YIbwqjwLnAGJaRQOF05kaofCAb1GM8fqtOpkunOWJnYsAB0ACDIUmXq5ZyMJ8r/epXQOEVkmI/Qrmjayz87hrAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by DS0PR11MB6520.namprd11.prod.outlook.com (2603:10b6:8:d0::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Wed, 4 Jan
 2023 16:43:06 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::a1f7:e4c4:e60:c5b3]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::a1f7:e4c4:e60:c5b3%6]) with mapi id 15.20.5944.019; Wed, 4 Jan 2023
 16:43:06 +0000
Message-ID: <21a4f7d7-eec6-f04e-9707-59236c0f937f@intel.com>
Date:   Wed, 4 Jan 2023 08:43:03 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.6.0
Subject: Re: [RFC PATCH 2/3] x86/resctrl: Move the task's threads to the group
 automatically
Content-Language: en-US
To:     Babu Moger <babu.moger@amd.com>, <fenghua.yu@intel.com>
CC:     <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
        <corbet@lwn.net>, <linux-kernel@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <eranian@google.com>,
        <peternewman@google.com>
References: <167278351577.34228.12803395505584557101.stgit@bmoger-ubuntu>
 <167278360189.34228.2442698916556329960.stgit@bmoger-ubuntu>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <167278360189.34228.2442698916556329960.stgit@bmoger-ubuntu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR04CA0007.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::17) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|DS0PR11MB6520:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c48a04f-9ef5-4fee-3877-08daee72c129
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eK/3+LA0xBgt+4Uwru3sxpBe1eiN8yWF7x+U6g3EQ2qw37QyqYV5QU2+kkhbi+nbG1R8zXU5bzzrnlvI+buO0CEJ3Cb46AiwKhYn2rTPOEKxylhxp+ZAtZPODTKpGNRg1QJYEiKPE/k2H/J4fj8EiEj5Qq24tfBerEAooirUbgTCcteRHw1IDUM+DZa/PW87lWyXOe4DVfOJq4sFR+RyXRzk9Rnnq/lm5NlsqnfGolfLZ3Ass7VulXtHnpTDH0IOyCWKNN+5b+JoaPUoI99GElnnEwkJtcQT7GeLe4t1POz8uZft9B+wcn9SSSe0rs2FAO5HSZFqgGmJrXJ5aLHE17WM4GqfTplWwglrFhkxoiQRPB8d+Qke+c8M3MIixvux2Zy+mPBS8EDSSBd2t/gn8jpfeRkbKV+oSBSNC1o40+NRkSy4QAS23f+VlaAugz7OF5FDg1A1un5ePwMed0IClJpKlYWjD8Z2qdMCm0YqonslNYbaM0N6YcsZneHOtchbRnjD0ZGt9uhTRmfE80JBnCwrDRGuwQ8cU6g+EtKALjMRsy4x3kxUwGlodlUYcD90z3JIZH5jpk6t2Yr/nJYab+zWWvu5wWEkqLheYNL9Ki07LnrFl9ODGg10CdSDPcZWl/lUhmNjw+IbCc6dOM+klrt9rtvtMrYFkacVaEtD7tm7GsE1rMlzWKs7d2+3Ykyxk1CGIe7NzGJCV0E4H8W4dp5/4Ilyd5c/26zwdFgipis=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(136003)(376002)(366004)(346002)(396003)(451199015)(31686004)(26005)(186003)(478600001)(6666004)(66556008)(2616005)(6486002)(66476007)(66946007)(6512007)(66899015)(4326008)(8936002)(8676002)(7416002)(5660300002)(44832011)(41300700001)(2906002)(316002)(82960400001)(86362001)(31696002)(6636002)(6506007)(53546011)(38100700002)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a2lFUUJqb2RuNDQ0dXNKRUhWUWFZM2czNXpIY3JZaHBtRnpaUFpTYlJscitG?=
 =?utf-8?B?VlFRbTRMTCt2ckkxQkFxR3RaSnNTamF1WVcwWU5kS3pxT0F1WXhQSGhJaUY1?=
 =?utf-8?B?Q1RwRDVGUlVRUTVTQTJCNVY0SG1ndnB1ZDNyL1BKS0l6T0NvSmF6L2VDOGdD?=
 =?utf-8?B?Zm5xcUlieGZUOWNKanNkaVBGZzZXYkdTUmZIL2lMNGlINEdEZ3BWWStWY3NN?=
 =?utf-8?B?RGN3aU1MSjFwQjBGem1EbE92TnhlVy9aMGo5NU9FakI1alA5RlZPNWJnendO?=
 =?utf-8?B?Z1IrV0d5U3NaOHN2a0U5Q0RCSDFLZUUrTmFRQk9LSXM0c2xUV0txVTM0UUtE?=
 =?utf-8?B?WXorT2Y2K0dqYUFuNWhrbFlMSnFmWFVtUUNBdDI5dmFoQ3NESjZqajMyRGtt?=
 =?utf-8?B?MDlOVS9iSDc2eWQ2T3VHYTQ3M29aeTJZSmFLSmhDQm9kVUZFUXFIeWtlVlVF?=
 =?utf-8?B?WGRMZ3dQaGhqb3M3TE9qL1p2NHpjYXo4L3NBd040d2c4OUl1NWpIVEd6eEZ4?=
 =?utf-8?B?T0x2dTl2QklKeW5EV1BlY2o2VzlUL3lkL0xhWVlFbEppMFJXS0EvWHVGR3A5?=
 =?utf-8?B?dHc4WDVmM0ZMZ0hLNUJHa2ZkK3pjaUFEb2FFSjV0K25PTitPeHg4VnJrczVW?=
 =?utf-8?B?a3F1Nk5LaXV2SjR3Z0UyamgyZ3VuemtPT3JJUjNpUElKQks3WnpWT0htTFNO?=
 =?utf-8?B?eUdxT1VlcDZFclhwNHErU3Z5UWFxMDd6bTBKKzZpc3lrN01Kck9QZXhMVGwr?=
 =?utf-8?B?UlFiNzZpeVl0a3A0MWMrMitNaEcreDU0ZG14bnRnWnZwc0duby9TQXJDS0cv?=
 =?utf-8?B?bTNnNUZlR3l3blQ4UHQ0OExDNFFKcnpDcUZIVkV6L2xkNG5yaHJCVTdkTmRS?=
 =?utf-8?B?QVVwNkg4RTdnamEvUjlMVjVMWk1rZzJ0V3d5djNQbVJFa24wOFlPTlBndjFp?=
 =?utf-8?B?R1lMOVRvQzIrZ01EbkxuY2ZXZzU5OHJQY0d0M0cvUDBmOUdsSU5XQms2RFpo?=
 =?utf-8?B?QlBTODlscFFLV2NCUi9sT2lRREdwbCttL0IySDliMXFXRHd0WW5ZbjByYk5K?=
 =?utf-8?B?Nzd4d0VNS0wxYUxwTGoybXBmY1RwN0tmbEtPL09oUzNZeG1hZE1xY0h1RjBH?=
 =?utf-8?B?WWgwaW5IbnlVRHozOERLYVJJSGJ5cEMyNWZRc0RSNG5FWFRPT1lkbVZ2Slho?=
 =?utf-8?B?a0dkejBrcERkRGFHMTk0VzE5WkdZclc5eGRjaExybE1MTXVVU3NRazdiaDJh?=
 =?utf-8?B?L2pvczFoTEhXVXZxQUU4eEk2R3NEM1YvZVFRdzBROXU1OGN1LzNVVUo1eVRz?=
 =?utf-8?B?RHc0UXNnZFZLb2lZaW9SNDIwZE40Z1NIZCsyTUR2TTBLKzcwNTFHRkNhYzNS?=
 =?utf-8?B?WkZuQWc3ZzhKYy9mTnNZM3dVSXJuajFNaFAvSXJseWt4RFh6ekVuelk2SjhB?=
 =?utf-8?B?MTV4cGlLcW1GYllZSkpkMEo0M2pRNzhPZzF2eXNjSkc3dzVXRVlUTjZvMkxi?=
 =?utf-8?B?azFLNGVXdlp5NXJuanduZlBLZHJaakszWC9xU1VZaDhMZUxwUXhpY2FIMW1V?=
 =?utf-8?B?cVBNVlZBcmZXdjMwblJDSzY4dllwNWlpN0hwN1U5Y29OZllIRVZwOGx3QUxB?=
 =?utf-8?B?RGg2K0RwSmRPQTZ3L3cvQ2FLbFBhVXJoQThlSzNuTEtLeWhxa3pKNlR2cS9j?=
 =?utf-8?B?MTBjODZINFY0cko5U0ZiOXhGdEZGSGR1Y1E4U2RmWjU4U0FxUExxVFdxSWZy?=
 =?utf-8?B?NlpTSzFUUWlKSlRGT3VwRVEvUVZpZTh6S2E5eURSdm5TT2N0QnVBVlplcjFi?=
 =?utf-8?B?UEd1ejV3K0prNWkvc25LRzlNMnJOZFg2eVVxdXhvS3g2UUhKWm1Yc29XM3Fj?=
 =?utf-8?B?V2ppdStQUi9jbW1yOHVPQmUvZU9zelhqTTErZkE4dXBaU21uMGJYdUkrWlRN?=
 =?utf-8?B?bEZVQlNlYTZBZWhPSHUzMm9pQmtGR3dWQnNSdy96ZkhDVUoyeWdxV3AyOUFj?=
 =?utf-8?B?em4vWmN2QmhSbGx0R0VDaHFxdDd5Q1ViWkNlRXhZbnRtbXhSaHV2V1NCMk1G?=
 =?utf-8?B?SWZMMTRhL21PenFLUVZZQ0owS01BWXNOV0VmQVVlT2hQVnlCYkZaTlNZY3pX?=
 =?utf-8?B?RDhqVXhFVml0THJwdEx6U056S09iWGlsaFRrK21nOE9FSWwrZ3I0WXRBNlV2?=
 =?utf-8?B?VFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c48a04f-9ef5-4fee-3877-08daee72c129
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2023 16:43:06.2295
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BZley24sDstSQ964pNg08ptrUOekZoPBuiHOWUyA3GCxvenCEhf/eP6Un4mEo/00DxraozqeEckPmENs/W6b2I10OE1B/3SLdaaKTfm6lRI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6520
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Babu,

On 1/3/2023 2:06 PM, Babu Moger wrote:
> Some micro benchmarks run multiple threads when started. Monitoring
> (or controlling) the benchmark using the task id is bit tricky. Users
> need to track all the threads and assign them individually to monitor
> or control. For example:
>   $stream_lowOverhead -codeAlg 13 -nRep 100000 -cores 0 1 2 3 -memMB 32
>   -alignKB 8192 -aPadB 0 -bPadB 0 -cPadB 0 -testMask 1
> 
>   $pidof stream_lowOverhead
>   6793
>
> This benchmark actually runs multiple threads underneath on the cores
> listed above. It can be seen with the command:
>   $ps -T -p 6793
>    PID   SPID TTY          TIME CMD
>   6793   6793 pts/2    00:00:00 stream_lowOverh
>   6793   6802 pts/2    00:01:25 stream_lowOverh
>   6793   6803 pts/2    00:01:25 stream_lowOverh
>   6793   6804 pts/2    00:01:25 stream_lowOverh
>   6793   6805 pts/2    00:01:25 stream_lowOverh
> 
> Users need to assign these threads individually to the resctrl group for
> monitoring or controlling.
> 
>   $echo 6793 > /sys/fs/restrl/clos1/tasks
>   $echo 6802 > /sys/fs/restrl/clos1/tasks
>   $echo 6803 > /sys/fs/restrl/clos1/tasks
>   $echo 6804 > /sys/fs/restrl/clos1/tasks
>   $echo 6805 > /sys/fs/restrl/clos1/tasks
> 
> That is not easy when dealing with numerous threads.

How about:

# echo $$ > /sys/fs/resctrl/clos1/tasks
# stream_lowOverhead -codeAlg 13 -nRep 100000 -cores 0 1 2 3 -memMB 32\
   -alignKB 8192 -aPadB 0 -bPadB 0 -cPadB 0 -testMask 1


Reinette
