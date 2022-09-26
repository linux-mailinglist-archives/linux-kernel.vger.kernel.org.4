Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BEC85EB4FE
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 01:03:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbiIZXDH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 19:03:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbiIZXDD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 19:03:03 -0400
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8906A721C;
        Mon, 26 Sep 2022 16:03:02 -0700 (PDT)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-11e9a7135easo11217773fac.6;
        Mon, 26 Sep 2022 16:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=LMtuy21foXTZtrHboQc8Vfajdu0Em6CTMANWzLi7V1Y=;
        b=khhx/qLwdB9elio31+N1XsbQatR/liBD92cZslnhIj/nHloto0nTJqczC0YPnZ4E8o
         B2biNS+sgi27bppFAJIhCujr5oo13IXfpi/PWXjz6+B+vfwTUMjMYoUfRYRw4Pd6NqcM
         9J2jW1rnRvgObSJ+n0M9tahpwAX5+J7ERbE19NpuYPbb628D8CxfyY8lb21KGnlop30q
         PyGa6NYPE9m6fQI1TcyAIsrvf0S6oZXZWcqsnWGT/M/sOlHky/t3HEvR01U9JNHAGwKO
         BTXv+1EmlZfEBBytzAx2H3D8awqiBH0QP81Dxq8GOsxhcJ1oj+8qFcASqV7Rfd8jMZXG
         ce0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=LMtuy21foXTZtrHboQc8Vfajdu0Em6CTMANWzLi7V1Y=;
        b=riAb2P17EMtqbxXuPuzt0AUCkyW3xKgqo7ZVbHYknvpvm5/OXAAaQ3trSiVBhTNlrp
         G2U1Ik3iiwvv/pl2UKojRYGbL/W4+QDQRXsrUCtvj6MaAs/f05O5ura4bvzNyDcJumkz
         WcHsQjMhkW5pjU1h5eI8gPMGOh67MrHoo1nLsxFxf73fx2YGPbbGl7Mm7ndPtf5wepv5
         rPlXYDZ/aggeFfAsMEahizD8h2sZXhlQr+a8V5EgukOoWpgSg0/n+qrFYe8BYayXswtY
         Q70EDbNMkl/mRL8zdECdFBHW+D73wXHC56BOWk946SA32szrUSTwJ4YxjrPcjCuBx4FW
         VSiQ==
X-Gm-Message-State: ACrzQf3WbKpU646roWRqf9xlZNqzWD5PKEaWaVB6fXfy0s7I1/UPnqT1
        3kTDpnr7+BxkZSwdxaMv4Hw=
X-Google-Smtp-Source: AMsMyM5fcq1V6oKfm+xZVS+YMCyEF7d0mT/A3ABDGDBBFMhz8e8n6y2yfAA+12/AMEUNPLbvXmGusw==
X-Received: by 2002:a05:6870:c184:b0:127:cd9:3e06 with SMTP id h4-20020a056870c18400b001270cd93e06mr577683oad.137.1664233381720;
        Mon, 26 Sep 2022 16:03:01 -0700 (PDT)
Received: from macondo.. ([2804:431:e7cc:3499:6191:8a21:21e2:19ef])
        by smtp.gmail.com with ESMTPSA id by5-20020a056830608500b0063b2251a78asm8376068otb.12.2022.09.26.16.02.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 16:03:01 -0700 (PDT)
From:   Rafael Mendonca <rafaelmendsr@gmail.com>
To:     Nilesh Javali <njavali@marvell.com>,
        GR-QLogic-Storage-Upstream@marvell.com,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Himanshu Madhani <himanshu.madhani@cavium.com>,
        Quinn Tran <quinn.tran@cavium.com>
Cc:     Rafael Mendonca <rafaelmendsr@gmail.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: qla2xxx: Fix serialization of DCBX TLV data request
Date:   Mon, 26 Sep 2022 20:02:44 -0300
Message-Id: <20220926230245.790508-1-rafaelmendsr@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit b6faaaf796d7 ("scsi: qla2xxx: Serialize mailbox request") serialized
mailbox requests from userspace using the 'optrom' mutex. However, in the
case of DCBX TLV data, if the memory for it is already allocated, then the
mailbox request ends up not being serialized because it is done without
holding the 'optrom' mutex.

Fixes: b6faaaf796d7 ("scsi: qla2xxx: Serialize mailbox request")
Signed-off-by: Rafael Mendonca <rafaelmendsr@gmail.com>
---
 drivers/scsi/qla2xxx/qla_attr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/qla2xxx/qla_attr.c b/drivers/scsi/qla2xxx/qla_attr.c
index fa1fcbfb946f..c2bc7f9c728a 100644
--- a/drivers/scsi/qla2xxx/qla_attr.c
+++ b/drivers/scsi/qla2xxx/qla_attr.c
@@ -951,9 +951,9 @@ qla2x00_sysfs_read_dcbx_tlv(struct file *filp, struct kobject *kobj,
 	if (!capable(CAP_SYS_ADMIN) || off != 0 || count > DCBX_TLV_DATA_SIZE)
 		return 0;
 
+	mutex_lock(&vha->hw->optrom_mutex);
 	if (ha->dcbx_tlv)
 		goto do_read;
-	mutex_lock(&vha->hw->optrom_mutex);
 	if (qla2x00_chip_is_down(vha)) {
 		mutex_unlock(&vha->hw->optrom_mutex);
 		return 0;
-- 
2.34.1

