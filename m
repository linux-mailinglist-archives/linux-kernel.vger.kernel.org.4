Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B92AD73FDE4
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 16:34:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231246AbjF0OeX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 10:34:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbjF0OeU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 10:34:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40DF210FC
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 07:34:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C8FAA6116D
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 14:34:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 666C8C433C0;
        Tue, 27 Jun 2023 14:34:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687876458;
        bh=qBKYhMeBJz+rIl9E1m/ziiZUzXijsRdV8U0bSFmCAAI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MKYywGfEVa9DRexeIPqNaUjeRBPlf7lgFIsnaoikLG3J3hE/igIoECy0oaBWuLrWY
         X+RibNBZXeQ4tyUBIxUert9sOmkm3HP5vbhHSchXEjF+mS6fRtQ7NwZXCtMkP/78w2
         iMIi0zd0RgA5K4PfgsTi+gqoKIGo0Eb9ubFZXEPsQsjEcPDpc54jM8W/rRyJ7My+RN
         nsO0nFPh8qEckskzVUFKInD+W2rQqmBTYYmzA2TjJOa4TTV0pjbjvFkFmpoAqqh4iZ
         x4B3arvGowo9a+wykswC+zXnMvvnk+tjrI9JUJJld10JjZjUH2oj8AhH9GLRK2L9XM
         n/2bZTKFNd6yw==
Date:   Tue, 27 Jun 2023 17:33:18 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Yajun Deng <yajun.deng@linux.dev>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] memblock: Introduce memblock_reserve_node()
Message-ID: <20230627143318.GN52412@kernel.org>
References: <ZJkudvnGz+Tt5Qml@kernel.org>
 <20230625050850.GJ52412@kernel.org>
 <20230624024622.2959376-1-yajun.deng@linux.dev>
 <4c361d62e0b77242fe4b8592c82c4d90@linux.dev>
 <a13e81ae159d388d3d3e18978a1b1091@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a13e81ae159d388d3d3e18978a1b1091@linux.dev>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 27, 2023 at 12:13:16AM +0000, Yajun Deng wrote:
> June 26, 2023 2:21 PM, "Mike Rapoport" <rppt@kernel.org> wrote:
> 
> > On Sun, Jun 25, 2023 at 07:39:10AM +0000, Yajun Deng wrote:
> > 
> >> June 25, 2023 1:08 PM, "Mike Rapoport" <rppt@kernel.org> wrote:
> >> 
> >> On Sat, Jun 24, 2023 at 10:46:22AM +0800, Yajun Deng wrote:
> >> 
> >> It only returns address now in memblock_find_in_range_node(), we can add a
> >> parameter pointing to integer for node id of the range, which can be used
> >> to pass the node id to the new reserve region.
> >> 
> >> Introduce memblock_reserve_node() so that the node id can be passed to
> >> the reserve region in memblock_alloc_range_nid().
> >> 
> >> Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
> >> 
> >> What problem does this patch solve?
> >> 
> >> If we set nid and flags in memblock_alloc_range_nid(), we may not need
> >> memblock_set_node() in memmap_init_reserved_pages().
> > 
> > When memblock_reserve() is called before NUMA setup, the node ids are still
> > unset in memblock.memory, so very early reservations will be missed and we
> > still have to update node ids in memblock.reserved later.
> 
> Even so, we still need to pass the 'flags' to the new reserve region.
> choose_memblock_flags() may return MEMBLOCK_MIRROR in memblock_alloc_range_nid(),
> memblock_reserve() couldn't pass this flag in this case.
 
flags are only relevant to memblock.memory, we don't care about the flags
in memblock.reserved.
 
> >> I tested this patch and delete memblock_set_node() in memmap_init_reserved_pages().
> >> It works fine. I did not delete memblock_set_node() in this patch just in case.
> > 
> > --
> > Sincerely yours,
> > Mike.

-- 
Sincerely yours,
Mike.
