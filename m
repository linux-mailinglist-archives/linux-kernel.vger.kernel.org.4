Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F4C4673588
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 11:32:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230212AbjASKcm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 05:32:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbjASKcj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 05:32:39 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35AC9E8
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 02:32:38 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id E584B5CC34;
        Thu, 19 Jan 2023 10:32:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1674124356; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Tegevk4l6eSAVcZhXnC6lhrFkkCioF18pmZkx/QMwxI=;
        b=Es6O2oAVkAEqFiIdqT+svJN6AueN7ixIB4oXi+Gf4j8u2FQwi8O9dHU20bnTWLOOSgFBpC
        Px1Oa8a7f6c8HyRHu8X5z9qY0tDXWqhaI5dfS7I+6qAxEDPJKFZoop0kmELlHk/XFJczW3
        I+2VpMwQmUsMyrzKqFegwRE6s6UmV/8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1674124356;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Tegevk4l6eSAVcZhXnC6lhrFkkCioF18pmZkx/QMwxI=;
        b=ZOZTb1xywmP4Ivu22dC+fS2VcRg7Epu4N+/9ViuwvDjwkOpVMDQYmEMfg2BcLlmj1gGVad
        lnvxKCplItVQtfDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BB0D5139ED;
        Thu, 19 Jan 2023 10:32:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id y59NLEQcyWNRIAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Thu, 19 Jan 2023 10:32:36 +0000
Message-ID: <6e9e406a-8a94-4e34-9e5e-f4bb3a321b4e@suse.cz>
Date:   Thu, 19 Jan 2023 11:32:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCHv4 2/2] mm: use stack_depot_early_init for kmemleak
Content-Language: en-US
To:     "zhaoyang.huang" <zhaoyang.huang@unisoc.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Zhaoyang Huang <huangzhaoyang@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, ke.wang@unisoc.com,
        Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
References: <1674091345-14799-1-git-send-email-zhaoyang.huang@unisoc.com>
 <1674091345-14799-2-git-send-email-zhaoyang.huang@unisoc.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <1674091345-14799-2-git-send-email-zhaoyang.huang@unisoc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/19/23 02:22, zhaoyang.huang wrote:
> From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> 
> Mirsad report bellow error which caused by stack_depot_init failed in kvcalloc.
> Solve this by having stackdepot use stack_depot_early_init.
> 
> On 1/4/23 17:08, Mirsad Goran Todorovac wrote:
> I hate to bring bad news again, but there seems to be a problem with the output of /sys/kernel/debug/kmemleak:
> 
> [root@pc-mtodorov ~]# cat /sys/kernel/debug/kmemleak
> unreferenced object 0xffff951c118568b0 (size 16):
> comm "kworker/u12:2", pid 56, jiffies 4294893952 (age 4356.548s)
> hex dump (first 16 bytes):
>     6d 65 6d 73 74 69 63 6b 30 00 00 00 00 00 00 00 memstick0.......
>     backtrace:
> [root@pc-mtodorov ~]#
> 
> Apparently, backtrace of called functions on the stack is no longer printed with the list of memory leaks.
> This appeared on Lenovo desktop 10TX000VCR, with AlmaLinux 8.7 and BIOS version M22KT49A (11/10/2022)
> and 6.2-rc1 and 6.2-rc2 builds.
> This worked on 6.1 with the same CONFIG_KMEMLEAK=y and MGLRU enabled on a vanilla mainstream kernel
> from Mr. Torvalds' tree. I don't know if this is deliberate feature for some reason or a bug.
> Please find attached the config, lshw and kmemleak output.

I think we could replace the full quote of the report with

Link: https://lore.kernel.org/all/5272a819-ef74-65ff-be61-4d2d567337de@alu.unizg.hr/

also

Fixes: 56a61617dd22 ("mm: use stack_depot for recording kmemleak's backtrace")

(Andrew can do that when picking up, no need to send v5)

> reported-by: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
> suggested-by: Vlastimil Babka <vbabka@suse.cz>
> Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

But to be cleaner I'd also suggest Andrew adds the hunk below. The call
to stack_depot_init() becomes no-op after this patch so it's not a bug
to leave it there, but it's just misleading now.

---8<---
diff --git a/mm/kmemleak.c b/mm/kmemleak.c
index 91dda5c2753a..55dc8b8b0616 100644
--- a/mm/kmemleak.c
+++ b/mm/kmemleak.c
@@ -2095,7 +2095,6 @@ void __init kmemleak_init(void)
 	if (kmemleak_error)
 		return;
 
-	stack_depot_init();
 	jiffies_min_age = msecs_to_jiffies(MSECS_MIN_AGE);
 	jiffies_scan_wait = msecs_to_jiffies(SECS_SCAN_WAIT * 1000);
 

