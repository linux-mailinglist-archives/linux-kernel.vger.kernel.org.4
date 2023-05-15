Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B9EA703459
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 18:47:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242582AbjEOQrR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 12:47:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243001AbjEOQrK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 12:47:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0215C1BE2;
        Mon, 15 May 2023 09:47:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 798CD62914;
        Mon, 15 May 2023 16:47:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AD44C4339B;
        Mon, 15 May 2023 16:47:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684169221;
        bh=zh/9JYGvcoSVjQ7npxV+BgPxVQexxuYJ23M0md2Kmdw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cIslEs2yQMckXwL5/Na8/0ePoLj2OJS9gernvA5rFeBS1JZvh+z6sn4u18xMqrlTi
         9X96zOY7e96hlRRQSRciZ5yArXIfqc8dZP2Q48BjUjG/eSz2Kiz5XuWZEZghy7gNHe
         NgLt94Xd8Ntq4UHii/+vj9y76A0oB0YRxXP/+PTg=
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
Subject: [PATCH 4.19 154/191] rxrpc: Fix hard call timeout units
Date:   Mon, 15 May 2023 18:26:31 +0200
Message-Id: <20230515161713.016576684@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161707.203549282@linuxfoundation.org>
References: <20230515161707.203549282@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
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
index a7a09eb04d93b..eaa032c498c96 100644
--- a/net/rxrpc/sendmsg.c
+++ b/net/rxrpc/sendmsg.c
@@ -709,7 +709,7 @@ int rxrpc_do_sendmsg(struct rxrpc_sock *rx, struct msghdr *msg, size_t len)
 		/* Fall through */
 	case 1:
 		if (p.call.timeouts.hard > 0) {
-			j = msecs_to_jiffies(p.call.timeouts.hard);
+			j = p.call.timeouts.hard * HZ;
 			now = jiffies;
 			j += now;
 			WRITE_ONCE(call->expect_term_by, j);
-- 
2.39.2



