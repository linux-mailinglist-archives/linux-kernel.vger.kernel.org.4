Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 423F76D9995
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 16:28:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237263AbjDFO2N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 10:28:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238965AbjDFO2K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 10:28:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 926408A51;
        Thu,  6 Apr 2023 07:28:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2F23B6450C;
        Thu,  6 Apr 2023 14:28:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B733C4339B;
        Thu,  6 Apr 2023 14:28:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680791288;
        bh=jhxfiG+JEN/B7SPCpeaq7cxeMMnz6qoyQOvS5SSFFt0=;
        h=Date:From:To:Cc:Subject:From;
        b=Zz13cmWj82aEGrHXBsUl6d2i6L41xOIQlyFWVqKmFZgKD6M904c1r218ROElrMQ9e
         zFaFbH958fBz/SaFcIwTI83FUGr8lFbeRg8emfKkWGRKE6uB/VH5w7FFUyaBzH/Oyg
         LBEL0vghIj5G5axIRSasIhhO99Vz25g0l/hYW2Lbzfc/DRcQSv+uHMIhAVcNCItb6x
         js09de36T1/ugJkwXO/LOwudjUuzWWWZrWSwKQzJXpXlEzP5a+tI7YbjsEg1OZ07pw
         3EY8sNNdLZEN+/MrUTpXavu0ePj+aNWo/5sToRYMtvT7MDhnzF6t5QPDnPVHB+01tO
         JA46rB1hJyiiQ==
Date:   Thu, 6 Apr 2023 08:28:42 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>
Cc:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH][next] s390/diag: Replace zero-length array with
 flexible-array member
Message-ID: <ZC7XGpUtVhqlRLhH@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Zero-length arrays are deprecated [1] and have to be replaced by C99
flexible-array members.

This helps with the ongoing efforts to tighten the FORTIFY_SOURCE routines
on memcpy() and help to make progress towards globally enabling
-fstrict-flex-arrays=3 [2]

Link: https://github.com/KSPP/linux/issues/78 [1]
Link: https://gcc.gnu.org/pipermail/gcc-patches/2022-October/602902.html [2]
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 arch/s390/include/asm/diag.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/include/asm/diag.h b/arch/s390/include/asm/diag.h
index 674a939f16ee..902e0330dd91 100644
--- a/arch/s390/include/asm/diag.h
+++ b/arch/s390/include/asm/diag.h
@@ -90,7 +90,7 @@ struct diag8c {
 	u8 num_partitions;
 	u16 width;
 	u16 height;
-	u8 data[0];
+	u8 data[];
 } __packed __aligned(4);
 
 extern int diag8c(struct diag8c *out, struct ccw_dev_id *devno);
-- 
2.34.1

