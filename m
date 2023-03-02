Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 346E36A7FF6
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 11:29:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbjCBK3j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 05:29:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbjCBK3i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 05:29:38 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1C3AD536
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 02:29:36 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id r18so16027513wrx.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Mar 2023 02:29:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677752975;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aG0uzlam+VIYSFcSVrtgNaOvUeUxZNJ+qAZWm8ja/DY=;
        b=qiEuzk581mlkYapti1YIm/V0XjlG20KCHFn4YAGJTpbZyclABGs8iQcEU5h1RsXS+v
         ML9MQ9w5SS2nvl1b7/Nd5/hexpweNNUi6QRW0pWlOLEQZCi/nNf9jcL5VsONz7DyOp45
         yIYUSE3vJ+etNZH3HoS98x2JN0Lw9QdLpkdX4TYPwHnN6XZ8e/G9XhSLVx7q7Yzk82LA
         AvAiZRA+FMy20PQwO5QgXWobPHpmexmqiJn54YeshKpniMfrY1UuEF23rwo0SOTmQSVV
         ZMVI/omRyWUAGyUq+cArdaMAtM81zuKUZ570O5+bSmz+Q54/l5sTw1GiryHNKOce5Q7X
         56zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677752975;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aG0uzlam+VIYSFcSVrtgNaOvUeUxZNJ+qAZWm8ja/DY=;
        b=rPSpb5cUiqJBr8W4dJYegsqTSd35m7kcHPqLSjksxCxZbNmWrXNRkxAlSII5YspIoR
         ng34XPZ/6df/pLysjb0xSwCjwHESCCOOGkDgQszrVIzWrar17s8nPgON1jReURx27CpB
         EoT5U4Sch9xVqAOK5UfdWUGS5pRQqs4ajeUNr5JD5+9whqxJW9WBbL39ujaiVtqrEpwx
         XgHXxLjLMVRfN0zxB6K5kHbaUxlZfjuTQkxkaPikSKMEZvVlYX/2ffMr38cdnyiRCgtC
         ibYoN0vjQbn8WjwO+lEKsmAmT+Q0RfdkpvDWshmvSQ8tle1VQ3F8BfNTUOqIq5P/FZ9J
         E8FQ==
X-Gm-Message-State: AO0yUKWiyvNBxL4Aq7T6H7IXaTpOldogylyO+wQ9OiKr/0olI3OoBlNd
        8/ioldASHC1SXPVmUn7vgn5rwVlUseP0cBGMouM=
X-Google-Smtp-Source: AK7set9vEdzBVf4lPIVfbQuTGQ+LT+gsnEcEJwXGUvFZFRmt6hqek/sgmyehiQPAW/KVqZHNXngUpA==
X-Received: by 2002:a5d:4586:0:b0:2c7:1d71:e672 with SMTP id p6-20020a5d4586000000b002c71d71e672mr6879122wrq.7.1677752975373;
        Thu, 02 Mar 2023 02:29:35 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id j14-20020a5d464e000000b002c558869934sm15069137wrs.81.2023.03.02.02.29.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Mar 2023 02:29:34 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Neil Armstrong <neil.armstrong@linaro.org>
Cc:     Daniel Vetter <daniel@ffwll.ch>, dri-devel@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jagan Teki <jagan@amarulasolutions.com>
In-Reply-To: <20230216-topic-drm-panel-upstream-maintainance-v2-1-ffd262b72f16@linaro.org>
References: <20230216-topic-drm-panel-upstream-maintainance-v2-1-ffd262b72f16@linaro.org>
Subject: Re: [PATCH v2] MAINTAINERS: Add myself as maintainer for DRM
 Panels drivers
Message-Id: <167775297427.128880.7902941265688645008.b4-ty@linaro.org>
Date:   Thu, 02 Mar 2023 11:29:34 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 01 Mar 2023 10:47:35 +0100, Neil Armstrong wrote:
> Add myself as co-maintainer for DRM Panel Drivers in order to help
> reviewing and getting new panels drivers merged, and Remove Thierry
> as he suggested since he wasn't active for a while.
> 
> Thanks Thierry for all your work!
> 
> 
> [...]

Thanks, Applied to https://anongit.freedesktop.org/git/drm/drm-misc.git (drm-misc-next-fixes)

[1/1] MAINTAINERS: Add myself as maintainer for DRM Panels drivers
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=4ddeb90d602ac58bcf99924eb34d8b2f820ce11d

-- 
Neil

