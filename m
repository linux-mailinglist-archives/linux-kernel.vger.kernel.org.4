Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17674733C89
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 00:43:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232180AbjFPWnw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 18:43:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbjFPWnu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 18:43:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57012359D
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 15:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686955388;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xil8pYQHFvvvTl9T7ZZLQkZeu1j0WF7ytBjn1P1WCeA=;
        b=VpqtiYrkk1WEwApRkU5EzodIPxzuJfyMBTADhkJn6jAOBY/XCuFa1tyWeo+GoCu1W+rVYT
        N47WizLdlwk+CukPhl+edETOG9b8k3QkhT4gjMnxATmbbLqvKBJoSq+ZAEFrghjWb0FXc1
        ptRre7vfQ+OHlFVzURAvU8k9PdiVD+o=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-607-zpiW6TjfOayuMdK63qkmJg-1; Fri, 16 Jun 2023 18:43:05 -0400
X-MC-Unique: zpiW6TjfOayuMdK63qkmJg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 166873855576;
        Fri, 16 Jun 2023 22:43:04 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.51])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 77724C1603B;
        Fri, 16 Jun 2023 22:43:03 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20230608175031.9c534e7f554de89e3d972ab2@linux-foundation.org>
References: <20230608175031.9c534e7f554de89e3d972ab2@linux-foundation.org> <20230607204120.89416-1-vishal.moola@gmail.com> <20230607204120.89416-2-vishal.moola@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     dhowells@redhat.com,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
        linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] afs: Fix waiting for writeback then skipping folio
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <702178.1686955382.1@warthog.procyon.org.uk>
Date:   Fri, 16 Jun 2023 23:43:02 +0100
Message-ID: <702179.1686955382@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@linux-foundation.org> wrote:

> > Commit acc8d8588cb7 converted afs_writepages_region() to write back a
> > folio batch. The function waits for writeback to a folio, but then
> > proceeds to the rest of the batch without trying to write that folio
> > again. This patch fixes has it attempt to write the folio again.
> > 
> > This has only been compile tested.
> 
> This seems fairly serious?

We will try to write the again later, but sync()/fsync() might now have
skipped it.

> From my reading, we'll fail to write out the dirty data.  Presumably
> not easily observable, as it will get written out again later on.

As it's a network filesystem, interactions with third parties could cause
apparent corruption.  Closing a file will flush it - but if there's a
simultaneous op of some other kind, a bit of a flush or a sync may get missed
and the copy visible to another user be temporarily missing that bit.

> But we're also calling afs_write_back_from_locked_folio() with an unlocked
> folio, which might cause mayhem.

Without this patch, you mean?  There's a "continue" statement that should send
us back to the top of the loop before we get as far as
afs_write_back_from_locked_folio() - and then the folio_unlock() there would
go bang.

David

