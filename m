Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 195A0732F1E
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 12:52:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344398AbjFPKwE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 06:52:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344818AbjFPKvg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 06:51:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EF30A26B
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 03:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686912120;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eIOLShY/ZmsNAmLuX2YSma08DfvRfpLXlZqs26cgyEs=;
        b=gMJINM/8dc+rZcH+EYIS3WDDj9Q4qX+rahxEXMDkTBzGXnH/YW2jNV8tnoeweAzG4OT3YV
        fU7VSEkFtvlwikm+xbMbBEmJB8nLx611xvoD0wBNmSKtl2MRajXhK65NfAK5CQQC9VvNKm
        aYE2YIsLt5d2OG8nCi4poQlskVPmAxE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-189-CGjzTS8uMVWdy5Eg3ByHXw-1; Fri, 16 Jun 2023 06:38:01 -0400
X-MC-Unique: CGjzTS8uMVWdy5Eg3ByHXw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2D5978028B2;
        Fri, 16 Jun 2023 10:38:01 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.51])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C5E20492C38;
        Fri, 16 Jun 2023 10:37:58 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <ZIw4+Go7ZIth+CsY@gondor.apana.org.au>
References: <ZIw4+Go7ZIth+CsY@gondor.apana.org.au> <1679829.1686785273@warthog.procyon.org.uk>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     dhowells@redhat.com, netdev@vger.kernel.org,
        syzbot+13a08c0bf4d212766c3c@syzkaller.appspotmail.com,
        syzbot+14234ccf6d0ef629ec1a@syzkaller.appspotmail.com,
        syzbot+4e2e47f32607d0f72d43@syzkaller.appspotmail.com,
        syzbot+472626bb5e7c59fb768f@syzkaller.appspotmail.com,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Matthew Wilcox <willy@infradead.org>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] crypto: af_alg/hash: Fix recvmsg() after sendmsg(MSG_MORE)
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <426352.1686911878.1@warthog.procyon.org.uk>
Date:   Fri, 16 Jun 2023 11:37:58 +0100
Message-ID: <426353.1686911878@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Can you have a look at:

	https://lore.kernel.org/r/415439.1686877276@warthog.procyon.org.uk/

I'm proposing that as an alternative to this patch.

David

