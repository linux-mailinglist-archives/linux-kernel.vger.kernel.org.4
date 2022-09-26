Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 863F95EB011
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 20:37:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbiIZSho (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 14:37:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229893AbiIZShl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 14:37:41 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C440D659C4
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 11:37:40 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id z13-20020a7bc7cd000000b003b5054c6f9bso7529264wmk.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 11:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date;
        bh=YWy5dAY8OXlfZakbmyL3MvfrEAJ3U12lMsLHLwd72I4=;
        b=ENjZRdx60Y14KVIfgiPpREzXHjTXmOeJhqMOPGD2GzO7iXZ70LsyxiMMOkiRnU+BDb
         9VzlSqYZqmP++9MRjWoeInjXa7y5p9M3A0uL1hp/B22vwV3JKII4zSCr6Vg+vCY1MBi+
         rJmOLHswgfen5auuQIFJ8Vncn8nwcBjqcFLNvMRcTs8vCJu2AD90OAgc1N3TbiW5HrFQ
         VPvUugRXQKewQQtBeLABfuHWY26EKFP9i9vYx9FmlbcJEUdUjxyRGUAE1nBJzGUGL+WK
         E2x5DhybML/zlPvG+st790WcOPte9+6/TbuqlNimV1328g29AJAMKpRZSdKQJyKPj1J7
         ogzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=YWy5dAY8OXlfZakbmyL3MvfrEAJ3U12lMsLHLwd72I4=;
        b=J3qKWFDN3+VoSevwt37iZrL9IBixG5MeYY9HjzzbndgFGt3z60fosypVmg0f8FObFt
         f9uGmoaUmpZNdlZzQakWHtAVX7bdSLlYrwMAueGzZJm4rRmsbF3hSOJ1t/89eDI1wEQs
         qk/PD25uDGf+a/7weVYiRdpLtp0tD2Oj/E/Pk58yfrL5/JLC6OMMI+lUvloU9Zti0RqR
         63PPUYpsfGnVTH5yeNyKxpv0Qc/scO4sn/GCh6D8cp2OtNTI5FwwxJhNHQ1QQ64CWQvP
         JNZK0XWHZxj89CxvV2hetWsUn4jwX32dYhF7evgKPnG9Es5OCf90GWCEaGg1ulekH/B7
         BNMQ==
X-Gm-Message-State: ACrzQf38d9HTlIgw478/+dAIZCGTPFJ0Zv7CM7NUPbeb8bWla/72Qn4j
        nqiz8avMZcWEqMnLIjqYUQ==
X-Google-Smtp-Source: AMsMyM4AME0ty4MV+aveoi30huVXgOGjJN6j4jDxIwffq1UaNOJSIFITYbzkDQvqMrqM+RdJSdOx5Q==
X-Received: by 2002:a05:600c:3511:b0:3b4:bb85:f1e3 with SMTP id h17-20020a05600c351100b003b4bb85f1e3mr86616wmq.0.1664217459201;
        Mon, 26 Sep 2022 11:37:39 -0700 (PDT)
Received: from fedora (88-106-97-87.dynamic.dsl.as9105.com. [88.106.97.87])
        by smtp.gmail.com with ESMTPSA id m10-20020a05600c3b0a00b003b47b913901sm26341385wms.1.2022.09.26.11.37.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 11:37:38 -0700 (PDT)
Date:   Mon, 26 Sep 2022 19:37:37 +0100
From:   Jules Irenge <jbi.octave@gmail.com>
To:     abbotti@mev.co.uk
Cc:     hsweeten@visionengravers.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, abbotti@mev.co.uk
Subject: [PATCH 1/7] comedi: Convert snprintf() to scnprintf()
Message-ID: <YzHxcb5VzWeSNKo0@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Coccinnelle reports a warning
Warning: Use scnprintf or sprintf
Adding to that, there has been a slow migration from snprintf to scnprintf.
This LWN article explains the rationale for this change
https: //lwn.net/Articles/69419/
Ie. snprintf() returns what *would* be the resulting length,
while scnprintf() returns the actual length.

Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
---
 drivers/comedi/comedi_fops.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/comedi/comedi_fops.c b/drivers/comedi/comedi_fops.c
index 55a0cae04b8d..e8a0142d5894 100644
--- a/drivers/comedi/comedi_fops.c
+++ b/drivers/comedi/comedi_fops.c
@@ -396,7 +396,7 @@ static ssize_t max_read_buffer_kb_show(struct device *csdev,
 	mutex_unlock(&dev->mutex);
 
 	comedi_dev_put(dev);
-	return snprintf(buf, PAGE_SIZE, "%u\n", size);
+	return scnprintf(buf, PAGE_SIZE, "%u\n", size);
 }
 
 static ssize_t max_read_buffer_kb_store(struct device *csdev,
@@ -452,7 +452,7 @@ static ssize_t read_buffer_kb_show(struct device *csdev,
 	mutex_unlock(&dev->mutex);
 
 	comedi_dev_put(dev);
-	return snprintf(buf, PAGE_SIZE, "%u\n", size);
+	return scnprintf(buf, PAGE_SIZE, "%u\n", size);
 }
 
 static ssize_t read_buffer_kb_store(struct device *csdev,
@@ -509,7 +509,7 @@ static ssize_t max_write_buffer_kb_show(struct device *csdev,
 	mutex_unlock(&dev->mutex);
 
 	comedi_dev_put(dev);
-	return snprintf(buf, PAGE_SIZE, "%u\n", size);
+	return scnprintf(buf, PAGE_SIZE, "%u\n", size);
 }
 
 static ssize_t max_write_buffer_kb_store(struct device *csdev,
@@ -565,7 +565,7 @@ static ssize_t write_buffer_kb_show(struct device *csdev,
 	mutex_unlock(&dev->mutex);
 
 	comedi_dev_put(dev);
-	return snprintf(buf, PAGE_SIZE, "%u\n", size);
+	return scnprintf(buf, PAGE_SIZE, "%u\n", size);
 }
 
 static ssize_t write_buffer_kb_store(struct device *csdev,
-- 
2.37.3

