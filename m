Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CE5E6A159B
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 04:44:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbjBXDo2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 22:44:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbjBXDo1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 22:44:27 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFD16CDC0;
        Thu, 23 Feb 2023 19:44:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 538FD617AA;
        Fri, 24 Feb 2023 03:44:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13E30C433EF;
        Fri, 24 Feb 2023 03:44:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677210242;
        bh=RwjySR8hWiLpxUC0dXi0nzoxYZdFGRL2DklpueF5MkU=;
        h=Date:From:To:Cc:Subject:From;
        b=XJPbS1UbyjIiMYfcmex9BIoKABEj3kN1KuaUZ+IvDh89zdkURSzEyIBeswY5eP+8A
         UJOavKCO4FBaAQAPmJrDObNsAjN1U2l8foWAGxdEToy4CrvylLIruyjB/IdsLtx6sr
         3wQ+oogSYYJHgPQYe1GN3JzKpkiUKbUtu6gOYxPKDu9BPqn2gP+Nc/anNmV9ynkrqw
         i6ScmFDZvSa0pyYTTxR9DEMjYphSu0iHa60/M7c4nPG4Hgglit1+u0PooNACanAFsr
         8bpIPiKVZA44qq5M9Qc1uAlSEU976FiHj/vkZ+dIE+9tfOlGA7MK8+I3cEQuMWwNls
         HrZ8rV9sEtKmA==
Date:   Thu, 23 Feb 2023 21:44:28 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH][next] usb: host: oxu210hp-hcd: Replace fake flex-array with
 flexible-array member
Message-ID: <Y/gynI9Wv8RZTD8M@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Zero-length arrays as fake flexible arrays are deprecated and we are
moving towards adopting C99 flexible-array members instead.

Transform zero-length array into flexible-array member in struct
ehci_regs.

Address the following warnings found with GCC-13 and
-fstrict-flex-arrays=3 enabled:
drivers/usb/host/oxu210hp-hcd.c:3983:30: warning: array subscript i is outside array bounds of ‘u32[0]’ {aka ‘unsigned int[]’} [-Warray-bounds=]
drivers/usb/host/oxu210hp-hcd.c:3986:38: warning: array subscript i is outside array bounds of ‘u32[0]’ {aka ‘unsigned int[]’} [-Warray-bounds=]
drivers/usb/host/oxu210hp-hcd.c:3971:30: warning: array subscript i is outside array bounds of ‘u32[0]’ {aka ‘unsigned int[]’} [-Warray-bounds=]
drivers/usb/host/oxu210hp-hcd.c:3978:30: warning: array subscript i is outside array bounds of ‘u32[0]’ {aka ‘unsigned int[]’} [-Warray-bounds=]
drivers/usb/host/oxu210hp-hcd.c:3523:30: warning: array subscript i is outside array bounds of ‘u32[0]’ {aka ‘unsigned int[]’} [-Warray-bounds=]
drivers/usb/host/oxu210hp-hcd.c:2774:39: warning: array subscript port is outside array bounds of ‘u32[0]’ {aka ‘unsigned int[]’} [-Warray-bounds=]
drivers/usb/host/oxu210hp-hcd.c:3569:35: warning: array subscript <unknown> is outside array bounds of ‘u32[0]’ {aka ‘unsigned int[]’} [-Warray-bounds=]
drivers/usb/host/oxu210hp-hcd.c:3888:36: warning: array subscript port is outside array bounds of ‘u32[0]’ {aka ‘unsigned int[]’} [-Warray-bounds=]
drivers/usb/host/oxu210hp-hcd.c:2911:45: warning: array subscript i is outside array bounds of ‘u32[0]’ {aka ‘unsigned int[]’} [-Warray-bounds=]

This helps with the ongoing efforts to tighten the FORTIFY_SOURCE
routines on memcpy() and help us make progress towards globally
enabling -fstrict-flex-arrays=3 [1].

Link: https://github.com/KSPP/linux/issues/21
Link: https://github.com/KSPP/linux/issues/259
Link: https://gcc.gnu.org/pipermail/gcc-patches/2022-October/602902.html [1]
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/usb/host/oxu210hp-hcd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/host/oxu210hp-hcd.c b/drivers/usb/host/oxu210hp-hcd.c
index 3a441310c713..f998d3f1a78a 100644
--- a/drivers/usb/host/oxu210hp-hcd.c
+++ b/drivers/usb/host/oxu210hp-hcd.c
@@ -169,7 +169,7 @@ struct ehci_regs {
 #define FLAG_CF		(1<<0)		/* true: we'll support "high speed" */
 
 	/* PORTSC: offset 0x44 */
-	u32		port_status[0];	/* up to N_PORTS */
+	u32		port_status[];	/* up to N_PORTS */
 /* 31:23 reserved */
 #define PORT_WKOC_E	(1<<22)		/* wake on overcurrent (enable) */
 #define PORT_WKDISC_E	(1<<21)		/* wake on disconnect (enable) */
-- 
2.34.1

