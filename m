Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 988C6642827
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 13:12:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231755AbiLEMMh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 07:12:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231688AbiLEMM1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 07:12:27 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B8611A227
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 04:12:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A36EA61033
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 12:12:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB129C433C1;
        Mon,  5 Dec 2022 12:12:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1670242345;
        bh=43jvevdKv4umtU+wp4x+NPKgDNGKY9Kf0Q7wT6D1kl0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hi0hvPgkNF6kJ4476VQzRzmX/STtGvBy6KyQLv86O7AnTaVcY75yee4wCp/8qgpW8
         QjyB3zO1tpv8cn67xh7SQDv8lowHdNjzjZBGdXszg8Ca/dZFeZewSx8955IlnTxWeG
         6RYnmxX2aH8AVpAxa1m41h8vsNmkEdFJvqR4nWZE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Russ Weight <russell.h.weight@intel.com>
Subject: [PATCH v2 4/4] firmware_loader: fix up to_fw_sysfs() to preserve const
Date:   Mon,  5 Dec 2022 13:12:06 +0100
Message-Id: <20221205121206.166576-4-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221205121206.166576-1-gregkh@linuxfoundation.org>
References: <20221205121206.166576-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1518; i=gregkh@linuxfoundation.org; h=from:subject; bh=43jvevdKv4umtU+wp4x+NPKgDNGKY9Kf0Q7wT6D1kl0=; b=owGbwMvMwCRo6H6F97bub03G02pJDMm9D0TtFm79+chBzTymYqGa44T6QxdDmJ5xzdMvnVPjZvRs qpNRRywLgyATg6yYIsuXbTxH91ccUvQytD0NM4eVCWQIAxenAEzEYyXDXNHSuy7qtxw5X100Ld36tj p514R2ZYb5fn8lvNx80v6+yktbduBxjO7XrorLAA==
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

to_fw_sysfs() was changed in commit 23680f0b7d7f ("driver core: make
struct class.dev_uevent() take a const *") to pass in a const pointer
but not pass it back out to handle some changes in the driver core.
That isn't the best idea as it could cause problems if used incorrectly,
so switch to use the container_of_const() macro instead which will
preserve the const status of the pointer and enforce it by the compiler.

Cc: Luis Chamberlain <mcgrof@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Acked-by: Russ Weight <russell.h.weight@intel.com>
Fixes: 23680f0b7d7f ("driver core: make struct class.dev_uevent() take a const *")
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
v2: - respin with changed container_of_const() parameters

 drivers/base/firmware_loader/sysfs.h | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/base/firmware_loader/sysfs.h b/drivers/base/firmware_loader/sysfs.h
index fd0b4ad9bdbb..2060add8ef81 100644
--- a/drivers/base/firmware_loader/sysfs.h
+++ b/drivers/base/firmware_loader/sysfs.h
@@ -80,11 +80,7 @@ struct fw_sysfs {
 	struct firmware *fw;
 	void *fw_upload_priv;
 };
-
-static inline struct fw_sysfs *to_fw_sysfs(const struct device *dev)
-{
-	return container_of(dev, struct fw_sysfs, dev);
-}
+#define to_fw_sysfs(__dev)	container_of_const(__dev, struct fw_sysfs, dev)
 
 void __fw_load_abort(struct fw_priv *fw_priv);
 
-- 
2.38.1

