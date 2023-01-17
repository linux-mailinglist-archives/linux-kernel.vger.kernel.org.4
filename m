Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 265A666DC26
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 12:19:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236304AbjAQLTZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 06:19:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236723AbjAQLSO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 06:18:14 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA0EC34C0D
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 03:18:13 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id d2so10087310wrp.8
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 03:18:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qzKpj6N65RyfEWZaM/311Snl/iRS/oRAMMEJaUx5YSw=;
        b=w4NjWRX2AtBqPYizk+hvep+qNr9EePwIzgjLONWI4zTERxhmzkLwwyQG47T10+ITXR
         j3ViZP81F+rWxpdsELw2Wr5nQnPRZ2m2qAfGYfKmGu2/pCqwTQvNIB6TUr52cL6L/XLQ
         vOpqIisxMxJBk8aJI5/0jPKdUDcVyCgzn67dW+DLIIVgvWETzcDnToVejAcvabZXgalf
         aLaSpjp8PdKy1r5AsCsHPcyiI/N+1lxSQ4lIlfWO7w2uEiHfkCXKdDm0O7nBbB45PRVy
         59A+tzc5l++SGLfKS5QeBVdGO6r3koEIgegNLRq0wqUATOSMx0fY/ZSQI5Hello55Tb5
         sCNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qzKpj6N65RyfEWZaM/311Snl/iRS/oRAMMEJaUx5YSw=;
        b=pkBd1wrXeZttTRhbpSntZKgUhZAq//xmIrHpz9Un+ek9w+9GuFhVp1Bay7kQfQwRct
         9/+Z5zXacpp++3lsZbji6O1p+ZXMPR3al2JmJtGxkyaJOF6A9NjkE+QzCYvQg5PthOoc
         vRJ7GMSs4sxlJFzMsZwBqOnrCoADvdeYj9A1L3LaWOUcu5s1ctrA+nUeWXh0CzJDaByk
         fcek0usKQL2WseooyKlWGVDnl+q8Dm6cXnjWFN9E1gQbnC3zrBvYLQA8nOOmZz+zz8F4
         9xcfIib9uvXwZmy6YYch7USEeTRWQgjlhqmho7UEh0tCmbjfvhXEohd5GmObH3eWi9fM
         6A5Q==
X-Gm-Message-State: AFqh2kqk83CV/uij59oPNVn8DTA0SC8PnFpgxDRQ+hNgY/2BAlUYC+fH
        tdoRblr5cZbxe6+cZmvbRF/gFA==
X-Google-Smtp-Source: AMrXdXvoNzN9Kcj1yCUu+9eKnZ1i5BWtuXWnAzxfExRVNV/2hW7BsH5nnVL4/jyuvP/M7RMFtGmHFg==
X-Received: by 2002:a5d:608d:0:b0:2bb:cc51:7617 with SMTP id w13-20020a5d608d000000b002bbcc517617mr2683557wrt.42.1673954293435;
        Tue, 17 Jan 2023 03:18:13 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id w10-20020a5d404a000000b00275970a85f4sm28466717wrp.74.2023.01.17.03.18.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 03:18:13 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Padmanabhan Rajanbabu <p.rajanbabu@samsung.com>,
        alim.akhtar@samsung.com, rcsekar@samsung.com, robh+dt@kernel.org,
        lgirdwood@gmail.com, s.nawrocki@samsung.com,
        krzysztof.kozlowski+dt@linaro.org, aswani.reddy@samsung.com,
        pankaj.dubey@samsung.com, tiwai@suse.com, broonie@kernel.org,
        perex@perex.cz
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-samsung-soc@vger.kernel.org, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH v4 5/5] arm64: dts: fsd: Add sound card node for Tesla FSD
Date:   Tue, 17 Jan 2023 12:18:03 +0100
Message-Id: <167395418605.64421.16134681081396817546.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230116103823.90757-6-p.rajanbabu@samsung.com>
References: <20230116103823.90757-1-p.rajanbabu@samsung.com> <CGME20230116103912epcas5p2ae807f1b6435e103a6527332e42f03a2@epcas5p2.samsung.com> <20230116103823.90757-6-p.rajanbabu@samsung.com>
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

On Mon, 16 Jan 2023 16:08:23 +0530, Padmanabhan Rajanbabu wrote:
> Add device tree node support for sound card on Tesla FSD platform
> 
> 

Applied, thanks!

[5/5] arm64: dts: fsd: Add sound card node for Tesla FSD
      https://git.kernel.org/krzk/linux/c/56a14f01a54568e049e22c46ffc654602bbd01d1

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
