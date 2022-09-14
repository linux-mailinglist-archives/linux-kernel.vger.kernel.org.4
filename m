Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78E3F5B8704
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 13:08:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbiINLI0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 07:08:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiINLIY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 07:08:24 -0400
Received: from out1.migadu.com (out1.migadu.com [IPv6:2001:41d0:2:863f::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09F465D104
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 04:08:19 -0700 (PDT)
Date:   Wed, 14 Sep 2022 12:08:15 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1663153697;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4icdTTwMOEDl/FiFqEWnD1meNX7EE2LU8zEMLkINvBI=;
        b=W6EdHTzE6hL8xf2xCXTgPfAWhGW726ekqZCMjg7k35lyEBz7Tt3ZmzHp0iwg7+fHlaXFD6
        dahkLcn8Jn4N+5PEv8i7exrmNXbsNqkC/YGp9Dh5q1LGzRfEanP4LFGy9xYjWbimwNLn43
        LcJIWApPaRoNmrdDX3GsRJLYLkQNYHs=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Oliver Upton <oliver.upton@linux.dev>
To:     Zenghui Yu <yuzenghui@huawei.com>
Cc:     kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, maz@kernel.org, james.morse@arm.com,
        alexandru.elisei@arm.com, suzuki.poulose@arm.com,
        catalin.marinas@arm.com, will@kernel.org,
        wanghaibin.wang@huawei.com, pbonzini@redhat.com
Subject: Re: [PATCH] KVM: arm64: Use kmemleak_free_part_phys() to unregister
 hyp_mem_base
Message-ID: <YyG2H8PbJjehAwch@google.com>
References: <20220908130659.2021-1-yuzenghui@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220908130659.2021-1-yuzenghui@huawei.com>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 08, 2022 at 09:06:59PM +0800, Zenghui Yu wrote:
> With commit 0c24e061196c ("mm: kmemleak: add rbtree and store physical
> address for objects allocated with PA"), kmemleak started to put the
> objects allocated with physical address onto object_phys_tree_root tree.
> The kmemleak_free_part() therefore no longer worked as expected on
> physically allocated objects (hyp_mem_base in this case) as it attempted to
> search and remove things in object_tree_root tree.
> 
> Fix it by using kmemleak_free_part_phys() to unregister hyp_mem_base. This
> fixes an immediate crash when booting a KVM host in protected mode with
> kmemleak enabled.
> 
> Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>

Reviewed-by: Oliver Upton <oliver.upton@linux.dev>

Marc or Paolo, do one of you want to pick this patch up? Looks like a
good fix.

--
Thanks,
Oliver
