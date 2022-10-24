Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8885609FDC
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 13:11:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbiJXLLO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 07:11:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230199AbiJXLLD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 07:11:03 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E570F3AB3C
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 04:10:59 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 936BF21E6C;
        Mon, 24 Oct 2022 11:10:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1666609858; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=c9LyPhw0fn06VJLpIWBBedHqVCQTOByd+fZNTw6i+9w=;
        b=P7qhGZV/D7QYWARtAPR+FrgfXcrTC5U0U0uwHWNnGBGLmtf7c4Q62C/dBRUu+zp3S6pzSo
        2S0X1nzT5dDsti3bk5WZuMZBPJGWaOZmw0LWOOtvCELQNjg57atjdUiIN8PIHXHLajP9ZK
        KO84Y1BhxdEFbBoHPiBtih8zgdm6gu0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1666609858;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=c9LyPhw0fn06VJLpIWBBedHqVCQTOByd+fZNTw6i+9w=;
        b=DbpVXtLXVrQcCfak4I6tx3O3sJjO2NeyGKACOfwHdp5t0U4ftk2WPocXxe+Xe4KV1VQZhT
        bQ3A2yveLjESqXBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6733D13357;
        Mon, 24 Oct 2022 11:10:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id jkuAGMJyVmN+LAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Mon, 24 Oct 2022 11:10:58 +0000
Message-ID: <e6b415c8-4905-8bbd-fe72-d3d95d77c890@suse.cz>
Date:   Mon, 24 Oct 2022 13:10:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH] mm/slub: remove dead code for debug caches on
 deactivate_slab()
Content-Language: en-US
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <roman.gushchin@linux.dev>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20221014114322.97512-1-42.hyeyoo@gmail.com>
 <82e8147e-f031-6bc2-9395-56d2052e62cb@suse.cz> <Y1NuEhXgxmr2OHeH@hyeyoo>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <Y1NuEhXgxmr2OHeH@hyeyoo>
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

On 10/22/22 06:14, Hyeonggon Yoo wrote:
> On Fri, Oct 21, 2022 at 12:43:42PM +0200, Vlastimil Babka wrote:
>> On 10/14/22 13:43, Hyeonggon Yoo wrote:
>> > After commit c7323a5ad0786 ("mm/slub: restrict sysfs validation to debug
>> > caches and make it safe"), SLUB does not take a slab from partial list for
>> 
>> I'm confused by "SLUB does not take a slab from partial list" here. Did you
>> mean something like "SLUB never installs (even temporarily) a percpu slab
>> for debug caches"?
> 
> Yes.
> 
>> So that means we never deactivate percpu slabs for debug
>> caches.
> 
> Yes.
> 
>> And since debug caches are also the only ones that use the full
>> list, we no longer need to care about the full list in deactivate_slab(), right?
> 
> Yes, You got it right, exactly!
> 
> Let me rephrase:
> 
> "After commit c7323a5ad0786 ("mm/slub: restrict sysfs validation to debug
> caches and make it safe"), SLUB never installs percpu slab for debug caches
> and thus never deactivates percpu slab for them.
> 
> Since only some of debug caches care about the full list, SLUB no longer
> deactivates to full list. Remove dead code in deactivate_slab()."
> 
> 
> Feel free to change this ;-)

Great, thanks!

Pushed to slab/for-6.2/cleanups


