Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C6CF601461
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 19:12:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229592AbiJQRL5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 13:11:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230003AbiJQRLy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 13:11:54 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ECF86FA0F
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 10:11:53 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id q9so10996256pgq.8
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 10:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0tBsZ76gwc8/70eg063yamfq95Tc780KUhRC9NyQyUU=;
        b=JfqX/tWXuWfol9Fbo7MMWPEIFekj8VCvbIam0iehMAxcW9tuJ0AW88tOYP1WRwJvVR
         8MKwYYrzg1NOd9uiLXL/mItJH+Ryi/C3tcDrgRmOwmQTCqtVXWncmqhdarpXTD6ljyKW
         N9Z8PbF/v6gBfq2SYCKJVrmfFcJVeDP9Vm4f0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0tBsZ76gwc8/70eg063yamfq95Tc780KUhRC9NyQyUU=;
        b=jssn4aMpDUFTlcnfMsvpV3mCYOekFktMpYAk9fUaO7aOQLTkZsilTN1OwMZ/y/4FuD
         tJQ8kOmPif4l2dLYJ+klIgbdskixa5Ox84GEys4w30n4qD53Pq9ZV/ivN21FI6t0Etdt
         Q+pfVs27C5Uj29NApwruraw1hbAHWJrO77r9gM3KRA1HH02F9FRXtEuNRjFwhY+K+4r1
         ipJKgJ2iud6KDvXEy2CofOESarS9B4j5+o9x/Pa0XlStG+HZx7pHc/iTyVziKFUbi0Gb
         ytlKxZ1do4pCgL7WZryhqI4P1cVr7Oj2hgPiz+VMM9VjfI2rqZm5x9KxgW29NW3p0gWw
         4Q9w==
X-Gm-Message-State: ACrzQf2LDkfbnDUfRVpql1Brt/wtCTB1vcbhOQMoM8P5OjQBc8leJBdK
        50sQ0YOvuvE7316NFpUw/xiipg==
X-Google-Smtp-Source: AMsMyM74ewJl164Y2UsNgLzMWBSmVqg3OL997xAOzqDhQPpx44i3PgLUYOrFqW4PdN9S9F71YSELuQ==
X-Received: by 2002:a63:4a53:0:b0:439:3c80:e053 with SMTP id j19-20020a634a53000000b004393c80e053mr11584993pgl.3.1666026712543;
        Mon, 17 Oct 2022 10:11:52 -0700 (PDT)
Received: from khazhy-linux.svl.corp.google.com ([2620:15c:2d4:203:a9cb:592c:5760:8872])
        by smtp.gmail.com with ESMTPSA id b8-20020a17090a7ac800b00205d70ccfeesm9706025pjl.33.2022.10.17.10.11.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 10:11:52 -0700 (PDT)
From:   Khazhismel Kumykov <khazhy@chromium.org>
X-Google-Original-From: Khazhismel Kumykov <khazhy@google.com>
To:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Gabriel Krisman Bertazi <krisman@collabora.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Khazhismel Kumykov <khazhy@google.com>
Subject: [PATCH] scsi: fix crash in scsi_remove_host after alloc failure
Date:   Mon, 17 Oct 2022 10:11:47 -0700
Message-Id: <20221017171147.3300575-1-khazhy@google.com>
X-Mailer: git-send-email 2.38.0.413.g74048e4d9e-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If transport_register_device returns error, shost_gendev has already
been cleaned up - however since we ignore the error device setup
continues happily. We will eventually call transport_unregister_device,
attempting to delete shost_gendev again, resulting in a crash.

It looks like when this cleanup behavior was added, iscsi was updated,
but scsi was missed.

Fixes: cd7ea70bb00a ("scsi: drivers: base: Propagate errors through the transport component")

Signed-off-by: Khazhismel Kumykov <khazhy@google.com>
---
 drivers/scsi/scsi_sysfs.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/scsi_sysfs.c b/drivers/scsi/scsi_sysfs.c
index c95177ca6ed2..722ab042fbd7 100644
--- a/drivers/scsi/scsi_sysfs.c
+++ b/drivers/scsi/scsi_sysfs.c
@@ -1599,7 +1599,11 @@ EXPORT_SYMBOL(scsi_register_interface);
  **/
 int scsi_sysfs_add_host(struct Scsi_Host *shost)
 {
-	transport_register_device(&shost->shost_gendev);
+	int err;
+
+	err = transport_register_device(&shost->shost_gendev);
+	if (err)
+		return err;
 	transport_configure_device(&shost->shost_gendev);
 	return 0;
 }
-- 
2.38.0.413.g74048e4d9e-goog

