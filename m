Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 553E56D0047
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 11:55:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229898AbjC3JzF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 05:55:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230181AbjC3Jys (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 05:54:48 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2300B0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 02:54:46 -0700 (PDT)
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id CE74F3F22E
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 09:54:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1680170084;
        bh=T7mBxCfafRtBzm4CcOSBFKfHm4zEVrLF2OE++FUVsZo=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=ag+7bLwMLaQXgW057zXwxFJ2XPUwqi7UPRiylQLC16my+OGXlQKJWW41+F11Ai49a
         p8ACLZ2aK1/ACHlWzRnJ/vaD6hZZS/VmdZU3Z9BptjsNFCm8I98XfQTCgXdmosR3Np
         InGzyfszFYFgx/XyPnhVYlmbQM5sp3DhnAUqZnENfY2l/dJClV4OwQoya9jLFNmmaf
         UKwukcDPgwR4yAzW83j43QIUqOhmFMmyJCwo5qOacVqdKFMHb22GUvEBwcdNIYKbhB
         k4pTq6AM0eRMNH0DOOtrBimJAAd9xBkdhownS71bQu+4O1gZlPe18j1fexLpWmYhhl
         f00bt79uQlXvA==
Received: by mail-ed1-f71.google.com with SMTP id m18-20020a50d7d2000000b00501dfd867a4so26641680edj.20
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 02:54:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680170084; x=1682762084;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T7mBxCfafRtBzm4CcOSBFKfHm4zEVrLF2OE++FUVsZo=;
        b=XmAI2B3WWJN2CwMl45XaXhf8t+0VA4ep8z3k8tUyhiv3SA9bI6wD4ds3u31jhQiv3x
         Y70gAo4MPkQy0bzW/oI5+y0jJmzJZQFDtBZBeoSjAAGf03x0E1ypoUUmrtk90UwyZ+KK
         Z/8iF/WZWOLGk3V1cirk5KpFexwQZbuwAt8SGT4pjwqXxyj5G0R1vlBwq7DHhFk96yCH
         5vEw5imw41zZ16f66ahzoRA+RAfWEzk0hXYMByknhf3xJEnBXEJnisNw8xFH3Er5SZew
         K3OT8BMqSAAHNkkK+x9RCl4SGIqlprWH0GXqso4pI1pKACQqOvk8DB7lQl+HOvBCbdhL
         a4Rw==
X-Gm-Message-State: AAQBX9cNwsXOSiKoQ4vx8oal9r08hCCB4TzcKIsrm5RIBp+A2v2CXdHK
        iipXjzt1dqbvzYQLE1BNHLL7P1M61rp/acHragDErfPKEGI5BdjSiBNH13jS8UEM4hHBtg+x3MB
        tzOQvMm0OoJpY7uZfjFnkq98nvdWSDWIH9IC7+RIZGA==
X-Received: by 2002:a17:907:9a0c:b0:947:6fae:5d27 with SMTP id kr12-20020a1709079a0c00b009476fae5d27mr993709ejc.56.1680170084558;
        Thu, 30 Mar 2023 02:54:44 -0700 (PDT)
X-Google-Smtp-Source: AKy350bKhnnWvol18CEKvEou2r/IMLnBhwUZQdPMuSULagsmAa7GsWb+yLs5E05+GXwlM3D3VmFXXg==
X-Received: by 2002:a17:907:9a0c:b0:947:6fae:5d27 with SMTP id kr12-20020a1709079a0c00b009476fae5d27mr993692ejc.56.1680170084289;
        Thu, 30 Mar 2023 02:54:44 -0700 (PDT)
Received: from righiandr-XPS-13-7390.homenet.telecomitalia.it (host-79-33-132-140.retail.telecomitalia.it. [79.33.132.140])
        by smtp.gmail.com with ESMTPSA id lj24-20020a170906f9d800b00932ba722482sm16703862ejb.149.2023.03.30.02.54.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 02:54:44 -0700 (PDT)
From:   Andrea Righi <andrea.righi@canonical.com>
To:     David Miller <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     Shuah Khan <shuah@kernel.org>,
        Wojciech Drewek <wojciech.drewek@intel.com>,
        netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] l2tp: generate correct module alias strings
Date:   Thu, 30 Mar 2023 11:54:42 +0200
Message-Id: <20230330095442.363201-1-andrea.righi@canonical.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 65b32f801bfb ("uapi: move IPPROTO_L2TP to in.h") moved the
definition of IPPROTO_L2TP from a define to an enum, but since
__stringify doesn't work properly with enums, we ended up breaking the
modalias strings for the l2tp modules:

 $ modinfo l2tp_ip l2tp_ip6 | grep alias
 alias:          net-pf-2-proto-IPPROTO_L2TP
 alias:          net-pf-2-proto-2-type-IPPROTO_L2TP
 alias:          net-pf-10-proto-IPPROTO_L2TP
 alias:          net-pf-10-proto-2-type-IPPROTO_L2TP

Use the resolved number directly in MODULE_ALIAS_*() macros (as we
already do with SOCK_DGRAM) to fix the alias strings:

$ modinfo l2tp_ip l2tp_ip6 | grep alias
alias:          net-pf-2-proto-115
alias:          net-pf-2-proto-115-type-2
alias:          net-pf-10-proto-115
alias:          net-pf-10-proto-115-type-2

Moreover, fix the ordering of the parameters passed to
MODULE_ALIAS_NET_PF_PROTO_TYPE() by switching proto and type.

Fixes: 65b32f801bfb ("uapi: move IPPROTO_L2TP to in.h")
Link: https://lore.kernel.org/lkml/ZCQt7hmodtUaBlCP@righiandr-XPS-13-7390
Signed-off-by: Guillaume Nault <gnault@redhat.com>
Signed-off-by: Andrea Righi <andrea.righi@canonical.com>
---
 net/l2tp/l2tp_ip.c  | 8 ++++----
 net/l2tp/l2tp_ip6.c | 8 ++++----
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/net/l2tp/l2tp_ip.c b/net/l2tp/l2tp_ip.c
index 4db5a554bdbd..41a74fc84ca1 100644
--- a/net/l2tp/l2tp_ip.c
+++ b/net/l2tp/l2tp_ip.c
@@ -677,8 +677,8 @@ MODULE_AUTHOR("James Chapman <jchapman@katalix.com>");
 MODULE_DESCRIPTION("L2TP over IP");
 MODULE_VERSION("1.0");
 
-/* Use the value of SOCK_DGRAM (2) directory, because __stringify doesn't like
- * enums
+/* Use the values of SOCK_DGRAM (2) as type and IPPROTO_L2TP (115) as protocol,
+ * because __stringify doesn't like enums
  */
-MODULE_ALIAS_NET_PF_PROTO_TYPE(PF_INET, 2, IPPROTO_L2TP);
-MODULE_ALIAS_NET_PF_PROTO(PF_INET, IPPROTO_L2TP);
+MODULE_ALIAS_NET_PF_PROTO_TYPE(PF_INET, 115, 2);
+MODULE_ALIAS_NET_PF_PROTO(PF_INET, 115);
diff --git a/net/l2tp/l2tp_ip6.c b/net/l2tp/l2tp_ip6.c
index 2478aa60145f..5137ea1861ce 100644
--- a/net/l2tp/l2tp_ip6.c
+++ b/net/l2tp/l2tp_ip6.c
@@ -806,8 +806,8 @@ MODULE_AUTHOR("Chris Elston <celston@katalix.com>");
 MODULE_DESCRIPTION("L2TP IP encapsulation for IPv6");
 MODULE_VERSION("1.0");
 
-/* Use the value of SOCK_DGRAM (2) directory, because __stringify doesn't like
- * enums
+/* Use the values of SOCK_DGRAM (2) as type and IPPROTO_L2TP (115) as protocol,
+ * because __stringify doesn't like enums
  */
-MODULE_ALIAS_NET_PF_PROTO_TYPE(PF_INET6, 2, IPPROTO_L2TP);
-MODULE_ALIAS_NET_PF_PROTO(PF_INET6, IPPROTO_L2TP);
+MODULE_ALIAS_NET_PF_PROTO_TYPE(PF_INET6, 115, 2);
+MODULE_ALIAS_NET_PF_PROTO(PF_INET6, 115);
-- 
2.39.2

