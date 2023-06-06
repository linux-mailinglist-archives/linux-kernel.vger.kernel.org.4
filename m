Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B12DD724DD4
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 22:15:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238804AbjFFUPp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 16:15:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234226AbjFFUPm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 16:15:42 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E6099E
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 13:15:40 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 303A71FD8C;
        Tue,  6 Jun 2023 20:15:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1686082539; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GRdaNaKr0mVo9Z+XRAEpnMDkFT3nh/DoMeZkPYisvDM=;
        b=ioC/quvRSy7NIVr6dNWhuWtynvA0QHib3x3S1200yPrmXu2hDy+rvxNYTFGDhG7eKVL3vP
        bTDfDeW4uGxoFQVUVijBy/FNL/9x29uPcy7FJHUXN45DEF8OyNwrbO7+KSiMmmv4moTaZ8
        Iv6s8+xTPSPSSRjcvDa3HluXs9GpxIs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1686082539;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GRdaNaKr0mVo9Z+XRAEpnMDkFT3nh/DoMeZkPYisvDM=;
        b=di+1KcQGyUMmvlbPmv74BZ6926czHaKCgvmzYYBCsAS/yPE5NoWqPz1hcrz7+wV9ZUpM1G
        aXnFibq0THq8DYAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EEB1E13776;
        Tue,  6 Jun 2023 20:15:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id q0y8OeqTf2RPJwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Tue, 06 Jun 2023 20:15:38 +0000
Message-ID: <6403a950-7367-0b00-8cd5-2f0a32dac953@suse.cz>
Date:   Tue, 6 Jun 2023 22:15:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: RFC for new feature to move pages from one vma to another without
 split
To:     Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>
Cc:     Lokesh Gidra <lokeshgidra@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Brian Geffon <bgeffon@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Kalesh Singh <kaleshsingh@google.com>,
        Nicolas Geoffray <ngeoffray@google.com>,
        Jared Duke <jdduke@google.com>,
        android-mm <android-mm@google.com>,
        Blake Caldwell <blake.caldwell@colorado.edu>,
        Mike Rapoport <rppt@kernel.org>
References: <CA+EESO4uO84SSnBhArH4HvLNhaUQ5nZKNKXqxRCyjniNVjp0Aw@mail.gmail.com>
 <ZC8BgFSFC3cDcAcS@x1n> <27ac2f51-e2bf-7645-7a76-0684248a5902@redhat.com>
 <ZDbVMk0trT5UaqaA@x1n> <3059388f-1604-c326-c66f-c2e0f9bb6cbf@redhat.com>
 <ZDghhTH2KtCeAwcZ@x1n>
Content-Language: en-US
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <ZDghhTH2KtCeAwcZ@x1n>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/13/23 17:36, Peter Xu wrote:
> On Thu, Apr 13, 2023 at 10:10:44AM +0200, David Hildenbrand wrote:
>> So instead, we consider the whole address space as a virtual, anon file,
>> starting at offset 0. The pgoff of a VMA is then simply the offset in that
>> virtual file (easily computed from the start of the VMA), and VMA merging is
>> just the same as for an ordinary file.
> 
> Interesting point, thanks!

FYI, I've advised a master thesis exploring how to update page->index during
mremap() to keep things mergeable:

https://dspace.cuni.cz/bitstream/handle/20.500.11956/176288/120426800.pdf

I think the last RFC posting was:
https://lore.kernel.org/all/20220516125405.1675-1-matenajakub@gmail.com/

It was really tricky for the general case. Maybe it would be more feasible
for the limited case Lokesh describes, if we could be sure the pages that
are moved aren't mapped anywhere else.
