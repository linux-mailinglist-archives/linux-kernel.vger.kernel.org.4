Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2638973D7B7
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 08:21:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbjFZGVv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 02:21:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbjFZGVu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 02:21:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4947EF3
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 23:21:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D30ED60C88
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 06:21:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDD2CC433C0;
        Mon, 26 Jun 2023 06:21:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687760508;
        bh=32adzyDlBFSBWtLEHoNT9pfLD4gF8dQdYVhhOXCfYD0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WBqcc90oaWhYQCR+OXO6W6iA1ACE4SzpeVklyw8fJfxPwJz0K1YH3vIWMR84qSpaj
         OrwYeLr4DbDJTVWnrcaD6KDbdQfSQYSBFWOOlpgL7jB5vbzolI8iBDnA8JE6OPkBXm
         dbvViJB9f/0YTRMiBWnmnqVTLdOvLE/q63nO1zmW4NZXPmirC0L4RdZ4FCCQvKEqdv
         cPZ7mpUXnXdKxc1ryne6q4P3oABniHLHIoXGnVSLHcnSmNsERVnEm92VyNEuD7TaMA
         D2qtgyLYu1om93dBNc/LnJQpSuRvj5dz5MDHFvj+flBUWndo6hVGKx6EZtOH/8naDz
         xJWbQFYxOOYjg==
Date:   Mon, 26 Jun 2023 09:21:42 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Yajun Deng <yajun.deng@linux.dev>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] memblock: Introduce memblock_reserve_node()
Message-ID: <ZJkudvnGz+Tt5Qml@kernel.org>
References: <20230625050850.GJ52412@kernel.org>
 <20230624024622.2959376-1-yajun.deng@linux.dev>
 <4c361d62e0b77242fe4b8592c82c4d90@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4c361d62e0b77242fe4b8592c82c4d90@linux.dev>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 25, 2023 at 07:39:10AM +0000, Yajun Deng wrote:
> June 25, 2023 1:08 PM, "Mike Rapoport" <rppt@kernel.org> wrote:
> 
> > On Sat, Jun 24, 2023 at 10:46:22AM +0800, Yajun Deng wrote:
> > 
> >> It only returns address now in memblock_find_in_range_node(), we can add a
> >> parameter pointing to integer for node id of the range, which can be used
> >> to pass the node id to the new reserve region.
> >> 
> >> Introduce memblock_reserve_node() so that the node id can be passed to
> >> the reserve region in memblock_alloc_range_nid().
> >> 
> >> Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
> > 
> > What problem does this patch solve?
> >
> 
> If we set nid and flags in memblock_alloc_range_nid(), we may not need
> memblock_set_node() in memmap_init_reserved_pages().

When memblock_reserve() is called before NUMA setup, the node ids are still
unset in memblock.memory, so very early reservations will be missed and we
still have to update node ids in memblock.reserved later.
 
> I tested this patch and delete memblock_set_node() in memmap_init_reserved_pages().
> It works fine. I did not delete memblock_set_node() in this patch just in case.

-- 
Sincerely yours,
Mike.
