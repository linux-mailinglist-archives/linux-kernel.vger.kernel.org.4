Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 026646F622B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 01:42:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbjECXm2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 19:42:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjECXm1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 19:42:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E5F58A6C
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 16:42:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DC31A625CC
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 23:42:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAA7FC433EF;
        Wed,  3 May 2023 23:42:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683157345;
        bh=ygoZYBqc+MgS/E5JfqeI+QYE2ey17vUNkWBN0+w7Ihg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rR60sSxOq1wMexhStoRwCNd6mFnVEtm3r9fdZYObhwYmhrC5HKxAVDYfVWoLFo6yG
         g6RErlInF7G86qSog+Q77xb4bSCb7YMKYV0KXOaLUexiGdINrHv6XPauFTu64ZHoWE
         p/rPENKJkgh4PJ7FNnYlTdPSOzQ56N0Xat0sZMRmrd9ik024nCRV6Ha+AGt45KU/CF
         SzisRbQ5tsaCa29EqTZC3xUasdE0troUtBh0xCJ1wnBth3WNVO353aC3WCbSfejiZi
         pJk5ipXdZpSpJ8Ozfo/X8381WguMYgf7YjgD30CX2NqjJZqwaHEteB/YacZYGFikJW
         DyxBxZQ9XC6YQ==
Date:   Wed, 3 May 2023 17:42:22 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     jiweisun126@126.com
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        axboe@fb.com, hch@lst.de, sagi@grimberg.me, ahuang12@lenovo.com,
        sunjw10@lenovo.com
Subject: Re: [PATCH] nvme: add cond_resched() to nvme_complete_batch()
Message-ID: <ZFLxXjiQUPl+tV8L@kbusch-mbp.dhcp.thefacebook.com>
References: <20230502125412.65633-1-jiweisun126@126.com>
 <ZFKLxfet7qUIwScd@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZFKLxfet7qUIwScd@kbusch-mbp.dhcp.thefacebook.com>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 03, 2023 at 10:28:53AM -0600, Keith Busch wrote:
> On Tue, May 02, 2023 at 08:54:12PM +0800, jiweisun126@126.com wrote:
> > According to the above two logs, we can know the nvme_irq() cost too much
> > time, in the above case, about 4.8 second. And we can also know that the
> > main bottlenecks is in the competition for the spin lock pool->lock.
> 
> I have a fix that makes pool->lock critical section much shorter and constant
> time. It was staged in mm tree for months, but mysteriously it's missing...

Well this is certainly odd: the commit I'm referring to is in Linus' log, but
the file it modified is not updated. What kind of 'git' madness is this??

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a4de12a032fa6d0670aa0bb43a2bf9f812680d0f

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/log/mm/dmapool.c
