Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5149D6BEF06
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 17:59:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230020AbjCQQ72 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 12:59:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229988AbjCQQ7Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 12:59:24 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4418A20D25;
        Fri, 17 Mar 2023 09:59:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 0FBE7CE20FF;
        Fri, 17 Mar 2023 16:59:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B00E0C433EF;
        Fri, 17 Mar 2023 16:59:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679072358;
        bh=Yr+loVbWv0qK18b3WpWr9ZR4G6QuOAV94eNluGFAb18=;
        h=Date:From:To:Cc:Subject:From;
        b=XniyUM26LziXHrexP/d/DUVLjnjl4qsrffDi+ERWh6SmXsGgmg7VJxMQtVgwshxny
         dFvp0OpJhh/vfqa/cGeur5SEtghfBr9J8PS6x8rdr83Z7Jg2vnxLMEeyE9TQQsK9k7
         7EyZpAMUKl0mpKAA3yBGWpDbAHZ/lKDCvl9dgxS3rljmW+AJt7BkR1YjB4s6tSDzHl
         sk9WX3evD6kjhJWmuXcjEuXv0dg0BRT/rZhwCXMgMMRhznb5ZkmA2GgzdfCJPufpnS
         /+KkNz7UZCe78TZKjBmBuqymn9RqBm3tnfT5q/gONOSHXhhcKMvGHhTCTTBOeDycaQ
         bAouUTD5ks0FQ==
Date:   Fri, 17 Mar 2023 10:59:48 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Bodo Stroesser <bostroesser@gmail.com>
Cc:     linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH][next] uapi: target: Replace fake flex-array with
 flexible-array member
Message-ID: <ZBSchMvTdl7VObKI@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Zero-length arrays as fake flexible arrays are deprecated and we are
moving towards adopting C99 flexible-array members instead.

Address the following warning found with GCC-13 and
-fstrict-flex-arrays=3 enabled:
  CC      drivers/target/target_core_user.o
drivers/target/target_core_user.c: In function ‘queue_cmd_ring’:
drivers/target/target_core_user.c:1096:15: warning: array subscript 0 is outside array bounds of ‘struct iovec[0]’ [-Warray-bounds=]
 1096 |         iov = &entry->req.iov[0];
      |               ^~~~~~~~~~~~~~~~~~
In file included from drivers/target/target_core_user.c:31:
./include/uapi/linux/target_core_user.h:122:38: note: while referencing ‘iov’
  122 |                         struct iovec iov[0];
      |                                      ^~~

This helps with the ongoing efforts to tighten the FORTIFY_SOURCE
routines on memcpy() and help us make progress towards globally
enabling -fstrict-flex-arrays=3 [1].

Link: https://github.com/KSPP/linux/issues/21
Link: https://github.com/KSPP/linux/issues/270
Link: https://gcc.gnu.org/pipermail/gcc-patches/2022-October/602902.html [1]
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 include/uapi/linux/target_core_user.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/linux/target_core_user.h b/include/uapi/linux/target_core_user.h
index fbd8ca67e107..f925a77f19ed 100644
--- a/include/uapi/linux/target_core_user.h
+++ b/include/uapi/linux/target_core_user.h
@@ -119,7 +119,7 @@ struct tcmu_cmd_entry {
 			__u64 cdb_off;
 			__u64 __pad1;
 			__u64 __pad2;
-			struct iovec iov[0];
+			__DECLARE_FLEX_ARRAY(struct iovec, iov);
 		} req;
 		struct {
 			__u8 scsi_status;
-- 
2.34.1

