Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF64F6384C3
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 08:50:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbiKYHun (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 02:50:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiKYHul (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 02:50:41 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F2B01BEBB;
        Thu, 24 Nov 2022 23:50:37 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 0D86E21AE4;
        Fri, 25 Nov 2022 07:50:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1669362636; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nvdAlIgOG5yqCLw/uf3CjVt0knMtHQ2HViq7mDKGha0=;
        b=UfA+KLDHvqCfxZkPL8VzkpPT/Fhn6znGTJkr9TAm8Df/6osHNjpPZL3bpjXCNW9Y6CO+bV
        55yDsVYkDD1XCL4UB9UYWsXIiUbxJpK1nR1ijkPRl3MAS0DNrX3yo0Osn0cL7Uhod8zhw2
        6Jmj/Fl9CPemw02qixisQW8yEpz74O8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1669362636;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nvdAlIgOG5yqCLw/uf3CjVt0knMtHQ2HViq7mDKGha0=;
        b=hFbVrf2fTew+nsw0hgcUxNXADJWFG/z1U07cXA+HsRBXofEjbI5gIqoncmK8d81yaEwaT8
        DibuSqZrI/DVt/AA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E840413A08;
        Fri, 25 Nov 2022 07:50:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id kKr+N8tzgGMTFgAAMHmgww
        (envelope-from <vbabka@suse.cz>); Fri, 25 Nov 2022 07:50:35 +0000
Message-ID: <14bd73b0-5480-2b35-7b89-161075d9f444@suse.cz>
Date:   Fri, 25 Nov 2022 08:50:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: linux-next: build failure after merge of the slab tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Marco Elver <elver@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>
References: <20221125124934.462dc661@canb.auug.org.au>
Content-Language: en-US
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20221125124934.462dc661@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/25/22 02:49, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the slab tree, today's linux-next build (x86_64
> allmodconfig) failed like this:
> 
> mm/slub.c:965:13: error: 'freelist_corrupted' defined but not used [-Werror=unused-function]
>   965 | static bool freelist_corrupted(struct kmem_cache *s, struct slab *slab,
>       |             ^~~~~~~~~~~~~~~~~~
> 
> Caused by commit
> 
>   f6e94ad44e77 ("mm, slub: remove percpu slabs with CONFIG_SLUB_TINY")
> 
> I have used the slab tree from next-20221123 again.

I tried the allmodconfig and:

WARNING: unmet direct dependencies detected for SLUB_DEBUG
  Depends on [n]: SLUB [=y] && SYSFS [=y] && !SLUB_TINY [=y]
  Selected by [y]:
  - KASAN_GENERIC [=y] && <choice> && HAVE_ARCH_KASAN [=y] && CC_HAS_KASAN_GENERIC [=y] && CC_HAS_WORKING_NOSANITIZE_ADDRESS [=y] && SLUB [=y]

Wasn't aware it's possible that it will leave a combination of configs
that's not allowed and just warn about it. Oh well.

I'll solve it by:
--- a/lib/Kconfig.kasan
+++ b/lib/Kconfig.kasan
@@ -37,7 +37,7 @@ menuconfig KASAN
                     (HAVE_ARCH_KASAN_SW_TAGS && CC_HAS_KASAN_SW_TAGS)) && \
                    CC_HAS_WORKING_NOSANITIZE_ADDRESS) || \
                   HAVE_ARCH_KASAN_HW_TAGS
-       depends on (SLUB && SYSFS) || (SLAB && !DEBUG_SLAB)
+       depends on (SLUB && SYSFS && !SLUB_TINY) || (SLAB && !DEBUG_SLAB)
        select STACKDEPOT_ALWAYS_INIT
        help
          Enables KASAN (Kernel Address Sanitizer) - a dynamic memory safety

