Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D8C45E68FA
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 19:01:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbiIVRA5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 13:00:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbiIVRAz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 13:00:55 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40234F2773;
        Thu, 22 Sep 2022 10:00:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F35D4B803F3;
        Thu, 22 Sep 2022 17:00:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F4DDC433D6;
        Thu, 22 Sep 2022 17:00:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663866051;
        bh=2WF+oCjweKMMdy0hxBDSueIZNZ6Go1kccHSoK1QX4/M=;
        h=Date:From:To:Cc:Subject:From;
        b=KSsRxLsQwHm4a+VVjxQIj5CUD9E1XI+oUvioOrTjUzdg8adoDQk34azZ+f1dooYiz
         JdYjtYhDfCaDWDchupKulGbWMkx84ljXZzLpX2b7NElQOKjBInQ8MJ/XX+jIT/Dyo+
         rUa207uFLcR8IrDIEFLdqhtn70gog3Uuij2/FTNcEFJSNevLVqxYomGrRhkDVm0xmf
         TCa7pupd9hGaC18me4dgbZu8y+kCtwqxPv5faGzir0KSCnRYQ/JM6HxV5Dutx30O9+
         1Ir9DRazt5IK/zZ5hICgjmebvU9ihlge+RbVHRD6E2I/ww3d9Fpr+lT1KrreUyr/hF
         9OhPXJ4cN8Xxw==
Date:   Thu, 22 Sep 2022 12:00:46 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH][next] scsi: hptiop: Replace one-element array with
 flexible-array member in struct hpt_iop_request_ioctl_command
Message-ID: <YyyUvuId7dAZadej@work>
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

One-element arrays are deprecated, and we are replacing them with flexible
array members instead. So, replace one-element array with flexible-array
member in struct hpt_iop_request_ioctl_command.

Link: https://github.com/KSPP/linux/issues/79
Link: https://github.com/KSPP/linux/issues/205
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/scsi/hptiop.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/hptiop.h b/drivers/scsi/hptiop.h
index ef2f2aca598c..394ef6aa469e 100644
--- a/drivers/scsi/hptiop.h
+++ b/drivers/scsi/hptiop.h
@@ -237,7 +237,7 @@ struct hpt_iop_request_ioctl_command {
 	__le32 inbuf_size;
 	__le32 outbuf_size;
 	__le32 bytes_returned;
-	u8     buf[1];
+	u8     buf[];
 	/* out data should be put at buf[(inbuf_size+3)&~3] */
 };
 
-- 
2.34.1

