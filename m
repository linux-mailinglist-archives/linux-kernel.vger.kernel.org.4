Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCD556634EE
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 00:16:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237503AbjAIXQO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 18:16:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237556AbjAIXQJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 18:16:09 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 528A2BC84;
        Mon,  9 Jan 2023 15:16:07 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id d30so10615503lfv.8;
        Mon, 09 Jan 2023 15:16:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TQwDBfqkurhgjNXU0QKC0PjFG76vM9b8TjKB0PaMvXw=;
        b=SqMxWZDzvqcnd4VsGn02ROGADSumLx9BSN8MB31bs3DrTrebdrbk649dIlJYjdQVYI
         Jyit7fGBQBIlayPVkbESvPA5uj2HvBlWpIXz/QLbJaBMJHyk/gqUvz8txxloW3/kg/h4
         8fKFPj/dF5RTTeQUIg3DdaB1Lykoi623x65aXh+oxADVw1V2VLeTyO3F0EsK1OAEpRJ4
         n//iygvdu0aDZMi6Vwz2oguE6dgJY+85pwWO278pxCRVFL97CcTJQWU9+JL5qi3wyYZN
         0QKPRAvwdjkjlglmNCrgQBlGzC4DPggg0NdqqAF2aeYDXgPv05Ztfe7nzrLdWkjmD0Im
         uyNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TQwDBfqkurhgjNXU0QKC0PjFG76vM9b8TjKB0PaMvXw=;
        b=qsEwJIGCD3+2DsWzEK/hWGPUp2YxIL0/WDe2a3JcD7aVfbu/xSaDFGE8BI/AA2NOwy
         Q6V78A5b5hFX0kD8WTvmdLoKBYyrzbGE7C0RQoSLb20VgMbbvJQG2K3wX5+TAXJTYoGR
         dBOwRfnpp4F/Zphx2Ay3uPHyqKIVfspuWHJOzYxvk9QHSFA0XOyIdT+TE1a/LYSZGnf2
         m+97WofgDjPD/xHqxgS3fqfJsTQEH6srkNPpYa0ZhlccxCIJzSYPGMfttOwQ2NIp3Z+Z
         ZhaQ2WXW40lBv1EQqHjETpYYWEFH5dLe2qhLQYhD6V5/jpuB4wiPMZUe4d6XBcGWBMlf
         Zjqw==
X-Gm-Message-State: AFqh2koMxfvxAXOE6/0oa1kjKkWGIwSgddDw65CY7Zg45yosNHzEkg41
        ++qsz157Yhsp2kpdsLnP+0I=
X-Google-Smtp-Source: AMrXdXsxlo89Tk1v8oWLh9mQW/RBULg2GePp3d7816B4+khN0j3h8rEZ3+fD5AU+CLlRhohD3mhCXQ==
X-Received: by 2002:a05:6512:c03:b0:4b5:a4ef:fca3 with SMTP id z3-20020a0565120c0300b004b5a4effca3mr21624685lfu.38.1673306166159;
        Mon, 09 Jan 2023 15:16:06 -0800 (PST)
Received: from localhost (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id s6-20020ac25fe6000000b004b50b4f63b7sm1814075lfg.170.2023.01.09.15.16.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 15:16:05 -0800 (PST)
From:   Dmitry Baryshkov <dbaryshkov@gmail.com>
X-Google-Original-From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Adam Skladowski <a39.skl@gmail.com>
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221231170532.77000-1-a39.skl@gmail.com>
References: <20221231170532.77000-1-a39.skl@gmail.com>
Subject: Re: [PATCH] dt-bindings: msm: dsi-phy-28nm: Document fam-b compatible
Message-Id: <167330408780.609993.10652879591606544377.b4-ty@linaro.org>
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


On Sat, 31 Dec 2022 18:05:32 +0100, Adam Skladowski wrote:
> Document omitted 28nm compatible which will be used on MSM8976 SoC.
> 
> 

Applied, thanks!

[1/1] dt-bindings: msm: dsi-phy-28nm: Document fam-b compatible
      https://gitlab.freedesktop.org/lumag/msm/-/commit/852f489b36aa

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
