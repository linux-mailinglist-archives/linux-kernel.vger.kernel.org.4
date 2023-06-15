Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BDE9731B30
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 16:22:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240015AbjFOOWc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 10:22:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245661AbjFOOW3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 10:22:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD45E297B
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 07:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686838899;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WNUJrv1eNB4SMwqhnEsBfDZoOO86Im2l2qkR71QzBpA=;
        b=PHz0n2YJ41MA+BffAtLCqx7mniUG9pXaxGhXWFuLQD7ipJP85KsbvqZ2hhYj6CxZr9zY6m
        XcMOb4j3k1/zVVkI7lo5Tmxt+MOktL4HslmVI5Adh5aFwEvzyM25Md2hbuJxdooausJ0GV
        zFZB8wwgOQYYbyhd6zHhGoM/X7jq6rI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-175-D2E1aklHMlapWqMh_9I3vw-1; Thu, 15 Jun 2023 10:21:35 -0400
X-MC-Unique: D2E1aklHMlapWqMh_9I3vw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 03702806000;
        Thu, 15 Jun 2023 14:21:35 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.51])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9A8352166B25;
        Thu, 15 Jun 2023 14:21:33 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <1657853.1686757902@warthog.procyon.org.uk>
References: <1657853.1686757902@warthog.procyon.org.uk> <000000000000b2585a05fdeb8379@google.com>
To:     herbert@gondor.apana.org.au
Cc:     dhowells@redhat.com,
        syzbot <syzbot+6efc50cc1f8d718d6cb7@syzkaller.appspotmail.com>,
        davem@davemloft.net, kuba@kernel.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [crypto?] KASAN: slab-out-of-bounds Read in extract_iter_to_sg
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <189807.1686838892.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Thu, 15 Jun 2023 15:21:32 +0100
Message-ID: <189808.1686838892@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

David Howells <dhowells@redhat.com> wrote:

> @@ -83,26 +83,14 @@ static int hash_sendmsg(struct socket *sock, struct =
msghdr *msg,

Actually, this patch definitely won't fix this bug since the test is using=
 an
skcipher not a hash.

David

