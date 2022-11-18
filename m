Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67E5362EF74
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 09:30:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241408AbiKRIat (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 03:30:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241488AbiKRIaW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 03:30:22 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2048.outbound.protection.outlook.com [40.107.223.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11FFE942F6;
        Fri, 18 Nov 2022 00:30:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PS8/JI59Zvl8D/SSxfkZHAhfhdDFpFw4yzlKgz+s1+1g7LST8OHutBrKpTASGQPlSc7EWEwwjm5B5DFOewbDk1PqjmnHuT1Os20cn+8pDUGYmxVKUnS2wBxvfycbbUC041YkLTa8/8e6M5Ojcd7UehVXkA/sQJYLTgcHiRvuLWJNGyKPf1czScpSZKTrEiwOTQozY8yfgwnjCZLJtcVRtCHKYB6zLWkVGJFDQaBk8aFRZdEJSs/4xqT1yAitWmmtr9s1JgnoNU5IwnMhDg45HyyfMKZikDRxRUlrbfYp21X3anEeG32rwLTwcumj2J3E7oRQZ29zTOMKih0Jq9RUKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/8+cvQSc+mthUcPwwOvJLNPGCB6WTkgjA+LSC7CDuZw=;
 b=YVr+gj+IecOkjfTxVusoFRRrfws8/SPJyaDfW8f/BZ7WvuPLBazWOO3wjq9oKueX76scaLsWGcEyG/CXUSSOcu2A3A3E24uA+OULj/O3fvUiOvRUeLtzTnwuzPO64QKXFK7XKStljzv4fCxSZaQZJQtXsBaUV/x3YdNGd3YP3ufzendusf8mvlWkE+pI0/jrhQcxHYRBhJ0G9r3AdiAyuGKdRI/b/uXCTy+Y7OEsVl+kYbI8L5mTrpvhG8EQ01AXmHDYasXoPn1aDd5mXgBTYw0ziRTrOboT07UIP6tqAg01RRhg6rcTa3fhwwGmD8GJVfn9g2nnsdfZGn+8Z96O6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/8+cvQSc+mthUcPwwOvJLNPGCB6WTkgjA+LSC7CDuZw=;
 b=PMUfcRYBbBTW5Yp+tjFfi/BxxkKTkyL68BRS54gwDi/tUSVYWAs/O646nXD/nzFAja/DNQcdn4u/NPqBxbA3wxAQBLhoqyKKHfGvnkk2SGCZbYef+/fQgvuD5eUGitxLy6oP4W3olILSfKennut58aaDcbNGf8+kwjgR25ASBGE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by DM4PR12MB6613.namprd12.prod.outlook.com (2603:10b6:8:b8::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.18; Fri, 18 Nov
 2022 08:30:03 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::7d43:3f30:4caf:7421]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::7d43:3f30:4caf:7421%7]) with mapi id 15.20.5813.017; Fri, 18 Nov 2022
 08:30:03 +0000
Message-ID: <b432104d-025c-1b0d-7d4b-e01996003144@amd.com>
Date:   Fri, 18 Nov 2022 09:29:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: linux-next: build warning after merge of the amdgpu tree
Content-Language: en-US
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Alex Deucher <alexdeucher@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20221118174733.78a98e1a@canb.auug.org.au>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20221118174733.78a98e1a@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0053.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:93::6) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|DM4PR12MB6613:EE_
X-MS-Office365-Filtering-Correlation-Id: 67d4fcb9-be55-4a13-9ff3-08dac93f16f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OEyt8FxMsf6cYpfM/Tv0/5L6esgafoKE6uE4q1MdrR/yTgSp8O7W1vaZZuxcp+B1ygly7E/71rLKAb/vR66HwyU71zHkd0TcrjQyHY0ivIJvHsoSUKTAX5tA8Uq5orLT4kLTQxQQm33XaN66E/MBhHoNoZl6B+h3Jjq1T2CLdMyqsg7iBoyGDiUfpJZMdOC/3vVZ2LnUuNNGaYtvqnF/Hc1q3ZNND+oW0UczSBkj8U32vggiJKqUHJv2ZRNtrTzau0ND4uI+Ef0uOkV0/BAwlC1nzjgLlmi4dpvV+B2OSoWWW6vX+Hd9mX6GBeIyA16xho7iH35jxv5iTYDOfxb5D1ksy7s7PXL7PGCc9wraSmmtuWGWlvQr62R4772gz+09hmaUi0tmS2OmJk22WOp0YjvkS3M4L7c3bUeqLuH7om6jOSXaurtPQqENdXBK2KKoOPBRs58A2qtlKZ/mGdayfm2kzJIBKExZX6uclBfqlwtQ+gKU3KMYrV3FbaQn3kgQ8wl4msZblAJgWZ8hn2iAV9k/02kKj3hRtfch80XUFwvsz8bQdhwpLd7kgXxv3BjMf8eUe3AQszem1ZH+j8hrVb/vtMcbhIJGL3j9cS4AByktORuvhQIs9cLdXT2X/NKmopvZdPkRUg3JWrNv7lyWcWtiKQ3o4B20QSe+VOn/jyJFYfih1jWJ8z/HUxWSMchoyxJNWP2/8ufbYIsaEkcgeD2TX52kmkCGyjG+Zi6nHrg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3587.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(346002)(396003)(136003)(39860400002)(376002)(451199015)(38100700002)(83380400001)(31696002)(86362001)(478600001)(6506007)(110136005)(6486002)(66476007)(4326008)(316002)(66946007)(8676002)(41300700001)(6666004)(4744005)(8936002)(54906003)(66556008)(5660300002)(2906002)(2616005)(6512007)(186003)(36756003)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cEx4Qmc2a3dHd1A1MlZSU29QSlk3Qm1MaUdrV0pMazEwMFdDTGpiaEtIdFV2?=
 =?utf-8?B?bVk3RmpsL3NPR0NxNGhWU0xoL1NSeDN6aFVVUGtOeDFOVlpxMzcwcVdwZDA2?=
 =?utf-8?B?MjhrVHdCQzhWR2NyQXM2N1VPWFhKVnBOdGhndElRTjdYWi9zUEpJWi9ucVRx?=
 =?utf-8?B?cTJmUXNRV24vejhPTVMvamhpYi83UmNiZXQ0QU0rL0RMalJPU25DQ0hTTDMr?=
 =?utf-8?B?Z2REOGRLamlScHh2TDdhNjhKT2pqbWJacWF6OUZEUXkva20yZXVISEJad2RE?=
 =?utf-8?B?WlVSemhDakdRelFNc3dzS0JDWjlveVNKUWhGakNiNjhzNVUrdWp2YmJDMk9l?=
 =?utf-8?B?K2VzRDNrMXJkbGkrcWJ1VXA0aFk1YzNDcmppbnNoWWZYZHNaWC8zVlVHalUv?=
 =?utf-8?B?d3ZWWVg1eVRtQ295ZG9USUNZTDgxRWJHZzVLRlFZZDBGWEgzNTd2RjJ6TFNH?=
 =?utf-8?B?VGJlbkl0V2U4U1U4cEIyYXlSckkxZ2hUZHB4T3U4T3pVQ3dyRTdBZzhMNlF3?=
 =?utf-8?B?OWk2eGNCT0hBVC9YNjg1SjB4OC96RlFTc1JTWmY3RDFkT3hsVTVqbFlNd3Qv?=
 =?utf-8?B?UVJoNXp3dlFUNGZjdG5QdXFYK3RTVHN2NUNhTXYrNEUzQUFTZzVpZEJCdWZY?=
 =?utf-8?B?dXVyY3AyaE5hcHNkQkpnVTlTcVY1L2x5aGZzOXVGNWVMeTRWUzlZY2pSSXd3?=
 =?utf-8?B?OTdzbmtEMDNXWWQ1eWVBTzRCQlRhMFZvYitqSjlDUkdYZjNpRkZSOVNwc3U2?=
 =?utf-8?B?c2YxZXN3LzBXMUxTeWFBK0g5bjNPZ3FqdzM4N0E1SzZ4UmdMbjZBVHU5RG9P?=
 =?utf-8?B?M0lnbjdUTUpyZTNobmpmZm1nOGEyVlB3VkFGMTFld0cxMlI1QTc2OWNFWjEv?=
 =?utf-8?B?VkJNd2NSalJlOXBvN2xZOHFuc2lpSmdJdVZFeWRzb1FWRlZYU2pwQXFnYmFs?=
 =?utf-8?B?VVZ3cnFYNEJLY3ZOeDVqVklKVnV6cmV1SFZPZTdGYTRvMGVyNEU3RndRcVFv?=
 =?utf-8?B?MDllTzlXekFMOFAzNjA0bkhZK1UycjdyNTd1OCtKVHhRRHVMMkcrcHRUZkRQ?=
 =?utf-8?B?bkNUMDdKRjJFa2RsODhJaE1SS1BnZVRGOC8vbnlTQkh1bkZWNjZGeWFxKzRO?=
 =?utf-8?B?VjlkMlZZNDRhQnJHVU9zSEtGZDkvbEEwSHNtMDFNNXE3WXZSaEJTMmcrWG54?=
 =?utf-8?B?aFNOVzZFaUp6ZEtlNVZZam5LcTdON1JQa1FwVFhNc2Q4OWJPUFdSeVRNT3NF?=
 =?utf-8?B?KzliSUc0RldPNmVUMmJGVm15SUltMXVYVXA5TnZHVzFsL3JCOTRmSWRlNHFx?=
 =?utf-8?B?ZmJpRUZJanM5QVZSVjBhQktxNXc2OTFwS2VFdERKSGJnN3FHZ2tUemgwRHpp?=
 =?utf-8?B?RHlGaStTOXhOdlVwWEpGRXBVMy9aa3lsazY2ZHhUWThTNVhxcjdTbnQ1T0hM?=
 =?utf-8?B?YjJHSFcya2xBTkxGL2NqL3laOG1VcndWNjdibGt1MVY0UFlOek9UVzhyd3Zv?=
 =?utf-8?B?akhDM1lPcjdabnhTRmpUTC9LVnQwRU01bENwVmcxdUxyRG11Q1M2a2Zhb1I1?=
 =?utf-8?B?UlZqUTNMcFVIcXVsV3pWYVJKdmY5QjdBYXZUa3ZaN2tJTG1yTURvNDBrYjgx?=
 =?utf-8?B?R0h4VHdaOEdsY3NoNnJMSXc0MDhnTEpxcGJoTUtoc2JJNXlVN2gzWXU5aEdp?=
 =?utf-8?B?OFlMdEFpWHRrZ2llSjFWUmNyYXdER3g0RU8vTnp2TkR5dldDeXNURUxyb2J1?=
 =?utf-8?B?cmFQbmNsQ2p3Q2VLVnVPV095WC81OVFJMmVreisrcjEvODhtY0o3dGVpdFlw?=
 =?utf-8?B?bFZ0eFRlbXNacTZWcWh5OHM2SDJDZWdkdERRNE1reGRiZXZ4WTJIaURndTNa?=
 =?utf-8?B?bEgyNnNjNUxRUmFLZ1VIK2EvOWJxL0lBYnBHOXZGcmk0K3dGckU2RityZmsx?=
 =?utf-8?B?ZHNQdExyZTJRR3psaGdyVDZTV3pvYlN3Nk5CaXlxYXJrTit6NDRlWTRFM3pN?=
 =?utf-8?B?U3VtalJGeDF1Y3lBSkt3UnZYQmJPbFNlUCtuZEU4TEpmWVB5MVFocmUyWlFF?=
 =?utf-8?B?bUNUUVB0UWptSzU2RElxL21tbXhXc1FsZDFza1NYZWcxVkd3a2c0SnFvVzB5?=
 =?utf-8?B?VWw1cFZzdkZrTVY2dTM4SnlVYXZJVzJoQ2tocVNxRFRSUDNweEFsTmdRVzNG?=
 =?utf-8?Q?34eoTrtW5HJLuxPLwbXH7pLgU1s5zNpN2PT0/fZ44L1C?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67d4fcb9-be55-4a13-9ff3-08dac93f16f4
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2022 08:30:03.3630
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hARr8aOsvMbFuZTb8CFYWMYu+qeJG4Wc8DiHC6qv4QJI7sncWJgt88snQ43jLq1K
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6613
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Am 18.11.22 um 07:47 schrieb Stephen Rothwell:
> Hi all,
>
> After merging the amdgpu tree, today's linux-next build (htmldocs)
> produced this warning:
>
> Error: Cannot open file /home/sfr/next/next/drivers/gpu/drm/amd/amdgpu/amdgpu_mn
> .c
>
> Introduced by commit
>
>    d9483ecd327b ("drm/amdgpu: rename the files for HMM handling")
>
> This file is mentioned in Documentation/gpu/amdgpu/driver-core.rst
>

Ah, thanks for pointing that out. Looks like I missed that reference. 
Going to fix it ASAP.

Thanks,
Christian.
