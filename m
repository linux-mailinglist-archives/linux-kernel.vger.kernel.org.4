Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE4F86697A7
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 13:45:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241770AbjAMMpl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 07:45:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241949AbjAMMoL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 07:44:11 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DB5640C35
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 04:36:28 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id az20so32929456ejc.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 04:36:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N1ZPBPraqcCSXLcbBqEiTH4593Z8hkjnTNKrVJO6nsc=;
        b=H1cWTLNMFyabZxRRgStGWeUzanvjp0Bj18ZcRAus/5m28S6QpN3yI1JV+uWc+YzPfU
         IyhyKcRkDRynH5pTc8H99VKS4vSpQywBAL8oVCIkkl6miPByqCFRIWYcxiCArTI5FwM+
         zVEZ40O4VzfAFqpdDexxjWxp6DOvibzhkqNhNqnamU3SWC/y7bIh2q0RWNBzeDEeyYPl
         S9N91Mv8T9e5MO9p88rokudwIsO/OJrHscaNspDv743X4ILM+GEEOAuf25tVuu0pMqL3
         eddMnTZdYDp42Lp4tYh3lLDK9SUdWuoN6Nfc4rRnAhnAeD8bux39C7jc8O+618+2W0Uw
         YTRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N1ZPBPraqcCSXLcbBqEiTH4593Z8hkjnTNKrVJO6nsc=;
        b=JGaAhT2ro/WgtgOJNjBgnrDGHnEBs+jtZyo3lsTnMv8kGHAE6pYznKStM84r6p+s6q
         4Pg3DBt2YJ9uPt7LEWWqbV8vbPc6yu5LV+7uc1ybm2R8Jf4i+KUeHuwbUZ7hdVsmJET5
         Oq+kD3fdYCre7KZNAVTqsPb4YKo21JMCfU4RVHFG2stYmNdgEYT451Yu1RXNXFaN3P7/
         DqlD57PTgPNWZ63XA/9b7njq5Tdro3IzALyvl26jZEGnL4hhVACL9D6Mfoopeul8CM3d
         ctrL5VYtHSH4EWk/alp66/y8d0zHRLZB7pHj9OO2EQSLktSnHHrBxVkN7N/RZAEIs6Hp
         yjTg==
X-Gm-Message-State: AFqh2kpaWe+YBYYXXq1+ryJ3+VdEGiyVx9NrihamCrtu591LDMPlEBiS
        gwvzUFESnxpYBwBUUf5/IfVVTA==
X-Google-Smtp-Source: AMrXdXtMtHzH0ab2fylDfJ3FwmJBMxwWgMb80CrapVMEh3PCsXJ3VEY9ljT7Bfa44WICBObQntdf+w==
X-Received: by 2002:a17:906:838b:b0:851:97ca:7fc9 with SMTP id p11-20020a170906838b00b0085197ca7fc9mr14761111ejx.40.1673613347524;
        Fri, 13 Jan 2023 04:35:47 -0800 (PST)
Received: from localhost.localdomain (h082218028181.host.wavenet.at. [82.218.28.181])
        by smtp.gmail.com with ESMTPSA id 17-20020a170906329100b007c0bb571da5sm8402496ejw.41.2023.01.13.04.35.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 04:35:47 -0800 (PST)
From:   =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= 
        <christoph.boehmwalder@linbit.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     drbd-dev@lists.linbit.com, linux-kernel@vger.kernel.org,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        linux-block@vger.kernel.org,
        =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= 
        <christoph.boehmwalder@linbit.com>,
        Joel Colledge <joel.colledge@linbit.com>
Subject: [PATCH 6/8] MAINTAINERS: add drbd headers
Date:   Fri, 13 Jan 2023 13:35:36 +0100
Message-Id: <20230113123538.144276-7-christoph.boehmwalder@linbit.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230113123538.144276-1-christoph.boehmwalder@linbit.com>
References: <20230113123538.144276-1-christoph.boehmwalder@linbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>
Reviewed-by: Joel Colledge <joel.colledge@linbit.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 595d59eec7ea..83b6f3a97cf6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6349,6 +6349,7 @@ T:	git git://git.linbit.com/linux-drbd.git
 T:	git git://git.linbit.com/drbd-8.4.git
 F:	Documentation/admin-guide/blockdev/
 F:	drivers/block/drbd/
+F:	include/linux/drbd*
 F:	lib/lru_cache.c
 
 DRIVER COMPONENT FRAMEWORK
-- 
2.38.1

