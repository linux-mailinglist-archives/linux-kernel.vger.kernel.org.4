Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D8BD62550C
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 09:16:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233143AbiKKIQh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 03:16:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233116AbiKKIQf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 03:16:35 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 882FD70182
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 00:16:34 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 3E5342206E;
        Fri, 11 Nov 2022 08:16:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1668154593; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=K3QYJ2EXLu+u4WaeAKt86AUgaddU0ZJc+TTeHOeCaKA=;
        b=fIwWWpAIyj7U9UnoGnRTbdzv7YFcNdZZEZFW5YCn8mKWbZVwQwg9LKYknIjSs9Cn1HH1nl
        05Y4lnKWcvcHhQbDJY1Up4AEmucMbMmecAsNmhXBlrH3tJ0/6wKYYtoHrOd+tZA/jUugS8
        ClFqwgCbRg7rEFM9dIH8uiw8klANw8Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1668154593;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=K3QYJ2EXLu+u4WaeAKt86AUgaddU0ZJc+TTeHOeCaKA=;
        b=eyv34fHRvuYKjWpuyugvAMN5DvJa1CvVCT4VqZT//+Dx3yu+z08RRkPj/kEWrZbfbSW8b/
        RtDZ4kOrgaICtwCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0EC6C13357;
        Fri, 11 Nov 2022 08:16:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id rJP3AuEEbmOuOQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Fri, 11 Nov 2022 08:16:33 +0000
Message-ID: <f9da0749-c109-1251-8489-de3cfb50ab24@suse.cz>
Date:   Fri, 11 Nov 2022 09:16:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v7 0/3] mm/slub: extend redzone check for kmalloc objects
Content-Language: en-US
To:     Feng Tang <feng.tang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Kees Cook <keescook@chromium.org>
Cc:     Dave Hansen <dave.hansen@intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com
References: <20221021032405.1825078-1-feng.tang@intel.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20221021032405.1825078-1-feng.tang@intel.com>
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

On 10/21/22 05:24, Feng Tang wrote:
> kmalloc's API family is critical for mm, and one of its nature is that
> it will round up the request size to a fixed one (mostly power of 2).
> When user requests memory for '2^n + 1' bytes, actually 2^(n+1) bytes
> could be allocated, so there is an extra space than what is originally
> requested.
> 
> This patchset tries to extend the redzone sanity check to the extra
> kmalloced buffer than requested, to better detect un-legitimate access
> to it. (dependson SLAB_STORE_USER & SLAB_RED_ZONE)
> 
> The redzone part has been tested with code below:
> 
> 	for (shift = 3; shift <= 12; shift++) {
> 		size = 1 << shift;
> 		buf = kmalloc(size + 4, GFP_KERNEL);
> 		/* We have 96, 196 kmalloc size, which is not power of 2 */
> 		if (size == 64 || size == 128)
> 			oob_size = 16;
> 		else
> 			oob_size = size - 4;
> 		memset(buf + size + 4, 0xee, oob_size);
> 		kfree(buf);
> 	}

Sounds like a new slub_kunit test would be useful? :) doesn't need to be
that exhaustive wrt all sizes, we could just pick one and check that a write
beyond requested kmalloc size is detected?

Thanks!

