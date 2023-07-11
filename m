Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 899CC74EB4F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 11:59:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbjGKJ7M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 05:59:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231218AbjGKJ7D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 05:59:03 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 890BD10F9
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 02:57:34 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id F21BD204E5;
        Tue, 11 Jul 2023 09:57:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1689069452; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ndrpTB8+BW2nsVzC9b3EPrI8jU76zMdu9leJSYbJQV0=;
        b=EjqzrF7dzWaSqgYHubdacAC7OAN0opHtYL6Gic/sAK5h0MpUDXaasJN+90ETQ4BTmHefVp
        WURR79+G0fdLTTTaYnLh9Mq3Zy3cUocLtn0lXFicu5J7cZIGofryZS/bBnAhc0shfe+PoW
        RPLDQ9P+IaCO4M9ImS/u2bOeMr/E79U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1689069452;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ndrpTB8+BW2nsVzC9b3EPrI8jU76zMdu9leJSYbJQV0=;
        b=9GpLkrj7A61FyiXBpm5p0gjrtxvX0Cs5FWR9baHVxFZYMl8yzih5HTFJY+NeEJ5G3K/1IC
        KP7Ax+reBTezT2AQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0FF141391C;
        Tue, 11 Jul 2023 09:57:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id zyMHN4onrWRAaQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Tue, 11 Jul 2023 09:57:30 +0000
Message-ID: <ffc84d42-b530-58a7-2af2-4c8b55f697dd@suse.cz>
Date:   Tue, 11 Jul 2023 11:57:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2] mm/slub: refactor freelist to use custom type
Content-Language: en-US
To:     Matteo Rizzo <matteorizzo@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, cl@linux.com, penberg@kernel.org,
        rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, roman.gushchin@linux.dev,
        42.hyeyoo@gmail.com
Cc:     jannh@google.com
References: <20230704135834.3884421-1-matteorizzo@google.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20230704135834.3884421-1-matteorizzo@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/4/23 15:58, Matteo Rizzo wrote:
> From: Jann Horn <jannh@google.com>
> 
> Currently the SLUB code represents encoded freelist entries as "void*".
> That's misleading, those things are encoded under
> CONFIG_SLAB_FREELIST_HARDENED so that they're not actually dereferencable.
> 
> Give them their own type, and split freelist_ptr() into one function per
> direction (one for encoding, one for decoding).
> 
> Signed-off-by: Jann Horn <jannh@google.com>
> Co-developed-by: Matteo Rizzo <matteorizzo@google.com>
> Signed-off-by: Matteo Rizzo <matteorizzo@google.com>

Thanks, merged:

https://git.kernel.org/pub/scm/linux/kernel/git/vbabka/slab.git/log/?h=slab/for-6.6/cleanup

While reviewing this I think more cleanups are possible but I will post them
on top as it's better for bisection purposes than folding anyway, and should
involve kasan folks.

