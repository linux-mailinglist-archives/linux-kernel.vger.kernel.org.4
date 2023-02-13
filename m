Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3243E6942B3
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 11:20:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231164AbjBMKUp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 05:20:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231163AbjBMKUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 05:20:42 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F4A11204D
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 02:20:25 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id C294321B50;
        Mon, 13 Feb 2023 10:20:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1676283604; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=65fYUfn3GoYatis0AOVMTqKcL936aMO9+NoqSfIfToQ=;
        b=Fu364rm9KUi8b+3WvUXBzcLcIjXuTDL9Y8K0UMaaTiQwhCL4W5JLNS7WbffJwJOcrweRXQ
        zEH68wp/IRvZoiTGcY8tWJrVGnOiTHiAOY4neyumgBHCWeT2WjV7GV0nKPT4tw19uty1Y2
        JCjWkqenzBAsVQJCdSH7LDHIIoP3Auo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1676283604;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=65fYUfn3GoYatis0AOVMTqKcL936aMO9+NoqSfIfToQ=;
        b=SkqO1DutFCx14kbC1Q7atPUivyZgNfDk87+cjTD/AzkRXy8Bc5kXe1ljtTQBUCIWuB8pWe
        KMVMKTHLPxE1VPAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 98127138E6;
        Mon, 13 Feb 2023 10:20:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id XK5CJNQO6mOpdwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Mon, 13 Feb 2023 10:20:04 +0000
Message-ID: <2085e953-ff9d-4d2e-cb35-24383592f2c4@suse.cz>
Date:   Mon, 13 Feb 2023 11:20:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2 09/18] lib/stackdepot: rename slab to pool
Content-Language: en-US
To:     andrey.konovalov@linux.dev, Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>
Cc:     Andrey Konovalov <andreyknvl@gmail.com>,
        kasan-dev@googlegroups.com, Evgenii Stepanov <eugenis@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
References: <cover.1676063693.git.andreyknvl@google.com>
 <923c507edb350c3b6ef85860f36be489dfc0ad21.1676063693.git.andreyknvl@google.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <923c507edb350c3b6ef85860f36be489dfc0ad21.1676063693.git.andreyknvl@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/10/23 22:15, andrey.konovalov@linux.dev wrote:
> From: Andrey Konovalov <andreyknvl@google.com>
> 
> Use "pool" instead of "slab" for naming memory regions stack depot
> uses to store stack traces. Using "slab" is confusing, as stack depot
> pools have nothing to do with the slab allocator.
> 
> Also give better names to pool-related global variables: change
> "depot_" prefix to "pool_" to point out that these variables are
> related to stack depot pools.
> 
> Also rename the slabindex (poolindex) field in handle_parts to pool_index
> to align its name with the pool_index global variable.
> 
> No functional changes.
> 
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

Thanks!

