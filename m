Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E050A707D98
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 12:09:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230366AbjERKJP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 06:09:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230188AbjERKJM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 06:09:12 -0400
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D4E31BD3;
        Thu, 18 May 2023 03:09:11 -0700 (PDT)
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1ae50da739dso12997235ad.1;
        Thu, 18 May 2023 03:09:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684404551; x=1686996551;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rTItOvZyqAvodhACTuaNIkuq7MW1RtbhnQpTTB2wrgw=;
        b=jn9hQcaq7D7/lxJF6u+hVoHQAA8EnZuDuCN/MY1RX5EgDe622Q3MHWmNJuA7aMjSt+
         E0wnE6OrjBwMYNEtu7YVDq8Vpcco/LDMtMuSSJveXz6gcZlrtJN8P8J8HeGj/LV9m41O
         ihGYfWWEE9vrbqBRIav7E5ClC7AxnBDjCdGkkb3bSjxIP11HJ69eruv1wsBJgm5WnYfa
         lDkzqPTH6qLIISoBXbJTFxPrc3Zcq4MNq1egUHu0ehnEIYi0eS629cBOMSZr9YJBymkj
         1Ck0JTNMuEbbiwDWExtXm0EopiZjgLN+73sfb+CexCVxpRIAH2g0KdnQ9KsXCOX7TeVc
         9Yaw==
X-Gm-Message-State: AC+VfDzmpUDQb6EY8ylfTd1foD2/HkoJWW7SIeZK6mZPVbDIlte+W91z
        Cy3s6PtY5+SeqKhMgHekGXw=
X-Google-Smtp-Source: ACHHUZ73of32hG9wDgV5ePpSUzHNcqrDv7Hd9jW7P8x8SqynUFgsnmCcOOGAPUgmgr+4d84YZuFWaQ==
X-Received: by 2002:a17:903:24e:b0:1ae:32d3:43b2 with SMTP id j14-20020a170903024e00b001ae32d343b2mr2046272plh.25.1684404550505;
        Thu, 18 May 2023 03:09:10 -0700 (PDT)
Received: from dev-linux.lan (cpe-70-95-21-110.san.res.rr.com. [70.95.21.110])
        by smtp.gmail.com with ESMTPSA id jb15-20020a170903258f00b001ae626d051bsm1031202plb.70.2023.05.18.03.09.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 03:09:10 -0700 (PDT)
From:   Sukrut Bellary <sukrut.bellary@linux.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Amol Maheshwari <amahesh@qti.qualcomm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Sukrut Bellary <sukrut.bellary@linux.com>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
Subject: [PATCH] misc: fastrpc: Fix double free of 'buf' in error path
Date:   Thu, 18 May 2023 03:08:29 -0700
Message-Id: <20230518100829.515143-1-sukrut.bellary@linux.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
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

Fix this by avoiding the call to the second fastrpc_buf_free() if
fastrpc_req_munmap_impl() is successful.
'err' is not updated as it needs to retain the err returned by
qcom_scm_assign_mem(), which is the starting point of this error path.

This is based on static analysis only. Compilation tested.

Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>
Signed-off-by: Sukrut Bellary <sukrut.bellary@linux.com>
---
 drivers/misc/fastrpc.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index f48466960f1b..1c3ab78f274f 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -1921,7 +1921,10 @@ static int fastrpc_req_mmap(struct fastrpc_user *fl, char __user *argp)
 	return 0;
 
 err_assign:
-	fastrpc_req_munmap_impl(fl, buf);
+	if (!fastrpc_req_munmap_impl(fl, buf)) {
+		/* buf is freed */
+		return err;
+	}
 err_invoke:
 	fastrpc_buf_free(buf);
 
-- 
2.34.1

