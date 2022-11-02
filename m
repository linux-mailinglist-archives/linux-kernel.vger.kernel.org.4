Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE573616D59
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 20:04:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231856AbiKBTEd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 15:04:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231863AbiKBTES (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 15:04:18 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2079.outbound.protection.outlook.com [40.107.212.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A28063BB
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 12:04:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vmykvt0g4NxVDgdDc/OPqGBvuqnfiphblu4OqMotPv5/uN6k2vhqaHzLtYOHgeM+w4cGXKJHg9lYVhgkKW+uvdzTWwuEABzAVCFFE5cSbUqrEfNGS/mOFB73aKgzhS5Xe1vB7fNhEQT3P5OVLKTFYUivBIVzlJ3atHulKeG273rnMJ5u4cnZafqr7XC/xQUNAEo7H4VI74QYzQ51oKtxXGkZvHSN0tIFErMxYzzvSlYRvLHcRMoBD6COykUHge+1PJDGjFBAUUNPEIipqbwukwwHrycheKcjO7f7uUK4spe8AFWrZDtdOTAsepZv/iGIZnv12FfOGV4ppEhdEadTXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=61Yk3l7ndXgU89tbKln5l3H1jitFcIvGo4l4T3QIHhM=;
 b=hXBByAAM4VzkgWhCLkAEdTOrZOvZv5hAdfrQlQPdZZI9pPcg9j50yJWOgHaRPDon32W2wE/rnRC4RemzlJTTAzfQ5U0a2QfGaL7r+1AG4ffsMJ/kXIO5HY19XPpQBNXEWmzgawG/aOB5l0F95Gxhm+Itgju2UmxlDFyBd3RJczCHXpqEU3KwZuQnZCxomaEzpX8FnAULui/QfLlX7RzavUPWhAih4KFpWVEV1un5+jzSrXFxjzshlCq28rwN7vR4HqJ5U7+Orj/7DoE8Zh3tlXBfms/OuoZOYF7Hhk0wT0AUolvmZg4/Vr/I4W7DWbJGwC9xvx5izaenCO2QmFIrOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=61Yk3l7ndXgU89tbKln5l3H1jitFcIvGo4l4T3QIHhM=;
 b=37asxtdr/u6tytROwM6TyPz0ab2jxOTSjvUa1pLxe7eUW9ufS7e8hyrWREd6Wd1hncpHMAGkL1cTFJhwnBBpTTjBmHze3mr5JSPgDdUjMSC0Ghl4/9JXF9xagB78LQrtp+WYhKzFNkfqM7RkdcoptxF3oL0iClNSrBTXUVjvMXs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY4PR1201MB0181.namprd12.prod.outlook.com
 (2603:10b6:910:1f::11) by BL1PR12MB5064.namprd12.prod.outlook.com
 (2603:10b6:208:30a::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.19; Wed, 2 Nov
 2022 19:04:09 +0000
Received: from CY4PR1201MB0181.namprd12.prod.outlook.com
 ([fe80::a035:7550:7327:3d10]) by CY4PR1201MB0181.namprd12.prod.outlook.com
 ([fe80::a035:7550:7327:3d10%3]) with mapi id 15.20.5769.021; Wed, 2 Nov 2022
 19:04:06 +0000
Message-ID: <257ed6bb-6625-e634-a4b0-4bcca751d7c8@amd.com>
Date:   Wed, 2 Nov 2022 20:03:59 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] mm/memremap.c: map FS_DAX device memory as decrypted
Content-Language: en-US
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        dan.j.williams@intel.com, thomas.lendacky@amd.com,
        pankaj.gupta@amd.com
References: <20221102160728.3184016-1-pankaj.gupta@amd.com>
From:   "Gupta, Pankaj" <pankaj.gupta@amd.com>
In-Reply-To: <20221102160728.3184016-1-pankaj.gupta@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0069.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:49::22) To CY4PR1201MB0181.namprd12.prod.outlook.com
 (2603:10b6:910:1f::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0181:EE_|BL1PR12MB5064:EE_
X-MS-Office365-Filtering-Correlation-Id: c99b5301-49f4-4719-0640-08dabd0503ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WPZD5jvBQaGhgNVZx3PMe1LZ0NrnEXQzerS7dbV/yjHXwF1eP3fHup5dcUtU5zRH+MZKiax7x+UodF8J850LwTqpt6qim/E7WxpGYz5ysHAeOt7cHhIB1dDU6HZEYVWq7wB7eNuUXPsPMpfjtJnRSRdYmm7xDSANc7RHy9ZNPYqnVXcAJtJqNgFvB8MGo3HriKfJ29IJObY6yFbzz7g9wvpUmynIWzVIpt+P8vh1ew3BWiFrM6+xgn5sijp7c0VM9EL4UbJmeJeUPh4lz4gUJWYcQQLLQZepVLnVTEZCRdN6OuC/OhruWP1eYmbJCo0S5pixeEUsxF/URsQAp7ZaS9wTvJUhKSZ86+1PyOW++YiIz3bXjEFzYjpgDJ6AY0ta5hnRfzxRyQAEIkMAurQ77MPFhIus1fK3Yf5x0cRU+pTOSzSk7wMTStQ3BLnvJLFwUlq7ogT93c/UJ2PUjc8uzaR3RyuP+Cq0UMD7qR5Sa/bwqipQrc1sJuX01bbsRD2YvYHeL1hNar7qpTnNH+ng9Q1LjjqshSP/H4lxY0sskKMvcBg8auMAwKIdscUCVoSOsZxC6v5lO1F+MEYShrZtCBaJxlDPX4q2pwtKowbxYtxk+o4xHgpci/zYiuwJnN/dezThb0gaCMZ/g0zN8aBYsBmyFSiVgscp7UpMr4FOiVDjl0Vl7llI6IpMKVEzyfx5OveYQbDzgwYJHvdZevkkC3I99bwC0jCfzLkUS2jXtSZvgqEIw+2Tb6dkwwwe8wBZGC97prpokaKKE6UJhrOYzeIlqAQ5QHa4pv9BFZzMHbc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR1201MB0181.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(346002)(136003)(396003)(376002)(39860400002)(451199015)(38100700002)(36756003)(86362001)(4744005)(6666004)(4326008)(6486002)(2906002)(478600001)(316002)(41300700001)(66556008)(5660300002)(66476007)(8936002)(2616005)(6506007)(26005)(186003)(66946007)(6512007)(8676002)(31696002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NEVHalkrVkZJbkwrdGoyMDV1ZmJLM1NicExlQU42MzErb1FZQitTTDNvZW1o?=
 =?utf-8?B?aGNpK241OHBNb0RLOS9EVG5jWnZHR0xjN1M1WnB1eVlVZDNiaXlOZzhiY3hx?=
 =?utf-8?B?S05PaGZGcXRROXpwOEJVSkQvem1MZWI4TGVHUHNKYjlmZjhONWhVVHlRWGdB?=
 =?utf-8?B?UEFSUmxlb1RhRkh3YWlkdGt5T3dqMG9aeTIreHZ0eXRCaThzZlZ1QVB4QXdm?=
 =?utf-8?B?WTBZckxETm5Yd0tNNUhZV0paOEtOMFZuR1VlOHdRQy8zTTNZRUFlMFpyS1J0?=
 =?utf-8?B?dlA0MjcvZ29NY2RnaldpMEhsTHlNWkk3cUN5Y0V1VUhHSlRMTGhGY1EwR2Yv?=
 =?utf-8?B?QlpPS244YmltLzFXWEZtTWlkSlF3dTljeFFMSTBFdWwxb1hiRmJvam0zTjZs?=
 =?utf-8?B?L1V1TjBnTEpTUld3Q1FsYzQvNU9HSkZIN1JteG1FY0FJZllURmFzQ1d1cXdH?=
 =?utf-8?B?ZzUxYkUzbG1iRmhLL3NTTHRqMlRDcGF5T2JpRlRmQ3JGVy9ET21QVEY0QVJv?=
 =?utf-8?B?bmlVdWlKQUhHNzV1TWtiUU50UUZrV0RQZERZQ3loWWlYdXJoUUpCbUJqb2N6?=
 =?utf-8?B?MllXd2hYTUdhc3E3S203MzZ0eWNkVmdPNks5REh5ejU2a3ViN2ZVRGxwbG9p?=
 =?utf-8?B?Y0FmYndmT1BZeDZmMVQzWXVWOFdYbWZVaUs4U2hTKzRDc0ptVCsvZzBOemtr?=
 =?utf-8?B?bTlIcFJOMkpCdlV0VXBxbnpnSXJsWlFFMlJkYmk5S0JsbUhKdTB4c05uMjFD?=
 =?utf-8?B?S1h6NmNVd0FtZnBjaGhMOXMrVUlMNU5PR0M2djYySkVtMm43VFphVHAxeEVE?=
 =?utf-8?B?bGNaQTNiaG5WWUc0NzRGbkp2THgySEV2M1NQQnJMYmpYYlNCdGI5SGhUNVVo?=
 =?utf-8?B?OXF5cllkaWFwQ2trQ0VzVWUvMnRUVGhsT3BUNFVCVVpCYzMrVzdRZjRkeFQy?=
 =?utf-8?B?ZDQxbXNpRzlvdENkTTg3d3hzQVltYXA5THJYelZpZmIvS0hkSXp4eS9Ca3I3?=
 =?utf-8?B?YmlBVXlTdzVsSlEvVE1lZE93dUd4akZmS3JXQVBmRWZPbGVHV2NkVjI1MzM4?=
 =?utf-8?B?RzRnR1VhcUVFZEhaMHJlNGZlVWpPTWxBUEZXTWhiOFpCNXM2L1g3b0JEVDFz?=
 =?utf-8?B?TmtZZnppTFFnY3pBdXpPZkk0MzVzS2srSXhncnJ0MlFXdWxIbk82dEZRay8z?=
 =?utf-8?B?M0p0SmFYL3dOaTBWYlN2ZXhycHAwQVFURlF3STgwUWMzbVg5ZEdmenZjMyt5?=
 =?utf-8?B?bnJjZE83L0ppWTgvODRjL0w3SzFZTmJWM0hESndEbHBXelVSMFdqNllPV0NP?=
 =?utf-8?B?OWlOTEExU0F3R2xYM1dkaXV1WlFYSENleWJVZ042elEyK3lldm9hOFo1UFF0?=
 =?utf-8?B?MVlaa1daS0RwRlFNQnBGWURobFAraUV3elVsc0RrY0NTald0dU5VdGRQWXNU?=
 =?utf-8?B?Z3ZTWnV6TWNmdURhZS83UHhoOTVHbWxqd29tTlp3R1VFaU44MHZHcnBQbTBl?=
 =?utf-8?B?Q0ZkWHEzNDZ4V3hieHBmZ1ZiUlg5YkpCR0pHMVU4MHJEQjBPLy81K09FYTA5?=
 =?utf-8?B?NWp3RUhLODBlZEFYUWtVWlJFclg5SWVyQ0FmdmpGUVRGSUZPUm81REJJeXg5?=
 =?utf-8?B?VTc1endoVkZHRVl4OElkNE1jano2eGNaVVFwWVRxMThTNG11M0h1WmtBd1Fr?=
 =?utf-8?B?Z1NqLzFXcGd0MjdsQ3R0QVZjZS9rS21Rak9BbDQwbXlnazFHUXpPK2dVYkds?=
 =?utf-8?B?d1RscDJpUGdtZ0R6Z2YvTk5nUVd6Q3k2eUdZaEtLV3Y4LzVuVVgzNjNRN0Mr?=
 =?utf-8?B?TDlRTkdZRCtYWXBVLzhSUWFNZE44NzZwVGx6a1ZKSjFYU0ZKYXhVQzdkbk1x?=
 =?utf-8?B?YXBURW9aWHY1QlczaXBVRlV5SCt4VXNOOHNpcjF5cnBCZUVMOFduQXRDMnVl?=
 =?utf-8?B?Z1gxWkVrckNNUGpCVVZpLytweFdWdzlJOGNyT0h3WXRjY3RKY2tVNDVZTUZx?=
 =?utf-8?B?dGdCMFMwSlAyaVVjMnZQWGpIdUxHR3VnTnUwWW0zcmdzOFBla1ZRR3FHeGxj?=
 =?utf-8?B?MWo3ZWsxT1VzeEFUV3NrQmg0c2cvZndMVTd1dmxuRkdmS0h5ejZMeEtpZHRn?=
 =?utf-8?Q?oid6gAcYV0JNZUYGKoHbCj5/D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c99b5301-49f4-4719-0640-08dabd0503ae
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1201MB0181.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2022 19:04:06.3225
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qhaVLrRsQQVvHKBISQco/e1FFUTCu7SylM4LWT8f9RhdHOqpLS9tMmqfds2oR/WYKW8z6ymL3ttCBIxm31ROfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5064
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Cc Andrew [forgot to add earlier]

> virtio_pmem use devm_memremap_pages() to map the device memory.
> By default this memory is mapped as encrypted with SEV. Guest
> reboot changes the current encryption key and guest no longer
> properly decrypts the FSDAX device meta data.
> 
> Mark the corresponding device memory region for FSDAX devices
> (mapped with memremap_pages) as decrypted to retain the persistent
> memory property.
> 
> Signed-off-by: Pankaj Gupta <pankaj.gupta@amd.com>
> ---
>   mm/memremap.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/mm/memremap.c b/mm/memremap.c
> index 421bec3a29ee..08cbf54fe037 100644
> --- a/mm/memremap.c
> +++ b/mm/memremap.c
> @@ -335,6 +335,7 @@ void *memremap_pages(struct dev_pagemap *pgmap, int nid)
>   			WARN(1, "File system DAX not supported\n");
>   			return ERR_PTR(-EINVAL);
>   		}
> +		params.pgprot = pgprot_decrypted(params.pgprot);
>   		break;
>   	case MEMORY_DEVICE_GENERIC:
>   		break;

