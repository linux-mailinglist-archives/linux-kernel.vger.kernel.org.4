Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1986F72645B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 17:25:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239816AbjFGPZm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 11:25:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241585AbjFGPZK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 11:25:10 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 057121FE8
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 08:24:48 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1b0424c5137so64958745ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 08:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686151485; x=1688743485;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RiKvZSsDZj7fd26SGwfQBoXfS34tAdkyr70ERjpK1aY=;
        b=zqPggBcq11OX1ElgAFqoDAWJRSASVztJb1cWe6OynaqzLe7sBsRT+wAnAtnUAFidvn
         F5l4K5Dhxc8a1NacTr6qRcfwZRlB3SnqlCzOofBuwXZ+wi6fdsWaWEuThesswCSjO61H
         obx5ReKroXUhJEum8G0ogUpHHN3e1IxlHELQwwsdbJOvwjBLvg1weSd3i91QuEDdI/Ha
         OUpTXWz4W60SlYCfvAbA2Wwp/PMWZrzpv2mPZJhOSJ5HkH5982DpU0WeiX/M5sAdYPGR
         gnO3lJfDLFU9t81dUl5qkSnjZN55uKpA0ajcaseMwBZaxbMNvsBt0yi8k2NtboE+mUEp
         nFsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686151485; x=1688743485;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RiKvZSsDZj7fd26SGwfQBoXfS34tAdkyr70ERjpK1aY=;
        b=deBaTAGiVU+jRdLQHumCiLuORsieDzNmkeni1hwQqnaAGZ858Yg8GB6SMNwqZI4nnh
         G/klbqhMhxsNS95uV1IuT05gcjb+IXkAv00z1NSqfUCur511S6kaW2rv0wQZX91hBwfe
         df3XJL6EGViu1FH3+q2cBU/25RXxTZNsU85IDOvrk0StgN7BUmicyvBNRC/GphySlqmS
         9PFDTsYwMDsqHKBFxYzUjoSQAmaqYfbMdlG8o8KJtYJgU95DiLWX+g6YqGQGw+LbuoCq
         4WHobd0Z0k3z31jIgE5kWELpaHV4LERKaxyMj7CbTHAJht7yUhTpeirmOjdYOh9HP9n/
         OfNQ==
X-Gm-Message-State: AC+VfDy4ch2FgyiBZTEDgV5svQ5blLU4RDYzsCQ10GHa1bSDXLjbG5lD
        gj1rOshcK9jy5lUA/sGAsl+C
X-Google-Smtp-Source: ACHHUZ6d4E1TgxI5W1nBECW5opZQlDztc30qRfffvojmV4zVv25wpJL8mcdindlvslgaAnTog4ZAVQ==
X-Received: by 2002:a17:902:da8d:b0:1b2:28ca:d38 with SMTP id j13-20020a170902da8d00b001b228ca0d38mr6687381plx.10.1686151485580;
        Wed, 07 Jun 2023 08:24:45 -0700 (PDT)
Received: from localhost.localdomain ([59.92.97.244])
        by smtp.gmail.com with ESMTPSA id q5-20020a170902788500b001aaf536b1e3sm10590958pll.123.2023.06.07.08.24.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 08:24:45 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com
Cc:     mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        loic.poulain@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 2/2] MAINTAINERS: Add entry for MHI networking drivers under MHI bus
Date:   Wed,  7 Jun 2023 20:54:27 +0530
Message-Id: <20230607152427.108607-3-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230607152427.108607-1-manivannan.sadhasivam@linaro.org>
References: <20230607152427.108607-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The host MHI net driver was not listed earlier. So let's add both host and
endpoint MHI net drivers under MHI bus.

Cc: Loic Poulain <loic.poulain@linaro.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 081eb65ef865..14d9e15ae360 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13632,6 +13632,7 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/mani/mhi.git
 F:	Documentation/ABI/stable/sysfs-bus-mhi
 F:	Documentation/mhi/
 F:	drivers/bus/mhi/
+F:	drivers/net/mhi_*
 F:	include/linux/mhi.h
 
 MICROBLAZE ARCHITECTURE
-- 
2.25.1

