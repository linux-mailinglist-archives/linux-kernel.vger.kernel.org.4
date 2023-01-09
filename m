Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D5BB663514
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 00:18:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237938AbjAIXRd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 18:17:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237850AbjAIXQe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 18:16:34 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4351C186BA;
        Mon,  9 Jan 2023 15:16:33 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id d30so10616931lfv.8;
        Mon, 09 Jan 2023 15:16:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XHjEtNVaTqOtCpnB9ZP021rbETT/k+vzPdGSi2OKKbk=;
        b=Dd9JqNQM4cUJM4TBXa5f4xvEAS9VPArJhWLDzOlCPE7UEAKXRhtW7VQ2cmdUTVVk0G
         VYT6hox6yoL2bEvWBJuLKd86+3whBQaa1drVc97qUHLKzbzstPXGjAuZc4d/yr8bot84
         8AUV1Y1SyZQUIbNPmu4uphSh85FxvRSVCB4n9nMbn+kPl2tQRlcVJYezP6JnIzfj59WG
         8+j5WaBqQNdd4LQaJHBA8IYwnngzv4oqLlgOU7s8lB447GnMZEyskOkjNmT64wcSy8WH
         4dHz1sURUjoigqOMejLb7fCuxJLGfbHoeB5SPaB+P+3FljuafV20y+8FvPWBE2bPGwfo
         HKZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XHjEtNVaTqOtCpnB9ZP021rbETT/k+vzPdGSi2OKKbk=;
        b=rSuA0bDS1QZ4QMOhaqfOlZznVe12Xf+pNULmCROKdxLbTphNr/+ZMXSSj3H/9bgdXL
         TlpzMRG675hST3u6flloiZcSH/e0LlQY9bWNciZRhbbAHDjoo+eVgE9IzUW4xSECdpN2
         1od1jxbnFymkFymEvw6wD6f2fJcBb03rIzqXqqqKQaXp7pIozvPxhrFe3sbALCDehaYy
         aOmzKuqiaHGXaYY7RRCTYQrwXAYlgYNUcSGxJaE4jsR1ULWP4O2AL7lROgV9Nyg4dOQ0
         Gfa1YuUA1MPAS3wN2dZXHt6OODlnIi05CVfgpBlKmEzheiw4RqpbtXTw3fGGEXXk5p3z
         dswA==
X-Gm-Message-State: AFqh2krG8RV8miub5K1frOQv8x5DmmB+9IcKuhmjEYGvoIMaYL1eS1Om
        wp8nr6x/wQlpHP890NPsQLM=
X-Google-Smtp-Source: AMrXdXuq/b00HS8PUFGm6yKSVMLWmldR90yzJzqsS17SBf9hSgAklRD7ER40uVXxqYUX1Tv4Bcj7/A==
X-Received: by 2002:a05:6512:25a0:b0:4b5:5dea:85ad with SMTP id bf32-20020a05651225a000b004b55dea85admr18729585lfb.12.1673306192837;
        Mon, 09 Jan 2023 15:16:32 -0800 (PST)
Received: from localhost (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id n2-20020a05651203e200b004bb8a796a6bsm1852983lfq.66.2023.01.09.15.16.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 15:16:32 -0800 (PST)
From:   Dmitry Baryshkov <dbaryshkov@gmail.com>
X-Google-Original-From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     robdclark@gmail.com, quic_abhinavk@quicinc.com, airlied@gmail.com,
        daniel@ffwll.ch, Hui Tang <tanghui20@huawei.com>
Cc:     linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        yusongping@huawei.com
In-Reply-To: <20221119055518.179937-1-tanghui20@huawei.com>
References: <20221119055518.179937-1-tanghui20@huawei.com>
Subject: Re: [PATCH] drm/msm/dpu: check for null return of devm_kzalloc() in dpu_writeback_init()
Message-Id: <167330408783.609993.13860899129914018447.b4-ty@linaro.org>
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


On Sat, 19 Nov 2022 13:55:18 +0800, Hui Tang wrote:
> Because of the possilble failure of devm_kzalloc(), dpu_wb_conn might
> be NULL and will cause null pointer derefrence later.
> 
> Therefore, it might be better to check it and directly return -ENOMEM.
> 
> 

Applied, thanks!

[1/1] drm/msm/dpu: check for null return of devm_kzalloc() in dpu_writeback_init()
      https://gitlab.freedesktop.org/lumag/msm/-/commit/21e9a838f505

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
