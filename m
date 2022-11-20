Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF0E1631543
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Nov 2022 17:50:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229526AbiKTQua (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Nov 2022 11:50:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbiKTQu1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Nov 2022 11:50:27 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 989FF2E698;
        Sun, 20 Nov 2022 08:50:26 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id C423D2234F;
        Sun, 20 Nov 2022 16:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1668963024; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KfVu7FWkHQ2Bojm6W10rAhMWKqZU3HIBARL9zZ8Ec6Q=;
        b=ClCAE1gTBD7L0VHqYX1j1nPLr8bzlVQR367tUEYAo+XO0eBUZse8pBuW0kz2b6gPjNRZBn
        aQGUA7mXLZ1wbExWdMVlF36LbyBzZErSyi6rqCu7DyeJWhB1bMmEkL/XF3hjAkqluHGc2t
        m5d2XY4ySVoN89WBjiON/DcRpV1L0ws=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1668963024;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KfVu7FWkHQ2Bojm6W10rAhMWKqZU3HIBARL9zZ8Ec6Q=;
        b=4bUXNii3ybC/Lc1z7dMzDj/jXBGbveL1kNLLsyAbN1AL4OXRRGCXm6TDlVWaovZAJORDw0
        bgOxWnAg0gUOoiAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8C98813216;
        Sun, 20 Nov 2022 16:50:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id +1/FIdBaemOlWAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Sun, 20 Nov 2022 16:50:24 +0000
Message-ID: <fd3211fd-5b3c-c1f2-c126-e96844b16c22@suse.cz>
Date:   Sun, 20 Nov 2022 17:50:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2] mm: Make ksize() a reporting-only function
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>
Cc:     Andrey Konovalov <andreyknvl@gmail.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        linux-mm@kvack.org, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20221118035656.gonna.698-kees@kernel.org>
 <230127af-6c71-e51e-41a4-aa9547c2c847@suse.cz>
 <202211180907.A4C218F@keescook>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <202211180907.A4C218F@keescook>
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

On 11/18/22 18:11, Kees Cook wrote:
> On Fri, Nov 18, 2022 at 11:32:36AM +0100, Vlastimil Babka wrote:
>> On 11/18/22 04:56, Kees Cook wrote:
>> > With all "silently resizing" callers of ksize() refactored, remove the
>> 
>> At cursory look seems it's true now in -next (but not mainline?) can you
>> confirm?
> 
> Almost, yes. I realized there is 1 case in the BPF verifier that
> remains. (I thought it was picked up, but only a prereq patch was.) I'm
> going to resend that one today, but I would expect it to be picked
> up soon. (But, yes, definitely not for mainline.)
> 
>> That would probably be safe enough to have slab.git expose this to -next now
>> and time a PR appropriately in the next merge window?
> 
> Possibly. I suspect syzkaller might trip KASAN on any larger BPF tests
> until I get the last one landed. And if you don't want to do the timing
> of the PR, I can carry this patch in my hardening tree, since I already
> have to do a two-part early/late-merge-window PR there.

OK I'm fine with you doing that, there's my ack already, hopefully Andrey is
now also happy :)

Vlastimil
