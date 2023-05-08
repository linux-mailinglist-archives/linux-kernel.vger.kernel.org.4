Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 297F16FA2DC
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 11:02:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233518AbjEHJB5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 05:01:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233613AbjEHJBA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 05:01:00 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 574902269D
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 02:00:39 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-50bd2d7ba74so46614124a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 May 2023 02:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683536417; x=1686128417;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iF+PxD13TGSqnU6lSyQS7ji225exjvT3ubojGrSPdPE=;
        b=CMcjmwi2x/o72L+x7uFsvDgzbCFatcpOt2G8s5R2Wc8OKr0n9z++wvw44KWbqYP6eY
         UsFiqrmPJCUA7bOcgoXE0lN0OrgOYq+0ozuvrYuf7peCQCK5Gy53rGcYUtbF1wC53ecZ
         xvNMUR97OdnDdKRPx4Bo1HnqV5PPOadfvPcyayEfv7I84nmC4iyD35ps1pObIkm0i6mk
         viIrRlIzqpjoRIWp34TKczd+39P9HNk493zHUHKDGE93euAHiig8CBsSQtw1ezRJCt45
         gr+JEOAqAGdXVTtmk86xGWacviyLTv2+P7PenfC8mdjLp1yRwKMPNuOSYVJUo/ZRK/L/
         /A6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683536417; x=1686128417;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iF+PxD13TGSqnU6lSyQS7ji225exjvT3ubojGrSPdPE=;
        b=lGM7Z5/10KnAnPre14g5irM0I4Xp9C/ePzp6U120DGX0ZX/qvCWcREHgzxh7GoDg3X
         PLss7p2HyDymXvnX3PWPb3mgzdkIdt/9h0Hhu8hofjrSIHxtdH/fiayQ6mTg8Mckurji
         pgf1RixaZZrb7jTJ1SWUu52evaZN8Db8iNMFRAltVj+shdvYO7VYO9dse4V3sYl/1Hhd
         r6uUf75HCLUyd1ZUwAZZ8EGzrN/CIL1OGz4T0bHyRdrkBfOBr4duGO4wbb/BUVSKrZ+P
         QOAnEZKst36bwh2jzXOudwsTyFsq+STMNt4RMF09dsW67DbLKzRucqEtJTvgVeOgV86C
         nowQ==
X-Gm-Message-State: AC+VfDyBsF0DdSgMQljDBB+ekIbk/HHf3rcAnMpurWCpLJS9jdjg0JZC
        uDzo9xjinzH8LonDYYBOBjztGQyzz0Dn6g9+MT4Gmw==
X-Google-Smtp-Source: ACHHUZ7ME19G+aaJMBypZm89uEqraVT8Ky1L19j9mIeAOxM98vo/ScfzpTP8TbiQRgQCV7qO4faRew==
X-Received: by 2002:a17:907:a429:b0:94a:8e19:6aba with SMTP id sg41-20020a170907a42900b0094a8e196abamr7454835ejc.21.1683536417560;
        Mon, 08 May 2023 02:00:17 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:50e0:ebdf:b755:b300])
        by smtp.gmail.com with ESMTPSA id jz4-20020a170906bb0400b0094bb4c75695sm4718953ejb.194.2023.05.08.02.00.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 02:00:17 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     zbr@ioremap.net, zuoqilin1@163.com
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-kernel@vger.kernel.org, zuoqilin <zuoqilin@yulong.com>
Subject: Re: [PATCH] wl: Simplify the steps
Date:   Mon,  8 May 2023 10:59:49 +0200
Message-Id: <168353638585.78189.7110378892615296338.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20210618092418.1424-1-zuoqilin1@163.com>
References: <20210618092418.1424-1-zuoqilin1@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 18 Jun 2021 17:24:18 +0800, zuoqilin1@163.com wrote:
> There is no necessary to define variable assignment, return directly.
> 
> 

Applied, thanks!

[1/1] wl: Simplify the steps
      https://git.kernel.org/krzk/linux-w1/c/a8c4dda94115c4079d3aaa35ba238f2376b6aa53

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
