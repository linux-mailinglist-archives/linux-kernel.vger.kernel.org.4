Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A975627ADD
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 11:44:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236211AbiKNKox (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 05:44:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236389AbiKNKon (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 05:44:43 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B3AEB8C
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 02:43:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668422622;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=KhGrKqZABfxXgxhvFZS6ZgjvLKrUckNIrRZXNfiIo74=;
        b=Lwg52Q+dxsZyoqmnYMkSKPaSzZXdYEUWr1GsF56/awJL/KrKNEKHFDqeuzE9nGLGv1vgic
        SNbKEPKqB+FyMQfm5wOckIqQvbYVl+i6XhSdcgGFjLb2uA1aqlWywvV3P9E2H3iUH4YmHj
        XWteV3T0Kx0eqCv8m1Q/ucoYAjR0/1w=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-605-D4HNFdWJNOOMQkJcVfxOpw-1; Mon, 14 Nov 2022 05:43:41 -0500
X-MC-Unique: D4HNFdWJNOOMQkJcVfxOpw-1
Received: by mail-wm1-f72.google.com with SMTP id bg25-20020a05600c3c9900b003cf3ed7e27bso6580695wmb.4
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 02:43:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KhGrKqZABfxXgxhvFZS6ZgjvLKrUckNIrRZXNfiIo74=;
        b=0fNDPg9TrSe6upxhxpY6pTU7kDo07jnZXgh6bi3NxsuBV4TrzkqvfU7dklZCRPEYI+
         mI/gj2gEVlNGinuTqRZNH9VQ/kRJWIDQSQMSRfotl3YlzpEd9IagDhV5PlA1xh89YwMn
         /EPX18QpvFyCPPnKkq3doS8O8qVjgwaeCDcx0qiQvyhtpqM5OgAbhrAXa2yHkfl+Ugb2
         /Egk7HsuShr6aGpJByhSwE3tI3/7M3U8VswJIwywZMDmJK7I0Bvr4iZ7qbL70paSAr0R
         r/KTEP+bZ1xU5xADRzx/Y5mvxOHrNjnbYj2nR3JqM5jwhmc+M233IJh9zyG25qgu74j8
         NWYQ==
X-Gm-Message-State: ANoB5plheBhF2KnGm6MHFFHkpYwYejuMU3FwzATi6SlBS4d1ez/JFRQU
        UgnTXSRWzSJ3Utdc0X6+USLIuEY9mpG/lqeNl13bojP5Eaov2lyiH/FObr0CEykkeNhhzghoONZ
        LG/pXZ0n+o1la56lse8ynz4SqYZzkrQPb9OH2Wk9qJPwFrSzx/ZBQbSlQdZSvFWkBkYQD3B14Tf
        M=
X-Received: by 2002:a05:600c:3c93:b0:3cf:cfcd:1e0 with SMTP id bg19-20020a05600c3c9300b003cfcfcd01e0mr7551215wmb.166.1668422618433;
        Mon, 14 Nov 2022 02:43:38 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4LTTfRgk2hIRvMGXUFWJY0WRKIO0NZxyor0pdMsOQonaFaUu/i8GL+jAbQiu7NJaJs3Mqc7Q==
X-Received: by 2002:a05:600c:3c93:b0:3cf:cfcd:1e0 with SMTP id bg19-20020a05600c3c9300b003cfcfcd01e0mr7551187wmb.166.1668422618089;
        Mon, 14 Nov 2022 02:43:38 -0800 (PST)
Received: from minerva.home (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id n18-20020a7bcbd2000000b003cf9bf5208esm17225468wmi.19.2022.11.14.02.43.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 02:43:37 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Saravana Kannan <saravanak@google.com>,
        Peter Robinson <pbrobinson@redhat.com>,
        Steev Klimaszewski <steev@kali.org>,
        Rob Herring <robh@kernel.org>,
        Sergio Lopez Pascual <slp@redhat.com>,
        Enric Balletbo i Serra <eballetbo@redhat.com>,
        John Stultz <jstultz@google.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH] driver core: Disable driver deferred probe timeout by default
Date:   Mon, 14 Nov 2022 11:43:33 +0100
Message-Id: <20221114104333.3695531-1-javierm@redhat.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver_deferred_probe_timeout value has a long story. It was first set
to -1 when it was introduced by commit 25b4e70dcce9 ("driver core: allow
stopping deferred probe after init"), meaning that the driver core would
defer the probe forever unless a subsystem would opt-in by checking if the
initcalls where done using the driver_deferred_probe_check_state() helper,
or if a timeout was explicitly set with a "deferred_probe_timeout" param.

Only the power domain, IOMMU and MDIO subsystems currently opt-in to check
if the initcalls have completed with driver_deferred_probe_check_state().

Commit c8c43cee29f6 ("driver core: Fix driver_deferred_probe_check_state()
logic") then changed the driver_deferred_probe_check_state() helper logic,
to take into account whether modules have been enabled or not and also to
return -EPROBE_DEFER if the probe deferred timeout was still running.

Then in commit e2cec7d68537 ("driver core: Set deferred_probe_timeout to a
longer default if CONFIG_MODULES is set"), the timeout was increased to 30
seconds if modules are enabled. Because seems that some of the subsystems
that were opt-in to not return -EPROBE_DEFER after the initcall where done
could still have dependencies whose drivers were built as a module.

This commit did a fundamental change to how probe deferral worked though,
since now the default was not to attempt probing for drivers indefinitely
but instead it would timeout after 30 seconds unless a different timeout
was set using the "deferred_probe_timeout" parameter.

The behavior was changed even mere with commit ce68929f07de ("driver core:
Revert default driver_deferred_probe_timeout value to 0"), since the value
was set to 0 by default. Meaning that the probe deferral would be disabled
after the initcalls where done. Unless a timeout was set in the cmdline.

Notice that the commit said that it was reverting the default value to 0,
but this was never 0. The default was -1 at the beginning and then changed
to 30 in a later commit.

This default value of 0 was reverted again by commit f516d01b9df2 ("Revert
"driver core: Set default deferred_probe_timeout back to 0."") and set to
10 seconds instead. Which was still less than the 30 seconds that was set
at some point to allow systems with drivers built as modules and loaded by
user-land to probe drivers that were previously deferred.

The 10 seconds timeout isn't enough for the mentioned systems, for example
general purpose distributions attempt to build all the possible drivers as
a module to keep the Linux kernel image small. But that means that in very
likely that the probe deferral mechanism will timeout and drivers won't be
probed correctly.

So let's change the default again to -1 as it was at the beginning. That's
how probe deferral always worked. In fact, it could even be that users can
load modules manually after the system has already booted so it is better
to not assume when it can be safe to just timeout instead of probe defer.

Systems that want to somehow time bound the probe deferral seems to be the
special case, so it makes more sense for these to either not enable module
support or specify a timeout using the "deferred_probe_timeout" parameter.

Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

 drivers/base/dd.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index 3dda62503102..7592f5ce35c8 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -256,11 +256,7 @@ static int deferred_devs_show(struct seq_file *s, void *data)
 }
 DEFINE_SHOW_ATTRIBUTE(deferred_devs);
 
-#ifdef CONFIG_MODULES
-int driver_deferred_probe_timeout = 10;
-#else
-int driver_deferred_probe_timeout;
-#endif
+int driver_deferred_probe_timeout = -1;
 
 EXPORT_SYMBOL_GPL(driver_deferred_probe_timeout);
 
-- 
2.38.1

