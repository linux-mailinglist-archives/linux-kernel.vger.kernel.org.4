Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88F0E7396FB
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 07:49:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230503AbjFVFti (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 01:49:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbjFVFtf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 01:49:35 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2042.outbound.protection.outlook.com [40.107.223.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB57D19F;
        Wed, 21 Jun 2023 22:49:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UwmMMNhEGoC9lnMXt/o0chP872YyVStLnrt8/nDkCuNEjh53WRCBFx9k8NNZG412V7uNph9UhqXoTaHGX6P5lVDbW14aw9juB6XyTTetMSVlSP6sPBwC6aerLOBmCRSAuFGHn4s8NQgi9eQuQ7MlX6j0M3vTN4O4z/AoiB3QaptOdTizxRYhusTwN2FXIbFY77kQDB6kKyntnPJEUmTe4gbOZlJE7x+C5r7eNPU35U/D/TcJJpyhRSfQmVLs5tyM/p7/Z/fKBLKRdM4EmSAzadyWQP+BmYZH3h2HirLJndvk9SYT+L2+qSTl/u5HpIc31FWiWFkBFdJzfmv6iDemKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jQwbeQgnAPUnolHZaWzYIn4xtebpI5fbTX/qo33VLS8=;
 b=a3Op0/5cfQqvDIYmBI1Dx+4/NA8owhZBke1k+mtBR+Vf0XBKZvbfioXhxbCWadsLkXwl8+So6kYkoVNGhILAd157K3zYa1DKLum4wuG6YJF0NPgN1imcVwfBW14NKwJha8KmsxiczbKP//hVx6AV5ABXM5B9GIRreiE23mXurH4w0yj2exXj7a0GasU6KlNso3jOkyTTeXIcDyng0bZZ3+EyotdhrDQixPjFSPgSv53qyCzn1Ij8lo0tHd8qexbuhvOJoOA/1t6anjXnYynigaDdWxC5QLL3SAomkoPanagb1agpVGV4cOnbUh7MtRfe4xBI3caaWZJpE/4XU8y/uQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jQwbeQgnAPUnolHZaWzYIn4xtebpI5fbTX/qo33VLS8=;
 b=RZKCJJcy96PCL8irOdtzPNoTdjSfXsi+faPYCg/IqqA40eGhMaW7mX+8XKKG/P6pW5yFcf6qcdAb2kp2DFY6f1CJsW5dM7Xl8wbfPrCDbGAVo2ObE2HcrKZqkuQETDCJ5iTOvzaxaL2I7hNfhCqYXpHuhTltkiqJ6gJh4NJhNoc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by CH2PR12MB4858.namprd12.prod.outlook.com (2603:10b6:610:67::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Thu, 22 Jun
 2023 05:49:32 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::b4a6:94bb:6895:645]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::b4a6:94bb:6895:645%4]) with mapi id 15.20.6521.024; Thu, 22 Jun 2023
 05:49:32 +0000
Message-ID: <90477fcd-a31c-bb7f-f1e7-538df0d3bab8@amd.com>
Date:   Thu, 22 Jun 2023 11:19:16 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] perf/amd: Prevent grouping of IBS events
Content-Language: en-US
To:     Ian Rogers <irogers@google.com>
Cc:     peterz@infradead.org, acme@kernel.org, jolsa@kernel.org,
        namhyung@kernel.org, bp@alien8.de, x86@kernel.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        sandipan.das@amd.com, ananth.narayan@amd.com,
        santosh.shukla@amd.com, Ravi Bangoria <ravi.bangoria@amd.com>
References: <20230620091603.269-1-ravi.bangoria@amd.com>
 <CAP-5=fXS726wY1taYEYXDz3YZ4ZwxcL+nhh_yNM7rwamMd8mWg@mail.gmail.com>
 <3b0abd4a-6450-c282-65ff-ec0c7df67b03@amd.com>
 <CAP-5=fXfTDY9-uDq2BR2QmTP=-1=4RKRK=dvKmz5CF+oXgz+Eg@mail.gmail.com>
 <515f3ad1-3e2e-7c59-5005-1ce6ad83364c@amd.com>
 <CAP-5=fX3q8eS5yPK2RHFeLDH2LReaiaCOzTQrk+9wsQxZ1g34w@mail.gmail.com>
From:   Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <CAP-5=fX3q8eS5yPK2RHFeLDH2LReaiaCOzTQrk+9wsQxZ1g34w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BM1P287CA0008.INDP287.PROD.OUTLOOK.COM
 (2603:1096:b00:40::14) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6588:EE_|CH2PR12MB4858:EE_
X-MS-Office365-Filtering-Correlation-Id: 84653f92-cbd9-4523-881c-08db72e4732f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AFOVrldwICtM/ACUOE7pf8sJbOErT6YGAYdCjpVFe9XNB+n0PPWwTor3apvq7qe39VV3P58i3sxt7Lek7CpLoQWEML396X+5KOcNCMNjDJY8RLgNhQwmELOQ55LZ5vLD3ofHrdsnJ4jRBBhqcHLh4Jw60dLQYCT9RN52caLx4B+gsxlgurFpEVEsn3acB7K9/knnKq6aFeXGGq5LeJWRfRsbkbsf1MOQfIP3O30wJcIQN5Pj+EwT0hu/YSFQNNGYD6HH1OM9kML+Pq2M9iccwWyW2ibTvUA+HnMIkc81Mx/PvDRPV65Je25g0UmAtWp/rT+WnoWBDaCs4x9/pVkY0JLtTYyNRuBxw9P5tWsy2e+5Cw0PYGSUydffcPFlzv0VHt46bPEdCcXs3K+weR7ck2fjrmKboMvecCbtkhU2ceiFaNAGvSMay52EXjwCRlKmUiosLoQLU2hrOgQhyqhgegbwSeaXn91T4c0uD9fSksInjkNjUfI76SF4+M46LRl3MPy2HLQI748pWGJa9HdoMwA3plGkchDih014cQnEzGUpik6gB/1HLaSkkrYX/QAaqOVewbwsdHbKqzOrlqqctGSckKHZHFETNt6nZGj/PkZprXrbjV8aBRdaoi8qobdA7vxINcYErSFf4EcmJxmwNw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(396003)(366004)(346002)(136003)(451199021)(44832011)(2906002)(8676002)(8936002)(316002)(41300700001)(31686004)(5660300002)(66476007)(66946007)(66556008)(4326008)(6666004)(558084003)(6486002)(478600001)(36756003)(31696002)(38100700002)(6512007)(6916009)(186003)(2616005)(86362001)(6506007)(26005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?akFLZ25mTmFaRlJXTTlHVERMb0x0NFhkQmxFM2NKdXhKNEdBM0ludnJYbG9L?=
 =?utf-8?B?SlZKdit1aXBmNFlTc1JMVklTVW9UcGdOaGxHTE9TOURoSEtIV240ekxRY2Fx?=
 =?utf-8?B?MDVhRW5aVk9QUm14ckV4MHJ5empQZGpXU3JvWXBlSWxPMkhKVFRDbTFqblZj?=
 =?utf-8?B?UWJhUHY1bFovQmZKNWRTaVlBa3RkWWNxcEt3NFJXeVdZRDV6cEROV3YyRTVz?=
 =?utf-8?B?bG1GREJCYS9MYmZLQUxici9XVGR4Uy9GWFFSUEdtcXFRVnFrU3oveGtQRjJ5?=
 =?utf-8?B?RWhrc091RzAwZVlDRHd6WVUza3ZVUWI3d3o4bmRJdEVGdjg3SC8yOXZLd3Rw?=
 =?utf-8?B?bVRsejk4U0FnY2tsaUFYM0xMek85dUdZR2Z4NjhuRTRGRHY2NU5RK2RaZGF0?=
 =?utf-8?B?bFd2STlhN1dkZnA5Mjh2bi9pUFJ5WFUrVjN1Z085MXVzMjNsaEZCRTc1dUhm?=
 =?utf-8?B?N01iSGlXeW1KR08wTmg3VDFrd011enIxcHJTekVPaXNlSGFsQkdmeUNDV2Jm?=
 =?utf-8?B?OHp3NHFMTUFtNE9tcjdLK1Q5d1pBb0xaMW5HQ0dIRjdmOXRoazY4U2xOcHBV?=
 =?utf-8?B?S1ZkV3dQaU5WNVd2ZFN4eVdNVjIxYUZycWtiN2RVTlYxOUl1TmJJL3B3bXQv?=
 =?utf-8?B?VE1MV2JOWldVM3Y4UVVzQ2ZmMnE3RWpYbEM2V3IvZzBNZ210azVXVUtQSGhr?=
 =?utf-8?B?WkNFdFVOWWNiYUNBMHd4akVpOVNrTGNNUnFqTzZDNEZRUkFuMWJLQmdXQVVt?=
 =?utf-8?B?MkRoNCtCbUdtU2lxRHRjM0lHUlh0WVBOeFJpYmZWRFprVU9EZTF2VVN4MmRE?=
 =?utf-8?B?UWRxTkRTVVdydzRHdFpKbzZFaUpWS1hBRWRyTVM1aHlLQ1N4VG5zKzRoWS83?=
 =?utf-8?B?ZmdtYTlaSGFrSHo4MUNvME9wNW1rdnhPVkxRREJQcVNqQ1FWNC9TRmZDSHo3?=
 =?utf-8?B?L1FuTFErKzltT0NQNUpqUjN1SFBzV3JhUktuOXpNVmpZN3QwSG9FMDN5SlB4?=
 =?utf-8?B?SnBqTCsrWjkrZlZiRy9rUXdLS2dPeVh2Z1Ywb1YrZWdwWmlVbTNXWTRLRzRK?=
 =?utf-8?B?bFdPbXVzYU92dDZxS09Wd0hTVDZleGh0aHFZSGhwcklyWllIOHFDa2hQZGVp?=
 =?utf-8?B?bjU4S2lQaU1nc3Z1ZCtDc2NwNjBVWElZaE4vcjR6THRTOHVXSis0clNDTnho?=
 =?utf-8?B?ZUx0MlRPYkxYUWN1R2tMWDdrODFzMzBhN2lqVWllOURNR0szZ2RYWFJLOTFS?=
 =?utf-8?B?SXNyZzRxRW5SNXhvdjBHR3piVzA1aDU0N1BBd2dNZ3ExVzRDaGdkR0JzUWRE?=
 =?utf-8?B?czRoaFRSazRqUEJROSsrbStTbGd6S0RQTzZkQ1FKRzFiOWwxLzhXMWFmVVhO?=
 =?utf-8?B?WUg4SjhOZFU4ZndwODkveFdveEcwaTkrc21NcmNOeGowVnpDdjN2bzFuK3JT?=
 =?utf-8?B?alBlTnI5T3d6czZzQ090VWFicGNDMXYwdFpYTVdDZkZYUFZpRWhidVFaRDdw?=
 =?utf-8?B?YWUvNkJPWEorc09Hb1NPTTd3SGw1TlEzek9FcHdpQ0xEVlYxRHA4NGpUV1Q2?=
 =?utf-8?B?SUtlTFQwbEZFNTJSQlJaQUlWemFWZ25IRW9UWVVpVUVjQVlzc1NPbWh0WG1G?=
 =?utf-8?B?SlR2NmZHRjZORnU3VFVNMGpIbnNHNnkzOHRZazVkZ2NFM3FwanpLdnpLZzNi?=
 =?utf-8?B?Z2hRNDBBSVE1M045eGRQUkVLNVZ0R1J2NWxTVnRJWGQzUHd6TE5oSStRVWxr?=
 =?utf-8?B?Y2NsWXk0OW0wR1Zkem5JdFVYSC8yd1pLRkVSMXNhVDBVR1JDbEdDeUVHeHcw?=
 =?utf-8?B?QU9kK2FKNzNuaUFKUHYrcmtOMjZYbGo0dkhEUHd1anEwT04yUjJMSDVPRnpS?=
 =?utf-8?B?TTlEK05Eb2FUOFFtV1A2emw4VXRGMlhPNDgwa2ZUNEQzc2xNYjE4Ti9Ub0du?=
 =?utf-8?B?NHNmSVpLVm5rL2tkZENjUVZjbnJmVWswazRjU0dQWGt4R2Y2aG1uYnhPWDRP?=
 =?utf-8?B?NkZ1c0krM1R3ZFYrNS9VcTI3SmhUZ1F4R3R4SVV5ak5HSnY3N2hLZFZFaEpH?=
 =?utf-8?B?SEtDNWYzMUpDSkhUNmxoc3ltb1pnb0F3TGUzbkpMRFNOdnRDTWU0QkJ4a3Zy?=
 =?utf-8?Q?tsgkBzvwUgiAAnhh6+EfCndK5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84653f92-cbd9-4523-881c-08db72e4732f
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2023 05:49:31.9481
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mo4ONgKSu6jJc0Prq23ISgA2bkMDwjQOvJEN6xGBmwzHkY6SeL2AoC5noe03eFNBFtFDYXYc2TOKpM8B/rmd0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4858
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Sorry Ravi, I've got my head in the clouds. I was reading this as a
> tools patch :-)

No worries :). And thanks for taking a look at the patch!

Ravi
