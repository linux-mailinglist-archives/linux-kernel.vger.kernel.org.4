Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A8D7663510
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 00:17:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238012AbjAIXRD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 18:17:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237769AbjAIXQS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 18:16:18 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E1F6D12B;
        Mon,  9 Jan 2023 15:16:17 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id f34so15492665lfv.10;
        Mon, 09 Jan 2023 15:16:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CRAyi2n2FSarDTatQAHom6gbymd5CATd4MjDLdYU+WQ=;
        b=b4Uv+CXMXlZtwqrSfCLoi378tjvHb4etfrlxpdyXiDHBq7dB/wgK/wFs2oFjtEpZel
         2uMQIPeZHEicJmOV5pgaZMFP+j+G8HG1c4VW34jTAe5Woj80MxYYnZjTY46Sfn5dnoLU
         TfAts+Yt8I5Xje7dHjt7FbXC49EfH6ifC3otMRvAV5BJyeyEYZnp4H20bJtWyVTkM8+u
         Zbg+o3NNTTyU7OLYnwncMsNfHiKrTnJeOlhGuiz9PctdldrTlfacprZgTKAkhjyHkbM9
         aCir3j8BceK1rPwaamM2iE8F1/vCx+xKyQGtRYcCAeq0cXbG6rx2qR3u/fdxp3jDg/tk
         oTOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CRAyi2n2FSarDTatQAHom6gbymd5CATd4MjDLdYU+WQ=;
        b=yhqH+2U293mGboWMcGo7d5RHKrBu8X5LE7oQwrDA0AYMeQwCkv6CFF/1d8crHOz7bA
         3sy403Q8Ch5prObvajRh0JGC9elOqSifrQE8+4rjccmg3s2D/e9B4DXR4nyRWgh6IQhN
         rY7HxUf+YvEVN8ngLDnBVyTOmOawPL8Gjn9kTw2IGXjLG8AJFsYYl0rPyIM96oZKSYPB
         iourAdG3UDglM8Oe5REpWuh5Td+EaODKJdkQSaoPlFr8nGscGYW2p+9N2po5JOcWdNAu
         rgDenGYmB2cNj3XfYqs1AnRA1IrkGUqw0NpeRY7m5EgKUyoom138CpB5d8Z6qyroAsLd
         0Y6A==
X-Gm-Message-State: AFqh2kpfTtV6Jx35HVbshxjbY4EUnaEWIMf8a75Tc4rPHHa76yIe0yc8
        qQhIH9sZb2B29M4VClMw8YYc3Llu+e1BbA==
X-Google-Smtp-Source: AMrXdXtIwEE5Za8GXe9lgmkNcC7x8cBRABMaPprXpAMFBHNbva3FqyXnd7ZAu+nw15tNw/d530/K9w==
X-Received: by 2002:ac2:43a4:0:b0:4cb:3a60:65cb with SMTP id t4-20020ac243a4000000b004cb3a6065cbmr6861205lfl.6.1673306174920;
        Mon, 09 Jan 2023 15:16:14 -0800 (PST)
Received: from localhost (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id a18-20020a056512201200b004cc59b46f74sm1819042lfb.106.2023.01.09.15.16.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 15:16:14 -0800 (PST)
From:   Dmitry Baryshkov <dbaryshkov@gmail.com>
X-Google-Original-From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     patches@linaro.org, Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Kalyan Thota <quic_kalyant@quicinc.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221107103739.8993-1-konrad.dybcio@linaro.org>
References: <20221107103739.8993-1-konrad.dybcio@linaro.org>
Subject: Re: [PATCH] drm/msm/dpu1: Remove INTF4 IRQ from SDM845 IRQ mask
Message-Id: <167330408784.609993.15717302243167908042.b4-ty@linaro.org>
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


On Mon, 07 Nov 2022 11:37:36 +0100, Konrad Dybcio wrote:
> SDM845 only has INTF0-3 and has no business caring about the INTF4 irq.
> 
> 

Applied, thanks!

[1/1] drm/msm/dpu1: Remove INTF4 IRQ from SDM845 IRQ mask
      https://gitlab.freedesktop.org/lumag/msm/-/commit/a685d27f2201

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
