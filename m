Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFA0070F91D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 16:50:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236014AbjEXOua (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 10:50:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235363AbjEXOuR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 10:50:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9C6A130
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 07:49:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684939772;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=6x0d7ICEdgzrcRTczgY+40SEU6mXT880gCShmbLBLHI=;
        b=Nf7DbeMad4/XRcgazI8BfdgZLgrMAD6J1Ov8fhKSZMN8j5L5Yr8/8NCe1/9TfkVMjywWqt
        vmhg2LW7rN5UQgIJb+/Z5rptSG63PL3oq1O1arVd6/V6X1cuslvDG+xZ8RLjURb1u+zX+v
        NUfswxgCSQ/VixUTCn440fVkRkqom5o=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-668-ZiIQyxGuNnic9eYKRn8upQ-1; Wed, 24 May 2023 10:49:28 -0400
X-MC-Unique: ZiIQyxGuNnic9eYKRn8upQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E9FFB3C397C6;
        Wed, 24 May 2023 14:49:27 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.39.192.68])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4FC9B1121314;
        Wed, 24 May 2023 14:49:26 +0000 (UTC)
From:   David Howells <dhowells@redhat.com>
To:     netdev@vger.kernel.org
Cc:     David Howells <dhowells@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        David Ahern <dsahern@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH net-next 0/4] splice, net: Replace sendpage with sendmsg(MSG_SPLICE_PAGES), part 2
Date:   Wed, 24 May 2023 15:49:19 +0100
Message-Id: <20230524144923.3623536-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here's the second tranche of patches towards providing a MSG_SPLICE_PAGES
internal sendmsg flag that is intended to replace the ->sendpage() op with
calls to sendmsg().  MSG_SPLICE_PAGES is a hint that tells the protocol
that it should splice the pages supplied if it can and copy them if not.

This set consists of the following parts:

 (1) Implement MSG_SPLICE_PAGES support in Chelsio TLS and make
     chtls_sendpage() just a wrapper around sendmsg().

 (2) Implement MSG_SPLICE_PAGES support in AF_KCM and make kcm_sendpage()
     just a wrapper around sendmsg().

I've pushed the patches here also:

	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?h=sendpage-2

David

Link: https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/commit/?id=51c78a4d532efe9543a4df019ff405f05c6157f6 # part 1

David Howells (4):
  chelsio: Support MSG_SPLICE_PAGES
  chelsio: Convert chtls_sendpage() to use MSG_SPLICE_PAGES
  kcm: Support MSG_SPLICE_PAGES
  kcm: Convert kcm_sendpage() to use MSG_SPLICE_PAGES

 .../chelsio/inline_crypto/chtls/chtls_io.c    | 121 ++--------
 net/kcm/kcmsock.c                             | 216 +++++-------------
 2 files changed, 74 insertions(+), 263 deletions(-)

