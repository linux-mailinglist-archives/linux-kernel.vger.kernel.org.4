Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 948CF72EB3A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 20:46:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231348AbjFMSqY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 14:46:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232686AbjFMSqU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 14:46:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F2B61BDC
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 11:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686681935;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SIDR2dqRwvLDufVgXSXj8KatzblZX0gs/2FHCG5UpAY=;
        b=h0ku6a2aIZa4cQbhSCtohVB9tPYhTSMnmKpX+Uh11jfbbDdRql5cXZTdBYVtbJ5562u3oZ
        1m6MY2SeVLArzZ9nq5b1i5fyaxpU0BAqGydOB1pMmkrvNP4AXtv/NKhqmARfLOvbkK7k3n
        La3gVkI4aN+eCu3oI+RTSiplnH4OOmY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-553-xTvb-8OnNO2OYEr7YExcXQ-1; Tue, 13 Jun 2023 14:45:32 -0400
X-MC-Unique: xTvb-8OnNO2OYEr7YExcXQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D9C97101A53B;
        Tue, 13 Jun 2023 18:45:23 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.67])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AF880492C1B;
        Tue, 13 Jun 2023 18:45:22 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20230613111505.249ccb18@kernel.org>
References: <20230613111505.249ccb18@kernel.org> <000000000000ae4cbf05fdeb8349@google.com>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     dhowells@redhat.com,
        syzbot <syzbot+d8486855ef44506fd675@syzkaller.appspotmail.com>,
        bpf@vger.kernel.org, davem@davemloft.net, dsahern@kernel.org,
        edumazet@google.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, pabeni@redhat.com,
        syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net?] KASAN: stack-out-of-bounds Read in skb_splice_from_iter
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <920481.1686681922.1@warthog.procyon.org.uk>
Date:   Tue, 13 Jun 2023 19:45:22 +0100
Message-ID: <920483.1686681922@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jakub Kicinski <kuba@kernel.org> wrote:

> Hi David, are you fighting all these fires reported by syzbot?
> I see another one just rolled in from yesterdays KCM changes.

I'm trying to pin down a bug in the old DIO code whilst attending the AFS
Workshop.  I'll get to the sendpage reports in a bit.  I think a bunch of them
are probably the same issue in AF_ALG hashing.  They do at least have
reproducers.

David

