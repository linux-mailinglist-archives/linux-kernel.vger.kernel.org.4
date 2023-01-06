Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 445AA65FE94
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 11:14:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233101AbjAFKNh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 05:13:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233600AbjAFKNT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 05:13:19 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 743CA69B33
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 02:13:17 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id DF0B925EF0;
        Fri,  6 Jan 2023 10:13:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1672999995; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nERWJ8jWPlGQK5idcTkJNelcJmXRYvfJXwDNtJ1Pe4A=;
        b=MaULLB4DgfHl6u1tgkaruYPDRAeRoPXNjzSi8ktosf+Vp4qW34m6hu/KGSnOUf8UUsBToy
        XmasH0rlqiw3VGGc5imHtEYM85kkr2wIcRSU6CjicdfCmVu52DE9dyRnODc+VWJqbWHp0B
        l4mfnAZlcgGaExZtsxAydkc0LrUUX3w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1672999995;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nERWJ8jWPlGQK5idcTkJNelcJmXRYvfJXwDNtJ1Pe4A=;
        b=mWBUqwKncFqQaIkx1E72Oor3bxc7RsmdoL6G1gx5pBA4JvF6UTFVnwDU2kl7KPCYmlJ7cz
        KLcLyV+K/gzhenAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B847B139D5;
        Fri,  6 Jan 2023 10:13:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Gk9HLDv0t2OsfQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Fri, 06 Jan 2023 10:13:15 +0000
Message-ID: <3f7fa3b3-9623-5c4c-94b1-a41dea6eaaf2@suse.cz>
Date:   Fri, 6 Jan 2023 11:13:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [linus:master] [mm, slub] 0af8489b02:
 kernel_BUG_at_include/linux/mm.h
To:     Oliver Sang <oliver.sang@intel.com>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc:     oe-lkp@lists.linux.dev, lkp@intel.com,
        Mike Rapoport <rppt@linux.ibm.com>,
        Christoph Lameter <cl@linux.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Matthew Wilcox <willy@infradead.org>
References: <202212312021.bc1efe86-oliver.sang@intel.com>
 <41276905-b8a5-76ae-8a17-a8ec6558e988@suse.cz>
 <Y7Qxucg5le7WOzr7@xsang-OptiPlex-9020> <Y7VBFLHY/PMbb4XS@hyeyoo>
 <Y7Yr3kEkDEd51xns@xsang-OptiPlex-9020>
Content-Language: en-US
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <Y7Yr3kEkDEd51xns@xsang-OptiPlex-9020>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/5/23 02:46, Oliver Sang wrote:
> hi, Hyeonggon, hi, Vlastimil,
> 
> On Wed, Jan 04, 2023 at 06:04:20PM +0900, Hyeonggon Yoo wrote:
>> On Tue, Jan 03, 2023 at 09:46:33PM +0800, Oliver Sang wrote:
>> > On Tue, Jan 03, 2023 at 11:42:11AM +0100, Vlastimil Babka wrote:
>> > > So the events leading up to this could be something like:
>> > > 
>> > > - 0x2daee is order-1 slab folio of the inode cache, sitting on the partial list
>> > > - despite being on partial list, it's freed ???
>> > > - somebody else allocates order-2 page 0x2daec and uses it for whatever,
>> > > then frees it
>> > > - 0x2daec is reallocated as order-1 slab from names_cache, then freed
>> > > - we try to allocate from the slab page 0x2daee and trip on the PageTail
>> > > 
>> > > Except, the freeing of order-2 page would have reset the PageTail and
>> > > compound_head in 0x2daec, so this is even more complicated or involves some
>> > > extra race?
>> > 
>> > FYI, we ran tests more up to 500 times, then saw different issues but rate is
>> > actually low
>> > 
>> > 56d5a2b9ba85a390 0af8489b0216fa1dd83e264bef8
>> > ---------------- ---------------------------
>> >        fail:runs  %reproduction    fail:runs
>> >            |             |             |
>> >            :500         12%          61:500   dmesg.invalid_opcode:#[##]
>> >            :500          3%          14:500   dmesg.kernel_BUG_at_include/linux/mm.h
>> >            :500          3%          17:500   dmesg.kernel_BUG_at_include/linux/page-flags.h
>> >            :500          5%          26:500   dmesg.kernel_BUG_at_lib/list_debug.c
>> >            :500          0%           2:500   dmesg.kernel_BUG_at_mm/page_alloc.c
>> >            :500          0%           2:500   dmesg.kernel_BUG_at_mm/usercopy.c
>> > 
> 
> hi Vlastimil,
> 
> as you mentioned
>> Hm even if rate is low, the different kinds of reports could be useful to
>> see, if all of that is caused by the commit.
> 
> we tried to run tests even more times, but with the config which enable
>     CONFIG_DEBUG_PAGEALLOC
>     CONFIG_DEBUG_PAGEALLOC_ENABLE_DEFAULT
> (config is attached as
>     config-6.1.0-rc2-00014-g0af8489b0216+CONFIG_DEBUG_PAGEALLOC+CONFIG_DEBUG_PAGEALLOC_ENABLE_DEFAULT
> the only diff with previous config is
> @@ -5601,7 +5601,8 @@ CONFIG_HAVE_KCSAN_COMPILER=y
>  # Memory Debugging
>  #
>  CONFIG_PAGE_EXTENSION=y
> -# CONFIG_DEBUG_PAGEALLOC is not set
> +CONFIG_DEBUG_PAGEALLOC=y
> +CONFIG_DEBUG_PAGEALLOC_ENABLE_DEFAULT=y
>  CONFIG_PAGE_OWNER=y
>  # CONFIG_PAGE_POISONING is not set
>  CONFIG_DEBUG_PAGE_REF=y
> )
> 
> what we found now is some issues are also reproduced on parent now (still by
> rcutorture tests here), though seems lower rate on parent.
> 
> =========================================================================================
> compiler/kconfig/rootfs/runtime/tbox_group/test/testcase/torture_type:
>   gcc-11/i386-randconfig-a012-20221226+CONFIG_DEBUG_PAGEALLOC+CONFIG_DEBUG_PAGEALLOC_ENABLE_DEFAULT/debian-11.1-i386-20220923.cgz/300s/vm-snb/default/rcutorture/tasks-tracing
> 
> 56d5a2b9ba85a390 0af8489b0216fa1dd83e264bef8
> ---------------- ---------------------------
>        fail:runs  %reproduction    fail:runs
>            |             |             |
>           8:985         19%         199:990   dmesg.invalid_opcode:#[##]
>            :985          5%          51:990   dmesg.kernel_BUG_at_include/linux/mm.h
>           3:985          4%          41:990   dmesg.kernel_BUG_at_include/linux/page-flags.h
>           4:985         10%         102:990   dmesg.kernel_BUG_at_lib/list_debug.c
>            :985          0%           2:990   dmesg.kernel_BUG_at_mm/page_alloc.c
>           1:985          0%           3:990   dmesg.kernel_BUG_at_mm/usercopy.c
> 
> however, we noticed dmesg.kernel_BUG_at_include/linux/mm.h still have
> relatively high rate on this commit but keeps clean on parent.

Well that's interesting. As long as any bugs happen in the parent, it could
mean the commit we suspect is just changing the circumstances and creating
conditions that increase the bug happening - e.g. because it causes slab
pages to be always immediately freed when the last object is freed.

So I would be curiou about how some of the reports from the parent look like
in detail. And if the rate at the parent (has it increased thanks to the
DEBUG_PAGEALLOC?) is sufficient to bisect to the truly first bad commit. Thanks!

