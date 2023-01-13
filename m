Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC86366979F
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 13:45:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241383AbjAMMpG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 07:45:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241761AbjAMMnH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 07:43:07 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F41287F31
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 04:35:50 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id mp20so5393489ejc.7
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 04:35:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rnWGghdREJ6zIaEe7+G9hDEkG3lKlZcJtoyqEzGOui4=;
        b=7MggSvVJcvB+UhgdCA3YbS9r+ZOV3AkBaHplJBS3GHTsZ7kKYp6j6tXdu3rHlUqUXg
         CuAfampyUgvOK/Fjbv+qH5HZtB1stqe6g5zwpCnI2n1nXZ9V5LzZPISGD/8Rks0pJVd8
         3hOsc+AUF1w1Cgt6rac331YMACuqJ5zZDkJHuMd0X0+JgPBKuzSAYJu9TkR3TizU1AJ/
         phVvbDXyDj0AFqcLRk4ActDz2MfJpRpdnlUm2cpG6EFRJfyMePbRmfm7qZv/7xQCYsUL
         VtmfkqA8ATSi4pBSUl7CMjgtFQKfrHylppisWyml8jf0ra9PKm1lR0Akk9lI/b3A5BJK
         grHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rnWGghdREJ6zIaEe7+G9hDEkG3lKlZcJtoyqEzGOui4=;
        b=yu2yEfeMakIyYs+egWkCVwHSpXT055Ond6wt2n8Opf0gcGHBojxu0WsWDXnogYaiXq
         UxBTwM3S9p8uOnVDTcy8ruI4NlW8CAHxJUHcjmLyZWvOAGfSRaSDLKUq7UegqyyptphQ
         yoSzl6eTXpCJZ5t4Oe2l7T2A6yjqPZhVIIFAT/v9p5v17ryq+em9WCrQAT6b7Zm39ivz
         KBBEpG85L84A5htXEXRhkBkHMCsnFAD6+uD0UMhkEGrdpnxpzXHyBOKX9tB+DgbRqJ5b
         5FiOLIDTGYTdJ8isFLT9Zpt0+LseC7AGZ5EsZuVhITFCol+0OHXwT+S3mAk+W0NbG5Mf
         ce/g==
X-Gm-Message-State: AFqh2kqT7+SgVA2Gs29eYuxnKlKZ23zGqss3fIxs7Q36i/AnEGztDV0Z
        K2Q9r+eVUHin3V+H+hOBFwGZFw==
X-Google-Smtp-Source: AMrXdXs1zcfIgcaXvcxplpumwnRr+KMhCRY/vNTco05knDjB5ZLtnWzyxCP0Udy1N5NsZvzBzh/K/g==
X-Received: by 2002:a17:907:d50d:b0:801:d6f2:754 with SMTP id wb13-20020a170907d50d00b00801d6f20754mr70167151ejc.52.1673613320223;
        Fri, 13 Jan 2023 04:35:20 -0800 (PST)
Received: from localhost.localdomain (h082218028181.host.wavenet.at. [82.218.28.181])
        by smtp.gmail.com with ESMTPSA id 18-20020a170906201200b00846734faa9asm8386323ejo.164.2023.01.13.04.35.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 04:35:19 -0800 (PST)
From:   =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= 
        <christoph.boehmwalder@linbit.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     drbd-dev@lists.linbit.com, linux-kernel@vger.kernel.org,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        linux-block@vger.kernel.org,
        =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= 
        <christoph.boehmwalder@linbit.com>,
        Joel Colledge <joel.colledge@linbit.com>
Subject: [PATCH 2/3] drbd: drop API_VERSION define
Date:   Fri, 13 Jan 2023 13:35:05 +0100
Message-Id: <20230113123506.144082-3-christoph.boehmwalder@linbit.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230113123506.144082-1-christoph.boehmwalder@linbit.com>
References: <20230113123506.144082-1-christoph.boehmwalder@linbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the genetlink api version as defined in drbd_genl_api.h.

Signed-off-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>
Reviewed-by: Joel Colledge <joel.colledge@linbit.com>
---
 drivers/block/drbd/drbd_debugfs.c | 2 +-
 drivers/block/drbd/drbd_main.c    | 2 +-
 drivers/block/drbd/drbd_proc.c    | 2 +-
 include/linux/drbd.h              | 1 -
 include/linux/drbd_genl_api.h     | 2 +-
 5 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/block/drbd/drbd_debugfs.c b/drivers/block/drbd/drbd_debugfs.c
index a72c096aa5b1..12460b584bcb 100644
--- a/drivers/block/drbd/drbd_debugfs.c
+++ b/drivers/block/drbd/drbd_debugfs.c
@@ -844,7 +844,7 @@ static int drbd_version_show(struct seq_file *m, void *ignored)
 {
 	seq_printf(m, "# %s\n", drbd_buildtag());
 	seq_printf(m, "VERSION=%s\n", REL_VERSION);
-	seq_printf(m, "API_VERSION=%u\n", API_VERSION);
+	seq_printf(m, "API_VERSION=%u\n", GENL_MAGIC_VERSION);
 	seq_printf(m, "PRO_VERSION_MIN=%u\n", PRO_VERSION_MIN);
 	seq_printf(m, "PRO_VERSION_MAX=%u\n", PRO_VERSION_MAX);
 	return 0;
diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
index 345bfac441da..5156d2fb2d76 100644
--- a/drivers/block/drbd/drbd_main.c
+++ b/drivers/block/drbd/drbd_main.c
@@ -2899,7 +2899,7 @@ static int __init drbd_init(void)
 
 	pr_info("initialized. "
 	       "Version: " REL_VERSION " (api:%d/proto:%d-%d)\n",
-	       API_VERSION, PRO_VERSION_MIN, PRO_VERSION_MAX);
+	       GENL_MAGIC_VERSION, PRO_VERSION_MIN, PRO_VERSION_MAX);
 	pr_info("%s\n", drbd_buildtag());
 	pr_info("registered as block device major %d\n", DRBD_MAJOR);
 	return 0; /* Success! */
diff --git a/drivers/block/drbd/drbd_proc.c b/drivers/block/drbd/drbd_proc.c
index 2227fb0db1ce..1d0feafceadc 100644
--- a/drivers/block/drbd/drbd_proc.c
+++ b/drivers/block/drbd/drbd_proc.c
@@ -228,7 +228,7 @@ int drbd_seq_show(struct seq_file *seq, void *v)
 	};
 
 	seq_printf(seq, "version: " REL_VERSION " (api:%d/proto:%d-%d)\n%s\n",
-		   API_VERSION, PRO_VERSION_MIN, PRO_VERSION_MAX, drbd_buildtag());
+		   GENL_MAGIC_VERSION, PRO_VERSION_MIN, PRO_VERSION_MAX, drbd_buildtag());
 
 	/*
 	  cs .. connection state
diff --git a/include/linux/drbd.h b/include/linux/drbd.h
index 5755537b51b1..df65a8f5228a 100644
--- a/include/linux/drbd.h
+++ b/include/linux/drbd.h
@@ -40,7 +40,6 @@
 
 extern const char *drbd_buildtag(void);
 #define REL_VERSION "8.4.11"
-#define API_VERSION 1
 #define PRO_VERSION_MIN 86
 #define PRO_VERSION_MAX 101
 
diff --git a/include/linux/drbd_genl_api.h b/include/linux/drbd_genl_api.h
index bd62efc29002..70682c058027 100644
--- a/include/linux/drbd_genl_api.h
+++ b/include/linux/drbd_genl_api.h
@@ -47,7 +47,7 @@ enum drbd_state_info_bcast_reason {
 #undef linux
 
 #include <linux/drbd.h>
-#define GENL_MAGIC_VERSION	API_VERSION
+#define GENL_MAGIC_VERSION	1
 #define GENL_MAGIC_FAMILY	drbd
 #define GENL_MAGIC_FAMILY_HDRSZ	sizeof(struct drbd_genlmsghdr)
 #define GENL_MAGIC_INCLUDE_FILE <linux/drbd_genl.h>
-- 
2.38.1

