Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CD2662C579
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 17:54:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234356AbiKPQyH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 11:54:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234599AbiKPQxf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 11:53:35 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9ACC1172
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 08:51:52 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id ud5so45605074ejc.4
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 08:51:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NvbONARSsIDwCwSEYkMMo3k5hneuUpgwVcRn4D9nR5g=;
        b=ciFME/0QGrxCsZv8RfK4lRHAp9GK4NlACjARkh4aKKI1x0jFQaIdqYgQ6/x20tKuul
         3NHLAuroG6YC3hCdeWpMMIcts9K7avaIFFv8x/nCfHkGnnLsCJ2LP/69YQJTqSMPOwLV
         bf13ujJuuX4J2w9Gw7MzG+DziM5T5Jr2z0eEs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NvbONARSsIDwCwSEYkMMo3k5hneuUpgwVcRn4D9nR5g=;
        b=XqCxTyaVCeji780G+1BtcUGP934b4Jk2q7qJ3BKjqW9mIsjkMAW+/5UyGADdqw5DhJ
         HxDyXNcUc/MDiNq2dN+IfZCJvhQBeGiND6OBnv4R0m3Xr9owiINHG5DArmsJDFFMK1JG
         uAOq61A48e2PTDvkCytVNkL7gNvX3dPzod1U8UhIVUUbo6EmWO77iIVTlEtt3kiCN4PM
         c6x0RoGa4jk/qbbzvXMaIXsN9C9aDyPLpiAbw7XabyDe7TVql0Pm1TK3O6/2PEI+h87F
         IWDiyGX/Es/rNuqlFmG1gSC7lL/ZlU1dRclB0QIraeN2MPRJzBxrypJktiKA58q6vZYM
         vv+g==
X-Gm-Message-State: ANoB5pkV0IkM8bsh2aZOl4ePUZCEF4gNFeNbVbcH9+qo6N4j1W2dQsUs
        Wu30Unp2PW/UUGwy9OSt9DrBMwKDEma4OMp6
X-Google-Smtp-Source: AA0mqf4Bw8nw8n1HooeSBCjX6J6DyDddKuc56g3OVBpVk/T7PpKJfA5L5vRui4alxqO6eBuh/aQ1Ng==
X-Received: by 2002:a17:907:8b0d:b0:78d:857d:b4a8 with SMTP id sz13-20020a1709078b0d00b0078d857db4a8mr17435356ejc.495.1668617511012;
        Wed, 16 Nov 2022 08:51:51 -0800 (PST)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com. [209.85.128.51])
        by smtp.gmail.com with ESMTPSA id jz22-20020a17090775f600b0073dc4385d3bsm7045645ejc.105.2022.11.16.08.51.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Nov 2022 08:51:45 -0800 (PST)
Received: by mail-wm1-f51.google.com with SMTP id 5so12329942wmo.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 08:51:41 -0800 (PST)
X-Received: by 2002:a05:600c:4148:b0:3cf:7716:8954 with SMTP id
 h8-20020a05600c414800b003cf77168954mr2774825wmm.57.1668617501480; Wed, 16 Nov
 2022 08:51:41 -0800 (PST)
MIME-Version: 1.0
References: <1668591184-21099-1-git-send-email-quic_srivasam@quicinc.com>
In-Reply-To: <1668591184-21099-1-git-send-email-quic_srivasam@quicinc.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 16 Nov 2022 08:51:29 -0800
X-Gmail-Original-Message-ID: <CAD=FV=Uzky4uxs+qwSH9d7MBBWbXe8sMdvB_-Lqkq+6jbTCciQ@mail.gmail.com>
Message-ID: <CAD=FV=Uzky4uxs+qwSH9d7MBBWbXe8sMdvB_-Lqkq+6jbTCciQ@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: dts: qcom: sc7280: Remove unused sleep pin
 control nodes
To:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Cc:     vkoul@kernel.org, agross@kernel.org, andersson@kernel.org,
        robh+dt@kernel.org, broonie@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_rohkumar@quicinc.com, srinivas.kandagatla@linaro.org,
        swboyd@chromium.org, judyhsiao@chromium.org,
        alsa-devel@alsa-project.org, quic_rjendra@quicinc.com,
        konrad.dybcio@somainline.org, mka@chromium.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Nov 16, 2022 at 1:33 AM Srinivasa Rao Mandadapu
<quic_srivasam@quicinc.com> wrote:
>
> Remove unused and redundant sleep pin control entries as they are
> not referenced anywhere in sc7280 based platform's device tree variants.
>
> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
> ---
> Chnges Since v1:
>     -- Update subject prefixes and commit message.
>
>  .../qcom/sc7280-herobrine-audio-rt5682-3mic.dtsi   |  8 -----
>  .../dts/qcom/sc7280-herobrine-audio-wcd9385.dtsi   | 20 -----------
>  arch/arm64/boot/dts/qcom/sc7280-idp.dtsi           | 20 -----------
>  arch/arm64/boot/dts/qcom/sc7280.dtsi               | 40 ----------------------
>  4 files changed, 88 deletions(-)

Reported-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
