Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78F026099EE
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 07:43:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230071AbiJXFnH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 01:43:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230091AbiJXFm7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 01:42:59 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2042.outbound.protection.outlook.com [40.107.220.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C05D87C1C9
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 22:42:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DjOho90NsXOmacIkvFGrAdjS3/bXxmzoYR9Y1KvuuB6xXgKeWKgVfs6WrpfFJ4q0xUdXVu0Z6kAqM9lsq7b/bDp2dzHvoYq3aVLJ3IlrLIGmyNXSpv5L/cQxyqdAhCpDPRsJfB0FyyE9yi+5LPUmrdpaeIub4KZ04DdOjOo3Rr9HcIPZRHvfApSXUGfSxSpsuQURDywNE265F/ZHaev4evAvp0iqTByyKLBNdyAxBCcgrEsMez/hkfatQini3fCMNV7PWIrmTXAD9pnYL8zw1qXKrUufLV53ukAIvE/z5LFGewWg57KKFuBv7aCjopT2bQAWxh14jXvTm9pwDo4vUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d9iwcn9fkLABXP6r3ucIASzGeHvFnBsjGIfZrD14gqI=;
 b=U9clo3F4iB+I3dbkPFS0/P8ePvOUdgyhhEm1352TK7uldFURetvCAjnIoFt63lLuyV5of0oZCtItObgcs8gm+7REBbbpDGBpRaIMlJea/Zjk2X5822+YBWEI1yydFz57UCMCqCKv98cmdHnDr1gzxb8c+bLQ+BYT12UOj+h8dsqOejKtIqLZOetEmJStRzLzVaUYsyYfLbnJj+U90yVjaoXFhpdxKZcMa/zAxLAQnP72S4+1Hg6pd3EeKfQaPu5o/X2l2lZgx79mwLJAmr5KVcVlZdBit/jimhHcVPsEAz0YL8IE/Sy0aQzmWTU2FoyKt0OWkp1Wfv/LaH58eg1dxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d9iwcn9fkLABXP6r3ucIASzGeHvFnBsjGIfZrD14gqI=;
 b=kb3EdG2rmLIudY+V629UoGiXXEHqqUC4ARz9B92gZHQEsicPwa55sq1FJRyKa7k/Ac/SP8lkKVRdU94jBxODKH2k5xYem4NWKRVUKwsiYA/0UKc2WD7GIrfiiBIpUCRX/473+lck+QT2WHbGIFBCWSAL/rZmTG6bRlhiJ9EHdxzo3cnf4u0wnYOtskzW1QnkLoAesnH+DFuo3x1vuyQ/KLSyF6dikTjG8M2Fagad07M6WFOOumkqONHM48yFeHG8R/OkmxjO/vDB68MZPlhteSzdNCOpQ7fKijqfjkShucs7MMlxF14xPoFoFrH9LWHV4of5KWAP2rkUp5Ak920duQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by DM4PR12MB6231.namprd12.prod.outlook.com (2603:10b6:8:a6::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.35; Mon, 24 Oct
 2022 05:42:52 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::fbce:3eb5:b646:6e3f]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::fbce:3eb5:b646:6e3f%3]) with mapi id 15.20.5746.023; Mon, 24 Oct 2022
 05:42:52 +0000
Message-ID: <2c800ed1-d17a-def4-39e1-09281ee78d05@nvidia.com>
Date:   Sun, 23 Oct 2022 22:42:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH 01/13] mm: Update ptep_get_lockless()s comment
To:     Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        willy@infradead.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, Jann Horn <jannh@google.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        aarcange@redhat.com, kirill.shutemov@linux.intel.com,
        jroedel@suse.de, ubizjak@gmail.com
References: <20221022111403.531902164@infradead.org>
 <20221022114424.515572025@infradead.org>
Content-Language: en-US
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20221022114424.515572025@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0036.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::11) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4130:EE_|DM4PR12MB6231:EE_
X-MS-Office365-Filtering-Correlation-Id: 336cfb6f-29f5-4de0-ebc5-08dab5829786
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ibsioy/wwb9SA378L1j+MocWmLeLVvlJ+S5JWTKbVHoLsUlviQMyXsoET2Edr5ySeTL3UaeDIhVD3ovgC+F3GYBGHZPTAB1JEVDeFQJwwTZXEn6F1dMsipY6Y3tPMtR1taMsyjB2Jox0QcbAnFWzjAd7XjgSKeHwBA+owBjitanaFX73W5oLH4z/NjE9nQj+FJRAvqGxuOsWs2j4t1GyBGf2RUSXC8+TL9KDxeEWeMOLFCQEMcwnZ/jCXe0HMvQKyIkVXIyHhV4++FqIOsOj99dcAX5ImwoiVQoIPUg5YegDoL4aXRS5xbI+KzXepQrlIVj6iJo14u7xzWEDb18frsivjMzZWvj6VzYM9oQ5B+2v2plupC3at8Yk5v5niJ63GyNEoBYAtrrbszfqZDoLMyFTUHdtAHpCg8fJbKXB+Ayzcdw7wqTWkCmjKapG5K/sNY/lGt7u0+P8/wuPpKPaHaGm1ni2e6USqNbD9EscPW3VA0RIBWOj7v5trP23JE1xK5abfIj+/BasR/qiErzFsDcnklzuAdPzP50RLZ+P6geplwRGSEnJqyB9yaE4aj7XzoH3Pd5ekEglNs9otdKyz20878FAQMundOEg3ZaFUkaDrneyanGhJSITQ/pgaBla+QoYSnK+2W2hPG9nYa5Xb+ILizLDCPdV4ruBKB7Lx24uPfh/vR3Oxx3pgsUkLVbVRCeWyk/p9ytyDG95l5WtfnbtNAn7FrCKS8XXgEX6Gl5ORs+nKzRbO0DQ3QYwVz5SYMbHznP2pWYisS7JZkAed1mCTZwC46YOx2AHPd6T6AlMgWozBtC5FbDaz2zTYFg5d1epR2Mo+s+wDooYHOSZ9+xYvAEB5BxOa19buwjUFy31JuJ1hLar34f7RoczD/dJ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(346002)(396003)(366004)(376002)(136003)(451199015)(966005)(4326008)(66476007)(2906002)(316002)(7416002)(110136005)(8676002)(53546011)(6486002)(36756003)(5660300002)(41300700001)(86362001)(15650500001)(8936002)(6506007)(66946007)(66556008)(186003)(26005)(6666004)(6512007)(2616005)(31696002)(38100700002)(478600001)(31686004)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WWFCTHR6Z2pVOHgvQ1I4UEtzZ29IZjYyQ29samZQVUM0c1FJakh1MHJGeVV6?=
 =?utf-8?B?RmhEb3N0dmM5RlY3dXlxTmxRRVJxR0t4cWtBR2RFVHc5ODlCU2pnWmlQT25Y?=
 =?utf-8?B?MFVzU3pucWRoZ1RsVVA1dEF3akxENzROc0Fua1ZSeHhKSHJybTJSd2lRVjY4?=
 =?utf-8?B?WVNFeEowTzJUaEVJaU5kM25lS0wzMGZadWtIRlprWHNnb3RLcVVtemVDQ2Ny?=
 =?utf-8?B?NlcwVTd3NWdUNVIvQ1ZzNEtxS0l2SWJ0VU01SW1iRzF4dEkrQkcwMnV6S1BC?=
 =?utf-8?B?aWZVTGc3RG9PdEJmSEgvWmRrRkgrTVdPc3ZwRlR0TUJpczZ3MS9YQ2lGM2FC?=
 =?utf-8?B?SVpsRHZDeDJlVUsvNTlXNUFhd2xOSUQzMmRhVnp4OXk1eGpRZk96RVpBRzlz?=
 =?utf-8?B?OWhEQXlEMmJRWmtZdExjbnkyclorMlBCWHFzTmZYR1pDeVRvUmlxK3h2T3dW?=
 =?utf-8?B?eGUzTTBDaWN0b2sxeUdkRVB3TGs1TzN5a29QSnVZMjQrQk5ra0hQc25uMkJX?=
 =?utf-8?B?U09VSGZGVG1RR1Q5MHJRbkJSMkdNVHpmYmw4VnltTi9MSkZicjdXS3BMZ1U4?=
 =?utf-8?B?Vmd5cWViUzJVM2wvUjdBdFBGKzNmQUdLWXd6RzhKSzBkSXZ4a3dHR0x0V1pE?=
 =?utf-8?B?S216UVB2SHNXUWVXTUtLOGVVNGppai9VdjhpQnl4anBrbWx5TXNmL0RpSFp1?=
 =?utf-8?B?TTRhejdmcU5ubktpelZ2d2pYWllwaDBwSzNPdS9GUDhib0VPVEJyRkduQWlG?=
 =?utf-8?B?MWd5QnZIbnhNcm9EZlo5QWVWRUxYNDVyWlRGbDJBTXJ3VDBnbXBiY21GYWt0?=
 =?utf-8?B?YmpTalFzeUUzMVlWU1MrRnVjTUlMOXRGMVc2Q054czZWUDFyU2VyYUpUSWZy?=
 =?utf-8?B?VjdUWHZBcEtndk5wamlMeW9IanFEOThzY3RTRXVIM3I5d2RFTnJzeEpiNnFU?=
 =?utf-8?B?QXBpU01rbVFVYmsxbnJRamlZK2RCcjAya2k5Qm16SEJDazEyNzZ1cHFaYUx1?=
 =?utf-8?B?anFmVzJCSU5mbUVKQWhiSHJCT3k4ZlUwM1VRc0VaNUJpd3dEalBZbE9rSkR6?=
 =?utf-8?B?Z0VlZ2krdjZIZjV1MmdoenBKeGM3OTVBemFtZEJmYXF4Z1JuUG9vWG9Ock5k?=
 =?utf-8?B?WDFHemU4WnBHVVVXcVZSUURLRytvSXRVK0VzWnFjWkNuMldNK2s5VXpzd2xL?=
 =?utf-8?B?RFNEbHVUcGZmdWFXUDdtaUdnTXNFbVNYQ2Zwb0xZNyttbkQwMEl1QnEyaUZ6?=
 =?utf-8?B?WmZCSXUxU1VTUHpDYkNqWFpiNTU0L0JpNWZ3K1JGalZQY0JnbXpCNy9XVFBH?=
 =?utf-8?B?UVlPbmgxUlhEVUZocmh0OWxFY2NTNjJCVHR1UHRXd1BNYzZkQ21EZjFaUEZu?=
 =?utf-8?B?M2RFaVhCMHZVaU1mcTN3MzZXakVMMGF3UWZ3NzIyanJPODVIOFNTNGlSR2NQ?=
 =?utf-8?B?aEZRVU5UbUFONWd4eFkyUHJPbU5TZjNVcGkzNlFEVk1STVZXajMrUjZmWHRZ?=
 =?utf-8?B?OURUWEV0L1FOclZvSzI3czIwLzVXdUVQNFc2WWlDSGNSaUtHRWs4a1Zsenh5?=
 =?utf-8?B?NjNNVjd6bm9URXpiN0JsRlM1UDUxaERLWUt2MjdjZ1QyMFBzUGtCYmRKRlVK?=
 =?utf-8?B?WERSUU1pWkNLUmRZOGNCUVV2RERtMUV6OWlZdzM3bXRsQUE0WjBPZ3N6Z0pl?=
 =?utf-8?B?U2grY1JhbGRtcVl4S0ZuSmtCZSsvRlVRT2swM0FybVYxbTl0dEFCOFBwRFJF?=
 =?utf-8?B?Z1lpTDJiVlhtZDA5VnYrZWxLVzdPYU85SStMTnd4UWp2b0tidUlremZoRTdi?=
 =?utf-8?B?WU9ZeEhvbzRBaE55eGowbjIwREduYm5DaTFaaUtiOFRaSkNOV3pHQnp6TkFx?=
 =?utf-8?B?MkNITUhGNUN5V0ZiYno2Y0poTWpuSHhDQWNJMk1ObklodXJHZE9iMk16ZkFE?=
 =?utf-8?B?OW1obTU2d1VSd3lCQVp4dG1lODVJaXJ6RkJwNXJCbk1QWUhTaFErTnFydzNJ?=
 =?utf-8?B?UGRIMTA3N0diK2cvaEtaQmt3d0ZjUTVJdGhaYW1NT05nWU1LUlhGSlZFNzhN?=
 =?utf-8?B?WG5sSElYaDFIb29PNFZ6S3gwTEtQV0lSMk9Tcno5UzFtZm1mMStqM2NvUFdW?=
 =?utf-8?Q?pzlZthDumPzwM91nz94YZlIzA?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 336cfb6f-29f5-4de0-ebc5-08dab5829786
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2022 05:42:52.1124
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aCqewyR7GmqoHm6nm955UKo0bfG1g28LHBg/AoTaERpY8a3/NyceqegFMFnVlbAK9Gfbvxoerr2kaFZdMqWiVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6231
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/22/22 04:14, Peter Zijlstra wrote:
> --- a/include/linux/pgtable.h
> +++ b/include/linux/pgtable.h
> @@ -260,15 +260,12 @@ static inline pte_t ptep_get(pte_t *ptep
>  
>  #ifdef CONFIG_GUP_GET_PTE_LOW_HIGH
>  /*
> - * WARNING: only to be used in the get_user_pages_fast() implementation.
> - *
> - * With get_user_pages_fast(), we walk down the pagetables without taking any
> - * locks.  For this we would like to load the pointers atomically, but sometimes
> - * that is not possible (e.g. without expensive cmpxchg8b on x86_32 PAE).  What
> - * we do have is the guarantee that a PTE will only either go from not present
> - * to present, or present to not present or both -- it will not switch to a
> - * completely different present page without a TLB flush in between; something
> - * that we are blocking by holding interrupts off.
> + * For walking the pagetables without holding any locks.  Some architectures
> + * (eg x86-32 PAE) cannot load the entries atomically without using expensive
> + * instructions.  We are guaranteed that a PTE will only either go from not
> + * present to present, or present to not present -- it will not switch to a
> + * completely different present page without a TLB flush inbetween; which we
> + * are blocking by holding interrupts off.


This is getting interesting. My latest understanding of this story is
that both the "before" and "after" versions of that comment are
incorrect! Because, as Jann Horn noticed recently [1], there might not
be any IPIs involved in a TLB flush, if x86 is running under a
hypervisor, and that breaks the chain of reasoning here.


[1] https://lore.kernel.org/all/CAG48ez3h-mnp9ZFC10v+-BW_8NQvxbwBsMYJFP8JX31o0B17Pg@mail.gmail.com/


thanks,
-- 
John Hubbard
NVIDIA

