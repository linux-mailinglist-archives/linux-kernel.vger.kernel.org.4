Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3F81631CAB
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 10:17:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230178AbiKUJRt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 04:17:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230157AbiKUJRn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 04:17:43 -0500
Received: from forward103j.mail.yandex.net (forward103j.mail.yandex.net [IPv6:2a02:6b8:0:801:2::106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C23916585;
        Mon, 21 Nov 2022 01:17:39 -0800 (PST)
Received: from myt5-01d0fbe499ab.qloud-c.yandex.net (myt5-01d0fbe499ab.qloud-c.yandex.net [IPv6:2a02:6b8:c12:4619:0:640:1d0:fbe4])
        by forward103j.mail.yandex.net (Yandex) with ESMTP id EE18E10262F;
        Mon, 21 Nov 2022 12:17:37 +0300 (MSK)
Received: by myt5-01d0fbe499ab.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA id VC22I9egno-HaVqN7lN;
        Mon, 21 Nov 2022 12:17:37 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1669022257;
        bh=e8HT6dD/3N27O+m0P8iRhFaXnOdkCyfzpN5zPbWNkcQ=;
        h=Message-Id:Date:Cc:Subject:To:From;
        b=Jv2Tr9S0pGdAQmxuripPhHsfwOMHYwg7jVY/mAPGAdsrovkumPkKvLC8aziWtlRgq
         f/nK2QirBgHtVhBWOPRjdDxOzWnGP78yQlA+BeoGasvGRKX/INIRFZDv/7JXIA1b5/
         MXvpTb4NuaI8e7nd2340f5vLO4Zl49pGN7op1HdE=
Authentication-Results: myt5-01d0fbe499ab.qloud-c.yandex.net; dkim=pass header.i=@yandex.ru
From:   Peter Kosyh <pkosyh@yandex.ru>
To:     Artur Paszkiewicz <artur.paszkiewicz@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Peter Kosyh <pkosyh@yandex.ru>, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
Subject: [PATCH] scsi: iscsi: check retval of sci_unsolicited_frame_control_get_header
Date:   Mon, 21 Nov 2022 12:17:32 +0300
Message-Id: <20221121091732.547363-1-pkosyh@yandex.ru>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sci_unsolicited_frame_control_get_header may return error if frame_index
is invalid. There are two calls where retval was forgotten to check.

Add check of retval.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: c72086e3c289 ("isci: merge smp request substates into primary state machine")
Signed-off-by: Peter Kosyh <pkosyh@yandex.ru>
---
 drivers/scsi/isci/request.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/isci/request.c b/drivers/scsi/isci/request.c
index 6370cdbfba08..e9f442d5cb73 100644
--- a/drivers/scsi/isci/request.c
+++ b/drivers/scsi/isci/request.c
@@ -1712,9 +1712,11 @@ sci_io_request_frame_handler(struct isci_request *ireq,
 		struct ssp_frame_hdr ssp_hdr;
 		void *frame_header;
 
-		sci_unsolicited_frame_control_get_header(&ihost->uf_control,
+		status = sci_unsolicited_frame_control_get_header(&ihost->uf_control,
 							      frame_index,
 							      &frame_header);
+		if (status != SCI_SUCCESS)
+			return status;
 
 		word_cnt = sizeof(struct ssp_frame_hdr) / sizeof(u32);
 		sci_swab32_cpy(&ssp_hdr, frame_header, word_cnt);
@@ -1768,9 +1770,12 @@ sci_io_request_frame_handler(struct isci_request *ireq,
 		void *frame_header, *kaddr;
 		u8 *rsp;
 
-		sci_unsolicited_frame_control_get_header(&ihost->uf_control,
+		status = sci_unsolicited_frame_control_get_header(&ihost->uf_control,
 							 frame_index,
 							 &frame_header);
+		if (status != SCI_SUCCESS)
+			return status;
+
 		kaddr = kmap_atomic(sg_page(sg));
 		rsp = kaddr + sg->offset;
 		sci_swab32_cpy(rsp, frame_header, 1);
-- 
2.38.1

