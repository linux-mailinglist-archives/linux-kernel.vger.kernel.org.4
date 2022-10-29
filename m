Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB61A612427
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 17:23:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbiJ2PXv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Oct 2022 11:23:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbiJ2PXt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Oct 2022 11:23:49 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20FC651A0B
        for <linux-kernel@vger.kernel.org>; Sat, 29 Oct 2022 08:23:48 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id f27so19542965eje.1
        for <linux-kernel@vger.kernel.org>; Sat, 29 Oct 2022 08:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-language:mime-version:user-agent
         :date:message-id:subject:from:cc:to:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LM0zNyCG6vu1EkX5rDqFjfE2Q0rAIzB1wYhK7YvnQns=;
        b=juD2ya3o94qMIsY8wraqg+F+Qd2G6JeimGfqSmHC2B1NwGQ0B3tn65TlxYbQAu8iOe
         sm/SU/BP21gVtp/zaXfagzyJPVRX2bJVtW1WPI9aF8/V+tS3+ErGABMslZgJUZle8Eru
         J4avK/5g/EmAlL93IR7KcbCgIzjKuC+RTTsJhKspyG4pXD2JUOsZsrP/pSo3PGGvmlpK
         L52/k8K6AUjBejickvlE5qICWZV4xDfvo+sftFbUSjW9XLL5vxzShdumRtJDwLDNCsjq
         sjvP1fyfEKmJtIjY82ShMZD29FGDnSpIvncz7K57KfHytH/AI56iP9jIpXkc9Gb3S8KL
         1g+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:mime-version:user-agent
         :date:message-id:subject:from:cc:to:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LM0zNyCG6vu1EkX5rDqFjfE2Q0rAIzB1wYhK7YvnQns=;
        b=DVP6axDjIZqDKirxskWPje4JdWWIYhy96ZGjPbs6oCN6yEa6jjsC0ibrUZNQjZc562
         cW3VcseP3l4o/0QDxZjBgw7B5o2EVRa+PafSh5JiKi1yVIA1+HoQfXzivMCi/4POaHC6
         fgjQLK8eYg4N8N28p9rsXhuF754enWXaXV4HEqvFPzo+No6jZ/eM518f5wXyIn/Uz0gV
         kXXvrMniM1cSgr6iESVlKAszFEkHZFSvlNQwDpZ2tsqUVgvoJSDc3+t6SEPP9d7kfWdV
         SDqmfewjqBQud80cppID4IEUmHEH8est5t7KLWVywlzY4O4+eCHgcv5Mym6xMXl4me3u
         6Aaw==
X-Gm-Message-State: ACrzQf3LgdZgJq0ctfV3wSWnZSziteCyGPkT7HmOGeZ2XO0lpwdlhkX2
        FFVVVLZ8a+9HAkkbH9Xyl7J6pLGByt/0FQ==
X-Google-Smtp-Source: AMsMyM7cufHmJnEOFkb7HDOqoa+AK1me5MwoKmn499nTc0wfkM2nSYIF9kssabeYNCPeuCtZPTe9Ww==
X-Received: by 2002:a17:907:97c3:b0:79b:3f8d:a354 with SMTP id js3-20020a17090797c300b0079b3f8da354mr4285123ejc.461.1667057026596;
        Sat, 29 Oct 2022 08:23:46 -0700 (PDT)
Received: from [192.168.1.10] ([46.249.74.23])
        by smtp.googlemail.com with ESMTPSA id gg33-20020a17090689a100b0078b03d57fa7sm787034ejc.34.2022.10.29.08.23.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 29 Oct 2022 08:23:46 -0700 (PDT)
To:     wens@csie.org, samuel@sholland.org
Cc:     mripard@kernel.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, Merlijn Wajer <merlijn@wizzup.org>
From:   Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Subject: [BISECTED] Allwinner A33 tablet does not fully power off
Message-ID: <9f8a0fc3-1d9a-b271-3c26-4f7373b8a3e9@gmail.com>
Date:   Sat, 29 Oct 2022 18:23:43 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Firefox/60.0 Thunderbird/60.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

After commit 843107498f91e57d1d4b22cd8787112726fdaeb4 (bus: sunxi-rsb: 
Implement suspend/resume/shutdown callbacks) Q8 A33 tablet I have here 
cannot be powered-on after power-off, it needs press-and-hold of the 
power button for 10 seconds (I guess some HW assisted power down 
happens) before it can be powered-on again.

The following patch makes it behave correctly:

diff --git a/drivers/bus/sunxi-rsb.c b/drivers/bus/sunxi-rsb.c
index 60b082fe2ed0..30016d62044c 100644
--- a/drivers/bus/sunxi-rsb.c
+++ b/drivers/bus/sunxi-rsb.c
@@ -818,10 +818,7 @@ static int sunxi_rsb_remove(struct platform_device 
*pdev)

  static void sunxi_rsb_shutdown(struct platform_device *pdev)
  {
-       struct sunxi_rsb *rsb = platform_get_drvdata(pdev);
-
         pm_runtime_disable(&pdev->dev);
-       sunxi_rsb_hw_exit(rsb);
  }

  static const struct dev_pm_ops sunxi_rsb_dev_pm_ops = {


I guess the issue comes from the fact that by the time 'power off' 
command to the power management IC has to be send, the bus it lives on 
is already down, so the device is left in semi-powered down state. Ofc 
this is a wild guess, however, preventing the bus being turned off on 
shutdown fixes the issue.

Please LMK if the above is the correct approach so I will send a proper 
patch or something else shall be fixed.

Ivo
