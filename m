Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 693336E5AF8
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 09:52:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231160AbjDRHwQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 03:52:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230467AbjDRHwO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 03:52:14 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62A4D72A9;
        Tue, 18 Apr 2023 00:51:45 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id A78F31F8D5;
        Tue, 18 Apr 2023 07:50:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1681804236; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=46e7WTGcHNks6sxTiebpVk6ExMfzEHXXE/aXkJusS5g=;
        b=uG1RAziSlvQ/AB6RQnxcNayvtDodqRrOp363Gas3XQAKfYeJPHa3904AfTgyYGI541gMah
        Oo0jHROGhui6HyXV9gYIf8RIPuSxbHVOhwE5XmOaKmnqwBTkLHM0b8dsHL4cKZgmMp8qzn
        c2Fpq7XO2GcRQuxTvj22KrhI3FzVSf4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1681804236;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=46e7WTGcHNks6sxTiebpVk6ExMfzEHXXE/aXkJusS5g=;
        b=6SHx2StO+Tcg6qDit+z9WzPQX0muMG1mdmG4QkhvSHTYHiXGL6rliQuS4Mq9yrRmecHD8j
        1L/LSMcbIoXjj0Dw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7327E139CC;
        Tue, 18 Apr 2023 07:50:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id EG1rG8xLPmRGbgAAMHmgww
        (envelope-from <vbabka@suse.cz>); Tue, 18 Apr 2023 07:50:36 +0000
Message-ID: <7dda08c3-4f51-7ab5-12af-3635302ffc63@suse.cz>
Date:   Tue, 18 Apr 2023 09:50:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 0/5] Some tiny clean ups for SLUB
Content-Language: en-US
To:     sxwjean@me.com, cl@linux.com, penberg@kernel.org,
        rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, roman.gushchin@linux.dev,
        42.hyeyoo@gmail.com, keescook@chromium.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        Xiongwei Song <xiongwei.song@windriver.com>
References: <20230413143452.211250-1-sxwjean@me.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20230413143452.211250-1-sxwjean@me.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/13/23 16:34, sxwjean@me.com wrote:
> From: Xiongwei Song <xiongwei.song@windriver.com>
> 
> Hi,
> 
> Just clean ups, no any functionality changed. Thanks for your time.

Thanks, added to slab.git for 6.5:

https://git.kernel.org/pub/scm/linux/kernel/git/vbabka/slab.git/log/?h=slab/for-6.5/cleanup

> Xiongwei Song (5):
>   slub: Correct the error code when slab_kset is NULL
>   slub: Put objects_show() into CONFIG_SLUB_DEBUG enabled block
>   slub: Remove CONFIG_SMP defined check
>   slub: Remove slabs_node() function
>   slub: Don't read nr_slabs and total_objects directly
> 
>  mm/slub.c | 45 +++++++++++++++++----------------------------
>  1 file changed, 17 insertions(+), 28 deletions(-)
> 

