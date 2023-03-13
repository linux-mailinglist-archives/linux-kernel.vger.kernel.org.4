Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 540B96B7DD0
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 17:39:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbjCMQjQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 12:39:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231517AbjCMQiw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 12:38:52 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE55A18AAC;
        Mon, 13 Mar 2023 09:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678725523; x=1710261523;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=4YmVEPPiJhkp3kmCDMXlFbuGUMi90BRjzgKBY16onuk=;
  b=hKIRwIc/5Q/Vu5RmMm1rRlhxecnoEk4XFRr9eHQpa+LJJtZ26Ujc3H9u
   wmNi92lpAtIotHlCsYhMqQJ8rqiq3/qASEAJpXIDQrXnEkRmONBS/xDQY
   1lnMdfZ+4+5QWl6R5cIVq8UUq4LRHL1AGMMV0RabSFZAqMHRyCdhFoAdk
   ED6sEPiGv6h6/fwxDXk0wVDW6eKt6SLuyrQ7z/FFN1te0rT2hdlo0Nw1p
   KW7z+ETgZa+g8hCENaFgpbBhkxwCLEZuTzRLwEf1KQ7v0Yd6Hi9xPXlv5
   L7n3s2x9So5X73mpTyA92hkYBwYEO69JaVGYNE4DxuPow4ihsReIzlpFi
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="317582449"
X-IronPort-AV: E=Sophos;i="5.98,257,1673942400"; 
   d="scan'208";a="317582449"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2023 09:37:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="742934462"
X-IronPort-AV: E=Sophos;i="5.98,257,1673942400"; 
   d="scan'208";a="742934462"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga008.fm.intel.com with ESMTP; 13 Mar 2023 09:37:39 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 13 Mar 2023 09:37:39 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 13 Mar 2023 09:37:38 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Mon, 13 Mar 2023 09:37:38 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Mon, 13 Mar 2023 09:37:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NF7tFlrIwXc3r2/tyoRJ9pKeB4boXixnpd8skMjeGInr4eGxWtCb00b/QEG8le6sr8JHEpNC/jlAq/UrLilYR1qqMbF5/pN0dYoQzch45+V5wXyUQeS+VPI6s2g1CC6RJFqCYGA/HAAAnr8d2EnQNb32OOgauZ+vBexVrR2FYv78XhgVR521U3WKt8Ka9EIrR51634jXSvTlHRfYi0CdNBSg651Ujmj0cr8M1m3QP4e7qrcJ33SzQttfRRFBResFo5gIwcXD3/ba+iFAMdWh1mKlZnTe8Hq+sRLQhNe4yEV2OTfUKlkwNRZzaehj3PsELjCv99lMibLM6bXdIV+4yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W6y3SVtheGniBwi4Cl965F+c63PCCs7X82MYA6xXQ58=;
 b=dF63SAoJy/FjEF25iDi/8OsLBDETHbqMwe2JXpuWz/Rs30ILF4uizLPDazELXSbLZ8SSYxydZOjrLnF7Zzam+FCYxcRyuDFakOACf2AeoXa5LpU6hbzxl6aNoyHv56iijlOf7KfVXbmDfNsboZa4095F7lbPdhr6HjX9iSDpPUoRltF/Wnw+Qeb9cq2Nb4Z46a6jLVsW4LBCZLyJs5UM206F1hTR5kuL0TfN/hl2K0hafHJNb0PGy5vWXJ6EFvLkDhxJOI0lAe4dN+mttiRGfNQcCZDCSAHR2/L+Sr3pOA4PwqnAkJTsqml50Yk5uX5G/6iZbSd8DT96wQi0k0E5Gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3768.namprd11.prod.outlook.com (2603:10b6:a03:fa::20)
 by LV2PR11MB5976.namprd11.prod.outlook.com (2603:10b6:408:17c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.24; Mon, 13 Mar
 2023 16:37:35 +0000
Received: from BYAPR11MB3768.namprd11.prod.outlook.com
 ([fe80::9a08:f53b:3a33:1211]) by BYAPR11MB3768.namprd11.prod.outlook.com
 ([fe80::9a08:f53b:3a33:1211%3]) with mapi id 15.20.6178.024; Mon, 13 Mar 2023
 16:37:35 +0000
Message-ID: <9dde72aa-a28d-2b0e-7b90-6b1996dbf202@intel.com>
Date:   Mon, 13 Mar 2023 09:37:32 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v3 6/8] platform/x86/intel/ifs: Implement Array BIST test
To:     Hans de Goede <hdegoede@redhat.com>, <markgross@kernel.org>
CC:     <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
        <gregkh@linuxfoundation.org>, <rostedt@goodmis.org>,
        <ashok.raj@intel.com>, <tony.luck@intel.com>,
        <linux-kernel@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>, <patches@lists.linux.dev>,
        <ravi.v.shankar@intel.com>, <thiago.macieira@intel.com>,
        <athenas.jimenez.gonzalez@intel.com>, <sohil.mehta@intel.com>
References: <20230214234426.344960-1-jithu.joseph@intel.com>
 <20230301015942.462799-1-jithu.joseph@intel.com>
 <20230301015942.462799-7-jithu.joseph@intel.com>
 <628e092c-793e-96ce-71f5-80392ad69569@redhat.com>
Content-Language: en-US
From:   "Joseph, Jithu" <jithu.joseph@intel.com>
In-Reply-To: <628e092c-793e-96ce-71f5-80392ad69569@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR17CA0015.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::28) To BYAPR11MB3768.namprd11.prod.outlook.com
 (2603:10b6:a03:fa::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3768:EE_|LV2PR11MB5976:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a28d1d5-6ad9-4e6b-1662-08db23e13faf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FBYVKhej4+gqaGNY9SytDNcAgkqE3ra/sfpxIfSvuMCLVqNd3brwXhoqFutz8n/9rmg5GGNVUL7bW0Js4GkN6U46UHnZrNY42voNvQD7KBvxVmH0sn4iuDJH2pxZmwJomDlA8E4x0lktqXBa8nPE9iJNVngrNEMx5A9+d+3zRxgX8kIfu/E8mQoE4iFmiCEzXKmnP3DkMG7JmgsFNEN2Rv25I950ztANKhjELct3hoTijFJ3rychGxJFXG0iCU0myoGQOMik326kKMEs1B1zi2VE/RZjEkiHVRZu/xd0Oo5v+lou33UQjPMPwsnJdqJqrFbXuJ9RPSoAVnqPUDQDypxW4p6Ie1MSNG4+QvqnDBPR+JWebCIFA5iJAY3e/xdjLN/G71Gekqs3Dn0E5o5mjF+PTFSADEyEG5NkqzgDyem6V5h6o+wQCVmlqG6VSk4dTZXfFQs9NHRbPBzuzhmWd4LWGYkhMBqPVp2t7ks4ykSe46AaUJXkyXMB3lawBuzC2xE9JznZjtiHeq5VPd5mZawkIXo4Zq4GbKF8NCG4g7Sp/NfEGsqjk61l+bGQNx0XGCLi64N8q9T/4zdr1DmD+IJd9hu7N4nm1bhRm+Ce87NPPvOypeqFySBwXC9cNGYYRGpYQb3Eu5aFrt+i46wUvcK245UdRAhYrnD9gwU6IPoiHMGpCKqr3KcPCPiyuHWjUuE99+T6Nnysk56neCWd2UjuUZMmjWhC/aga6yiNVrQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3768.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(346002)(366004)(376002)(396003)(39860400002)(451199018)(7416002)(5660300002)(36756003)(83380400001)(478600001)(6666004)(6512007)(6506007)(2616005)(53546011)(6486002)(26005)(66476007)(8676002)(66946007)(66556008)(186003)(4326008)(41300700001)(8936002)(86362001)(31696002)(316002)(38100700002)(82960400001)(31686004)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RncxSWpMTnBmc3ZTMW5POEtHT1JXcFRkOXE2VDRQTlYyRGdka2kvdVFzVGJt?=
 =?utf-8?B?N0ljZFFTekJjVmhVOU5oRmdvcVUrNHdJZFRWa3NDRTF5VmtHbGs3THhBUVRj?=
 =?utf-8?B?MmUreWJBb005dWlFZ1FubFNLc3FUU0laMW1BVkU2VmRBRmV6UUpUamxBMU9r?=
 =?utf-8?B?a1RXSjdNOXluaWNHSUkyQzFwSk1ya1B4T0xuQkRLdmVlN0RIUFE5NUd2UlRu?=
 =?utf-8?B?czVQNWNqSTZscTdmUkJpQSswTytSSjBNREJpbzVqeFpiVkNoS0FYa3pvakU4?=
 =?utf-8?B?dlp6dlBaczdPaTc4TnhUWGYvZ1hPVWFpdWdRa2dyZzRQa3NZSWdOMUlZNldl?=
 =?utf-8?B?NHZYL2Uvd3pZVkFjdDBEZFpCcVk4djRnVDBnNHpnVFVkNUNLOTlGdkIyRDJP?=
 =?utf-8?B?OGc4dFVNVGN2RzNtRXdMYm9TdHBQN0FiMnFRZE5LazRqVFpqSUJWQ3NiMElN?=
 =?utf-8?B?UlJvMGJ5VEtMYWVPMU1nc2RUNWxlZlNSem4rSTdCUnJZR29pR1dyaEFxajgy?=
 =?utf-8?B?dXZVNlRwZzR0YzdTVnhlN3ZHTnFRbUZ3VlJOWUFIOUpadENRSzI1YTBGejBR?=
 =?utf-8?B?MFliRXV3NWRncm1nYWNBb0lxcEZoRGFJTlZaVGZyWTNlOHdTNWYvNlZNczFt?=
 =?utf-8?B?ODhnajF3QWpZNTBzajBIby93Z3ZhcUlOTk5VYXFnWitwU0ZLcTNGNkRENHRG?=
 =?utf-8?B?Sm9kZFhxelpSQ0ZyeXM5cHNmWXJaZ1RUV1RER3puOEw5VkR1VU5YbStvd29x?=
 =?utf-8?B?S3JBK2ZZVHlxUDdGd0N3Sk50UHczTmVkWlpUV3Y2QWdTQ2ZiZzl4b09seHlD?=
 =?utf-8?B?dnJoaU9UcFhiTDdqUnIyWUVEbGltV1MzK3pkUXJBL1orQ3JnQ0xZbEpLOHlj?=
 =?utf-8?B?RXNBeTJFdzY4dWpFenR6Y3lpSm1NdHMyOGUzbURKYk1TTHI2Vng2OG1EanNL?=
 =?utf-8?B?SlgxN0Rhb1E3L3M2eGNxRmJ5L0RWRmxXcXlQd1Q2TktHL2t3WGFkeTBsaC9K?=
 =?utf-8?B?ODd1QkZyZmI4TE1VNWRZcG1CWjBTR3I0Z3pLbmsvWUlYbngxUkFXbGkxVUpr?=
 =?utf-8?B?YW5NTnFybGpKV1FKRXJKRDZzSFpVemY3S25nMWN1YjhuNzNxTGdxSTV0Z1BZ?=
 =?utf-8?B?K1hOTTNRR1lycHhUOW9qZGs5YTM3bkVERG1mZXl4UVZSQWJpcnIzaDRXaUov?=
 =?utf-8?B?M2VxZ3liMDBVM0VIekRlN04vUUwxTU9wNkVHZngxM01VQTlVcy9wTlpOc0Fj?=
 =?utf-8?B?TmNydEZ4NzhtZlVUUlBHR1gzM0lCUGlrYlBzOERCOU1MK1hEZWYycmtNYmNP?=
 =?utf-8?B?a2wzUFhPNFFVUFZxOURUUUN5MUNxWDRkbnBYVmpaS0hlTGhQeVlCQXhkN1JM?=
 =?utf-8?B?U2NOQTRycmhON2xaQmNSUU5xR3JqandtUGw4Q1Nqd1B5WGdpbUV6RVNCUE5M?=
 =?utf-8?B?UEtETGVwQk9wV1V5KzZkOGVhZjZET2VEU1R4YzR4YWV1Wml5WXJzMy84NTZV?=
 =?utf-8?B?K0VwNENlVHNaVFlVY1dCdnA3NTRKQnlaQzZlaEt2dEZkTmdHRStaZVlSeWty?=
 =?utf-8?B?MHZCTXVieXZHb3l1TTRkdmZjVFFiYUg5NnpxdWF0a29UU3hoQ1E5L1hQTWgy?=
 =?utf-8?B?cmY2bFNPaUQ5ZU42QnhnQ29KeGdKQSt2RkNtRVVBZGFiS3Q1aVV6RmdSQmdJ?=
 =?utf-8?B?VHBSdklTcmpOcDI3dVNGZzVLdzlBVE5FNVN2ekZyK3dyNStES2lHbkhOTFpH?=
 =?utf-8?B?M1UvQzNkQ1U5V0txTDQ2ZjM3dG9VMjNhWlU5dnE2VkNsQXFJa3JqakpjZnBD?=
 =?utf-8?B?M0RXd3QzdnRLaEU0ZUZ5SSsrVjlrSEZaa21PMjNvWmt1N1NhUnZ4dksrYVl5?=
 =?utf-8?B?YWhlNVFzaS8wbTQ4WHQvbkRQaVFSUzN0Z01FNXV3UXpucm5aY3lNTTJYWDRZ?=
 =?utf-8?B?RkpkbXk1OEtqeWt2d3Y1YnpBNjZ4dUhYdXJZcm5KazZGSWp1SWxnblJyeDEr?=
 =?utf-8?B?ZlpDZDlDTkx5SzBDUjlHckdnS0ZqRVZqSDVyYTJyMWg2eHVHK05ESlBQeUZz?=
 =?utf-8?B?aW5XemhYQTJ3TjR1amFCa2ZSZi9TZjR4US9TdFUrZUJPOUVUMEt1UmN1Smx4?=
 =?utf-8?B?dyt1MWV3a1E2Y2JWZDgzZzk4WXdpd1pmM2Q5UHhFWWUyZ3ZWTE8zZlhaMFlH?=
 =?utf-8?B?Ync9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a28d1d5-6ad9-4e6b-1662-08db23e13faf
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3768.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2023 16:37:34.7984
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PytOXEbJREPViPqjPc19QRPlpLvPv1MRPOV3DNADbPXhmQAuljBadu5e7UrsnB2v7yVoaLJpaCrt9B4EH6uYCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB5976
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hans,

Thank-you very much for the review.

On 3/13/2023 9:24 AM, Hans de Goede wrote:


>>  
>> +#define SPINUNIT 100 /* 100 nsec */
>> +static atomic_t array_cpus_out;
> 
> This variable is only inc-ed + read, it is never reset to 0
> so the "while (atomic_read(t) < all_cpus)"
> check only works for the first test run.
> 

It is reset to zero as annotated below. Let me know if this doesn't address your concern.

> Also even static atomic_t variables must be initialized, you cannot
> assume that using using zeroed mem is a valid value for an atomic_t.
> 
> And this is also shared between all smt pairs, so if 2 "real"
> CPU cores with both 2 sibblings are asked to run IFS tests at
> the same time, then array_cpus_out will get increased 4 times
> in total, breaking the wait_for_sibbling loop as soon as
> the counter reaches 2, so before the tests are done.

Only one IFS test is allowed at a time. This is done using "ifs_sem" defined in sysfs.c

...

>> +static void ifs_array_test_core(int cpu, struct device *dev)
>> +{
>> +	union ifs_array command = {};
>> +	bool timed_out = false;
>> +	struct ifs_data *ifsd;
>> +	unsigned long timeout;
>> +
>> +	ifsd = ifs_get_data(dev);
>> +
>> +	command.array_bitmask = ~0U;
>> +	timeout = jiffies + HZ / 2;
>> +
>> +	do {
>> +		if (time_after(jiffies, timeout)) {
>> +			timed_out = true;
>> +			break;
>> +		}
>> +		atomic_set(&array_cpus_out, 0);

The above line is where the zero initialization happens before every test.

>> +		stop_core_cpuslocked(cpu, do_array_test, &command);
>> +
>> +		if (command.ctrl_result)
>> +			break;
>> +	} while (command.array_bitmask);
>> +
>> +	ifsd->scan_details = command.data;
>> +
>> +	if (command.ctrl_result)
>> +		ifsd->status = SCAN_TEST_FAIL;
>> +	else if (timed_out || command.array_bitmask)
>> +		ifsd->status = SCAN_NOT_TESTED;
>> +	else
>> +		ifsd->status = SCAN_TEST_PASS;
>> +}

Jithu
