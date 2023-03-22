Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E49A6C4C4F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 14:50:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230388AbjCVNuB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 09:50:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229937AbjCVNt6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 09:49:58 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2057.outbound.protection.outlook.com [40.107.92.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2817532BD;
        Wed, 22 Mar 2023 06:49:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=feznQ0r+3hAxB/rsK7LOBZL5/yaBam5WZj4hW2xkhQGYihN9zVqiOQjiZg2mOmKeYwq7VLZxzXl6O5WC3oqNDNFDhvf9w6M7Zsuemnk5zXoBpSWApOpT6FiHU2C50Gr6yGq+5UqbPeOPx1hvXZw9O27XzugVqtbx3czCo29m5L8Lxa9xPXo/u9ALXH4m1U7Y2RYZN/RM+mDM5Z1vnPrNycUqBnWv6th3/ON7yFa4kh8nh6M/MklwRiPzlP0/Da0jCoU3RMRhgnCCt5+Geb76JabqmS7Oa8kU5qeE660oneRgnw2UXybpdpihPw1wRVPQyXwU7vPzLHINlRB/T7vQeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zIVqTpsHwWL+YPkI9wqx172KEIYJcvzRTtY9jJ7sc3o=;
 b=QjIitYK2VbuFgKNUHDVEJDgk1Etu+jRlPCbvMd55bxbdFJsNAex5qZIaE1UXO2CqWzvZzLdlpzirgTtuLtDIP2v3An+v15BjuCB3QnWVOJV6kmBfxA4gfVevh50SgqD3iXQxNRXLAHBO7a2laDsd3EHKd2ImWwPMs/DQTUQgjsXcT5fm1RDcgAnPoA/L5Om40H8QFIRbaIaQ5ofAOol0oG/N/4gmdzxlW7mZpj5gtskLAzCBOKXfaTigCT65k8M0hfKQXT5L7CqGPi60Go2tofYTYKGCLeWRRxoM9GhUEjNr0H+EcGycSar5boRdl3+wuK+6nWOxp0+0W1ylrmSmJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zIVqTpsHwWL+YPkI9wqx172KEIYJcvzRTtY9jJ7sc3o=;
 b=m0JpxH3h/bsuY+uksrynkoQ4RWpvwBP0PFXDxSBTIimBGO5E41bpvER07OnrtcQcykzkhV1Mi2lqBqQ3ntufcsOR4PGePYxR/0LECorwVNifPV6ZBpUz8iB9gaeZBv5dJLAkMAOfzAzEnMTVITGYMPxmmsHNhxC/NLy8OoMM+sE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by SJ0PR12MB7458.namprd12.prod.outlook.com (2603:10b6:a03:48d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Wed, 22 Mar
 2023 13:49:20 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::3490:de56:de08:46f6]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::3490:de56:de08:46f6%8]) with mapi id 15.20.6178.037; Wed, 22 Mar 2023
 13:49:20 +0000
Message-ID: <b0647255-ce4a-ff0e-016b-2868bb3d6d63@amd.com>
Date:   Wed, 22 Mar 2023 08:49:14 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v3 5/7] x86/resctrl: Display the RMID and COSID for
 resctrl groups
Content-Language: en-US
To:     Stephane Eranian <eranian@google.com>
Cc:     corbet@lwn.net, reinette.chatre@intel.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, fenghua.yu@intel.com,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        paulmck@kernel.org, akpm@linux-foundation.org,
        quic_neeraju@quicinc.com, rdunlap@infradead.org,
        damien.lemoal@opensource.wdc.com, songmuchun@bytedance.com,
        peterz@infradead.org, jpoimboe@kernel.org, pbonzini@redhat.com,
        chang.seok.bae@intel.com, pawan.kumar.gupta@linux.intel.com,
        jmattson@google.com, daniel.sneddon@linux.intel.com,
        sandipan.das@amd.com, tony.luck@intel.com, james.morse@arm.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        bagasdotme@gmail.com, christophe.leroy@csgroup.eu,
        jarkko@kernel.org, adrian.hunter@intel.com, quic_jiles@quicinc.com,
        peternewman@google.com
References: <167778850105.1053859.14596357862185564029.stgit@bmoger-ubuntu>
 <167778869402.1053859.6094569492538617564.stgit@bmoger-ubuntu>
 <CABPqkBQWy2anBCvfo6DK5EyBxv3WrbUcxFVoLP=YsgYoQ1anxw@mail.gmail.com>
From:   "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <CABPqkBQWy2anBCvfo6DK5EyBxv3WrbUcxFVoLP=YsgYoQ1anxw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR03CA0077.namprd03.prod.outlook.com
 (2603:10b6:610:cc::22) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|SJ0PR12MB7458:EE_
X-MS-Office365-Filtering-Correlation-Id: fc045491-ce7c-4480-6662-08db2adc3c96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NfsoIascFzhHi223xual1ZLDOAzvzgqwCMTEn2NMHh+37aA0LHkgfnLgU1EnQrgZcLj/QHFw1+hDz8h5e9XvxXTIYf4VErty+Pf1bzaGuztY5CxI8AJQk3kKo1bHr541jPNBGjYt+cgGWhDpFsqlm0l/Ktp005Ejbo9H+Byv0LUMhYNL7yUEYG2QklnsHaBebV8O40LMz7oFZ40Gc3PpVND/uinP8JwUgOwseWYYyeDbooQNAppZDCXhTlOiIO5RClIgHr/HtleQ+Kn1E/gVcaL5zarFzoTBWAIN1usBKHaPCUMwn2/Vc3pO5ckIcieapcibrrYtiR7P4/4qCaQgjZliXe9003QqL5lz1xDfWQu+TpT6XMLFjRA8QOwmE3HIjWptjEFwGQoYZichP4Dn4lSTAxWVws1ybmp5V4OSS8NbWt7rElqUwgFkoDPBamjo1jmCc3mHaKFoBtd6xNDDUoTHiY1otskZOMo503GumRBEs83rOnrxK07Qf6Ec4nWLyEj39uYgpPv/dQnvr3FGmIvqnQLBsmz+TLTMFpBy7KRJTP4rQsokzErdrIWDMWZzKO1J2cGuAL7y6YKKo4bvjwh1B3iEKvHQ4R18tf5iuj2o5bkBgnGF6SINJf2QmldTJp4mkE809ZlL4x7thOAtqm/SP1GLL/FwzEjH9OTl2t/x+ESwLZzImBR1xk43opYg/OEKc0VgQ7xDlgYjIEmLmijsyLq2562+rE+EW4P0FcQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(346002)(396003)(39860400002)(366004)(136003)(451199018)(38100700002)(31696002)(7406005)(8676002)(66476007)(66946007)(4744005)(316002)(36756003)(66556008)(8936002)(4326008)(6916009)(41300700001)(5660300002)(7416002)(2906002)(478600001)(86362001)(3450700001)(6666004)(2616005)(31686004)(6506007)(186003)(26005)(53546011)(6512007)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dFVNcFcxT1JLNU9oRUY3bE5FbTh5a01zMEJ0SzVHZ2tJcU9nRjhEdkcrNlYr?=
 =?utf-8?B?aWJMWFlzN2FldkxSL0RMN3hPd095dlBVMUV3dlllbFRqbGdPTWZOaTRmYVdt?=
 =?utf-8?B?MUFSTkVLSnlYdXg0NkNhVk1UdmZsVFVEZ1RtMzhyY3NPbVh2OWloOFd0aytq?=
 =?utf-8?B?ZWRiZzJrUWdmTVpUeERIb1dmOW9UZ25nZ2dnRzZUV1dleVR5K2dETjRDYlNm?=
 =?utf-8?B?S29IM3Jhay9vc0hCbFpkS1c5bGZWVW1tN1pzenFKak1YZUMzSlJjM2tCZHg2?=
 =?utf-8?B?a1krT1ZURWVzUkRqc0xKVVZCUWpSaVBKdjJ0V0tlRUNxaXJ1L1BZeFV6NUFB?=
 =?utf-8?B?MVMvUEs4WFU2aW81SWRVcmVWOHFGVDViZTJXcXBmUHVlWEhpcEEwUXluQ2p5?=
 =?utf-8?B?R1liOGVUSGJRaEgxaFVoZU14VjF4R3lVRVAydkFmMzhtdG1QYWp2bzNVWkJX?=
 =?utf-8?B?VEVNdEtXejJhUHIwS24vR1lmMUdsdEtWcEtSUmd0OXNydjUwL2FDd054RjVU?=
 =?utf-8?B?VzVmb1NXcmZhUUNTTXBLQkxZRSt2QWhjdkpmVE0yNGtiUGp3czArQVVoWGg0?=
 =?utf-8?B?bmhUdVJpWkZRMUwzQjNPVkhJL1BDNXo3Y0FjajFKK2xoUy9SRzg1alEyc3ph?=
 =?utf-8?B?d05NZmNoYlBRanJ2VVd2M3JXMkJjQzNJNGtkMHZGVzhERm1LOFQ0TE1xcjE2?=
 =?utf-8?B?b0lKUGV5QStoTzVuY3B6WnkxbUdUR3d1a3p1bTI2OVpidE5pUHJrcVFlRWRV?=
 =?utf-8?B?MmllWUJNV24yamY1b3JOcVd6NThrVkJDWVpOdnhUSVNQQVVqeDhJY2prN0x4?=
 =?utf-8?B?UFNqS1FLTzdtZ3Zub0QrZW5hQnNIMk1DcWxveW80a1NaUXlKdzc5Q2lnSFJ1?=
 =?utf-8?B?QWxhSXAzS1NOTVpQTm05YSs0TmsyWU40a1FFeWpYZG5yM09NbGZMaVh6V0hQ?=
 =?utf-8?B?WnJ3WjdRR2JIU2RvSkZ5Wi9TNXA1N3NGRjZwRjRyanVmQy92L0xaSmJDOFNW?=
 =?utf-8?B?RFZ2TE5HYytqTGlnTlpiZ1FrL2xCOG9mNW0vSFpGSUR6RmpHTm83aTJFYzhr?=
 =?utf-8?B?TktRQmN5c1ZzcXdQMlBMMWdMMjBpL3NseXNFWVhaNVdoZmxFQzJwOUU2Vnl5?=
 =?utf-8?B?aXJxUnpUTHIvZDVXZndTbjZsd2laQmU0NHpGc1VEVUhJYmFMYTZFc2xOZE9y?=
 =?utf-8?B?emsvT3hFM2VxSTZJNHRTL2dRNnNqcFFlNUtOY3ZNczkyOUc3QkpSaENoOFJP?=
 =?utf-8?B?UnlaWk1LVVNWZTIxSVVIcDdVc2EzYjJLdFB3NW1FeHZHY3J0Q3RuQ0dIMEk3?=
 =?utf-8?B?U3JMaE9paHl4V0NUTmlodG05blNvOENnZE1OM3BkTHl1K0dkZUhLenZrUlR2?=
 =?utf-8?B?ajVaZE1QQndrSTlka1RMelNQbmVORXFsN3g4WUlpNThHS2ZzdkM3Ujh3dlJz?=
 =?utf-8?B?dEZ0djhEbS9VWDBaamI4NWVqbVR0UW1uL00xL2J0dDkyYVF0NnJZU1BtbXJy?=
 =?utf-8?B?MlJZOXk5aFVhNFl4ZUcxdkphY3dDS2VmNlNEdGhhd2RIUnBYbkJYSllZcUhT?=
 =?utf-8?B?QjFBd3lOZXMvZmE1MWFYUVQzZGJtYXFJSDlDOGlaYkhPSFdTOHdlTmZlUVVx?=
 =?utf-8?B?bHpJOFVac0hvZSsyMCszbDR5YjZQdnFEMS9jVkk3R2kwRVdCMCsyT3BWdjQz?=
 =?utf-8?B?eElGOHRJa2RUaVl4RWhWTjNSOVM0U05hV3F6clhCRFYyL0NJOVhIRCtBL3RL?=
 =?utf-8?B?QlF4U3ZZNE1UVlAyYlM2Q0hNbHFhSitnd0RvTnZ1UnRHZUI5R1lHWno5Njkw?=
 =?utf-8?B?RE05ZEFSVDN1aG41a1dtOU5KNXM4UDJSNUZxOC9OT216NEIrZmtFRW5acWU0?=
 =?utf-8?B?YjY3VXh4bFFLanlkZThMZDFmS2JjNjVnNGZDMTYwQWRGbkMzNEtPaTdDNDVC?=
 =?utf-8?B?RXg2dGp6SE50SmkweXkyOUpzcGFFSXcvMEpEVHFWMDEwYytraHVIeWFNTmRM?=
 =?utf-8?B?ZExSbTFPeC93WmdueDBUUjRzZHBuNlZhUjZWUjRZL0RMQnQ2M00zUEIzRnRI?=
 =?utf-8?B?WHdKRFVhN25SL1BDVVhqa0Y0WmpRYytpLzZBaFRIZ0JGY29rL2I4amFUWXVI?=
 =?utf-8?Q?qZtAUr03Xppd5sd5ei60dZa85?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc045491-ce7c-4480-6662-08db2adc3c96
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2023 13:49:20.3530
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +jc6khbREfZfTcSOl0QCXvxsY0ls0SU4uQ6VlnaLvpV9hM4M79cV8xCgh92+1m9F
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7458
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephane,

On 3/20/23 15:59, Stephane Eranian wrote:
> On Thu, Mar 2, 2023 at 3:25 PM Babu Moger <babu.moger@amd.com> wrote:
>>
>> When a user creates a control or monitor group, the CLOSID or RMID
>> are not visible to the user. These are architecturally defined entities.
>> There is no harm in displaying these in resctrl groups. Sometimes it
>> can help to debug the issues.
>>
>> Add CLOSID and RMID to the control/monitor groups display in resctrl
>> interface.
>>
>> $cat /sys/fs/resctrl/clos1/closid
>> 1
>> $cat /sys/fs/resctrl/mon_groups/mon1/rmid
>> 3
>>
> Is the intent here to be x86 specific?
> How would that work on ARM?
> Shouldn't we be using more generic names such as monitoring_id,   control_id?

Yes. We can do that.
Thanks
Babu
