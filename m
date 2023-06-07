Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 180D0725D62
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 13:40:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240370AbjFGLkG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 07:40:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239236AbjFGLkE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 07:40:04 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC64519BB
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 04:39:59 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 16F86219D1;
        Wed,  7 Jun 2023 11:39:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1686137998; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=07E35V9kNUmXqLvBB2GO14KIXcwkI2HegjgZefJoCH0=;
        b=S5ulmEud2BFCkU6rfAnte9QtdDxYs7ln9Vky6zPsnXe7iBRVNGjqozmxHAJ6qDS4xknGuZ
        qLiy2ftbSjznAFol73INN4t/rWVka3CuzXO/T/lwYvXQjJ8JBPrvzAfwLYmM6iQpOAjgSB
        AMR0Eq5XakLR0PM+tKiNh62tDMLVA7M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1686137998;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=07E35V9kNUmXqLvBB2GO14KIXcwkI2HegjgZefJoCH0=;
        b=rHATyk8i8jCdRsh1kbsEtKVh/QxIFx4XAk8S2dKWZDGH0ZG2hCXLWoFg85BQKnjHBl14xF
        ZxJxpvDS9AaW4YDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D6E9513776;
        Wed,  7 Jun 2023 11:39:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id UlksM41sgGSMKgAAMHmgww
        (envelope-from <vbabka@suse.cz>); Wed, 07 Jun 2023 11:39:57 +0000
Message-ID: <8701bb94-07c4-f552-aecd-0a6a2621f5ab@suse.cz>
Date:   Wed, 7 Jun 2023 13:40:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v4 0/2] mm/slab: trivial fixup for SLAB_TYPESAFE_BY_RCU
 example code snippet
Content-Language: en-US
To:     SeongJae Park <sj@kernel.org>, akpm@linux-foundation.org
Cc:     willy@infradead.org, paulmck@kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20230417190450.1682-1-sj@kernel.org>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20230417190450.1682-1-sj@kernel.org>
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


On 4/17/23 21:04, SeongJae Park wrote:
> Changes from v3
> (https://lore.kernel.org/linux-mm/20230417173238.22237-1-sj@kernel.org/)
> - Yet more wordsmith of the second patch's commit message
>   (Matthew Wilcox)
> 
> Changes from v2
> (https://lore.kernel.org/linux-mm/20230415033159.4249-1-sj@kernel.org/)
> - Wordsmith commit message of the second patch (Valstimil Babka)
> 
> Changes from v1
> (https://lore.kernel.org/linux-mm/20230415003754.1852-1-sj@kernel.org/)
> - Update label (s/again/begin/) correctly (Matthew Wilcox)
> - Add missed rcu_read_unlock()
> 
> This patchset is for trivial fixup for SLAB_TYPESAFE_BY_RCU example code
> snippet, namely adding missed semicolon and breaking RCU read-side
> critical section into smaller ones.

Oops, almost forgot to merge this, now done, with Paul's R-b's, in
slab/for-6.5/cleanup. Thanks!

> SeongJae Park (2):
>   mm/slab: add a missing semicolon on SLAB_TYPESAFE_BY_RCU example code
>   mm/slab: break up RCU readers on SLAB_TYPESAFE_BY_RCU example code
> 
>  include/linux/slab.h | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
