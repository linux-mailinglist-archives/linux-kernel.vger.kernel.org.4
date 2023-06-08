Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5246772826F
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 16:13:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236737AbjFHONt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 10:13:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235991AbjFHONr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 10:13:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86D65E46
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 07:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686233579;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LQN1rSggYyPPSycUnq6KlPtxhprnsBF/y6WC2lvND9M=;
        b=W2ldDbxu//UAZx963E6nBe1zbady2al9LBXC6Gl1tmT2ikdfG9Bb7FkIa/BNIa0Zo8sjDY
        QsizOu23iSKOlg/Bz8XJoKZ2cLrib4eZiLQodyxS+YI6bHsKeVPWXg5czpOSufGpejOFTH
        lF+Mm3Lzhhwq9qSW3jbbA6jx0tqeu1E=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-481-x9Y7XCovMa--ExoHKtjaBg-1; Thu, 08 Jun 2023 10:12:56 -0400
X-MC-Unique: x9Y7XCovMa--ExoHKtjaBg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BA51F1C08DC0;
        Thu,  8 Jun 2023 14:12:55 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.182])
        by smtp.corp.redhat.com (Postfix) with ESMTP id ECCF42026D49;
        Thu,  8 Jun 2023 14:12:54 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20230323130412.32097-1-petr.pavlu@suse.com>
References: <20230323130412.32097-1-petr.pavlu@suse.com>
To:     Petr Pavlu <petr.pavlu@suse.com>
Cc:     dhowells@redhat.com, jarkko@kernel.org, keyrings@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] keys: Fix linking a duplicate key to a keyring's assoc_array
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2413880.1686233574.1@warthog.procyon.org.uk>
Date:   Thu, 08 Jun 2023 15:12:54 +0100
Message-ID: <2413881.1686233574@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Apologies for missing this patch.

Petr Pavlu <petr.pavlu@suse.com> wrote:

> * Back on the first task, function construct_alloc_key() first runs
>   __key_link_begin() to determine an assoc_array_edit operation to
>   insert a new key. Index keys in the array are compared exactly as-is,
>   using keyring_compare_object(). The operation finds that "abcdef" is
>   not yet present in the destination keyring.

Good catch, but I think it's probably the wrong solution.

keyring_compare_object() needs to use the ->cmp() function from the key type.

It's not just request_key() that might have a problem, but also key_link().

There are also asymmetric keys which match against multiple criteria - though
I'm fine with just matching the main description there (the important bit
being to maintain the integrity of the tree inside assoc_array).

I wonder, should I scrap the assoc_array approach and go to each keyring being
a linked-list?  It's slower, but a lot easier to manage - and more forgiving
of problems.

	struct key_ptr {
		struct list_head	link;
		struct key		*key;
		unsigned long		key_hash;
	};

I'm also wondering if I should remove the key type from the matching criteria
- i.e. there can only be one key with any particular description in a ring at
once, regardless of type.  Unfortunately, this is may be a UAPI breaker
somewhere.

Any thoughts?

David

