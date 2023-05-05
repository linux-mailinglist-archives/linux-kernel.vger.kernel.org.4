Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5644A6F8A4A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 22:41:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233075AbjEEUlE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 16:41:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbjEEUlC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 16:41:02 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2066.outbound.protection.outlook.com [40.107.244.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A604B49FF;
        Fri,  5 May 2023 13:41:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jPerEKPC8W7jIVPX+x0GJSOWPdtpkA+VYWZ+7qzTsyAHaqdYjJ/h8VGuT2l0PyQAUqa0HWmUfu7bulzxfAsdAKu8w/jGz9I6x1L2hMsVaHOPTP9MHMOT19OsAWbM6OxDJEIiTZrrQdJ/Q85OOatAiuRwIAHqeNWJlOCUQt6xoTV4/fhr5E2xTEmnysv4RDXa8Sw3M4pIiSS4wrvNxDwxpREifC29cvZEokhPbSmk1H0ObGmhnIT4KsDYSVFtrIC6nXkX3QAv1mqTwXWlLAWGroO8yTNcfPr/FqllQIShOabGGPSPsBnx8tCqxSU4u6PeU2CPTiyt9tUn5mk1XbLckw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4qA/zZYRQNWADbMtRi2Kbl3/XlzdwyeB2BJc4yKVDu8=;
 b=Gd+HWqqMmLERJEit76khaTz+9pmtfI4U0xaBazRFYXea0qll3zwDem+MoF5K4J04Aj25fyBbGZli08oDkvfhHFv4WqQ2Z47oVV669m7SeFjtGjIgUg7yVS5ntAhCtTTVe3nUnH9MIFbXcE1sB/kAQ1N/zQc4h9EkF60B33l3XgMeUL+ZBSS1mpXdu900YjXw52ZFZDdfIz0awZF5SzqEl17nifOcEDXfCjl8HDWbqXfrgVS+PN01YrQIEhOq+jpD5bacAImpCsyYppvzET7Y9GsNcyQoAI2oSMlqUjxLupyhVh2ikIpzDJ/PP76XuRFRaKnyHN4KNAaHkRfHXJ/COQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4qA/zZYRQNWADbMtRi2Kbl3/XlzdwyeB2BJc4yKVDu8=;
 b=JQECdcIhQHtk/epMgZTyxANqltlje8bC6drgOUsMyLQKW4DrgmIGkGjQYU3itFvZYSbBUNbaJmy6q72SE5xu5o12opcN0Dsm8VwkkPJ3c6Mhxv6YpGXN1WUdN9dJ7XDQWCcxwGWEdJKw1fZwe5JylwYZC+AEuBOTtPEVRom1tPQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by DM6PR12MB4513.namprd12.prod.outlook.com (2603:10b6:5:2ad::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.22; Fri, 5 May
 2023 20:40:59 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::216f:6f0f:4a21:5709]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::216f:6f0f:4a21:5709%5]) with mapi id 15.20.6363.026; Fri, 5 May 2023
 20:40:59 +0000
Message-ID: <c1a309b0-3d29-151d-b1af-04d524cfbd83@amd.com>
Date:   Fri, 5 May 2023 15:40:51 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v4 4/7] x86/resctrl: Re-arrange RFTYPE flags and add more
 comments
Content-Language: en-US
To:     Reinette Chatre <reinette.chatre@intel.com>,
        Babu Moger <babu.moger@amd.com>, corbet@lwn.net,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de
Cc:     fenghua.yu@intel.com, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, paulmck@kernel.org, akpm@linux-foundation.org,
        quic_neeraju@quicinc.com, rdunlap@infradead.org,
        damien.lemoal@opensource.wdc.com, songmuchun@bytedance.com,
        peterz@infradead.org, jpoimboe@kernel.org, pbonzini@redhat.com,
        chang.seok.bae@intel.com, pawan.kumar.gupta@linux.intel.com,
        jmattson@google.com, daniel.sneddon@linux.intel.com,
        sandipan.das@amd.com, tony.luck@intel.com, james.morse@arm.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        bagasdotme@gmail.com, eranian@google.com,
        christophe.leroy@csgroup.eu, jarkko@kernel.org,
        adrian.hunter@intel.com, quic_jiles@quicinc.com,
        peternewman@google.com
References: <168177435378.1758847.8317743523931859131.stgit@bmoger-ubuntu>
 <168177447844.1758847.17789021842152864417.stgit@bmoger-ubuntu>
 <67e00f1e-bbb2-59b6-fe34-758d5b268324@intel.com>
From:   "Moger, Babu" <bmoger@amd.com>
In-Reply-To: <67e00f1e-bbb2-59b6-fe34-758d5b268324@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR14CA0019.namprd14.prod.outlook.com
 (2603:10b6:208:23e::24) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|DM6PR12MB4513:EE_
X-MS-Office365-Filtering-Correlation-Id: 240c152b-8d25-4035-246b-08db4da90847
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Euwi4aTtxf5VFGgACck8sDhgmyybYdT8D9c7vizJlLwHlqBVNE43JXQwCJnL2miO96M9VHnfeF1BxSLTUyQc10o10EV3bXHwx9N6bJteauGETXSbPHXP1XfrywwLJq31q1qJEiRz3NqvoB3/vD2qzsr8rfQuVfuNinzBKx3PT3DE5txiNnCP+n/RrEZBN19D8IxK8GA5EvvfnWwv2JCHfFGaX2fMLFmiaNjPsGmfJrLi97JOUC45lktpQ2TUKEbvH7g/pMI8gIz+mDRc7YuKeyNx62fIdk+edvsIhxkokMhzHvqaPkd0oTxF7fhlB6DrF3Xg10Nza49Yv/ZLBux3wD6UVKfxobiteQQE4HbMb5alOFXLJbKkwZ5Oh5Xhcj+yC4fFhk2WTp4aHUPMhMOnAPtBujwl+8xLN8pvYrfGJ6x6jYcA9l9eSkGmZleOoby535KgKYoBqcPTDV4wJvUOKix33eGecUTZa5JPobeDz+KWgim9zS6XwAHpA74IuHugQ2IAXFQ0NvtnujSPjVNjMUgTdFmWGY/ngFz4CLFdrnCqdmXNxZQ7JuoJUKRAPBKH6AEbYOQPiIDIKDSK1BiUGeHiSYtca8oNWtTEdoZF7qx+GpnFFrduDowcJRPoYZOvSBbeokWXGiBJrYc67FdxKw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(136003)(39860400002)(366004)(396003)(451199021)(6666004)(478600001)(110136005)(4744005)(2906002)(31696002)(5660300002)(4326008)(8676002)(2616005)(8936002)(316002)(41300700001)(31686004)(38100700002)(6486002)(7406005)(36756003)(7416002)(186003)(53546011)(66556008)(66476007)(66946007)(26005)(6506007)(6512007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U2MrZDVzVXRPcXNIVXhjYXFobnl6c3BPU3dGU25uZU0rYkQvK1BiTXhKc2VO?=
 =?utf-8?B?UStBMXljWDBQZGNibzBIZzZpTkRjcFNsL0wwaDZ6cUd1QVMzeDRscHQvdkIr?=
 =?utf-8?B?YmtyeGUydkhiQnBSLzIwcHNHN25iNytyNGQ3Y2JycXkxMmZqN3NyYStXMVRB?=
 =?utf-8?B?YXAxNnMyWEdyZmpTRkNTRDBVOXUrTFJLZlZ2RVR1TXFDNm85U0xvUmswWjJz?=
 =?utf-8?B?SXZlbjFJTkFjOG05Z3UyNytydkU0a1JBUy9HNlFkYk9BWVVVT2pISGZpZkZp?=
 =?utf-8?B?K0U0UHRUNXZvU09yMVNlZWdLaGVhTDBBYlB2cUk3YkNFcCtENWtmK3Q4a2Z3?=
 =?utf-8?B?ekdlRUVNNERzL29hbDVJT0l5ZTNpdHRiQnNzbzNrYUlnekZrUG12am1tQmpZ?=
 =?utf-8?B?QkNveWg0eVhNZEVLOWxxK1ZPTXdVRlJWM25NcVdYMTMzQy9VcVdxVWlsSlhS?=
 =?utf-8?B?WFE2SXN6ako3Z3VwZlpQV0VUZ3VwbmMrTm5ZRDdUUlZBS1FhaUZrL0NlckMz?=
 =?utf-8?B?UEtZcmlkUGg2TGdvSVpQeXNteVByeC9CMThjdTdVVnhUem9sWmNTUWZZT1hN?=
 =?utf-8?B?Q095UWkyTUVIWXI3dXJ0bStRYjZwdEJqQ0YyTTZQUFZhVGN5VWNJVWNlN3lR?=
 =?utf-8?B?SS9ZbWFwQUh1OWZ2UEtWMC9VTFB6ZHdUYlE2NDMyUXFiWmNUaGlJckV6UjE5?=
 =?utf-8?B?MzNnZVJodHV2L3Z6VXYvYzE2bWlna08zNjRnVjBMWm5hNHZMSmtUNnJtTGl5?=
 =?utf-8?B?SVhSYXg3T1JLbTd3ZzlDU0Rob3B0SVYwNGxoWWhTaUZwSGg0OVNDQ3lvV2dZ?=
 =?utf-8?B?YkxFeHlOOE1DWGpDUmxsVGpJUFQ4bjFRaGxYTlRMKzRZUTdFc21vWWljcnlK?=
 =?utf-8?B?bDFDUCt2NXZIdGx6bjV6cHE3WjZKUzJCTGxRMCt2T0JteUYwb2dWT3JnOXBw?=
 =?utf-8?B?RlpXclkrUXJqcCtQaGp3cksrM0lrRmVzN0xwMENXYWFUTEJGc29hUTB0SWZO?=
 =?utf-8?B?aHEvekdGRkE2ZExzYTh0V3ljbHJlc2VCNDB1dEU0NTdwNTN6N05QUFlCeElR?=
 =?utf-8?B?c1plOG9RQld5cDhuVTMrMVNWdHJQNVpTWWNZZ3RlUXpuMkVlQ200QnB4aXJR?=
 =?utf-8?B?WHg4YjNJdzRTMlAyclF2ckIzREJEWlp1TzJTUHdLbXVqQlRMdFBYNGoxbGt5?=
 =?utf-8?B?Q0NrTzJsb2V3WXk0UEMxbllYQk1hYXo3YnQxRWlCNzdFdFdUNjQ1b0RONkdn?=
 =?utf-8?B?L0JKVDZlT3lGVTFIcnFrbjJmYWVRQzkzSUxKZThGRTZvNGlQMExJSlZsNG05?=
 =?utf-8?B?Zll2R2ZyM0x4NHpSRVNCYjl1c082bXpZZXUwU2RyT1R5M0FSREE1SlNDaE9o?=
 =?utf-8?B?TTQrUkI0WjAybEdZMnpaY2FKUjFHNDdveDd3ZDEzS1V3Ym1oZDhlNDRnNUho?=
 =?utf-8?B?ZjR1a3gxNjU3Y1ljUWc0NFVkVmwvNW14M2ZIaEJkSnFBdnJnVEpNZ0JXVUJs?=
 =?utf-8?B?RjRJZ0hjUUF3RGdBc0FHSWhaZU5Xb0tSN0ZkdWVwOTZROUtVMHVEWHRjZ1Jn?=
 =?utf-8?B?cUlQaVZqd3loK0VIaGtXd044T2wyQ1N2ZUxBTFFNSWlmaFMvOFRBQUQ0QWlS?=
 =?utf-8?B?SytQNmRWUjhaTXRtcjUzOXArVmh1ZElPYUdHMEVJRkpyR3dvWHpOYmZ3VTFR?=
 =?utf-8?B?U0dmZDlUWndQcDJYZW5KcHMva1dsL3N2Zzk5eEZlcER4RS90WXZwWHFXQmdk?=
 =?utf-8?B?RU9MSkZpUHdGOU5YSUY2MW9wbk12NUJuMEFzSnFrTmErMnlCZ2h6bFFPNkl4?=
 =?utf-8?B?M25kbnRMZmZ5c3Z1Ri9ZVmZ3THZsd0xhenJFNVZCUnpLcmIrY3lIWU01a0w2?=
 =?utf-8?B?NjlPZTc2d1VZVHpRYXJBY1R5Tk9RRVZLREl6Y3lGQ1ZtSHJwZUdIekwyVkxX?=
 =?utf-8?B?VGliNlRVZWxlRzQ3eDU2UlU3THdJb3loTWZNRG5zN2hKanlrTWM3Z0tJK05L?=
 =?utf-8?B?eHhwVFFxakRoRHFKM0s3ajZaMEhDZEtpQ1lNTXpzcjc2MHFLYk5aN0I3S2J6?=
 =?utf-8?B?MWh0MHgydERQTlJ0eDhmSndQTEVUYmU0QnhFbWVmQlBoVEd5ajE2MllqZUVj?=
 =?utf-8?Q?0jqX5BaCi55KA6RYBietHcpWx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 240c152b-8d25-4035-246b-08db4da90847
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2023 20:40:58.9079
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: epSvtu2sPC1Q5/4Y4Ck6atEjuPDyjHVLyKKCv2y9LtCRyjqFrl/f1JSttgpJQMOj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4513
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Reinette,

On 5/4/2023 2:00 PM, Reinette Chatre wrote:
> Hi Babu,
>
> On 4/17/2023 4:34 PM, Babu Moger wrote:
>> Remove gaps in bit definitions of RFTYPE flags and add more comments
> Why is it necessary to remove gaps in the bit definitions?

Removing the gaps is not necessary definitely. I thought adding comments 
will help adding new flags in the future.

If you want me to drop this whole patch, I am fine with it.

Thanks

Babu

