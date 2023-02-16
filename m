Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42EF96991E3
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 11:41:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230263AbjBPKlw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 05:41:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbjBPKlv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 05:41:51 -0500
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0F9B552B9;
        Thu, 16 Feb 2023 02:41:22 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id a9so1441310ljr.13;
        Thu, 16 Feb 2023 02:41:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=twA/dx8sDl/9zgFTq0t8Vwm8D0+RN/hMKLyQGOMyKi0=;
        b=IKzmVteJil80YEuu0osMFEi1dNcxHcz52i0jc1fsmoXiDCvc9khvZoSCNaRN6zKG8I
         tNYa0tQLx+6VHY4K9k4ulyy/CJPbzRl8S5I76ykHkrb53D0px04Mq4meblNlnWaqs2l5
         1V3mxHg/E/+uoq6V4Bp1t/y4SGuUJJ8MzQXJbxTdxZhItgMgq94L2AbZQp/ogNbuccuA
         KGdvQ3MZngdZmwJkeA29uLh9JmSCjwnx0unfi6PPnInwxyq2SJT7fts94bb0FYYWVQyt
         iRBEFfefZdBSdkuJ105lo0+8s1NCjolv4QVv6RNWqiCHj+1WCLzXnZl9LCo2cSLs1gYj
         7smQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=twA/dx8sDl/9zgFTq0t8Vwm8D0+RN/hMKLyQGOMyKi0=;
        b=slNU5u0XEyzE8/UPowRxHnEmPx/JUcB8XnNFcj3klgz1Nu8jK/XYagBhwdblAjn3fF
         q+pYuQ2Ya/4yWgGQRRNLWgKJ325eWL6cmmQhe4K177RKDFU7nmMtfW0fCv0EQv+xIdSP
         BEtLhbcabTlMrx0Eot/pvze9Dc2GqWusrffi/cKzauKY9N+XeiAs3zFgaz3MVPD/zxzd
         Q2W36thErN4Huwy3g3wxLGBG7wlviOun7NJRbTjdy5wqrmvOyYF3kRpdtl0g0uED5TPA
         gpUbYTPHzCqTm2/YJ2ZlZpgtlZ6IvEOsRrcEJHcAuPFJTt7Wm+N6c67xUFlKDGV4Dbky
         EfCQ==
X-Gm-Message-State: AO0yUKVGRdWfBEBvZ3nirrR2pX00qRgjHrTN/w6J3P0cumEbyaAcMXFB
        PROiwqHlJAZMJHqemdfsbZo=
X-Google-Smtp-Source: AK7set9M7yZnKlCL9WHhJa+Sne+fWHl5DFgm91yMAcYhyE0osi909sEDIkAOKNJnV0I5Id/wIfqxSQ==
X-Received: by 2002:a2e:7204:0:b0:290:7054:e8b with SMTP id n4-20020a2e7204000000b0029070540e8bmr1671461ljc.49.1676544079563;
        Thu, 16 Feb 2023 02:41:19 -0800 (PST)
Received: from alsp.securitycode.ru ([2a02:2168:8a04:5600:ecbf:de16:f87d:956])
        by smtp.googlemail.com with ESMTPSA id l22-20020a2e7016000000b002934e972a6esm142181ljc.26.2023.02.16.02.41.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Feb 2023 02:41:19 -0800 (PST)
From:   Alexander Sapozhnikov <alsp705@gmail.com>
To:     Adam Radford <aradford@gmail.com>
Cc:     Alexandr Sapozhnikov <alsp705@gmail.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        lvc-project@linuxtesting.org
Subject: [PATCH] NULL check in twl_scsiop_execute_scsi()
Date:   Thu, 16 Feb 2023 13:41:13 +0300
Message-Id: <20230216104113.46-1-alsp705@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexandr Sapozhnikov <alsp705@gmail.com>

After having been compared to NULL value at 3w-sas.c:322, 
pointer 'srb' is passed as 1st parameter in call to 
function 'scsi_sg_count' at 3w-sas.c:336, where it is dereferenced.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Alexandr Sapozhnikov <alsp705@gmail.com>
---
 drivers/scsi/3w-sas.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/3w-sas.c b/drivers/scsi/3w-sas.c
index 3ebe661..674c130 100644
--- a/drivers/scsi/3w-sas.c
+++ b/drivers/scsi/3w-sas.c
@@ -333,7 +333,7 @@ static int twl_scsiop_execute_scsi(TW_Device_Extension *tw_dev, int request_id,
 
 	if (!sglistarg) {
 		/* Map sglist from scsi layer to cmd packet */
-		if (scsi_sg_count(srb)) {
+		if (srb && scsi_sg_count(srb)) {
 			sg_count = scsi_dma_map(srb);
 			if (sg_count <= 0)
 				goto out;
-- 
2.5.3

