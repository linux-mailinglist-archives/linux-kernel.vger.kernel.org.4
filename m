Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E5AA701DB3
	for <lists+linux-kernel@lfdr.de>; Sun, 14 May 2023 16:01:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233590AbjENOBM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 May 2023 10:01:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbjENOBI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 May 2023 10:01:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30DE91BD5
        for <linux-kernel@vger.kernel.org>; Sun, 14 May 2023 07:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684072820;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=5XPWFCwn0ec1Bk7N8aYQ4DY3w3ZSXgJSesqW7FrFphE=;
        b=AxBlYgdtYiyRpm5s+M6zPxXXIDETxpw++AauWnQPBz+s+8D9O/0SDHx4m8nfId4tLsN6m/
        3TEkOeuwi05NfAMp1vluhln14A7uzXobCClJYj9HUL356EhFhHBZOo/dfyHfbp/I+Qv6Nj
        Gg+PS3vZ8gD0YXzzmPqluz5n7EcdK5Q=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-286-QoVv7HoJNgaoyT8JVKlNcA-1; Sun, 14 May 2023 10:00:18 -0400
X-MC-Unique: QoVv7HoJNgaoyT8JVKlNcA-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7577727a00eso2845396285a.1
        for <linux-kernel@vger.kernel.org>; Sun, 14 May 2023 07:00:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684072818; x=1686664818;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5XPWFCwn0ec1Bk7N8aYQ4DY3w3ZSXgJSesqW7FrFphE=;
        b=WhWTa8AX7mNt9IP/EW4Mzv8ZZtvnXy/ZiEZSJIO+6NB726AxyYj9Yxa+pmJV/xEsmK
         NrXNu/CYl8YYUoDma7ErsbHV61xmPr2YFNDey9R8pr8OSRIfbGYwLijiQCkyACtPJRLa
         KY/5S58DSByB+T8yFm85Ci84rP+5LxiCMr+7WyLlT5HMFxhoG/Tlp039/hQkGa9Y2OvL
         F5LGpxaXLRBnQlx3U13KO/sCTh5wv7KXSX4n07GxDhWFC/Fz0xo3jAz+f6mjJw8DC9KW
         PczPS1RFGb99tGs6ejO8Z7E7HOWYsiHZ/zsQwcNv3d7uwI1H/woxASxyuzlt/LPkESIe
         F8vQ==
X-Gm-Message-State: AC+VfDzXcag4mcu5RE5yq9Nls8zofIGo2izMjIwZEpgKO5NHsY2fIKjo
        yPUfbUtXRpKQWAic4zsGQCv+LPbtZMZEtO2rt1iszj5YakTfqV6O0zVP9cv0dTGeoee8NGECKL/
        hj+BJNtpXBkuun65Et4d7TgOc
X-Received: by 2002:a05:6214:1d26:b0:5ef:d5b0:c33f with SMTP id f6-20020a0562141d2600b005efd5b0c33fmr68583123qvd.2.1684072818272;
        Sun, 14 May 2023 07:00:18 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6ZxEJVXSJj22FdfeUHUFCbHqGYuIFy6aJ+7s6HEds/c8wbbuyT8d6HxTccrfjHe12gZcWZvw==
X-Received: by 2002:a05:6214:1d26:b0:5ef:d5b0:c33f with SMTP id f6-20020a0562141d2600b005efd5b0c33fmr68583067qvd.2.1684072817948;
        Sun, 14 May 2023 07:00:17 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id ev11-20020a0562140a8b00b0061668c4b426sm4304678qvb.59.2023.05.14.07.00.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 May 2023 07:00:17 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     pablo@netfilter.org, kadlec@netfilter.org, fw@strlen.de,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com
Cc:     netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] netfilter: conntrack: define variables exp_nat_nla_policy and any_addr with CONFIG_NF_NAT
Date:   Sun, 14 May 2023 10:00:10 -0400
Message-Id: <20230514140010.3399219-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

gcc with W=1 and ! CONFIG_NF_NAT
net/netfilter/nf_conntrack_netlink.c:3463:32: error:
  ‘exp_nat_nla_policy’ defined but not used [-Werror=unused-const-variable=]
 3463 | static const struct nla_policy exp_nat_nla_policy[CTA_EXPECT_NAT_MAX+1] = {
      |                                ^~~~~~~~~~~~~~~~~~
net/netfilter/nf_conntrack_netlink.c:2979:33: error:
  ‘any_addr’ defined but not used [-Werror=unused-const-variable=]
 2979 | static const union nf_inet_addr any_addr;
      |                                 ^~~~~~~~

These variables use is controlled by CONFIG_NF_NAT, so should their definitions.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 net/netfilter/nf_conntrack_netlink.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/netfilter/nf_conntrack_netlink.c b/net/netfilter/nf_conntrack_netlink.c
index d40544cd61a6..69c8c8c7e9b8 100644
--- a/net/netfilter/nf_conntrack_netlink.c
+++ b/net/netfilter/nf_conntrack_netlink.c
@@ -2976,7 +2976,9 @@ static int ctnetlink_exp_dump_mask(struct sk_buff *skb,
 	return -1;
 }
 
+#if IS_ENABLED(CONFIG_NF_NAT)
 static const union nf_inet_addr any_addr;
+#endif
 
 static __be32 nf_expect_get_id(const struct nf_conntrack_expect *exp)
 {
@@ -3460,10 +3462,12 @@ ctnetlink_change_expect(struct nf_conntrack_expect *x,
 	return 0;
 }
 
+#if IS_ENABLED(CONFIG_NF_NAT)
 static const struct nla_policy exp_nat_nla_policy[CTA_EXPECT_NAT_MAX+1] = {
 	[CTA_EXPECT_NAT_DIR]	= { .type = NLA_U32 },
 	[CTA_EXPECT_NAT_TUPLE]	= { .type = NLA_NESTED },
 };
+#endif
 
 static int
 ctnetlink_parse_expect_nat(const struct nlattr *attr,
-- 
2.27.0

