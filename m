Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6758743E03
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 16:58:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232814AbjF3O6R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 10:58:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231849AbjF3O6P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 10:58:15 -0400
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5BEC19B5;
        Fri, 30 Jun 2023 07:58:12 -0700 (PDT)
X-GND-Sasl: i.maximets@ovn.org
X-GND-Sasl: i.maximets@ovn.org
X-GND-Sasl: i.maximets@ovn.org
X-GND-Sasl: i.maximets@ovn.org
X-GND-Sasl: i.maximets@ovn.org
X-GND-Sasl: i.maximets@ovn.org
X-GND-Sasl: i.maximets@ovn.org
X-GND-Sasl: i.maximets@ovn.org
X-GND-Sasl: i.maximets@ovn.org
X-GND-Sasl: i.maximets@ovn.org
X-GND-Sasl: i.maximets@ovn.org
X-GND-Sasl: i.maximets@ovn.org
X-GND-Sasl: i.maximets@ovn.org
X-GND-Sasl: i.maximets@ovn.org
Received: by mail.gandi.net (Postfix) with ESMTPSA id E6CF81C0002;
        Fri, 30 Jun 2023 14:58:07 +0000 (UTC)
From:   Ilya Maximets <i.maximets@ovn.org>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
        Magnus Karlsson <magnus.karlsson@intel.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Ilya Maximets <i.maximets@ovn.org>
Subject: [RFC bpf-next] xsk: honor SO_BINDTODEVICE on bind
Date:   Fri, 30 Jun 2023 16:58:31 +0200
Message-Id: <20230630145831.2988845-1-i.maximets@ovn.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_NEUTRAL,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Initial creation of an AF_XDP socket requires CAP_NET_RAW capability.
A privileged process might create the socket and pass it to a
non-privileged process for later use.  However, that process will be
able to bind the socket to any network interface.  Even though it will
not be able to receive any traffic without modification of the BPF map,
the situation is not ideal.

Sockets already have a mechanism that can be used to restrict what
interface they can be attached to.  That is SO_BINDTODEVICE.

To change the binding the process will need CAP_NET_RAW.

Make xsk_bind() honor the SO_BINDTODEVICE in order to allow safer
workflow when non-privileged process is using AF_XDP.

Signed-off-by: Ilya Maximets <i.maximets@ovn.org>
---

Posting as an RFC for now to probably get some feedback.
Will re-post once the tree is open.

 Documentation/networking/af_xdp.rst | 9 +++++++++
 net/xdp/xsk.c                       | 6 ++++++
 2 files changed, 15 insertions(+)

diff --git a/Documentation/networking/af_xdp.rst b/Documentation/networking/af_xdp.rst
index 247c6c4127e9..1cc35de336a4 100644
--- a/Documentation/networking/af_xdp.rst
+++ b/Documentation/networking/af_xdp.rst
@@ -433,6 +433,15 @@ start N bytes into the buffer leaving the first N bytes for the
 application to use. The final option is the flags field, but it will
 be dealt with in separate sections for each UMEM flag.
 
+SO_BINDTODEVICE setsockopt
+--------------------------
+
+This is a generic SOL_SOCKET option that can be used to tie AF_XDP
+socket to a particular network interface.  It is useful when a socket
+is created by a privileged process and passed to a non-privileged one.
+Once the option is set, kernel will refuse attempts to bind that socket
+to a different interface.  Updating the value requires CAP_NET_RAW.
+
 XDP_STATISTICS getsockopt
 -------------------------
 
diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 5a8c0dd250af..386ff641db0f 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -886,6 +886,7 @@ static int xsk_bind(struct socket *sock, struct sockaddr *addr, int addr_len)
 	struct sock *sk = sock->sk;
 	struct xdp_sock *xs = xdp_sk(sk);
 	struct net_device *dev;
+	int bound_dev_if;
 	u32 flags, qid;
 	int err = 0;
 
@@ -899,6 +900,11 @@ static int xsk_bind(struct socket *sock, struct sockaddr *addr, int addr_len)
 		      XDP_USE_NEED_WAKEUP))
 		return -EINVAL;
 
+	bound_dev_if = READ_ONCE(sk->sk_bound_dev_if);
+
+	if (bound_dev_if && bound_dev_if != sxdp->sxdp_ifindex)
+		return -EINVAL;
+
 	rtnl_lock();
 	mutex_lock(&xs->mutex);
 	if (xs->state != XSK_READY) {
-- 
2.40.1

