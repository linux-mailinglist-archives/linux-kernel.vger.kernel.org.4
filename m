Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C44696672BC
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 13:57:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232545AbjALM5f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 07:57:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231582AbjALM4q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 07:56:46 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13DAADEC9;
        Thu, 12 Jan 2023 04:56:46 -0800 (PST)
Received: from localhost (89-26-75-29.goll.dyn.salzburg-online.at [89.26.75.29])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sebastianfricke)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id BF6A36602DBB;
        Thu, 12 Jan 2023 12:56:44 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1673528204;
        bh=GtQZT2nN8QVz9LN/mUHoZT/CUo6gIVaMFXE6EeZP8+w=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=f3+wXOfId313ZjMh/uj5YyArXZ6QYSDBTl+YVjkRP7vNA+aP9XlSN7x31pOqpO/i0
         U3XO5+2Qtclgr/r+hSRfU/AN+LfDrxKmTKLaRJuIt2EUryjNtbN9xgdsOhK7h445kP
         9FvsvDF8lu94aevG1t2G5NA3coRX2H2u8epSH5srfqlProjYdCGS9eNDwMT2iSdB9l
         1BJQVrrxC3m+tqhcXg5cESXNUPLHcm/3LfdAyEYwt3VxQXOv7lH85o7SeNe7WSrkmm
         MCLS5aMFnELvLxFYZq+jkhufKL3Ahp0BsIi7a8uSaCkF3/IrYc/t70/+3uFD2ZFm3S
         qwQKrW4BVuUHA==
From:   Sebastian Fricke <sebastian.fricke@collabora.com>
Date:   Thu, 12 Jan 2023 13:56:20 +0100
Subject: [PATCH v2 05/12] staging: media: rkvdec: Add SPS structure to
 internal context
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230101-patch-series-v2-6-2-rc1-v2-5-fa1897efac14@collabora.com>
References: <20230101-patch-series-v2-6-2-rc1-v2-0-fa1897efac14@collabora.com>
In-Reply-To: <20230101-patch-series-v2-6-2-rc1-v2-0-fa1897efac14@collabora.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-staging@lists.linux.dev,
        Jonas Karlman <jonas@kwiboo.se>,
        Alex Bee <knaerzche@gmail.com>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        Collabora Kernel-domain <kernel@collabora.com>,
        Robert Beckett <bob.beckett@collabora.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Sebastian Fricke <sebastian.fricke@collabora.com>
X-Mailer: b4 0.11.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1673528186; l=801;
 i=sebastian.fricke@collabora.com; s=linux-media; h=from:subject:message-id;
 bh=GtQZT2nN8QVz9LN/mUHoZT/CUo6gIVaMFXE6EeZP8+w=;
 b=OjC0Py2sReXxL+AYZYLXHyPGdbsOwyx+uqaYl4Y1kEeTAbxmGZkntvZnq3XKEtOeM85QWw+Ztya4
 wmZhOV/OBs/BI5WNTao0NajI7uAMZXp/pcpslmQlBD+AoRw3Kxzc
X-Developer-Key: i=sebastian.fricke@collabora.com; a=ed25519;
 pk=pYXedPwrTtErcj7ERYeo/IpTrpe4QbJuEzSB52fslBg=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prepare storing the SPS structure for HEVC & H264 in the internal
context of the rkvdec instance. This structure is used to figure out
which capture queue format is appropriate for decoding.

Signed-off-by: Sebastian Fricke <sebastian.fricke@collabora.com>
---
 drivers/staging/media/rkvdec/rkvdec.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/staging/media/rkvdec/rkvdec.h b/drivers/staging/media/rkvdec/rkvdec.h
index 633335ebb9c4..332126e7b812 100644
--- a/drivers/staging/media/rkvdec/rkvdec.h
+++ b/drivers/staging/media/rkvdec/rkvdec.h
@@ -105,6 +105,7 @@ struct rkvdec_ctx {
 	struct v4l2_ctrl_handler ctrl_hdl;
 	struct rkvdec_dev *dev;
 	void *priv;
+	void *sps;
 };
 
 static inline struct rkvdec_ctx *fh_to_rkvdec_ctx(struct v4l2_fh *fh)

-- 
2.25.1
