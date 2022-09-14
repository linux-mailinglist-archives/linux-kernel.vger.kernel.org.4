Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1B965B7E0A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 02:55:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229802AbiINAzr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 20:55:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbiINAzn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 20:55:43 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2338F252BB
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 17:55:42 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id u132so13323950pfc.6
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 17:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date;
        bh=5vV4CilzLiWjPs5xReufWS8ipvCGneLgr8C9TBkLjw0=;
        b=nhcftbz0F+5FieX2xbd8segHsRucGIuOwKvgYMu9lmxrssK8PpwDOXEh1Rw+Esp+dz
         MilZoQWwJc4vabWLbqbTFAMTOE7qQ9msTC0w/k0ZfPeJCRS1vgzLelZxU3M2p0uFJ5QU
         Cx6QDJlBXVOWNqdDgdJ4l/sQx4KTcvP2b1hrc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=5vV4CilzLiWjPs5xReufWS8ipvCGneLgr8C9TBkLjw0=;
        b=0HURuaXaELwRRjHbrmMyQRVffRhAywNSX4gn+D9V35wZb+gjOPHNx6YWJXEzlQol1S
         RD9PEQ++UXvUNmUUAKnWGslxX6YCYd85JeTpjLUBG7keQB/NthDmlXTSt5/MQur3H2hO
         krHlz5fO/q+4Udgznud+3FmwCYrXAF3/H9K2AvZwxZkeyM15D0T+8rJiYNgJzUyS750D
         O5wgR9o/fpmDeutNIyFTEmJ/bYATH6GCWXNnobF7KIN5EfP3iKTRHjhpjfvGakf5U6Yc
         flPdnodukYgiRL85HmAYz1EWLIk7q15hviUoGW768Z0e/3zNMrq5i2qFr1ozZ/GobOon
         7blg==
X-Gm-Message-State: ACgBeo1vPTfM37y2JufNbmSndCK1SKxL6bG/ssQEPUA5xzH0qSBWlHBF
        UWzLnrh93KtPozU0tnV6HzDtTQ==
X-Google-Smtp-Source: AA6agR48k91enu7+uh/AQ4joZbHAihyt0j9hntaWvaNHhQzbmNpt+4siuaaNR8At8OdvW016llHErg==
X-Received: by 2002:a63:fb0e:0:b0:434:efad:10c8 with SMTP id o14-20020a63fb0e000000b00434efad10c8mr28905882pgh.316.1663116941537;
        Tue, 13 Sep 2022 17:55:41 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id i32-20020a17090a3da300b001fbb0f0b00fsm7846674pjc.35.2022.09.13.17.55.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Sep 2022 17:55:40 -0700 (PDT)
Date:   Tue, 13 Sep 2022 17:55:39 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Jason@zx2c4.com
Cc:     syzbot <syzbot+a448cda4dba2dac50de5@syzkaller.appspotmail.com>,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        linux-kernel@vger.kernel.org, linux-next@vger.kernel.org,
        netdev@vger.kernel.org, pabeni@redhat.com, sfr@canb.auug.org.au,
        syzkaller-bugs@googlegroups.com, wireguard@lists.zx2c4.com
Subject: Re: [syzbot] linux-next test error: WARNING in set_peer
Message-ID: <202209131753.D1BDA803@keescook>
References: <00000000000060a74405e8945759@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <00000000000060a74405e8945759@google.com>
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 13, 2022 at 12:51:42PM -0700, syzbot wrote:
> memcpy: detected field-spanning write (size 28) of single field "&endpoint.addr" at drivers/net/wireguard/netlink.c:446 (size 16)

This is one way to fix it:

diff --git a/drivers/net/wireguard/netlink.c b/drivers/net/wireguard/netlink.c
index 0c0644e762e5..dbbeba216530 100644
--- a/drivers/net/wireguard/netlink.c
+++ b/drivers/net/wireguard/netlink.c
@@ -434,16 +434,16 @@ static int set_peer(struct wg_device *wg, struct nlattr **attrs)
 	}
 
 	if (attrs[WGPEER_A_ENDPOINT]) {
-		struct sockaddr *addr = nla_data(attrs[WGPEER_A_ENDPOINT]);
+		struct endpoint *raw = nla_data(attrs[WGPEER_A_ENDPOINT]);
 		size_t len = nla_len(attrs[WGPEER_A_ENDPOINT]);
 
 		if ((len == sizeof(struct sockaddr_in) &&
-		     addr->sa_family == AF_INET) ||
+		     raw->addr.sa_family == AF_INET) ||
 		    (len == sizeof(struct sockaddr_in6) &&
-		     addr->sa_family == AF_INET6)) {
+		     raw->addr.sa_family == AF_INET6)) {
 			struct endpoint endpoint = { { { 0 } } };
 
-			memcpy(&endpoint.addr, addr, len);
+			memcpy(&endpoint.addrs, &raw->addrs, len);
 			wg_socket_set_peer_endpoint(peer, &endpoint);
 		}
 	}
diff --git a/drivers/net/wireguard/peer.h b/drivers/net/wireguard/peer.h
index 76e4d3128ad4..4fbe7940828b 100644
--- a/drivers/net/wireguard/peer.h
+++ b/drivers/net/wireguard/peer.h
@@ -19,11 +19,13 @@
 struct wg_device;
 
 struct endpoint {
-	union {
-		struct sockaddr addr;
-		struct sockaddr_in addr4;
-		struct sockaddr_in6 addr6;
-	};
+	struct_group(addrs,
+		union {
+			struct sockaddr addr;
+			struct sockaddr_in addr4;
+			struct sockaddr_in6 addr6;
+		};
+	);
 	union {
 		struct {
 			struct in_addr src4;


diffoscope shows the bounds check gets updated to the full union size:
│ -     cmp    $0x11,%edx
│ +     cmp    $0x1d,%edx

and the field name changes in the warning:
$ strings clang/drivers/net/wireguard/netlink.o.after | grep ^field
field "&endpoint.addrs" at drivers/net/wireguard/netlink.c:446


-- 
Kees Cook
