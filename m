Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3271F6E5D2F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 11:17:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231238AbjDRJRa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 05:17:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230509AbjDRJR0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 05:17:26 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F00DFED
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 02:17:24 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 9F40A1F8D6;
        Tue, 18 Apr 2023 09:17:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1681809443; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lrrlZEOMXRldfaSPVNeyMPGMmoVT36um+XV3eepdEbU=;
        b=WwH0Z2XykF5KxMGR4buRTbjZGhLlP9MICgQbXewkGCuBRvYnV5OMRZF4JWeaNLr3MQOoJq
        wGgWUCRufMnnnqSQr8QN0j9j4qAOC8hol7w9SZ7RrYHBCf1nGQVVE5gQsw6UrbFf66B2fl
        SO9bcGCDI67Z+AD2yuzWkwIdS2ioR+M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1681809443;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lrrlZEOMXRldfaSPVNeyMPGMmoVT36um+XV3eepdEbU=;
        b=WPJvjY6GNu1rif4tTjyEY7sgW8ZBOMtbfO+UbtH70StIamHihmy9/p7GIhFFGG0NqYSWaC
        6Xgav+sfZUE1mPCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8066213581;
        Tue, 18 Apr 2023 09:17:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 8/aeHiNgPmQaIwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Tue, 18 Apr 2023 09:17:23 +0000
Message-ID: <e5237b55-50eb-2a93-78cf-79421164f1fd@suse.cz>
Date:   Tue, 18 Apr 2023 11:17:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [RFC PATCH] migrate_pages: Never block waiting for the page lock
Content-Language: en-US
To:     Doug Anderson <dianders@chromium.org>,
        "Huang, Ying" <ying.huang@intel.com>,
        Mel Gorman <mgorman@techsingularity.net>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Yu Zhao <yuzhao@google.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
References: <20230413182313.RFC.1.Ia86ccac02a303154a0b8bc60567e7a95d34c96d3@changeid>
 <87v8hz17o9.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <CAD=FV=XPBaGGLJVG9UGoJss6EU5=esqyt=aWsp2nOm2YcVOc8g@mail.gmail.com>
 <87ildvwbr5.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <CAD=FV=WCWWuGO7D9X6By-fQ0ZB63iDsAvcPwza-F6tbA-Z_M6w@mail.gmail.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <CAD=FV=WCWWuGO7D9X6By-fQ0ZB63iDsAvcPwza-F6tbA-Z_M6w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/17/23 16:28, Doug Anderson wrote:
> Hi,
> 
> On Sun, Apr 16, 2023 at 6:15 PM Huang, Ying <ying.huang@intel.com> wrote:
>>
>> Doug Anderson <dianders@chromium.org> writes:
>>
>> > Hi,
>> >
>> > On Thu, Apr 13, 2023 at 8:10 PM Huang, Ying <ying.huang@intel.com> wrote:
>> >>
>> >> Douglas Anderson <dianders@chromium.org> writes:
>> >>
>> >> > Currently when we try to do page migration and we're in "synchronous"
>> >> > mode (and not doing direct compaction) then we'll wait an infinite
>> >> > amount of time for a page lock. This does not appear to be a great
>> >> > idea.
>> >> >
>> >> > One issue can be seen when I put a device under extreme memory
>> >> > pressure. I took a sc7180-trogdor Chromebook (4GB RAM, 8GB zram
>> >> > swap). I ran the browser along with Android (which runs from a
>> >> > loopback mounted 128K block-size squashfs "disk"). I then manually ran
>> >> > the mmm_donut memory pressure tool [1]. The system is completely
>> >> > unusable both with and without this patch since there are 8 processes
>> >> > completely thrashing memory, but it was still interesting to look at
>> >> > how migration was behaving. I put some timing code in and I could see
>> >> > that we sometimes waited over 25 seconds (in the context of
>> >> > kcompactd0) for a page lock to become available. Although the 25
>> >> > seconds was the high mark, it was easy to see tens, hundreds, or
>> >> > thousands of milliseconds spent waiting on the lock.
>> >> >
>> >> > Instead of waiting, if I bailed out right away (as this patch does), I
>> >> > could see kcompactd0 move forward to successfully to migrate other
>> >> > pages instead. This seems like a better use of kcompactd's time.
>> >> >
>> >> > Thus, even though this didn't make the system any more usable in my
>> >> > absurd test case, it still seemed to make migration behave better and
>> >> > that feels like a win. It also makes the code simpler since we have
>> >> > one fewer special case.
>> >>
>> >> TBH, the test case is too extreme for me.
>> >
>> > That's fair. That being said, I guess the point I was trying to make
>> > is that waiting for this lock could take an unbounded amount of time.
>> > Other parts of the system sometimes hold a page lock and then do a
>> > blocking operation. At least in the case of kcompactd there are better
>> > uses of its time than waiting for any given page.
>> >
>> >> And, we have multiple "sync" mode to deal with latency requirement, for
>> >> example, we use MIGRATE_SYNC_LIGHT for compaction to avoid too long
>> >> latency.  If you have latency requirement for some users, you may
>> >> consider to add new "sync" mode.
>> >
>> > Sure. kcompactd_do_work() is currently using MIGRATE_SYNC_LIGHT. I
>> > guess my first thought would be to avoid adding a new mode and make
>> > MIGRATE_SYNC_LIGHT not block here. Then anyone that truly needs to
>> > wait for all the pages to be migrated can use the heavier sync modes.
>> > It seems to me like the current users of MIGRATE_SYNC_LIGHT would not
>> > want to block for an unbounded amount of time here. What do you think?
>>
>> It appears that you can just use MIGRATE_ASYNC if you think the correct
>> behavior is "NOT block at all".  I found that there are more
>> fine-grained controls on this in compaction code, please take a look at
>> "enum compact_priority" and its comments.
> 
> Actually, the more I think about it the more I think the right answer
> is to keep kcompactd as using MIGRATE_SYNC_LIGHT and make
> MIGRATE_SYNC_LIGHT not block on the folio lock. kcompactd can accept
> some blocking but we don't want long / unbounded blocking. Reading the
> comments for MIGRATE_SYNC_LIGHT, this also seems like it fits pretty
> well. MIGRATE_SYNC_LIGHT says that the stall time of writepage() is
> too much. It's entirely plausible that someone else holding the lock
> is doing something as slow as writepage() and thus waiting on the lock
> can be just as bad for latency.

+Cc Mel for potential insights. Sounds like a good compromise at first
glance, but it's a tricky area.
Also there are other callers of migration than compaction, and we should
make sure we are not breaking them unexpectedly.

> I'll try to send out a v2 with this approach today and we can see what
> people think.

Please Cc Mel and myself for further versions.

> -Doug
> 

