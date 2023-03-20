Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B73006C10AD
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 12:22:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbjCTLWg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 07:22:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230113AbjCTLWT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 07:22:19 -0400
Received: from baptiste.telenet-ops.be (baptiste.telenet-ops.be [IPv6:2a02:1800:120:4::f00:13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E809FBBA9
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 04:22:01 -0700 (PDT)
Received: from ramsan.of.borg ([84.195.187.55])
        by baptiste.telenet-ops.be with bizsmtp
        id abMx2900d1C8whw01bMxVl; Mon, 20 Mar 2023 12:21:59 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1peDZk-00E1jv-VC;
        Mon, 20 Mar 2023 12:21:57 +0100
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1peDaP-00736z-OM;
        Mon, 20 Mar 2023 12:21:57 +0100
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-nvme@lists.infradead.org,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] nvme-tcp: Fix implicit padding in struct nvme_tcp_term_pdu
Date:   Mon, 20 Mar 2023 12:21:56 +0100
Message-Id: <af0a1f2194fc9a6f8a95cf6c82277b8b0377d029.1679311226.git.geert@linux-m68k.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On m68k:

    drivers/nvme/host/tcp.c: In function ‘nvme_tcp_init_module’:
    include/linux/compiler_types.h:397:38: error: call to ‘__compiletime_assert_723’ declared with attribute error: BUILD_BUG_ON failed: sizeof(struct nvme_tcp_term_pdu) != 24

Indeed, on m68k the minimum alignment is 2 bytes, not 4 bytes, thus
triggering the check added in commit 7e87965d3807ab1f ("nvme-tcp: add
nvme-tcp pdu size build protection"), and indicating that NVMe over
Fabrics TCP on m68k must be incompatible with other platforms.

Fix this by adding explicit padding.

Fixes: fc221d05447aa6db ("nvme-tcp: Add protocol header")
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 include/linux/nvme-tcp.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/nvme-tcp.h b/include/linux/nvme-tcp.h
index 75470159a194d97f..ba8f82672e39730f 100644
--- a/include/linux/nvme-tcp.h
+++ b/include/linux/nvme-tcp.h
@@ -115,6 +115,7 @@ struct nvme_tcp_icresp_pdu {
 struct nvme_tcp_term_pdu {
 	struct nvme_tcp_hdr	hdr;
 	__le16			fes;
+	__u8			rsvd2[2];
 	__le32			fei;
 	__u8			rsvd[8];
 };
-- 
2.34.1

