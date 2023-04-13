Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 209476E073F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 08:55:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbjDMGzZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 02:55:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbjDMGzX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 02:55:23 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5204683F8
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 23:55:17 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id ED36C1FD63;
        Thu, 13 Apr 2023 06:55:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1681368915; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LKj3Sa1bj1k3JK9KGPKmmqNZDHVo9Oz8P5aTGkpnMg0=;
        b=aNUxu1hlEE5Ur9RwKUlhPDMubtfHNjPcT0xwlcHF4Lo1cwN1FHKGEjCOxGggyjwiJ54VR0
        lELtxJuX4VlEvYgRZ3QCCv66hqvv2imSnghQz62o4mSFFLmfGZsjlA+GzQvKqZsWLa6jk5
        LxDVmN1lk1ju08U+a3/uforkohWcRV0=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C11BB13421;
        Thu, 13 Apr 2023 06:55:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id bQJ4LFOnN2TvawAAMHmgww
        (envelope-from <mhocko@suse.com>); Thu, 13 Apr 2023 06:55:15 +0000
Date:   Thu, 13 Apr 2023 08:55:15 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Jaewon Kim <jaewon31.kim@samsung.com>
Cc:     "T.J. Mercier" <tjmercier@google.com>,
        "jstultz@google.com" <jstultz@google.com>,
        "sumit.semwal@linaro.org" <sumit.semwal@linaro.org>,
        "daniel.vetter@ffwll.ch" <daniel.vetter@ffwll.ch>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jaewon31.kim@gmail.com" <jaewon31.kim@gmail.com>
Subject: Re: [PATCH v3] dma-buf/heaps: system_heap: avoid too much allocation
Message-ID: <ZDenU98chAfH9jSj@dhcp22.suse.cz>
References: <CABdmKX2fA2nXaSb8k+LE1yeso=ZnboDtxhzmjzrS35GSKv73hQ@mail.gmail.com>
 <ZDZ4j7UdBt32j28J@dhcp22.suse.cz>
 <ZDZqYTSHBNGLq0zI@dhcp22.suse.cz>
 <20230410073228.23043-1-jaewon31.kim@samsung.com>
 <20230412085726epcms1p7d2bec2526e47bd10a3b6ea6a113c9cc3@epcms1p7>
 <20230412094440epcms1p445319579ead0d0576bb616ebb07501b4@epcms1p4>
 <ZDaP4/PYyb9tKGQi@dhcp22.suse.cz>
 <20230412113759epcms1p8cb15b54e3a96c7616419cb030d16f804@epcms1p8>
 <CGME20230410073304epcas1p4cf3079b096994d69472b7801bd530bc7@epcms1p6>
 <20230413001658epcms1p611d149fcbbbd06fc17387724f4f16359@epcms1p6>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230413001658epcms1p611d149fcbbbd06fc17387724f4f16359@epcms1p6>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 13-04-23 09:16:58, Jaewon Kim wrote:
> >On Wed, Apr 12, 2023 at 4:38?AM Jaewon Kim <jaewon31.kim@samsung.com> wrote:
> >
> >> Yes I think you're right. As a allocator, dma-buf system heap looks to be loose
> >> in memory allocation. Limiting dmabuf memory may be required. But I think there
> >> is no nice and reasonable way so far. And the dma-buf system heap is being
> >> widely used in Android mobile system. AFAIK the camera consumes huge memory
> >> through this dma-buf system heap. I actually even looked a huge size request
> >> over 2GB in one dma-buf request.
> >>
> >Hey can you point me to where you saw a request that big? That's a
> >non-buggy request?!
> 
> (let me resend as plain text)
> It was one of camera scenarios. I internally asked and heard that was not a bug
> but normal. I think 2GB looks too big for one graphics buffer but it could be
> for other purposes like camera. I think the system heap should support that.

Is that any of the upstream drivers or something sitting out of the
tree.

> Regarding __GFP_RETRY_MAYFAIL, we may need to say dma-buf system heap was
> designed to gather many pages up to a requested size. If mm returns NULL due to
> __GFP_RETRY_MAYFAIL, dma-buf system heap will release other already allocated
> pages, so that it may help to avoid oom.

This really depends on the other activity on the system. If you have a
more concurrent memory demand at the time then you might be just out of
the luck. Really, claiming huge portion of the memory shouldn't be done
nilly willy.
-- 
Michal Hocko
SUSE Labs
