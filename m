Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6843B73E190
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 16:07:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbjFZOHf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 10:07:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjFZOHd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 10:07:33 -0400
Received: from bee.tesarici.cz (bee.tesarici.cz [IPv6:2a03:3b40:fe:2d4::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F6AB193
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 07:07:32 -0700 (PDT)
Received: from meshulam.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-4427-cc85-6706-c595.ipv6.o2.cz [IPv6:2a00:1028:83b8:1e7a:4427:cc85:6706:c595])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by bee.tesarici.cz (Postfix) with ESMTPSA id 66F688B11E;
        Mon, 26 Jun 2023 16:07:27 +0200 (CEST)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=none dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tesarici.cz; s=mail;
        t=1687788447; bh=FILL/HLjSg/GDNwutDPaxm/toIQ/PWb8bUfurR9PFH4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=QJMzGwTgMOXIVQ7F16kYj0bofTEB1DLXPNaCa2ivRDPDS4KWwWKLImRWQ0vJaxAIw
         D/Ve629p9/aQwiMR+o/UBv7iEYYxiLpXTD75PDGfouuxVKOsxH/5GWZgM/5oFOC7vk
         D8lj/F9p5uGZ7roqOaKP9dcOUTLapDOAgLJEv2PH8jNchQiISCb9R9GRuH1C7cTRzX
         zc0y39OrYAzQMbI/u4ULm3aL4eWhh/pV2wliXafcCVfYK7amxkSnyYpcRL4RWtwwks
         SK4CWdLnGwQQvbWmmPGsL1bfZ3nM4+47MuzcRA5URxL+JXFs1Ka3EcjGkMth2G1tst
         c3fjez+Ol+Avw==
Date:   Mon, 26 Jun 2023 16:07:25 +0200
From:   Petr =?UTF-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
To:     Petr Tesarik <petrtesarik@huaweicloud.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux.dev (open list:DMA MAPPING HELPERS),
        linux-kernel@vger.kernel.org (open list),
        Roberto Sassu <roberto.sassu@huaweicloud.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: Re: [PATCH v1 0/2] swiotlb: Fix a couple of bugs in sizing areas
Message-ID: <20230626160725.5164ca74@meshulam.tesarici.cz>
In-Reply-To: <cover.1687784289.git.petr.tesarik.ext@huawei.com>
References: <cover.1687784289.git.petr.tesarik.ext@huawei.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Jun 2023 15:01:02 +0200
Petr Tesarik <petrtesarik@huaweicloud.com> wrote:

> From: Petr Tesarik <petr.tesarik.ext@huawei.com>
> 
> While reworking the dynamic SWIOTLB implementation, I ran into some
> locking issues with the current implementation. I believe the bugs
> are serious enough to be fixed separately.

As an aside (and not directly related to the bugfixes themselves), I
wonder why the area size cannot be always equal to IO_TLB_SEGSIZE. Of
course, we would (usually) end up with more areas, but that should be
a good thing, shouldn't it? The area structure is quite small, so it
cannot be because of memory consumption concerns. The overhead of
taking an uncontended spinlock should also be negligible.

Do I miss something important here?

Petr T
