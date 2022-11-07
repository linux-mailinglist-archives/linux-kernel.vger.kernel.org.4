Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60DD261F7DC
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 16:41:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232926AbiKGPlM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 10:41:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232267AbiKGPlL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 10:41:11 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0136F01E
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 07:41:09 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 660DA1F86C;
        Mon,  7 Nov 2022 15:41:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1667835668; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WqBY47TvUH1dvtSu8SBNelarM/9OKGyt4h0zT41CUVM=;
        b=qNqUVG75BJt1bm99q72Pq3B/A7r/E+YucWOeV+VHxz3GREf20Zo/rk1vnqyrFSgOtIXXUu
        gIJYbInNNAxW/SXFFVKZqyVui8e1MKtK9sj35dlzXC8adNzv1tMDiJDPtfkEGEKpVoeWiC
        ZRlpEN+Hgu+y6g6vMiDtlcjwUIUyfcI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1667835668;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WqBY47TvUH1dvtSu8SBNelarM/9OKGyt4h0zT41CUVM=;
        b=Zo2UNhuBcQjBz+7pFX65zMWGBt269DOBhicmohatji+6xycj0/yF+69GOVOQAFRlmBZaBq
        QgCot0Lb91FCcwDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3676913494;
        Mon,  7 Nov 2022 15:41:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id AI6PDBQnaWMWMQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Mon, 07 Nov 2022 15:41:08 +0000
Message-ID: <66279414-6cc5-d4a4-176e-a75ba7d36037@suse.cz>
Date:   Mon, 7 Nov 2022 16:41:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH V5] mm: fix use-after free of page_ext after race with
 memory-offline
Content-Language: en-US
To:     Charan Teja Kalla <quic_charante@quicinc.com>,
        akpm@linux-foundation.org, mhocko@suse.com, david@redhat.com,
        pasha.tatashin@soleen.com, shakeelb@google.com, sieberf@amazon.com,
        sjpark@amazon.de, william.kucharski@oracle.com,
        willy@infradead.org, quic_pkondeti@quicinc.com, minchan@google.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <1661496993-11473-1-git-send-email-quic_charante@quicinc.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <1661496993-11473-1-git-send-email-quic_charante@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/26/22 08:56, Charan Teja Kalla wrote:
> The below is one path where race between page_ext and  offline of the
> respective memory blocks will cause use-after-free on the access of
> page_ext structure.
> 
> process1		              process2
> ---------                             ---------
> a)doing /proc/page_owner           doing memory offline
> 			           through offline_pages.
> 
> b)PageBuddy check is failed
> thus proceed to get the
> page_owner information
> through page_ext access.
> page_ext = lookup_page_ext(page);
> 
> 				    migrate_pages();
> 				    .................
> 				Since all pages are successfully
> 				migrated as part of the offline
> 				operation,send MEM_OFFLINE notification
> 				where for page_ext it calls:
> 				offline_page_ext()-->
> 				__free_page_ext()-->
> 				   free_page_ext()-->
> 				     vfree(ms->page_ext)
> 			           mem_section->page_ext = NULL
> 
> c) Check for the PAGE_EXT flags
> in the page_ext->flags access
> results into the use-after-free(leading
> to the translation faults).
> 
> As mentioned above, there is really no synchronization between page_ext
> access and its freeing in the memory_offline.
> 
> The memory offline steps(roughly) on a memory block is as below:
> 1) Isolate all the pages
> 2) while(1)
>   try free the pages to buddy.(->free_list[MIGRATE_ISOLATE])
> 3) delete the pages from this buddy list.
> 4) Then free page_ext.(Note: The struct page is still alive as it is
> freed only during hot remove of the memory which frees the memmap, which
> steps the user might not perform).
> 
> This design leads to the state where struct page is alive but the struct
> page_ext is freed, where the later is ideally part of the former which
> just representing the page_flags (check [3] for why this design is
> chosen).
> 
> The above mentioned race is just one example __but the problem persists
> in the other paths too involving page_ext->flags access(eg:
> page_is_idle())__.
> 
> Fix all the paths where offline races with page_ext access by
> maintaining synchronization with rcu lock and is achieved in 3 steps:
> 1) Invalidate all the page_ext's of the sections of a memory block by
> storing a flag in the LSB of mem_section->page_ext.
> 
> 2) Wait till all the existing readers to finish working with the
> ->page_ext's with synchronize_rcu(). Any parallel process that starts
> after this call will not get page_ext, through lookup_page_ext(), for
> the block parallel offline operation is being performed.
> 
> 3) Now safely free all sections ->page_ext's of the block on which
> offline operation is being performed.
> 
> Note: If synchronize_rcu() takes time then optimizations can be done in
> this path through call_rcu()[2].
> 
> Thanks to David Hildenbrand for his views/suggestions on the initial
> discussion[1] and Pavan kondeti for various inputs on this patch.
> 
> [1] https://lore.kernel.org/linux-mm/59edde13-4167-8550-86f0-11fc67882107@quicinc.com/
> [2] https://lore.kernel.org/all/a26ce299-aed1-b8ad-711e-a49e82bdd180@quicinc.com/T/#u
> [3] https://lore.kernel.org/all/6fa6b7aa-731e-891c-3efb-a03d6a700efa@redhat.com/
> 
> Suggested-by: David Hildenbrand <david@redhat.com>
> Suggested-by: Michal Hocko <mhocko@suse.com>
> Signed-off-by: Charan Teja Kalla <quic_charante@quicinc.com>

Hi, looks like this added a new warning to a previously clean "make W=1 mm/"
build:
mm/page_ext.c:178: warning: Function parameter or member 'page_ext' not
described in 'page_ext_put'

Can you fixup please?
