Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96BA46634FC
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 00:17:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237804AbjAIXQp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 18:16:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237739AbjAIXQR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 18:16:17 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7462FBE22;
        Mon,  9 Jan 2023 15:16:15 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id m6so15504679lfj.11;
        Mon, 09 Jan 2023 15:16:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IJYCXzCwWlmnquQ5yNkG+nGz0jiVnLUqp4W9MaxrD4s=;
        b=YTI7W3G4y1L5rwesm0WF5z+DsXipiyuGioX3bnzpjRNpUysDgdGM+otXAgEBLyVaY6
         pRsclm0+HmfVrySDdrkWNefV0vsp2ds+8TU7Kf/4Row5Jsc2YYP967SJlts5bM/090BB
         18hHtVNVZPgzuISKTp6plNDiXjsbLtRPduh4gY2DC5mYpHvreu8Ekri0NmfR2ti76yoK
         wD5faO4UmJtaeTQDqGjRT3ojvEpevC9CsZP+Pnunct7wAPNxfhJh73egSgXsnph2DMsx
         NyA7C3vs1UcakHvqXMPnwHgz8hf8l+iPwNA9Nsnz8Y/hdFQF0rJp8L7SayU6JZ066Qlh
         LPKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IJYCXzCwWlmnquQ5yNkG+nGz0jiVnLUqp4W9MaxrD4s=;
        b=vI+7zzCpdZV7sb+szrKSs2QuhRR6ZZpKxO8dVS1GgXBki6m3l2Uchk/8aKqnjDVGlb
         KuNnzKCtS0HW7k+tBJmt0YCEDgycYik2yKy8bmo68Xss5hEtFcvST+1RhfImz7maXOQe
         UFCH+dao2lNRhXEQWDiN/A9YdFumcLIPt8M9CtviGKvfbduzs5K4/U8c6RVy1s17Bf7c
         ohRxD32Gps/kxOTkieGNGRp1wEUt+mPf1F8MwVaK+zP3oDZwP1cUAtH7jIf+aZy3mOHi
         4/0fO2Hwrh5sSfParCptgWAO4LnfORrfl5FCIduga/QFOGqUd0FhnzM2nQBqjfRSYouR
         0P5w==
X-Gm-Message-State: AFqh2kqFFhag8MHPKCq+i9cxckUA9so3JFReo5EBlgAozXvQ1IQAMLAy
        Fru/S6iCz2z/G+in0qOK2r4=
X-Google-Smtp-Source: AMrXdXvXSiOF4gRJTLJ3TV58YDP0SSl7wPd+ZUlMGSvcU+i9HSGuoSykydyjYrIW2CK/p/5AMFd8bg==
X-Received: by 2002:a05:6512:c1c:b0:4a4:68b9:60b0 with SMTP id z28-20020a0565120c1c00b004a468b960b0mr23307701lfu.59.1673306173615;
        Mon, 09 Jan 2023 15:16:13 -0800 (PST)
Received: from localhost (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id d7-20020ac25447000000b004b40c1f1c70sm1837407lfn.212.2023.01.09.15.16.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 15:16:12 -0800 (PST)
From:   Dmitry Baryshkov <dbaryshkov@gmail.com>
X-Google-Original-From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     robdclark@gmail.com, quic_abhinavk@quicinc.com, sean@poorly.run,
        airlied@gmail.com, daniel@ffwll.ch, swboyd@chromium.org,
        quic_khsieh@quicinc.com, johan+linaro@kernel.org,
        Jiasheng Jiang <jiasheng@iscas.ac.cn>
Cc:     linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230106023011.3985-1-jiasheng@iscas.ac.cn>
References: <20230106023011.3985-1-jiasheng@iscas.ac.cn>
Subject: Re: [PATCH] drm/msm/hdmi: Add missing check for alloc_ordered_workqueue
Message-Id: <167330408781.609993.12402793226257634056.b4-ty@linaro.org>
Date:   Tue, 10 Jan 2023 00:41:27 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 06 Jan 2023 10:30:11 +0800, Jiasheng Jiang wrote:
> Add check for the return value of alloc_ordered_workqueue as it may return
> NULL pointer and cause NULL pointer dereference in `hdmi_hdcp.c` and
> `hdmi_hpd.c`.
> 
> 

Applied, thanks!

[1/1] drm/msm/hdmi: Add missing check for alloc_ordered_workqueue
      https://gitlab.freedesktop.org/lumag/msm/-/commit/afe4cb96153a

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
