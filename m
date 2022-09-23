Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 670225E7BAC
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 15:21:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232040AbiIWNVK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 09:21:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230285AbiIWNVI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 09:21:08 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16CCC13EE84;
        Fri, 23 Sep 2022 06:21:06 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id g3so20363183wrq.13;
        Fri, 23 Sep 2022 06:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=3BlIJMdluE47X3gFSDBJTgtvgj1lWndk79Vpp72Pjy0=;
        b=MBEDfuXBdTsbV/hv3XTrJqWFYkjxxl6HISff1+YKyhS3Io6oRK3o0wiPDc3w8iUNV/
         mJpBmbI/EOa5wXb6DzOaiER12JikN6Bkt51uICkzyJvzBDbmAuE5zP/ff3tJtp/YNO8H
         Y4fyyujutSJxNnPmwp5yV18zma2k9h18wPK8zvjiTReP6lIwzT209kjHsIVo+K8Whyho
         ARL3qqLNAC56fPXbpeeucpsub83JfWZx4UfbzVkW5/SyUXjKKozHOAi64GvoJBm/TCt4
         D2fo6CLOgsQ3hobk7/CP/Mu92zMiSEAMWLU//uTgcNW5XSKbvhiJtqX5+JucmSv/VBwv
         1/lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=3BlIJMdluE47X3gFSDBJTgtvgj1lWndk79Vpp72Pjy0=;
        b=Ug+yLzxN9atnHT8+2ZMpAPD49gOE4K96NunKsWPqzQS0aSQsBHZ7G/JyiaDvXmcLSy
         rzQ9cHadet9baSiuyLoSjNk7cRoXEqaHms2ne1H885AReVqy+nHfpeC2S0EfuBip5nin
         yxQbesiGZe4Z1W87NCwiqwDmrzxNiR+72/CS4kRkdqN6iCNUwZux5KgRYzFR0T5tGiqr
         CUH8IukE89GSt68bzS7fPVHGWyYjxUnfNUuprRNVlVrs1Q7Njr4YHGMkqLJmPFThOb/h
         ZRNJwTMb0kk6I7ua/oninJ3a2mTsCWP8zON5DXVVEZNBOjchOm1eLA3zIRPbUK9ik7oX
         0Dpw==
X-Gm-Message-State: ACrzQf3hJNOcKkNCA9jmfWANrs+V91zRria+yl0bz8DAXkrjnOCbvSg7
        k+wUueZxL2AjQyOV0SJF1jHNR3IjKtgf3g==
X-Google-Smtp-Source: AMsMyM5cQCGvanfiRlbu19EJsO6XJhMxjmSUCKtvA4aXuWso8uKHJoxvwLgD0/hF7za3Od9NlHd2kw==
X-Received: by 2002:a5d:5b0f:0:b0:22a:f738:acdd with SMTP id bx15-20020a5d5b0f000000b0022af738acddmr5088852wrb.234.1663939264554;
        Fri, 23 Sep 2022 06:21:04 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id bx29-20020a5d5b1d000000b0021f131de6aesm7383168wrb.34.2022.09.23.06.21.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Sep 2022 06:21:04 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Stefan Haberland <sth@linux.ibm.com>,
        Jan Hoeppner <hoeppner@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        linux-s390@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] s390/dasd: Fix spelling mistake "Ivalid" -> "Invalid"
Date:   Fri, 23 Sep 2022 14:21:03 +0100
Message-Id: <20220923132103.2486724-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

There is a spelling mistake in a pr_warn message. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/s390/block/dasd_ioctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/s390/block/dasd_ioctl.c b/drivers/s390/block/dasd_ioctl.c
index d0ddf2cc9786..484de696839c 100644
--- a/drivers/s390/block/dasd_ioctl.c
+++ b/drivers/s390/block/dasd_ioctl.c
@@ -401,7 +401,7 @@ dasd_ioctl_copy_pair_swap(struct block_device *bdev, void __user *argp)
 		return -EFAULT;
 	}
 	if (memchr_inv(data.reserved, 0, sizeof(data.reserved))) {
-		pr_warn("%s: Ivalid swap data specified.\n",
+		pr_warn("%s: Invalid swap data specified.\n",
 			dev_name(&device->cdev->dev));
 		dasd_put_device(device);
 		return DASD_COPYPAIRSWAP_INVALID;
-- 
2.37.1

