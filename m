Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCF915B353D
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 12:31:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230487AbiIIK2Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 06:28:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbiIIK2G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 06:28:06 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55F9712F225
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 03:28:05 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id o2-20020a17090a9f8200b0020025a22208so4932041pjp.2
        for <linux-kernel@vger.kernel.org>; Fri, 09 Sep 2022 03:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ecs-corp-partner-google-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=A2mUQ7fRFvl4uncpd865iji4uF5goEpWJoSgQh7OGzs=;
        b=wnY6Ju26Lduyy3BBxnOibYoABYQp14RiI/A6EelKgXJBluGpYMufyYgKVPhByOdgJm
         kalR7E1gMTCYua2iNwMqB3xxF3VIL/uqJNjJu6fUEkOOLKTW0c+dMsNAKQ/QgpItcivh
         xoqFs44Hidtxc2XnsOMJiH6oEmVf/T2msU8LlUWkq1Chi8bmhIdJlaA5Xu+n0CKwYs/l
         LAgU9KOO8Nk9ZbKgn9CeKro5T7bv8OLL3f3XfFyANRxW6NoBw+QEdQH2Tr8cVgvso5n2
         Szwo+4CjibfG4jAT66Uph8C9itXGeUukRA7kuH3UM82Q3YoXErthZZx5zpNWI4mJ/3fS
         8l0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=A2mUQ7fRFvl4uncpd865iji4uF5goEpWJoSgQh7OGzs=;
        b=cNXSXj4XYKW7peevsBrIFL4JqynV8QcF8svB3CKZGXcFQqck6p12J2QBfnrCFZrSOs
         cCH9sqYtXTiJZdfbS467rOSH3HVvqOaGNZp3zAD0ezHM6h1PfwmMI7Ma5zTWN4JiNj6m
         RGZbrQavR1fS3XjtwPAzH+vCm2vqdFek1APM6zOmK3Nx3WchdFZPUi2al6O8iBwGFy3B
         dXwp+PFB1S/7WqYOqlags2XV4qBa9EMzYNPRiNOlGk1UPrmowQ0H0VWTF5p50sqkzyB/
         72YPBrAsZHZ56TGyUU8+ShTD7P++JywWFfrY+XysSUWfPdxb89ApioBQYT2JD7mC9bi0
         C/HA==
X-Gm-Message-State: ACgBeo3Rgwuwgi2lrKibU6MDt4fX0UaPjRRfsHA/Fimi+xXWFDHfpl+g
        gNf5HKPbB9lxf6fmC3NsBs6IHgN1aWcSBdt5
X-Google-Smtp-Source: AA6agR71IB5DpQABFJR4ATzXtpHnNkODpV6uYlIX33pXUwuCzJlt/xXeNA8s3hfTmvBUxpDl+ont4g==
X-Received: by 2002:a17:902:e2d3:b0:176:e97a:d3eb with SMTP id l19-20020a170902e2d300b00176e97ad3ebmr12072323plc.172.1662719284553;
        Fri, 09 Sep 2022 03:28:04 -0700 (PDT)
Received: from localhost.localdomain ([103.150.184.130])
        by smtp.gmail.com with ESMTPSA id c12-20020a170902d48c00b0016bb24f5d19sm121476plg.209.2022.09.09.03.28.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Sep 2022 03:28:03 -0700 (PDT)
From:   Yunlong Jia <yunlong.jia@ecs.corp-partner.google.com>
X-Google-Original-From: Yunlong Jia <yunlong.jia@ecs.com.tw>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Henry Sun <henrysun@google.com>,
        Douglas Anderson <dianders@chromium.org>,
        Bob Moragues <moragues@chromium.org>,
        Yunlong Jia <yunlong.jia@ecs.com.tw>,
        David Heidelberg <david@ixit.cz>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-input@vger.kernel.org
Subject: [PATCH v3 1/2] dt-bindings: input: touchscreen: elants_i2c: Add eth3915n touchscreen chip
Date:   Fri,  9 Sep 2022 10:27:54 +0000
Message-Id: <20220909102720.v3.1.Ib599a6001558a4afd11016e7016d74dce748a749@changeid>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an elan touch screen chip eth3915n.
This chip requires more delay time than the eth3500.

Signed-off-by: Yunlong Jia <yunlong.jia@ecs.com.tw>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Acked-by: David Heidelberg <david@ixit.cz>
---

(no changes since v1)

 .../devicetree/bindings/input/touchscreen/elan,elants_i2c.yaml   | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/elan,elants_i2c.yaml b/Documentation/devicetree/bindings/input/touchscreen/elan,elants_i2c.yaml
index a9b53c2e6f0ab..d28625372f5ac 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/elan,elants_i2c.yaml
+++ b/Documentation/devicetree/bindings/input/touchscreen/elan,elants_i2c.yaml
@@ -17,6 +17,7 @@ properties:
     enum:
       - elan,ektf3624
       - elan,ekth3500
+      - elan,ekth3915
 
   reg:
     maxItems: 1
-- 
2.17.1

