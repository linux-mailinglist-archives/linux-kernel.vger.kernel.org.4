Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 480C95EF5EA
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 15:01:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235554AbiI2NBU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 09:01:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235017AbiI2NBO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 09:01:14 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 308A1145CB2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 06:01:10 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id CD6A721989;
        Thu, 29 Sep 2022 13:01:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1664456468; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mMcf2TQeX0/eb4xhoq81siCbWjBexQIYrNessvTrls0=;
        b=faj4fGdFpfGVhaEqpGzULjNu1kQQ2G+CCGyj+FN+xBuMcjw4qsjF7mZyoxkF57ZcOCe/MF
        JUQs/JLc7t4A655bltpgqRsXKAiCvFJ0us9oVRfrTcVa8WWo7tIu5rZiUhqvSGZ22hlD/2
        fLz1ET6mwR26bwoEhis9ZaYHvRrr28c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1664456468;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mMcf2TQeX0/eb4xhoq81siCbWjBexQIYrNessvTrls0=;
        b=mUmxr83wtjjOp5fo3R1ql2+h/veH208ewoxPaK1KjCvEgGDjxwEsH7sx4hvZQMNsYtF5t+
        kFld784OrpJOGqCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A9E321348E;
        Thu, 29 Sep 2022 13:01:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id eyDSKBSXNWNhGgAAMHmgww
        (envelope-from <vbabka@suse.cz>); Thu, 29 Sep 2022 13:01:08 +0000
Message-ID: <ea6e7b10-c514-8320-05c2-4a18391a7079@suse.cz>
Date:   Thu, 29 Sep 2022 15:01:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: amusing SLUB compaction bug when CC_OPTIMIZE_FOR_SIZE
Content-Language: en-US
To:     David Laight <David.Laight@ACULAB.COM>,
        'Hugh Dickins' <hughd@google.com>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
References: <ea96c78c-e1dc-1364-e91-51909f82388b@google.com>
 <YzPgTtFzpKEfwPbK@hyeyoo> <YzRQvoVsnJzsauwb@google.com>
 <35502bdd-1a78-dea1-6ac3-6ff1bcc073fa@suse.cz>
 <ff905c1e-5eb3-eaf8-46de-38f189c0b7a5@google.com>
 <9368c760191448bba0e062709cc7c799@AcuMS.aculab.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <9368c760191448bba0e062709cc7c799@AcuMS.aculab.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/29/22 13:53, David Laight wrote:
>> -static void rcu_free_slab(struct rcu_head *h)
>> +/*
>> + * rcu_free_slab() must be __aligned(4) because its address is saved
>> + * in the rcu_head field, which coincides with page->mapping, which
>> + * causes trouble if compaction mistakes it for PAGE_MAPPING_MOVABLE.
>> + */
>> +__aligned(4) static void rcu_free_slab(struct rcu_head *h)
>>  {
>>  	struct slab *slab = container_of(h, struct slab, rcu_head);
>> 
> 
> Isn't that going to cause grief with options that align
> functions on 16/32byte boundaries when adding space for
> 'other stuff'?

How is that done exactly? Also having higher alignment (16/32) is not in
conflict with asking for 4?

> 	David
> 
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)
> 

