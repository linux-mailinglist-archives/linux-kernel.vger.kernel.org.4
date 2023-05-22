Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9101570C1A4
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 16:59:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233199AbjEVO7D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 10:59:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231321AbjEVO7A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 10:59:00 -0400
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 50853185
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 07:58:36 -0700 (PDT)
Received: from 8bytes.org (p200300c2773e310086ad4f9d2505dd0d.dip0.t-ipconnect.de [IPv6:2003:c2:773e:3100:86ad:4f9d:2505:dd0d])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.8bytes.org (Postfix) with ESMTPSA id B14892476DC;
        Mon, 22 May 2023 16:58:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
        s=default; t=1684767514;
        bh=lZHPcZFttC8PwMH3huLv0AsmR9poQhlnJzue5QlLdFM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ye1AkBufdcMtnsCFVaACxTZkR8vc5S5B2YWnJIKjPUsnHtsa4j0AwqbkLEWQ8WVPS
         GZZBIpH7EFJe9trjXQEBF27HhCsipnxq0Xr6Y4Nvk1gVWp4xB+uDsEWQVoit2SzXJI
         0a8a0CAOkRIIUc0INZpmtb2ncvDUYLRvFYrYTGITMfo3mpCmInJM/Dz2p+ZEoE2xDI
         QCm36mNah4TwpMlWgYrgtWeRuy2VL2Z4YMV3yLz4ZPBfsZleS4IRlBFtJ9MEH42Thv
         FOpCCgfviHrhbFG8EUunsXJLBWhxwKZlGMUaxXRU0lJBle6UDFfnODTEEblN5sKMIc
         1wlKFcZyxwuLg==
Date:   Mon, 22 May 2023 16:58:33 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Vasant Hegde <vasant.hegde@amd.com>
Cc:     Jerry Snitselaar <jsnitsel@redhat.com>,
        Peng Zhang <zhangpeng.00@bytedance.com>,
        Robin Murphy <robin.murphy@arm.com>, will@kernel.org,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        Li Bin <huawei.libin@huawei.com>,
        Xie XiuQi <xiexiuqi@huawei.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: Re: [PATCH] iommu: Avoid softlockup and rcu stall in
 fq_flush_timeout().
Message-ID: <ZGuDGftmxsF35C9P@8bytes.org>
References: <20230216071148.2060-1-zhangpeng.00@bytedance.com>
 <edvxk47ok5dhlif5mhntrazzg57vxpcwqncjtr4n3ts2zvp6ib@o6qvqfmvxmlt>
 <7bede423-690c-4f6a-9c23-def4ad08344e@amd.com>
 <21f69b43-a1e7-6c84-a360-dae410bedb3f@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <21f69b43-a1e7-6c84-a360-dae410bedb3f@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Apr 28, 2023 at 11:14:54AM +0530, Vasant Hegde wrote:
> Ping. Any suggestion on below proposal (schedule work on each CPU to free iova)?

Optimizing the flush-timeout path seems to be working on the symptoms
rather than the cause. The main question to look into first is why are
so many CPUs competing for the IOVA allocator lock.

That is a situation which the flush-queue code is there to avoid,
obviously it does not scale to the workloads tested here. Any chance to
check why?

My guess is that the allocations are too big and not covered by the
allocation sizes supported by the flush-queue code. But maybe this is
something that can be fixed. Or the flush-queue code could even be
changed to auto-adapt to allocation patterns of the device driver?

Regards,

	Joerg
