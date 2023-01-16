Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE8AA66BE32
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 13:51:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231205AbjAPMvS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 07:51:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231178AbjAPMuc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 07:50:32 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77C8C1F4A2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 04:49:51 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id k22-20020a05600c1c9600b003d1ee3a6289so22062840wms.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 04:49:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=x4Z+LutHe+zV9AhuohA6QC+0IyQu4tvHPiEekexhZpY=;
        b=xFbDH611S+uXOxluSvEMmyeWywhyca/UcW9miGnIrrUJBTtE9xqTg7taTQmppPLUu6
         dI7JNfViDlfi9Iy/NVjHFOLX4hzI2XKn7q7M33dblsRowq/WhC2Q+88JsHWaCItqgz7u
         6ZzLAtASQaaJNFoRIsSLJQ2wvzHfV1fu0/zmmnV4NevTBd0YhEo5UUkNwQGEB6IF3mX9
         KzvJXWtu/7jSxH08BipOtnxZ5CKyR2YVddhfSEEDjKtR58S6PILCWZgRDebviY+cVEI6
         kNpF0RutVhWooXfsWOr/46JCpVLzPWVIbLug1nHNuwqOzSP8zsL94Bkzt0HCQXPb+1tF
         /uAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x4Z+LutHe+zV9AhuohA6QC+0IyQu4tvHPiEekexhZpY=;
        b=J/tMzImvXAfvZd7t0mN3t1roYM/ORMj+N9QIDnCRXuKbN2nd6XXU2ca5TpaMCoOaD6
         mrnO2hgRKXc6nk4gx4w3SsdPiRS5jgnTj5rzxjcilhFBRPoO+pTK+v4tVOMVR5U1RMLo
         mOMDVyvDXmznD9SZ7THu4lBOBzHdoUK+SDrydDxhps3UHMYitlaMnuWTSpL4SsB1HT37
         fJMVxdsV+jLe3RTORo8VQp+zpIEySO+9Tn8gWIEAbfrLk9NUu5kH8EWpcxvUy8Stmmyd
         lvnwkeFI7Bc3PBb7oT7AmYIovhSuqbqYhP5T8YCe0jhx54MSKBa8b+9J5VPnsqP4KCpW
         YL9w==
X-Gm-Message-State: AFqh2kpnSuBHNXu08LSMOjDUWRvbEop/bInfeDAwR2kxNDpvAr9IXz7Q
        vS+qF/50gm9v8660LihIZnKOtA==
X-Google-Smtp-Source: AMrXdXsEc/URZzYzsLh9QPOwNDQJr3pcJWQQ9XSC1WRRwATgPDKVjGuvBKvsvIIpQMhLTW51JmS6OQ==
X-Received: by 2002:a05:600c:328a:b0:3da:fac4:7da3 with SMTP id t10-20020a05600c328a00b003dafac47da3mr3558156wmp.36.1673873391094;
        Mon, 16 Jan 2023 04:49:51 -0800 (PST)
Received: from linaro.org ([2a00:23c5:6809:2201:6c91:710d:9433:e868])
        by smtp.gmail.com with ESMTPSA id fl12-20020a05600c0b8c00b003dab40f9eafsm6896832wmb.35.2023.01.16.04.49.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jan 2023 04:49:50 -0800 (PST)
From:   Mike Leach <mike.leach@linaro.org>
To:     coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     mathieu.poirier@linaro.org, suzuki.poulose@arm.com,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        linux-perf-users@vger.kernel.org, leo.yan@linaro.org,
        quic_jinlmao@quicinc.com, Mike Leach <mike.leach@linaro.org>
Subject: [PATCH v7 15/15] coresight: etm3x: docs: Alter sysfs documentation for trace id updates
Date:   Mon, 16 Jan 2023 12:49:28 +0000
Message-Id: <20230116124928.5440-16-mike.leach@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230116124928.5440-1-mike.leach@linaro.org>
References: <20230116124928.5440-1-mike.leach@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sysfs access to etm3x trace ID value is now read-only due to recent
trace updates and for consistency with etm4x.

Signed-off-by: Mike Leach <mike.leach@linaro.org>
---
 Documentation/ABI/testing/sysfs-bus-coresight-devices-etm3x | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-coresight-devices-etm3x b/Documentation/ABI/testing/sysfs-bus-coresight-devices-etm3x
index 651602a61eac..234c33fbdb55 100644
--- a/Documentation/ABI/testing/sysfs-bus-coresight-devices-etm3x
+++ b/Documentation/ABI/testing/sysfs-bus-coresight-devices-etm3x
@@ -236,7 +236,7 @@ What:		/sys/bus/coresight/devices/<memory_map>.[etm|ptm]/traceid
 Date:		November 2014
 KernelVersion:	3.19
 Contact:	Mathieu Poirier <mathieu.poirier@linaro.org>
-Description: 	(RW) Holds the trace ID that will appear in the trace stream
+Description: 	(RO) Holds the trace ID that will appear in the trace stream
 		coming from this trace entity.
 
 What:		/sys/bus/coresight/devices/<memory_map>.[etm|ptm]/trigger_event
-- 
2.17.1

