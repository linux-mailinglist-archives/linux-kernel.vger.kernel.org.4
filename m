Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA4F36B547C
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 23:31:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231295AbjCJWbq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 17:31:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230135AbjCJWbE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 17:31:04 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB34D125D92
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 14:30:06 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id ec29so26474993edb.6
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 14:30:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678487400;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1bKoS9pvaPD45vxy/8VN1t6bf3++/Pyh+VWncnUfWao=;
        b=bttxm87/lgUPmpMYKydTCfUMa5cDKLYHvOBIkzCvMNEPYG4xqqJeJUWgGQQDH9PyzO
         SaTEota3CK4/NereGVSzzNR43a+xssbGD17otOcAoR/UlGNmQ/DG/IeUJ0My8hgqsKlo
         FdpcOxV2cHVwUjbZ9Y89PfMva8mxNaN8rdbycAdg9HUR7rKw3YUP5DFyKk6TbP95bsPT
         MV2QY1ZSXetc9ctfkeou/ZL5xRdyUqL8uOF2OJ067z/Kqb2wpxzDJcK5trgGZiQ3BzHe
         bzuWfwQma93PkD6JlblqZClSrAAe88Uu4R1khZlNRI5SH1YCVHkoWyGw+lcyPPF5/xfF
         5GNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678487400;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1bKoS9pvaPD45vxy/8VN1t6bf3++/Pyh+VWncnUfWao=;
        b=onCt9eikqEBT0gCQRjKuTSvH9OFF8tcdO2ms+RcMYQGMuA4M5Nzl3ITRIpnEzYe8uH
         LqxmncuRwZyK6XwqpZTK1ohYUjQZMtkGvjU+S3iIicgj8ed1YRhsFQMtgG59U/9lsNR+
         K2+KClAszOUFsjTZ9W8O1AXC4AWN2MEp2gE2LPXJsbFU0l1ODUGhMHW9F9Fiby2UFait
         WBqqXlgiXW9X2BEFGtAntpTk3svuADXblcfynn7kdslC59gVLTgJkZiK/qZ1apagj76d
         9JHY7KUT8RFd/9vAnbD4uDURgoel3q0SInD4hj/9K2yuNXPs4tk+6Z+lbInwbuWNmrp1
         umfQ==
X-Gm-Message-State: AO0yUKV09m1B7XQZDrrzvSR4K8ccQ6QkSCQE36EbzAfXyd8hUhMpBnSw
        Gkn6kn1noPJdxY+R2jt5MLDSrg==
X-Google-Smtp-Source: AK7set/tYHm3YohbJurAFpGOd/UcKCLoXe4uAxVuLCtC4yaFD/VHodM/+2UXAUZPyoY9aefDgDO9Pw==
X-Received: by 2002:a17:906:a1c5:b0:906:3373:cfe9 with SMTP id bx5-20020a170906a1c500b009063373cfe9mr25594468ejb.10.1678487399961;
        Fri, 10 Mar 2023 14:29:59 -0800 (PST)
Received: from krzk-bin.. ([2a02:810d:15c0:828:34:52e3:a77e:cac5])
        by smtp.gmail.com with ESMTPSA id k10-20020a50c08a000000b004c2158e87e6sm495695edf.97.2023.03.10.14.29.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 14:29:59 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/2] serial: sh-sci: mark OF related data as maybe unused
Date:   Fri, 10 Mar 2023 23:29:56 +0100
Message-Id: <20230310222957.315848-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver can be compile tested with !CONFIG_OF making certain data
unused:

  drivers/tty/serial/sh-sci.c:3144:34: error: ‘of_sci_match’ defined but not used [-Werror=unused-const-variable=]

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/tty/serial/sh-sci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 7bd080720929..a12aa8ff2d51 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -3141,7 +3141,7 @@ static int sci_remove(struct platform_device *dev)
 #define SCI_OF_TYPE(data)		((unsigned long)(data) >> 16)
 #define SCI_OF_REGTYPE(data)		((unsigned long)(data) & 0xffff)
 
-static const struct of_device_id of_sci_match[] = {
+static const struct of_device_id of_sci_match[] __maybe_unused = {
 	/* SoC-specific types */
 	{
 		.compatible = "renesas,scif-r7s72100",
-- 
2.34.1

