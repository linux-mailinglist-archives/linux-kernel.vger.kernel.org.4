Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 296355DD30A
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 20:12:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231143AbiIUSMI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 14:12:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231150AbiIUSL6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 14:11:58 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2043.outbound.protection.outlook.com [40.107.100.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15225A347A
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 11:11:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HCfYWtjCQGLOEW9YaDbA98azEw15M9Sexyva2WazyUT6sQIa3tcfyP1rDeZRWzsHvNVKS7NBhZM/1vBjQo1v/yB23fwt6pALU628JOG3P/v+oAG/d5MIYk6u4Ttg4xp3lEZs2arUg1DFzMxM2DmpYQ8Zx4wkVANd5lLcKkA0qdZUoWDSgsbJu+gOjOLrUnl9CmHm7L+p+UYfpvDAHrHrzXyrLda65VNbjMiVv26B7T8gQUPeSdekLVHUv90479JU8tNA9EO9JvEwqHKCEnl8snZp8+OzgQg/pwK2UIW0xKl+BRH0hLstY8AO9y06Ij0UmAvu28rWfuQGUylh6SKWOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h0dDmc/pxwLq/3xwXOFsEPRTZSudHD88fwWfl+qBdqU=;
 b=KdQJtVJJmHf2dulQp9xirtCjFk/PPv9idxqzCnX8bZ2JLEr3YgivTGQQjB9bY4UQb5X4lpdfHA3U36wgJW3vX4Cos8AbuxO3Df6tsxuB9sHUlT3BLyjlw//kuPkwPQbLv+NBvY+5dz8k9vGMxJvdB8Boyu8xnkgf9t+VKi8XMyRrPNlcCRyYa8PP4VRlL57ApfTUqCF1kojJ8Q2g9fJi7ZaQ/TA1aeZ/RRoS0gtKsC07gH9Nqc/Y+Z4VhvH9I5Iemw3+vhDoJFyHS4QFcTZWfOL+nNrhIE6bt0jRaBQNdOK88F0Ho+aqZqVWglCoAf2zBqNAWUrM7glUSOUCAzKmjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h0dDmc/pxwLq/3xwXOFsEPRTZSudHD88fwWfl+qBdqU=;
 b=ZsNUB3hB/0gMbRcSnkgN3jqNCkNeSpF4BYowHY4pxIIFJavA/HTPJRdNhX4o91+tgNBRDMHsMw0iC8KxkjrOO75hzUPO7N8SwOiwY1dlbcb6qHevoWIaA2C69t4gA4YzeYSUF3HN9haDg5Dm0+vxZBRoX2oIKex9FSltmg3zNOZILAuZZDVpqVFZAxmNAhBZU7vxkuWI1GQk1uK0vrQpPfZV8WNDZlPq5b8vefZ/IEKqvL5FV9sUoOdyJnM6VY77vo2yYJoQwhSPX5V7rX3RUV/ajRrstvwNLqkn82AoIk2Nff23ZBHnlT9MzccN6elSiOYRXFieYy4Ns/ZU/G+dSA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by MN2PR12MB4424.namprd12.prod.outlook.com (2603:10b6:208:26a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.21; Wed, 21 Sep
 2022 18:11:36 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5%7]) with mapi id 15.20.5654.016; Wed, 21 Sep 2022
 18:11:35 +0000
Date:   Wed, 21 Sep 2022 15:11:34 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Ashok Raj <ashok.raj@intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@intel.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Ashok Raj <ashok_raj@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        Kostya Serebryany <kcc@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Taras Madan <tarasmadan@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCHv8 00/11] Linear Address Masking enabling
Message-ID: <YytT1hfRZdb9GYQK@nvidia.com>
References: <YyHvF2K7ELVSTGvB@araj-MOBL2.amr.corp.intel.com>
 <20220914151818.uupzpyd333qnnmlt@box.shutemov.name>
 <YyHz7H0uyqG58b3E@araj-MOBL2.amr.corp.intel.com>
 <20220914154532.mmxfsr7eadgnxt3s@box.shutemov.name>
 <20220914165116.24f82d74@jacob-builder>
 <20220915090135.fpeokbokkdljv7rw@box.shutemov.name>
 <20220915172858.pl62a5w3m5binxrk@box.shutemov.name>
 <562dec4d-a39f-b517-58a3-45f691a2d10a@intel.com>
 <YytFGqv5V4T8lbM8@araj-MOBL2.amr.corp.intel.com>
 <f1aac14e-380c-f76f-84bb-fdff56207d2f@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f1aac14e-380c-f76f-84bb-fdff56207d2f@intel.com>
X-ClientProxiedBy: MN2PR16CA0042.namprd16.prod.outlook.com
 (2603:10b6:208:234::11) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4192:EE_|MN2PR12MB4424:EE_
X-MS-Office365-Filtering-Correlation-Id: f2dcfbad-f027-44b2-13f8-08da9bfcb899
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5fAvxKE00O6IG4HH/XIBpGDvMRpG1ntKG8RqTqgySMZCCg0qzwEeD/PpN2i/Fy7xLLd4y/Z3wpE57NmHQazZpJc3OsC8rH6PSXVB6vhxmsCSdBk1nhz/oOlC2JsmQGhyF8UXWDzdRmcdRvdICQM6BAdxdjwqbzFDOw9Cx7hEAF2QnaqSVh8SET4Fqog3L38VzyAHc61A7/b3N4P0OsP/Ms1H5skMvpTXM5OhGA74Xh1h8NMEpT/iokV1HC1zoU8S/S3ApQtvfvJkDJD4RswYZ28jixMIyY6bZu0uaECeYl+FaviD1UCS+KX13udmLGe4ZgVBSVjBFy9ChUOnXNNfviKTPvKhFZYL7L0vOBcCzjJ0ghPabXMQLPHR9NERAvAEFxtB1R6ZgcH6vxBue4sFNqMRfk6tDVrXnQH2Japr7SlpdsgIgNaHgfYzs7ZixjnxZ0G/gNh8Bo7RxNo5aSbaL6Me2Cgm/oLYaM/5C/BJOifyUHGgEQqLMO6SwUL/Ti4FCfW53RaDapm5QYG8V3VZNwbmfHus7S7/LZOXalgj12sK1rm+OyisMu5p6qKdFLPOTaL0fnOQnP27k8zxIIrmbHYIDM0gxMy/BndiehKIQYhT9tvU5diplJdL8Xsup78qP2MK2tnY1nkJPBmVuPpwc22fOvBt3aDUyHpFa0uFdAoekVecLWE8IJcWy+4/nfDfo/OilaULKT8LgV5t5ZIHQQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(39860400002)(346002)(376002)(136003)(396003)(451199015)(2616005)(54906003)(2906002)(41300700001)(8676002)(4744005)(4326008)(6506007)(83380400001)(6916009)(66556008)(66476007)(316002)(6486002)(66946007)(478600001)(86362001)(186003)(36756003)(5660300002)(8936002)(7416002)(6512007)(38100700002)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QVEXgAevpqT9hspaN3TfyQUbgq0Fu9nNZUdQ05vReOisS1wDtB0CCAbTyGhQ?=
 =?us-ascii?Q?ECT8aESdzo85ju2jrwZ0yocGozw8J9kJXfK8i8QXLZyiU/HjpRrnL450QmED?=
 =?us-ascii?Q?WJKWfzjRZdCHpIo+6POe1Np8f+Jsd+sh0YwfymbPghlkPJBGclRUeLgifVxk?=
 =?us-ascii?Q?74BM3PlZz/ZST4KVwsE51xZlH0BfmLkgdESDhqtaxEl/7JXCFkwAf36ehMFP?=
 =?us-ascii?Q?d3e8l/fdoRzwkEml8kPIktlk18tguaai6CwVAaxW0rOCOxpg9d7tBjDOPMWs?=
 =?us-ascii?Q?GHpZHV4yrq9xPFz4HQpKPs4Ic8lcsz9SrOeeddERai2bOVuoZX4+/ygq4GOL?=
 =?us-ascii?Q?qlQS7bRrwoNEP4qiil6ZJigXhj9aazE2ZEAoLIs6BDTmaBpyrOGnr0QerFeu?=
 =?us-ascii?Q?QatTi9HbAi6gv2f8KXFwY+kBev8LSmuBPiV+eFR/EtUyL2R6FXh4irXHG8zI?=
 =?us-ascii?Q?Txn4I0bMds2dtNQfMQpOJUERrCGEDq5c28vTpCcdTHIPn7Vp/qX5TG7IZ9//?=
 =?us-ascii?Q?n2CxmSa3SMGUQOkQNfvE3xPgy+8C6SoKzFV8Qu/35oP0NgAjTOXGLftxPXc3?=
 =?us-ascii?Q?TPosF/V3Ykydbd3a/CuiFjDhoXH7cfb6w0J4lxaXJ6oLQVEr6Ea/cxHbFvR0?=
 =?us-ascii?Q?SA+yVKDg3t/mJHti4chOTTvt2SX4eJ+pEN4CtAXhM58vB4wmvx13SCnJwFXO?=
 =?us-ascii?Q?D7KmhDouIx5RPjYL+nsS+sptOMm1YyvuKQt4acSBgRrjv6ovk9MxNozsmZzZ?=
 =?us-ascii?Q?ZtDQCXEQamNBJQzrwSBExE5BpE4F7aQsMRmrM4ua3qwygS3X+/aGB6rzNkcy?=
 =?us-ascii?Q?qyK0ZwOU033JJ4mximmSS2n+Niko67HPClgIVmbf0YofmdpM1FPQxP2WYDc1?=
 =?us-ascii?Q?QKkN4tqhnj6Oe2lyHvX9TPEwyfm9yp/0wKQRauWpGksJbSwQGnKRbMXVKeMI?=
 =?us-ascii?Q?ujB78rQI98YqvYuSK6AgU8jz1/kqT5EQ8GFJ0IQBB3anK7eSwu9MoBJEI4j2?=
 =?us-ascii?Q?wsKU29ODffZ467oCIDcbZ22nXyA31bqbsMx7L4mxsrjl4RUiA6wpY0MEymZp?=
 =?us-ascii?Q?XIY9fS86VwYgQRoPr/rwL/vQVCzjGpCGoY1IX4L0zraCXjj344cXzoGEwoKx?=
 =?us-ascii?Q?KBBjzz5YmOsF9ZgGAPEiN9kVFfg59whKo9ismyfD5X2gKAKwxUEZtTUT1Ly6?=
 =?us-ascii?Q?/z3uKvxYL5+biRPEJio5cApuTE9cQ5J4iIib9y6CV98NEoZiqHylFmjfWsJ4?=
 =?us-ascii?Q?rmDRrNzfrRNzwlcDg6BRK0+/xTGDP4V28lXivQssg17ljH2l3i6YtR7dRpHf?=
 =?us-ascii?Q?CAm/c2WKGbpcGLNPouqqo1eDMkFDNbjd+yUs+VPxHah0Na07h4hdLDXBy9h6?=
 =?us-ascii?Q?QkMIfse5oyB04xBN6AfbgZtEZ2E9YLXQUVdKSKl0Z+TbS9PWu3TDEnYhModT?=
 =?us-ascii?Q?SLfI8Lp8cL6KkrywIJXtWKgf2v5wa19+czeMSVlMohl4aXetW+mNTwBuOAux?=
 =?us-ascii?Q?I+Fi1VnydZl9VLWIy7d2Yx7qKOkP324Fz20LrgpCudA6HsN9l1vjPYOjjcld?=
 =?us-ascii?Q?q7YDX1yO3LXwqHShBHRvkhihLGjFTbBpk0eIG48k?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2dcfbad-f027-44b2-13f8-08da9bfcb899
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2022 18:11:35.8700
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yX5OKgCCwb4a18pIadI0HpB56cw+Gc9E3N8iTANNPd5SsFqXVRxFAiadpd0A+L2e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4424
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 21, 2022 at 10:11:46AM -0700, Dave Hansen wrote:

> Are you saying that any device compatibility with an mm is solely
> determined by the IOMMU in play, so the IOMMU code should host the mm
> compatibility checks?

Yes, exactly. Only the HW entity that walks the page tables needs to
understand their parsing rules and in this case that is only the IOMMU
block.

Jason
