Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2E5C746DE1
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 11:44:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230519AbjGDJoH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 05:44:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230334AbjGDJne (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 05:43:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBAF41996
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 02:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688463710;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zLSEosjlinrCxKCLRBdlkkdM07HJXUp3DKjWoDpchWo=;
        b=BmO1hTry8LXUZPn1AsPPS4fXe/hWf5iyfG4fi5WyyP2JJZguAV/tx2c8orHqTZNiu4Vsqx
        D5zdtbnOdq3ggEt/3KiEKSzVexY7fYs395FC0ByCunJviH4TH5JtmGvOHLpoot8xnPih/F
        npCk56EuajAvTLFm+/zhz/CY24kQi2o=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-447-UDuYkHNINm63hneICkQI6g-1; Tue, 04 Jul 2023 05:41:47 -0400
X-MC-Unique: UDuYkHNINm63hneICkQI6g-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6201C3814950;
        Tue,  4 Jul 2023 09:41:47 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.195])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 81309492C13;
        Tue,  4 Jul 2023 09:41:46 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <ZKPgkgiddAl9qddT@gondor.apana.org.au>
References: <ZKPgkgiddAl9qddT@gondor.apana.org.au> <CAAUqJDvFuvms55Td1c=XKv6epfRnnP78438nZQ-JKyuCptGBiQ@mail.gmail.com> <1357760.1688460637@warthog.procyon.org.uk>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     dhowells@redhat.com, Ondrej Mosnacek <omosnacek@gmail.com>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        regressions@lists.linux.dev
Subject: Re: Regression bisected to "crypto: af_alg: Convert af_alg_sendpage() to use MSG_SPLICE_PAGES"
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1361503.1688463705.1@warthog.procyon.org.uk>
Date:   Tue, 04 Jul 2023 10:41:45 +0100
Message-ID: <1361504.1688463705@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Herbert Xu <herbert@gondor.apana.org.au> wrote:

> All it's saying is that if you modify the data after sending it off
> via splice then the data that will be on the wire is undefined.

Er, no.  It can literally remove the page from the process's VM and paste it
somewhere else - though in this case, that shouldn't happen.  However, the
buffer passed to SPLICE_F_GIFT should also be page-aligned, which it might not
be because they used calloc().

There's no reason to use SPLICE_F_GIFT here.  vmsplice() still attaches the 

> There is no reason why this should crash.

Agreed.  I'm still looking at it.  Interestingly, the output comes out the
same, no matter whether vmsplice(), vmsplice() + SPLICE_F_GIFT or writev(), so
it looks like the buffers get to 

> If we can't fix this the patches should be reverted.

I didn't change vmsplice() or the way pages are stored in the pipe.

And, note, there are also a bunch of GUP changes that could have an effect.

David

