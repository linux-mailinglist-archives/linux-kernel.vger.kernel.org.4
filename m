Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B12274B4B8
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 17:55:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232418AbjGGPzd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 11:55:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbjGGPzb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 11:55:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 929DDFB;
        Fri,  7 Jul 2023 08:55:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 26F97619FC;
        Fri,  7 Jul 2023 15:55:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A3BFC433C7;
        Fri,  7 Jul 2023 15:55:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688745329;
        bh=w8KYR6gzrUNFbtKM/p+G+JdWO4JfsO1K+O7KqoUEqtc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sUQTi0btfsvZqBKWmLBywAmzE41jyD42XPM9Zc0dUv/PHx768itGsSGmaM9v1lkM8
         P6YWSL0IecjEdMvfbaCTPnDN8ogTsxy9nwnArRewdXEzITBuVKLtDESLlAVpZZSAnF
         Zp7UcmmV1sQecT3Qc+DiOgs8JpBP9b5SrEtQtmn0=
Date:   Fri, 7 Jul 2023 17:55:26 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        John Hsu <John.Hsu@mediatek.com>, stable@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH stable v6.1] mm/mmap: Fix extra maple tree write
Message-ID: <2023070748-confiding-abnormal-b7e3@gregkh>
References: <20230706185135.2235532-1-Liam.Howlett@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230706185135.2235532-1-Liam.Howlett@oracle.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 06, 2023 at 02:51:35PM -0400, Liam R. Howlett wrote:
> commit 0503ea8f5ba73eb3ab13a81c1eefbaf51405385a upstream.
> 
> This was inadvertently fixed during the removal of __vma_adjust().
> 
> When __vma_adjust() is adjusting next with a negative value (pushing
> vma->vm_end lower), there would be two writes to the maple tree.  The
> first write is unnecessary and uses all allocated nodes in the maple
> state.  The second write is necessary but will need to allocate nodes
> since the first write has used the allocated nodes.  This may be a
> problem as it may not be safe to allocate at this time, such as a low
> memory situation.  Fix the issue by avoiding the first write and only
> write the adjusted "next" VMA.

Are you sure this is the same git id?  The one you reference above is
_VERY_ different from your 2 line change below.

And the changelog text is not the same.

confused,

greg k-h
