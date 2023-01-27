Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BEC767E9C8
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 16:44:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234609AbjA0PoA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 10:44:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232456AbjA0Pn4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 10:43:56 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69DEE83951
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 07:43:49 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id vw16so14700706ejc.12
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 07:43:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=C0XbD0jJdU2x+omBw0qnilPtQJrXIbuZZfbb07Z77I0=;
        b=rhn6HiKjfZwLaFGQK38vDp9w1cvhdoUbh8rp3/CF5hFP/JeLDKrD1AwCYvOyo+ftVM
         hva82F6VMCtIlwPj7I2iC9zPtpKPz5QijVb1HvKPXjwS1GLz0LoGMTr1spq7AeDUg9a1
         WxU/bfsL9xGibKLvrEXk9auUZmnuqUR1Ui3yd4dUnUCYMLfPr3CCn9o09ipOLmqpfy92
         i383zdPhTal2L2M2CWT9NdysSC5DoWiWD0OodJk3KEJSfuOrMYgUIp8c4YhcVq3VN20R
         ziqnBJsRLSt3BKSMMP2DlnTjJVakTNBGvdRuMe5JPN15DqlmH1PTnR+9KpUA4WwPGg+I
         Nkug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C0XbD0jJdU2x+omBw0qnilPtQJrXIbuZZfbb07Z77I0=;
        b=kiuzCoeps2SbGVA+4mHSRtc0Y/MksETnhr8kX8u/0+xZQq9u946Vgm33GgOji5DsLq
         Mlu8sa0wbXnjnWWHoeMMwbY0qh125lmN2anOYWxdBpI+qYDt+2lCEEM8WbG7DKIV9WDQ
         EoRMYL9de2kavzdxd9Tla+PGwgvE0bNgTJqfOZtmPTiWPBk+uycurTuFPVbbTq5Tj0Ve
         qF+lmPvk5B3YxR2lLwp1Q8VqNLTzLJIo93CGRiSo677oCLQG3kxldaaHxDrF6wJyyB1d
         cNg45mBLUNK4cN7FA+NBhaOnPZ/mwwklHapYShYMyqMfHVlZVXSc8Y8F2mSgLNfhLPbb
         mpOg==
X-Gm-Message-State: AFqh2krASiJjYxEclAsqv43HYMKiSFNHyiGOrEW+tBQHV0Be/BlrlZyD
        GLUx8QTY8XnglV2ejuzLWYXBEw==
X-Google-Smtp-Source: AMrXdXtIPa2FHgXTbsBWuFGKqryY9aFAnBphBxSv1zAdzgW9cAzkyCKlcCl0N7aLR0cMGtIDblr/Sw==
X-Received: by 2002:a17:906:3291:b0:86f:356e:ba43 with SMTP id 17-20020a170906329100b0086f356eba43mr40042800ejw.18.1674834227901;
        Fri, 27 Jan 2023 07:43:47 -0800 (PST)
Received: from uffe-XPS13.. (h-94-254-63-18.NA.cust.bahnhof.se. [94.254.63.18])
        by smtp.gmail.com with ESMTPSA id va17-20020a17090711d100b00876479361edsm2467611ejb.149.2023.01.27.07.43.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 07:43:47 -0800 (PST)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Cc:     Paolo Valente <paolo.valente@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH] block: Default to build the BFQ I/O scheduler
Date:   Fri, 27 Jan 2023 16:43:39 +0100
Message-Id: <20230127154339.157460-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Today BFQ is widely used and it's also the default choice for some of the
single-queue-based storage devices. Therefore, let's make it more
convenient to build it as default, along with the other I/O schedulers.

Let's also build the cgroup support for BFQ as default, as it's likely that
it's wanted too, assuming CONFIG_BLK_CGROUP is also set, of course.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 block/Kconfig.iosched | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/block/Kconfig.iosched b/block/Kconfig.iosched
index 615516146086..221739143d44 100644
--- a/block/Kconfig.iosched
+++ b/block/Kconfig.iosched
@@ -18,6 +18,7 @@ config MQ_IOSCHED_KYBER
 
 config IOSCHED_BFQ
 	tristate "BFQ I/O scheduler"
+	default y
 	select BLK_ICQ
 	help
 	BFQ I/O scheduler for BLK-MQ. BFQ distributes the bandwidth of
@@ -30,6 +31,7 @@ config IOSCHED_BFQ
 config BFQ_GROUP_IOSCHED
        bool "BFQ hierarchical scheduling support"
        depends on IOSCHED_BFQ && BLK_CGROUP
+       default y
        select BLK_CGROUP_RWSTAT
 	help
 
-- 
2.34.1

