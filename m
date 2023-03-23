Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 345A16C62AA
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 10:05:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231633AbjCWJFE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 05:05:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231603AbjCWJEh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 05:04:37 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8BBC1E1FF
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 02:04:30 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id kq3so9299071plb.13
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 02:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679562269;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HkAGxiMm0D6sZZHk+W+42sbwTh2uKjw/ysosEWY5e6A=;
        b=LIkMDCo6uE7KtCBkAYpv7U6sC6jQgySdx8sLRUp+8pMXXhPbM43mYGNBF63R+WRXoU
         ukIJ1GGYQ4ykj/OhCzf75lefRjFVnxS5gcTa6UaiyxSZlhgjA31yxQWEbDj/r3BY9/g+
         S6xy4Pgq97Q94R3Fsk15pA6dDpcbmKcg6g+oj/N+0Mle22mvizygKS2m6D4JoPbb3bmf
         bwZJVGXUk4tBt7cPTHn1u202TOgXst67Eg8w3X2DTXrjM3MRjCQzZhPDWUi0ybGKC0OG
         /rnV6SubfPMNzVf87Cw9WwnzOkVvP3CMk//Pvjy9oa5YVrx8p4WGSPT8Zsc5f3lNNeIr
         Dulg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679562269;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HkAGxiMm0D6sZZHk+W+42sbwTh2uKjw/ysosEWY5e6A=;
        b=pZ4H0zHgDCq5osBDbHkPpW+tnAnbY/eOfEPEIesn4F5JhpfYfmAVxSGkLTM8t+fPYU
         aTgC4GYUk5iS9S+rSGjb0BWavgATJBtA5JSPJ/jRYQIjSr6zB5af4KG+YAEbN8IVvZ6W
         NKXfat6mK89pFFi4k/E4EsWwt8igSzBvPcWQy7GNqXXga2kRi1tDVD71M5MHZG8uoYMm
         2JxH/Nap1efvNpUk2vyLjTip+oeLdslb/plPtjg+MuSqcCtDHfbRoQC2OKBlbIgzYsiw
         hzRrml+V+qt9m/vPNcIrda7Rx6dT0NYGdWbFElP5KLcSN2WbMzF1pgpZZN7yUzr6WVFi
         RGPA==
X-Gm-Message-State: AO0yUKVgYfmO41RtBVjQaloVGfT0RXKaZVgbapC0F3tExZqjIT/uGN0C
        IXhGG+sU9AqJGzrRXHKnOZQ+R9CvG8zxhQ==
X-Google-Smtp-Source: AK7set8I4cmzf3Zmp2eBlUvhQR6WjHK9/2UFO2PkOCoRYTGxgHw7Kr8EnoEKqizYtcXg8exBT1xv3A==
X-Received: by 2002:a17:902:fa43:b0:1a1:a5df:764 with SMTP id lb3-20020a170902fa4300b001a1a5df0764mr5230531plb.7.1679562269354;
        Thu, 23 Mar 2023 02:04:29 -0700 (PDT)
Received: from ubuntu.localdomain ([117.207.139.205])
        by smtp.gmail.com with ESMTPSA id q8-20020a656848000000b005034a57b963sm11277116pgt.58.2023.03.23.02.04.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 02:04:28 -0700 (PDT)
From:   Sumitra Sharma <sumitraartsy@gmail.com>
To:     outreachy@lists.linux.dev
Cc:     johan@kernel.org, elder@kernel.org, gregkh@linuxfoundation.org,
        greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Sumitra Sharma <sumitraartsy@gmail.com>
Subject: [PATCH 2/3] Staging: greybus: Convert macro struct gb_audio_manager_module to an inline function
Date:   Thu, 23 Mar 2023 02:03:40 -0700
Message-Id: <2a1752d909a33f2a8e93bd60043aaa5a659c98e4.1679558269.git.sumitraartsy@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1679558269.git.sumitraartsy@gmail.com>
References: <cover.1679558269.git.sumitraartsy@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert 'struct gb_audio_manager_module' from a macro to a static
inline function, to make the relevant types apparent in the
definition and to benefit from the type checking performed by
the compiler at call sites.

Signed-off-by: Sumitra Sharma <sumitraartsy@gmail.com>
---
 drivers/staging/greybus/audio_manager_module.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/greybus/audio_manager_module.c b/drivers/staging/greybus/audio_manager_module.c
index 81b4ba607a0e..5f9dcbdbc191 100644
--- a/drivers/staging/greybus/audio_manager_module.c
+++ b/drivers/staging/greybus/audio_manager_module.c
@@ -12,8 +12,11 @@
 
 #define to_gb_audio_module_attr(x)	\
 		container_of(x, struct gb_audio_manager_module_attribute, attr)
-#define to_gb_audio_module(x)		\
-		container_of(x, struct gb_audio_manager_module, kobj)
+
+static inline struct gb_audio_manager_module *to_gb_audio_module(struct kobject *kobj)
+{
+	return container_of(kobj, struct gb_audio_manager_module, kobj);
+}
 
 struct gb_audio_manager_module_attribute {
 	struct attribute attr;
-- 
2.25.1

