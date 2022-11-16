Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9E4C62BD34
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 13:09:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233846AbiKPMJ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 07:09:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbiKPMIF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 07:08:05 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AFB6A3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 04:01:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668600074;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qXpS5ogY+quOVBSqhFr3jD7fUFESPhWtnRgSpqA/kiQ=;
        b=CQGDJjRxtH3VgVhznwqsBhGuMANrybOgdJX4e7yc28wZPW3Gjet7o+EdeUGPG2HVs2jD71
        mVJTDNHJI6SJoJtgLJ7rWZ4hgAerv7D73YkJGXma/t+x+CdUtIvkXvCY7U4LNf+ltrB9ue
        EmbpMoq/HJJcWhAlj5npcOJ2trKZx5Y=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-321-tDjxHqfVMVWS_e0R1uoHMQ-1; Wed, 16 Nov 2022 07:01:07 -0500
X-MC-Unique: tDjxHqfVMVWS_e0R1uoHMQ-1
Received: by mail-wm1-f69.google.com with SMTP id x10-20020a05600c420a00b003cfa33f2e7cso9895431wmh.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 04:01:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qXpS5ogY+quOVBSqhFr3jD7fUFESPhWtnRgSpqA/kiQ=;
        b=fHxxx4+2r8T7mKQuov9MbQwdHvwMgTJCy6po91dRsUfpWhXiUBh4S0S1iU4aD0tnqR
         IkMPcL8mO2U193S+8GKFG5LTSqc7C4qC8iOIfy0IyM2rJUF3YF7oKHgK0dnf6IOl5ylN
         cUJka2kymer2jTTVMipQU1BpNOmTtipA+tzF0Mrub2lYedEOT5Dj24JAsR9H7/x646zh
         wfNZDScEnAilJ+c/CtucRH8GGkbZ8bfzWvRqwDtneoVfpJmGlMYx6QKq8RC/gU91vD9v
         xX7hYvMzEKSeAR3pEYoUoctcZ0O5piYG0U/Y6fjXObB0zvqOK2JjVgxg5VGaxYr44rc2
         /eAg==
X-Gm-Message-State: ANoB5pmxnVhoOu4cplZZghMlwvWtHuKldcAopq5v2nBy7E140iC0hy4s
        hWEW+FYw43fR5/jKUAkDfhqCy4sKwxENWdlavTfuYbl+Hgoa5J6RbnEisi1w4Ww65Ybw6HzhkB7
        +ZmiQ/O0gRlk+URJlAbcTfJrjblGrvk0pXkj/T9AB17tMCnS99ifb0HrbD/iWOD4eRECxo/Ex4A
        k=
X-Received: by 2002:a5d:6752:0:b0:236:73b2:f026 with SMTP id l18-20020a5d6752000000b0023673b2f026mr13799536wrw.396.1668600066375;
        Wed, 16 Nov 2022 04:01:06 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4JOT6/zsQCPAo4bnANXkeD6+Wah+l7xo5KbcAGf+Aw9JQb7E9QHfplxlEHsyJcBBgtA/Vxqg==
X-Received: by 2002:a5d:6752:0:b0:236:73b2:f026 with SMTP id l18-20020a5d6752000000b0023673b2f026mr13799498wrw.396.1668600066055;
        Wed, 16 Nov 2022 04:01:06 -0800 (PST)
Received: from minerva.home (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id by7-20020a056000098700b002368a6deaf8sm15112370wrb.57.2022.11.16.04.01.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 04:01:05 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        Saravana Kannan <saravanak@google.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        linux-arm-msm@vger.kernel.org, John Stultz <jstultz@google.com>,
        Peter Robinson <pbrobinson@redhat.com>,
        Steev Klimaszewski <steev@kali.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Enric Balletbo i Serra <eballetbo@redhat.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Brian Masney <bmasney@redhat.com>,
        Rob Herring <robh@kernel.org>,
        Javier Martinez Canillas <javierm@redhat.com>
Subject: [PATCH v2 2/4] driver core: Set deferred probe timeout to 0 if modules are disabled
Date:   Wed, 16 Nov 2022 13:00:43 +0100
Message-Id: <20221116120043.519614-1-javierm@redhat.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221116115348.517599-1-javierm@redhat.com>
References: <20221116115348.517599-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no point to schedule the work queue to timeout the deferred probe
if all the initcalls are done and modules are not enabled. The default for
this case is already 0 but can be overridden by the deferred_probe_timeout
parameter. Let's just disable to avoid queuing a work that is not needed.

Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

(no changes since v1)

 drivers/base/dd.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index 040b4060f903..1e8f1afeac98 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -350,8 +350,10 @@ static int deferred_probe_initcall(void)
 	flush_work(&deferred_probe_work);
 	initcalls_done = true;
 
-	if (!IS_ENABLED(CONFIG_MODULES))
+	if (!IS_ENABLED(CONFIG_MODULES)) {
+		driver_deferred_probe_timeout = 0;
 		fw_devlink_drivers_done();
+	}
 
 	/*
 	 * Trigger deferred probe again, this time we won't defer anything
-- 
2.38.1

