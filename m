Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A184C714F74
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 20:51:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229580AbjE2SvT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 14:51:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjE2SvS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 14:51:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DEDD9F;
        Mon, 29 May 2023 11:51:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C6004614C1;
        Mon, 29 May 2023 18:51:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8820AC4339B;
        Mon, 29 May 2023 18:51:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685386276;
        bh=mawl8qMpP5viRoL6CkrK/gaq13n6bKJ6HvUhLIOtVsA=;
        h=Date:From:To:Cc:Subject:From;
        b=tOuUuwakLBZIkoTaSMDxZeIXxooaeCi6u6ziQ5J4Y0kdscBs/USyp+KPgbs7IWTrY
         r4b8WdwGW7GlDLBHSQa94FWIU+K1irRz6MKAPoJhExvwqmRVf5+2R7WW8u9eHuhugH
         4ihm/oWMk5urUKttwFrsG+r+yNWP4AZicBGZpGKxDqup+mjrdOSGX459xEGRPSgR3z
         gCQ4X54+QhXoqpYgJ5juo/7M6SJ13B48Hl4IIwgv2DHxYdBceAARfpMXx75CIzWK0x
         eVsjV+JSIxl63Cyn2W9Yffuf4H3izJfNs7KoKWZzAM9u72mwLBq7ZOK45pPqvkri6c
         b0h3jnXl2rAaw==
Date:   Mon, 29 May 2023 12:52:07 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc:     linux1394-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH][next] firewire: Replace zero-length array with
 flexible-array member
Message-ID: <ZHT0V3SpvHyxCv5W@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Zero-length and one-element arrays are deprecated, and we are moving
towards adopting C99 flexible-array members, instead.

Address the following warnings found with GCC-13 and
-fstrict-flex-arrays=3 enabled:
sound/firewire/amdtp-stream.c: In function ‘build_it_pkt_header’:
sound/firewire/amdtp-stream.c:694:17: warning: ‘generate_cip_header’ accessing 8 bytes in a region of size 0 [-Wstringop-overflow=]
  694 |                 generate_cip_header(s, cip_header, data_block_counter, syt);
      |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
sound/firewire/amdtp-stream.c:694:17: note: referencing argument 2 of type ‘__be32[2]’ {aka ‘unsigned int[2]’}
sound/firewire/amdtp-stream.c:667:13: note: in a call to function ‘generate_cip_header’
  667 | static void generate_cip_header(struct amdtp_stream *s, __be32 cip_header[2],
      |             ^~~~~~~~~~~~~~~~~~~

This helps with the ongoing efforts to tighten the FORTIFY_SOURCE
routines on memcpy() and help us make progress towards globally
enabling -fstrict-flex-arrays=3 [1].

Link: https://github.com/KSPP/linux/issues/21
Link: https://github.com/KSPP/linux/issues/303
Link: https://gcc.gnu.org/pipermail/gcc-patches/2022-October/602902.html [1]
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 include/linux/firewire.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/firewire.h b/include/linux/firewire.h
index 1716c01c4e54..efb6e2cf2034 100644
--- a/include/linux/firewire.h
+++ b/include/linux/firewire.h
@@ -391,7 +391,7 @@ struct fw_iso_packet {
 	u32 tag:2;		/* tx: Tag in packet header		*/
 	u32 sy:4;		/* tx: Sy in packet header		*/
 	u32 header_length:8;	/* Length of immediate header		*/
-	u32 header[0];		/* tx: Top of 1394 isoch. data_block	*/
+	u32 header[];		/* tx: Top of 1394 isoch. data_block	*/
 };
 
 #define FW_ISO_CONTEXT_TRANSMIT			0
-- 
2.34.1

