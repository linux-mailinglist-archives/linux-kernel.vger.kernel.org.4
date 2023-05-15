Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D0EC70383E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 19:30:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242648AbjEORaj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 13:30:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244355AbjEOR3w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 13:29:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B1CB12EBE;
        Mon, 15 May 2023 10:27:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B9EDB62D12;
        Mon, 15 May 2023 17:27:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7ADAFC433D2;
        Mon, 15 May 2023 17:27:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684171647;
        bh=43pq+UjSaKTzdKcTZSc3BjZWUVTfug1scezW8PiZqrk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JpvNX+YaG4tJFhX2g+ta2Lqd9ttaBntmdSfOrmrkY7aEGcTxyzXlcD3EZB3yHD+Hk
         3yjGOczbSA/wFXK4bdAiutdai1L9kf9sETK0MltEP1VeWS7hiL24IruwpOHUGWxDKD
         b4HYyFnL7fEbP8VTH8Vk75cHc1BuEu7CKM/Buqt4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, David Howells <dhowells@redhat.com>,
        Marc Dionne <marc.dionne@auristor.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-afs@lists.infradead.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 033/134] rxrpc: Fix hard call timeout units
Date:   Mon, 15 May 2023 18:28:30 +0200
Message-Id: <20230515161704.200160555@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161702.887638251@linuxfoundation.org>
References: <20230515161702.887638251@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Howells <dhowells@redhat.com>

[ Upstream commit 0d098d83c5d9e107b2df7f5e11f81492f56d2fe7 ]

The hard call timeout is specified in the RXRPC_SET_CALL_TIMEOUT cmsg in
seconds, so fix the point at which sendmsg() applies it to the call to
convert to jiffies from seconds, not milliseconds.

Fixes: a158bdd3247b ("rxrpc: Fix timeout of a call that hasn't yet been granted a channel")
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: "David S. Miller" <davem@davemloft.net>
cc: Eric Dumazet <edumazet@google.com>
cc: Jakub Kicinski <kuba@kernel.org>
cc: Paolo Abeni <pabeni@redhat.com>
cc: linux-afs@lists.infradead.org
cc: netdev@vger.kernel.org
cc: linux-kernel@vger.kernel.org
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/rxrpc/sendmsg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/rxrpc/sendmsg.c b/net/rxrpc/sendmsg.c
index d4e4e94f4f987..71e40f91dd398 100644
--- a/net/rxrpc/sendmsg.c
+++ b/net/rxrpc/sendmsg.c
@@ -736,7 +736,7 @@ int rxrpc_do_sendmsg(struct rxrpc_sock *rx, struct msghdr *msg, size_t len)
 		fallthrough;
 	case 1:
 		if (p.call.timeouts.hard > 0) {
-			j = msecs_to_jiffies(p.call.timeouts.hard);
+			j = p.call.timeouts.hard * HZ;
 			now = jiffies;
 			j += now;
 			WRITE_ONCE(call->expect_term_by, j);
-- 
2.39.2



