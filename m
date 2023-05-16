Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C54B7057CB
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 21:47:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230015AbjEPTq7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 15:46:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjEPTq5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 15:46:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0A24468B
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 12:46:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4F7B563D0B
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 19:46:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 832C2C433D2;
        Tue, 16 May 2023 19:46:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684266412;
        bh=Retqq5JfF+1v3Y0juT8ukUupAtMcuR+tzDBH2kPz0nA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CYoYaBX+m/LPk4VBRp8JNpVscrno+XDoOxsbtT049WnQxI9/kSv1bR5kiaTmgxUUy
         yyC7zNWfHk1n1+Bj8Et1dY92a6p0p51q4zMvCDb9u/iIFhC965iehJ9+OHPWqp9bok
         8fR9wBQWSjY95WV68eJL+MIsjiuxWDC3uu+Jjzd0BE4+In115Zc1eGavYGPScFq5OB
         6WFmKjetm6poZK2aA6o+B7/MSKLwV/Sim4gAPGVazWEZDClKW9/9Ibhr3Xv7uzOEp1
         5qU0+8VwZdehpR7d99IB8cS41Y3EeSlnta9+f3e9RwtJ+zwAvcGzKZJEpKMztEPuVn
         DkgRIf/FWV1mw==
From:   Arnd Bergmann <arnd@kernel.org>
To:     netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Roopa Prabhu <roopa@nvidia.com>,
        Nikolay Aleksandrov <razor@blackwall.org>,
        bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] bridge: always declare tunnel functions
Date:   Tue, 16 May 2023 21:45:35 +0200
Message-Id: <20230516194625.549249-3-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230516194625.549249-1-arnd@kernel.org>
References: <20230516194625.549249-1-arnd@kernel.org>
MIME-Version: 1.0
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

From: Arnd Bergmann <arnd@arndb.de>

When CONFIG_BRIDGE_VLAN_FILTERING is disabled, two functions are still
defined but have no prototype or caller. This causes a W=1 warning for
the missing prototypes:

net/bridge/br_netlink_tunnel.c:29:6: error: no previous prototype for 'vlan_tunid_inrange' [-Werror=missing-prototypes]
net/bridge/br_netlink_tunnel.c:199:5: error: no previous prototype for 'br_vlan_tunnel_info' [-Werror=missing-prototypes]

The functions are already contitional on CONFIG_BRIDGE_VLAN_FILTERING,
and I coulnd't easily figure out the right set of #ifdefs, so just
move the declarations out of the #ifdef to avoid the warning,
at a small cost in code size over a more elaborate fix.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 net/bridge/br_private_tunnel.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/bridge/br_private_tunnel.h b/net/bridge/br_private_tunnel.h
index 2b053289f016..efb096025151 100644
--- a/net/bridge/br_private_tunnel.h
+++ b/net/bridge/br_private_tunnel.h
@@ -27,6 +27,10 @@ int br_process_vlan_tunnel_info(const struct net_bridge *br,
 int br_get_vlan_tunnel_info_size(struct net_bridge_vlan_group *vg);
 int br_fill_vlan_tunnel_info(struct sk_buff *skb,
 			     struct net_bridge_vlan_group *vg);
+bool vlan_tunid_inrange(const struct net_bridge_vlan *v_curr,
+			const struct net_bridge_vlan *v_last);
+int br_vlan_tunnel_info(const struct net_bridge_port *p, int cmd,
+			u16 vid, u32 tun_id, bool *changed);
 
 #ifdef CONFIG_BRIDGE_VLAN_FILTERING
 /* br_vlan_tunnel.c */
@@ -43,10 +47,6 @@ void br_handle_ingress_vlan_tunnel(struct sk_buff *skb,
 				   struct net_bridge_vlan_group *vg);
 int br_handle_egress_vlan_tunnel(struct sk_buff *skb,
 				 struct net_bridge_vlan *vlan);
-bool vlan_tunid_inrange(const struct net_bridge_vlan *v_curr,
-			const struct net_bridge_vlan *v_last);
-int br_vlan_tunnel_info(const struct net_bridge_port *p, int cmd,
-			u16 vid, u32 tun_id, bool *changed);
 #else
 static inline int vlan_tunnel_init(struct net_bridge_vlan_group *vg)
 {
-- 
2.39.2

