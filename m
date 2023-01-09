Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 583876635CB
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 00:45:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238015AbjAIXpB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 18:45:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237745AbjAIXoP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 18:44:15 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BD0E3F473
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 15:44:12 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id m6so15588913lfj.11
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 15:44:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TfEuuSwlBNCNhQ0V5aSlOKkpq1jL3HZF0gUtECm9ca4=;
        b=CabRoexvIHthMAjN9bOtYlrmiWIq4jOS4ECtS7o8jrMEW271dUEDGI7aD/YT+S1FL6
         GirrB+S8Ep775bg6drn7B5KgTSlZB4MBCIdhLQPkVpfqyzpi7q3J8Ff755AeIUW77o2A
         BnGA5Jwe3maS4Xo+J7FvcOAyNQgtBBXaIe2oybrNKVTDwgVR0erqPWVop3XmKkhf0PoV
         EDxqFX+0O1GIY1ZliEFP4Y3XQKm7G+l62ITYgdxyZT1NksiADTO/0nmkb+UCZx/SVBMc
         lOwbVd5zfa9q2CLpig0vHIwB7xXh9y0ZHMo+L6Rgm7TgohwwPzTB+kdemhJISUGoKVDH
         zMjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TfEuuSwlBNCNhQ0V5aSlOKkpq1jL3HZF0gUtECm9ca4=;
        b=ImxDXlLbUe6mCW++R/0nY/DC2ICAI9OsDMMjTN/w6P4MezGZGoXMp0NUOZayfmDujn
         z/Ry9bN0ZXWCB5Av1zbDY/kzz1w7Rgt2MDb4eGqM3/c6H/prknxFIepAlpdLtGcaJRMB
         EJGi+BbgrGR7pl86KEhFvcc4YtDm/A4oZ1b4xLguslQqu2K0MR69UAUa5MMrtSnfhsvd
         osSYB7Kyaf5w0mfoY+t4giP4Xs+gclVduQzb4qIxlAb9NnSkUo5gNd00vAYseNvYKVDW
         aHCUvciz1lfPcO80QliOsnZICMIXkOIzioWtsg9abKECPpxHSqxz470aW9KdbwcHeR9f
         5HNg==
X-Gm-Message-State: AFqh2koRaychKHtkN9GPDDiZAhdl52h3iMa7TDmni2Y5F78z/f19Ai0W
        ZFwoFfTihZuvn7rW0lqz1bvqBg==
X-Google-Smtp-Source: AMrXdXs0iF/miKI7qLAgrJfIAHY3483zTUbToR93HVGlxwSfxKxWogktXNquQxEzEQSx+CYsFnWgfg==
X-Received: by 2002:ac2:495b:0:b0:4b5:6755:4226 with SMTP id o27-20020ac2495b000000b004b567554226mr17831489lfi.55.1673307850418;
        Mon, 09 Jan 2023 15:44:10 -0800 (PST)
Received: from eriador.lan (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id s9-20020a056512214900b004b5a4cf69dfsm1835255lfr.261.2023.01.09.15.44.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 15:44:10 -0800 (PST)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Bjorn Andersson <quic_bjorande@quicinc.com>
Cc:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Kalyan Thota <quic_kalyant@quicinc.com>,
        Jessica Zhang <quic_jesszhan@quicinc.com>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Johan Hovold <johan+linaro@kernel.org>,
        Sankeerth Billakanti <quic_sbillaka@quicinc.com>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 00/12] drm/msm: Add SC8280XP support
Date:   Tue, 10 Jan 2023 01:43:55 +0200
Message-Id: <167330408782.609993.5872563380257036199.b4-ty@linaro.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20221207220012.16529-1-quic_bjorande@quicinc.com>
References: <20221207220012.16529-1-quic_bjorande@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 07 Dec 2022 14:00:00 -0800, Bjorn Andersson wrote:
> This introduces support for the SC8280XP platform in the MDSS, DPU and
> DP driver. It reworks the HDP handling in the DP driver to support
> external HPD sources - such as the dp-connector, or USB Type-C altmode.
> 
> It then introduces the display clock controllers, mdss, dpu and
> displayport controllers and link everything together, for both the MDSS
> instances on the platform, and lastly enables EDP on the compute
> reference device and 6 of the MiniDP outputs on the automotive
> development platform.
> 
> [...]

Applied, thanks!

[01/12] dt-bindings: display/msm: Add binding for SC8280XP MDSS
        https://gitlab.freedesktop.org/lumag/msm/-/commit/9ae2a57bdf9a
[02/12] drm/msm/dpu: Introduce SC8280XP
        https://gitlab.freedesktop.org/lumag/msm/-/commit/f0a1bdf64dd7
[03/12] drm/msm: Introduce SC8280XP MDSS
        https://gitlab.freedesktop.org/lumag/msm/-/commit/39bcdb416fb6
[04/12] dt-bindings: msm/dp: Add SDM845 and SC8280XP compatibles
        https://gitlab.freedesktop.org/lumag/msm/-/commit/b6f8c4debc00
[05/12] drm/msm/dp: Stop using DP id as index in desc
        https://gitlab.freedesktop.org/lumag/msm/-/commit/5d417b401146
[06/12] drm/msm/dp: Add DP and EDP compatibles for SC8280XP
        https://gitlab.freedesktop.org/lumag/msm/-/commit/5bd69fd16198
[07/12] drm/msm/dp: Add SDM845 DisplayPort instance
        https://gitlab.freedesktop.org/lumag/msm/-/commit/fa33f2aa9674
[08/12] drm/msm/dp: Rely on hpd_enable/disable callbacks
        https://gitlab.freedesktop.org/lumag/msm/-/commit/cd198caddea7
[09/12] drm/msm/dp: Implement hpd_notify()
        https://gitlab.freedesktop.org/lumag/msm/-/commit/542b37efc20e

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
