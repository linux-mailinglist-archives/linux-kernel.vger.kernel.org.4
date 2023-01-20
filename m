Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27EA3675506
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 13:53:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230401AbjATMw7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 07:52:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230060AbjATMw4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 07:52:56 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BD6240DB
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 04:52:51 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 50B8422CF2;
        Fri, 20 Jan 2023 12:52:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1674219170; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kTQ8Nq5uvi7FWe1ddqkYPpHbQ6IQIb+Qc6lBsv5QfVI=;
        b=ElA9uAGLE8ZdsC+6EypPtS7ML7QfEqiyXmTJDtC7kgz7sDJz+8iO8gcTxtbxOmhomCzCdz
        PnD4wZlJVQA8POWLgxzspN9PojhrsHQ0ZkJU6BiHX6ziA54MnRnMVZyzFgvjAvWeO+sbIx
        RcIHkdF6CjTh/57o5c7UnanqLjT2Cvg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1674219170;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kTQ8Nq5uvi7FWe1ddqkYPpHbQ6IQIb+Qc6lBsv5QfVI=;
        b=ERovqVMAZaPUFruKbfpihDfcPrnt+VfHJu4rR0qhMeuljKCXst6SlU7fA5QkFSXBRc586Z
        OY4eZq3brnySttAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0E10A1390C;
        Fri, 20 Jan 2023 12:52:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 5ZZqAqKOymMWKAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Fri, 20 Jan 2023 12:52:50 +0000
Message-ID: <b6da6f3b-8d66-2b8c-b02e-14d274260493@suse.cz>
Date:   Fri, 20 Jan 2023 13:52:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCHv4 2/2] mm: use stack_depot_early_init for kmemleak
Content-Language: en-US
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "zhaoyang.huang" <zhaoyang.huang@unisoc.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Zhaoyang Huang <huangzhaoyang@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, ke.wang@unisoc.com,
        Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
References: <1674091345-14799-1-git-send-email-zhaoyang.huang@unisoc.com>
 <1674091345-14799-2-git-send-email-zhaoyang.huang@unisoc.com>
 <6e9e406a-8a94-4e34-9e5e-f4bb3a321b4e@suse.cz>
 <20230119144204.a5a67be85544cd29cd656a5b@linux-foundation.org>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20230119144204.a5a67be85544cd29cd656a5b@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/19/23 23:42, Andrew Morton wrote:
> On Thu, 19 Jan 2023 11:32:36 +0100 Vlastimil Babka <vbabka@suse.cz> wrote:
> 
>> But to be cleaner I'd also suggest Andrew adds the hunk below. The call
>> to stack_depot_init() becomes no-op after this patch so it's not a bug
>> to leave it there, but it's just misleading now.
>>
>> ---8<---
>> diff --git a/mm/kmemleak.c b/mm/kmemleak.c
>> index 91dda5c2753a..55dc8b8b0616 100644
>> --- a/mm/kmemleak.c
>> +++ b/mm/kmemleak.c
>> @@ -2095,7 +2095,6 @@ void __init kmemleak_init(void)
>>   	if (kmemleak_error)
>>   		return;
>>   
>> -	stack_depot_init();
>>   	jiffies_min_age = msecs_to_jiffies(MSECS_MIN_AGE);
>>   	jiffies_scan_wait = msecs_to_jiffies(SECS_SCAN_WAIT * 1000);
>>   
> 
> I added your signoff to this.

Fine with me, thanks.

> I used not to bother for such minor to-be-folded fixups, but now
> Stephen sends me automated nags when his scripts detect this.

Ack, will try to remember that next time.
