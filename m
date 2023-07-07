Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4F2B74B8D4
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 23:47:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232418AbjGGVri (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 17:47:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231976AbjGGVrg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 17:47:36 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BC5C1FD9;
        Fri,  7 Jul 2023 14:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688766442; x=1720302442;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=AUeSTO4dhwAyLbONPP+sNPAZjvwfej2n9ic16GUEtmY=;
  b=fwsqNDEPmpqUGOmZWtLTbKWuX/v3ZvfRrcftQ2LEERIRlSR534DnZ9VT
   U5Owiw2p0VcrsIO1M1/dT8TkdoV6UNH+XWx2r9b6MHmgQJ6aIKZVfFeWY
   ifyctCqNILLwUYp9uzx8InDEI/egorA1v4wOM73d8+qqVwWox5OP03f1x
   bGu255/9MzECrxJd16dX+FjrXyXD71OiurMlu9Fbus0fIrlpJyuKVEIhe
   yUSSS14gCcXdXT0wIQ6/f9K80nfBz2JHbO/oTxdtIpd1rdhyB3gINZo26
   0d4JJKzLLlOP3mGCyNmAQiCrd0aS1d7LIYEr9+/12lbfvabbOXbjNIc2k
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10764"; a="353837291"
X-IronPort-AV: E=Sophos;i="6.01,189,1684825200"; 
   d="scan'208";a="353837291"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2023 14:47:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10764"; a="785492168"
X-IronPort-AV: E=Sophos;i="6.01,189,1684825200"; 
   d="scan'208";a="785492168"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga008.fm.intel.com with ESMTP; 07 Jul 2023 14:47:16 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 7 Jul 2023 14:47:16 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 7 Jul 2023 14:47:15 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 7 Jul 2023 14:47:15 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 7 Jul 2023 14:47:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qk3IVEz5HbfeyL3SWHgXveD8MdIOXhzMCUcFHDPBdyKESPAYdFyKzzVq208KUCxtwb8EYHCoOMtezh4B1p0LOjL4aYFGnssOTONkyoccTiEpmX8nVVfP/29EAVpY9RDcQbYQAFJY3nmSTUO3irPu7FJmIzQrW7bkUWkGjaZMqC9JvQSaOUXERnLSW5FenekkZwjrO3zXx9OhWN+BIkxygD2Vb7Ija+smGdJOBm9rireYZkMLXrR44eWv9FB5IIYiMh0Z0byn4n4Kb2uKKCXcdxekg5V1w1H3B8yF7liXPsUSBNxlLy/mHxofNcNOTiR3OY3sXDBL6SeVYSU1OrTP5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x5mgyFXzpoj8mJBiVleydwYCbLBP7vnBaC0nfJoVRx0=;
 b=WZmrtWhKhCrnCYGug/cfMBs4uMNwKQtdsbSZuVn7zErAfanczvdzIi7Vo5KxKQZaE1k41q8iZxnA2Wmr32U/v30p8lVrU7XgbUuOdQt97MegcfDH5sjr8VIlULFYm0q4GqpOvNfQokr9opBDBNP+lhQokuoeu1iSbvnNH2fkjXKktV+Ql5ytbe3T38PryyMsmPy9ohKPmVO5SpL8xv5T/4/bTZMK/Tv07Ej5PgbghjXU3HxJBejigKQZJM+IpAczlPzUqtKTFNmdVNNhDHtCsHNkxGSLGZqXz2W7qZankJRlT1GsBQLfaJleTO1QFSGcW8izni6u12lp7hItrTIxSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by BN0PR11MB5696.namprd11.prod.outlook.com (2603:10b6:408:14b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.25; Fri, 7 Jul
 2023 21:47:12 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::3b1a:8ccf:e7e4:e9fa]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::3b1a:8ccf:e7e4:e9fa%4]) with mapi id 15.20.6565.019; Fri, 7 Jul 2023
 21:47:12 +0000
Message-ID: <43ca50af-a58c-36de-74f7-47750faf79c5@intel.com>
Date:   Fri, 7 Jul 2023 14:47:09 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.12.0
Subject: Re: [PATCH v5 8/8] x86/resctrl: Introduce RFTYPE_DEBUG flag
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
References: <168564586603.527584.10518315376465080920.stgit@bmoger-ubuntu>
 <168564613667.527584.13233260903070279360.stgit@bmoger-ubuntu>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <168564613667.527584.13233260903070279360.stgit@bmoger-ubuntu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0062.namprd03.prod.outlook.com
 (2603:10b6:303:b6::7) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|BN0PR11MB5696:EE_
X-MS-Office365-Filtering-Correlation-Id: a7c8b2da-b69e-4ff8-c5d6-08db7f33b8ea
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JIVl5CNEHd4YH6/ikvxjJYABaiBJq7aOefssO7g+sa8A8P4O1k6C3V+Pz5HIhGb8O1OogyRB8L2hlkWK8emLaY1Y4M5GTK9Vh1JTh+VNGQmlqXJ28q8ccQ52YywvrqvlXGGylzsRgmBHJR4rc6AInSq62H7Uvy49DDiX7SMvnbRUMJ97hzAPJvNorhIqFPOowJgEFMOyyiwkC3zaWBzUY1agjZlh5U+ZYnHTlQJdJ8aLN7zrVC94RhVhp3koda6bIDBsXGUvNM5dM17eip6MF6PHFQMdMnatxQ1b6E1XllHpaPtxDDA8bMxEd+rinFlBwbYRTixHfEgfd4/HkLdVysSUU2XOhF9BeOpGlK0t2VnXlZccnMZ2IBRSbNGP9qz3kGzGVFmqxBfy77c4nbzzw4WHlGlkQSglXx+rm7Fuy8rcM7pzCrWaCaGG//NOI3OMaZf/rvZoJ/ZQ4kBqo6ceApWZfC3ZzjN7s3ZduGc57rMB6qGlViezG3s+/Qjgh3aqYJU31WFxkyIwuwL9xS9qGtUAwlFa9dijDirYkgdne+SOo8w1ISHAFJxWjCHBWbqdt/2bW7TuBeaF6PsLa3tWaLZnqzxCAr9f54SOnbcnzm6c39f/IbP30anrajJv+OH50gYtfmvkLCr85Xtilwaofg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(396003)(346002)(39860400002)(376002)(366004)(451199021)(8936002)(83380400001)(2616005)(2906002)(6666004)(6486002)(4326008)(66476007)(66556008)(66946007)(316002)(478600001)(6512007)(186003)(7406005)(26005)(53546011)(6506007)(44832011)(7416002)(41300700001)(8676002)(5660300002)(38100700002)(36756003)(31696002)(86362001)(31686004)(82960400001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YkNpRlJxZDBXcmVXczJvWk9tdk1OTnovcnpjamRLKzR5bG9YK2ZoMVU2bFFt?=
 =?utf-8?B?b3ltYkNYemY5UWx4N241QWx2cDcyRy9rbm1KQkNVVTRUcyt0SGR5eThxMlN3?=
 =?utf-8?B?NmFmcE0wKzBmYUZ2eDJoYUhnR3RGYmZKVkY4bHMyZWh0NjJXcG9vT2RNcndp?=
 =?utf-8?B?L24wZURaamwra1dlZzk3NVRoV0gzeDNiR1pxcEJqUDl4Y1JJb3dxSlMvVm81?=
 =?utf-8?B?UkJSUStsM2toTE5GaFNQclFrRUFQR1BmUDlmSmRtazBXcXJJdDZqMGdEU1Mx?=
 =?utf-8?B?S0FFaFdJUzZ2OTRGdUdHYWxRZDExVlVvSWV2c1o5d3F5THpzK2Q1VVdEK2tp?=
 =?utf-8?B?TTJRak9pTnEyQ0dES1htaTVPSm5vazlQNlp5ajVGejY5cDc5RmcxUkF3VjhG?=
 =?utf-8?B?YXlUcnBWNjBMNXFyeEdhcnhYVlI0S3pleFZWVjlmT2ZiUzl2Y1FxM21SSnh0?=
 =?utf-8?B?TmQzUVdWUmgrUjFic2VBdWdPSUVzRGlsamNBMnJvWTJZYTF4clpRZ2ZNVm9S?=
 =?utf-8?B?L2FsdXc5TFJ3TUllejFHdFVsUG5ab1lraXQzQTd6UjVsaGUwTGlDSytxenRF?=
 =?utf-8?B?K1RuOEhJTGtYVUIzTk5WYTdWZXphZnBrc0N2aVJwNXlGT2hiWGg2RUNUMjhX?=
 =?utf-8?B?b2pnT1A1cFdlMDBOdEdQT2pUcDU1SndvZEY3MnJwZmd2M21jalEvZGlFNzJP?=
 =?utf-8?B?MzFickJDWDlGdGE5ZUdEQS9makxUcCtadm90SExyYTVCRHZReGdrOExYZGJa?=
 =?utf-8?B?KzNaVENWczQ3Q2tWd2hTb3NiRllWdWphRS92VXVmSWkvdXV6QmgxdGlmSHBG?=
 =?utf-8?B?QzVobEJNcmM3bE1QNzNrc0hSSUFoUHU1RE4zbGRVZ3piNkpjYVRKeUw1RzBT?=
 =?utf-8?B?R1RQR1pSU2MrVm1LZFZteTV6VDUxLzZJUWFxZW1TczBwMldUZDlBcStJdC8r?=
 =?utf-8?B?ejBqWnRHTDUvSFp6WTkwdmd2R2RmR2YwRDN1Rjk1R0NzMVZ3dW9HaU4ySG1q?=
 =?utf-8?B?emxvYjVid2FVK04ra21uRDE2c2VmVjFDNEwrbGUvVlNGVmZxZFdKU3VUMHNn?=
 =?utf-8?B?ZnZ6c1hlM3MxV1hQakV4WFB2ZEh6b3lqczZVaWRZUDFMVEFSc2JKVHlTb1BJ?=
 =?utf-8?B?VkxEc2VCaE1RNkJJMzVoUnB0RWxmVUhjOGZ3d2N5M21nNldrV1NsQ0ovVlI4?=
 =?utf-8?B?R0YxYVgxb3lsL1RZbEFETGZFYzVYSmVzbjBwRG14K1ZlVkxjRlA1N3hDY1VI?=
 =?utf-8?B?R3RxSUxVeWMxa1JndlBzR1h1alFuNWMyTWZmUXhxNjBYL2FyaFhUZTBpam56?=
 =?utf-8?B?RUQvZFBmL2xpNHV4UE5zY1NTS3Q1dUlWWHRMUi9GSnlrZytTR2RQNXNSSjVD?=
 =?utf-8?B?RjJNeE1GUWFCL1h0azVSSGZqSXdOSDhRTHhaSFllZ2wwODJ0Nkg0eXd0U3lq?=
 =?utf-8?B?WmxiRkNGcGZRSmxJMTFuTXR4emhXem1PdW9YWXpHUkJuRTZ2dkwralJpT0hQ?=
 =?utf-8?B?YnpDRStveE9sWGV3VFl4TURka2NUeUhiSG52SmV0Mkg4eHVsTThnTzhybU5n?=
 =?utf-8?B?Z0dyUUU1QXZuRHRDQXpRS1ZSMjhGRDB0dHVibHU0cjJkck5wWHhrYTFEVndP?=
 =?utf-8?B?dWEvS1NmSGVuUlZUY3pEVW9IMFZpZ3VwWUtHYjRWMnozVTVhR1M4RWFjdVJ4?=
 =?utf-8?B?aG1lLzNPb2VJbjAzUmk0K0dEdWtzZE92TWk5YlVCTUNKL0VnTHNKNUl6MjQ2?=
 =?utf-8?B?QjBkRkdweWtVVVpTMm5FbC9oYS81VHo3d25xRkg3SStzTE5ndVYzWHZtY1Ni?=
 =?utf-8?B?YzR3ZWwzN3FqNEt3UExXa25CU255WElGeU5jS0MyNDB2aWd6Mk5mNkpKWjh1?=
 =?utf-8?B?NkFMSmJYYytvL1N1K1pESjFWdXU1NitCaFhqajBHYmJxZlpCRW9xendUQk9B?=
 =?utf-8?B?SEFVcDdVUkowZGViOE5MaUUrYVZYMmhrRjYzdUhla29ZZnJtcDUxNDRTV0Y2?=
 =?utf-8?B?S211WWxTUWkybUYwcHEzWk5uUWJYMGM1dnBNY0tzSkZWOE9jL1oxMGpLL0Q5?=
 =?utf-8?B?SjFoQUJPVGRHd2VvdmNzcENUcU9sN0pFcE5tSERhMDcwU3NLNytmLzRXRkUz?=
 =?utf-8?B?QVA5TVVHS3hQY29aMXV2YjFFMW1DbVdLdGFveUc4anVtcTlxTXF4T3I1V01F?=
 =?utf-8?B?bkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a7c8b2da-b69e-4ff8-c5d6-08db7f33b8ea
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2023 21:47:12.7785
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zW8MOf6Q2kJOrJ+6MNQzXLMiR+60wkYHi3MLsRO11+Y83ldhRAcluiM4ZrUjW+ZR1FqLkOyMleFXU+U4C5p5mSkuQ9nWxJYtTLCew9OtIHM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR11MB5696
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

Hi Babu,

On 6/1/2023 12:02 PM, Babu Moger wrote:
> Introduce RFTYPE_DEBUG flag which can be used to add files when
> resctrl is mounted with "-o debug" option. RFTYPE_DEBUG is OR'd
> with other RFTYPE_ flags. These other flags decide where in resctrl
> structure these files should be created.
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---
>  arch/x86/kernel/cpu/resctrl/internal.h |    1 +
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c |    5 +++++
>  2 files changed, 6 insertions(+)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
> index c07c6517d856..5bc8d371fc3e 100644
> --- a/arch/x86/kernel/cpu/resctrl/internal.h
> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
> @@ -294,6 +294,7 @@ struct rdtgroup {
>  #define RFTYPE_TOP			BIT(6)
>  #define RFTYPE_RES_CACHE		BIT(8)
>  #define RFTYPE_RES_MB			BIT(9)
> +#define RFTYPE_DEBUG			BIT(10)
>  #define RFTYPE_CTRL_INFO		(RFTYPE_INFO | RFTYPE_CTRL)
>  #define RFTYPE_MON_INFO			(RFTYPE_INFO | RFTYPE_MON)
>  #define RFTYPE_TOP_INFO			(RFTYPE_INFO | RFTYPE_TOP)
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index e03cb01c4742..9e42ecbb9063 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -1862,6 +1862,7 @@ static struct rftype res_common_files[] = {
>  		.mode		= 0444,
>  		.kf_ops		= &rdtgroup_kf_single_ops,
>  		.seq_show	= rdtgroup_rmid_show,
> +		.fflags		= RFTYPE_BASE | RFTYPE_DEBUG,
>  	},
>  	{
>  		.name		= "schemata",
> @@ -1891,6 +1892,7 @@ static struct rftype res_common_files[] = {
>  		.mode		= 0444,
>  		.kf_ops		= &rdtgroup_kf_single_ops,
>  		.seq_show	= rdtgroup_closid_show,
> +		.fflags		= RFTYPE_CTRL_BASE | RFTYPE_DEBUG,
>  	},
>  
>  };
> @@ -1905,6 +1907,9 @@ static int rdtgroup_add_files(struct kernfs_node *kn, unsigned long fflags)
>  
>  	lockdep_assert_held(&rdtgroup_mutex);
>  
> +	if (resctrl_debug)
> +		fflags |= RFTYPE_DEBUG;
> +
>  	for (rft = rfts; rft < rfts + len; rft++) {
>  		if (rft->fflags && ((fflags & rft->fflags) == rft->fflags)) {
>  			ret = rdtgroup_add_file(kn, rft);
> 
> 

I think that the first and last hunk of this patch can be
squashed with patch 5. From what I can tell it would help
the motivation of patch 5 and fit nicely with what its
changelog aims to describe. The remaining hunks can be
moved to patch 6.

Reinette
