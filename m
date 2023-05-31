Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82FB9717D81
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 13:01:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235101AbjEaLBN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 07:01:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235057AbjEaLBK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 07:01:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64F5412E
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 04:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685530820;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=ritQCRwG6JPNw2IlJoit4EL/5tJVr9K/iaMGx8C/GDs=;
        b=Um0TiZX7z+Zl1FCQEZxlC8stE3eYb+MoXiWqUXBzNX0HOjjHxc2MXeYvoadnkDkLDOpgwv
        QCuvsW+sXWYP8QsSDmKuaB85yMeYa6KnosjbDrffnFAFwYgYRwzaJCs7YWNKt+/RqHi2Up
        xeCvT3vUIdVeee9+z71DeAMuvRuV8MU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-413-8IoEmobkOseDjtIKySDr4Q-1; Wed, 31 May 2023 07:00:19 -0400
X-MC-Unique: 8IoEmobkOseDjtIKySDr4Q-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 25D6585A5BA;
        Wed, 31 May 2023 11:00:18 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.182])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CF32A140E963;
        Wed, 31 May 2023 11:00:14 +0000 (UTC)
From:   David Howells <dhowells@redhat.com>
To:     netdev@vger.kernel.org
Cc:     David Howells <dhowells@redhat.com>,
        Ayush Sawal <ayush.sawal@chelsio.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        David Ahern <dsahern@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>,
        Simon Horman <simon.horman@corigine.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 0/2] splice, net: Handle MSG_SPLICE_PAGES in Chelsio-TLS
Date:   Wed, 31 May 2023 12:00:06 +0100
Message-ID: <20230531110008.642903-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here are patches to make Chelsio-TLS handle the MSG_SPLICE_PAGES internal
sendmsg flag.  MSG_SPLICE_PAGES is an internal hint that tells the protocol
that it should splice the pages supplied if it can.  Its sendpage
implementation is then turned into a wrapper around that.

I've pushed the patches here also:

	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?h=sendpage-2-chelsio

David

ver #2)
 - Wrap at 80 chars.

Link: https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/commit/?id=51c78a4d532efe9543a4df019ff405f05c6157f6 # part 1
Link: https://lore.kernel.org/r/20230524144923.3623536-1-dhowells@redhat.com/ # v1

David Howells (2):
  chelsio: Support MSG_SPLICE_PAGES
  chelsio: Convert chtls_sendpage() to use MSG_SPLICE_PAGES

 .../chelsio/inline_crypto/chtls/chtls_io.c    | 121 +++---------------
 1 file changed, 18 insertions(+), 103 deletions(-)

