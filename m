Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74AE77420E1
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 09:21:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231901AbjF2HVW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 03:21:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231191AbjF2HVR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 03:21:17 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C1EB2122;
        Thu, 29 Jun 2023 00:21:16 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id DF8A52187E;
        Thu, 29 Jun 2023 07:21:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1688023274; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TQot3+/6L06MLnSwVM0U5KvPeO/RHKvhkYlJ8UsXvjs=;
        b=iaHOV9fKaasVMdc1oQTFtH99k6W1EIldNrjg6M6CAchZIiu6hRzsoyP93QXQPvnjmYCcRE
        d31Gvn5PraCXocbem8bQ39fmlGjiS8wn7X5/hPDjdu/TY+FXsWLb97iLDTrYxa3P01ZtLF
        NRHyjCCrijsV/filxnPnK5ISFK9/heg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1688023274;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TQot3+/6L06MLnSwVM0U5KvPeO/RHKvhkYlJ8UsXvjs=;
        b=gsKyyXeK693hOMAh8n+hnyyFNfuKx0+E6AJH8y0MmgnZn8NifxTHkRVWzbhHd9PT6g40a+
        plFRu3+d0l0ciKDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A689C13905;
        Thu, 29 Jun 2023 07:21:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 3gfyJ+ownWT9PAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Thu, 29 Jun 2023 07:21:14 +0000
Message-ID: <d7962a66-12e9-6225-1e74-ccdfc9891da9@suse.cz>
Date:   Thu, 29 Jun 2023 09:21:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] mm/slub: disable slab merging in the default
 configuration
To:     Roman Gushchin <roman.gushchin@linux.dev>,
        David Rientjes <rientjes@google.com>
Cc:     Julian Pidancet <julian.pidancet@oracle.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Rafael Aquini <aquini@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <20230627132131.214475-1-julian.pidancet@oracle.com>
 <48bd9819-3571-6b53-f1ad-ec013be742c0@google.com>
 <ZJxjgy/Mkh20WpXv@P9FQF9L96D.corp.robot.car>
Content-Language: en-US
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <ZJxjgy/Mkh20WpXv@P9FQF9L96D.corp.robot.car>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/28/23 18:44, Roman Gushchin wrote:
> On Tue, Jun 27, 2023 at 12:32:15PM -0700, David Rientjes wrote:
>> On Tue, 27 Jun 2023, Julian Pidancet wrote:
>> 
>> > Make CONFIG_SLAB_MERGE_DEFAULT default to n unless CONFIG_SLUB_TINY is
>> > enabled. Benefits of slab merging is limited on systems that are not
>> > memory constrained: the overhead is negligible and evidence of its
>> > effect on cache hotness is hard to come by.
>> > 
>> 
>> I don't have an objection to this, I think it makes sense.
> 
> +1
> 
> I believe the overhead was much larger when we had per-memcg slab caches,
> but now it should be fairly small on most systems.
> 
> But I wonder if we need a new flag (SLAB_MERGE?) to explicitly force merging
> on per-slab cache basis.

Damn, we just tried to add SLAB_NO_MERGE, that is if Linus pulls the PR, as
I've just found out that the last time he hated the idea [1] :) (but at the
same time I think the current attempt is very different in that it's not
coming via a random tree, and the comments make it clear that it's not for
everyone to enable in production configs just because they think they are
special).

But SLAB_MERGE, I doubt it would get many users being opt-in. People would
have to consciously opt-in to not being special.

As for changing the default, we definitely need to see the memory usage
results first, as was mentioned. It's not expected that disabling merging
would decrease performance, so no wonder the test didn't find such decrease,
but the expected downside is really increased memory overhead.

But then again it's just a default and most people would use a distro config
anyway, and neither option seems to be an obvious winner to me? As for the
"security by default" argument, AFAIK we don't enable freelist
hardening/randomization by default, and I thought (not being the expert on
this) the heap spraying attacks concerned mainly generic kmalloc cache users
(see also [2]) and not some specific named caches being merged?

[1]
https://lore.kernel.org/all/CA+55aFyepmdpbg9U2Pvp+aHjKmmGCrTK2ywzqfmaOTMXQasYNw@mail.gmail.com/
[2]
https://lore.kernel.org/all/20230626031835.2279738-1-gongruiqi@huaweicloud.com/

> I believe there are some cases when slab caches can
> be created in noticeable numbers and in those cases the memory footprint might
> be noticeable.
> 
> Thanks!

