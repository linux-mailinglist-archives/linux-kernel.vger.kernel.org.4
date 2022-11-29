Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC2BC63BFA9
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 13:04:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232238AbiK2MEZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 07:04:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233500AbiK2MDt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 07:03:49 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BFBE532DA
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 04:02:53 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id D21F021A9D;
        Tue, 29 Nov 2022 12:02:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1669723371; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=z/3hsjogRyiywNOtVq13TN6FozNI4uz7VCcPb28njoU=;
        b=qqpcbvqqo4tXUVc7mA+18PQYvRcs7oDUpGh/g3Up9IsTr804a/89Jyltjdt0zIJEFsGBZL
        UsLIyrtQcgG9dfy2KjHa8Ar0QoZgz5ZSycs4s5owWC1PuOg0+F3YPJIdktCFL+iUK0W2Yh
        jxLY53OWK5LF1Tv7U0fwPq+JKpUtHdw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1669723371;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=z/3hsjogRyiywNOtVq13TN6FozNI4uz7VCcPb28njoU=;
        b=UcQe1LxJo8la8OZ6DKqZjiM5CfBtE6Zb/LqKvfCRlOw5VE/1x5802P26oq+jYQSHBp+sfX
        rPgRrFVUpemBMDAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A54C013428;
        Tue, 29 Nov 2022 12:02:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id eSCJJ+v0hWNNfQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Tue, 29 Nov 2022 12:02:51 +0000
Message-ID: <d6c614fe-cc80-7a19-1fa6-2ed6cc75b705@suse.cz>
Date:   Tue, 29 Nov 2022 13:02:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2 2/2] mm/slub, kunit: Add a test case for kmalloc
 redzone check
Content-Language: en-US
To:     Marco Elver <elver@google.com>
Cc:     Feng Tang <feng.tang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oliver Glitta <glittao@gmail.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20221129063358.3012362-1-feng.tang@intel.com>
 <20221129063358.3012362-2-feng.tang@intel.com>
 <CANpmjNNkLWvNYUf-bPPDBcqFWegp3_NpYdhygvYU1dtT52m29g@mail.gmail.com>
 <67e6ebce-f8cc-7d28-5e85-8a3909c2d180@suse.cz>
 <CANpmjNNZhXX830jqPn9eaQZHwKhBb4b_PEuUdH6O69ELqW470w@mail.gmail.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <CANpmjNNZhXX830jqPn9eaQZHwKhBb4b_PEuUdH6O69ELqW470w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/29/22 12:48, Marco Elver wrote:
> On Tue, 29 Nov 2022 at 12:01, Vlastimil Babka <vbabka@suse.cz> wrote:
>>
>> On 11/29/22 10:31, Marco Elver wrote:
>> > On Tue, 29 Nov 2022 at 07:37, Feng Tang <feng.tang@intel.com> wrote:
> 
>> For SLAB_SKIP_KFENCE, we could also add the flag after creation to avoid
>> this trouble? After all there is a sysfs file to control it at runtime
>> anyway (via skip_kfence_store()).
>> In that case patch 1 would have to wrap kmem_cache_create() and the flag
>> addition with a new function to avoid repeating. That function could also be
>> adding SLAB_NO_USER_FLAGS to kmem_cache_create(), instead of the #define
>> DEFAULT_FLAGS.
> 
> I wouldn't overcomplicate it, all we need is a way to say "this flag
> should not be used directly" - and only have it available via an
> indirect step. Availability via sysfs is one such step.
> 
> And for tests, there are 2 options:
> 
> 1. we could provide a function "kmem_cache_set_test_flags(cache,
> gfp_flags)" and define SLAB_TEST_FLAGS (which would include
> SLAB_SKIP_KFENCE). This still allows to set it generally, but should
> make abuse less likely due to the "test" in the name of that function.
> 
> 2. just set it directly, s->flags |= SLAB_SKIP_KFENCE.
> 
> If you're fine with #2, that seems simplest and would be my preference.

Yeah, that's what I meant. But slub_kunit.c could still have own internal
cache creation function so the "|SLAB_NO_USER_FLAGS" and "s->flags |=
SLAB_SKIP_KFENCE" is not repeated X times.

> 
>> For SLAB_KMALLOC there's probably no such way unless we abuse the internal
>> APIs even more and call e.g. create_boot_cache() instead of
>> kmem_cache_create(). But that one is __init, so probably not. If we do
>> instead allow the flag, I wouldn't add it to SLAB_CORE_FLAGS but rather
>> SLAB_CACHE_FLAGS and SLAB_FLAGS_PERMITTED.
> 
> I'd probably go with the simplest solution here.

Agreed.
