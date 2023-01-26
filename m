Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CB5467D4D6
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 20:01:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232320AbjAZTBP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 14:01:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230163AbjAZTBL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 14:01:11 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54650222EE
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 11:01:09 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id qx13so7604722ejb.13
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 11:01:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6/hgeihi7ZjGYYdLqZARIRAYjr8aF0qhlO8SOLhtlp8=;
        b=qndTHlbjpfaL6qbJ/TvhR317D4OWWuUDGHqKGvEvJGVZMtUSWBCvv/fbfwkd49hUiQ
         z6tgwBIqOisziUxGn3G5MR0YEe/SQLl4hSZX6ISXXw+aL05DsyTFplYtqN5OZuaXE35N
         m4c+MEHsQ8f9oIrxbnTqQAyHli3m0WXvwjS01o74nplXedX6pgel4YFGDBoeCdZu4Dhr
         J8D23fLhzTjqcWYWMpmofj6GunWPTssTaEjYj3HIjME37A4jcNjGOSOsmlN0Qes+DGoV
         3KLIssWXrBdbaNQgnhUBqmGPzhbt3UKCh5nwIkjyj0SGSRKbjH1dYhN7hg9zsN+4K2HA
         kQyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6/hgeihi7ZjGYYdLqZARIRAYjr8aF0qhlO8SOLhtlp8=;
        b=KPd5aqfUlTakRO61LBcnWCsmelHdh6uoAHPSd5jWvW19jwXXumU5pAVrTpYATwRShw
         Z31XcaGxRDe6qND6HGkrOheHBl0xDc0SSsdZPMjUIoxuHYqW2p1SaZltqPMRFaZrIiny
         RQ24nvJFKGn76pMLjOtg6KSwTkfcfYDcT9YC5iR5LzJE7+mgDhoh9e3PduxsUH8+RLPn
         wO8DlcAKtDwzDoPtCdNz0PNkc82lEVHzwqzo9GqpAGdCJSwrH/Bas/NUS5WosizWUrfK
         rKWjrnjYZZyvHIv7YVkeciTObsxAmZHJqRFMNT9If7q0WGJQsrIflE4iQlyuLL1LQMHg
         V/eg==
X-Gm-Message-State: AFqh2kr5eYidMt16MQh1r+n0KcngsyHUVwh5ebUxuMdEwcBjkGWP0sts
        3/T9eR9pSB/wnhSFBR2vhW67Vw==
X-Google-Smtp-Source: AMrXdXtE8qV5H9Cp8tQfmuHwc9+X5j6HSC+5QPwvvBHlPV3xWsNS21kkvSCJq1otXOROOXqurM207A==
X-Received: by 2002:a17:907:9150:b0:84d:150d:5006 with SMTP id l16-20020a170907915000b0084d150d5006mr34691515ejs.49.1674759667959;
        Thu, 26 Jan 2023 11:01:07 -0800 (PST)
Received: from eriador.unikie.fi ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id o25-20020a1709061b1900b0084d4e9a13cbsm974982ejg.221.2023.01.26.11.01.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jan 2023 11:01:07 -0800 (PST)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc:     robdclark@gmail.com, quic_abhinavk@quicinc.com, sean@poorly.run,
        airlied@gmail.com, daniel@ffwll.ch, robh+dt@kernel.org,
        dianders@chromium.org, david@ixit.cz,
        krzysztof.kozlowski+dt@linaro.org, swboyd@chromium.org,
        konrad.dybcio@somainline.org, agross@kernel.org,
        andersson@kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 0/2] mdss-dsi-ctrl binding and dts fixes
Date:   Thu, 26 Jan 2023 21:00:52 +0200
Message-Id: <167475959094.3954305.603604364773846840.b4-ty@linaro.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230118171621.102694-1-bryan.odonoghue@linaro.org>
References: <20230118171621.102694-1-bryan.odonoghue@linaro.org>
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


On Wed, 18 Jan 2023 17:16:19 +0000, Bryan O'Donoghue wrote:
> V9:
> - Adds Rob's RB to #1
> - Fixes two check splats - Dmitry
> 
> V8:
> - Squash first and last patch to fix bisectability
> 
> [...]

Applied, thanks!

[1/2] dt-bindings: msm: dsi-controller-main: Add compatible strings for every current SoC
      https://gitlab.freedesktop.org/lumag/msm/-/commit/0c0f65c6dd44
[2/2] dt-bindings: msm: dsi-controller-main: Document clocks on a per compatible basis
      https://gitlab.freedesktop.org/lumag/msm/-/commit/d10bdc6ec6ac

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
