Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95DEA6CBA2C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 11:11:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231251AbjC1JLH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 05:11:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230199AbjC1JLE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 05:11:04 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 749DA5BAE
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 02:11:01 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 2BE2E21979;
        Tue, 28 Mar 2023 09:11:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1679994660; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UxBAeVCpn+r87f23UwtclmqroqumDDKiPx1bv7IdSyI=;
        b=g1AT2dHA6s4nRruRj09r3f0USJW+PBkfnCGgdurIH3drs6L9HDkT4Kz/7RCI1sZ/aaxlyW
        1uBtcBoBetEBq3E0GkMAVfvSeFULPighvjsjIsvYKO5d8aSl9DaeqRyS7MnUrgzwiHFzXh
        Wa6kN0a9aakeNF8AlbDA3Q9G+sYKY8s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1679994660;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UxBAeVCpn+r87f23UwtclmqroqumDDKiPx1bv7IdSyI=;
        b=1jOWWXvebXlfLbXxktlXXHz0ltFsbQjdHZXv0O8TE7yTAOYIrlBKyyblj73hldp2obkZPm
        BpkPv1XZok3b34Aw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0BA7B1390B;
        Tue, 28 Mar 2023 09:11:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id um0kAiSvImQfPgAAMHmgww
        (envelope-from <vbabka@suse.cz>); Tue, 28 Mar 2023 09:11:00 +0000
Message-ID: <a017acde-7520-743c-963b-94a23c0f30c8@suse.cz>
Date:   Tue, 28 Mar 2023 11:10:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 0/8] Fix VMA tree modification under mmap read lock
Content-Language: en-US
To:     "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <20230327185532.2354250-1-Liam.Howlett@oracle.com>
 <20230327123515.bce6c1ea3660e9b17db50c33@linux-foundation.org>
 <20230327194800.fzqfrxfh3nfmqwgk@revolver>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20230327194800.fzqfrxfh3nfmqwgk@revolver>
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

On 3/27/23 21:48, Liam R. Howlett wrote:
> * Andrew Morton <akpm@linux-foundation.org> [230327 15:35]:
>> On Mon, 27 Mar 2023 14:55:24 -0400 "Liam R. Howlett" <Liam.Howlett@oracle.com> wrote:
>> 
>> > These patches have been in -next since next-20230301, and have received
>> > intensive testing in Android as part of the RCU page fault patchset.
>> > They were also sent as part of the "Per-VMA locks" v4 patch series.
>> > Patches 1 to 7 are bug fixes for RCU mode of the tree and patch 8 enables
>> > RCU mode for the tree.
>> 
>> What's happening here?  I assume you've decided that the first 8
>> patches of the "Per-VMA locks v4" series should be fast-tracked into
>> 6.3-rcX and backported?  And we retain the rest of that series for
>> 6.4-rc1?
> 
> Yes, they need to be backported and fast tracked to fix the issue syzbot
> found.

Stable usually wants the "mainline first" which means fast tracking first,
then once it's in mainline, they pick it and annotate with mainline commit id.

One question is how Linus would feel about this now for rc5.

Another question is if we should really deviate in the patch 8/8 backport
just because it's not necessary for stable. Generally they would also prefer
not to deviate, unless there's a strong reason.

>> 
>> Patch [3/8] hasn't come through to me, to linux-mm or to linux-kernel.
> 
> Should arrive shortly, I received it from one of the ML.
> 
> 

