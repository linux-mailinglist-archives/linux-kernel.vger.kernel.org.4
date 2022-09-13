Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E8CB5B7CED
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 00:16:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbiIMWQE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 18:16:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiIMWPm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 18:15:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18FCF74B9A
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 15:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663107331;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IDL/AgTFWdm+PP/N7/EovNn2CFq5LCV9poLaDqClvoQ=;
        b=Swq9zW3+kK8ekgJu/MuuNmv5Q4R5+9954dWssFTghwnBOeHzeguj6I7+8L6OmPFqaoRCR9
        MznQ1xkbnx6rWouEyKhPJmZ3YomvlD1uNk+gsEenP2cGqX7SrQlFHyrTFcmNLMlUg3//zV
        OefhiML68Lkz+P+qeno5rJXcgKzer44=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-241-LdyeGKxnNkyn9SuCEOOmkA-1; Tue, 13 Sep 2022 18:15:22 -0400
X-MC-Unique: LdyeGKxnNkyn9SuCEOOmkA-1
Received: by mail-ej1-f71.google.com with SMTP id sc31-20020a1709078a1f00b0077ef3eec7d7so2917788ejc.16
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 15:15:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=IDL/AgTFWdm+PP/N7/EovNn2CFq5LCV9poLaDqClvoQ=;
        b=e+MhXtDacNG9l8/pTNoPruSw2rKbn6HgzbIKACm+pv4rsk/5sxgOMzNrwk+052ugb1
         BXJ5yD3BJ6c5+kJEyd5j+qwMkD7dLXTPiTNZLHx4Jgedx3QQE8plTDQ4qV2pl6QJW6ZG
         JbhRLzrhs0BeeGSou6Ojh5INeOLLp7P1H43xkAQPRXPzjtYf8j8iDwdeDESOaObv0pty
         +bcu/rsP+JM1h3uYOhC4W9pYNPTq8iEb4jsjPfmxmUvgbIK5bHTzF6mEaEneVY9sQmg4
         LLYG+nuXKwyAzS4lnv77gDyE69WvUY8MnfeOJ2Tqj6KcdGWWCEjrVWL9TpP/nBXw1jgM
         LkXQ==
X-Gm-Message-State: ACgBeo0f2FysTvIDofGNk1Y35PzKlAwXxGpe+nHi/7QIHA1WIUq6WABb
        zST7S24TNCydguQ5sHwMzcWdbWLvQPp1sGqhHv0FOQgfkNZTJWUSu6UbRRgPlTPQcOowLc1Gfdr
        HuVtlgjiczw5N0fxIlS+7oZM7
X-Received: by 2002:a17:907:b0e:b0:77a:d97d:9afc with SMTP id h14-20020a1709070b0e00b0077ad97d9afcmr12925513ejl.199.1663107321098;
        Tue, 13 Sep 2022 15:15:21 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4JrvdPCBd450Ne/WjVuyF2pyNqC+OiG8iXf5IJ2s1pVhR/kJe8SiZhf2Ce+d/6Pv1DDaJDow==
X-Received: by 2002:a17:907:b0e:b0:77a:d97d:9afc with SMTP id h14-20020a1709070b0e00b0077ad97d9afcmr12925509ejl.199.1663107320962;
        Tue, 13 Sep 2022 15:15:20 -0700 (PDT)
Received: from pollux.redhat.com ([2a02:810d:4b40:2ee8:642:1aff:fe31:a15c])
        by smtp.gmail.com with ESMTPSA id g17-20020a170906c19100b0073dbc35a0desm6628493ejz.100.2022.09.13.15.15.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Sep 2022 15:15:20 -0700 (PDT)
From:   Danilo Krummrich <dakr@redhat.com>
To:     daniel@ffwll.ch, airlied@linux.ie, tzimmermann@suse.de,
        mripard@kernel.org, liviu.dudau@arm.com, brian.starkey@arm.com
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Danilo Krummrich <dakr@redhat.com>
Subject: [PATCH drm-misc-next v2 6/6] drm/arm/hdlcd: debugfs: protect device resources after removal
Date:   Wed, 14 Sep 2022 00:14:56 +0200
Message-Id: <20220913221456.147937-7-dakr@redhat.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220913221456.147937-1-dakr@redhat.com>
References: <20220913221456.147937-1-dakr@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(Hardware) resources which are bound to the driver and device lifecycle
must not be accessed after the device and driver are unbound.

However, the DRM device isn't freed as long as the last user didn't
close it, hence userspace can still call into the driver.

Therefore protect the critical sections which are accessing those
resources with drm_dev_enter() and drm_dev_exit().

Signed-off-by: Danilo Krummrich <dakr@redhat.com>
---
 drivers/gpu/drm/arm/hdlcd_drv.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/arm/hdlcd_drv.c b/drivers/gpu/drm/arm/hdlcd_drv.c
index e41def6d47cc..020c7d0c70a5 100644
--- a/drivers/gpu/drm/arm/hdlcd_drv.c
+++ b/drivers/gpu/drm/arm/hdlcd_drv.c
@@ -204,11 +204,19 @@ static int hdlcd_show_pxlclock(struct seq_file *m, void *arg)
 	struct drm_info_node *node = (struct drm_info_node *)m->private;
 	struct drm_device *drm = node->minor->dev;
 	struct hdlcd_drm_private *hdlcd = drm_to_hdlcd_priv(drm);
-	unsigned long clkrate = clk_get_rate(hdlcd->clk);
-	unsigned long mode_clock = hdlcd->crtc.mode.crtc_clock * 1000;
+	unsigned long clkrate, mode_clock;
+	int idx;
+
+	if (!drm_dev_enter(drm, &idx))
+		return -ENODEV;
+
+	clkrate = clk_get_rate(hdlcd->clk);
+	mode_clock = hdlcd->crtc.mode.crtc_clock * 1000;
 
 	seq_printf(m, "hw  : %lu\n", clkrate);
 	seq_printf(m, "mode: %lu\n", mode_clock);
+
+	drm_dev_exit(idx);
 	return 0;
 }
 
-- 
2.37.3

