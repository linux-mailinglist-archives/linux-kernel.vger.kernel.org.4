Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB5CC603A43
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 09:04:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbiJSHEm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 03:04:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbiJSHEj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 03:04:39 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2071.outbound.protection.outlook.com [40.107.94.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F8F5186E3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 00:04:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ipfQH0pei+kFJqFtQ9HM6yqzqDTQJvhAc4NG69CzAQogE+65oDmiDjtAKFdeYm2UxqhC7L0R6qCNfTZNHkvrs8DQF5K+GxIbo6ZyVxbLDd7LnPPpIUrgA2kQIsxuG71A8b+NSDqv9rPayoZFxIt7GRwJ/0JYvCJjZGbgNBvUugji28xQLSOMBc1ivUA973+SBlalvQ3nZpeBne8AfuORiyha6NH1DSEmUptoEvWVbjz6F0sa4BcKKdNjjl/fot4CVO7lJ4sNXh7mzzuvTrI9WW2sTckta/kdZtabYWu6CxLrRGIQR0/Cp5sDHoJhGGgvXpy6BwLbJXBy6b7rdVOJ3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8gKn4jDfiUx04DPGvs4tisFfztIrC/AeLiSiM58690c=;
 b=g7PA+heITYpmMjjWoyrokpPQ1/tlZBNEEiFXEVHnxPpDBd8wD044fd7G1y8XNh7zoaVhkXvsGIziAeVbtH3OFHdjSK3elqSIFkWM5jzdnMmbimVaEmBh1t1YggZqoIlOBNbYSYpBodofUhvIHNUINyc16FHPq+OMQDosICeJH7olctr5ieswMAsDH0YuqhBRNSE9UMBQ2bAO9SCfjkrgO3xgcLfo2/zLmnpp2CdAleS4acYFTmumCWRHgytbwa0MG4ZZ1OiiPEnMl6zI65MYtOz4C2WTl4CSVduRNYwfzeJXnkS5wLVEHa9ORvo6hxOnVGBT70rTCZoiE77GFgXNww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8gKn4jDfiUx04DPGvs4tisFfztIrC/AeLiSiM58690c=;
 b=XHkighpqCozhqoFae4mBKBQaZW/38XiJZ4NXX49Eiqf82N1OuC4cEIBrNnlLcaSpajUB6ymxoi6x0G9wMWu6tUGVeanLNtDuJeGhF8vn7krkdZLGMZd9QHGkpJxRm906w87Qk7eqFPTid3xbJq59yIoc4USNHRGO2NVwnBAr8Q0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 CY8PR12MB7585.namprd12.prod.outlook.com (2603:10b6:930:98::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5723.34; Wed, 19 Oct 2022 07:04:34 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::580c:51f2:b715:17cf]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::580c:51f2:b715:17cf%5]) with mapi id 15.20.5723.034; Wed, 19 Oct 2022
 07:04:34 +0000
Message-ID: <0a0dfecf-9827-6ee8-0cf7-895b2ebf3e98@amd.com>
Date:   Wed, 19 Oct 2022 12:34:15 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCHv10 10/15] x86/mm, iommu/sva: Make LAM and SVM mutually
 exclusive
Content-Language: en-US
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, Kostya Serebryany <kcc@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Taras Madan <tarasmadan@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Bharata B Rao <bharata@amd.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20221018113358.7833-1-kirill.shutemov@linux.intel.com>
 <20221018113358.7833-11-kirill.shutemov@linux.intel.com>
From:   Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20221018113358.7833-11-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0094.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9b::18) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|CY8PR12MB7585:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f4666ff-778e-42d6-214f-08dab1a02d60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dPXzoF01riSSxXVfmGejEcR99W123Er52rPOuI19PgSsgTtvFPPa+C+Nb7nortlxN9lBRVeaZ0W+PUGpIQ+7yBf14jCeYQrFqxYAZ6pZ8wAQqP0k9osDB74mUsZXkUGkD4Z+1fH+v5qMi2sROUUAX6erH3h3qlcoG/RBWGGsibe84dBJE768BuM5v2MfPdPYlMK2bumI+A2PpTSvOsPH+udLB0Nb3KfqILg78R+jCdS3c3lxUF9CH0WMgFv/yWijGUQXQqswQ1/XiSYnU56BN3TZtNp3nWAmhKIRDDk7go6E4SGF9emhs4xVO6XLoA6FZnlci4Vcwvny0gOfLDyy2Fp71rrAYv98RXL2QdZGQCzkR2Z6/t6QUyAf7w/3Z/DO7PM/Gxx7GRl+xUdbOxVfVKpuMRi2KqlRIfJy/1zeVMGMsNvBZsjFQ8vPrK2mRTUtu8ZLEDOMH8QzD00K5AGVHPoA0lbMP0vEEp0TZgu0iKHWmWFHRAMof/g+CJkF1svw0mx8dcTRuDEXAyxDE7CSEsavbYu/5DTcTPuS7LYW09i97sjq2UfrLH+B34F+qdqJ9te53BRfofzlse3dA90nw6tXcOBaVvvzx248QiMVLtOijiNL9ZLdDCJbfFDGanHovPdLi2+JdSoFMdZO+/NMNqZvDXb831nVGYdxnts8DR8hoXYgiexFBAVrm0IV16Iz95HwDpmcL1LD9CvPrWiWbt9PX3dOrYYjHTz2PPtocQQyuH3BFpjauiKoSVoG7NxM+d3fO9C9RwcHCFr4CEXueEjVwRkoYTTCRYHGKf++Py0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(136003)(396003)(39860400002)(366004)(451199015)(6666004)(6486002)(478600001)(2906002)(5660300002)(4744005)(44832011)(7416002)(86362001)(31696002)(36756003)(54906003)(66946007)(66476007)(66556008)(41300700001)(110136005)(316002)(8936002)(8676002)(4326008)(83380400001)(38100700002)(31686004)(26005)(6506007)(6512007)(53546011)(2616005)(186003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RjdOOWo1bERVU3pxTEFmV2h3STRnTFdhVFdpYk9kT2F5eDhTU3hGbXU3ZTFp?=
 =?utf-8?B?eHVkNHJCRTAzeDJ2KzVpaG45cWJmU1FmdzYrMjhZakhtMHB2dmI3RS9Ob1dR?=
 =?utf-8?B?T2R3b2Vtb0VpZmhiV1hsbzVaUHBNRVBtVUtZMnhxMUxYZ2pvVmg2dlhMdWNQ?=
 =?utf-8?B?azEwcUhjU1FyNldHNlZXeU9MUkQvSW5YVDh0c1Q3NFJSNGpMdkpDOCsxNzh6?=
 =?utf-8?B?ZXEwMDVCelNLS3U1OVIxeUhnRFVhVy9TT0J4WldRSHBNOFprS1VoZE0wSno4?=
 =?utf-8?B?ZE0wK2U4Yy82elFlQzBjcTJMUjAyZmgvdUZlV0M2UDZuSmRlVkxXRjltbWM3?=
 =?utf-8?B?YlQ3SVA0WXRNdHdTdVJTc25CcU4wYzNaR0RDcklkV3FTNmxWVFhMVXdRVzA1?=
 =?utf-8?B?NGp3S0I1c1Myb1czSkFRTkJwakFDKzhCek5FN3hXS0VSNzMwc3BqVjVBNDQy?=
 =?utf-8?B?ZlJNOTNsclVxeFdISVBlZW1HU3k1N2pTb1I3cFdzdDFzMXQ5RGFkRHVCWnFZ?=
 =?utf-8?B?dUNTdTF6aWRWZG1IY3pEMjdibTJ2RHNYWS9WSDNUb01Zc0c0dzZ2Sk93dEVx?=
 =?utf-8?B?ejhtSjFMMGZOUitjeWlieVlZWldGRkwxWmU1VWJ3RTVXcXRpQ2hiTnlydk1m?=
 =?utf-8?B?WG9pM2VpYUQ3TVZna3I2bkZhYzNKQ3d4V0JBNlkxM2x5bzBtWkg4RkhEaGpX?=
 =?utf-8?B?clVEaGhTcU03dnAzdFhyOTBTRXVYVDNPcmNWV05YbEhDVHUxTGtIMlh1L1p6?=
 =?utf-8?B?M3ByeTdjOE8rQ3Z0T25yS3BXTTJFSk1WL3liUGRhdU1rdEg5aW9QMWM3bldC?=
 =?utf-8?B?NHdsQkZPcmw1L3NDcWxNMGttbDhEWThXaE9QN1lXN09OYkdUN1NVWGhtQXVo?=
 =?utf-8?B?WTBZUStnSnVwbE9mZ25TQjY1bW9tY0U3Rm1POENEMGVYUDlBZm1MdDVRSit5?=
 =?utf-8?B?YURNbzJLR1ZHWjRGanlYNkltaEdjNzJwMXZocXQwZ0ludW13czJjZXBPSEtX?=
 =?utf-8?B?TWhPLys2N1VZWk5HUktYVC9oZVh0Ny9zbmYvNjZ6Zk1Ra29kRHI2d0hQS0hJ?=
 =?utf-8?B?cjNLWGlLOXRocU4rdmRFVCtGSTRESjZoYXJFK0VQYyttRmtEY1hpOEd0aTBy?=
 =?utf-8?B?aUZ1OFcySzhTZm5tclBSTGtidzFyMDJ3SWwweFpMdkJzV0xJRG9MdnowVXFi?=
 =?utf-8?B?SFhUbjJNWTN5emc1T0hCV1V6VkRDTTR2MC9lSVZyN1I4cGcrNzF4VmQ5Sktk?=
 =?utf-8?B?dmY3bThiOG56Vnh3NTZFZE9tbTcyU3BXZTlPbnJ3S0FmR085aFk3NUlrMmxs?=
 =?utf-8?B?ZFcyRGs3eXk2N0FCWjFLV3BWQnZCOUVBMkJRYXRWclNhSFk1elVpVjlEaUhu?=
 =?utf-8?B?OUFGRTZVdHRpZndiMXk0SHdUbmxQTkJnY0IvdnlDenhzWXMxTzdOVWRCeHVE?=
 =?utf-8?B?cFRBbUJCekNFVWhzamtPd2syZ1JOaHdxOG95NDZCZVFDeWg5Wk05NnhXRUQ0?=
 =?utf-8?B?MVBmYVFKdkFYMVRvK2tySHZzUEFXOFdlTzU3WS9tRnl1TW1hcVU4bHY4bVVG?=
 =?utf-8?B?OWMwMnZRMjY4eWNhWDRLbnhWMnhLa1lVRFo2dytxcEJFOXc4c1ZPT1BvWm9C?=
 =?utf-8?B?RmtaRXF3c2tBQlJTY2VYR2FrSWJ0MjdXT0dINHJ1M3BzNjBxM3ZXdjNTck9V?=
 =?utf-8?B?OW9JOFBlOFl5NHoyUEhEZkE5SmRzMUxCQmRjNktpaFZJRkpjeXA0Q2JhNWkz?=
 =?utf-8?B?WWh1eXJGbDh1cmlNWExsZnhMUzdVdTcrTFVNZjkvRnVnZUFzdXJSa0h1eHFF?=
 =?utf-8?B?Z1FzU3MvOS9scHc1TklCNDB0cWdpWG9ZTjdZSWRBTWZWOEhWZngwVlpXZlU4?=
 =?utf-8?B?VzJualQzWHo2cDFmSFk2ZmFjaERydkxuVTE3QXVCejRSY0tmT01iYzBkMTdJ?=
 =?utf-8?B?VTBISzRTeTg0RGgvd1VVUDN6TjhlWnpnWHJXeWVlenBBNFI3alNVTnNoOHgr?=
 =?utf-8?B?ZVM5SmZNMHFkay9DWnlLU2g4UFhHQU1sSVVQZ21KOWE0aUpiUWE2WEg1TVBy?=
 =?utf-8?B?Nm12eCs3UUVxUjh3VTRkZk5DMElxUGx0WFcvVVBhSURkWmdRRlFDRWR4K1Av?=
 =?utf-8?Q?SZ8X1zPf666NtKl7hGrogW5uv?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f4666ff-778e-42d6-214f-08dab1a02d60
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2022 07:04:34.4254
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 97q+FSioTtABp2fxy5wYSqzsrLQM+Dh2qnDVibmqIKacodFg4oeXvkEboMtbZYCJE82ZSPY+Em4Ojg5QX26klA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7585
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kirill,

On 10/18/2022 5:03 PM, Kirill A. Shutemov wrote:
> IOMMU and SVM-capable devices know nothing about LAM and only expect
> canonical addresses. Attempt to pass down tagged pointer will lead to
> address translation failure.
> 
> By default do not allow to enable both LAM and use SVM in the same
> process.
> 
> The new ARCH_FORCE_TAGGED_SVM arch_prctl() overrides the limitation.

Better s/SVM/SVA/ ? So that its consistent with IOMMU usage.

-Vasant
