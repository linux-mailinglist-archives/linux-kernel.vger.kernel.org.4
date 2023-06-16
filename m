Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AC82732C89
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 11:56:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234815AbjFPJ4z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 05:56:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230420AbjFPJ4w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 05:56:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FD97297E
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 02:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686909371;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LRrap5sa/SGfzSyFM8C7uu+zlqlVKh+fF2QdwlihjcY=;
        b=XLHXKu5qkRqu8bTGnLbAnsMyLFIYysnvnUbmoXmzir8qaVLFFZrqaH/XJ3ag8k2dLFTFdx
        Fa8pLknFmPdjcZ5dBJOIZ04baawyiy0diRR0GMDyUpdTGqo6qxE3+fUTg75ONhW5vnbK2m
        ZjULZBbDVQ9xbjSIx33u/i9y7Zi+/Vg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-558-JeIIq2TmOLOvMpnKv8FXmQ-1; Fri, 16 Jun 2023 05:56:07 -0400
X-MC-Unique: JeIIq2TmOLOvMpnKv8FXmQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 719CF101A52A;
        Fri, 16 Jun 2023 09:56:07 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.51])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2508A40D1B60;
        Fri, 16 Jun 2023 09:56:06 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20230615205014.8d7eb4457ca9bc676a79d2db@linux-foundation.org>
References: <20230615205014.8d7eb4457ca9bc676a79d2db@linux-foundation.org> <20230616115856.3ce7682c@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     dhowells@redhat.com, Stephen Rothwell <sfr@canb.auug.org.au>,
        Jens Axboe <axboe@kernel.dk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: Re: linux-next: manual merge of the block tree with the mm tree
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <424128.1686909362.1@warthog.procyon.org.uk>
Date:   Fri, 16 Jun 2023 10:56:02 +0100
Message-ID: <424129.1686909362@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@linux-foundation.org> wrote:

> That's getting a bit nasty.  Maybe David's patches are in the wrong tree.

You'd need to discuss that one with Jens.  The patches you'd have to transfer
also touch a number of block-related files.  Looking at block/for-next, there
don't seem to be many other patches touching those files, but I've seen
patches from Christoph that will need to be applied on top of mine.

David

