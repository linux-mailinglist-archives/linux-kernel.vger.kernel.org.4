Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A3AC74CD6D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 08:46:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231751AbjGJGqb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 02:46:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231765AbjGJGqY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 02:46:24 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C01AB13D
        for <linux-kernel@vger.kernel.org>; Sun,  9 Jul 2023 23:46:17 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-4fb8574a3a1so5945412e87.1
        for <linux-kernel@vger.kernel.org>; Sun, 09 Jul 2023 23:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20221208.gappssmtp.com; s=20221208; t=1688971576; x=1691563576;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ULsnDQO1R7NyZ+kouszec1NukJNpex1WKOoz+5ctk5g=;
        b=iN11EwNuCYJVzKWiNxWAiJm8rJAuhdBLhYn/saKzDSMf6Iea26hmVZxeWxz11kAfrj
         bzVxBg6FQrgjJKE9pmHccMQ8536A+rzOcHkCc4JTDMkodoYrA5pM3MxEtzqluG6SPuC/
         qA5Iq1Yda6HgCr1XKS6kjAeM0hfm+jszEzvEDQnLmTngZB7r3Jd+STnUUGspIV3PbaNU
         KrePbHuRJyp1uM4lNmbiDrc1lAiIQmVD7X9SlEM89JHnia4ZwWwhAqzvB4yqa80ixF3G
         1E4EM6eazl+iQdJwsej084Iyam/8WP8uJ+3NhgJwZALKl81J4c5m73PnxjtxseAmJ8eP
         h2rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688971576; x=1691563576;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ULsnDQO1R7NyZ+kouszec1NukJNpex1WKOoz+5ctk5g=;
        b=eVpr7m29Tk+G+ztzFUP2vzO/NaVFHzsSMRKAP3yRe8yYxbSGXG1eobgo9ovTuaCWld
         0HGJteqwJ0pDJJTV3L8lSRmzo9Jv7imZQlP8TSJ0Qsry+2MBqGG3apU33izgRE/ilFys
         Anh8ceTOuX+8E2zJ8S1OBPkScfloIAv6Q2gSSxdoIIAyhIKT0eeEC0M9ksjJs+SXwq7P
         Hdu/bGrtnA6wx5A5oXuV2QmaiFpQgIG3VwTD426qZJImXprOKYzJnqlx3UeNKC0myoZK
         BrGOlzfYOI1XsUfcAoxYHSkvGXbtzjNlwCWDQ7NCa8jwMAyt8ikE0Uwk45QhIc9cSTyu
         bDvQ==
X-Gm-Message-State: ABy/qLbaPMFP0UxrpgHOJiZ5wmYVD8WY56OizCEFzlwOy1omjjJyWg9/
        QCXxNaziunY8kG8++fCdzMJrhg==
X-Google-Smtp-Source: APBJJlH+KwfP0iXrYfC4TF8IXL0FGxEwLXpWZvQPSKOjAD+BoK1B9huhRG10FL4VqbmvqxkKgPY6HQ==
X-Received: by 2002:a05:6512:b8c:b0:4f9:556b:93c2 with SMTP id b12-20020a0565120b8c00b004f9556b93c2mr11304889lfv.1.1688971575928;
        Sun, 09 Jul 2023 23:46:15 -0700 (PDT)
Received: from localhost ([185.108.254.55])
        by smtp.gmail.com with ESMTPSA id f15-20020ac251af000000b004fb8668e6cfsm1567079lfk.124.2023.07.09.23.46.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Jul 2023 23:46:15 -0700 (PDT)
From:   Andreas Hindborg <nmi@metaspace.dk>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Hans Holmberg <Hans.Holmberg@wdc.com>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        linux-block@vger.kernel.org (open list:BLOCK LAYER),
        linux-kernel@vger.kernel.org (open list),
        Johannes Thumshirn <jth@kernel.org>,
        Damien Le Moal <dlemoal@kernel.org>,
        Matias Bjorling <Matias.Bjorling@wdc.com>,
        Christoph Hellwig <hch@infradead.org>,
        Minwoo Im <minwoo.im.dev@gmail.com>, gost.dev@samsung.com,
        Aravind Ramesh <Aravind.Ramesh@wdc.com>
Subject: [PATCH v7 1/3] ublk: add opcode offsets for DRV_IN/DRV_OUT
Date:   Mon, 10 Jul 2023 08:46:04 +0200
Message-ID: <20230710064607.155155-2-nmi@metaspace.dk>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230710064607.155155-1-nmi@metaspace.dk>
References: <20230710064607.155155-1-nmi@metaspace.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andreas Hindborg <a.hindborg@samsung.com>

Ublk zoned storage support relies on DRV_IN handling for zone report.
Prepare for this change by adding offsets for the DRV_IN/DRV_OUT commands.

Suggested-by: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Andreas Hindborg <a.hindborg@samsung.com>
---
 include/uapi/linux/ublk_cmd.h | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/include/uapi/linux/ublk_cmd.h b/include/uapi/linux/ublk_cmd.h
index 4b8558db90e1..521a0d2fbc06 100644
--- a/include/uapi/linux/ublk_cmd.h
+++ b/include/uapi/linux/ublk_cmd.h
@@ -229,12 +229,23 @@ struct ublksrv_ctrl_dev_info {
 	__u64   reserved2;
 };
 
-#define		UBLK_IO_OP_READ		0
+#define		UBLK_IO_OP_READ			0
 #define		UBLK_IO_OP_WRITE		1
 #define		UBLK_IO_OP_FLUSH		2
-#define		UBLK_IO_OP_DISCARD	3
-#define		UBLK_IO_OP_WRITE_SAME	4
-#define		UBLK_IO_OP_WRITE_ZEROES	5
+#define		UBLK_IO_OP_DISCARD		3
+#define		UBLK_IO_OP_WRITE_SAME		4
+#define		UBLK_IO_OP_WRITE_ZEROES		5
+/*
+ * Ublk passthrough operation code ranges, and each passthrough operation
+ * provides generic interface between ublk kernel driver and ublk userspace, and
+ * this interface is usually used for handling generic block layer request, such
+ * as command of zoned report zones. Passthrough operation is only needed iff
+ * ublk kernel driver has to be involved for handling this operation.
+ */
+#define		__UBLK_IO_OP_DRV_IN_START	32
+#define		__UBLK_IO_OP_DRV_IN_END		96
+#define		__UBLK_IO_OP_DRV_OUT_START	__UBLK_IO_OP_DRV_IN_END
+#define		__UBLK_IO_OP_DRV_OUT_END	160
 
 #define		UBLK_IO_F_FAILFAST_DEV		(1U << 8)
 #define		UBLK_IO_F_FAILFAST_TRANSPORT	(1U << 9)
-- 
2.41.0

