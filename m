Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DC0B6CA444
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 14:41:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230380AbjC0MlF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 08:41:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbjC0MlD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 08:41:03 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0964E9B
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 05:41:01 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id AE2D821A9F;
        Mon, 27 Mar 2023 12:41:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1679920860; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Wm7sbcWSD2yiNeln6cRgOiH3J+C/JXbDg+4BGV1aKg4=;
        b=dxlpuYwwBnlJDYXkxL642L6oZ5IIA34dfrJgowMeuqPiyqS77/3YXtYOv+xkAklyGp9yeE
        Ef3g+byC6bbFpE71r3ND6J0mSXtSsPmhsfaPy3Rrz/a4O4OoE5IoxzRKZSkT84JWg1IdLc
        TC2wMsLKdV5QcEhOie8L+tT/ssLWGsM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1679920860;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Wm7sbcWSD2yiNeln6cRgOiH3J+C/JXbDg+4BGV1aKg4=;
        b=i7FtOIoDqVbdb3Y22Thn2JIvVIWpPwMKzUWmCGiRwRk7PVUVFx0jE1qcJWgcno4N5IXQT4
        OO27IZuSaVOjaBDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9844113329;
        Mon, 27 Mar 2023 12:41:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ifWYJNyOIWR1VAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Mon, 27 Mar 2023 12:41:00 +0000
Message-ID: <022e1c15-7988-9975-acbc-e661e989ca4a@suse.cz>
Date:   Mon, 27 Mar 2023 14:41:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: What size anonymous folios should we allocate?
To:     Matthew Wilcox <willy@infradead.org>,
        Yang Shi <shy828301@gmail.com>,
        Ryan Roberts <ryan.roberts@arm.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <Y/U8bQd15aUO97vS@casper.infradead.org>
 <CAHbLzkrkZmbVMkh-Y-bDxgy0T0ZRRd+T+o5y5-wKmjKmhN0NmA@mail.gmail.com>
 <Y/WRlX+MkmxelNbg@casper.infradead.org>
Content-Language: en-US
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <Y/WRlX+MkmxelNbg@casper.infradead.org>
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

On 2/22/23 04:52, Matthew Wilcox wrote:
> On Tue, Feb 21, 2023 at 03:05:33PM -0800, Yang Shi wrote:
> 
>> > C. We add a new wrinkle to the LRU handling code.  When our scan of the
>> >    active list examines a folio, we look to see how many of the PTEs
>> >    mapping the folio have been accessed.  If it is fewer than half, and
>> >    those half are all in either the first or last half of the folio, we
>> >    split it.  The active half stays on the active list and the inactive
>> >    half is moved to the inactive list.
>> 
>> With contiguous PTE, every PTE still maintains its own access bit (but
>> it is implementation defined, some implementations may just set access
>> bit once for one PTE in the contiguous region per arm arm IIUC). But
>> anyway this is definitely feasible.
> 
> If a CPU doesn't have separate access bits for PTEs, then we should just
> not use the contiguous bits.  Knowing which parts of the folio are
> unused is more important than using the larger TLB entries.

Hm but AFAIK the AMD aggregation is transparent, there are no bits. And IIUC
the "Hardware Page Aggregation (HPA)" Ryan was talking about elsewhere in
the thread, that sounds similar. So I IIUC there will be a larger TLB entry
transparently, and then I don't expect the CPU to update individual bits as
that would defeat the purpose. So I'd expect it will either set them all to
active when forming the larger TLB entry, or set them on a single subpage
and leave the rest at whatever state they were. Hm I wonder if the exact
behavior is defined anywhere.

>> > For the third case, in contrast, the parent had already established
>> > an appropriate size folio to use for this VMA before calling fork().
>> > Whether it is the parent or the child causing the COW, it should probably
>> > inherit that choice and we should default to the same size folio that
>> > was already found.
>> 
>> Actually this is not what THP does now. The current THP behavior is to
>> split the PMD then fallback to order-0 page fault. For smaller orders,
>> we may consider allocating a large folio.
> 
> I know it's not what THP does now.  I think that's because the gap
> between PMD and PAGE size is too large and we end up wasting too much
> memory.  We also have very crude mechanisms for determining when to
> use THPs.  With the adaptive mechanism I described above, I think it's
> time to change that.
> 
> 

