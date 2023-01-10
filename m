Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2F066636C4
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 02:39:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231193AbjAJBjp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 20:39:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbjAJBjn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 20:39:43 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 779AAA1B3;
        Mon,  9 Jan 2023 17:39:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 31E45B80F4B;
        Tue, 10 Jan 2023 01:39:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 154A1C433D2;
        Tue, 10 Jan 2023 01:39:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673314779;
        bh=vrLfad/dEaF4ahcbuNSigjh7IBnihHnE+uf7TW186+Y=;
        h=Date:From:To:Cc:Subject:From;
        b=stbxdH54iAbI7V6ELAgCiLxBF7prOUSb0gNS9VBXx72Bh+BH0p2ddWfgCS0ibUQpN
         kZH0y2ZrtoQaPDDTc0pvnvYmfTXzBQISAg3mOG+Q3L12HRD0/qAnkeJ2g6SKKzyERl
         MQ8i1kqjyHjezyhf3L7hPLfD3Wl8CHkLicKLOA6N03goN9oPzLcfUUu+sRsBbjWMVW
         yHslk5gzxvtPpyi22fOiTQR4EBf9kpsMOwEUL9iFYwkbvs5bwr9jJ6rRXJs7YKO+Br
         4kHoP2n/akDIUnQIE3AkNobhE9TPnuJpEiSufhu4ZaAi+ajLyVhKyvwZmH3vfkJMTR
         YZy61XPD13GBw==
Date:   Mon, 9 Jan 2023 19:39:47 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Oded Gabbay <ogabbay@kernel.org>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH][next] habanalabs: Replace zero-length arrays with
 flexible-array members
Message-ID: <Y7zB4z5cxpFkPXKV@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Zero-length arrays are deprecated[1] and we are moving towards
adopting C99 flexible-array members instead. So, replace zero-length
arrays in a couple of structures with flex-array members.

This helps with the ongoing efforts to tighten the FORTIFY_SOURCE
routines on memcpy() and help us make progress towards globally
enabling -fstrict-flex-arrays=3 [2].

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays [1]
Link: https://gcc.gnu.org/pipermail/gcc-patches/2022-October/602902.html [2]
Link: https://github.com/KSPP/linux/issues/78
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/accel/habanalabs/include/gaudi2/gaudi2_packets.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/accel/habanalabs/include/gaudi2/gaudi2_packets.h b/drivers/accel/habanalabs/include/gaudi2/gaudi2_packets.h
index 8bf90fc18bf5..a812f8503f90 100644
--- a/drivers/accel/habanalabs/include/gaudi2/gaudi2_packets.h
+++ b/drivers/accel/habanalabs/include/gaudi2/gaudi2_packets.h
@@ -59,7 +59,7 @@ struct gaudi2_packet {
 	/* The rest of the packet data follows. Use the corresponding
 	 * packet_XXX struct to deference the data, based on packet type
 	 */
-	u8 contents[0];
+	u8 contents[];
 };
 
 struct packet_nop {
@@ -80,7 +80,7 @@ struct packet_wreg32 {
 struct packet_wreg_bulk {
 	__le32 size64;
 	__le32 ctl;
-	__le64 values[0]; /* data starts here */
+	__le64 values[]; /* data starts here */
 };
 
 struct packet_msg_long {
-- 
2.34.1

