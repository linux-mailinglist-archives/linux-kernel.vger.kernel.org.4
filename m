Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2037864D5DD
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 05:31:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbiLOEbI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 23:31:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiLOEbE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 23:31:04 -0500
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2056.outbound.protection.outlook.com [40.107.96.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34D8A21E33
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 20:31:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gIFLfszTnKU3a2t9cyBFsQRn58F43ChdbBXFjJr+0R8AA9EIDaFloz0W4TJOQbzsjZckdQISAZTz1P9cx/6RCRGfOJ2pPGajICsVjOr9bDE0a1wsS4fHagskNZkhyrdTaK65LdoJ6t977UXpOSyHjE/ZxdvjYg8ZWyA+ENm3bRhARcXCgEQVisZorrHeauEfpprXxLebcSaDPz28fotruwPBT/GgL30eeqV9rvB1xoN7qtx7RyDv7r4UMA8Ej5mwwsPRcX1XLp2nOoWy/41ADwwDKV7nL4HN6RecfiRXZvDc7amsX7pA5YYvqZ0gvP+aonmUIaeitpfp3GQKN4fJhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XW2uKQ6C9o2tFTTSEBXYC6I76VqIMTmEfb7dcdqaaGg=;
 b=By+KMEWDqU6yC44KQSS2SZ+lDoPBMUzsMlMbmGDznIEw4zUMPqzcW3vDi0aoE9BSAIFzwafEydDs2Q9y0YYv1I8GwRzc1obsyn9LM+mPSWhrvfGEL5PLQSnmTScmvBDMTxXFDHtw4b7gKIaFz/3tU6MxzGgHHozalap1D2j+mvSa1S4Xzr3epMpqTcbPVRyZLhV2JWVBNuO32KPwl5GZyFzCv4pWL8efPm4pKF49CImyr4uPLko90oQJWnx0AMEDb0KTLiD/7mYLQs876SwK6yRk7G9nLwnc0Y3vD3eokbrOKftgjnny+1H1A2+QzWK6z2/MuP18krNp3HS04X8nUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XW2uKQ6C9o2tFTTSEBXYC6I76VqIMTmEfb7dcdqaaGg=;
 b=BwJApAC5eR1Ic60gnQdyZPcE+lgAPf8lQ5he0vz+vtTdxPkZkY//iU2Vftg8wB0i4HmTTACHGkuoAaAH5oWLxSPToZK6aBOeW0OkC/eFkZr5Ex+6N8Y2i7lqtAquIiuazwSygAp0zWr3cexuBL4MsBODZii6WSClrn9qCKjdY/k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3370.namprd12.prod.outlook.com (2603:10b6:5:38::25) by
 DM4PR12MB7696.namprd12.prod.outlook.com (2603:10b6:8:100::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5880.19; Thu, 15 Dec 2022 04:31:00 +0000
Received: from DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::2fd1:bdaf:af05:e178]) by DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::2fd1:bdaf:af05:e178%3]) with mapi id 15.20.5880.019; Thu, 15 Dec 2022
 04:31:00 +0000
Message-ID: <62bb5b41-0e76-a5fa-c021-e53c0c528339@amd.com>
Date:   Wed, 14 Dec 2022 23:30:58 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] dma-direct: Optimize get_required_mask
To:     Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev
Cc:     Christoph Hellwig <hch@lst.de>,
        Alex Deucher <Alexander.Deucher@amd.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20221214180025.163207-1-luben.tuikov@amd.com>
 <ce1b6720-b460-8e10-7885-31a8b6263908@arm.com>
Content-Language: en-CA
From:   Luben Tuikov <luben.tuikov@amd.com>
In-Reply-To: <ce1b6720-b460-8e10-7885-31a8b6263908@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT2PR01CA0017.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:38::22) To DM6PR12MB3370.namprd12.prod.outlook.com
 (2603:10b6:5:38::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3370:EE_|DM4PR12MB7696:EE_
X-MS-Office365-Filtering-Correlation-Id: e3e90940-4bc0-44c5-29e9-08dade552b20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rV7NlUZ2vw4Nhmtn32OAXlFm23P6iZaN65WQngUGgkoafrtaQ/7cTHipRANMKqLda/6o2mhdw1WorLIyBe/WW6D6792kwd20ryrhTnw/mnJWbxE3daiefpmjAYg+f058dXq+GSasw+Ic3gehbZlDH6umU9oy11i6F/TnaGnMZbdGlTcY52u596GFM4bp7kK4ot+SGuixJYgZLHnRhDUFnAJn93t6LayB68Ip6vpZjfZUNLiUBnKNySOuYKya40TPE0O8+6Ecq9lssKhuBrWxRhPcST0LVLkCIs6qZ3VqyehD3KQL1kafSIzkWiv0ZJlO6R9HiikBYyFLJrboH7dzuAQJifdddbP+ifU3v2ZcTVocVuWtKDjwHDu+NJIf2gYYlCzPewgirrb75W9C4pagN4Tr1oXSvg0JDLY+5kaiI82oOtiC/QV0ZX3Yg//4qCYgXtYCaJ0q/iJ4M7qOt0XhJiDe7AeqdlwmDpeHocFL++cQf0V86T5vBeLejFkdiCAm/ngePw01x1dKgFzoPa4VRyxVFdnIVfsKafPh5Db0S5TNXzRhVAQq9THvqRsZyFH7jOZvm7+SQO/rDc/RVAuMMAEKNl7PJr/F8cwVU3ZAMUk4IFVPGR+q3QzyW0bKuU3DofibJznQb9rHAZLaTjfVDI85zHinXA1Kh88zT64EoytE0w2koHQku+HA1WA5l40v4DVydBPpXgIpj7dndBJvWrvK8LiNojkjrSdjpFfQo/Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(396003)(366004)(136003)(39860400002)(376002)(451199015)(38100700002)(8936002)(31686004)(4744005)(4001150100001)(2906002)(44832011)(31696002)(6506007)(66946007)(53546011)(6512007)(186003)(478600001)(6486002)(66556008)(66476007)(8676002)(4326008)(5660300002)(36756003)(41300700001)(2616005)(26005)(316002)(86362001)(54906003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?blpraXRPZUp4TlhleWlJREFTTENINHpQbVNSUWUybG40cnBDZUkwQ1VqOHkz?=
 =?utf-8?B?anJoZXR4TlRzWFZvNk5Nbi9vZmdxbk5ZOHVlYStaUllYQ2VEL0kxODl6czBa?=
 =?utf-8?B?Zzk4N25UdHBzU1JMZEFxeXJLSmNrTlUyYlVMZlBEWG9ZWTRtTlBqeTN2QnZV?=
 =?utf-8?B?eFVKc0FGdVZvRjhibkgxdkxCR1JOZGxxcU1VaFdrZWFzV2ZtNHpJMDVEcTF0?=
 =?utf-8?B?V2hzRnlkSS9aNDZZZHRQTTd6ZkszOVRKNmtjUjZkQzhZUW9pTDNiOGFNaFFk?=
 =?utf-8?B?NmEvZm51Y2NxVkc5dUxDU2xJYjRQaEErdG52Vi9Bakt5QUZ3d3ZpVXROMXpP?=
 =?utf-8?B?WmVrRGVOVjF5S3dxRmZkV21xaThnbVlzTHZTOUNWTHBRTUZrSzlGdFZrdkFZ?=
 =?utf-8?B?SGd4OU00ZWtDY0pwMG1VRjNXMzJYYVkxMTMzZkU1TjBBbFlSNkRmbjU3TllD?=
 =?utf-8?B?ZTY5U3RBZnhSQ3dqNjFwVGowUUNncmJGSGdWUjU2N0pQbnpWMm91Vmo1NXQr?=
 =?utf-8?B?cG5IWGlQMGpYVlh4YWpHTXIxakp3VGpzcVNVL3VwcHdGYmhJMDhQMEkzMWJ2?=
 =?utf-8?B?ZmJCeVdnRVQvd0pFSkx1dm4yODliSmp0SWc1cGRMV3dSd1U2UEMxSGFZekNB?=
 =?utf-8?B?V0FDdjFFSFYxNSt6b0pleHErbEpxdXUyYVRnNzlWaGI3ZG1IWVBtSitHUThq?=
 =?utf-8?B?NWtqQ1ZwQVd4cWk3YlVFOC84dkFmeTg5UmJHMzA1Z3k2czkxL3JRaDl3ZkE1?=
 =?utf-8?B?YXRZTmVWRHlqNFlDaHZ4ZUpGemlwcHo4L2lmVmtQOW9LMnMrdHVLVlpkWllG?=
 =?utf-8?B?TGZ2R1JKM1ZHeXpVdXhHTURUUUhvdnhDSitnMVowZ0VySUtna2o1QkljQ0Vj?=
 =?utf-8?B?SzRtd1kwajZWQjMvUm13cStlOGRqY3B6NXFxbitudzM4UFR6V1VHWmdCT2c0?=
 =?utf-8?B?citxcVgrRFJSckRWMmlYUElRR0dOcHhXazRCVm5uVFFobC81bXYyZUhPWnFp?=
 =?utf-8?B?VkZtb2QvRXU2NU5PNFkzeDIxc1FsN1hpMEd6cFFBQ2M5VXQ5ejV5S2tTbjRE?=
 =?utf-8?B?aEl1UDIrYmRJNXc5dTE1d1VUM3E4QXA1Tmk2OEtjbXJMYmpzZkdOYzlUR2tl?=
 =?utf-8?B?b1EyQXJEY3MvOEh3dVE4UDNTZllhZ2JEYVdNVVZaQzF4VlRISkpBNlFnQVZB?=
 =?utf-8?B?Qks0YUFiQUh1UmtjaHgvOWZxOFVRRnY4RUJpaEJmRWx3eDV5akZIUmlJYVhh?=
 =?utf-8?B?Wkw3M3RCTkZyd1FsdGhMbUVrVjByZStvMEt6VW9MRC9Sa2hyYWRQK0oyRjVz?=
 =?utf-8?B?ZGxwWURlQ1NtSFRla0h5aExmQmg3ckNQT0pFUGlGTytMeEt6dndWc2FGaXU3?=
 =?utf-8?B?V0hlTzFNWk81aGptcjM2SFkrOGhEdERIOVpFOFVuUHJqNTYyeHNCbExSczVw?=
 =?utf-8?B?bmJUc05RdVFGZlNJenI5TnFaajVVczJiZlJDQ2xvcWVRL3VNZG1yVCtjUEFp?=
 =?utf-8?B?SnV5ejdUMjd6REp4cmlrbEJtWkVhOHF5TDJxWk1WN1JMWXZ3QzZwUXZSS3ps?=
 =?utf-8?B?MGR0Vm41SUZoQzhlM2J1aFByNGVLNzNNRllpVytCUTdZejdiNEF4ZnFpRG1u?=
 =?utf-8?B?S0hBVUVmc3hrd2RLVTZjb2xaMUZxbVZOR2FQWlpoWDFVVEhCeW53K2FEMENw?=
 =?utf-8?B?ZEdPWnJuVUpCejQzNVBteHdEVmlEZ2FrcFNsa1Jxekh1azhCUzVSQmZqVENN?=
 =?utf-8?B?V1hydENpUTNZSFd6dWVidGNUS2xWelVpZ2dsR3VyU3EvREZENG9ENnhQQjBZ?=
 =?utf-8?B?bk1raU5lN0JUNUNOc25SVXY2OUlnc2hpOWdaMjRBWjNVNkJzdWhCV0lkZG9m?=
 =?utf-8?B?TTZTY3h2aXkxdkgxMzlnNUZmZ3ZSaUYxc0pIRHY1YzJmcnJnOUxVQUN6dlRk?=
 =?utf-8?B?OVJTdTZhcXloNC9nQURaT0ZyN0l2TUg0R2x5MmdUcEk4aGVWZXliV1lrRVd1?=
 =?utf-8?B?anE5dFBUemV3c05WeTB2bjh6bSs5bVZjR203UzlvZjBVNUcrRGxiNGhIR0Nj?=
 =?utf-8?B?aFR2UFNWL1lLdUJDRkZlaUR0dHNoY1pCcVVHQUdIeVVmSytIV1JUYjkwczVZ?=
 =?utf-8?Q?5shUuRPZKDPfQjKECiFOExaKg?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3e90940-4bc0-44c5-29e9-08dade552b20
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2022 04:31:00.5023
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e8SArIu2zaRf8Ess0vBg9P7vNaR+KmDTyJGnq7AOyylL+RoZcuA0XZIMxAjVbhXh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7696
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-12-14 15:57, Robin Murphy wrote:
> On 2022-12-14 18:00, Luben Tuikov wrote:
>> Optimize dma_direct_get_required_mask(), in that we don't need to multiply by
>> two if we don't subtract 1 from the exponent. That is,
>>
>>      (1 << (n - 1)) * 2 - 1 <==>
>>      2^(n-1) * 2^1 - 1       = (by rule of exponents)
>>      2^n - 1                 <==>
>>      (1 << n) - 1.
> 
> ...except when n==64 (for the actual code below), in which case the 
> result of the shift becomes undefined.

Oh, right, for bit 63 being set. Forgot about that one. Good call.

Thanks,
Luben

