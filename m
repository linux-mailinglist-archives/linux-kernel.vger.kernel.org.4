Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D13D6710B8
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 03:06:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229792AbjARCGt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 21:06:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbjARCGi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 21:06:38 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8932F470A4
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 18:06:35 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id qx13so21451475ejb.13
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 18:06:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ccs2uNmfL4XWxTk6Uww2FXDm1/IOKWoamNzZVTFZBqg=;
        b=q0tgw2Z3ChWeUnJns+bg5UgV2wpIPe+4eymySGOiHe2x8bWtkliFGdMYtXQaWkZswx
         S3EMetxLLkpwji26+bXSC2li2MMmLZhSH9wmSbHRXNqEok04ZvgGq+CvARGESzELQUXx
         U3oU4cYAXc3PUHbIMsQJIdkyb2+EkKaBW20XfCBmjJSJUcCqXq3GJl27GlKFBfe7Nte2
         njxKegVK7aDJrdvorZauNZ2IZfj1Om09bcscX3FtlzAoQhsrv7Qm1PR/CEifaH5ytcee
         It51XGWjj2V689CLcxbjyPHfvozsVm0TqPha4rthQO0rrmbiEmxnmt0KR+U/z5DdaryE
         +2UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ccs2uNmfL4XWxTk6Uww2FXDm1/IOKWoamNzZVTFZBqg=;
        b=LV1MoUK/369adDiF81aK1wDB2/vvz2hj5CGAzBSE49d4P00qgo9opkIRTuByKwB6xR
         Yb6eFhiNV2JVmQhYgtM3GkAVKHHr8dsji0wlIoAQpzLOgOxCykAnnrrpf1SVU0EKwWzn
         R99qtLw9G3if1+kaan28OJRj6kMuiMH971NxSLqa5awHRwSvKWLoIWSEt20VfdVLc7fD
         GWkGHeKMAA16TD5I67YdZqZZEvV+LdOY1OEQtBW2w+s7OJieRkhuUIn/EOXD/VM9fZX2
         QjnpH76lmtz9cwTc8U5pzCqTixGU8SGivy7QiY4H7mSHWbmSwS9R7KSSy0E2rf3NO1tl
         jcwg==
X-Gm-Message-State: AFqh2kpvD9qrByyM094P12Vf5zzRnYIbFuKeznStYmTw+gSLShoJFslh
        f6sA9pNOJzhdHbn7kYguhup6tg==
X-Google-Smtp-Source: AMrXdXsS/dgY9e1GCBLOxP9hWlAxvr+wHa+R2wVZqHJzPgT5Z0EN6+R2fGy0/ziBt9AZuquxi3TPDA==
X-Received: by 2002:a17:907:86a5:b0:870:d4f3:61b3 with SMTP id qa37-20020a17090786a500b00870d4f361b3mr6574435ejc.12.1674007594143;
        Tue, 17 Jan 2023 18:06:34 -0800 (PST)
Received: from eriador.lan (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id kx1-20020a170907774100b0084d368b1628sm12702694ejc.40.2023.01.17.18.06.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 18:06:33 -0800 (PST)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     d-gole@ti.com, Jiasheng Jiang <jiasheng@iscas.ac.cn>
Cc:     robdclark@gmail.com, quic_abhinavk@quicinc.com, sean@poorly.run,
        airlied@gmail.com, daniel@ffwll.ch, marijn.suijten@somainline.org,
        vkoul@kernel.org, dianders@chromium.org, marex@denx.de,
        vladimir.lypak@gmail.com, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] drm/msm/dsi: Add missing check for alloc_ordered_workqueue
Date:   Wed, 18 Jan 2023 04:06:15 +0200
Message-Id: <167400670539.1683873.10074210279726951946.b4-ty@linaro.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230110021651.12770-1-jiasheng@iscas.ac.cn>
References: <20230110021651.12770-1-jiasheng@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 10 Jan 2023 10:16:51 +0800, Jiasheng Jiang wrote:
> Add check for the return value of alloc_ordered_workqueue as it may return
> NULL pointer and cause NULL pointer dereference.
> 
> 

Applied, thanks!

[1/1] drm/msm/dsi: Add missing check for alloc_ordered_workqueue
      https://gitlab.freedesktop.org/lumag/msm/-/commit/e5237cd6ad68

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
