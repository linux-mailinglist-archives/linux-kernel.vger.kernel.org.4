Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 323326DD033
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 05:31:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbjDKDbK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 23:31:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbjDKDbG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 23:31:06 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFA6A172B
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 20:31:04 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1a52648e0dcso2822705ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 20:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681183864; x=1683775864;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6ADmYS9mqbZyrMcltEWXh3K5aDlc5Z8KgWrgOoUl3zI=;
        b=gGkUurv/wo/vQUfZv3sE+Xi4vbIzlG3n8x/gEn3SUgdq2j4i65ZjwSbQlZcOQRT4Af
         YNVr2I1Ow72/OAKKMTLDD11+jW++DogBZsRL8uAsm828bH4GUGcsl8ST4FBcLsBUzoty
         ZcEdoJu+LEbyg2M5ccBXDAd2mbdMrc6dhlvfs2EJXwk6yDUH2xdPSs7jPO+KDqveU99Q
         fUt0K5g4iVFrjMGC481St1abs63lVy2tLYRpqhYgKmJU0RpuNMk9VuXlVOlLNt/5qW9A
         dKZehyScjRCiHpxhBt1Ij6zOEKFvOBs0KTBccEtYo56afg8J2nMkz2SZw2gT1VuKlKs+
         l3VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681183864; x=1683775864;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6ADmYS9mqbZyrMcltEWXh3K5aDlc5Z8KgWrgOoUl3zI=;
        b=UuMvvCLWuWkyfm8I46dXe+FPxPcftx3/IJpsMgTStVDLNnJbDJykCPTroA8i+E8tgw
         JJz5ofblTOvMImdGqu+kd2c9HZdyiF4jgd2gNF3iVIjElrsWYzPdIBiV3hwDd/T9+yQ0
         ULdyGWlcUYfbcEbSaT8HfSrUC6c5L28VwFA7mNL9iYPqX9+gOmnr/WG0vtHls9GdBYRS
         2goo2YVOWsmpjogJiXjIMtrnJHjzaYQGhW4rL7mydAy1I6OXNFyfLdgEZ3Qj1B62xTIT
         Ry9pUe00Znfcg09neLPwBEzz2kdQitYd++CvvobO3o7Lq9W0JQovtKNPrMjxmLFmVMBg
         1PLA==
X-Gm-Message-State: AAQBX9dts9UV5ZdfIT0bwdwfvOxKc3lyKBmxomT54wR4bAY/LrdDXDt9
        X0dgx0SmNyEw4RsVPG7zin9cyg==
X-Google-Smtp-Source: AKy350bfGCkeIj8TeSGJgc/MzhgkeGbBT5l2AslwrZmk+OnQlaVVFh857DYvS6yyr3gsd8t7iKslkQ==
X-Received: by 2002:a62:29c1:0:b0:624:7aac:ab7 with SMTP id p184-20020a6229c1000000b006247aac0ab7mr13232757pfp.18.1681183864202;
        Mon, 10 Apr 2023 20:31:04 -0700 (PDT)
Received: from localhost ([122.172.85.8])
        by smtp.gmail.com with ESMTPSA id x5-20020aa79185000000b0062ddcad2cbesm8864100pfa.145.2023.04.10.20.30.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Apr 2023 20:30:52 -0700 (PDT)
Date:   Tue, 11 Apr 2023 09:00:48 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     linux-pm@vger.kernel.org, kernel-janitors@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>, cocci@inria.fr,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [v2] cpufreq: sparc: Fix exception handling in two functions
Message-ID: <20230411033048.zwsijlyiksjcmgcc@vireshk-i7>
References: <f9303bdc-b1a7-be5e-56c6-dfa8232b8b55@web.de>
 <b3cce5b3-2e68-180c-c293-74d4d9d4032c@web.de>
 <2d125f3e-4de6-cfb4-2d21-6e1ec04bc412@web.de>
 <20230403033529.x6n3ihhkypwizq3b@vireshk-i7>
 <39342542-9353-6a7b-0aa9-f9c294b158cb@web.de>
 <20230403230432.xeubpa3cc2gt4mw3@vireshk-i7>
 <68b1988b-987f-fa2b-111e-b1b42f9767ab@web.de>
 <20230409235511.7xxqdxsqtflrhifk@vireshk-i7>
 <f9f40c8a-a392-27e3-b19c-c8985a163159@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f9f40c8a-a392-27e3-b19c-c8985a163159@web.de>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10-04-23, 15:08, Markus Elfring wrote:
> >> @@ -337,21 +337,17 @@ static int __init us2e_freq_init(void)
> >>  		driver->get = us2e_freq_get;
> >>  		driver->exit = us2e_freq_cpu_exit;
> >>  		strcpy(driver->name, "UltraSPARC-IIe");
> >> -
> >> -		cpufreq_us2e_driver = driver;
> >
> > This changes the behavior of the code here as "cpufreq_us2e_driver"
> > is used in us2e_freq_cpu_exit(). If some failure occurs after a
> > policy is initialized, and driver doesn't register successfully, then
> > we won't set the frequency to the lowest index of the table anymore.
> 
> The setting of the variables “cpufreq_us…_driver” influences the need
> to reset them to null pointers for the desired exception handling,
> doesn't it?

This is what all should be done for these drivers I guess. There is no
points doing the dance of {de}allocating resources unnecessarily.

diff --git a/drivers/cpufreq/sparc-us2e-cpufreq.c b/drivers/cpufreq/sparc-us2e-cpufreq.c
index 92acbb25abb3..b31fb07f3f39 100644
--- a/drivers/cpufreq/sparc-us2e-cpufreq.c
+++ b/drivers/cpufreq/sparc-us2e-cpufreq.c
@@ -20,7 +20,14 @@
 #include <asm/asi.h>
 #include <asm/timer.h>

-static struct cpufreq_driver *cpufreq_us2e_driver;
+static struct cpufreq_driver cpufreq_us2e_driver = {
+       .name = "UltraSPARC-IIe",
+       .init = us2e_freq_cpu_init,
+       .verify = cpufreq_generic_frequency_table_verify,
+       .target_index = us2e_freq_target,
+       .get = us2e_freq_get,
+       .exit = us2e_freq_cpu_exit,
+};

 struct us2e_freq_percpu_info {
        struct cpufreq_frequency_table table[6];
@@ -300,9 +307,7 @@ static int __init us2e_freq_cpu_init(struct cpufreq_policy *policy)

 static int us2e_freq_cpu_exit(struct cpufreq_policy *policy)
 {
-       if (cpufreq_us2e_driver)
-               us2e_freq_target(policy, 0);
-
+       us2e_freq_target(policy, 0);
        return 0;
 }

@@ -319,39 +324,15 @@ static int __init us2e_freq_init(void)
        impl  = ((ver >> 32) & 0xffff);

        if (manuf == 0x17 && impl == 0x13) {
-               struct cpufreq_driver *driver;
-
-               ret = -ENOMEM;
-               driver = kzalloc(sizeof(*driver), GFP_KERNEL);
-               if (!driver)
-                       goto err_out;
-
                us2e_freq_table = kzalloc((NR_CPUS * sizeof(*us2e_freq_table)),
                        GFP_KERNEL);
                if (!us2e_freq_table)
-                       goto err_out;
+                       return -ENOMEM;

-               driver->init = us2e_freq_cpu_init;
-               driver->verify = cpufreq_generic_frequency_table_verify;
-               driver->target_index = us2e_freq_target;
-               driver->get = us2e_freq_get;
-               driver->exit = us2e_freq_cpu_exit;
-               strcpy(driver->name, "UltraSPARC-IIe");
-
-               cpufreq_us2e_driver = driver;
                ret = cpufreq_register_driver(driver);
                if (ret)
-                       goto err_out;
-
-               return 0;
+                       kfree(us2e_freq_table);

-err_out:
-               if (driver) {
-                       kfree(driver);
-                       cpufreq_us2e_driver = NULL;
-               }
-               kfree(us2e_freq_table);
-               us2e_freq_table = NULL;
                return ret;
        }

@@ -360,13 +341,8 @@ static int __init us2e_freq_init(void)

 static void __exit us2e_freq_exit(void)
 {
-       if (cpufreq_us2e_driver) {
-               cpufreq_unregister_driver(cpufreq_us2e_driver);
-               kfree(cpufreq_us2e_driver);
-               cpufreq_us2e_driver = NULL;
-               kfree(us2e_freq_table);
-               us2e_freq_table = NULL;
-       }
+       cpufreq_unregister_driver(cpufreq_us2e_driver);
+       kfree(us2e_freq_table);
 }

 MODULE_AUTHOR("David S. Miller <davem@redhat.com>");

-- 
viresh
