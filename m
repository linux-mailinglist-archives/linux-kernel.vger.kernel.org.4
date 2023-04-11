Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A8056DDF7C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 17:21:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbjDKPVT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 11:21:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbjDKPVQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 11:21:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 465053C26;
        Tue, 11 Apr 2023 08:20:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A4E29625BE;
        Tue, 11 Apr 2023 15:17:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0237DC433EF;
        Tue, 11 Apr 2023 15:17:38 +0000 (UTC)
Date:   Tue, 11 Apr 2023 16:17:35 +0100
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
Subject: Re: [PATCH v2 1/6] module: fix kmemleak annotations for non init ELF
 sections
Message-ID: <ZDV6DzePHI3KLISY@arm.com>
References: <20230405022702.753323-1-mcgrof@kernel.org>
 <20230405022702.753323-2-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230405022702.753323-2-mcgrof@kernel.org>
X-Spam-Status: No, score=-4.8 required=5.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 04, 2023 at 07:26:57PM -0700, Luis Chamberlain wrote:
> diff --git a/kernel/module/main.c b/kernel/module/main.c
> index 5cc21083af04..d8bb23fa6989 100644
> --- a/kernel/module/main.c
> +++ b/kernel/module/main.c
> @@ -2233,11 +2233,23 @@ static int move_module(struct module *mod, struct load_info *info)
>  		ptr = module_memory_alloc(mod->mem[type].size, type);
>  
>  		/*
> -		 * The pointer to this block is stored in the module structure
> -		 * which is inside the block. Just mark it as not being a
> -		 * leak.
> +		 * The pointer to these blocks of memory are stored on the module
> +		 * structure and we keep that around so long as the module is
> +		 * around. We only free that memory when we unload the module.
> +		 * Just mark them as not being a leak then. The .init* ELF
> +		 * sections *do* get freed after boot so we treat them slightly
> +		 * differently and only grey them out -- they work as typical
> +		 * memory allocations which *do* eventually get freed.
>  		 */
> -		kmemleak_ignore(ptr);
> +		switch (type) {
> +		case MOD_INIT_TEXT: /* fallthrough */
> +		case MOD_INIT_DATA: /* fallthrough */
> +		case MOD_INIT_RODATA: /* fallthrough */
> +			kmemleak_ignore(ptr);
> +			break;
> +		default:
> +			kmemleak_not_leak(ptr);
> +		}

This works as well but if you want to keep it simple, just call
kmemleak_not_leak() in all cases. When freeing the init sections, they
would be removed from the kmemleak tracing anyway.

-- 
Catalin
