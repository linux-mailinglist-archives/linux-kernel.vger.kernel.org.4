Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84A4D6921A8
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 16:10:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232488AbjBJPKZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 10:10:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231838AbjBJPKX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 10:10:23 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7F4B39BAE
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 07:10:13 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id f47-20020a05600c492f00b003dc584a7b7eso6495111wmp.3
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 07:10:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pkxmAdiK02tzELJnUVQ6bUxT3BIOcz4ARiJnWJw6KzI=;
        b=oFVNpSPbjEdkphkX77kgV87QLdC4gRA94xD82rLGzjgpsMpJmTCVAJtepe3CF5Cf7N
         8SqbO+wHhzxpVNgXE7XwpnUEH/B1Vq/etBjY5P3XtzA3v0y5y0ZWjPlp3R5pGh9vnGoH
         Xn6GlvitcFlZNH9REWI6uwRfRnKpgD6zhIcioJK/kmSbejGy4JSxMPARo2hMg+dMExr4
         zJCTB25poF2eWNWAUvGYNqjEZSTxdArd39w2qVSNq13PKlA4S6Gv/avIXWuV8VB5Pbcl
         pU3n+p6L3wattcdRlD++nNkTiCa8FgnKWPMKuuMaE+UwV7oTsIK7aTYkcbdxspUZva8K
         Y3rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pkxmAdiK02tzELJnUVQ6bUxT3BIOcz4ARiJnWJw6KzI=;
        b=ffzpuA1OAygHx9DAWBUKw+4FyZ408Qe8Yrddm1JIH+lX19FMd13UZx6bC7gcaUnTB+
         wR+L8+BksdfprTZ5FgKVAs15Y/L2BVydFD//1fQdJJfN7SoZN0ZDQZDkSfRJCc4e91n4
         oi9ohIzBWdGjNNG3E1o7pnu+NBGieHDNCEx9yVptMMMwkAZMiOPMusXX+Y5h7skH5mwQ
         koN9wq+IWNYn9liYdhsSGxB2mzlW92qcTgCZ+XYMskDD9L41Kuz3TMz8qtQH6vC8mv2Z
         89kOrIddj8XfaRuRI+51VhMZQo7m8pvvs3i3/VL7kGHk4t9lPcsNV47ZiB6eF6mxZ5wi
         jQ0w==
X-Gm-Message-State: AO0yUKU00v7dI6xFAvKb0ykF5RuDJcbiQDGka0cnLHaRv7BBJ1pDm/5E
        //At4o8E00j08RbPvj/oyuOhDg==
X-Google-Smtp-Source: AK7set/Omj6SN3dIwSc611qbn7fyr0axOSapaX9ybMqIdUUUPBxKqCXD8lIzj9ZaioiFn/mej4zFXg==
X-Received: by 2002:a05:600c:43d3:b0:3da:1357:4ca2 with SMTP id f19-20020a05600c43d300b003da13574ca2mr14504177wmn.11.1676041812406;
        Fri, 10 Feb 2023 07:10:12 -0800 (PST)
Received: from linaro.org ([2a00:23c5:680a:d01:61c3:70d8:6500:e102])
        by smtp.gmail.com with ESMTPSA id a1-20020a05600c348100b003db0ee277b2sm8587771wmq.5.2023.02.10.07.10.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Feb 2023 07:10:11 -0800 (PST)
From:   Mike Leach <mike.leach@linaro.org>
To:     linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
        linux-kernel@vger.kernel.org
Cc:     mathieu.poirier@linaro.org, suzuki.poulose@arm.com,
        leo.yan@linaro.org, yabinc@google.com,
        Mike Leach <mike.leach@linaro.org>
Subject: [PATCH 0/3] Extend logging on TMC start / stop errors
Date:   Fri, 10 Feb 2023 15:10:05 +0000
Message-Id: <20230210151008.4587-1-mike.leach@linaro.org>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Recent issues with trying to debug TMC timeouts and flush issues shows
a general lack of logging and context around the possible errors

Patchset addresses that.

Signed-off-by: Mike Leach <mike.leach@linaro.org>

Mike Leach (3):
  coresight: Update timeout functions to allow return of test register
    value
  coresight: tmc: Update error logging in tmc common functions
  coresight: etf: etr: Update logging around flush_and_stop() errors

 drivers/hwtracing/coresight/coresight-core.c  | 50 +++++++++++++++----
 .../hwtracing/coresight/coresight-tmc-core.c  | 37 +++++++++++---
 .../hwtracing/coresight/coresight-tmc-etf.c   | 12 +++--
 .../hwtracing/coresight/coresight-tmc-etr.c   |  8 ++-
 drivers/hwtracing/coresight/coresight-tmc.h   |  2 +-
 include/linux/coresight.h                     | 10 +++-
 6 files changed, 93 insertions(+), 26 deletions(-)

-- 
2.17.1

