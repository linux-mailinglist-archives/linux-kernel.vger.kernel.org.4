Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3B766C71B8
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 21:40:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230506AbjCWUkw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 16:40:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229997AbjCWUku (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 16:40:50 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCC381E9F1;
        Thu, 23 Mar 2023 13:40:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 51C17B8224C;
        Thu, 23 Mar 2023 20:40:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEB8EC433EF;
        Thu, 23 Mar 2023 20:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679604046;
        bh=AU1TdyoB8zhc8vEYalC7k4O460M1RgZWUgFB7iLob3Y=;
        h=Date:From:To:Subject:From;
        b=tqgxbhv6mqkp3VieEzLnD9QKqbX0If1rJTPXT0z1Z2bKfQkqIpbsvBngPwvqed/fv
         FXXUjo+bolHV7TlSErE5YialZvIDdtKE2v5qRwStYcBOhOFjLGHTflvS7te65qop6k
         3BtnvVl2QGcsabVpCtTVOr8MsTtu/DdJoPEckkUuy3WoCRQl7wwG9vRuQIPUHImFZe
         zX9yEME1wiTV5LBzXt2G0YKVW9Yp49S3CTuft+nUGyZUgT4fkVJWjebu/wttJb6u8b
         UTcEBxAyNuzkeTsJ7f8xzWJxCkJ6F3M1F5kQRMjfjF0WT3RELu2pT1tm7aqCr/z7L0
         XP9+NSL4Syriw==
Date:   Thu, 23 Mar 2023 14:41:16 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH][next] uapi: net: ipv6: Replace fake flex-array with
 flex-array member
Message-ID: <ZBy5bNygP5yxnE9k@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Zero-length arrays as fake flexible arrays are deprecated and we are
moving towards adopting C99 flexible-array members instead.

Address the following warning found with GCC-13 and
-fstrict-flex-arrays=3 enabled:
net/ipv6/exthdrs.c: In function ‘fl6_update_dst’:
net/ipv6/exthdrs.c:1393:28: warning: array subscript 0 is outside array bounds of ‘struct in6_addr[0]’ [-Warray-bounds=]
 1393 |                 fl6->daddr = *((struct rt0_hdr *)opt->srcrt)->addr;
      |                 ~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
In file included from ./include/linux/ipv6.h:5,
                 from ./include/linux/icmpv6.h:6,
                 from net/ipv6/exthdrs.c:27:
./include/uapi/linux/ipv6.h:84:33: note: while referencing ‘addr’
   84 |         struct in6_addr         addr[0];
      |                                 ^~~~
net/ipv6/exthdrs.c: In function ‘ipv6_push_rthdr0.isra’:
net/ipv6/exthdrs.c:1125:19: warning: array subscript <unknown> is outside array bounds of ‘struct in6_addr[0]’ [-Warray-bounds=]
 1125 |         phdr->addr[hops - 1] = **addr_p;
      |         ~~~~~~~~~~^~~~~~~~~~
./include/uapi/linux/ipv6.h:84:33: note: while referencing ‘addr’
   84 |         struct in6_addr         addr[0];
      |                                 ^~~~

This helps with the ongoing efforts to tighten the FORTIFY_SOURCE
routines on memcpy() and help us make progress towards globally
enabling -fstrict-flex-arrays=3 [1].

Link: https://github.com/KSPP/linux/issues/21
Link: https://github.com/KSPP/linux/issues/276
Link: https://gcc.gnu.org/pipermail/gcc-patches/2022-October/602902.html [1]
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 include/uapi/linux/ipv6.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/linux/ipv6.h b/include/uapi/linux/ipv6.h
index 53326dfc59ec..ac56605fe9bc 100644
--- a/include/uapi/linux/ipv6.h
+++ b/include/uapi/linux/ipv6.h
@@ -81,7 +81,7 @@ struct ipv6_opt_hdr {
 struct rt0_hdr {
 	struct ipv6_rt_hdr	rt_hdr;
 	__u32			reserved;
-	struct in6_addr		addr[0];
+	struct in6_addr		addr[];
 
 #define rt0_type		rt_hdr.type
 };
-- 
2.34.1

