Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C918964E4B5
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 00:32:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbiLOXch (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 18:32:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229730AbiLOXcf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 18:32:35 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7016D4A5B6
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 15:32:34 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id o12so749203pjo.4
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 15:32:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=to:from:cc:content-transfer-encoding:mime-version:message-id:date
         :subject:from:to:cc:subject:date:message-id:reply-to;
        bh=kQ9ItmDRgbW04LygMs9P/+XkNt2iGLa92u7ZmkVsxPg=;
        b=3+h2uaJDaSROOvhBboqSxfpmgcWvz1ocI/sUoSk0anox6Ro9tkY+Mpb7qnGlSAWbot
         HwE6sDES8qP6LiNBAOCrY4R27F6G8EjGIqNMEvtfvP54d17ZfNqltqikhSSphUyAbU4/
         2yaZ18MrDSAoHsCQkQq663M55YvdNlKljmrvnxnWHkgKuqPMqdVMn4vNQVGY277aTe+H
         VOXAed9NCFQOPMca8KEXgw/nfixmnkC646RmvPmTXxR3W5+GQ6sOFazodSMi4CcKFYrL
         AS1xmVxyDVs8DVPbKkdzgbQ9oAL9KpruyhHGWiKLQvCkRJ3vhluI6KkWjTKllhCHzJOD
         LNQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:cc:content-transfer-encoding:mime-version:message-id:date
         :subject:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kQ9ItmDRgbW04LygMs9P/+XkNt2iGLa92u7ZmkVsxPg=;
        b=LwzhgZxT1u4RpgPC5sE9CGplpITnaKyFYsjLNM1wrIxkU41RZ3kzpwiKtuLA1ncfLA
         ItXSLn1qxuU32TO8HPe9245qosKjVS7lh4cl6ReG8xSvWRAEw6GR61O9JvqlaHdNBGoy
         pd6qsct2n/HZBPzcYMNr4B9OYqgI8Ut3wWWYjbTfVXbkiozUyetKAnh3exejyjBqg6+b
         zZ9czKDcc2OBD8L0KhD/irUzqjvX8aesqaN02suBKZiGEKnd6ZKUk3/L/t1Wv9Vx/fhR
         lyu34THr1WlKnnW66LAISvyQUlvFgbVQE92K7EvEiFX5GnZeIfQdvsoF8mrgui4fPztU
         zZyA==
X-Gm-Message-State: ANoB5pmFHQz4+xRxXPNH5NBHr+1uYBoN333NfI8ucaEEoU9q3erGoDLX
        eDs+p8WemhJewUr/EusT9XJFNQ==
X-Google-Smtp-Source: AA0mqf75MxP2xc7QbEyCwvdrf4xocmKX6dgvBFbdllqKlo95HpGTqG+OONx5pr8F6fsbtubS0YZlVw==
X-Received: by 2002:a17:902:b087:b0:189:e81b:d25f with SMTP id p7-20020a170902b08700b00189e81bd25fmr29657502plr.56.1671147153845;
        Thu, 15 Dec 2022 15:32:33 -0800 (PST)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id b4-20020a170902d50400b00182a9c27acfsm167565plg.227.2022.12.15.15.32.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Dec 2022 15:32:33 -0800 (PST)
Subject: [PATCH] RDMA/rxe: Avoid unused variable warnings on 32-bit targets
Date:   Thu, 15 Dec 2022 15:28:37 -0800
Message-Id: <20221215232837.30211-1-palmer@rivosinc.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc:     zyjzyj2000@gmail.com, jgg@ziepe.ca, leon@kernel.org,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux@rivosinc.com, Palmer Dabbelt <palmer@rivosinc.com>
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     jgg@nvidia.com
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Palmer Dabbelt <palmer@rivosinc.com>

These variables are not used on 32-bit targets as there's a big ifdef
around their use.  This results on a handful of warnings for 32-bit
RISC-V allyesconfig:

  CC      drivers/infiniband/sw/rxe/rxe_resp.o
linux/drivers/infiniband/sw/rxe/rxe_resp.c: In function 'atomic_write_reply':
linux/drivers/infiniband/sw/rxe/rxe_resp.c:794:13: error: unused variable 'payload' [-Werror=unused-variable]
  794 |         int payload = payload_size(pkt);
      |             ^~~~~~~
linux/drivers/infiniband/sw/rxe/rxe_resp.c:793:24: error: unused variable 'mr' [-Werror=unused-variable]
  793 |         struct rxe_mr *mr = qp->resp.mr;
      |                        ^~
linux/drivers/infiniband/sw/rxe/rxe_resp.c:791:19: error: unused variable 'dst' [-Werror=unused-variable]
  791 |         u64 src, *dst;
      |                   ^~~
linux/drivers/infiniband/sw/rxe/rxe_resp.c:791:13: error: unused variable 'src' [-Werror=unused-variable]
  791 |         u64 src, *dst;
      |             ^~~
cc1: all warnings being treated as errors

Fixes: 034e285f8b99 ("RDMA/rxe: Make responder support atomic write on RC service")
Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
---
 drivers/infiniband/sw/rxe/rxe_resp.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
index 7a60c7709da0..18977d5a3316 100644
--- a/drivers/infiniband/sw/rxe/rxe_resp.c
+++ b/drivers/infiniband/sw/rxe/rxe_resp.c
@@ -788,10 +788,10 @@ static enum resp_states atomic_reply(struct rxe_qp *qp,
 static enum resp_states atomic_write_reply(struct rxe_qp *qp,
 						struct rxe_pkt_info *pkt)
 {
-	u64 src, *dst;
-	struct resp_res *res = qp->resp.res;
-	struct rxe_mr *mr = qp->resp.mr;
-	int payload = payload_size(pkt);
+	__maybe_unused u64 src, *dst;
+	__maybe_unused struct resp_res *res = qp->resp.res;
+	__maybe_unused struct rxe_mr *mr = qp->resp.mr;
+	__maybe_unused int payload = payload_size(pkt);
 
 	if (!res) {
 		res = rxe_prepare_res(qp, pkt, RXE_ATOMIC_WRITE_MASK);
-- 
2.38.1

