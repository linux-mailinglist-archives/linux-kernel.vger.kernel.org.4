Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A4CC6EC42D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 05:55:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230270AbjDXDzG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Apr 2023 23:55:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbjDXDzD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Apr 2023 23:55:03 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0F6526A3
        for <linux-kernel@vger.kernel.org>; Sun, 23 Apr 2023 20:55:01 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id E27D31FD6F;
        Mon, 24 Apr 2023 03:54:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1682308499; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Vg+urJOyPUXiktXOQU10CHhl7LlrECD+nld2cuF6aAk=;
        b=eXxfKsWNO4lyj2ZqXMq+bLIHNTSri+lag0/Bt6xEzK1A+TjoA/ppj24WE6Z1sF+fGLd+nW
        gnjU0yXqwXwLBlSV54buUrxRY9QWR1+V4Lxiif+B6xUwwS1UvZcx5J7uamZvAyL869V8k7
        X3r+wxUpm7KjPh/LX/D6AVZAzNT6XMg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1682308499;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Vg+urJOyPUXiktXOQU10CHhl7LlrECD+nld2cuF6aAk=;
        b=6NxXkrOVVasLN3rwHOVjtak0p+7NjeNVXBEJZ/yOqxLmlj/U278PBU9oAc3CIM5kTIw8/H
        UozyMYX3r89C08Ag==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D374513780;
        Mon, 24 Apr 2023 03:54:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id /PJrM5P9RWSUaAAAMHmgww
        (envelope-from <osalvador@suse.de>); Mon, 24 Apr 2023 03:54:59 +0000
MIME-Version: 1.0
Date:   Mon, 24 Apr 2023 05:54:59 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     Alexander Potapenko <glider@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Eric Dumazet <edumazet@google.com>,
        Waiman Long <longman@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Marco Elver <elver@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>
Subject: Re: [PATCH v4 0/3] page_owner: print stacks and their counter
In-Reply-To: <CAG_fn=UzFaHrM2X0_X=9aRPe5Wcmzj_snAbY=GJCj8__h9PxCg@mail.gmail.com>
References: <20230421101415.5734-1-osalvador@suse.de>
 <CAG_fn=UzFaHrM2X0_X=9aRPe5Wcmzj_snAbY=GJCj8__h9PxCg@mail.gmail.com>
User-Agent: Roundcube Webmail
Message-ID: <7718244879ff2b696ea9cbb744cb3805@suse.de>
X-Sender: osalvador@suse.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-04-21 13:19, Alexander Potapenko wrote:
> I think the implementation of these counters is too specific to
> page_owner and is hard to use for any other purpose.
> If we decide to have them, there should be no page_owner-specific
> logic in the way we initialize/increment/decrement these counters.

Another solution would be to always increment the refcount in 
__stack_depot_save,
in this case the "page-owner" specific changes are gone, and
it is more of a generic thing.
e.g: Andrey Konovalov mentioned that in a future KASAN remodelation,
he would be using a stack refcount as well.

> The thresholds in "mm,page_owner: Filter out stacks by a threshold
> counter" should also belong elsewhere.

That can certainly be cleaned up I guess to not polute non-page_owner 
code.

> Given that no other stackdepot user needs these counters, maybe it
> should be cleaner to store an opaque struct along with the stack,
> passing its size to stack_depot_save(), and letting users access it
> directly using the stackdepot handler.
> 
> I am also wondering if a separate hashtable mapping handlers to
> counters would solve the problem for you?

Let us see first if with the changes from above the code gets to a more
generic and clean stage, if not we can explore further options.

Thanks for your feedback Alexander!

-- 
Oscar Salvador
SUSE Labs
