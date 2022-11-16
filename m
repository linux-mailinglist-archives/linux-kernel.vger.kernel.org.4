Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7806662BD3F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 13:10:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233610AbiKPMKz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 07:10:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238531AbiKPMKg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 07:10:36 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AC013FBAE
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 04:03:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668600180;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2bKdDWjb/yR9GkUK+RJy2/FRw0utp2NjQXlBH9JbbvI=;
        b=IPV8qyDFPFjzs88q2JZ0G5xDmcAD5RmYhWZTeX5irfUPpnbQLJol7cIvTDMEsR8b2NYbQQ
        4UcVPdJXb/6vUm91iVoRg5zq7z+aitwKVn9tDzrboJhguafbBz4lJqABilmk6+GxqNEi28
        0JOOp/XdQq2nQ8bRyeErbgIijYR/86M=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-536--b3yZEGGOti0GIw-WAcLvA-1; Wed, 16 Nov 2022 07:02:59 -0500
X-MC-Unique: -b3yZEGGOti0GIw-WAcLvA-1
Received: by mail-wr1-f69.google.com with SMTP id w11-20020adfbacb000000b002418a90da01so2208217wrg.16
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 04:02:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2bKdDWjb/yR9GkUK+RJy2/FRw0utp2NjQXlBH9JbbvI=;
        b=kKBks5zrT3/BN46pu+JEXq9o6a6eO+ccJi5q/eD4zSlevdRIrFYfSNGc3D3NFVjqNI
         bsId0U//ZudF1taN3agtiisypGTbrHRiXR+RbDGZAlLGyRPY9S8R2YoTOdwv5+U9y5x6
         Cw8fvriL/EKBlAqbULfz2N72FxjdWf7rhFeCLYXxdxMvm/R/Cj5PZxUGDzO/4dMhuyAq
         BU+R8fZ/jV2zi3QodVMxh83rADeuNQu3oAnTXhaU4W7wFKuk5XAhtr7GxM4rvoF6qZLY
         YqIIg6ncKeffAsJKwIRIiZQwnff1kqS4upgcMKZYnv5PG4dhXle81+LJVMWwcwY1qNw3
         rIPQ==
X-Gm-Message-State: ANoB5pnfq8+fdCRs9SRZQj0sudg5QHuFf5n7R94mAMXZhXtIyHwo2Hzi
        HchUtm3ofqihNoyZMpZeOwcXn8QUAnSEW1CCNtXL95MWsOWugDAS8I9BlPq62FLgbcxiPNTSbH5
        ghpEkSZSJlHJVJY0w7i7A7cyVD0YkaxMcyLzo3BZd8+nsWH32ey/wlDVu4Jvrt3O3A+v9dMu296
        A=
X-Received: by 2002:adf:e6ca:0:b0:22c:e009:a201 with SMTP id y10-20020adfe6ca000000b0022ce009a201mr13972081wrm.70.1668600177657;
        Wed, 16 Nov 2022 04:02:57 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6jrqx7xXE7iEAU+DPg8d7D/B8NwSeegMi83WIWnrRgYFjqPcupo1NUjghur0H1eJtRc3gdJw==
X-Received: by 2002:adf:e6ca:0:b0:22c:e009:a201 with SMTP id y10-20020adfe6ca000000b0022ce009a201mr13972045wrm.70.1668600177318;
        Wed, 16 Nov 2022 04:02:57 -0800 (PST)
Received: from minerva.home (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id h3-20020a05600c2ca300b003b49bd61b19sm2025563wmc.15.2022.11.16.04.02.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 04:02:56 -0800 (PST)
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
Subject: [PATCH v2 4/4] driver core: Disable driver deferred probe timeout by default
Date:   Wed, 16 Nov 2022 13:02:36 +0100
Message-Id: <20221116120236.520017-1-javierm@redhat.com>
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

The driver_deferred_probe_timeout value has a long history. It was first
set to -1 when was introduced by commit 25b4e70dcce9 ("driver core: allow
stopping deferred probe after init"), meaning that the driver core would
defer the probe forever unless a subsystem would opt-in by checking if the
initcalls where done using the driver_deferred_probe_check_state() helper,
or if a timeout was explicitly set with a "deferred_probe_timeout" param.

Only the power domain, IOMMU and MDIO subsystems currently opt-in to check
if the initcalls have completed with driver_deferred_probe_check_state().

Commit c8c43cee29f6 ("driver core: Fix driver_deferred_probe_check_state()
logic") then changed the driver_deferred_probe_check_state() helper logic,
to take into account whether modules have been enabled or not and also to
return -EPROBE_DEFER if the probe deferred timeout work was still running.

Then in commit e2cec7d68537 ("driver core: Set deferred_probe_timeout to a
longer default if CONFIG_MODULES is set"), the timeout was increased to 30
seconds if modules are enabled. Because seems that some of the subsystems
that were opt-in to not return -EPROBE_DEFER after the initcall where done
could still have dependencies whose drivers were built as a module.

This commit did a fundamental change to how probe deferral worked though,
since now the default was not to attempt probing for drivers indefinitely
but instead to timeout after 30 seconds, unless a different timeout is set
using the "deferred_probe_timeout" command line parameter.

The behavior was changed even more with commit ce68929f07de ("driver core:
Revert default driver_deferred_probe_timeout value to 0"), since the value
was set to 0 by default. Meaning that the probe deferral would be disabled
after the initcalls where done. Unless a timeout was set in the cmdline.

Notice that the commit said that it was reverting the default value to 0,
but this was never 0. The default was -1 at the beginning and then changed
to 30 in a later commit.

This default value of 0 was reverted again by commit f516d01b9df2 ("Revert
"driver core: Set default deferred_probe_timeout back to 0."") and set to
10 seconds instead. Which was still less than the 30 seconds that was set
at some point, to allow systems with drivers built as modules and loaded
later by user-land to probe drivers that were still in the deferred list.

The 10 seconds timeout isn't enough in some cases, for example the Fedora
kernel builds as much drivers as possible as modules. And this leads to an
Snapdragon SC7180 based HP X2 Chromebook to not have display, due the DRM
driver failing to probe if CONFIG_ARM_SMMU=y and CONFIG_SC_GPUCC_7180=m.

So let's change the default again to -1 as it was at the beginning. That's
how probe deferral always worked. The kernel should try to avoid guessing
when it should be safe to give up on deferred drivers to be probed.

The reason why the default "deferred_probe_timeout" was changed from -1 to
the other values was to allow drivers that have only optional dependencies
to probe even if the suppliers are not available.

But now there is a "fw_devlink.timeout" parameter to timeout the links and
allow drivers to probe even when the dependencies are not present. Let's
set the default for that timeout to 10 seconds, to give the same behaviour
as expected by these driver with optional device links.

Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

Changes in v2:
- Mention in the commit messsage the specific machine and drivers that
  are affected by the issue (Greg).
- Double check the commit message for accuracy (John).
- Add a second workqueue to timeout the devlink enforcing and allow
  drivers to probe even without their optional dependencies available.

 drivers/base/dd.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index ea448df94d24..5f18cd497850 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -256,12 +256,8 @@ static int deferred_devs_show(struct seq_file *s, void *data)
 }
 DEFINE_SHOW_ATTRIBUTE(deferred_devs);
 
-#ifdef CONFIG_MODULES
-static int driver_deferred_probe_timeout = 10;
-#else
-static int driver_deferred_probe_timeout;
-#endif
-static int fw_devlink_timeout = -1;
+static int driver_deferred_probe_timeout = -1;
+static int fw_devlink_timeout = 10;
 
 static int __init deferred_probe_timeout_setup(char *str)
 {
-- 
2.38.1

