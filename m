Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7CDA72BE46
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 12:04:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236497AbjFLKDw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 06:03:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236440AbjFLKBd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 06:01:33 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C342535A2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 02:44:40 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 6FB5322807;
        Mon, 12 Jun 2023 09:44:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1686563079; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6Emr8M0/RctObEKZRro6J+KUvO1Jejbj0oVC9sdgo18=;
        b=AfY1NP/Z0L5vDzsPzh2dXfKQPZg/c3D/aXYWYht0BwakIwQwDRIHIQaHhxgvaIb0luiXcP
        styc8uoqUJtTHTXuwCqJHqVYPjJBLF54NRV4Zr8M6jS4qLy/gFDvjHvujY6RbSgKhSLLaT
        2Mh1BrphZETRWhxe/4WbnT83IFG4wjs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1686563079;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6Emr8M0/RctObEKZRro6J+KUvO1Jejbj0oVC9sdgo18=;
        b=u5qYZVGzTsyIez8we60vnEQWNtD7lamS6oIVZZqutIuHQ/VCiWPZnT1SXCLPL4fKPhWPoO
        esOMLgs+Nz3ur7Bw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4602F1357F;
        Mon, 12 Jun 2023 09:44:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id bOldEAfphmRtFQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Mon, 12 Jun 2023 09:44:39 +0000
Message-ID: <8427ebb5-61d0-f0ad-3bfa-6aaf575427e4@suse.cz>
Date:   Mon, 12 Jun 2023 11:44:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v4 0/3] page_owner: print stacks and their counter
Content-Language: en-US
To:     Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>
Cc:     Alexander Potapenko <glider@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Michal Hocko <mhocko@suse.com>,
        Eric Dumazet <edumazet@google.com>,
        Waiman Long <longman@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Marco Elver <elver@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>
References: <20230421101415.5734-1-osalvador@suse.de>
 <CAG_fn=UzFaHrM2X0_X=9aRPe5Wcmzj_snAbY=GJCj8__h9PxCg@mail.gmail.com>
 <7718244879ff2b696ea9cbb744cb3805@suse.de>
 <20230609145505.dc30b7712779d990aba64372@linux-foundation.org>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20230609145505.dc30b7712779d990aba64372@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/9/23 23:55, Andrew Morton wrote:
> On Mon, 24 Apr 2023 05:54:59 +0200 Oscar Salvador <osalvador@suse.de> wrote:
> 
>> > Given that no other stackdepot user needs these counters, maybe it
>> > should be cleaner to store an opaque struct along with the stack,
>> > passing its size to stack_depot_save(), and letting users access it
>> > directly using the stackdepot handler.
>> > 
>> > I am also wondering if a separate hashtable mapping handlers to
>> > counters would solve the problem for you?
>> 
>> Let us see first if with the changes from above the code gets to a more
>> generic and clean stage, if not we can explore further options.
> 
> Alexander, does this approach sound reasonable to you?

Note this is a v4 thread; there was (and the version in mm-unstable is) v5,
where the latest was Alexander requesting further changes:

https://lore.kernel.org/all/CAG_fn%3DUJgnLFGgpkXbMeD6axZN_ifEPHvWpy2_oiPyG1a6PXng@mail.gmail.com/

> The overall feature seems useful, although I'm not seeing any positive
> reviewer feedback.

