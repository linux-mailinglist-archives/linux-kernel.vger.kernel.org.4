Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 866F86E208F
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 12:19:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbjDNKTE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 06:19:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbjDNKTC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 06:19:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CA694C06;
        Fri, 14 Apr 2023 03:19:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E695564516;
        Fri, 14 Apr 2023 10:19:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4066AC433EF;
        Fri, 14 Apr 2023 10:18:56 +0000 (UTC)
Date:   Fri, 14 Apr 2023 11:18:53 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     david@redhat.com, patches@lists.linux.dev,
        linux-modules@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, pmladek@suse.com,
        petr.pavlu@suse.com, prarit@redhat.com,
        torvalds@linux-foundation.org, gregkh@linuxfoundation.org,
        rafael@kernel.org, christophe.leroy@csgroup.eu, tglx@linutronix.de,
        peterz@infradead.org, song@kernel.org, rppt@kernel.org,
        dave@stgolabs.net, willy@infradead.org, vbabka@suse.cz,
        mhocko@suse.com, dave.hansen@linux.intel.com,
        colin.i.king@gmail.com, jim.cromie@gmail.com, jbaron@akamai.com,
        rick.p.edgecombe@intel.com
Subject: Re: [PATCH v3 1/4] module: fix kmemleak annotations for non init ELF
 sections
Message-ID: <ZDkojSahbkCtSOTq@arm.com>
References: <20230414050836.1984746-1-mcgrof@kernel.org>
 <20230414050836.1984746-2-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230414050836.1984746-2-mcgrof@kernel.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 13, 2023 at 10:08:33PM -0700, Luis Chamberlain wrote:
> Commit ac3b43283923 ("module: replace module_layout with module_memory")
> reworked the way to handle memory allocations to make it clearer. But it
> lost in translation how we handled kmemleak_ignore() or kmemleak_not_leak()
> for different ELF sections.
> 
> Fix this and clarify the comments a bit more. Contrary to the old way
> of using kmemleak_ignore() for init.* ELF sections we stick now only to
> kmemleak_not_leak() as per suggestion by Catalin Marinas so to avoid
> any false positives and simplify the code.
> 
> Fixes: ac3b43283923 ("module: replace module_layout with module_memory")
> Reported-by: Jim Cromie <jim.cromie@gmail.com>
> Acked-by: Song Liu <song@kernel.org>
> Suggested-by: Catalin Marinas <catalin.marinas@arm.com>
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
