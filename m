Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A89AC634B4B
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 00:43:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230365AbiKVXnY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 18:43:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233346AbiKVXnT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 18:43:19 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06C0FC67D3;
        Tue, 22 Nov 2022 15:43:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669160598; x=1700696598;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=asjLsiYgwKMRnYLRyh8IhK0nALgvyhXTvCSXJCVj+RY=;
  b=I85NAPdxDcLfu1r3VV0xRMzvkV7yL6B2V6JAbV0KQTDEIY0tvxOLYcsQ
   SOu5l+AHwCUZ0XdsFcMS4JkFFSb2nT50UcK1dVYWz5lGscaRnPNfOoLtd
   zZoYAnKyHqGu5ki2XujgeaxxJguzXlipURIYuPxxPV1Ede8kKRwwrKCxB
   KrFrzKA6bvMqr4/EUBqyx4Cnl9DndDkgdsAX8l2oLZp7gTQpy7KfRbXNL
   S6tulc1xFEs47lDHSnf2yGCdSEdV6zsnuwQPv6WigmRlWsw8zFwbTXZJ9
   /v6b6oOA7CPBgZQSx8FLOL0heczioKlEvU6ILElVplTyX92iJOU+d8cmn
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10539"; a="311566524"
X-IronPort-AV: E=Sophos;i="5.96,185,1665471600"; 
   d="scan'208";a="311566524"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2022 15:43:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10539"; a="784016993"
X-IronPort-AV: E=Sophos;i="5.96,185,1665471600"; 
   d="scan'208";a="784016993"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga001.fm.intel.com with ESMTP; 22 Nov 2022 15:43:17 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 22 Nov 2022 15:43:17 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 22 Nov 2022 15:43:17 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 22 Nov 2022 15:43:17 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.174)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 22 Nov 2022 15:43:17 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YcgRfy1T24bhBq7CfAJ/mworjACC1rjUD/LWNRImqb5Cog6CDUVJGpfxvprJEhPcdON1WbHOtQ4QGAyz5kGDW6U85ZdCKp1VSJOp1bnZKx8K9q91zTQDwqKOAmtyrQ3hT4euqq9s2PjuGPilBAV+7oQy0WI0qCbF1cstjqqESceFWi5dIO6/eVdKvw5wVfjPxj2Ou5Kb52umsVpuxELY4NKeHvHl9rF0ZWODeu/bCb59HLZylc+KMxxs4MAtZbFNkjUmmfF9kum1Ym0vInyMIeGg4IcjyXhiKIROV/IJOfNVI3s06RD407L0ZpxmCvMzngsRDjo5V1W0AwoinE0Tzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QmpKM68OImJ9reFNjE32Eb/upWcFMZLhJUp8t73ZHqo=;
 b=QP1armepbtR/HsPVlfrSlavDCYW0hmTV0xZkzKK42xB9XReM4DhyMiq5bY0pkKbNIFqEi4xEUmwIN5tOhKL1tIWlI/p4mG6ZEHC0E7HXP9WiUWhA0ghLwns6gNBVpPwxEGiMq/It+HpUy5TpcXld5RL1kfKYDl5jeKQ5M0gMG6deAAyOEjz869r/lnCEFZbrG27j4tZOxgvJg8OWSCBwaBtqkXlGqNxJdOMNWgQwlA1AjLuFqf55MKqjd+d3O3KG9rK4pDBvBnVoI2ItvnL3/j/CZ1N0fEGJ1JWUnZWf9CuxifzboQCHMclQNxmf4MPFX25ybXn+fRzAEyoKKjEMDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by CO1PR11MB5124.namprd11.prod.outlook.com (2603:10b6:303:92::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Tue, 22 Nov
 2022 23:43:12 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::6005:96bf:e2e1:2f7a]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::6005:96bf:e2e1:2f7a%12]) with mapi id 15.20.5834.015; Tue, 22 Nov
 2022 23:43:12 +0000
Message-ID: <5ce5bdd7-c2ee-fa7c-a01c-174ee3ee24d8@intel.com>
Date:   Tue, 22 Nov 2022 15:43:08 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.5.0
Subject: Re: [PATCH v8 10/13] x86/resctrl: Add sysfs interface to write
 mbm_total_bytes_config
Content-Language: en-US
To:     <babu.moger@amd.com>, Peter Newman <peternewman@google.com>
CC:     <akpm@linux-foundation.org>, <bagasdotme@gmail.com>,
        <bp@alien8.de>, <chang.seok.bae@intel.com>, <corbet@lwn.net>,
        <damien.lemoal@opensource.wdc.com>,
        <daniel.sneddon@linux.intel.com>, <dave.hansen@linux.intel.com>,
        <eranian@google.com>, <fenghua.yu@intel.com>, <hpa@zytor.com>,
        <james.morse@arm.com>, <jmattson@google.com>,
        <jpoimboe@kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <mingo@redhat.com>,
        <paulmck@kernel.org>, <pawan.kumar.gupta@linux.intel.com>,
        <pbonzini@redhat.com>, <peterz@infradead.org>,
        <quic_neeraju@quicinc.com>, <rdunlap@infradead.org>,
        <sandipan.das@amd.com>, <songmuchun@bytedance.com>,
        <tglx@linutronix.de>, <tony.luck@intel.com>, <x86@kernel.org>
References: <166759206900.3281208.11975514088019160962.stgit@bmoger-ubuntu>
 <20221107102134.255757-1-peternewman@google.com>
 <cccacde9-7d0b-f0c8-2e3d-2b09c910b8c5@amd.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <cccacde9-7d0b-f0c8-2e3d-2b09c910b8c5@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY5PR03CA0006.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::16) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|CO1PR11MB5124:EE_
X-MS-Office365-Filtering-Correlation-Id: a93d7c70-f165-4334-8ffe-08dacce3516b
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Jmt6+/HN82h2F4qATiAgHHgtBVNWl6VgOijTHbGkKi7DORIvctySuQUfMJ5+hQDfPHLvPBQkg3vhXkdCxBndy5dgJ+uX3lKtOwFTfkNL6hduhczkSCyxDyuBm41wh9nxklAKqhDZhamJfGwn8DcDdY3xw5xOMWKjDxs+x0C6EXP628aNEaD8KEot8aX/3wJofT0mqO6tJlccMSfmk6SgOsI4DFBThIpcafNjF+f7c02Utjf7yTxXcVhBcrwDbd49DcxehMFKqyH1j0pJYgn1Pg0ZqT48vNsUzVvMaVE08nKzMUmZ3zN+ABjuiHMjyfJFENQEivQD3BpF0EgM0XVaBkDP84S3Lo2t6uQdxBYKWLd0KordH18ZghbS00kq6z9YHXzzOpu9/M0/mYvfYYlWPdECEgcxufyPA16v8/JwoFDA5fT/bV0seky4EH6W+0gFVdVFKpdhAWD7sTHLbBwesIpjwVGabjlArqySK+MWaLye+z7C1H78rOnfXJREONwwHlvE1gWMZjwnfhAYQ2IMxkMcKMDKk/3WCNTxFS3+M5HxJ9QQD7KTa2cmFgW80AGZzpqI7ODwVNdDyTGwPkjTRXQyq2nZa9zsPWkdUb3lQa0gFUVn4ZVxGdozhv/PK95kBt7FykVlJkN+1Iz6/3BfsOpzOJuzEhcH6I8kxiiO1QQBU/ipNIMD5xBPv0M095qQGtlK5yaM3kkYXrNt5VQwJidsF3hfLYjqp7hz/rUUz0EnvSn21wQw+5Pt3SFk9r2S
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(396003)(376002)(366004)(39860400002)(346002)(451199015)(966005)(6666004)(478600001)(6486002)(53546011)(66946007)(6506007)(8676002)(6916009)(41300700001)(4326008)(66556008)(45080400002)(186003)(38100700002)(66476007)(2616005)(26005)(316002)(7416002)(2906002)(5660300002)(8936002)(6512007)(44832011)(36756003)(31696002)(86362001)(31686004)(82960400001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RGZpdDEzdWwrZysxdGJ5SkRFT3VGUXdNRzZEVFlnSmluYVNLby9rYUd5VU5m?=
 =?utf-8?B?bnNaWEhrUDFZQkVaNVJNblpoUHYyQkpnMlp5NGtVRGpHSUlESFN2bDN4SDRm?=
 =?utf-8?B?S1dQTk9OejAzd2lJa0ZRYnFOQldSaVdYQllZN1h5T1RLOVhCSWRVajNUMW5U?=
 =?utf-8?B?Tm8zeHE3cWsyWVpENE4zb3Bpc296aFY3K3c0OTNNN2I4NjJFUUdyRGMwOVRr?=
 =?utf-8?B?U3gwQ0tYdFpTR0JId2Q0THJLL1FmMk1wNFA2ZUc5S3R4WTR4eWYraG5QbWpJ?=
 =?utf-8?B?TmlSb3paOFdHRTU5MWcvS2hYZ1pzQzJYUlRhOGZpMTBRdEk5d0gxQnNvbDh1?=
 =?utf-8?B?Wm5HampYZ0tZOSt3OHVoUGxnWmlydTBmMzNkcGJEOTdrbWVwbTlxMWM0dFRo?=
 =?utf-8?B?czI2SGVVZUVSTGttZjA1cHdqUHhrVDRzZlJLUVpRY3lHemIwcmRQTThiV0dZ?=
 =?utf-8?B?MWkzUVNadTVoUHRCUU9zTU1tQTA1R2drN3orcndlc0haaGdVblI4SG1lVGFY?=
 =?utf-8?B?d0phdlJWNG5JZDVYZTJ1NGxob2RaOFZxVEdmTDNvVFNnWlpwY0RSTGRsZ2g0?=
 =?utf-8?B?Y2ExU2hWeTlrTU5PdFUxMHNwYnd3Ylg4RExZeTNqWXFVbk9pL28zOThWVUhl?=
 =?utf-8?B?WGFtSithNHdEcjNOZUgwNUpLSU51a0x1TXNkaGJ3d1JnUzVKbHFIeHVrNFZj?=
 =?utf-8?B?Q3NBK0ZqRmdzSlk3a3hWMk1XQWVhNmhXVjFwWGJ5UWszLzdvdEJNam4rVEJW?=
 =?utf-8?B?WFVpaU1jaHQxd1JDWUpKN3RIYmplNTlpc0VsOFRaNXpWaUUrYXYyOUdnMFBi?=
 =?utf-8?B?THlzeW5GSDBGdmVxNnJPWVpGSExtRTdrWVAvckVwcVZYU29nakIxTXNlNnNU?=
 =?utf-8?B?dE1MY0d3NjYyeEQxNkpKa0tuN1F4MWNzQmtkR2k2V1E2UU5SUWl6QXB4d0pG?=
 =?utf-8?B?ZGdFS0xrRGM2cXp1WC8zUUY2R1lZa2dhSFM1dmxwOFlhZ1Y3S0hPbGxCNXJV?=
 =?utf-8?B?Y2xGVlI1aVdzbDFxUmNUd3JYbk4wN1JuUWpyeEdwc2cra2d5ZDQ2bkNGTktD?=
 =?utf-8?B?SkxjVzFXRm5QclNPRTZrOW8zNW5VZURXYWpXVDlWR0ZRNzVIZTNMUENVUnlw?=
 =?utf-8?B?VCt6RkhUY2JHbUVRSDI1OXB3T2xMUm1Ua2V5YTdHSnQvWktQWTdPM1B5S1lv?=
 =?utf-8?B?Z3NJbFV6Y1lyMW1oNXd2Yk9xbzNWTWpTa2c5eUR1TXIzakNnei9VUmdzeTV2?=
 =?utf-8?B?N0IrK1dJSUloZy8yMERMSC9wMk1SeUxKa2FQbFEwUm94bnkrZFA0Zy9VK1FI?=
 =?utf-8?B?N2NmelZISDdUemF0M2MrbFM2UzlnR2dxZmpxNzVETVV0Vi9hZXI4NEZIK3JX?=
 =?utf-8?B?NEVnNWhPVDZUWU9uYjVoODJ4dE5PcWFxMEp5S0NiZ051VFpSK2ZLanlzZWRz?=
 =?utf-8?B?ZW5iUjMwSXBnL2Jsd0QrRHFCT3R5U1picmtVVVJ1MmJTSUR4WVRIV3IvL1hq?=
 =?utf-8?B?T296SGdFZ1Zta0dMbEpCRGVlenZtbWRhTGZ3WnZGQWR5ckxmbWQ5a2xoN20x?=
 =?utf-8?B?MndLUWU3aGFSRDczU3I0cjZXV0NFWmZ2dHUwR3NFb1Bpb2xPUFdJVVRRWEI5?=
 =?utf-8?B?d2xuSnc3dTlVUVZwWnlGS1kreEdTVGNMc1VndThSTFA5N29nTXVUQW9rTVlt?=
 =?utf-8?B?aHRkNWtUbFlCSDJJRFozcmIzSjNCMUhua2s5RFcvMXNvdjVwTGh0eDlOMXVj?=
 =?utf-8?B?MzVrSXNuVisrcWlpMVIzUFFVOTAyUU9OVGNLNEdadWh4UFk2TXhvdTlVZ1dU?=
 =?utf-8?B?a2dzV3JqR095OXdRZ0E1Q3lZTjlPSGczZHRuNkdwK3BqaHZvOGpaLzNlQlp4?=
 =?utf-8?B?SUpFMnQxa2YraHhKNTJ2VUNtM2llL24reDMySmI3Y1pRNzdES2dmUVAwSDdW?=
 =?utf-8?B?aHlORTk5cExmekwySG56a25PbnJISkxrT3ZjMlAwZ3hyaFJjYzRMV2NQMFBz?=
 =?utf-8?B?QStKUUNRZjRYcE84a1VhakVKV29laitQUE56bjIwRDlWR2lJaFJFTC9LTGJk?=
 =?utf-8?B?RnRDQjhKRW14aGRoWGh3bzNTMy9UN01SK1FJVnpWYS9KMitQZ3RpZWUreHRD?=
 =?utf-8?B?QjIxZmtoM29nckM2cTJrNXJta1Z4azB0ZnQza1dUNVBZalNWcWRtdDE1TUlx?=
 =?utf-8?B?Z2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a93d7c70-f165-4334-8ffe-08dacce3516b
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2022 23:43:12.5117
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /f09OlLfT5ZEZ0WycUomoMemvTBj9CGTPs8RJOU3phPl2GQ9WutH1T3+JkziejvwumZvvnVn57xAVEyYasP+OFsHZP0oTd5+J0wqL5vbbeI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5124
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Babu,

On 11/7/2022 11:00 AM, Moger, Babu wrote:
> 
> On 11/7/22 04:21, Peter Newman wrote:
>> Hi Babu,
>>
>> On Fri, Nov 04, 2022 at 03:01:09PM -0500, Babu Moger wrote:
>>> +	/*
>>> +	 * When an Event Configuration is changed, the bandwidth counters
>>> +	 * for all RMIDs and Events will be cleared by the hardware. The
>>> +	 * hardware also sets MSR_IA32_QM_CTR.Unavailable (bit 62) for
>>> +	 * every RMID on the next read to any event for every RMID.
>>> +	 * Subsequent reads will have MSR_IA32_QM_CTR.Unavailable (bit 62)
>>> +	 * cleared while it is tracked by the hardware. Clear the
>>> +	 * mbm_local and mbm_total counts for all the RMIDs.
>>> +	 */
>>> +	memset(d->mbm_local, 0, sizeof(struct mbm_state) * r->num_rmid);
>>> +	memset(d->mbm_total, 0, sizeof(struct mbm_state) * r->num_rmid);
>> Looking around, I can't find a reader for mbm_total anymore. It looks
>> like the last place it was used went away in James's recent change:
>>
>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kernel.org%2Fall%2F20220902154829.30399-19-james.morse%40arm.com&amp;data=05%7C01%7Cbabu.moger%40amd.com%7C84a9d0f934894a3031a608dac0a9db33%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C638034133003350939%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=i3isjCzxnBp4b2VblC7ZpH3hShUEe7unKiKfngG1kzE%3D&amp;reserved=0
>>
>> Are we supposed to be clearing arch_mbm_total now?
>>
> Patch got garbled in previous response.
> 
> Here is it now.
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index 6b222f8e58ae..28d9d99a639e 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -1517,7 +1517,7 @@ static int mbm_config_write(struct rdt_resource *r,
> struct rdt_domain *d,
>                             u32 evtid, u32 val)
>  {
>         struct mon_config_info mon_info = {0};
> -       int ret = 0;
> +       int ret = 0, i;
>  
>         rdt_last_cmd_clear();
>  
> @@ -1557,8 +1557,10 @@ static int mbm_config_write(struct rdt_resource *r,
> struct rdt_domain *d,
>          * cleared while it is tracked by the hardware. Clear the
>          * mbm_local and mbm_total counts for all the RMIDs.
>          */
> -       memset(d->mbm_local, 0, sizeof(struct mbm_state) * r->num_rmid);
> -       memset(d->mbm_total, 0, sizeof(struct mbm_state) * r->num_rmid);
> +       for (i = 0; i < r->num_rmid; i++) {
> +               resctrl_arch_reset_rmid(r, d, i, QOS_L3_MBM_TOTAL_EVENT_ID);
> +               resctrl_arch_reset_rmid(r, d, i, QOS_L3_MBM_LOCAL_EVENT_ID);
> +       }
>  
>  write_exit:
>         return ret;

Resetting each member of an array individually seems unnecessary when the
array could just be reset as a unit. How about instead a new
resctrl_arch_reset_rmid_all() that can do so?

Reinette

