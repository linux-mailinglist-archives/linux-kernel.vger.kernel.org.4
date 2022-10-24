Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC4A560B57A
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 20:28:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231991AbiJXS2i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 14:28:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230280AbiJXS2F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 14:28:05 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D2A696200;
        Mon, 24 Oct 2022 10:09:56 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id BEF5C22060;
        Mon, 24 Oct 2022 16:49:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1666630156; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4tbaQSlGeYJavYSi+3bPYagpChRAyG3trqPixSnTsnA=;
        b=EMwGDgTzLVJP3OIAz4qPm5nvY43h+mNraINUllgKEPSo1gH3bR8F/r0omRqeLmEL1DtWVS
        CrKOLdkzNC/wnFJr3849YVAtmfq81ada5Q1rbTW0JEyuQ5S+cGVPkoYMKwb/NFv6eRDtEH
        mBD+ixDLM5pJMtJlHAbxO2CyENyovew=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1666630156;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4tbaQSlGeYJavYSi+3bPYagpChRAyG3trqPixSnTsnA=;
        b=rgrHfqVMHQVzvF/LnK2bROvC940RkMuLs7S6bnnXRFVy046CDyebeQ9fsJ+EtB3ysDb6BD
        QOz86NIRtxxUwnAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 99BCC13A79;
        Mon, 24 Oct 2022 16:49:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 9TSqJAzCVmODbwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Mon, 24 Oct 2022 16:49:16 +0000
Message-ID: <46b5f4eb-76ac-718e-3b52-333bc55d0a3a@suse.cz>
Date:   Mon, 24 Oct 2022 18:49:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: amusing SLUB compaction bug when CC_OPTIMIZE_FOR_SIZE
Content-Language: en-US
From:   Vlastimil Babka <vbabka@suse.cz>
To:     Matthew Wilcox <willy@infradead.org>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc:     Hugh Dickins <hughd@google.com>,
        David Laight <David.Laight@aculab.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        rcu@vger.kernel.org
References: <ea96c78c-e1dc-1364-e91-51909f82388b@google.com>
 <YzPgTtFzpKEfwPbK@hyeyoo> <YzRQvoVsnJzsauwb@google.com>
 <35502bdd-1a78-dea1-6ac3-6ff1bcc073fa@suse.cz>
 <ff905c1e-5eb3-eaf8-46de-38f189c0b7a5@google.com>
 <de71b83a-c82c-4785-ef5a-3db4f17bbc8d@suse.cz>
 <bcecece-f7ce-221d-1674-da3d5ab3fef@google.com> <YzkmErHFyYW3awRn@hyeyoo>
 <YzsVM8eToHUeTP75@casper.infradead.org>
 <7dddca4c-bc36-2cf0-de1c-a770bef9e1b7@suse.cz>
In-Reply-To: <7dddca4c-bc36-2cf0-de1c-a770bef9e1b7@suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/24/22 16:35, Vlastimil Babka wrote:
> On 10/3/22 19:00, Matthew Wilcox wrote:
>> On Sun, Oct 02, 2022 at 02:48:02PM +0900, Hyeonggon Yoo wrote:
>>> Just one more thing, rcu_leak_callback too. RCU seem to use it
>>> internally to catch double call_rcu().
>>> 
>>> And some suggestions:
>>> - what about adding runtime WARN() on slab init code to catch
>>>   unexpected arch/toolchain issues?
>>> - instead of 4, we may use macro definition? like (PAGE_MAPPING_FLAGS + 1)?
>> 
>> I think the real problem here is that isolate_movable_page() is
>> insufficiently paranoid.  Looking at the gyrations that GUP and the
>> page cache do to convince themselves that the page they got really is
>> the page they wanted, there are a few missing pieces (eg checking that
>> you actually got a refcount on _this_ page and not some random other
>> page you were temporarily part of a compound page with).
>> 
>> This patch does three things:
>> 
>>  - Turns one of the comments into English.  There are some others
>>    which I'm still scratching my head over.
>>  - Uses a folio to help distinguish which operations are being done
>>    to the head vs the specific page (this is somewhat an abuse of the
>>    folio concept, but it's acceptable)
>>  - Add the aforementioned check that we're actually operating on the
>>    page that we think we want to be.
>>  - Add a check that the folio isn't secretly a slab.
>> 
>> We could put the slab check in PageMapping and call it after taking
>> the folio lock, but that seems pointless.  It's the acquisition of
>> the refcount which stabilises the slab flag, not holding the lock.
>> 
> 
> I would like to have a working safe version in -next, even if we are able
> simplify it later thanks to frozen refcounts. I've made a formal patch of
> yours, but I'm still convinced the slab check needs to be more paranoid so
> it can't observe a false positive __folio_test_movable() while missing the
> folio_test_slab(), hence I added the barriers as in my previous attempt [1].
> Does that work for you and can I add your S-o-b?

Tentatively the series is here for anyone interested, will send it for
proper review after the S-o-b is clarified.

https://git.kernel.org/pub/scm/linux/kernel/git/vbabka/slab.git/log/?h=slab/for-6.2/fit_rcu_head

> [1] https://lore.kernel.org/all/aec59f53-0e53-1736-5932-25407125d4d4@suse.cz/

