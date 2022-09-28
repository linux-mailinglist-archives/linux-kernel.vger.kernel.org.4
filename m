Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3682F5EDF07
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 16:43:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234477AbiI1OnY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 10:43:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233512AbiI1OnV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 10:43:21 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2045.outbound.protection.outlook.com [40.107.244.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90689AF4B0;
        Wed, 28 Sep 2022 07:43:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X3WmIjAvGZRBTBhaMU0NyA/y+qx/VRVjes4qQm5mH9ak/j02JrkKVL3IFMxmgYocS25UbopAiRUO25RuIb1KIdHVIYowRLbGA7T6dh3k8rjdvQAM5BbRqxNaS2aLz/mTrmLi9lv611Qx1KEQhRso3YslI7gPTszfokR4FdwHVMjPNAwIjoKN62/jx5escyFujphLd2w3tj8aRiQcVwWa3ooPD5kDzCuXeVe/wA5JDu4zQyl8uVgbL+8bNQBVzmNovqU38No5UQMjZ1NW65W8jrn7rH9FIzKPG0gKCTbUpNuxCF7XrQ0DQ2ZbGyCyctLQ71Y+XzAAS9klNQUab6q3jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J/bXSTzNo92NegiH2lvmQRYT8FKHoK7C+Sz7SjBqulU=;
 b=GoLiq8s1a4pLVM/msR58hS15nr/Va0daU8IMEnSgqZ3QMpJcJUaPncEU//rVJ1jOEb/fjuaBQALiBh3+Q6oxrT8zCL3f4Sn/BOSPLUEq3ucPbOCCpx2S0sGwJ8+F2COIaPWoSKFQTe6lsZG2UAz/qxjXrQ+F4y9BOXuxssU8fkSkMG87+Ba8/OEqGF4nBtJgscmAhWqIwF0sIa2da1TExV4sPw5AROUwutsgHwBFyL9FGWP7zf8qeO02NJVErS3fbj5HdCed1JDlBHBdu6KAvBnQz7DMfGAn+ZPvuk9awT7L0e44vDua6vHbY59TZQGz1N4AQCAhT7b5VZhphcAEKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J/bXSTzNo92NegiH2lvmQRYT8FKHoK7C+Sz7SjBqulU=;
 b=r4m/dg+PGYmTPf7PQ7bBXraj/fXXFCPn3bA67ZwtsHj4FmepIgL1vw6bkf8UElsyHTZghHzVOdBKNuh5V8jyppWog9FoqParBT+Iz3z3zxorCux5q3d8wSnzF2pPMgCgmBNP4tRvp5O7VJytpjfAxcEjfIqMipU03bcaYdGESwk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by PH7PR12MB5998.namprd12.prod.outlook.com (2603:10b6:510:1da::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.24; Wed, 28 Sep
 2022 14:43:16 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::619e:35bf:5e0b:c51e]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::619e:35bf:5e0b:c51e%3]) with mapi id 15.20.5676.017; Wed, 28 Sep 2022
 14:43:16 +0000
Message-ID: <3cb42d3b-703f-60e6-3494-b8eb80d04dbe@amd.com>
Date:   Wed, 28 Sep 2022 09:43:10 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v5 08/12] x86/resctrl: Add sysfs interface to read
 mbm_local_bytes event configuration
Content-Language: en-US
To:     "Yu, Fenghua" <fenghua.yu@intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "Chatre, Reinette" <reinette.chatre@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>
Cc:     "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "paulmck@kernel.org" <paulmck@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "quic_neeraju@quicinc.com" <quic_neeraju@quicinc.com>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "damien.lemoal@opensource.wdc.com" <damien.lemoal@opensource.wdc.com>,
        "songmuchun@bytedance.com" <songmuchun@bytedance.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "jpoimboe@kernel.org" <jpoimboe@kernel.org>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "Bae, Chang Seok" <chang.seok.bae@intel.com>,
        "pawan.kumar.gupta@linux.intel.com" 
        <pawan.kumar.gupta@linux.intel.com>,
        "jmattson@google.com" <jmattson@google.com>,
        "daniel.sneddon@linux.intel.com" <daniel.sneddon@linux.intel.com>,
        "sandipan.das@amd.com" <sandipan.das@amd.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bagasdotme@gmail.com" <bagasdotme@gmail.com>,
        "Eranian, Stephane" <eranian@google.com>
References: <166431016617.373387.1968875281081252467.stgit@bmoger-ubuntu>
 <166431038771.373387.9706240777220251603.stgit@bmoger-ubuntu>
 <IA1PR11MB609736EB0036405567A851649B559@IA1PR11MB6097.namprd11.prod.outlook.com>
From:   "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <IA1PR11MB609736EB0036405567A851649B559@IA1PR11MB6097.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR14CA0023.namprd14.prod.outlook.com
 (2603:10b6:208:23e::28) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|PH7PR12MB5998:EE_
X-MS-Office365-Filtering-Correlation-Id: 65b12266-69d2-43d7-293d-08daa15fc6ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QLRVk7HdCJGFKzCw9rt1ZxIK511l9hkxt2omn8o3ZS3EBYcmS6Mtvwa9ICQS2gBXO4YydW8Hpu/HqqImcrZsohBGUMIAlE60BloU6pzwu7Tiz8GjTlsGxRO5W8Un1jQ9XujqU5hYyQmThvMg7dvSkgOVQsVm6I32WSP27PonfFWhBn15DGQaQpFH0BBjDZPF4+RfRRKJzbEHBlk+rtPK5Ff88RQUkjPfawUnj7jWiLY7y+BLzSHoxAxiw/fERvZou680QVWLdrZay7z15wTMVVG+LVK5xEXoGKEB1cAUn8WDi+1NPquXmq7ZBmnKOHFWl70grz4KAO1MmaqGuYhD9oW3yGRw7vwjvIcXdp6kQDl9RVh3CzP4h6/N90upA6atlDu0mqeKQuky+745FxcaPJthGB8kgXXRXmHgs+ZpRCEDxSGJyPLwKyYguqZ6+Ol2U5zCYbiM04szGyl49doxGZoWYOnuIInSQ4+jNgjG7W5l53ICE8FDw3MZWgbrCrj+4QHmEPJGMdjOCgm5tG63HVdJiE7pjXlvcjhd4GV0t8aH7p96ROKS976zghrmduDKLAQZwgH2XnhTDOF7akX9YtdM5AZ/19VtvAdqK2/8n39L2gd68L37BMjhFCDk0ChrdZ4owZ8RRfrornZxHgCTkd1wuIB0TwjuiNkMjwJCj/909VjawaHy2MwhHMsduuGDKLkOA7oRAof263ErKcKQhtx3OxutfZOOnVMBZLnkb5TYJavEg8nt3l2dXuT+/xnqIjHLfh228PCZ2wTIHpZAyhnCT5hjwFZqoTsORBle+3E=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(396003)(136003)(376002)(346002)(39860400002)(451199015)(31686004)(4744005)(31696002)(66946007)(36756003)(2906002)(8936002)(5660300002)(86362001)(66556008)(7416002)(8676002)(316002)(110136005)(54906003)(4326008)(6486002)(38100700002)(41300700001)(6512007)(478600001)(26005)(186003)(53546011)(2616005)(3450700001)(6506007)(66476007)(6666004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b01YV2NtTlFXR1dzS0MxSE9RWTBjbnFPVEZVMUZjMytCQW5sN1FVbmFnK0ww?=
 =?utf-8?B?MEJoSU9HSTdLcExKdE1SYXlzdUo4Q3lZWWVpdmRaZ1pWc1czMUhaVFhVRXhs?=
 =?utf-8?B?dytLeEczUUphMnBtS1loWkhlMEZqbjNwZURhV1RuSkptTFluNFpmRk1hZ21x?=
 =?utf-8?B?WXEvNDIwL1M1QU5WdDdWeTJZcEszTFpNVWpEcFdwUlNvdWc4a2YwNC9TUHZ1?=
 =?utf-8?B?TTRxdEw0LzJSL0cyQ25rYXdDT3ZGNGVkWkhUb3c1clZtbTJhZFRxYmNZdU9m?=
 =?utf-8?B?NnUzT2E1UzdHRVNwbUN5N09McHVHUWdBaFdpWlJKNEtKNkt2dWJmL01ncTRT?=
 =?utf-8?B?RE5xb0J0K2JPZEhJdndjaHliTDdCdXM0NG5FeUJrMXlNSUFCdDZmNDMrTysx?=
 =?utf-8?B?Q1hPQWZ2TDF4R2R0QVgvUmJvTlJrdXFZdHhpbVRtelNScEF0T0tzVUh4a3pu?=
 =?utf-8?B?dWpFaWQxL3VCWVhmckNSS2RFTDRnakgrd21WVW01R1BXNzU2UWZ3d0hiSzZw?=
 =?utf-8?B?bjRva2drRnpESUgzWnI0d0t5S2tKUUtkaVlPZ2VUa1NnQ1N6N0N4TWZyS2Rv?=
 =?utf-8?B?MHpkK1Y3YnZmTlRlVFZOVHU3RWlJYnRVMWxRV3lTMzl0UDRjN2E4eEhYVXdL?=
 =?utf-8?B?TEtFN3E3cTlTL3doRmlUYUZFOGpkUGlTV2xkelIrZW9LellLcUEwcm1Dc1lJ?=
 =?utf-8?B?TTVqTENFRXVzclF0NXNlTGdDT1hkYTZ5N09kUEsvbmdmcFpHSHNBWDJLblZq?=
 =?utf-8?B?RHFWRUQ5Q3doM0NyczVYdVhIUFZPa0tacnd0OVlkVkRLTmNaOUFFaFJZQ0Ny?=
 =?utf-8?B?bmluZ3hlQmVNWnlJT0grRHpvUHJmUkIxTWQxQ2dKVjJzRXg1c3doM3JPK0NV?=
 =?utf-8?B?bjZuS1dTNU1rNHFOMjdwTWpTdlQyNHJYcTBhTWQyRTYxa2swOXBnR2Mwbm9j?=
 =?utf-8?B?WUZ4cWt2Tk9UUXYyTi8zclpPVE9ialp5a1NGYlVrcHdZY205K05rN2RpbXkr?=
 =?utf-8?B?OHJBM0FValB1cHdCeUwySGd1U2dtaVNoRTFwa3FyQnBwY2ZWbktSaHEwdnhx?=
 =?utf-8?B?L1llMnFzMThGZ0VhblhCVjlWamU1UVRhb0tLejFUNEJSeFQrY0JxV0hpalpp?=
 =?utf-8?B?ZGVyU0xQU3FDblNJNjFDRzdxYlZuWnlpMWRDUzVScTcrWHowcTVUaGhtTnBq?=
 =?utf-8?B?a0lKZVQxKzBaUU4zMzdGd2lPWE9WMlRVVGEzUmFOenZQdVNFelVXZExFTmRm?=
 =?utf-8?B?WTJhZ3JQU0FtRlVRMlJTTUZlbGJZN01tOUFUTFBicXMzb3pJY3NvM2crMnpH?=
 =?utf-8?B?czhld1BSbmxKNi9FSDQ0OXJjS0ttaE5OM3hqSmVRWmNOdHRiTEhRcXVWU1pp?=
 =?utf-8?B?RVd5MWFldWJDMGhseDJWYVYySzlLV1pYaklrbWJRNDRNVWhUUk9vMkhQRVh4?=
 =?utf-8?B?dUIvTUNNWWVQV0xEK2R6Vk84THArK3RqbDNuT1BPNmtmVnI2aDN3SUZuU3cw?=
 =?utf-8?B?SGdpN1ZrZ1djbXdEOWE0OFo1YU8vVDJ5aTM5aGlaQTJidVBtVHNYQ2w5N3Fa?=
 =?utf-8?B?N3VNaVNRaFB0T253ZS9NTlJRMW5Lemt1VHF3elRieTg1cGs1bHZaUEhFd1dh?=
 =?utf-8?B?a1R1NDVKZGxxMlVYR3E4eE1lcTg3WXFBT3Ivd2FkSU5XSVorZkVjQndtZlJJ?=
 =?utf-8?B?U1JDaWlXa0N5NGJBWHQ2cFFHcjVlMTBDcHpGM09aTDBkb3ZVdHJRcFdOUTZm?=
 =?utf-8?B?K2ZYZ0k1VzZJSnB2K2x6cWN5Uk43bmJmcy9ERlFWeTdJT3NEQSs2ZVJIcm5G?=
 =?utf-8?B?S3UxbXpwaWZpakpiN1VEcm52QlV1Um9XY3R0OHRWbS9EV2NGK3JwWHJKU0hX?=
 =?utf-8?B?cW9Fbjd1cE9OZEw5bnZmUkVMRHhTeU5MdTMxVHVtUDBpckhRdXI5Tmx1NDJK?=
 =?utf-8?B?cEUrRnNYMTNvblU5SGozbk1YNzlGUGxYTlJ2dEJkVjdmYVE2T3MwRkJnZ0ZQ?=
 =?utf-8?B?WXRkV0U2Qi9XUVRCcWw5S2k2NGljVlRMcmRjRndVMkZDdmJiblVkZXpLOS9s?=
 =?utf-8?B?czVXWXFnQ0ZtZ1ZRREVZSW52dTEveFRDNEJVdFZiOHpMNjdVMzVkYWZkZ3pR?=
 =?utf-8?Q?y4+A=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65b12266-69d2-43d7-293d-08daa15fc6ec
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2022 14:43:15.9864
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gY/8Q4Z2UeviM8QmaBbvdh5J8yw4yZhn0adHa8XdN/21sssAkqjE0oA192I/qcVg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5998
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fenghua,

On 9/27/22 17:42, Yu, Fenghua wrote:
> Hi, Babu,
>
>> By default, the mbm_local_bytes configuration is set to 0x15 to count all the
>> local event types. The event configuration settings are domain specific.
>> Changing the configuration on one CPU in a domain would affect the whole
>> domain.
>>
>> For example:
>>     $cat /sys/fs/resctrl/info/L3_MON/mbm_local_config
>>     0:0x15;1:0x15;2:0x15;3:0x15
> Schemata has format: "id0=val0;id1=val1;...". Maybe it's better to use
> similar format here: 0=0x15;1=0x15;2=0x15;3=0x15? So we can have uniform formats across
> resctrl.

Sure. Will change it,

Thanks

Babu

