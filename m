Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44B3470D5F7
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 09:48:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235771AbjEWHsW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 03:48:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235752AbjEWHrU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 03:47:20 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 756C61BB;
        Tue, 23 May 2023 00:46:49 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id F346E2278E;
        Tue, 23 May 2023 07:46:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1684828008; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=58gO67C02CVMHG9L5fQR2UaHS2Sy9GihYlrPMDsOtdY=;
        b=2d+tgN4NQAeqxQf9muy2Hs6z+gOqwlZz4sB110Vo8C97eAyDWV2FPNgr4+XERj/fbPnR7K
        dKoqBODa6I5DFBvgybWFUKX4WnnkZxulc98WwRZ4ciQI6D3KH6jdOLSPOQjCjqTwm9l6TB
        3hxPKIlmiAzYOa6yDUAIgwuebGO9o00=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1684828008;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=58gO67C02CVMHG9L5fQR2UaHS2Sy9GihYlrPMDsOtdY=;
        b=z9+bPFWJb5h70YdzRwLa7N6xoz226Vn0mVd4Gpx00kLlbTL3VVlAq1PFoiR8eE+Hwyog7Y
        dH9YZUh21MvLfvBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 56AF913588;
        Tue, 23 May 2023 07:46:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id gk7hE2dvbGTgJwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Tue, 23 May 2023 07:46:47 +0000
Message-ID: <623a87c6-c0d2-799a-c39e-0d14dcdfa6df@suse.cz>
Date:   Tue, 23 May 2023 09:46:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] mm/slab: remove HAVE_HARDENED_USERCOPY_ALLOCATOR
Content-Language: en-US
To:     Lorenzo Stoakes <lstoakes@gmail.com>
Cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Kees Cook <keescook@chromium.org>, linux-mm@kvack.org,
        linux-hardening@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <20230523073136.4900-1-vbabka@suse.cz>
 <310077ed-6f3f-41fe-afcf-36500a9408ec@lucifer.local>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <310077ed-6f3f-41fe-afcf-36500a9408ec@lucifer.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/23/23 09:42, Lorenzo Stoakes wrote:
> On Tue, May 23, 2023 at 09:31:36AM +0200, Vlastimil Babka wrote:
>> With SLOB removed, both remaining allocators support hardened usercopy,
>> so remove the config and associated #ifdef.
>>
>> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
>> ---
>>  mm/Kconfig       | 2 --
>>  mm/slab.h        | 9 ---------
>>  security/Kconfig | 8 --------
>>  3 files changed, 19 deletions(-)
>>
>> diff --git a/mm/Kconfig b/mm/Kconfig
>> index 7672a22647b4..041f0da42f2b 100644
>> --- a/mm/Kconfig
>> +++ b/mm/Kconfig
>> @@ -221,7 +221,6 @@ choice
>>  config SLAB
>>  	bool "SLAB"
>>  	depends on !PREEMPT_RT
>> -	select HAVE_HARDENED_USERCOPY_ALLOCATOR
>>  	help
>>  	  The regular slab allocator that is established and known to work
>>  	  well in all environments. It organizes cache hot objects in
>> @@ -229,7 +228,6 @@ config SLAB
>>
>>  config SLUB
>>  	bool "SLUB (Unqueued Allocator)"
>> -	select HAVE_HARDENED_USERCOPY_ALLOCATOR
>>  	help
>>  	   SLUB is a slab allocator that minimizes cache line usage
>>  	   instead of managing queues of cached objects (SLAB approach).
>> diff --git a/mm/slab.h b/mm/slab.h
>> index f01ac256a8f5..695ef96b4b5b 100644
>> --- a/mm/slab.h
>> +++ b/mm/slab.h
>> @@ -832,17 +832,8 @@ struct kmem_obj_info {
>>  void __kmem_obj_info(struct kmem_obj_info *kpp, void *object, struct slab *slab);
>>  #endif
>>
>> -#ifdef CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR
>>  void __check_heap_object(const void *ptr, unsigned long n,
>>  			 const struct slab *slab, bool to_user);
>> -#else
>> -static inline
>> -void __check_heap_object(const void *ptr, unsigned long n,
>> -			 const struct slab *slab, bool to_user)
>> -{
>> -}
>> -#endif
> 
> Hm, this is still defined in slab.c/slub.c and invoked in usercopy.c, do we
> not want the prototype?

Well I didn't delete the prototype, just the ifdef/else around, so now it's
there unconditionally.

> Perhaps replacing with #ifdef
> CONFIG_HARDENED_USERCOPY instead? I may be missing something here :)

Putting it under that #ifdef would work and match that the implementations
of that function are under that same ifdef, but maybe it's unnecessary noise
in the header?

