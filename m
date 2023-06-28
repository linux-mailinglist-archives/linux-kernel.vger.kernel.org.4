Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 948277418AD
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 21:08:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232144AbjF1THY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 15:07:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232138AbjF1THA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 15:07:00 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 653B6212E
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 12:06:55 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2b5c231c23aso2952511fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 12:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20221208.gappssmtp.com; s=20221208; t=1687979213; x=1690571213;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1+mgtaI49ANVecSJsMlgWiAuBSlWzk7jhi+QFImWVd0=;
        b=PkKpRHm88ty23JmdD6Stv68WY2ScVPPFNR0Y4NXYM3+ohmSQ8JoLfz3P6aKYHyfa3J
         XtO6/D3dg4RfSDjOC99oQIU0dCtIL8m47OtuB/Qw2NlYnKF3fucYg95jzZESwcJHMZ8w
         4FUQ9WeZccmv9k805txFr46dsytAXQBoWqRgDbvNvdp8iDeD59ulFumL4NNN6mIY6K1s
         q8zmTlCYHivwHdQJQRrdFlCEMi/J5TzNG0SWvsXwcZmgB1aFXmyzy+Uy1xGxCkpeRjTh
         ZzLqbjKQzATcgk4ldAWg9NOiP90rN4aeFHdOjlLAxqbqBxMX0oBKytS/ofFpMkZmCBn8
         rgXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687979213; x=1690571213;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1+mgtaI49ANVecSJsMlgWiAuBSlWzk7jhi+QFImWVd0=;
        b=gFuFtGoLKXlMyaRFFH/VM6Q8WYp80Ji2Wvie5txXMZObaMGHLG0/XPN6nrQQk4uKCu
         AD/J2+SSOljqtuLiLSwGwLVEgHiMiJEMVkc3oWCVF60Fl3SIondi+y6ej9cNvyKZpUzV
         ZvmoeH/sBp+pJ7Q557mKlF3R/KJOlzviTCHVuZ7RVwCU0B5ypPGPNjk5/c01NCoBM3CC
         wH3buNo4XbE5qDHp4/uBHRxPBG6mA51i+ycws0EGEn14+IMBxratjMGmP9nkxNHpS3k8
         8QWlG4P/bb/d9+dTh8rLSyFMZE/Jsn+bsWeSFxZnW3UHEfBkBt9aCy+AE3sYU6W6UZoT
         HsPg==
X-Gm-Message-State: AC+VfDxPpaP6zcu45DpiQsWpZzJWQU/t1yfnOuLgVU7olukXs9cqZcFR
        Oa5Ufzj8bZpyJiYZXWEvbeTMew==
X-Google-Smtp-Source: ACHHUZ4cZfpwaopcOAYuhNm1RnQpTqVHx2WlURuj621eIDqzHyync+Ojufp2+KNxr+hwEb7ONrnCeQ==
X-Received: by 2002:a2e:86c6:0:b0:2b6:c3b8:3a94 with SMTP id n6-20020a2e86c6000000b002b6c3b83a94mr915163ljj.42.1687979213445;
        Wed, 28 Jun 2023 12:06:53 -0700 (PDT)
Received: from localhost ([79.142.230.34])
        by smtp.gmail.com with ESMTPSA id ot6-20020a170906ccc600b0098df7d0e096sm5683211ejb.54.2023.06.28.12.06.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 12:06:53 -0700 (PDT)
From:   Andreas Hindborg <nmi@metaspace.dk>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Hans Holmberg <Hans.Holmberg@wdc.com>,
        Aravind Ramesh <Aravind.Ramesh@wdc.com>,
        Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org (open list:BLOCK LAYER),
        Christoph Hellwig <hch@infradead.org>,
        Matias Bjorling <Matias.Bjorling@wdc.com>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        linux-kernel@vger.kernel.org (open list),
        Damien Le Moal <dlemoal@kernel.org>, gost.dev@samsung.com,
        Minwoo Im <minwoo.im.dev@gmail.com>
Subject: [PATCH v4 1/4] ublk: change ublk IO command defines to enum
Date:   Wed, 28 Jun 2023 21:06:46 +0200
Message-ID: <20230628190649.11233-2-nmi@metaspace.dk>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230628190649.11233-1-nmi@metaspace.dk>
References: <20230628190649.11233-1-nmi@metaspace.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andreas Hindborg <a.hindborg@samsung.com>

This change is in preparation for zoned storage support.

Signed-off-by: Andreas Hindborg <a.hindborg@samsung.com>
---
 include/uapi/linux/ublk_cmd.h | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/include/uapi/linux/ublk_cmd.h b/include/uapi/linux/ublk_cmd.h
index 4b8558db90e1..471b3b983045 100644
--- a/include/uapi/linux/ublk_cmd.h
+++ b/include/uapi/linux/ublk_cmd.h
@@ -229,12 +229,23 @@ struct ublksrv_ctrl_dev_info {
 	__u64   reserved2;
 };
 
-#define		UBLK_IO_OP_READ		0
-#define		UBLK_IO_OP_WRITE		1
-#define		UBLK_IO_OP_FLUSH		2
-#define		UBLK_IO_OP_DISCARD	3
-#define		UBLK_IO_OP_WRITE_SAME	4
-#define		UBLK_IO_OP_WRITE_ZEROES	5
+enum ublk_op {
+	UBLK_IO_OP_READ = 0,
+	UBLK_IO_OP_WRITE = 1,
+	UBLK_IO_OP_FLUSH = 2,
+	UBLK_IO_OP_DISCARD = 3,
+	UBLK_IO_OP_WRITE_SAME = 4,
+	UBLK_IO_OP_WRITE_ZEROES = 5,
+	UBLK_IO_OP_ZONE_OPEN = 10,
+	UBLK_IO_OP_ZONE_CLOSE = 11,
+	UBLK_IO_OP_ZONE_FINISH = 12,
+	UBLK_IO_OP_ZONE_APPEND = 13,
+	UBLK_IO_OP_ZONE_RESET = 15,
+	__UBLK_IO_OP_DRV_IN_START = 32,
+	__UBLK_IO_OP_DRV_IN_END = 96,
+	__UBLK_IO_OP_DRV_OUT_START = __UBLK_IO_OP_DRV_IN_END,
+	__UBLK_IO_OP_DRV_OUT_END = 160,
+};
 
 #define		UBLK_IO_F_FAILFAST_DEV		(1U << 8)
 #define		UBLK_IO_F_FAILFAST_TRANSPORT	(1U << 9)
-- 
2.41.0

