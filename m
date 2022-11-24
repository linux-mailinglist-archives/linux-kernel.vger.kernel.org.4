Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 734776377A0
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 12:26:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbiKXL0q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 06:26:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbiKXL0o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 06:26:44 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 659A2240AA
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 03:26:43 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id EF9891F38D;
        Thu, 24 Nov 2022 11:26:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1669289201; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ghl8pz0023I9HjGlunSrLG6YT8beQ1/ZChOc8kYxn10=;
        b=rIeXXCIldod+fSwdIB8Hm4YrFZw7XlW0nl3dvw1KvRXSpNMC6w6mFGDxE5r7rECi+jGwH+
        5Vb389rbCvTPtLcY83CJLfZKnwjFq+W+XJXtzJNlSCX5zo+H6MS1yNOQN4nn/AAUPHVbaj
        4NBMJ90Lz9KWbl7wnPBfKGYX+43ZUr8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1669289201;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ghl8pz0023I9HjGlunSrLG6YT8beQ1/ZChOc8kYxn10=;
        b=jzhQoJTTjFx/oM4vMTIpSsNj/0pF6cBxA8irCorgksRzNosKsYxyvIfrvecGgiSmbQ048c
        4eW17KcyzN+8j4Bg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B6EDB13B4F;
        Thu, 24 Nov 2022 11:26:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id tSXvK/FUf2MNYQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Thu, 24 Nov 2022 11:26:41 +0000
Message-ID: <dcde302f-faa7-5e55-1e67-f8c7386119d4@suse.cz>
Date:   Thu, 24 Nov 2022 12:26:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 01/12] mm, slab: ignore hardened usercopy parameters when
 disabled
Content-Language: en-US
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc:     Kees Cook <kees@kernel.org>, Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Pekka Enberg <penberg@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>, patches@lists.linux.dev,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>
References: <20221121171202.22080-1-vbabka@suse.cz>
 <20221121171202.22080-2-vbabka@suse.cz>
 <206E0154-63A6-45CF-8E19-BD01B35AEF0B@kernel.org>
 <0058169a-1659-7ab1-edff-de9ebadcf236@suse.cz> <Y39Sq8vReXouviyn@hyeyoo>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <Y39Sq8vReXouviyn@hyeyoo>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/24/22 12:16, Hyeonggon Yoo wrote:
>>  	/* Fail closed on bad usersize of useroffset values. */
>> -	if (WARN_ON(!usersize && useroffset) ||
>> +	if (!IS_ENABLED(CONFIG_HARDENED_USERCOPY) ||
>> +	    WARN_ON(!usersize && useroffset) ||
>>  	    WARN_ON(size < usersize || size - usersize < useroffset))
>>  		usersize = useroffset = 0;
> 
> I think this change is no longer needed as slab_unmergeable()
> now does not check usersize when CONFIG_HARDENED_USERCOPY=n?

True, but the code here still follows by

if (!usersize)
    s = __kmem_cache_alias(name, size, align, flags, ctor);

So it seemed simplest just to leave it like that.


