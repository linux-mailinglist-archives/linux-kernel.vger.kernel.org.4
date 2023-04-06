Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 621056D9611
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 13:40:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238308AbjDFLkw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 07:40:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238996AbjDFLkQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 07:40:16 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FD0CB47A;
        Thu,  6 Apr 2023 04:36:32 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id g29so532751lfj.4;
        Thu, 06 Apr 2023 04:36:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680780934;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:dkim-signature
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hLe2BDpqjmup0y1LPiABk+LzHgKkTNIBWp76zDCcB+4=;
        b=GIcASHLvXk58zNoEndxSyPxeJSduISNiRK7lWnyq86ivFMxH/4PAdrQOyVXnK3unfq
         8tpWmJODQuW1eBuHeAF8JSlQXYfYI3LgIESyKi+U/lWEmv4RYoinzZKR5sdLoZoLzTCj
         GNxuiTQr6Ly+nldPAK6lVvA4ZVHx39c7+3I63uwU8A7mwyTfLlXTj2bv/lRjo7yDfadh
         P2Ki9a1ztaZyuPQIIPExrlHI5qLIbU5H5bdknMsMBmdEgxRYr6iFyNRK3ffKeYJbXR98
         sU3eJLUo4SqYB8A88j1iC87kKWEGbtZ+Ej3ceYTa/NqpWBXzqi5C3oHgodLUSCY65kZ6
         YR0w==
X-Gm-Message-State: AAQBX9eIj5BOwlWUwXzhvVANVB94xqYmqYBsUg39LO9iKGOMIRbspEMH
        5/3PJUgQKa451/SMmDVJewFDx/W2UbbVWw==
X-Google-Smtp-Source: AKy350ZsR7wQELdu0Yp2Ev9AYrRg0/aCfTlocFrwPkX/J8DrIIB5UP0w8paVzkWrOdzVODIGeX3vqQ==
X-Received: by 2002:ac2:48a1:0:b0:4eb:452d:5bbf with SMTP id u1-20020ac248a1000000b004eb452d5bbfmr2597917lfg.54.1680780934104;
        Thu, 06 Apr 2023 04:35:34 -0700 (PDT)
Received: from flawful.org (c-fcf6e255.011-101-6d6c6d3.bbcust.telenor.se. [85.226.246.252])
        by smtp.gmail.com with ESMTPSA id g13-20020ac2538d000000b004eb41d26d49sm229529lfh.28.2023.04.06.04.35.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 04:35:33 -0700 (PDT)
Received: by flawful.org (Postfix, from userid 112)
        id C2B7312A1; Thu,  6 Apr 2023 13:35:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=flawful.org; s=mail;
        t=1680780933; bh=preqedR2QZNTaOgvRKfmyWCCDHRysOKE6G/n/oQl2tk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QXZONJlZ0GfO6y8sPyaChIJtM6fJDKJskV+SLPl/UexUPKvDrpbjOZ/jqyelNv28s
         aAGIS5HV3hKHKkAmcQv/CKNvP2/24akemK/zi6nFBrKEvAFqv+MAnctGOgs7mbOWPL
         jzcm8vGGgCXy3//izsq53tmSyW8qDOTRJSepm55E=
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=0.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
Received: from x1-carbon.lan (OpenWrt.lan [192.168.1.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by flawful.org (Postfix) with ESMTPSA id 1EA9E69A;
        Thu,  6 Apr 2023 13:33:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=flawful.org; s=mail;
        t=1680780787; bh=preqedR2QZNTaOgvRKfmyWCCDHRysOKE6G/n/oQl2tk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YEsZ+/Af/WlbT+HSw0N1YcUN7htnpOH4BXhKpCf8EcuZ/lLc0NbhnVOt+ckzdFEzs
         6fY/gmaJfXrSiWMI9IfmIqrkmU9aUUtjiUncXShAn11iuqnC0vR0CeqHvfsLXW1jQI
         o/HTg47o4TdishwfA7oGwd0g98YzBEEiM1A/F5qE=
From:   Niklas Cassel <nks@flawful.org>
To:     Jens Axboe <axboe@kernel.dk>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-kernel@vger.kernel.org
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Damien Le Moal <dlemoal@fastmail.com>,
        linux-scsi@vger.kernel.org, linux-ide@vger.kernel.org,
        linux-block@vger.kernel.org, Niklas Cassel <niklas.cassel@wdc.com>
Subject: [PATCH v6 02/19] block: introduce ioprio hints
Date:   Thu,  6 Apr 2023 13:32:31 +0200
Message-Id: <20230406113252.41211-3-nks@flawful.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230406113252.41211-1-nks@flawful.org>
References: <20230406113252.41211-1-nks@flawful.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Damien Le Moal <damien.lemoal@opensource.wdc.com>

IO priorities currently only use 6-bits of the 16-bits ioprio value: the
3-upper bits are used to define up to 8 priority classes (4 of which are
valid) and the 3 lower bits of the value are used to define a priority
level for the real-time and best-effort class.

The remaining 10-bits between the IO priority class and level are
unused, and in fact, cannot be used by the user as doing so would
either result in the value being completely ignored, or in an error
returned by ioprio_check_cap().

Use these 10-bits of an ioprio value to allow a user to specify IO
hints. An IO hint is defined as a 10-bits value, allowing up to 1023
different hints to be specified, with the value 0 being reserved as the
"no hint" case. An IO hint can apply to any IO that specifies a valid
priority class other than NONE, regardless of the IO priority level
specified.

To do so, the macros IOPRIO_PRIO_HINT() and IOPRIO_PRIO_VALUE_HINT() are
introduced in include/uapi/linux/ioprio.h to respectively allow a user
to get and set a hint in an ioprio value.

To support the ATA and SCSI command duration limits feature, 7 hints
are defined: IOPRIO_HINT_DEV_DURATION_LIMIT_1 to
IOPRIO_HINT_DEV_DURATION_LIMIT_7, allowing a user to specify which
command duration limit descriptor should be applied to the commands
serving an IO. Specifying these hints has for now no effect whatsoever
if the target block devices do not support the command duration limits
feature. However, in the future, block IO schedulers can be modified to
optimize IO issuing order based on these hints, even for devices that
do not support the command duration limits feature.

Given that the 7 duration limits hints defined have no effect on any
block layer component, the actual definition of the duration limits
implied by these hints remains at the device level.

Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
 include/uapi/linux/ioprio.h | 49 +++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/include/uapi/linux/ioprio.h b/include/uapi/linux/ioprio.h
index 4444b4e4fdad..607c7617b9d2 100644
--- a/include/uapi/linux/ioprio.h
+++ b/include/uapi/linux/ioprio.h
@@ -58,4 +58,53 @@ enum {
 #define IOPRIO_NORM	4
 #define IOPRIO_BE_NORM	IOPRIO_NORM
 
+/*
+ * The 10-bits between the priority class and the priority level are used to
+ * optionally define IO hints for any combination of IO priority class and
+ * level. Depending on the kernel configuration, IO scheduler being used and
+ * the target IO device being used, hints can influence how IOs are processed
+ * without affecting the IO scheduling ordering defined by the IO priority
+ * class and level.
+ */
+#define IOPRIO_HINT_SHIFT		IOPRIO_LEVEL_NR_BITS
+#define IOPRIO_HINT_NR_BITS		10
+#define IOPRIO_NR_HINTS			(1 << IOPRIO_HINT_NR_BITS)
+#define IOPRIO_HINT_MASK		(IOPRIO_NR_HINTS - 1)
+#define IOPRIO_PRIO_HINT(ioprio)	\
+	(((ioprio) >> IOPRIO_HINT_SHIFT) & IOPRIO_HINT_MASK)
+
+/*
+ * Alternate macro for IOPRIO_PRIO_VALUE() to define an IO priority with
+ * a class, level and hint.
+ */
+#define IOPRIO_PRIO_VALUE_HINT(class, level, hint)		 \
+	((((class) & IOPRIO_CLASS_MASK) << IOPRIO_CLASS_SHIFT) | \
+	 (((hint) & IOPRIO_HINT_MASK) << IOPRIO_HINT_SHIFT) |	 \
+	 ((level) & IOPRIO_LEVEL_MASK))
+
+/*
+ * IO hints.
+ */
+enum {
+	/* No hint */
+	IOPRIO_HINT_NONE = 0,
+
+	/*
+	 * Device command duration limits: indicate to the device a desired
+	 * duration limit for the commands that will be used to process an IO.
+	 * These will currently only be effective for SCSI and ATA devices that
+	 * support the command duration limits feature. If this feature is
+	 * enabled, then the commands issued to the device to process an IO with
+	 * one of these hints set will have the duration limit index (dld field)
+	 * set to the value of the hint.
+	 */
+	IOPRIO_HINT_DEV_DURATION_LIMIT_1 = 1,
+	IOPRIO_HINT_DEV_DURATION_LIMIT_2 = 2,
+	IOPRIO_HINT_DEV_DURATION_LIMIT_3 = 3,
+	IOPRIO_HINT_DEV_DURATION_LIMIT_4 = 4,
+	IOPRIO_HINT_DEV_DURATION_LIMIT_5 = 5,
+	IOPRIO_HINT_DEV_DURATION_LIMIT_6 = 6,
+	IOPRIO_HINT_DEV_DURATION_LIMIT_7 = 7,
+};
+
 #endif /* _UAPI_LINUX_IOPRIO_H */
-- 
2.39.2

