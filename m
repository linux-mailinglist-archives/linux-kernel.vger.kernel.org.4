Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E953167D4E5
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 20:01:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232351AbjAZTB3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 14:01:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232353AbjAZTBZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 14:01:25 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF83E6184F
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 11:01:19 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id hw16so7622479ejc.10
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 11:01:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bTeKhYCgAYLn9b2pOWJlFiilL2KqGbxWtCO1YZ9/UkM=;
        b=Zq2IUYVCIk2ZkmKL8yTQ9rD/RcF7gQkTdEVyT/G8FqICTK1KKopxh3D9QABs16DCb/
         nnJEx7GPNlXadntyWwRU3iU7tGl4GKtw+JiS3zk4w5HI89y/f0oZEw6PNbJFEKuZISbn
         zT/m7gWdk3qZScZl88I9FMrgp1U8MqLgL+mfZjYjHDOOQf+IPVynotCJzf+6QlMdxp4K
         53odFHDtAn4mrs6R2dRyBsEQPlY0PTrn/6ws/vrXuvumBXXHW6dH2nd/1dXBDAM4lOAQ
         t1Qg83AcSL0v08OfFO+rcilwdDuCa6gqFpPC8LmX5Yl1XKk3ihClp4EcOMrWAfC4Pe7K
         0Idw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bTeKhYCgAYLn9b2pOWJlFiilL2KqGbxWtCO1YZ9/UkM=;
        b=kBVlIjlscMygm8/KP6p607Flj1Yo+5Xx+0qwLpv9LBOLi4zKzFp6bI5pvAtDgiOijO
         3/9nX+imoY8ApqcSMAvhvaE3u1LV9CYKjLXcHv7nGE1CDlFkWNqdgUDqxPhuv/g7ZlCa
         eXpKxgu2gqoz/tomSRz/ZQwOIAnzUSO79+hUJqSel3AEnZTxLV/kBvFcx70YiBEyCLPQ
         wAFL+gAbDbfkTmeUBdPOdTzJHH9W4sm4ADXI44DGrWNOpAhfPg78I6UrNyGsC3omqTJn
         744zEiDOcK/tYA92lSLgoq0Bk7jmyZc89tffuVu4rI0wCn3C1KqK6sy4aEepkWh5zqWU
         IkqA==
X-Gm-Message-State: AFqh2kpA9zukxaScarDfm0OyLCeLoa6qZnnJlhX2O1nGbQmij0To8cTc
        RQIS69VDP0BjAcKLT9VBf/NOAw==
X-Google-Smtp-Source: AMrXdXu/ugKU0aSJjN4CCNX12KjO9+Qm06X/CVkhbq7Os4veQCxLQBwbP5hQm2BV5NQe5Nn4RpOaIg==
X-Received: by 2002:a17:907:8d18:b0:7c0:d6b6:1ee9 with SMTP id tc24-20020a1709078d1800b007c0d6b61ee9mr43109147ejc.11.1674759679427;
        Thu, 26 Jan 2023 11:01:19 -0800 (PST)
Received: from eriador.unikie.fi ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id o25-20020a1709061b1900b0084d4e9a13cbsm974982ejg.221.2023.01.26.11.01.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jan 2023 11:01:18 -0800 (PST)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     robdclark@gmail.com, quic_abhinavk@quicinc.com, sean@poorly.run,
        airlied@gmail.com, daniel@ffwll.ch, quic_jesszhan@quicinc.com,
        ville.syrjala@linux.intel.com, yang.lee@linux.alibaba.com,
        Jiasheng Jiang <jiasheng@iscas.ac.cn>
Cc:     linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/msm/dpu: Add check for cstate
Date:   Thu, 26 Jan 2023 21:01:02 +0200
Message-Id: <167475959090.3954305.6194600813887477862.b4-ty@linaro.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20221206080517.43786-1-jiasheng@iscas.ac.cn>
References: <20221206080517.43786-1-jiasheng@iscas.ac.cn>
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


On Tue, 06 Dec 2022 16:05:17 +0800, Jiasheng Jiang wrote:
> As kzalloc may fail and return NULL pointer,
> it should be better to check cstate
> in order to avoid the NULL pointer dereference
> in __drm_atomic_helper_crtc_reset.
> 
> 

Applied, thanks!

[1/1] drm/msm/dpu: Add check for cstate
      https://gitlab.freedesktop.org/lumag/msm/-/commit/c96988b7d993

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
