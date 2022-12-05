Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DB716437CD
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 23:13:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232748AbiLEWNR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 17:13:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230254AbiLEWNP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 17:13:15 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24A011A4
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 14:13:14 -0800 (PST)
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id C467721BF4;
        Mon,  5 Dec 2022 22:13:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1670278392; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VoAnhUb0oelaApjHcv+l7NCW5POXG2u/N59IC5DVgok=;
        b=rImC6wY5zHJCAqTTD5LYBhzeqMUbWNe25UIxKTmpQNRXMYDyoCHSfJQRlMbH+6nP7H+V7M
        DYK/S99Jdt0W+kYagHNbs6pRjR4M9fgvBEqhmxR0kYeN8WSN7m6H663tDPZHKAeKqhr3OQ
        t8gh/eae/xa1IrW6zP4lhNrfSdhsTis=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1670278392;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VoAnhUb0oelaApjHcv+l7NCW5POXG2u/N59IC5DVgok=;
        b=dNh7tcCc/DDvCHpndefZPOn6AlPa0huoMsUK3ihPtr1ozJDoaOpwjm0nug5fnILmFsJlDI
        nEbgafmFrhnUZXDg==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 9222813326;
        Mon,  5 Dec 2022 22:13:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id 3vPqIvhsjmObcAAAGKfGzw
        (envelope-from <vbabka@suse.cz>); Mon, 05 Dec 2022 22:13:12 +0000
Message-ID: <b1b80402-2c90-8006-bcf8-716e6ef719c2@suse.cz>
Date:   Mon, 5 Dec 2022 23:13:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v2] mmap: Fix do_brk_flags() modifying obviously incorrect
 VMAs
To:     Jann Horn <jannh@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Liam Howlett <liam.howlett@oracle.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Yu Zhao <yuzhao@google.com>, Jason Donenfeld <Jason@zx2c4.com>,
        Matthew Wilcox <willy@infradead.org>,
        SeongJae Park <sj@kernel.org>
References: <20221205192304.1957418-1-Liam.Howlett@oracle.com>
 <20221205123250.3fc552d96fcca5dc58be8443@linux-foundation.org>
 <CAG48ez26s0R6DsPKJ1dUomwSwCfhWcpQD6Zb0GU0rbYcFD1hww@mail.gmail.com>
Content-Language: en-US
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <CAG48ez26s0R6DsPKJ1dUomwSwCfhWcpQD6Zb0GU0rbYcFD1hww@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/5/22 22:55, Jann Horn wrote:
> On Mon, Dec 5, 2022 at 9:32 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>> On Mon, 5 Dec 2022 19:23:17 +0000 Liam Howlett <liam.howlett@oracle.com> wrote:
>> > Add more sanity checks to the VMA that do_brk_flags() will expand.
>> > Ensure the VMA matches basic merge requirements within the function
>> > before calling can_vma_merge_after().
>>
>> I't unclear what's actually being fixed here.
>>
>> Why do you feel we need the above changes?
>>
>> > Drop the duplicate checks from vm_brk_flags() since they will be
>> > enforced later.
>> >
>> > Fixes: 2e7ce7d354f2 ("mm/mmap: change do_brk_flags() to expand existing VMA and add do_brk_munmap()")
>>
>> Fixes in what way?  Removing the duplicate checks?
> 
> The old code would expand file VMAs on brk(), which is functionally
> wrong and also dangerous in terms of locking because the brk() path
> isn't designed for file VMAs and therefore doesn't lock the file
> mapping. Checking can_vma_merge_after() ensures that new anonymous
> VMAs can't be merged into file VMAs.
> 
> See https://lore.kernel.org/linux-mm/CAG48ez1tJZTOjS_FjRZhvtDA-STFmdw8PEizPDwMGFd_ui0Nrw@mail.gmail.com/
> .

I guess the point is that if we fix it still within 6.1, we don't have to
devise how exactly this is exploitable, but due to the insufficient locking
it most likely is, right?
