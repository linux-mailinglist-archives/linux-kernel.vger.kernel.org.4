Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D9886A9887
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 14:36:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230521AbjCCNgk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 08:36:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230157AbjCCNgg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 08:36:36 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C09C83D919
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 05:36:28 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 67CBA22CF1;
        Fri,  3 Mar 2023 13:36:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1677850587; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ldNbB431e/ZrOzvtR232Ztvv4QdqleBsDZOUWRjloKA=;
        b=jfzbGUGtzuxxk/XkFN/jS61VUNyh3TiopbWLoZ0hI2G91eVu6KAArbMUGz/AW1haNkrR8g
        dlCq/ANRqrB4GGAa9s68n79xTrPckDOMgc10dukYtGI0gQ7/xEm6tvPWp8uLbQjG1w+oDR
        L+TAGHmLqVd2Bvv0T/X5aVDWU4d95sQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1677850587;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ldNbB431e/ZrOzvtR232Ztvv4QdqleBsDZOUWRjloKA=;
        b=15qFMsVz58cvQ2nl6DWCa7NNpMEbBCW1jHU1o/xpXMTB5lAic7Iq8NyYVyj4Bmmj0lfHQr
        lD+R2vNTyhDxypBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 51D9F1329E;
        Fri,  3 Mar 2023 13:36:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id yr84E9v3AWT2egAAMHmgww
        (envelope-from <vbabka@suse.cz>); Fri, 03 Mar 2023 13:36:27 +0000
Message-ID: <8f4793ac-c283-8a23-4aff-ef9d7d5994bd@suse.cz>
Date:   Fri, 3 Mar 2023 14:36:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] mm, page_alloc: batch cma update on pcp buffer refill
To:     Alexander Halbuer <halbuer@sra.uni-hannover.de>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
References: <20230217120504.87043-1-halbuer@sra.uni-hannover.de>
 <89778da7-74a3-2f2a-1668-afe7b15487dc@suse.cz>
 <0952ab0d-d640-decb-2f20-57881e45ab52@sra.uni-hannover.de>
Content-Language: en-US
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <0952ab0d-d640-decb-2f20-57881e45ab52@sra.uni-hannover.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/3/23 13:52, Alexander Halbuer wrote:
> On 2/21/23 11:27, Vlastimil Babka wrote:
>> Incidentally, did you observe any improvements by [2] with your test,
>> especially as the batch freeing side also no longer does checking under zone
>> lock?
>> 
>> Thanks!
>> 
> 
> I finally managed to repeat the benchmark to see the effects of
> disabling alloc and free sanity checks by default ("mm, page_alloc:
> reduce page alloc/free sanity checks"; results below).

Thanks for the measurements!

> Average huge page allocation latency drastically reduces by over 90% in
> the single core case. However i can't see any real improvements for the
> free operation.

Ah, I see now why huge page freeing didn't improve. It's because
bulkfree_pcp_prepare() was calling free_page_is_bad(page) thus checking just
the head page. So the tail pages were not actually checked. Just another
detail of how the checking wasn't thorough anyway.

> ---
> 
> Measurement results for the batch allocation benchmark for different
> core counts: Internally used functions are alloc_pages_node() for
> allocation (get) and __free_pages() for free (put).
> 
> Compared kernel versions are from the mm-unstable branch:
> - Reference version (without the mentioned patch):
> daf4bcbf2b72 ("mm: cma: make kobj_type structure constant")
> - Patched version:
> 60114678f165 ("mm-page_alloc-reduce-page-alloc-free-sanity-checks-fix")
> 
> Normale pages
> +-------+------+-------+---------+------+-------+---------+
> | cores | base | patch |    diff | base | patch |  diff   |
> |       |  get |   get |     get |  put |   put |   put   |
> |       | (ns) |  (ns) |         | (ns) |  (ns) |         |
> +-------+------+-------+---------+------+-------+---------+
> |     1 |  122 |   118 | (-3.3%) |  118 |   116 | (-1.7%) |
> |     2 |  133 |   130 | (-2.3%) |  130 |   123 | (-5.4%) |
> |     3 |  136 |   132 | (-2.9%) |  175 |   162 | (-7.4%) |
> |     4 |  161 |   149 | (-7.5%) |  241 |   226 | (-6.2%) |
> |     6 |  247 |   228 | (-7.7%) |  366 |   344 | (-6.0%) |
> |     8 |  331 |   304 | (-8.2%) |  484 |   456 | (-5.8%) |
> |    10 |  416 |   390 | (-6.2%) |  615 |   578 | (-6.0%) |
> |    12 |  502 |   472 | (-6.0%) |  727 |   687 | (-5.5%) |
> |    14 |  584 |   552 | (-5.5%) |  862 |   816 | (-5.3%) |
> |    16 |  669 |   632 | (-5.5%) |  967 |   923 | (-4.6%) |
> |    20 |  833 |   787 | (-5.5%) | 1232 |  1164 | (-5.5%) |
> |    24 |  999 |   944 | (-5.5%) | 1462 |  1384 | (-5.3%) |
> +-------+------+-------+---------+------+-------+---------+
> 
> Huge Pages
> +-------+------+-------+----------+-------+-------+---------+
> | cores | base | patch |     diff |  base | patch |  diff   |
> |       |  get |   get |      get |   put |   put |   put   |
> |       | (ns) |  (ns) |          |  (ns) |  (ns) |         |
> +-------+------+-------+----------+-------+-------+---------+
> |     1 | 3148 |   177 | (-94.4%) |  2946 |  2872 | (-2.5%) |
> |     2 | 3404 |   596 | (-82.5%) |  3318 |  3306 | (-0.4%) |
> |     3 | 3581 |   950 | (-73.5%) |  3401 |  3358 | (-1.3%) |
> |     4 | 3651 |  1284 | (-64.8%) |  3562 |  3616 | (1.5%)  |
> |     6 | 3568 |  1929 | (-45.9%) |  4478 |  4564 | (1.9%)  |
> |     8 | 3605 |  2328 | (-35.4%) |  5658 |  5546 | (-2.0%) |
> |    10 | 4093 |  2935 | (-28.3%) |  6758 |  6457 | (-4.5%) |
> |    12 | 4778 |  3540 | (-25.9%) |  7698 |  7565 | (-1.7%) |
> |    14 | 5565 |  4097 | (-26.4%) |  8748 |  8810 | (0.7%)  |
> |    16 | 6364 |  4725 | (-25.8%) |  9942 | 10103 | (1.6%)  |
> |    20 | 8014 |  5915 | (-26.2%) | 12509 | 12772 | (2.1%)  |
> |    24 | 8732 |  7138 | (-18.3%) | 15217 | 15433 | (1.4%)  |
> +-------+------+-------+----------+-------+-------+---------+
> 
>>>
>>> [1] https://lore.kernel.org/lkml/1d468148-936f-8816-eb71-1662f2d4945b@suse.cz/
>>> [2] https://lore.kernel.org/linux-mm/20230216095131.17336-1-vbabka@suse.cz/

