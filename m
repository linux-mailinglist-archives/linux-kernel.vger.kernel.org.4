Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4A97745C3F
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 14:31:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230281AbjGCMbD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 08:31:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjGCMbB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 08:31:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61A8C109;
        Mon,  3 Jul 2023 05:31:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DFF1E60F11;
        Mon,  3 Jul 2023 12:30:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73A52C433C8;
        Mon,  3 Jul 2023 12:30:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688387459;
        bh=1sPgnQytqXvJBTAK60yFSx/ZPuPS0KgjBMPm7QnUKU4=;
        h=From:To:Cc:Subject:Date:From;
        b=DokGZ0UVTk2qrGDH6x0dFs0utSx1dI9dPfYIFYlqMiq9wQ0v04VplU1xRkx1IaKiJ
         +en5RWpr6Y3ZGmiVzuI71f8/H4MMrqSw2shS3BnBawra+vNWrA8t/Yd5jYWav7Wzr0
         AXs76PS7Y7tzqe+d8JbS2uT+R61NmccuXy9v6ohnyw0mOSD3J4CwWLzOlJ4hzvB4Mv
         Rcq3k9hOc3DGufhvC5a7F2fdSsEv1xEvN8fDASrlBdb4h0ZdstGb1FPVs4d/JbM9k7
         PERTQi4jBjLTUNUEELAZdwQKl9nUSJt4LZc9VQvYkH3fW3n0mzfTrufaEy9muOZSyq
         P9wryL2uqxP4w==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Udipto Goswami <quic_ugoswami@quicinc.com>,
        John Keeping <john@keeping.me.uk>,
        Linyu Yuan <quic_linyyuan@quicinc.com>,
        Dan Carpenter <error27@gmail.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] usb: functionfs: avoid memcpy() field overflow warning
Date:   Mon,  3 Jul 2023 14:30:32 +0200
Message-Id: <20230703123053.3117488-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
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

__ffs_func_bind_do_os_desc() copies both the CompatibleID and SubCompatibleID
fields of the usb_ext_compat_desc structure into an array, which triggers
a warning in the fortified memcpy():

In file included from drivers/usb/gadget/function/f_fs.c:17:
In file included from include/linux/string.h:254:
include/linux/fortify-string.h:592:4: error: call to '__read_overflow2_field' declared with 'warning' attribute: detected read beyond size of field (2nd parameter); maybe use struct_group()? [-Werror,-Wattribute-warning]
                        __read_overflow2_field(q_size_field, size);

Usually we can avoid this by using a struct_group() inside of the structure
definition, but this might cause problems in userspace since it is in a uapi
header.

Just copy the two members individually.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/usb/gadget/function/f_fs.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/gadget/function/f_fs.c b/drivers/usb/gadget/function/f_fs.c
index f41a385a5c421..b8f9e52e6db6b 100644
--- a/drivers/usb/gadget/function/f_fs.c
+++ b/drivers/usb/gadget/function/f_fs.c
@@ -2933,8 +2933,9 @@ static int __ffs_func_bind_do_os_desc(enum ffs_os_desc_type type,
 		t = &func->function.os_desc_table[desc->bFirstInterfaceNumber];
 		t->if_id = func->interfaces_nums[desc->bFirstInterfaceNumber];
 		memcpy(t->os_desc->ext_compat_id, &desc->CompatibleID,
-		       ARRAY_SIZE(desc->CompatibleID) +
-		       ARRAY_SIZE(desc->SubCompatibleID));
+		       sizeof(desc->CompatibleID));
+		memcpy(t->os_desc->ext_compat_id + sizeof(desc->CompatibleID),
+			&desc->SubCompatibleID, sizeof(desc->SubCompatibleID));
 		length = sizeof(*desc);
 	}
 		break;
-- 
2.39.2

