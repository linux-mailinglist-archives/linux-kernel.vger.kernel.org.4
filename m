Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6076866A3E8
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 21:14:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230428AbjAMUOf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 15:14:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbjAMUO3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 15:14:29 -0500
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4FE1149E0;
        Fri, 13 Jan 2023 12:14:27 -0800 (PST)
Received: by mail-ej1-f54.google.com with SMTP id hw16so42957709ejc.10;
        Fri, 13 Jan 2023 12:14:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5JjL1j5iNZo1KU1fhAgOKaIYvkYllk/Lw+U9Din0xd0=;
        b=B3rbQsvERehpGtZkivvZjjunScQerctRZPQafROFcMjjk54o+1z+uGSgJQ1z8THEoS
         QOpgoutkqyGfbCFhuXTlEVppcFJz9kHyze+llHzwIuk7HKjuSx8MjW4WEBfUd5WuN9VA
         IDK64jFzSfFqFrRX5M7+WHeYdsOmijBAH7MVZiDsbv3q5S+F/Zp3IodAgSS3k1uD+XXT
         /2+zNvFdb/btcOCndy6oR554YxJQERZfixwrrVBTCHnswU5k/HoS/MQF2G7/ZqJp5wfS
         WphvoIiMH9oqbg2Wq9bT6t0uYn78yJvJ1rH1QCldxZBylu1aF0yo4vmYKU+IDAt8dCVo
         BPBA==
X-Gm-Message-State: AFqh2krjO51lKBCgButKex+Rlai+LgwGtZdgumRerz1q9FayZ7xMd3tc
        3lJ+P3ts4YIGJiMtnl42p2yvn5EAywWRBlqHHk0=
X-Google-Smtp-Source: AMrXdXvi7NlnuutgKN9shlPcJSSWvdy3mHOMmT5JzO5cppbROUxY4MeClZgMBOhC49TbK0sGrkjHuHwHJoScNz4nf7A=
X-Received: by 2002:a17:907:98ee:b0:7c1:5ff0:6cc2 with SMTP id
 ke14-20020a17090798ee00b007c15ff06cc2mr6052436ejc.246.1673640866288; Fri, 13
 Jan 2023 12:14:26 -0800 (PST)
MIME-Version: 1.0
References: <1671085226-21347-1-git-send-email-shradhagupta@linux.microsoft.com>
In-Reply-To: <1671085226-21347-1-git-send-email-shradhagupta@linux.microsoft.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 13 Jan 2023 21:14:15 +0100
Message-ID: <CAJZ5v0jb3eU6asQ1TqPqV=s5k+255yse=4QH9WssnM2LH-d3uw@mail.gmail.com>
Subject: Re: [PATCH] kernel: power: swap: Suppress expected 'Image not found'
 error on Ubuntu
To:     Shradha Gupta <shradhagupta@linux.microsoft.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Dexuan Cui <decui@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 15, 2022 at 7:20 AM Shradha Gupta
<shradhagupta@linux.microsoft.com> wrote:
>
> In 'systemctl hibernate' if resume device is written to the sysfs
> resume parameter, a software_resume() call is triggerred. This call
> is expected to fail in swsusp_check() call with -EBUSY error and an
> 'Image not found' error message. This fix suppresses the expected
> failure message from getting logged in Ubuntu setups where
> CONFIG_DYNAMIC_DEBUG is enabled by default.

I see what you mean, so what about this change instead (modulo
GMail-induced white-space breakage):

---
 kernel/power/swap.c |    9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

Index: linux-pm/kernel/power/swap.c
===================================================================
--- linux-pm.orig/kernel/power/swap.c
+++ linux-pm/kernel/power/swap.c
@@ -1546,17 +1546,16 @@ int swsusp_check(void)
         }

 put:
-        if (error)
+        if (error) {
             blkdev_put(hib_resume_bdev, FMODE_READ | FMODE_EXCL);
-        else
+            pr_debug("Image not found (code %d)\n", error);
+        } else {
             pr_debug("Image signature found, resuming\n");
+        }
     } else {
         error = PTR_ERR(hib_resume_bdev);
     }

-    if (error)
-        pr_debug("Image not found (code %d)\n", error);
-
     return error;
 }
