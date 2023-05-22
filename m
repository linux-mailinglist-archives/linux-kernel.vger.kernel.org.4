Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DBF170B9AE
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 12:12:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbjEVKMg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 06:12:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232157AbjEVKMa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 06:12:30 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9F56C4
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 03:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684750349; x=1716286349;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tAF2CzJW9vSbgRJrTBfp96GQg1s66GPivnBYn+KlQdY=;
  b=cbgQCGyYl6HwGZNrUu30p1JXVToZz8/zd7qt+RpI/0oItqMqFiEf6rA7
   94BJHVZUEP3GLsanSdQR/buEay8LF4IWuLZO8wewDdLWT0EZUyFBM7sj4
   UeEY39ucN9V7HoEDh2jtj0WFdrKT3vT9AobmFFCVKU/zlSjks9xMQzDol
   j/inLlk+k2dXTeSU7Tunt8lR5MY5KTEr/VWcLCnJhzXoTwcaPAam8QeCk
   uyQUQZF6+IAOy4XWtjxD8lizCn9dkRbwQjDUuoMU9k17OT2AgfhW+pBqL
   mvA3t/O6L5WJ7sCI9VqYAePo86rC8/rZTg+6JTAFuTmH/TnauOnWAh2/l
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10717"; a="333245344"
X-IronPort-AV: E=Sophos;i="6.00,184,1681196400"; 
   d="scan'208";a="333245344"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2023 03:12:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10717"; a="1033575419"
X-IronPort-AV: E=Sophos;i="6.00,184,1681196400"; 
   d="scan'208";a="1033575419"
Received: from twinkler-lnx.jer.intel.com ([10.12.230.239])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2023 03:12:27 -0700
From:   Tomas Winkler <tomas.winkler@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Alexander Usyskin <alexander.usyskin@intel.com>,
        Vitaly Lubart <vitaly.lubart@intel.com>,
        linux-kernel@vger.kernel.org,
        Tomas Winkler <tomas.winkler@intel.com>
Subject: [char-misc-next 2/2] mei: bus-fixup: fix buffer type
Date:   Mon, 22 May 2023 13:12:10 +0300
Message-Id: <20230522101210.2207395-2-tomas.winkler@intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230522101210.2207395-1-tomas.winkler@intel.com>
References: <20230522101210.2207395-1-tomas.winkler@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Usyskin <alexander.usyskin@intel.com>

The __mei_cl_recv and __mei_cl_send accepts u8 buffer.
Fix buffer type from char to u8.

Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
---
 drivers/misc/mei/bus-fixup.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/mei/bus-fixup.c b/drivers/misc/mei/bus-fixup.c
index 31e3c74ca1f1e4a377592fb8..b8b716faf1921914fad9fcc7 100644
--- a/drivers/misc/mei/bus-fixup.c
+++ b/drivers/misc/mei/bus-fixup.c
@@ -108,7 +108,7 @@ struct mkhi_fw_ver {
 static int mei_osver(struct mei_cl_device *cldev)
 {
 	const size_t size = MKHI_OSVER_BUF_LEN;
-	char buf[MKHI_OSVER_BUF_LEN];
+	u8 buf[MKHI_OSVER_BUF_LEN];
 	struct mkhi_msg *req;
 	struct mkhi_fwcaps *fwcaps;
 	struct mei_os_ver *os_ver;
@@ -137,7 +137,7 @@ static int mei_osver(struct mei_cl_device *cldev)
 			       sizeof(struct mkhi_fw_ver_block) * (__num))
 static int mei_fwver(struct mei_cl_device *cldev)
 {
-	char buf[MKHI_FWVER_BUF_LEN];
+	u8 buf[MKHI_FWVER_BUF_LEN];
 	struct mkhi_msg req;
 	struct mkhi_msg *rsp;
 	struct mkhi_fw_ver *fwver;
-- 
2.40.1

