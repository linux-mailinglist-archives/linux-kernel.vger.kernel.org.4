Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB29A5EFEBE
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 22:39:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbiI2Ujl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 16:39:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbiI2Uji (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 16:39:38 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0F73139BD9;
        Thu, 29 Sep 2022 13:39:28 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id l8so1717667wmi.2;
        Thu, 29 Sep 2022 13:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=8HxfVkb86a/9E74ifE6otX6893P7GQ/dNRVt4bGFG0o=;
        b=BhCtOAuznjldNcQuORYTxa+o/fGUda93skrPTPEFSC/oIr0MWBV9ceJ6rSZtFZ3K8U
         yZZce/98s7SGVke14zsKpV5XnzTNmra2lF8ltabjppQY0hUC8D7N3ytyHaVvRxSSrxJE
         rBfa4V4FuT+9jbp7B4N7YZj2w/YuFaUBUozvZQUPFdYTxCBEkloUM+f311naxS/il0Y/
         d1EnX34rcjTgYIFD/ZyZ94TAeAS3VzX+HFZtTHZ+RZb7t/M4nBzTYMzFSgVY2tvpz/Ee
         vN8hp1ESh2D31vwjHqQ1zRt3cfJCVvQPAMnzVPZGA8HtbJzyzYuIs0CnyAxl5KSeWHES
         iKmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=8HxfVkb86a/9E74ifE6otX6893P7GQ/dNRVt4bGFG0o=;
        b=sY5WtmE8cHDB8PA0WazO88/zXFYNP99LQ+HgLcPPVfQF04dXF841Wy/FwfhMokaCCq
         BJ9Dy5EpZLPHy0pqQcqSvGXc05HYrHZPgjIMw+vuVuzvbgZ6h5bwCmH/k7QwC1Ff4MLX
         DGGiktf8wbBQoEhdh3A3zsHuZcgL3uDT/x8003PCErMW2JgyLUguPfeL9WCPOYhZUQZ/
         9ltKQw3GFcP1B4mIvHvotRQjDozFZDO5/hqIzp1SqMMb/gMpowXUcRKMY5GzyKu15jCT
         Ui6E7evh+JiXF2uohHI1x/ziYAMHnZLX7n0Gf+hdPAoJ7YM7gmKXuGO/gh3jxnAt74Kk
         A1Bg==
X-Gm-Message-State: ACrzQf2Qf5vpNG0DQjzJ27t39+jA6jEsxnGdaeEtGemz7ezqOK/p400W
        aFoSFa8p/6P3ScEBVBuUsJo=
X-Google-Smtp-Source: AMsMyM43tTPXmPyW9dctFM3wbg6DT2/MrYdQT7nJh5fcR7UsUyKR3fuuxnZOqvaCZk9Td1ueTQAHrw==
X-Received: by 2002:a05:600c:a46:b0:3a6:9c49:b751 with SMTP id c6-20020a05600c0a4600b003a69c49b751mr12276372wmq.169.1664483967114;
        Thu, 29 Sep 2022 13:39:27 -0700 (PDT)
Received: from felia.fritz.box (200116b826e1120029bb820a6dec0039.dip.versatel-1u1.de. [2001:16b8:26e1:1200:29bb:820a:6dec:39])
        by smtp.gmail.com with ESMTPSA id h9-20020a1c2109000000b003b4fac020c8sm4960755wmh.16.2022.09.29.13.39.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Sep 2022 13:39:26 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>, linux-mm@kvack.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] binfmt: remove taso from linux_binprm struct
Date:   Thu, 29 Sep 2022 22:39:03 +0200
Message-Id: <20220929203903.9475-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With commit 987f20a9dcce ("a.out: Remove the a.out implementation"), the
use of the special taso flag for alpha architectures in the linux_binprm
struct is gone.

Remove the definition of taso in the linux_binprm struct.

No functional change.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
Kees, please pick this patch on top of the commit above.

 include/linux/binfmts.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/include/linux/binfmts.h b/include/linux/binfmts.h
index 3dc20c4f394c..8d51f69f9f5e 100644
--- a/include/linux/binfmts.h
+++ b/include/linux/binfmts.h
@@ -43,9 +43,6 @@ struct linux_binprm {
 		 * original userspace.
 		 */
 		point_of_no_return:1;
-#ifdef __alpha__
-	unsigned int taso:1;
-#endif
 	struct file *executable; /* Executable to pass to the interpreter */
 	struct file *interpreter;
 	struct file *file;
-- 
2.17.1

