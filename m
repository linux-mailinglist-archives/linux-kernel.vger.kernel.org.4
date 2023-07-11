Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7648074F217
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 16:24:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233685AbjGKOYC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 10:24:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233589AbjGKOWm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 10:22:42 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC4392697
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 07:22:19 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2b703a0453fso91008341fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 07:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689085325; x=1691677325;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OV++g5l7T0tRimgh3Jdezm1NyLyIWbATkO5QIhsASFo=;
        b=GOGEgC2ipXyiP3z8IPmu6hx07i1nnE6D8nNnrVDnxnbxtZ00eD2Z4AxKmABjOTqqAA
         XWdJo20QqnwehJwRel3LDfnq7n12b1GXNLh8u65COO29VUqTk/gF3m04MAw7nSvKNAL0
         fC/irLnhTiQG6Swu05WSTLjE4vIJwN4Q61xD5OTqkWBppG31WsujxCFYHedJlaikqAny
         aRJ7PLjY8zchGwRbsqnk6nJ8LMRCVZYijeBuBKwSUhU1NbrR/GUT6TAEOwG07UdxpZZD
         nN/CbN8MIdqJL2+esbOxHqKxFHiUjl6FN4cZeVcTabmq+PTEC11Ly+CeXUxYUQ6hjaR2
         EayQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689085325; x=1691677325;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OV++g5l7T0tRimgh3Jdezm1NyLyIWbATkO5QIhsASFo=;
        b=XJVJ3msq+Ix0ZJmNjLx8Snfe0h6jQFn5BDTierd6mMd8UzbXbUTHYyDphk5B4srEM1
         6/fVBQvXsUqe5AlTqsy3yXZnSbfbxF4uKbdORDyCkHctm+5s6vv2ZP4IhUBJ7/2+YMXf
         FKfaPHuZRHGeoLNOF64qotKxrP6pkpj73UxR+I+HJjNU9uhkx4GxTFmVcnlImvj+SF5s
         tXeIJRtb8MVfUUnURuKHqIGY4I9H7g/kJk8l/ESrn5isxKOYy63Ge4hybodjg7vkRS+c
         CqM9t50gJNeO2liud7nH1WmdaXzr1Di3sRibR0TsUKJLmsvZ3Lyoz4E2J0vfmnxPLuZg
         MN1Q==
X-Gm-Message-State: ABy/qLaoVMxk2D1lJSLThGsNUTgrkdPwGmjWe2+4eIXiMTNQPKEbEIC1
        lpmtDGl/EMlsrYTP/XIiyai11Q==
X-Google-Smtp-Source: APBJJlE5VMnrx88cqkH8qJJRYAzPzrxXbOp0E7ZXLk5iTSk06igrGHB6WXj0hcZsVHc8i8W/u5edgA==
X-Received: by 2002:a2e:700e:0:b0:2b5:97a3:3ba5 with SMTP id l14-20020a2e700e000000b002b597a33ba5mr12518675ljc.10.1689085324766;
        Tue, 11 Jul 2023 07:22:04 -0700 (PDT)
Received: from eriador.lan (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id v9-20020a2e87c9000000b002b6b4424a28sm487934ljj.13.2023.07.11.07.22.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 07:22:04 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Ryan McCann <quic_rmccann@quicinc.com>
Cc:     Rob Clark <robdclark@chromium.org>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, quic_jesszhan@quicinc.com
Subject: Re: [PATCH v5 0/6] Add support to print sub-block registers in dpu hw catalog
Date:   Tue, 11 Jul 2023 17:21:54 +0300
Message-Id: <168908465040.1869384.8490726560198921888.b4-ty@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230622-devcoredump_patch-v5-0-67e8b66c4723@quicinc.com>
References: <20230622-devcoredump_patch-v5-0-67e8b66c4723@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 07 Jul 2023 18:24:39 -0700, Ryan McCann wrote:
> The purpose of this patch series is to add support to print the registers
> of sub-blocks in the DPU hardware catalog and fix the order in which all
> hardware blocks are dumped for a device core dump. This involves:
> 
> 1. Changing data structure from stack to queue to fix the printing order
> of the device core dump.
> 
> [...]

Applied, thanks!

[1/6] drm/msm: Update dev core dump to not print backwards
      https://gitlab.freedesktop.org/lumag/msm/-/commit/beef5b6c4050
[2/6] drm/msm/dpu: Drop unused num argument from relevant macros
      https://gitlab.freedesktop.org/lumag/msm/-/commit/c8c931fb7426
[3/6] drm/msm/dpu: Define names for unnamed sblks
      https://gitlab.freedesktop.org/lumag/msm/-/commit/785150043166
[4/6] drm/msm/dpu: Remove redundant prefix/suffix in name of sub-blocks
      https://gitlab.freedesktop.org/lumag/msm/-/commit/8875840d60a8
[5/6] drm/msm/dpu: Refactor printing of main blocks in device core dump
      https://gitlab.freedesktop.org/lumag/msm/-/commit/f63f29b1d2d5
[6/6] drm/msm/dpu: Update dev core dump to dump registers of sub-blocks
      https://gitlab.freedesktop.org/lumag/msm/-/commit/4183857e5747

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
