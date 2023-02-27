Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 404146A4282
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 14:21:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbjB0NVn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 08:21:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230011AbjB0NVl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 08:21:41 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BFCB1E9E3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 05:20:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677504053;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GIUaC7K1TYqWkgQiMBQCJNQiY2ZClHrxPQ2oiydBZJ4=;
        b=K20HJxEXXwARkXCIueLo/peUw09ruA4lZC5U1nyxJnBOoVzjKNTtoNFnd4UW7yOj1xwh5L
        UkvXpUiow5mdnHwUUjyCsadAlv6S20nCQR9QxuxexBH1sc1vzlivu/sN1Leu5E9bxPgAU9
        QL0y10e7++5wvOTj/im0wQ18v6kLPn4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-371-oxBDmthhPsi5Sf1kEf0HUg-1; Mon, 27 Feb 2023 08:20:50 -0500
X-MC-Unique: oxBDmthhPsi5Sf1kEf0HUg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3D568101B42B;
        Mon, 27 Feb 2023 13:20:49 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.18])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9F2F7404BEC5;
        Mon, 27 Feb 2023 13:20:46 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <Y/kh8P4oSjunIU7T@casper.infradead.org>
References: <Y/kh8P4oSjunIU7T@casper.infradead.org> <Y/jhwuTCaOgOTLp2@casper.infradead.org> <2134430.1677240738@warthog.procyon.org.uk> <2009825.1677229488@warthog.procyon.org.uk> <CAHk-=whAAOVBrzwb2uMjCmdRrtudGesYj0tuqdUgi8X_gbw1jw@mail.gmail.com> <20230220135225.91b0f28344c01d5306c31230@linux-foundation.org> <2213409.1677249075@warthog.procyon.org.uk> <2385089.1677258941@warthog.procyon.org.uk> <Y/kFnhUM5hjWM2Ae@casper.infradead.org> <2390711.1677269637@warthog.procyon.org.uk> <CAHk-=wgpjrdcs_aFvdHdH6TpOsOmN9S5rXDqCZTB8WqXsZH8Qw@mail.gmail.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     dhowells@redhat.com,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Steve French <stfrench@microsoft.com>,
        Vishal Moola <vishal.moola@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jan Kara <jack@suse.cz>, Paulo Alcantara <pc@cjr.nz>,
        Huang Ying <ying.huang@intel.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Xin Hao <xhao@linux.alibaba.com>, linux-mm@kvack.org,
        mm-commits@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] cifs: Fix cifs_writepages_region()
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2675058.1677504045.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Mon, 27 Feb 2023 13:20:46 +0000
Message-ID: <2675059.1677504046@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Wilcox <willy@infradead.org> wrote:

> On Fri, Feb 24, 2023 at 12:16:49PM -0800, Linus Torvalds wrote:
> > On Fri, Feb 24, 2023 at 12:14 PM David Howells <dhowells@redhat.com> w=
rote:
> > >
> > > Then why do we have to wait for PG_writeback to complete?
> > =

> > At least for PG_writeback, it's about "the _previous_ dirty write is
> > still under way, but - since PG_dirty is set again - the page has been
> > dirtied since".
> > =

> > So we have to start _another_ writeback, because while the current
> > writeback *might* have written the updated data, that is not at all
> > certain or clear.
> =

> also, we only have a writeback bit, not a writeback count.  And when
> the current writeback completes, it'll clear that bit.  We're also
> being kind to our backing store and not writing to the same block twice
> at the same time.

It's not so much being kind to the backing store, I think, as avoiding the
possibility that the writes happen out of order.

> > I'm not sure what the fscache rules are.
> =

> My understanding is that the fscache bit is set under several
> circumstances, but if the folio is dirty _and_ the fscache bit
> is set, it means the folio is currently being written to the cache
> device.  I don't see a conflict there; we can write to the backing
> store and the cache device at the same time.

The dirty bit is nothing to do with it.  If the fscache bit is set, then t=
he
page is currently being written to the cache - and we need to wait before
starting another write.

Sometimes we start a write to the cache from a clean page (e.g. we just re=
ad
it from the server) and sometimes we start a write to the cache from
writepages (e.g. the data is dirty and we're writing it to the server as
well).

Things will become more 'interesting' should we ever get around to
implementing disconnected operation.  Then we might end up staging dirty d=
ata
through the cache.

David

