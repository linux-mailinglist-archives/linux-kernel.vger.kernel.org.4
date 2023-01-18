Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C00F6710B2
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 03:06:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbjARCGq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 21:06:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbjARCGg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 21:06:36 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CADE42DD3
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 18:06:33 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id bk15so22323008ejb.9
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 18:06:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EJFVta3hfZRXKx31flRwp+6NT2ffWbzRaGmZqjFNr1c=;
        b=iYjiINA+JJ3kTzl1Gteh2w+mbXYZ9cG0fXexodYl+c+HMeAU3ijvCw2l/9A6UII/+W
         zk/r1pm7o/XrXklag/NO61lvSN+4jx5Vrk5yezpWjXvO7SWMRQfS8lM6BocW8giJG4sD
         JfPwWiVAtgoWl8NDfz4a+injNOjlx7/FRmOZUCJ4wJKLZQEAdUMs3n0OYMBPJ7PdcM/h
         NFQOIdvPFVszk9XlGUGxuK9Z4avY+cstBvIGRKohtA9lVmLIhnOyu45FJ5AssCqcxNDx
         FNYTjpSWV5OnvSgUnk56GRe4BQNmpyjtlyndTYZF1QER+2ljc3YFdpbq6dH4Wm88OdQ2
         dRtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EJFVta3hfZRXKx31flRwp+6NT2ffWbzRaGmZqjFNr1c=;
        b=XKol3ysTnsnNZveH16eaMW1pKiOObftyk49NwYN7t5ueyK6JlTKgpHIKEHiGCpc7r3
         Iezm/fzkE1HXrLgYQFvyGjO1j0W4Jif4C/BVcB6nucIA6NoKxqOyYTigwiaBnzbtynmL
         1vDuT8kr9yiulRkIVrqabSEs7QPTgnqxdTtqe7U5OqXF2FOSZEViKrMhQDhw8TpzfSRJ
         wR7MPPn+vW9SPsl4LXMksbU2AU17Z36AT7Jo3nFt7zMtmdJR8Jjq6hKwqFUwz8/5pk2i
         8Xz7QTm6KudfT0NLATNiJGDSx1ln6gAPYnZ9uykVdnZ9X9IJNvAosqOFNnXuVL9IeRbM
         gL8w==
X-Gm-Message-State: AFqh2kqYTMBYsG2q42LeKMn0ZzSQzDs7xDy3kUVdxgbMmYZosdWxIxRw
        qqFVGMXBBCMbd1UxNdpeDGU3M1K3as2+ymfo
X-Google-Smtp-Source: AMrXdXuMQsMdEybEvR86mCX/ybN1G/aZe55D3EdZwtkengkxeDuDvAfBx5UmZHdzFoQbX3i4PvV+WA==
X-Received: by 2002:a17:907:9b06:b0:872:f259:a7ea with SMTP id kn6-20020a1709079b0600b00872f259a7eamr4989597ejc.53.1674007592812;
        Tue, 17 Jan 2023 18:06:32 -0800 (PST)
Received: from eriador.lan (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id kx1-20020a170907774100b0084d368b1628sm12702694ejc.40.2023.01.17.18.06.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 18:06:32 -0800 (PST)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     dianders@chromium.org, Jiasheng Jiang <jiasheng@iscas.ac.cn>
Cc:     robdclark@gmail.com, quic_abhinavk@quicinc.com, sean@poorly.run,
        airlied@gmail.com, daniel@ffwll.ch, marijn.suijten@somainline.org,
        vkoul@kernel.org, marex@denx.de, vladimir.lypak@gmail.com,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] drm/msm/dsi: Drop the redundant fail label
Date:   Wed, 18 Jan 2023 04:06:14 +0200
Message-Id: <167400670539.1683873.12609021672778272128.b4-ty@linaro.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230111011006.6238-1-jiasheng@iscas.ac.cn>
References: <20230111011006.6238-1-jiasheng@iscas.ac.cn>
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


On Wed, 11 Jan 2023 09:10:06 +0800, Jiasheng Jiang wrote:
> Drop the redundant fail label and change the "goto fail" into "return ret"
> since they are the same.
> 
> 

Applied, thanks!

[1/1] drm/msm/dsi: Drop the redundant fail label
      https://gitlab.freedesktop.org/lumag/msm/-/commit/dc57f09acc34

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
