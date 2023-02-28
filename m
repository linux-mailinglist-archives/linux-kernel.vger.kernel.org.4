Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D47BE6A626B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 23:31:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbjB1WbV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 17:31:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbjB1WbR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 17:31:17 -0500
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2058.outbound.protection.outlook.com [40.107.95.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85FA22E810;
        Tue, 28 Feb 2023 14:31:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bTpTjtCJh4LIdKghXsY/KLGTyUUUU0IjwgSfTxNl2j5m5sFtZSjLkZn7X4lkgxJldPnaT5AG2Nq7yoctdnpmGZDabZpUZCmG+W3t7MrXWAqtbwI7eIJ16Ywg2yA4Ma8guGv1Cnj1rspxJZybkVI2iYnn+4gmtI02Hc9lG6bT+7tWtbiQVYBehFUj1drw7kad+Fz0pUS+yCVbsd38YE3fj4FMYZycJ8g+Fuhq9Udff2hiPy/Pu7W6MZZzbQBitrdyS7ZsaOsok40XAkXgB4pDSSecV8W6u61FcsFR2j2zGNjnugGoC83lyE0NirBmlBrKpKiAnHI1G6RKwaVKu3ePZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wH2Td+bpfpPBp4FWtEUIwI3NnE0iwbP8rsdI35AuujY=;
 b=FhG6TUSZK9GEpD8Yx28cWNLjcA7AZfXpvPV1Uh40vZa5vBmd4LdY9kLz+OfU/r9w4cKE4Sdv/lV9Kng1A4MR/TBgfRBZoa5q1ODuUmV60UV2hM3fSiTfI1l1pxN8QudYmEG8du1dap6OZQstgSMIgBnFabdGRCw3GbNNHidw3Yi4GSoNeakkI+ubaXbgueOfc1JMDHfEt8Dizy2Oe1XQENltfUd+OhejI5RjeClxPt7FIvIfSXYb3VJCyGxH/pb2pXzYl+xAhfDVPE6ZrCsN//ZuJiqbOu6mTi+/aUM6Z+wdifkXsHq4ogEiI0YNDoxwYlz4Ei7aRtsP8+c9obK4ZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wH2Td+bpfpPBp4FWtEUIwI3NnE0iwbP8rsdI35AuujY=;
 b=Yg0vkWf4GfSuu4e0TV3e7e175jerPC5VAN7FPW0zQPW7roF2rFzaLbjIqj7uJiu2umIRppEMWNPTfV4OL/50BGRhKQYMjA67D9b2LFOxTl08NMnoB8zts3pJw6NEE7aQ/iGvMXWG7Of+r+oF7W8QFZQOOtTMpZHzAUpNFJsqEGY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by DM4PR12MB7670.namprd12.prod.outlook.com (2603:10b6:8:105::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.30; Tue, 28 Feb
 2023 22:31:14 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::3490:de56:de08:46f6]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::3490:de56:de08:46f6%8]) with mapi id 15.20.6134.030; Tue, 28 Feb 2023
 22:31:13 +0000
Message-ID: <11be067e-8d42-e10c-342c-4224ea546130@amd.com>
Date:   Tue, 28 Feb 2023 16:31:09 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH 7/7] x86/resctrl: Determine if Sub-NUMA Cluster is enabled
 and initialize.
Content-Language: en-US
To:     "Luck, Tony" <tony.luck@intel.com>,
        "babu.moger@amd.com" <babu.moger@amd.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "Chatre, Reinette" <reinette.chatre@intel.com>,
        Peter Newman <peternewman@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "x86@kernel.org" <x86@kernel.org>
Cc:     Shaopeng Tan <tan.shaopeng@fujitsu.com>,
        James Morse <james.morse@arm.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>
References: <20230126184157.27626-1-tony.luck@intel.com>
 <20230126184157.27626-8-tony.luck@intel.com>
 <85d7e70a-b9c8-6551-b1ac-229b51ee18d7@amd.com>
 <SJ1PR11MB60837729155ACDEB1C093DCFFCAC9@SJ1PR11MB6083.namprd11.prod.outlook.com>
From:   "Moger, Babu" <bmoger@amd.com>
In-Reply-To: <SJ1PR11MB60837729155ACDEB1C093DCFFCAC9@SJ1PR11MB6083.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0P223CA0003.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:610:116::15) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|DM4PR12MB7670:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d98ed65-18b4-430b-c5d2-08db19db7f99
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Mq+LANXa6DL34VgRPhN9D3arW0C81BR5S/uzF3yubkJxVqkC0kT+MAOmTGJApLYBsY8t2vmXAmYtR34Njpcu/WbtZsoQpcFAAQkRa7JxLirYMvjIrFbk++gQW6iOBUfJe7sZpoPbyS64hB46PyNa2dZDGqsSruQ72FPBtGS9iwN2NqeTUdWmQGVgurcttmnJm317mHHALrEZJdczxeX9mI1rUVcle0Q36lnxbFNMcm7Ufelz1fFXgPgOeBXMEyJGQuf7ecl5M+owhYFtTVCtKmp/PishYirmUxmucmW/ORHQMru9tDRVquu1Z9YQXK4ZrSOGLL9noGzXreamFv9WcR0eBVgO1nn0JZcf29jJttwktuF616Lg2/H+avaTj4ImUBZLxnM5/8VP2HVcaTCEd+iH7pX6dedfTUDowLglfjcA8Y1d9n1JGjyFhdY4daAmnS7Ub6yr9+qN9gARxzdaOQH174YONt/i4PsvM5AaPsaa4TyWAkXOKHY4Gh5YGMLFAJocebMuVxixw/G+CZl4EUvC/qM4hnh3q1EN4kSPN0+Aw9ULCDiMU8TyXr0EJ+h4nhYb0Z1JPbjD/UIWZL+3o+th1qWnn/Zs18i1TTthQLSiqfL5PXi9l/zl4AJqT/ZmyuDtOfL1Se3r594KTZSRfOlyfOWy9FIn8rF+magZSV7O0+Vh/WTRGv4vJ3xSde4GJCMH1N6qNiiUPZlglhD9AjqDjQZ4WxWna3BHq2Bd0in2KYH7wrB2sWdQFzlWic6b
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(39860400002)(366004)(346002)(136003)(396003)(451199018)(31686004)(36756003)(66946007)(66476007)(66556008)(7416002)(41300700001)(5660300002)(8936002)(8676002)(31696002)(2906002)(4744005)(921005)(4326008)(38100700002)(6666004)(6486002)(54906003)(478600001)(316002)(110136005)(186003)(83380400001)(2616005)(26005)(6506007)(53546011)(6512007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UTdrckt6ZkRuZldKNCtsMzF3UjZtMUlIcTZMNlhCYVlLcUkwR3gzYjZDTklH?=
 =?utf-8?B?TjlGWFlzVE5hcjduWDlFbkgyZmlSOXRrcEtMakUzcVViLzF2NUFXV3p2TmVk?=
 =?utf-8?B?ajBoMUtFZlM1WDdUaml3V0JzSUhsMFQxR1JIeHdtZnY2dWV4MXdndVluSmQ0?=
 =?utf-8?B?MEkvYzV4WXo5YzVWUVlzYzdIaXg2SWh3SzFGczJaQlkxQ3QxU0k2czR3K0xR?=
 =?utf-8?B?MTlKbXA3VEtSbWltUmhaZ2Rkajd3dWpwMmRNa1FDSE9IcnJnRk4yMENVK3Bl?=
 =?utf-8?B?VkNlVzBscWVMbTFMQ3FaM0xYTVhJWXUrNThJSW9rSWFldXN2V1pKSWtuR25n?=
 =?utf-8?B?TEl1VU5LRk5CM3ZnMkdYblFZYUF5dnRiZlR6QUZ4WGM3OTBaR3ViaXVoUlpY?=
 =?utf-8?B?SmVGRkszZC81YWQzb2JOY0lrRWNDYVlVUGVNMFAzT0U0NW5sWis2TzUyVUVq?=
 =?utf-8?B?cEc1ZGlJVjc3K1g5TEN1TUw2b3BDaVIyS3Y4Mk9DUERNcCtsQU1HUlB2U3k2?=
 =?utf-8?B?TmNHZUVUUkZoN3RpZW51RHQ2bGl6aENwNXM3R01UMm1ZRkNRTHYyUlVjLzdw?=
 =?utf-8?B?eXlLYmQzbzFyQ1F1ZDRtOHFaeVpjYUFIZ2trY3kxV3Y1dVQwakZucWg3cHFL?=
 =?utf-8?B?QnBPa0tFbW9WcWlSV0RNN3I3NDdzYkVhNkRmaUpxMnNkODN5QkUrU1MxM2Fs?=
 =?utf-8?B?U0pheFgzYlhhNWxaZWdac1BxbElZbXR3Y05MaTBoUUpaVi9zTHVRdlgvRHlZ?=
 =?utf-8?B?UXBRRkErTjJIRU1ET1o5MmtNVHp6SWZBaldkSlVOSk9BUHJ1Q2d1UUpBY2NC?=
 =?utf-8?B?QitVdnFpWUpzNlhKNFhXKytMbXZVWWZtSUcwMjlXb2pqdkhnNlVPTURzWVUx?=
 =?utf-8?B?WUErbUM2Tzc2Vnd2K1MzbE1TS0p6dnloNXNSOERvbVFUd1BxRm9XK0FNQ3E1?=
 =?utf-8?B?NzNRY1l0T3FTQlJLS1M1dFpxbEJNRnFSRExzaE9kL3dIaERNZ3BVcUlTbTFh?=
 =?utf-8?B?TzNoNzZaL1IvOFpvUDNScnNhazY0ZXBXelVxTlBmaVQ4TVJXU1ZBazdMQzdB?=
 =?utf-8?B?TkdOV1M2Y1FPSDkveHFjTmg4MHJOdWU3dlg4akt2Yjc4YkxWbHByVEN0NjJy?=
 =?utf-8?B?aVFzNDFtVXZOd0ZpbVZTMUpmTnc2TVduVHB2eUg5UHhJSG1yRXJPVEVSdW1S?=
 =?utf-8?B?bkNqZzNqc0V3Sk5BZGdxNmUwTVVValcwZFRhTGIyZ1dGdEdZQzhZc3FoM2dz?=
 =?utf-8?B?M1MxLzhDZHFZbDFPcnRKSUNSa0ZKUFA2Z2R4OUxDSU5HbEFwMFFQQ0ZPaTNP?=
 =?utf-8?B?SHU1YmJtbExWTS9KQm10TVBYaU52M093ZnJLUVVOdmYwWnJQRnRRaFlLeVdW?=
 =?utf-8?B?WDFEMGxpWHJ6NGdZOUwvOGl3VVJZQko5TXBYakJLUmcrSDA3UEhrT0VlRnFm?=
 =?utf-8?B?MUZQOFF1S0VRUnJRblh6U3RNcGowN3hOSUY4Unl1b1RZTGdwY21NK0E5SWpN?=
 =?utf-8?B?KzIwTUxNTjBYK05Kak5vQzBOMFl4UC8yMHl4bVFMWFFRQlVSRkhMQXp5bCt4?=
 =?utf-8?B?WDhUYUNJTFZJUzQyR3Vlc3ZlbWtpMURSdC9CcTl1dHlTbkdNY3dLbk82ellr?=
 =?utf-8?B?c2lPSDNkSVZuYzdmSHJ6d25KcVFaNHhQa3BMMWh1cHp5U0w4QVBPMUQrV29m?=
 =?utf-8?B?U0FuSTFQeU5ieEV4VVVNdjlWb09wM0xDcGFPUXRrRlJrWll2R09sY0wzWnB6?=
 =?utf-8?B?VFVJTERiQ0E0anFsc1VhZ2xYS3BVMzViZW82SlY2SzRKL00xVGVJZysydTRj?=
 =?utf-8?B?Nmlmc3hmNWhkK0NyVzFCcVVyTFJ3TWp1UVpNMVczQm00UmdnTU92Y2tjUXVx?=
 =?utf-8?B?UFlqeFg4WW5kcWpRaER1WmMrRHF4WEl6V3M4aDJRRklzeEQwL3RUMWYxcWhw?=
 =?utf-8?B?OVI4U3FDWVkrWTZCTW80c3FncStrRDZZT2dUenkyUDNBc3hjZnY1bE9ITTRR?=
 =?utf-8?B?N1NKOXAwMXJsV1FrWGxTWlpzL1dqR05kY2xsdTdPY25PNEl0WGFrUDFZZnJK?=
 =?utf-8?B?SFJOQnREUWVSK2ZydlNuOVhQc29IaVlJQjNwTDhNVVZHYStXWTBRT0NlZFJH?=
 =?utf-8?Q?0Re6tpsLDG00o9reUKqetLcwR?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d98ed65-18b4-430b-c5d2-08db19db7f99
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2023 22:31:13.4407
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K1qp9BO1+MyfBNoTFY/r+Z9aqTnJgg04hhFTYRpLKP6rSsa5+bEi0qdmo50Pyt7E
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7670
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2/28/2023 2:39 PM, Luck, Tony wrote:
> Babu wrote:
>> I am thinking loud here. Have you thought of addressing this problem?
>> When a new monitor group is created, new RMID is assigned. This is done by alloc_rmid. It does not know about the rmid_offset details. This will allocate the one of the free RMIDs.
>> When CPUs are assigned to the group, then per cpu  pqr_state is updated. At that point, this RMID becomes default_rmid for that cpu.
> Good point. This is a gap. I haven't handled assigning CPUs to resctrl groups when SNC is enabled.

You may need to document it.

Thanks

Babu

