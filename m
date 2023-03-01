Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8F166A64C4
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 02:25:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbjCABZS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 20:25:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbjCABZQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 20:25:16 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 817F836471
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 17:25:10 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-536bf649e70so248686577b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 17:25:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1677633909;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZpTjGf5rdoQrgqg7m4j1olf7isTwZLPPEo4N4KGMcEs=;
        b=P1Jw3R9M7WyomTrluAtxS6Vdnfm6Xc3oR/9mSdbGPZ7SHcz4lGkgd3F7ehpanwlSHw
         kbNZPnmmreFDmFgC1bKEKKQh8sdgyUNgLB1nxL7//ezPy6ccyf19TJpvhzu8lxmetVR0
         oRTCU1g9Z+C38UNCe+JLI386mh9XKUMOOeRbwqGrCTizpwI0MiTXnOgmZ7eJoW1AByRn
         Lo/ZyJu232LIU5MTMBovZJQQ1M+p5TRVL1r/aJsIe/VR/kzxKvmw0HBipYEQMPC7kFxL
         9v4HvzBP6ykxUKJIHDVEUnK4msPJvwpW7r/xfyzp0oNsNOmd6/ktU7z3POjnk4VkNDbQ
         xN+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677633909;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZpTjGf5rdoQrgqg7m4j1olf7isTwZLPPEo4N4KGMcEs=;
        b=grCTQ4PPve6ETnZuZNLJpImoNatL+pnlkGL7e7l/+foJrLz0lnzRM8qY7WbL/Ybs6N
         w/EmYoEc9DtP5qvd/0KnQJyvOmt1cz5fi3uzgDmNR3Cr572xbaI6eizEtHjsHEnVI5C/
         Boce6xtsABmdG8c5F+2QQY7iyT4zMmYAdcxGiGjjMj72WC3ZOQ1Uy2nOgSl6wnsHX4Nz
         j02GiyC+OpzvSg1Ri72ufkkBGvh+ykM3c2niomn+DX4KxXC1P7bH4+riOiN4E9W1aW4g
         Th8BPoBVkHDfEaU5f28mVHTbnZFaKizAmESSasv1MaJBJOG8eYJkKKO7AD3uicDAj4gt
         mAPg==
X-Gm-Message-State: AO0yUKW1yezWf+Uq+ytg/6XlgIqU/zri2b/j+bVk4j6Wkc9cNSLMLdED
        aSTfVK+La8YTcKjNCzKBB6vD5s99YxSlkf8=
X-Google-Smtp-Source: AK7set8XzvTlY3Lelpk8wWvtM+smDcvIiIuFVaO7S/PpYpjk8CTakqtZKPi9Od/tLawpoxrRPPIDOdt1aEYwb+w=
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:debf:1aed:5c45:c92])
 (user=saravanak job=sendgmr) by 2002:a5b:50:0:b0:ab8:1ed9:cfc5 with SMTP id
 e16-20020a5b0050000000b00ab81ed9cfc5mr1566210ybp.6.1677633909687; Tue, 28 Feb
 2023 17:25:09 -0800 (PST)
Date:   Tue, 28 Feb 2023 17:25:06 -0800
Message-Id: <20230301012506.1401883-1-saravanak@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.2.722.g9855ee24e9-goog
Subject: [PATCH v1] clk: Mark a fwnode as initialized when using
 CLK_OF_DECLARE* macros
From:   Saravana Kannan <saravanak@google.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Saravana Kannan <saravanak@google.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>, kernel-team@android.com,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The CLK_OF_DECLARE macros sometimes prevent the creation of struct
devices for the device node being handled. It does this by
setting/clearing OF_POPULATED flag. This can block the probing of some
devices because fw_devlink will block the consumers of this node till a
struct device is created and probed.

Set the appropriate fwnode flags when these device nodes are initialized
by the clock framework and when OF_POPULATED flag is set/cleared. This
will allow fw_devlink to handle the dependencies correctly.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reported-by: Linus Walleij <linus.walleij@linaro.org>
Link: https://lore.kernel.org/lkml/CACRpkdamxDX6EBVjKX5=D3rkHp17f5pwGdBVhzFU90-0MHY6dQ@mail.gmail.com/
Fixes: 4a032827daa8 ("of: property: Simplify of_link_to_phandle()")
Signed-off-by: Saravana Kannan <saravanak@google.com>
---

This is fixing a patch that landed through driver core. So, should Greg
be pulling in this fix?

-Saravana

 drivers/clk/clk.c            | 4 ++++
 include/linux/clk-provider.h | 1 +
 2 files changed, 5 insertions(+)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index ae07685c7588..8bd5b9841993 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -5361,6 +5361,10 @@ void __init of_clk_init(const struct of_device_id *matches)
 				clk_provider->clk_init_cb(clk_provider->np);
 				of_clk_set_defaults(clk_provider->np, true);
 
+				fwnode_dev_initialized(
+					of_fwnode_handle(clk_provider->np),
+					true);
+
 				list_del(&clk_provider->node);
 				of_node_put(clk_provider->np);
 				kfree(clk_provider);
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index 842e72a5348f..93c0b06a0f2b 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -1373,6 +1373,7 @@ struct clk_hw_onecell_data {
 	static void __init name##_of_clk_init_driver(struct device_node *np) \
 	{								\
 		of_node_clear_flag(np, OF_POPULATED);			\
+		fwnode_dev_initialized(of_fwnode_handle(np), false);	\
 		fn(np);							\
 	}								\
 	OF_DECLARE_1(clk, name, compat, name##_of_clk_init_driver)
-- 
2.39.2.722.g9855ee24e9-goog

