Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 718FE6BACEB
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 11:03:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231940AbjCOKDU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 06:03:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231386AbjCOKDB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 06:03:01 -0400
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 139A584801
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 03:01:36 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 8301F24001B;
        Wed, 15 Mar 2023 10:01:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1678874493;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=X8q+3qBKuCZzlT3vjk4NJTDyLJ76Yq7oZLAj93l08Y4=;
        b=Z+305vMGrWBxbMUW8+OThfe7GJmTmEI0My/WKUGwr7y1ww1G3VVois/r4DR/846kmo//Zs
        YT91l6mcwXegVNcuGrD/qIGnOz/UAfj8pVsEHBp2bLpu/pbHML7X7VZvo5WexBIc1p/51D
        B4e+1P5xHJLQQlRI1UML4R/uhOObAM33AleP1sXWrBxA9auWrKjpkC9atFCRblghqA9fSD
        gFsZO37+2H5P9+l6ALiPoa2HZvqdaSyiYXEQmZai084bqfABGnqaAjgqkxCFUjbxekPnaa
        xxjFNL4NTuE9dq/fHr/hGHRvefFJ6UtJruxrhMUFVWGSG3rWvhBB9bvoJ8w/Sg==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>
Cc:     Michael Walle <michael@walle.cc>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
        Robert Marko <robert.marko@sartura.hr>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH 1/4] nvmem: Add macro to register nvmem layout drivers
Date:   Wed, 15 Mar 2023 11:00:15 +0100
Message-Id: <20230315100018.1660071-2-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230315100018.1660071-1-miquel.raynal@bootlin.com>
References: <20230315100018.1660071-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide a module_nvmem_layout_driver() macro at the end of the
nvmem-provider.h header to reduce the boilerplate when registering nvmem
layout drivers.

Suggested-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 include/linux/nvmem-provider.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/nvmem-provider.h b/include/linux/nvmem-provider.h
index 0cf9f9490514..a1c668018894 100644
--- a/include/linux/nvmem-provider.h
+++ b/include/linux/nvmem-provider.h
@@ -240,4 +240,9 @@ nvmem_layout_get_match_data(struct nvmem_device *nvmem,
 }
 
 #endif /* CONFIG_NVMEM */
+
+#define module_nvmem_layout_driver(__layout_driver)		\
+	module_driver(__layout_driver, nvmem_layout_register,	\
+		      nvmem_layout_unregister)
+
 #endif  /* ifndef _LINUX_NVMEM_PROVIDER_H */
-- 
2.34.1

