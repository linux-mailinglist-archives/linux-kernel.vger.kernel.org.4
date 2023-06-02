Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78F49720080
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 13:37:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235361AbjFBLg5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 07:36:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235233AbjFBLgy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 07:36:54 -0400
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B856D194;
        Fri,  2 Jun 2023 04:36:52 -0700 (PDT)
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1b04706c974so16969305ad.2;
        Fri, 02 Jun 2023 04:36:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685705812; x=1688297812;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+8V9XaMYituDt7+Ry1Yz1LEHFfSZsiDESteY20tnKzk=;
        b=Q4A85mLrn14X9FOV42CgmzkR4k+KXvZ53kbaZtqc371x1/6AtR7p3aqNg1/Oa2pzoK
         Unr9RT5ksJcwuHvnCx2cB4K+RL3IRV23mymRfNz+PYRdAkGOi1KBgGr1OfUru4LHyvnm
         QidulZlthrn/XkscLqzSvPY7BJHZQAFFMedjZ175ZzvFB2ix5hHQGSGvlVQIWYx0jieq
         YWE+HFHdJc0x24xr983kxR+kKo7KYwyDpqsXEZdm2vZujT0FrlIMwfvKqKiFNAZsDh6s
         bj9wHjSUl8suLi+CLlI6ivnrvEbbX2LX2wSfe5S4BcgZneDBDNx54xoXLMfBQ/Lk6g9U
         8ADA==
X-Gm-Message-State: AC+VfDwIBFLYgshrQKLSIG5nZzWxlAnHjJad5pXFE5tI4iZciF8jg3+B
        iCepdz09vw+vYhdNO02ZC2o=
X-Google-Smtp-Source: ACHHUZ5kW48TS0f90vTRqxS3q8MXbKl4HpGm4tJCgIeeIQepEBZcvvx/c1d2m5+wve9VwXgAoK89/g==
X-Received: by 2002:a17:902:74c4:b0:1b0:46c:9944 with SMTP id f4-20020a17090274c400b001b0046c9944mr2006230plt.48.1685705812001;
        Fri, 02 Jun 2023 04:36:52 -0700 (PDT)
Received: from dev-linux.lan (cpe-70-95-21-110.san.res.rr.com. [70.95.21.110])
        by smtp.gmail.com with ESMTPSA id u11-20020a170902714b00b001a525705aa8sm1159716plm.136.2023.06.02.04.36.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jun 2023 04:36:51 -0700 (PDT)
From:   Sukrut Bellary <sukrut.bellary@linux.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Amol Maheshwari <amahesh@qti.qualcomm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        Abel Vesa <abel.vesa@linaro.org>
Cc:     Sukrut Bellary <sukrut.bellary@linux.com>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
Subject: [PATCH v2] misc: fastrpc: Fix double free of 'buf' in error path
Date:   Fri,  2 Jun 2023 04:36:02 -0700
Message-Id: <20230602113602.1271695-1-sukrut.bellary@linux.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

smatch warning:
drivers/misc/fastrpc.c:1926 fastrpc_req_mmap() error: double free of 'buf'

In fastrpc_req_mmap() error path, the fastrpc buffer is freed in
fastrpc_req_munmap_impl() if unmap is successful.

But in the end, there is an unconditional call to fastrpc_buf_free().
So the above case triggers the double free of fastrpc buf.

Fixes: 72fa6f7820c4 ("misc: fastrpc: Rework fastrpc_req_munmap")
Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>
Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>
Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Sukrut Bellary <sukrut.bellary@linux.com>
---
This is based on static analysis. Compilation tested.
---
Changes in v2: 
- Fixed the commit message.
- Addressed the review comment about deleting buf from the list
  before freeing.
- Link to v1: https://lore.kernel.org/all/20230518100829.515143-1-sukrut.bellary@linux.com/
---
 drivers/misc/fastrpc.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index f48466960f1b..b3b520fcfb75 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -1882,7 +1882,8 @@ static int fastrpc_req_mmap(struct fastrpc_user *fl, char __user *argp)
 				      &args[0]);
 	if (err) {
 		dev_err(dev, "mmap error (len 0x%08llx)\n", buf->size);
-		goto err_invoke;
+		fastrpc_buf_free(buf);
+		return err;
 	}
 
 	/* update the buffer to be able to deallocate the memory on the DSP */
@@ -1922,8 +1923,6 @@ static int fastrpc_req_mmap(struct fastrpc_user *fl, char __user *argp)
 
 err_assign:
 	fastrpc_req_munmap_impl(fl, buf);
-err_invoke:
-	fastrpc_buf_free(buf);
 
 	return err;
 }
-- 
2.34.1

