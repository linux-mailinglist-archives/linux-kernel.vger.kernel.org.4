Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA2AF5BEE27
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 22:02:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231282AbiITUB6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 16:01:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231137AbiITUBp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 16:01:45 -0400
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5303452FD2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 13:01:44 -0700 (PDT)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-12b542cb1d3so5836899fac.13
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 13:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=lP9Jf81Swn6HKhzeqSgb5dx7kwZ1I6PvW+Qk6QnaJIM=;
        b=mn+XocFI9IgOzLf24JS8tHEgsTnBgE4LGh8VUQUZ/PdLXavL5/96BlY/5O437ZmoNj
         Ms1IbUvflE+mIMbwlxolfk8SsZg6frg4TgbF2e12wT+b8mQrgn+kBBPDMJr/2dv6D2JL
         Ey5Am5OPOuZdbFXYRCpk2h7eUd+ybr6y7vlyU8O0OdStNfKYfwC5lwXNBD3BgTYcFtkr
         lO0euV7UOctGTgyN1owGgZd9BFXLf1jfmEkOu0NDN274EcG/xaNfyNvWsQZSrxeY7fQ2
         AuK2sMuGetebvnRi1HkKdG8Il5brmy+sFp9WTJNzYoco9/knhBTMPQM4ojA5Hk7EQU4T
         7vAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=lP9Jf81Swn6HKhzeqSgb5dx7kwZ1I6PvW+Qk6QnaJIM=;
        b=J6J9WERCwNvAoLmoaZvDAr9cArkCFQ/rJy16aaVKz8KwIDqGAWoCEToRsJJify8Cku
         q2dBlavqpIBAhmhicE1Q/NNZVvuzI5MSskJOwz/aY4GZlVAn71IqGFpPBwI2WdGVkqyr
         doxt9oEHpFHqH73wZiWfbkJVZjoWG66YzGVkYgSPB1+catQ+6ZbGDYUyj28uJ5MdKYRL
         YlERfOWMUpkKkX2EOgjv7ZozdbdHdtJpIZ6AnIjrlzmjmVsVIoG9E8OaDUuOd94zUVat
         MPT6oQbSTY2W67fDHm+w1z1meFuSxBUtJTprSK2c4AMP9fWxeIbtvwiQYvrhrgI8LkiG
         Gqiw==
X-Gm-Message-State: ACrzQf2PcSDJurbbV+0YVY8h7ce8E98JPc3AUNq07I15Q/RYq+cIIKPO
        DnONJflsz3FndVbjAABEgD+FQg==
X-Google-Smtp-Source: AMsMyM6dx12VbH4+QCIEnfs+y56iuqMWJieydWsURcHHZvh8hsscCTrigL/e0w7CpvmWC06fgaRsLQ==
X-Received: by 2002:a05:6870:352:b0:10e:d4ee:a3f2 with SMTP id n18-20020a056870035200b0010ed4eea3f2mr3094146oaf.172.1663704103435;
        Tue, 20 Sep 2022 13:01:43 -0700 (PDT)
Received: from fedora.attlocal.net (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id bm43-20020a0568081aab00b0034d14c6ce3dsm325634oib.16.2022.09.20.13.01.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Sep 2022 13:01:43 -0700 (PDT)
From:   William Breathitt Gray <william.gray@linaro.org>
To:     linux-iio@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, mranostay@ti.com,
        jpanis@baylibre.com, gwendal@chromium.org, bleung@chromium.org,
        groeck@chromium.org, jic23@kernel.org, david@lechnology.com,
        robertcnelson@gmail.com,
        William Breathitt Gray <william.gray@linaro.org>
Subject: [PATCH v5 3/5] counter: Introduce the Count capture component
Date:   Tue, 20 Sep 2022 13:21:27 -0400
Message-Id: <ff4fac409706a57f601188afbd9a08fc0af42a26.1663693757.git.william.gray@linaro.org>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1663693757.git.william.gray@linaro.org>
References: <cover.1663693757.git.william.gray@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some devices provide a latch function to save historic Count values.
This patch standardizes exposure of such functionality as Count capture
components. A COUNTER_COMP_CAPTURE macro is provided for driver authors
to define a capture component. A new event COUNTER_EVENT_CAPTURE is
introduced to represent Count value capture events.

Cc: Julien Panis <jpanis@baylibre.com>
Signed-off-by: William Breathitt Gray <william.gray@linaro.org>
---
 Documentation/ABI/testing/sysfs-bus-counter | 6 ++++++
 include/linux/counter.h                     | 3 +++
 include/uapi/linux/counter.h                | 2 ++
 3 files changed, 11 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-counter b/Documentation/ABI/testing/sysfs-bus-counter
index a234022f9add..30b6e1faa6f6 100644
--- a/Documentation/ABI/testing/sysfs-bus-counter
+++ b/Documentation/ABI/testing/sysfs-bus-counter
@@ -4,6 +4,12 @@ Contact:	linux-iio@vger.kernel.org
 Description:
 		Count data of Count Y represented as a string.
 
+What:		/sys/bus/counter/devices/counterX/countY/capture
+KernelVersion:	6.1
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Historical capture of the Count Y count data.
+
 What:		/sys/bus/counter/devices/counterX/countY/ceiling
 KernelVersion:	5.2
 Contact:	linux-iio@vger.kernel.org
diff --git a/include/linux/counter.h b/include/linux/counter.h
index 60428d06915d..2c6594c240d4 100644
--- a/include/linux/counter.h
+++ b/include/linux/counter.h
@@ -453,6 +453,9 @@ struct counter_available {
 	.priv = &(_available), \
 }
 
+#define COUNTER_COMP_CAPTURE(_read, _write) \
+	COUNTER_COMP_COUNT_U64("capture", _read, _write)
+
 #define COUNTER_COMP_CEILING(_read, _write) \
 	COUNTER_COMP_COUNT_U64("ceiling", _read, _write)
 
diff --git a/include/uapi/linux/counter.h b/include/uapi/linux/counter.h
index e9610e1944dc..8ab12d731e3b 100644
--- a/include/uapi/linux/counter.h
+++ b/include/uapi/linux/counter.h
@@ -63,6 +63,8 @@ enum counter_event_type {
 	COUNTER_EVENT_INDEX,
 	/* State of counter is changed */
 	COUNTER_EVENT_CHANGE_OF_STATE,
+	/* Count value captured */
+	COUNTER_EVENT_CAPTURE,
 };
 
 /**
-- 
2.37.3

