Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 109C86E7FE0
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 18:47:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233257AbjDSQrn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 12:47:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232588AbjDSQrl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 12:47:41 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C62CC270E
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 09:47:32 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 6B78D1FD98;
        Wed, 19 Apr 2023 16:47:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1681922851; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=R7n8VKpCcuyDgTxe9PzLJnL7YYi0wPZnyKfOG+vA4Qc=;
        b=HeixTkZD59JVtb74nipavgvSlQn//sMl5NVsI/y3gPbSs2BeoMGqEqoXJJsV9xLOSGB/GY
        Xm4u2uK/dTxrNE566wDiVRuAZRsG/kqBpARc+Aa3Nn/sa8/ozNxFYQ+RjsEUZb/Rtx+awD
        ooTJQu3kUUYWyCXhpDziWkrvipzuM5s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1681922851;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=R7n8VKpCcuyDgTxe9PzLJnL7YYi0wPZnyKfOG+vA4Qc=;
        b=Qq1iYoqPtPkJNNrXPQltI6ODmAFphQxpVDVdEFN6p+jUgu0P3afq91021gagmRxGPpRQas
        PQvIHvuU7yB45NDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2C73613580;
        Wed, 19 Apr 2023 16:47:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 7nSaCSMbQGR3QAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Wed, 19 Apr 2023 16:47:31 +0000
Message-ID: <1a481d68-930e-9418-a9aa-befdcfe36928@suse.cz>
Date:   Wed, 19 Apr 2023 18:47:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v7 00/13] fold per-CPU vmstats remotely
Content-Language: en-US
To:     Marcelo Tosatti <mtosatti@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Christoph Lameter <cl@linux.com>,
        Aaron Tomlin <atomlin@atomlin.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Russell King <linux@armlinux.org.uk>,
        Huacai Chen <chenhuacai@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>, x86@kernel.org,
        Michal Hocko <mhocko@suse.com>
References: <20230320180332.102837832@redhat.com>
 <20230418150200.027528c155853fea8e4f58b2@linux-foundation.org>
 <ZD/NAaa5TVcL7Mxm@tpad> <ZD/Qq9v0EDxUn7HW@tpad>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <ZD/Qq9v0EDxUn7HW@tpad>
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

On 4/19/23 13:29, Marcelo Tosatti wrote:
> On Wed, Apr 19, 2023 at 08:14:09AM -0300, Marcelo Tosatti wrote:
>> This was tried before:
>> https://lore.kernel.org/lkml/20220127173037.318440631@fedora.localdomain/
>> 
>> My conclusion from that discussion (and work) is that a special system
>> call:
>> 
>> 1) Does not allow the benefits to be widely applied (only modified
>> applications will benefit). Is not portable across different operating systems. 
>> 
>> Removing the vmstat_work interruption is a benefit for HPC workloads, 
>> for example (in fact, it is a benefit for any kind of application, 
>> since the interruption causes cache misses).
>> 
>> 2) Increases the system call cost for applications which would use
>> the interface.
>> 
>> So avoiding the vmstat_update update interruption, without userspace 
>> knowledge and modifications, is a better than solution than a modified
>> userspace.
> 
> Another important point is this: if an application dirties
> its own per-CPU vmstat cache, while performing a system call,
> and a vmstat sync event is triggered on a different CPU, you'd have to:
> 
> 1) Wait for that CPU to return to userspace and sync its stats
> (unfeasible).
> 
> 2) Queue work to execute on that CPU (undesirable, as that causes
> an interruption).

So you're saying the application might do a syscall from the isolcpu, so
IIUC it cannot expect any latency guarantees at that very moment, but then
it immediately starts expecting them again after returning to userspace, and
a single interruption for a one-time flush after the syscall would be too
intrusive?

(elsewhere in the thread you described an RT app initialization that may
generate vmstats to flush and then entry userspace loop, again, would a
single interruption soon after entering the loop be so critical?)

> 3) Remotely sync the vmstat for that CPU.
> 
> 
> 

