Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66F237418B6
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 21:11:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231520AbjF1TLf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 15:11:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:27623 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231509AbjF1TLd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 15:11:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687979446;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DHYzA765GPu9kX2/aCtAcTvHRHevAxD+3e5vQVRrgfY=;
        b=Mv8Feepj0GIXHp1Jc1q5KBPzfO61T7YucEoCGVlZRb0FF3R5SQEt+R/odguqzXS6T9czu8
        NK9XoJ/VtKdYA9FzOAEwNyE8Lj0MPOo4mSzKTjQhCa6luaqgwkrgJM2Ft1MDCvpcaq8I5L
        dfGP4ljr6KHwGHTMtvSrY2bQChUxclw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-478-yDhu-QUUMAKeu8FHPLXHfg-1; Wed, 28 Jun 2023 15:10:43 -0400
X-MC-Unique: yDhu-QUUMAKeu8FHPLXHfg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DDC1E8DBAEE;
        Wed, 28 Jun 2023 19:10:42 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.4])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C1DFB200B677;
        Wed, 28 Jun 2023 19:10:41 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <CAHk-=wjyJyV=Kyb8XJcLjFEPP-RMF0J6CQfT2OXLmJdM2yEv8w@mail.gmail.com>
References: <CAHk-=wjyJyV=Kyb8XJcLjFEPP-RMF0J6CQfT2OXLmJdM2yEv8w@mail.gmail.com> <20230626085035.e66992e96b4c6d37dad54bd9@linux-foundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     dhowells@redhat.com, Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>, linux-mm@kvack.org,
        mm-commits@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] MM updates for 6.5-rc1
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3696705.1687979441.1@warthog.procyon.org.uk>
Date:   Wed, 28 Jun 2023 20:10:41 +0100
Message-ID: <3696706.1687979441@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> wrote:

> So I think it needs to match the comment (and the try_grab_page()
> logic), and just basically
> 
>         if (flags & FOLL_GET)
>                 return try_get_folio(page, refs);
> 
>         if (is_zero_page(page))
>                 return page_folio(page);
> 
>         folio = try_get_folio(page, refs);
>         if (!folio)
>                 return NULL;
> 
> instead.

That looks right.

David

