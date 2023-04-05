Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9CC16D73B1
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 07:23:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236386AbjDEFXY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 01:23:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjDEFXW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 01:23:22 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2069.outbound.protection.outlook.com [40.107.94.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 612B03AB0
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 22:23:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IBOMe6X+DtzpyEaJAmBcuz3h0cZiiMGhbHfc9nVUouDP7NPfgVoQOzEYlf0QF2D1ZljkQ1Q2nPm7ziq6SalMPgEiInPibvEeryE8ClhvIU8mGSSYIu4QeLpBu+Al0uI6TGZEXXwmf4Re5BrSgVI81oe21x2MDDeTmnKsOYoZTsz2/3YIuPLj+9NxGTvE/z5C9GLv4AUI3gvpkOd7B9Sm6WIlYefSEt0O4e0YNH9L75G04JkBELEO+N/Owjp+Zi0apxsJPG9Ha8CbMyQPQMNw4WSGpTfWrJohbzkHUCKiA/ktMAEca+JvRwvPkJCV8w8nGo54BsFwCDQ0isZ4LvkpSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7iZSCHs9j0rF4ydKFuau4nC4OPPgQkwnCKNWMNYN764=;
 b=Ra7kKhydvVxllrN+wFzoC1ubI09gyXCkl7gcg/oYbFUjdRPE118jugfy0nunrHaLVP82kBmHU4+h4oI4R6QeSEbSAY0WOvklvR4QdrI0IXFgd+LMcXmGE/nADMe/RArF5W4qG7QYJmbp7y7/jGXzGBGx3KdfO8++FBf0a8OoB8jccOHXXHacAEXVyGK468BVO26wslzF9E3Bzev+a5Er9vK0KjXvuDn3ZFSdjWA03if5Z2gj8e/xjvbP+HKiXDlxpI+3eU680IiAphZybvA2TCpDd+mfbcdHQqIPRcNclksmdDQkWLF5JTlcr/635uUydmQaMJbx/JOCiAq2tnLITw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7iZSCHs9j0rF4ydKFuau4nC4OPPgQkwnCKNWMNYN764=;
 b=NM31627TMhYg3mVSxBLHHimdw5Ee0r+/PRBPcoxg65xnUaFnxPlH78JgWgcli98ql9oDxRrDvRGBoOapoaU4ajE/Qq8M8YsKDEJuhmzyvFNlHKcXcjIXmMDjxUuoqxENWQORFTExbTtyjsuCRvKqyMXBc722gIpSWw1F2oLc9h8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6309.namprd12.prod.outlook.com (2603:10b6:8:96::19) by
 MW6PR12MB8998.namprd12.prod.outlook.com (2603:10b6:303:249::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6254.33; Wed, 5 Apr 2023 05:23:19 +0000
Received: from DS7PR12MB6309.namprd12.prod.outlook.com
 ([fe80::de58:ace6:16ba:96eb]) by DS7PR12MB6309.namprd12.prod.outlook.com
 ([fe80::de58:ace6:16ba:96eb%3]) with mapi id 15.20.6254.035; Wed, 5 Apr 2023
 05:23:19 +0000
Message-ID: <45aac589-4cf1-aa03-ca92-5df552f1dcd1@amd.com>
Date:   Wed, 5 Apr 2023 10:53:04 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Reply-To: nikunj@amd.com
Subject: Re: [PATCH v2 02/11] virt: sev-guest: Move mutex to SNP guest device
 structure
Content-Language: en-US
To:     Tom Lendacky <thomas.lendacky@amd.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     bp@alien8.de, dionnaglaze@google.com, pgonda@google.com,
        seanjc@google.com, pbonzini@redhat.com, michael.roth@amd.com,
        ketanch@iitk.ac.in
References: <20230326144701.3039598-1-nikunj@amd.com>
 <20230326144701.3039598-3-nikunj@amd.com>
 <93800953-b800-960a-f7dc-e517158b68fd@amd.com>
From:   "Nikunj A. Dadhania" <nikunj@amd.com>
In-Reply-To: <93800953-b800-960a-f7dc-e517158b68fd@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0031.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:22::6) To DS7PR12MB6309.namprd12.prod.outlook.com
 (2603:10b6:8:96::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6309:EE_|MW6PR12MB8998:EE_
X-MS-Office365-Filtering-Correlation-Id: ce6514b4-8f6a-455c-eb1c-08db3595dd7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VMXw59csrZuRMaOPqSSBnfK+I0LNS1BKzW3PRDT9RZ9H7J/IGq3u4XftzUUXpyf5ztXsAo244hTaomzdSI+pQ1asKQ+T56GL5i59nZ99p5IgMgaebTug9xp2I/Im+LGzPph14TSX8q74utQINoS6Hve8EjlpQ9z/FjRqCqUZbMnm4vHlVuwUuGS/pACMw5eKfJwVWaithKBeog8UU5g/HRAJi/F6pM85SuWO/i5fJuBVnUYVwQ3Ly/AIra5PjwwgHjxmPBmPeudG2CU/U3JMm5sCj5T6ky+9kRWqgTx2fxC1/Tq6CABSH8a+wjLQ8qNgILqlTd1e1ZG63uiqdMdwq22OaKUTf3/c6dbJdzaqFz/cpjhDOk0Z8pMZMe3Fe5kN1vKh4Oa4NQnvj/GKuytl7Wqsc2pCqSIm+G3g5KQjIO0EyyHRJtXr/oGm1n0bIMhnKa9Ipg7M1G1cOEKBo36JswFbDqzI8cE7KeD5eFzEy4rOam9nZR531yMpx2pRUJdKReWSSG2BKdVl8N+lvfO9cXMuMUrBcEsoa7lDpK745+5W2VE49ukl9Ely58LxzORzWUJXnggIwEMLvhOn7BKwFg79iWtNMH+wAWUQ2zEdskWbIyKQqghG2wJRImGhKZPJSARHXPWWTuBt6x0oqx0TpA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6309.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(366004)(136003)(39860400002)(376002)(451199021)(4326008)(478600001)(66476007)(316002)(8676002)(66946007)(66556008)(8936002)(4744005)(38100700002)(41300700001)(5660300002)(6486002)(186003)(53546011)(2616005)(6666004)(6512007)(6506007)(83380400001)(26005)(31696002)(2906002)(36756003)(3450700001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZlhlSFZ1MFo2Z1ZZZmFhZUdsb2tZMm9oNnF5MXFXLzFycm0zWDRuM3BQRzRD?=
 =?utf-8?B?Y2dOekNPaEZtclFHRlMzaERsZW94SklMNWpKVVk0RHNLQ0x1T0pWb3hBRXZv?=
 =?utf-8?B?MmtnVzFhWk1Rcmc2aHNaTGQrUnZnUEFYa2pJbWtHOXNldWxUU2NpZm1BdFJK?=
 =?utf-8?B?TjdOZ2E1YkFnTnlCcHdOa0ozeHMvNjc0QUZubzRZVGE0Mm1saHVMKzBxbnFC?=
 =?utf-8?B?L3VqQnp5eDVNVi9ON25wRVVZVk1Nand5aHpPdDU2aUMvS3g2aXB0N21SNkZ6?=
 =?utf-8?B?MXNzUkpjWEdPT2ljRzlLUkNSMXlQWFBaN1dzRGlKQ1NWaXYwaHE0WGoxK0dj?=
 =?utf-8?B?disrcHFReE4wcDMxRHJtQjkrQ25pQU5VR3U3blVyVzhwOWdRcWJ4NUxLNHUx?=
 =?utf-8?B?Vll0aWRtSDFPa0tzNUwvQ0JjUW5CSHloM2Z6M1ZvbGtGeEwxLzc2NkNXK05q?=
 =?utf-8?B?LzF0eFcyRnFSNkUxRTU1NGJyTkx0QjhEV2hTdWJ6NjdjckJJalgvSmxRdWE3?=
 =?utf-8?B?SU5uUi91SU5OWHIvQW95RkhwaHNPanMvdVR0NFRyZldoSjRnM1Z5MEthbDN3?=
 =?utf-8?B?bDltanorSHlLcFRFaXFrOU1CdHRjUkp5UzJXU09xL2NndnZFcURKSDRmS2Fw?=
 =?utf-8?B?L3lQRlNYUmVhbXdQSUdQVGhmNDd0S09rbWRWVUVoUVFlc3JTeFNyS2FuVmxu?=
 =?utf-8?B?UXYweUxheG15dS9raTJOcitHTVd4MjNWc2N4M0RURXA3a0d5OGl5TUdqb3pC?=
 =?utf-8?B?MFU3R2R5WDMzd2dFME03OUFpQ28yeGZqS25IWTRKNXdPMERnR3pYMjhxWERi?=
 =?utf-8?B?eVFRK3hyZ2J4K1R4UFZvUnVBUlpzcGFyR21hN3VCV0ZaWE9MdThpZS9uOXhu?=
 =?utf-8?B?OThDdTVJTUFHTDFLWEhPdjBPeHZEQTRYbGhJL3djQVBCT015RyszZTVpbUN6?=
 =?utf-8?B?aXJaVkhDTTl6VnJWR05lckF5TU9BSEd3R0JwSmlVWEtMdldSM1hEcjFWeE5C?=
 =?utf-8?B?Y1hpeGJkRXJkalNicU4wOXoyeS9MejZoNzJKVm9vbWhjZFVnUkNQUVdDRTB3?=
 =?utf-8?B?Mm41QURuUlZnQk96U1hQTmQxZ0Z2L2hUVFlmTWQ1bU54L3dXbzRGditjNFRz?=
 =?utf-8?B?dEFFaFpiUjNycDJoNHVvQStKbURvbzVFNWtZaEI5T3Y4U0tFVEZRQ0JYU0lq?=
 =?utf-8?B?VHRSdnE3RkI1Z0FlRXVHS0tHKzJxMzYxZXRqK1ltRHc5K1dyNHhZU3F4ejYz?=
 =?utf-8?B?bjBSb0pKZy9OZ0U1OFNnMTNEQUFGM1dMalFRMmtqUVoxVlZwT2t2WDRVNEI3?=
 =?utf-8?B?Y1E5dUpqZkkxWEM2Q1NWZmdwaElXR08xU0w3aHdOOU1FZU1kR0kzRmZZbklD?=
 =?utf-8?B?a20vS1ZUYUt4ZEZ0M0VxZkdZRGRPMWQ3MWdXRXhacW10NGRFbmt6UVVxUG1i?=
 =?utf-8?B?bEJrREN0cnFMSmJUaUQyUDliVE1KaUEyQXdXb3htcENWSEtGdkhHYjk1ZnJU?=
 =?utf-8?B?WE0vT2k1OVFGdEF6akZjcHoxWEQ3UG56T3ZJK2RGY0g3K3RmYWZ0S1ZjQVFt?=
 =?utf-8?B?S2lEYjRsUS9mVGhvd3k5L2xYWWdiclR2emRDQ3p2MFNuN1NObVBpTW40TmdB?=
 =?utf-8?B?MndyYzJtUU5tSDllMEtGdXBMc3RZS1hWTjZ2NTJzQjc0MEF4a0hPKzBsYkhj?=
 =?utf-8?B?Zk02azMvNWtJZUlVL25ib1ZtVGMvSlBLYkMxUjlIRnd3T2hHZ3FTWnVzT1hl?=
 =?utf-8?B?T3N4cEV2QlRiYmFKVmVjcURJbjBWUU13NWxjZnhvdy9QeFpIRmFpa1FSTHRG?=
 =?utf-8?B?KzdWK3N5dkdVT0phVURobUxPeUwxV1BzUWFYb0dEVWFKeDNxWWg4a0JMVnFm?=
 =?utf-8?B?R0hlQ2JpQ0hTRjNJTjBHOFNBd1JnZWRzSjhGdWRlZThrTVhmcGh1MEFkTTlk?=
 =?utf-8?B?bGo0V1NERGdJb2FYVlNGYm1LUUplNU9wazNZMzlhM2g4UE9VRTNhTTNoY1Ry?=
 =?utf-8?B?ZnBISVc1dFZHYkZxenZZaHVJd1RzaFR6TkpwNm84eU5EK044MW1HTUp6cmFN?=
 =?utf-8?B?ZkI5KzdZRi9HWFp2SExUTnp6bm94ZUtzNkdJWDF0bmx0clRkOHo0UXhHNVNO?=
 =?utf-8?Q?wIC8SfQrrXL+T7sQ/OMXz/81N?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce6514b4-8f6a-455c-eb1c-08db3595dd7e
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6309.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2023 05:23:18.9589
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PaGeNdeM0rFBBVQbnGj1jZ22mCtCvkdTGAARiE8Tt2vhkzrjggO7ZHnp7Kuqbz+kbicm5TlY8xfEaId2qNJULg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8998
X-Spam-Status: No, score=-1.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/4/2023 12:43 AM, Tom Lendacky wrote:
> On 3/26/23 09:46, Nikunj A Dadhania wrote:
>> In preparation to provide new API for sending SNP guest message to the
>> sev-guest driver, move the SNP command mutex to the snp_guest_dev
>> structure.
> 
> In preparation for providing a new API to the sev-guest driver for sending an SNP guest message, ...

Sure.

>>
>> Signed-off-by: Nikunj A Dadhania <nikunj@amd.com>
> 
> Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
> 

Regards
Nikunj

