Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E3505FC552
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 14:30:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbiJLMaj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 08:30:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbiJLMaX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 08:30:23 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 398114A809
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 05:30:17 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 1076721F2C;
        Wed, 12 Oct 2022 12:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1665577816; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=u1AMcvv7taYOuHiirpvzZyNURP/MRqokBLvNSR8M5Vk=;
        b=fM9RA6CYhZU5/ypkeJO2yPVrxnE9UvZ+IqrHN1Am1tVP/Y/3Zk6XZzFJs3Lz2IRCH056V8
        TegKaiZlAbUKNKBz95LFkZSzoN3EKUY0atBMNyVLhX373+3Jfyp2Bkb1fEa6Kzgeo/JDb0
        1+8QyVp4GZdbNhYqq0hof/qpjT0o9Uk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1665577816;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=u1AMcvv7taYOuHiirpvzZyNURP/MRqokBLvNSR8M5Vk=;
        b=xk5JTfWsfNrE05XizhmVT7mqihZPMxfSijRJDO+Miom0emZWDcY288FQ6AnpAtGXoe0kX+
        eCRHWu2C07VwbZBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B0E2C13A5C;
        Wed, 12 Oct 2022 12:30:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id SemQKlezRmOWWgAAMHmgww
        (envelope-from <vbabka@suse.cz>); Wed, 12 Oct 2022 12:30:15 +0000
Message-ID: <e2b567bd-5a1d-d19a-a45b-6f48d2292dd3@suse.cz>
Date:   Wed, 12 Oct 2022 14:30:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH v2] mm: slab, with same context require fs_reclaim lock
To:     Steven Rostedt <rostedt@goodmis.org>, eadavis@sina.com
Cc:     syzbot+dfcc5f4da15868df7d4d@syzkaller.appspotmail.com,
        akpm@linux-foundation.org, keescook@chromium.org,
        linux-kernel@vger.kernel.org, mark.rutland@arm.com,
        mhiramat@kernel.org, syzkaller-bugs@googlegroups.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
References: <00000000000074b50005e997178a@google.com>
 <20220927071134.1674904-1-eadavis@sina.com>
 <20221012072319.1a678100@rorschach.local.home>
Content-Language: en-US
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20221012072319.1a678100@rorschach.local.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/12/22 13:23, Steven Rostedt wrote:
> On Tue, 27 Sep 2022 15:11:34 +0800
> eadavis@sina.com wrote:
>> --- a/mm/slab.c
>> +++ b/mm/slab.c
>> @@ -3275,15 +3275,19 @@ slab_alloc(struct kmem_cache *cachep, struct list_lru *lru, gfp_t flags,
>>  	bool init = false;
>>  
>>  	flags &= gfp_allowed_mask;
>> +	local_irq_save(save_flags);
> 
> Please do not do this. Open coding interrupt disabling due to locking
> issues is not the solution. You need to make the locks themselves
> disable interrupts if need be. This breaks PREEMPT_RT, and creates a
> "big kernel lock" situation where there's random interrupts being
> disabled for no apparent reason.
> 
> -- Steve

And FWIW the problem was in the calling context of io_uring, not slab code
itself in the first place, see:

https://lore.kernel.org/all/20220929135627.ykivmdks2w5vzrwg@quack3/
