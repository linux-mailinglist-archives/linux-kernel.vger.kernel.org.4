Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3002A6C6066
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 08:09:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230283AbjCWHJK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 03:09:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229928AbjCWHJH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 03:09:07 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5102A44B1;
        Thu, 23 Mar 2023 00:09:03 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E106B343FD;
        Thu, 23 Mar 2023 07:09:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1679555341; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bo0mwMSC9DxwRp+mVZJu5IM8tHoiuR9sJzmhxjYBT1Q=;
        b=lgriT5kKTd7HE5i2PBh1xbIICb+y/QW6cUvKsTVPwMczjrejBvH6bW5+QtUKn05Nz3EXQU
        /s4HhNwyZ//KkmAeRNfoujOzNW3u30KG+JY0wa+sAcXKg02qUtrWEfvY9xuR/h852sMALV
        qjcvASpIkccmUre5WmVsNwjcBJ+hDJI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1679555341;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bo0mwMSC9DxwRp+mVZJu5IM8tHoiuR9sJzmhxjYBT1Q=;
        b=Mr7qWsYRld0GeQKhgGiVh+BApisHJbhTBfwS/Cex7LSrmrurd0qdewsCbdkbx7lCaS0AG6
        bEIjcpHvf0vDYBBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B378613596;
        Thu, 23 Mar 2023 07:09:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 0y3uKg37G2S4dwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Thu, 23 Mar 2023 07:09:01 +0000
Message-ID: <7d3725ec-1586-e697-1602-713bfd38daf9@suse.cz>
Date:   Thu, 23 Mar 2023 08:09:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 06/14] init: fold build_all_zonelists() and
 page_alloc_init_cpuhp() to mm_init()
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Doug Berger <opendmb@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>, Michal Hocko <mhocko@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-mm@kvack.org
References: <20230321170513.2401534-1-rppt@kernel.org>
 <20230321170513.2401534-7-rppt@kernel.org>
 <f712fa24-91f7-38e7-fd6e-b33ab52ce88c@suse.cz> <ZBtkYQyxulcNV8gG@kernel.org>
Content-Language: en-US
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <ZBtkYQyxulcNV8gG@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/22/23 21:26, Mike Rapoport wrote:
> On Wed, Mar 22, 2023 at 05:10:10PM +0100, Vlastimil Babka wrote:
>> On 3/21/23 18:05, Mike Rapoport wrote:
>> > From: "Mike Rapoport (IBM)" <rppt@kernel.org>
>> > 
>> > Both build_all_zonelists() and page_alloc_init_cpuhp() must be called
>> > after SMP setup is complete but before the page allocator is set up.
>> > 
>> > Still, they both are a part of memory management initialization, so move
>> > them to mm_init().
>> 
>> Well, logic grouping is one thing, but not breaking a functional order is
>> more important. So this moves both calls to happen later than theyw ere. I
>> guess it could only matter for page_alloc_init_cpuhp() in case cpu hotplugs
>> would be processed in some of the calls we "skipped" over by moving this
>> later. And one of them is setup_arch()... so are we sure no arch does some
>> cpu hotplug for non-boot cpus there?
> 
> mm_init() happens after the point build_all_zonelists() and
> page_alloc_init_cpuhp() were originally, so they are essentially moved
> later in the init sequence and in either case called after setup_arch().

Right, I looked at a wrong place in start_kernel() for the original location
of the calls, sorry for the noise.

> We skip the code below and it does not do neither cpu hotplug nor
> non-memblock allocations.
> 
> 	jump_label_init();
> 	parse_early_param();
> 	after_dashes = parse_args("Booting kernel",
> 				  static_command_line, __start___param,
> 				  __stop___param - __start___param,
> 				  -1, -1, NULL, &unknown_bootoption);
> 	print_unknown_bootoptions();
> 	if (!IS_ERR_OR_NULL(after_dashes))
> 		parse_args("Setting init args", after_dashes, NULL, 0, -1, -1,
> 			   NULL, set_init_arg);
> 	if (extra_init_args)
> 		parse_args("Setting extra init args", extra_init_args,
> 			   NULL, 0, -1, -1, NULL, set_init_arg);
> 
> 	/* Architectural and non-timekeeping rng init, before allocator init */
> 	random_init_early(command_line);
> 
> 	/*
> 	 * These use large bootmem allocations and must precede
> 	 * kmem_cache_init()
> 	 */
> 	setup_log_buf(0);
> 	vfs_caches_init_early();
> 	sort_main_extable();
> 	trap_init();
> 

Yeah, that looks safe.

>> > Signed-off-by: Mike Rapoport (IBM) <rppt@kernel.org>
>> > Acked-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>


