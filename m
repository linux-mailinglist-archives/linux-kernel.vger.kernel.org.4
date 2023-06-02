Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1939871FE04
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 11:36:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234928AbjFBJg2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 05:36:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234361AbjFBJgV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 05:36:21 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27EA4E7
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 02:36:19 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4f50470d77cso2477703e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jun 2023 02:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1685698577; x=1688290577;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=t3hnBdT+4sofW6weHvtY0aB3YDwyxDO3yd2SZl1VkXg=;
        b=2wuqAodsy7HoWHGvVe5jW9OMuhCUSqCgb8Q0X68MCniJvVWk9vSjxsqaheCfDOBU8O
         24yDaRZOpd5J0iwC57SUBC+W7AlUTyQyZVNzxQyXE3BWnDp4h/vzBlhMvJXE/r3gDkLb
         WjnexhCx5w40GmlXK2o14O8O9cdTLSdVJQPp81Bpu6BE4w9iXFlXke4oS3FsjQ1Stjdy
         bMmu7yvhb6tfKKVnQPh6EnC/I5TuWLiEGVYu9UJi6uF8tmUevyGqwjpp2kIL7zcY7Fd6
         1qRcsy6jALhfJkXQkc1AZ5tHpuKziWKUX2JJz2zP1BQ+UUPS/cZFWLyWLg3Oo5Zp2aNO
         vbDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685698577; x=1688290577;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t3hnBdT+4sofW6weHvtY0aB3YDwyxDO3yd2SZl1VkXg=;
        b=lu88hM/dbN90Jqzij4fxoN+lYuHJo0GEzfC2v50Hx/w2EYR09tVXYoeVB/bhBLVn5e
         vZ69OIeS9XcAt0iq1Sp5WVlcaFHbs1YQmRGGOeQW+ahJge5eTD6dEqTc+/vikYn6Qj15
         Z+EElWevUy/BiqZqjNMXEgQghHcWx+1ULEHeeRwTsLtwgWR9EaaEw8iLH7rV44dR5iFG
         LUugeHhHFTnDZowmi3q7G/Iz1ZODlofsQrdaKQkfzLhJeL8ZGTKz0oXfhQ54TIYICxPp
         LI20Q1frSykz3yRONL3mpyX7xqGewgyVAwGoO9snjRpBs3tOkLlCnpWJFc9BvNMps5SU
         +lhw==
X-Gm-Message-State: AC+VfDzH6rf+b8ra1tUJEwU2iM5QB9DoFegyLaL3DXYE8jgixo+PC9Hh
        DJWtNhqhcf7/D+SWfXgyJz9gRg==
X-Google-Smtp-Source: ACHHUZ7qQeDUha9mDyy+gujyAY0nQj03FED/BjoEl5XPG1LJTS8xMalacGSsIUEV5xttDjR8WUG5Zw==
X-Received: by 2002:ac2:4824:0:b0:4db:1e4a:74a1 with SMTP id 4-20020ac24824000000b004db1e4a74a1mr1516894lft.0.1685698577315;
        Fri, 02 Jun 2023 02:36:17 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id 18-20020a05600c029200b003f601a31ca2sm1337446wmk.33.2023.06.02.02.36.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jun 2023 02:36:16 -0700 (PDT)
From:   Matthieu Baerts <matthieu.baerts@tessares.net>
Date:   Fri, 02 Jun 2023 11:36:07 +0200
Subject: [PATCH net-next] ipv6: lower "link become ready"'s level message
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230601-net-next-skip_print_link_becomes_ready-v1-1-7ff2b88dc9b8@tessares.net>
X-B4-Tracking: v=1; b=H4sIAAa4eWQC/5WOwQqDMBAFf0VybkoSjdCe+h9FQhK3dbGNkg2ii
 P/eKJSee3iHx8AwKyOICMSuxcoiTEg4hHzkqWC+s+EJHNv8mRKqFLWQPEDKmxOnHkczRgzJvDD
 0xoEf3kAmgm0Xrp1XtdattapiWeYsAXfRBt/tuq9lR2OEB85Hw/0Hmkw6pDTE5Yib5MH/7Zgkl
 9zLEurKy0pc9C0BkY1A52xgzbZtH2KCdjkEAQAA
To:     mptcp@lists.linux.dev, "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        David Ahern <dsahern@kernel.org>,
        Mat Martineau <martineau@kernel.org>,
        Stephen Hemminger <stephen@networkplumber.org>
Cc:     Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Matthieu Baerts <matthieu.baerts@tessares.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2795;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=U6Zkq3srBMQTPaEUG3HGzM57fXdxB8VpRxHgcFT+el8=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBkebgQCX/9JMKftJ5U7zjZIG1X6H1AAnSt9raUN
 Q69PhpcIq6JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZHm4EAAKCRD2t4JPQmmg
 c2fnD/wIHt1J8gTaEY6Rcdt3ayLx76pBwCzZswplm6GiaI/S8iZLz455CLHoimDPXcXBSpAUyoL
 kWp/OQkiH975/TGlrBDM4BwCxBz0ARMag/uKrruFCcM5f6aNe7ySXfZ31EU3+JM04CnrZG8uSKY
 UPChOnXVtmj6M5JO4kd/oS/YxRSoHs1vwl1/khOvmPWAuPyR/mMqp6+LGq6GA3yrI8jh4fFV3Y/
 0SgIhKBuZ7fPkNqf3GQcRQovUFymy2xrv6SxnbgKq+PlzgzN2RSo6vioTAIssIDdvBQIdAvYz06
 cu7RaU2TK9aej11QEMO+f54t8WtzJAecJEbUw3gy2mxmp5rlQHqUlpjCd7dloQoE0pjQMk23iY7
 /EVBfwTzCCb6Iv1pYUJewm8WTfkrFssO0+mb3DFXHfossfEfKnba4NE4jVjkBIyWskZBY8hasmw
 MKJUW/rsG+o4JtbV9gzjc6WOkM75IdxPAAnKXqcv3bTsWzEiJ6cctRY0NZawt/jV9662Ez/SUru
 e4wO3PU5iT1UK8jksUMzhmFyQ2v93J0eQbjYwb4q9D0D+WJFqUnS8nkIbArunPiasf/w2aANQk5
 RQPS/folm9oM8hN/6ycoOvaE3kGvmXH/PzQcSuVyt6FxuhVfn4WfTk92+0iJqi5AefH6sh5hxo+
 pUqGEH8nxY9tbMg==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This following message is printed in the console each time a network
device configured with an IPv6 addresses is ready to be used:

  ADDRCONF(NETDEV_CHANGE): <iface>: link becomes ready

When netns are being extensively used -- e.g. by re-creating netns' with
veth to discuss with each others for testing purposes like mptcp_join.sh
selftest does -- it generates a lot of messages like that: more than 700
when executing mptcp_join.sh with the latest version.

It looks like this message is not that helpful after all: maybe it can
be used as a sign to know if there is something wrong, e.g. if a device
is being regularly reconfigured by accident? But even then, there are
better ways to monitor and diagnose such issues.

When looking at commit 3c21edbd1137 ("[IPV6]: Defer IPv6 device
initialization until the link becomes ready.") which introduces this new
message, it seems it had been added to verify that the new feature was
working as expected. It could have then used a lower level than "info"
from the beginning but it was fine like that back then: 17 years ago.

It seems then OK today to simply lower its level, similar to commit
7c62b8dd5ca8 ("net/ipv6: lower the level of "link is not ready" messages")
and as suggested by Mat [1], Stephen and David [2].

Link: https://lore.kernel.org/mptcp/614e76ac-184e-c553-af72-084f792e60b0@kernel.org/T/ [1]
Link: https://lore.kernel.org/netdev/68035bad-b53e-91cb-0e4a-007f27d62b05@tessares.net/T/ [2]
Suggested-by: Mat Martineau <martineau@kernel.org>
Suggested-by: Stephen Hemminger <stephen@networkplumber.org>
Suggested-by: David Ahern <dsahern@kernel.org>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
RFC to v1:
- Thanks to Stephen and David's feedback, this new version is smaller
  and simpler: only the level of the problematic message is changed, no
  more sysctl.
- Link to RFC: https://lore.kernel.org/r/20230601-net-next-skip_print_link_becomes_ready-v1-1-c13e64c14095@tessares.net
---
 net/ipv6/addrconf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index 3797917237d0..5479da08ef40 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -3633,8 +3633,8 @@ static int addrconf_notify(struct notifier_block *this, unsigned long event,
 				idev->if_flags |= IF_READY;
 			}
 
-			pr_info("ADDRCONF(NETDEV_CHANGE): %s: link becomes ready\n",
-				dev->name);
+			pr_debug("ADDRCONF(NETDEV_CHANGE): %s: link becomes ready\n",
+				 dev->name);
 
 			run_pending = 1;
 		}

---
base-commit: a395b8d1c7c3a074bfa83b9759a4a11901a295c5
change-id: 20230601-net-next-skip_print_link_becomes_ready-5bc2655daa24

Best regards,
-- 
Matthieu Baerts <matthieu.baerts@tessares.net>

