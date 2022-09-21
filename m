Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 374855BF1A0
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 02:02:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230525AbiIUABf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 20:01:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230469AbiIUAB3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 20:01:29 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 214953F30F
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 17:01:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Seb+jA7/kiwj4343NypHpQXpqJEBLyP5GUYO7t0a+VAP09Peb/oFPZtM9W9M8z01TN6o23YopXK3BIciha8+TQ06s0L9j2j2ibaS/7Fhxcdx6Br/wceRiJVdGCn+q9RWzV8EqdqsY7/Bk8n4L+U6ZGmQLN2vOPPykrC1WibjylaPys7YJ+bBDSpdRIDEoclsVlmBYIxouDB1rePAkwXcU+Of85sHdMVh4gUECecKFNPhvDOq94L5QvzUbtloQWMHlXT6KN04w/ZuuEk4Gqd4O8rTqPkNIHjOeVu11axlf8iCs0UnaTAs9wssGpxnUt3k1d29vmYjP04JLleca66m+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XgHOn6ZetKr9/xD/si8qg141dTq9rXn4xdQkhJokqCM=;
 b=cwyLrD+v/fyWxS4W+tOKs85HfBTybM0jtQpHcY5VGfwoM6T/ylcnhU16RJwQ7RpyCFOWaf54hLIJ7v+3QkrMJ60W0PSZNKbolNDQ5Rm/II6RW1sjX9gQ+76epY88bwP9w1TGDxViaMVsHBV7kjZhTNzYNq60qdA0lzLsThclYzrJgebkPijTqLRSr+/2ERL0hP17By8XR+FEZtLcQTjSNv/tWL8ayw+TFCSfrhrd3S1w02x2YrHkWqYrKDMKDUrZCxrzgtq8Ga7oEmdeY1DR1Itn+c6LduwIb0dw27YTkKMjyW6IQdULvho4m7GA/oRO3qWrBLSrnjaV8GB/p1RsNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XgHOn6ZetKr9/xD/si8qg141dTq9rXn4xdQkhJokqCM=;
 b=MCIu2BkwpvvYOJjp42hLOlVOXIVaqJRgmazKkNXWEpenbjs5WuEh+BiHuX/VInLM/pc51PjEgb6CCr2Yljrw1P4BQvuQavHnPbcsIUzmcUvOHHxcGzronKNjUmNP3KAIhIEHqjuCcJXH5koKcYgyqHdQWo+yKZorvLIDvMw9y+jZzw1YARMEE8BbOvha9LYmMRoTtLaEuFUFBycxQQJvn/f0e+B5nuUx714TUEd4V8PMBI6ItPjHfXRYVaoh9gICmKMsx4YLz/7XYlFmFYSFXyQzq9WszBWddtmfgZ0rKPed8fchvUT94g2RlB6Sox9C2EQooEvejbWNrol32sRRHQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB4181.namprd12.prod.outlook.com (2603:10b6:610:a8::16)
 by DM4PR12MB6663.namprd12.prod.outlook.com (2603:10b6:8:bb::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5632.21; Wed, 21 Sep 2022 00:01:26 +0000
Received: from CH2PR12MB4181.namprd12.prod.outlook.com
 ([fe80::3d9f:c18a:7310:ae46]) by CH2PR12MB4181.namprd12.prod.outlook.com
 ([fe80::3d9f:c18a:7310:ae46%8]) with mapi id 15.20.5632.021; Wed, 21 Sep 2022
 00:01:26 +0000
Date:   Tue, 20 Sep 2022 21:01:25 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
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
Message-ID: <YypUVe2YGcM+xkog@nvidia.com>
References: <20220914154532.mmxfsr7eadgnxt3s@box.shutemov.name>
 <20220914165116.24f82d74@jacob-builder>
 <20220915090135.fpeokbokkdljv7rw@box.shutemov.name>
 <20220915172858.pl62a5w3m5binxrk@box.shutemov.name>
 <Yym8zsuXbYaW3alU@nvidia.com>
 <15741fdf-68b6-bd32-b0c2-63fde3bb0db2@intel.com>
 <Yynp77km4SaHpe/3@nvidia.com>
 <20220920113742.277ac497@jacob-builder>
 <YyoLedkOx59KUjSw@nvidia.com>
 <20220920134430.20111b7f@jacob-builder>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220920134430.20111b7f@jacob-builder>
X-ClientProxiedBy: BL1P223CA0023.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:2c4::28) To CH2PR12MB4181.namprd12.prod.outlook.com
 (2603:10b6:610:a8::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB4181:EE_|DM4PR12MB6663:EE_
X-MS-Office365-Filtering-Correlation-Id: c08685fd-a4af-4831-7cb0-08da9b646d73
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ndy0NMMfiSP5klj/07z79giyAP36DzX2x7wBMQVVmT3FOC46e/no6Rh7VFvw3z0xmuWRBeXw7X3A3UchdnU7qGVV2q/Lw/1aYXebaA/uy78cp10VsAucR0Nmu+gbTPkwmm3ePjvVAwo1bqjzFyDussjS7ikXVaHcsc0A3bqb5Zi1+4Jla6SwfgkRBFJse0/JtroLtGKXEILtSu+79Q6TWJjdGw7vEgIybo9gUDwvEP7aXCd60gIJUFBfX0JXbqKqNnA5FtEST3LKId1kZL8a/GcVXMjiYhi9vuGzQqTMzJVmuFV0wrzsO2KjkYxj9gIgR16+s8uFao54RbOwPoFfDbuyioMjBHtzgxBL9QxX2NuEdu4SI3fR++4QMmDarONM0adT040MEG3TSNImcGTWG1ZRebqm0fBhyMBKq/JNrQphdTvxiCSqhyisv09O9bc00puLBTbWuEzCaE4rRE6YpWnZkojp4zGDztzTfmXKOZO/jRfkPQoIfQYSBxrgkumydV0ixLVFITWa7ZTT47jzrmGKEuxdlIWdW9TbqF6XQOg5vuZv6JVEHZhLvLhEnCM0LkjXx8QCgWfozVknm4xBEWoAGoVKATtQGaJhhLF9/o2YvhHbsub5A5gJW7j7Q6P7vpExsKYxh3PbqsVZ+4fpaGupZXnfm7fzEs4G6cUmb693a1BaH9kbPm+OIBrCg0hdpSY6G9wzvQhRAYg3bgQjqcfVOr0oYVCouegLmkaDbV+ZBBEfIdebYceRs5JKeOb4
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB4181.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(39860400002)(136003)(396003)(346002)(366004)(451199015)(7416002)(66476007)(8676002)(66946007)(5660300002)(6916009)(54906003)(86362001)(66556008)(316002)(4326008)(38100700002)(8936002)(41300700001)(6506007)(6486002)(478600001)(2616005)(186003)(6512007)(26005)(2906002)(36756003)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zXrYt8sZn94e0yp+rGz73HA3BH0FIAynj3a+s+2/yuQrPeDZjtnJWF2pswaT?=
 =?us-ascii?Q?AmV51kA6/9AC5BYUkfP3K0n78GgxR+GNk4plaGe6Ic/oo+udE0NYwD923Pos?=
 =?us-ascii?Q?e7nNLjAI12WH8NqxtDekjXQyEqhTD3ZWu/35qo1OFixQjIi9A3I+94tsW60K?=
 =?us-ascii?Q?Y7VCiE+Ti5+wqlHMhWTCGCOkKMg0RxuI2uElY2TkC91DAGFLnW82WywEEV12?=
 =?us-ascii?Q?CFGQNt+Wv7YEdFYsGqWHAQUwOb/8yTsunNY/WDy59ua0DS7gnPWvrXGvoq3q?=
 =?us-ascii?Q?5N0Fghp73/f9ZI3XXd9vFdM8Pod174XU9TNNA6YxqWW+L5IGYqabJpUOFRZf?=
 =?us-ascii?Q?ARyI4kjOeWbnDJ0LORgBR4gWiPKLkPzEZYUm8TcycNEi1Ds6wscsDkwN6ail?=
 =?us-ascii?Q?kS4H3ByrQljXRZ9sVKvLMpaAeejZKEk5NMdvlQh5YwtogDRJ/b1U78xOxYSz?=
 =?us-ascii?Q?I9Al8ohdk9ASMvNuKoutff4sRLUFc7O4BGcycAyJi+D1/7sWItbs6rn3VDuX?=
 =?us-ascii?Q?/fE7EqWMm2c74nkf3tlnfZTBiEQ6qRa2TBfNSGz2U9TWAfSgNF8wmaGFbPjj?=
 =?us-ascii?Q?sdQnNhTO8TuVTiINJVRJK8UWUQAGLIg+Uspi9zVg4u/yubwTmMbVmmvV55zw?=
 =?us-ascii?Q?OG3RB4X2TZGaRRLZZbDrFNNFYOm65FRVQA5t/pU2dOEcV0mAKjcIGVyU6Y72?=
 =?us-ascii?Q?rR/bnZqb6riwlVTDxXY4KdsDTSRPEdwSb95kG7fo3Z+9amtfd68W6DSg6wgS?=
 =?us-ascii?Q?QNKs4hbkeb33y4aoiJ2vRS5+6vQvOSmgCieNGTFiks5Y1Kexyb76AE5zWb7b?=
 =?us-ascii?Q?K+cUu0PXyEZC/p2Vs6TXUSzepYn53e8xt/UDmt9KWxO/lXubjCeGCmBROi3Y?=
 =?us-ascii?Q?eONc7mUoY08/xhZ9kh594nKI2fJZ5kq7QU2ufC0wmX0qQJfvWHjM8gfuaLCv?=
 =?us-ascii?Q?UabumUlzIqZDWl1zHg+HlyoAlBE6vIhKVZ6Aaiam9q5TqkxJI7YnTvICMUjO?=
 =?us-ascii?Q?Y8takyYTyifoAmvZbyxDXGleQJzmM0tzWvLkqamwJArF6hyaHj7v+b3tcexE?=
 =?us-ascii?Q?wOphsHTk9b7jRRx9ElYZTImH7Nx2jMcwmsCe1UQVMM4zok43/yKJRjUBXU3F?=
 =?us-ascii?Q?UGonpiYdt5I+6f6PeaEeKrnXcRxqOELH9Ldu3DFoQ+K+GBVlTr4pwlOebUTD?=
 =?us-ascii?Q?qGyf9jcMTf/j4MobZcNa0WveDaPDwTKxeJ4p1AihlzmvhddmJ8Pc5MXuKAXN?=
 =?us-ascii?Q?hLm9SACtrB/3Rgnkv58mnh41x0y0aOqlE1RGbQ9hYtAcIhJXX1GwV0XzUY/d?=
 =?us-ascii?Q?OInYEuZEUkFfA3ea+8hUMDcsQ7JYwkO4Srn+eyv/A5agjxFrg/s52YGsK825?=
 =?us-ascii?Q?9mTPGVLGH6UYtkMVXbN102qnUvfEhKKn3h/73m1Dxg/JsJmFpnbQHl5Wn/3k?=
 =?us-ascii?Q?KuNwCf7Ngtum/msORHUAHsC9nUlVf/m6EefmnVPFq/8yGmmvaajiAZ2hPTZZ?=
 =?us-ascii?Q?4T36dC8FpWJ6svEHuauWCeKX+qOyyX4K775k4LjlZlZtqvnRnLG+bTOgED6/?=
 =?us-ascii?Q?Y9UaZxU7s8L7BQrOP1s1kbhvzLFGAHQcuNWXWJme?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c08685fd-a4af-4831-7cb0-08da9b646d73
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4181.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2022 00:01:26.4322
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hM5iDDITnMd2bHCikSBSOUHE6u63Z7iaNgTKHGv+4z44ZN78aMnTHH+Ljm1h3dMZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6663
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 20, 2022 at 01:44:30PM -0700, Jacob Pan wrote:

> > In general I'm not so keen on arch unique code for general ideas like
> > this (ARM probably has the same issue), but sure it could work.
> > 
> Creating an abstraction seems to belong to a separate endeavor when we
> have more than one user. For now, are you ok with  the current approach?

Sure, just don't give it a silly name like pasid or sva

> > You need to assert that the page table format is one of the
> > formats that the iommu understands and configure the iommu to match
> > it. It is a very simple question about what ruleset and memory layout
> > govern the page table memory used by the CPU.

> the problem is more relevant to  things like  canonical address
> requirement  than  page table format.

The translation of an VA to a PA is entirely within the realm of the
page table format, IMHO. If the rules change then the format clearly
differs, even if your arch documents talk about "canonical address" or
something to define the different parsing behaviors.

Jason
