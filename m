Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F85974D30B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 12:12:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233318AbjGJKLz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 06:11:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232996AbjGJKLe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 06:11:34 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B96A21FE0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 03:09:11 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-51d885b0256so5991068a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 03:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688983750; x=1691575750;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WMFmMb5xmqU7B8PmUEZWQT2VR2ztpUvAEDART/yjKt0=;
        b=D5tf7sEBgJakSo8czm1YteIIM00VpOyOlRKeWJ0qY6YX3dRHkWKtRVnbl4MVms39DT
         7y/Chl6dfnkbJIGQVgsq86ovJGeOxtxkAfY9BvOQzQRPY1QxVYhHw0XEtmK07DmTZZ6y
         kgB+Lp5MNn6cxSsfN8sWgJkJSWqGqp+wOBmJt6IjmRP4CORx51e97XD+EQGwytIlHBr5
         ilf4EOh4S6WFKSvA16kZK2eDLyiGV6tgIyyXGi8NLEP1pizYotc+BvfpW4mSNdshtw2i
         zIZANUpYA1VAAh5tfFVmII+rpvVUPoLJC3fXI/E1antxwqPpLGFp+A5Gt7DR4/QeESMh
         1XPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688983750; x=1691575750;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WMFmMb5xmqU7B8PmUEZWQT2VR2ztpUvAEDART/yjKt0=;
        b=kwgnCYS6XP4Uwje0ELNAVhpsTa849XbbPd3hVQqbroMnuRfpmSBc4z5TmEiBLpmitm
         kPKIbvl84mNX3KO7QIwlj67sUKOl+5gxPmGu5xyS+96R3B1jUOrfwJEPMnqZIoZP2t2R
         uipEpCsRzGUmV+27EzjuUkrHBPt/tFqkaA3J1hgk2Vl6FrN7mvloL8xG4EeK2H88G9Y8
         AQxG7F2izj21+2LYGjZLzcxZXj1xmXgvHefHGYO2VH/nwIoyGm/gnEmBnmlUVeAib1IT
         39z9RZCn2uu0KVM/ey4KJi0aePhAUKaM34JPEEjfTj1Pci4LZ4SLrSSIVLiCQMZ3zX8s
         KIbQ==
X-Gm-Message-State: ABy/qLadFhF0mPYxRdafIBWQDHm23hAkZmRhKPiRVKYQXilmPB6vFPWB
        lM1VqK8/nbpWpCfERzLfkQ+lMQ==
X-Google-Smtp-Source: APBJJlHyHcQKZY24TNFbCFwhQ1nTZbGoHkQIzZ75KUYgGZCoQl6kmwcWOyE+ZdBsl9n0h7ZxoNbTPA==
X-Received: by 2002:aa7:d453:0:b0:51e:f83:6de6 with SMTP id q19-20020aa7d453000000b0051e0f836de6mr11437239edr.16.1688983750378;
        Mon, 10 Jul 2023 03:09:10 -0700 (PDT)
Received: from krzk-bin.. ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id c7-20020aa7d607000000b0050488d1d376sm5649645edr.0.2023.07.10.03.09.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 03:09:09 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Jon Hunter <jonathanh@nvidia.com>,
        Sumit Gupta <sumitg@nvidia.com>, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] memory: tegra: Add dummy implementation on Tegra194
Date:   Mon, 10 Jul 2023 12:09:08 +0200
Message-Id: <168898373734.31330.13078070401058102283.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230629160132.768940-1-thierry.reding@gmail.com>
References: <20230629160132.768940-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 29 Jun 2023 18:01:32 +0200, Thierry Reding wrote:
> With the introduction of commit 9365bf006f53 ("PCI: tegra194: Add
> interconnect support in Tegra234"), the PCI driver on Tegra194 and later
> requires an interconnect provider. However, a provider is currently only
> exposed on Tegra234 and this causes PCI on Tegra194 to defer probe
> indefinitely.
> 
> Fix this by adding a dummy implementation on Tegra194. This allows nodes
> to be provided to interconnect consumers, but doesn't do any bandwidth
> accounting or frequency scaling.
> 
> [...]

Applied, thanks!

[1/1] memory: tegra: Add dummy implementation on Tegra194
      https://git.kernel.org/krzk/linux-mem-ctrl/c/d1478aea649e739a0a0e4890cd8b049ae5d08c13

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
