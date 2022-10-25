Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E17EA60C7E8
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 11:23:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231276AbiJYJW6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 05:22:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231213AbiJYJWU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 05:22:20 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 289BDFCA;
        Tue, 25 Oct 2022 02:17:41 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 01ECD1FD6C;
        Tue, 25 Oct 2022 09:17:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1666689460; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zD8OApJsTbBnv3iSDEQ49cotr+aBwY7HUsO9Mmm7DyI=;
        b=tZNaBpgRS2zftFAhvMLdtVxWOpW3DR3e9FK3I5hXXbAIDvLr7G8T7UgYtxstGKE/nJRrVq
        YkqlGUdwW1JyGmNM5dF/AEGZiKHNwqSZ/GIyJgG8RGfUcxLBb00POG5rljywVvmsQIhxbO
        d8CgwSKzMPKy2RxSJd63ru2SkcOBq0k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1666689460;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zD8OApJsTbBnv3iSDEQ49cotr+aBwY7HUsO9Mmm7DyI=;
        b=UIV++LU+F+Fv84uskaMlBHpmjO0+klcnp4ZLkqUp4JULhXo9MLl/3WPaZOU53Zf1hyW9N+
        BsaLrSFTvaqfQ8DQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CAC8C134CA;
        Tue, 25 Oct 2022 09:17:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id FIDSMLOpV2McOwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Tue, 25 Oct 2022 09:17:39 +0000
Message-ID: <32fe01dc-dda1-2154-af8e-7e9f64d6f811@suse.cz>
Date:   Tue, 25 Oct 2022 11:17:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: amusing SLUB compaction bug when CC_OPTIMIZE_FOR_SIZE
Content-Language: en-US
To:     Hugh Dickins <hughd@google.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        David Laight <David.Laight@aculab.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        rcu@vger.kernel.org, David Laight <David.Laight@ACULAB.COM>,
        Kees Cook <keescook@chromium.org>
References: <ea96c78c-e1dc-1364-e91-51909f82388b@google.com>
 <YzPgTtFzpKEfwPbK@hyeyoo> <YzRQvoVsnJzsauwb@google.com>
 <35502bdd-1a78-dea1-6ac3-6ff1bcc073fa@suse.cz>
 <ff905c1e-5eb3-eaf8-46de-38f189c0b7a5@google.com>
 <de71b83a-c82c-4785-ef5a-3db4f17bbc8d@suse.cz>
 <bcecece-f7ce-221d-1674-da3d5ab3fef@google.com> <YzkmErHFyYW3awRn@hyeyoo>
 <YzsVM8eToHUeTP75@casper.infradead.org>
 <7dddca4c-bc36-2cf0-de1c-a770bef9e1b7@suse.cz>
 <904cc831-eb16-b1e5-10e5-9e7a171ef83@google.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <904cc831-eb16-b1e5-10e5-9e7a171ef83@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/25/22 06:19, Hugh Dickins wrote:
> On Mon, 24 Oct 2022, Vlastimil Babka wrote:

>> 
>> [1] https://lore.kernel.org/all/aec59f53-0e53-1736-5932-25407125d4d4@suse.cz/
> 
> Ignore me, don't let me distract if you're happy with Matthew's patch
> (I know little of PageMovable, and I haven't tried to understand it);
> but it did look to me more like 6.2 material,

Yes, it is targetted towards 6.2 now.

> and I was surprised that
> you dropped the simple align(4) approach for 6.1.
> 
> Because of Hyeonggon's rcu_leak_callback() observation?  That was a
> good catch, but turned out to be irrelevant, because it was only for
> an RCU debugging option, which would never be set up on a struct page
> (well, maybe it would in a dynamically-allocated-struct-page future).

It was mainly due to David's observation:

https://lore.kernel.org/all/c1c8920a56014a179dbb82d483f2ad28@AcuMS.aculab.com/

I did also conclude that align(4) indeed overrides anything set via
CONFIG_FUNCTION_ALIGNMENT (and passed by -falign-functions) in a way that a
globally configured larger alignment can be made smaller by this macro, and
it was all too risky and last minute to me, while Joel's series wasn't
targetted to 6.1 anyway so there was no urgency.

And yeah it looks like a gcc bug to me.

> Hugh

