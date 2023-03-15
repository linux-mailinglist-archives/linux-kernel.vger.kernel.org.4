Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 474A16BADC6
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 11:36:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231862AbjCOKgV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 06:36:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231955AbjCOKgO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 06:36:14 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C48D4C3A
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 03:35:59 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id CCA1D219A2;
        Wed, 15 Mar 2023 10:35:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1678876557; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tkpLVVJ1d4eh1HuKB17Mt7JaB4xH9HKPot13nPCRvZ8=;
        b=oyZZPiSiUXGycdwo9hTvUM0QnEl+9gQKUsu2PyEdHpRViu4a2fplsJ2K139hm1iwQT4ub7
        kEVSk32Is3nUdSmLCBUrNLZhyl2u0ZWEQpYl33vZ8Zw99SkULTkiY9VRc36IzcKng82qpU
        M6OpViYTsnla3oOu5jBYGqelOPaYkSw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1678876557;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tkpLVVJ1d4eh1HuKB17Mt7JaB4xH9HKPot13nPCRvZ8=;
        b=WhBiiLRmUnPZ+v9rMKBVG5N0VQm9zpHKosuKfyhvcgspUj03NCFjQyBKagFWNBuST/zFTV
        2JJ4EoBpjFr61zBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9F7CB13A00;
        Wed, 15 Mar 2023 10:35:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id OTOSJY2fEWRlTQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Wed, 15 Mar 2023 10:35:57 +0000
Message-ID: <5216bb3e-1249-a051-c1b3-2dd3a63cfdd2@suse.cz>
Date:   Wed, 15 Mar 2023 11:35:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] mm: prefer xxx_page() alloc/free functions for order-0
 pages
Content-Language: en-US
To:     Lorenzo Stoakes <lstoakes@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        David Hildenbrand <david@redhat.com>,
        Nick Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Uladzislau Rezki <urezki@gmail.com>,
        Christoph Hellwig <hch@infradead.org>
References: <50c48ca4789f1da2a65795f2346f5ae3eff7d665.1678710232.git.lstoakes@gmail.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <50c48ca4789f1da2a65795f2346f5ae3eff7d665.1678710232.git.lstoakes@gmail.com>
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

On 3/13/23 13:27, Lorenzo Stoakes wrote:
> Update instances of alloc_pages(..., 0), __get_free_pages(..., 0) and
> __free_pages(..., 0) to use alloc_page(), __get_free_page() and
> __free_page() respectively in core code.
> 
> Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

