Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F5D57418CB
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 21:19:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231573AbjF1TT2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 15:19:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:23168 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230361AbjF1TTY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 15:19:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687979917;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=z3+WfKV5Wz85M3f84YrJfAbIjSPqDA0LNe6BQbP5oxI=;
        b=a8lYgvYeh20eA7MBW/kabaWwxEOC6NhP6Eb1GbVnUlM1RzawT+vvmXRl2nUOlkN5twrsXH
        bh/Kd/2R5aObLnPORHj+o5FJbYcLPUe2rlK2e7iqwMm3o/eA+/1tDw9lEyqTwZSmt3CAAO
        cNGTBm+1s9/YEFVCL64D4oc9F36KxiI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-401-x-1JRoffOwuUYVdkw7tiHQ-1; Wed, 28 Jun 2023 15:18:34 -0400
X-MC-Unique: x-1JRoffOwuUYVdkw7tiHQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5A56F185A7A4;
        Wed, 28 Jun 2023 19:18:33 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.4])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8F7FF46EE28;
        Wed, 28 Jun 2023 19:18:32 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <CAHk-=wie=MvQzmjhKGCCbRapK3Zz-b8GFUchEDJi7SkeLAX6Pw@mail.gmail.com>
References: <CAHk-=wie=MvQzmjhKGCCbRapK3Zz-b8GFUchEDJi7SkeLAX6Pw@mail.gmail.com> <20230626085035.e66992e96b4c6d37dad54bd9@linux-foundation.org> <CAHk-=wjyJyV=Kyb8XJcLjFEPP-RMF0J6CQfT2OXLmJdM2yEv8w@mail.gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     dhowells@redhat.com, Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>, linux-mm@kvack.org,
        mm-commits@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] MM updates for 6.5-rc1
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3696803.1687979912.1@warthog.procyon.org.uk>
Date:   Wed, 28 Jun 2023 20:18:32 +0100
Message-ID: <3696804.1687979912@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> wrote:

> Side note: I think we should just do the "FOLL_GET" doesn't touch the
> refcount either, which would make this all become just

Yeah... but there's a lot of places that would potentially need fixing.
iov_iter_get_pages*(), for example, is used to grab pages and push them to all
sorts of destinations, including pipes and sk_buffs.

> but then we would need to fix try_grab_page() and gup_put_folio() and
> friends to match. And any other cases I haven't thought of.

And put_page(), folio_put(), ...  I wonder if there would be a noticeable
performance loss from adding an is_zero_page() check into those.

It might also make sense to include the entire kernel post-init static image
in that, perhaps a check:

	if ((unsigned long)(virt_address) & KERNEL_MASK == KERNEL_BASE)
		return;

David

