Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 922FB736506
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 09:43:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231455AbjFTHnl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 03:43:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230129AbjFTHnN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 03:43:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FDA4E68
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 00:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687246942;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+92FxVTjgy7f+sZL0/WEWN3/mD2r8Rpsadm+H0B45no=;
        b=bRtYiPbeZlYCfAzLM1wd3uAoB8s0biMwBUqFDV1FB0id90e3cYsmT2hz13VRYM6U11X+zh
        Lk7eaiMp0ill/T3l2TssbQo/iQKZewJT8Q21Glba5sy/oiKM0p9MLPzzoY5nz5XyuEUTG4
        tOIVd2Z8wSERB4+kT3rxu1wj6O7FeGg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-650-7mogXHEzOlejoLY2g7uzpg-1; Tue, 20 Jun 2023 03:42:19 -0400
X-MC-Unique: 7mogXHEzOlejoLY2g7uzpg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3AB02811E9E;
        Tue, 20 Jun 2023 07:42:18 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.4])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 91756492CA6;
        Tue, 20 Jun 2023 07:42:16 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <ZJEwPLudZlrInzYs@gondor.apana.org.au>
References: <ZJEwPLudZlrInzYs@gondor.apana.org.au> <427646.1686913832@warthog.procyon.org.uk>
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
Subject: Re: [PATCH net-next v2] crypto: af_alg/hash: Fix recvmsg() after sendmsg(MSG_MORE)
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1220920.1687246935.1@warthog.procyon.org.uk>
Date:   Tue, 20 Jun 2023 08:42:15 +0100
Message-ID: <1220921.1687246935@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Herbert Xu <herbert@gondor.apana.org.au> wrote:

> > +		hash_free_result(sk, ctx);
> 
> Please revert this change as I explained in the other message.
> 
> > +		if (!msg_data_left(msg))
> > +			goto done; /* Zero-length; don't start new req */
> 
> This is still broken in the case of a zero-length message with
> MSG_MORE set.  Here you will short-circuit out without ever calling
> crypto_ahash_init.  However, hash_recvmsg will directly call
> crypto_ahash_final on this, which is undefined.

Not so.  hash_recvmsg() will call crypto_ahash_init() first because ctx->more
is false (hence why we came down this branch in hash_sendmsg()) and the result
was released on the previous line (which you're objecting to).  If it goes to
the "done" label, it will skip setting ctx->more to true if MSG_MORE is
passed.

However, given you want sendmsg() to do the init->digest cycle on zero length
data, I think we should revert to the previous version of the patch that makes
a pass of the loop even with no data.

David

