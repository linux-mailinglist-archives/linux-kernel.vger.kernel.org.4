Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96529615260
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 20:36:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbiKATgD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 15:36:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbiKATgA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 15:36:00 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F4A71DDFF;
        Tue,  1 Nov 2022 12:35:58 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id ABF861F8BA;
        Tue,  1 Nov 2022 19:35:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1667331356; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Jc3GZbUnGicye2/jncE2VAeBO5z9oAX6w1xDyj0hRaI=;
        b=zxfEoNp7ByQJWbFfW/abgDH3V5Ms7cBMA7PHBEYuzp95JXxSnlsKV9HE48hNuYThLVm4d8
        pDUT0NS97pS9sleJdlH4HYB4TuKVZ0sW0UcxJDs6rj6RjjnVG/OYrQhOYfWNtJolbMgKYn
        42KRxuj4mYVHb7TJUD+FfYxMqVIuygI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1667331356;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Jc3GZbUnGicye2/jncE2VAeBO5z9oAX6w1xDyj0hRaI=;
        b=R81kdDAat9+Gy9w72WUdJdEEDk1kFsDH5uguOsuZGDmslkZx4I/62V9xhPiUKDalyvl3JQ
        ekfwdj+5mkwhYwAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6A11613AAF;
        Tue,  1 Nov 2022 19:35:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id g9MRGBx1YWOATwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Tue, 01 Nov 2022 19:35:56 +0000
Message-ID: <ab914e26-9b90-c878-dd47-f417b03212c5@suse.cz>
Date:   Tue, 1 Nov 2022 20:35:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v4] mempool: Do not use ksize() for poisoning
To:     Kees Cook <keescook@chromium.org>
Cc:     Anders Roxell <anders.roxell@linaro.org>,
        kernel test robot <oliver.sang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Marco Elver <elver@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        linux-mm@kvack.org, Andrey Konovalov <andreyknvl@gmail.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20221028154823.you.615-kees@kernel.org>
 <20221031105514.GB69385@mutt> <13c4bd6e-09d3-efce-43a5-5a99be8bc96b@suse.cz>
 <202211011014.02F2559@keescook>
Content-Language: en-US
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <202211011014.02F2559@keescook>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 11/1/22 18:15, Kees Cook wrote:
> On Mon, Oct 31, 2022 at 04:00:25PM +0100, Vlastimil Babka wrote:
>>  From a4a5a40852723dfadb2429bee1d5e1f9d3b75f39 Mon Sep 17 00:00:00 2001
>> From: Vlastimil Babka <vbabka@suse.cz>
>> Date: Mon, 31 Oct 2022 15:55:47 +0100
>> Subject: [PATCH] mempool: Do not use ksize() for poisoning-fix
>>
>> For slab mempools (not kmalloc), pool_data is not object size, but a
>> kmem_cache pointer; we need to extract the size via kmem_cache_size().
>>
>> Reported-by: Anders Roxell <anders.roxell@linaro.org>
>> Link: https://lore.kernel.org/all/20221031105514.GB69385@mutt/
>> Reported-by: kernel test robot <oliver.sang@intel.com>
>> Link: https://lore.kernel.org/oe-lkp/202210312110.1fe5d224-oliver.sang@intel.com
>> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> 
> Reviewed-by: Kees Cook <keescook@chromium.org>
> 
> Thanks again for fixing this. I don't see it in -next yet? Should I
> resend this directly, or how would be best to land it?

I think Andrew will add it from here, but maybe is waiting for Anders 
acknowledging that it fixes the bug for him?

> -Kees
> 

