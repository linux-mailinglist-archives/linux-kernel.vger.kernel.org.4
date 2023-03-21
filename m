Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85F536C2E1B
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 10:41:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbjCUJlY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 05:41:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjCUJlV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 05:41:21 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 759353D90C
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 02:41:14 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A371721A75;
        Tue, 21 Mar 2023 09:41:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1679391672; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=e86jmMfhyx3g3Qd21WKPXVLg7NEfwOFc8WYM94djY1s=;
        b=hOtDvriSHngf2Um59z9J/Xm4r/QXMm1VvW0bn1bn4dLRaYvJtkkkjA4ERm/8hbvjXDyABf
        T+j6eOncRLjUdHpJGnzw7qlZ5m7nxPhkYS+kvHkaLwgpj/0p2MXErJ1DrIIQf1+E/+foo7
        HweY4ijkswx9MQMMvHsqb39fvXLIwHQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1679391672;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=e86jmMfhyx3g3Qd21WKPXVLg7NEfwOFc8WYM94djY1s=;
        b=P3EnkHVyN4KTsYuNwt92A+YLNu0wUuJOaOUbHxoz72R81jKN2YBJ4hvektWjxbq724Htl6
        TsUSYCZczxwuIfAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6786213451;
        Tue, 21 Mar 2023 09:41:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id XGqCGLh7GWQxEwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Tue, 21 Mar 2023 09:41:12 +0000
Message-ID: <20b896db-9dd6-fcc3-a72a-ce0044d4ab75@suse.cz>
Date:   Tue, 21 Mar 2023 10:41:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] mm/slub: Reduce memory consumption in extreme scenarios
Content-Language: en-US
To:     Mike Rapoport <rppt@kernel.org>
Cc:     "chenjun (AM)" <chenjun102@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "cl@linux.com" <cl@linux.com>,
        "penberg@kernel.org" <penberg@kernel.org>,
        "rientjes@google.com" <rientjes@google.com>,
        "iamjoonsoo.kim@lge.com" <iamjoonsoo.kim@lge.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        "xuqiang (M)" <xuqiang36@huawei.com>,
        "Wangkefeng (OS Kernel Lab)" <wangkefeng.wang@huawei.com>,
        Michal Hocko <mhocko@kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Matthew Wilcox <willy@infradead.org>
References: <20230314123403.100158-1-chenjun102@huawei.com>
 <0cad1ff3-8339-a3eb-fc36-c8bda1392451@suse.cz>
 <344c7521d72e4107b451c19b329e9864@huawei.com>
 <8c700468-245d-72e9-99e7-b99d4547e6d8@suse.cz>
 <aeb2bd3990004b9eb4f151aa833ddcf2@huawei.com>
 <015855b3-ced3-8d84-e21d-cc6ce112b556@suse.cz> <ZBgjZn7WOqO5ruws@kernel.org>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <ZBgjZn7WOqO5ruws@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_SOFTFAIL,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/20/23 10:12, Mike Rapoport wrote:
> On Mon, Mar 20, 2023 at 09:05:57AM +0100, Vlastimil Babka wrote:
>> On 3/19/23 08:22, chenjun (AM) wrote:
>> > 在 2023/3/17 20:06, Vlastimil Babka 写道:
>> > 
>> > If we ignore __GFP_ZERO passed by kzalloc， kzalloc will not work.
>> > Could we just unmask __GFP_RECLAIMABLE | __GFP_RECLAIM?
>> > 
>> > pc.flags &= ~(__GFP_RECLAIMABLE | __GFP_RECLAIM)
>> > pc.flags |= __GFP_THISNODE
>> 
>> __GFP_RECLAIMABLE would be wrong, but also ignored as new_slab() does:
>> 	flags & (GFP_RECLAIM_MASK | GFP_CONSTRAINT_MASK)
>> 
>> which would filter out __GFP_ZERO as well. That's not a problem as kzalloc()
>> will zero out the individual allocated objects, so it doesn't matter if we
>> don't zero out the whole slab page.
>> 
>> But I wonder, if we're not past due time for a helper e.g.
>> gfp_opportunistic(flags) that would turn any allocation flags to a
>> GFP_NOWAIT while keeping the rest of relevant flags intact, and thus there
>> would be one canonical way to do it - I'm sure there's a number of places
>> with their own variants now?
>> With such helper we'd just add __GFP_THISNODE to the result here as that's
>> specific to this particular opportunistic allocation.
> 
> I like the idea, but maybe gfp_no_reclaim() would be clearer?

Well, that name would say how it's implemented, but not exactly as we also
want to add __GFP_NOWARN. "gfp_opportunistic()" or a better name with
similar meaning was meant to convey the intention of what this allocation is
trying to do, and I think that's better from the API users POV?
