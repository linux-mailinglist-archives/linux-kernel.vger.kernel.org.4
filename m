Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DF1E6C3519
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 16:08:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230109AbjCUPIA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 11:08:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230040AbjCUPH5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 11:07:57 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34D55509A3;
        Tue, 21 Mar 2023 08:07:40 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id CB0E22205A;
        Tue, 21 Mar 2023 15:07:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1679411258; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Qjl8kH/Vpnej56cQT8qCtFqqHMGm0sWE/AsgusME/uQ=;
        b=g1rdgNqoBgU3cwnVT7+hVR+odjZ7C52BpKvZF97Qf8wh0PAs/ANQATzTkvbvGV6PwqqOBL
        zPd9TXhm5lc7xw8OAcx/6DoC3kK0+jdwm6/LeRkDiRvWtNGrkZtNCARbeCexd/NgXyey42
        3Qv8zZTP6L3b1HxeYj098ub+/WkjY2c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1679411258;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Qjl8kH/Vpnej56cQT8qCtFqqHMGm0sWE/AsgusME/uQ=;
        b=dFU5avTINlLBgm//sJpLqHPsiKpYosg07rOX+nuSSSpzuQidDzKa4lcd24yq1u4Zu8OSip
        rFx9mY/NXUg4kqAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 90D6313440;
        Tue, 21 Mar 2023 15:07:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id kT+nIjrIGWT/TAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Tue, 21 Mar 2023 15:07:38 +0000
Message-ID: <bd800046-4883-71d7-535f-7546d693faa1@suse.cz>
Date:   Tue, 21 Mar 2023 16:07:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] mm/slab: Fix undefined init_cache_node_node() for NUMA
 and !SMP
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org,
        linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org,
        Randy Dunlap <rdunlap@infradead.org>
References: <67261c513706241d479b8b4cf46eb4e6fb0417ba.1679387262.git.geert+renesas@glider.be>
 <fac6b2c757166df891d60bd00524af7e7d30fe78.camel@physik.fu-berlin.de>
 <CAMuHMdUJ+o4qf056XgLHtkoPnqL+Nk4jZhQ7zntKS0_1dzYAEg@mail.gmail.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <CAMuHMdUJ+o4qf056XgLHtkoPnqL+Nk4jZhQ7zntKS0_1dzYAEg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_SOFTFAIL,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/21/23 09:50, Geert Uytterhoeven wrote:
> Hi Adrian,
> 
> On Tue, Mar 21, 2023 at 9:47 AM John Paul Adrian Glaubitz
> <glaubitz@physik.fu-berlin.de> wrote:
>> On Tue, 2023-03-21 at 09:30 +0100, Geert Uytterhoeven wrote:
>> > sh/migor_defconfig:
>> >
>> >     mm/slab.c: In function ‘slab_memory_callback’:
>> >     mm/slab.c:1127:23: error: implicit declaration of function ‘init_cache_node_node’; did you mean ‘drain_cache_node_node’? [-Werror=implicit-function-declaration]
>> >      1127 |                 ret = init_cache_node_node(nid);
>> >         |                       ^~~~~~~~~~~~~~~~~~~~
>> >         |                       drain_cache_node_node
>> >
>> > The #ifdef condition protecting the definition of init_cache_node_node()
>> > no longer matches the conditions protecting the (multiple) users.
>> >
>> > Fix this by syncing the conditions.
>> >
>> > Fixes: 76af6a054da40553 ("mm/migrate: add CPU hotplug to demotion #ifdef")
>> > Reported-by: Randy Dunlap <rdunlap@infradead.org>
>> > Link: https://lore.kernel.org/r/b5bdea22-ed2f-3187-6efe-0c72330270a4@infradead.org
>> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>> > ---
>> >  mm/slab.c | 2 +-
>> >  1 file changed, 1 insertion(+), 1 deletion(-)
>> >
>> > diff --git a/mm/slab.c b/mm/slab.c
>> > index ba454246ee13dd4d..de1523a78f2e7367 100644
>> > --- a/mm/slab.c
>> > +++ b/mm/slab.c
>> > @@ -839,7 +839,7 @@ static int init_cache_node(struct kmem_cache *cachep, int node, gfp_t gfp)
>> >       return 0;
>> >  }
>> >
>> > -#if (defined(CONFIG_NUMA) && defined(CONFIG_MEMORY_HOTPLUG)) || defined(CONFIG_SMP)
>> > +#if defined(CONFIG_NUMA) || defined(CONFIG_SMP)
>> >  /*
>> >   * Allocates and initializes node for a node on each slab cache, used for
>> >   * either memory or cpu hotplug.  If memory is being hot-added, the kmem_cache_node
>>
>> FWIW, the other #ifdef starting at drain_cache_node_node() closes with "#endif /* CONFIG_NUMA */",
>> while this #ifdef just ends with "#endif". Just in case you want to make this consistent.
> 
> I guess that's fine, as init_cache_node_node() is a small function.
> #endif comments are typically used when the start and end markers
> do not fit on your (80x25 ;-) screen.

Agreed with this reasoning.

>> Reviewed-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> 
> Thanks!

Applied to slab/for-6.3-rc4/fixes, thanks!

> Gr{oetje,eeting}s,
> 
>                         Geert
> 

