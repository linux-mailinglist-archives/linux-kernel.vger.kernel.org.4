Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27FEF5ED862
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 11:03:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233175AbiI1JD0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 05:03:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233551AbiI1JDH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 05:03:07 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E83EFE05DD
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 02:03:05 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id l12so13598835ljg.9
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 02:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=Qivih7Ox0DdR7xAv+foWHqtTQqdqkALSOgUvdHP21xA=;
        b=MK7CFQ9YcPNocb/BlU8K2dGG0Nrome6kA7nPy0n6rjndVEZaNPV7X8uN9Wbay3cDiF
         2CaEcd90WMbW7h2S/umJ3fIPGAk4bYqI5uctxq/Xlq/PNhbWo5YlGwrYgJOoo3Qp9HnN
         W+QY/AZb3BZuqMNSJ5NP5epnW6LSxvApRh9qFHh7OppqQ7RhvnD47a1m+on2zfJtoQ6u
         pNk50zRulq86ttW1Mwcs93xK+BslCH1L0yAvrh7qjVcddCAxOEr8JyKX5WJaXfYYHm9X
         hq7AFHJcanh+W0Q0JYGbgFH9a1WTP1REgHNldvwm2wwiGDFNrk113OXxiwN00c0O6v2Z
         K7wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=Qivih7Ox0DdR7xAv+foWHqtTQqdqkALSOgUvdHP21xA=;
        b=QLg5wiHuuiGsn+BVjDcQV+IKNlzBiz2n9I0JSSNgtIzZ3RGGOzNeDG/egOav3PU+oM
         bpkdwQGc+mK2WNbmvEyYNeqmo95A2Nmr4j9GbggMOwAc1Ky4A1yICqztbcShrWCVTYRX
         FMmqxx/dBir7JmO1m2IZ1Y6mlegFiUp/cVcDme3W7b9Wbnbt9t4znsTVQgru5NWG7t9y
         JdhxxYrxx6hCEbd0Itj9R5Ko8J4pez1I04c/Ntb+sY8+JrKb1Fdd5/ccL6O7i0Vtgz+h
         P9d4ELXzLGJ9wpfIG1J+jR3xQmSrpzHayLIgRHIQcJHUVNBxEXkGMs+k+IYt4/2QAaq/
         QtLQ==
X-Gm-Message-State: ACrzQf2j/gZkWzpHhIO08H/qB90qlxKtIGFXvS1pPa2BSE/taHQp24nv
        8CAF4x/SbYIW79BuDkIVV764AA==
X-Google-Smtp-Source: AMsMyM6kVPc1yWr8KuUU2EZPmo0ooqebRc+y5zFM1TknSI5X2qRgOQd12MT1RgPccoVXhFpIcchTwQ==
X-Received: by 2002:a2e:9114:0:b0:26b:e3a2:3f89 with SMTP id m20-20020a2e9114000000b0026be3a23f89mr11902830ljg.132.1664355784273;
        Wed, 28 Sep 2022 02:03:04 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id j6-20020a2ea906000000b0026c297a9e11sm377185ljq.133.2022.09.28.02.03.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 02:03:02 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     liushixin2@huawei.com, thierry.reding@gmail.com,
        jonathanh@nvidia.com
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/4] memory: tegra: Use DEFINE_SHOW_ATTRIBUTE to simplify code
Date:   Wed, 28 Sep 2022 11:02:58 +0200
Message-Id: <166435026500.12920.10508016012075575717.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220926130025.1061373-1-liushixin2@huawei.com>
References: <20220926130025.1061373-1-liushixin2@huawei.com>
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

On Mon, 26 Sep 2022 21:00:21 +0800, Liu Shixin wrote:
> Use DEFINE_SHOW_ATTRIBUTE helper macro to simplify the code.
> No functional change.
> 
> v1->v2: remove duplicate blank lines.
> 
> Liu Shixin (4):
>   memory: tegra20-emc: use DEFINE_SHOW_ATTRIBUTE to simplify code
>   memory: tegra30-emc: use DEFINE_SHOW_ATTRIBUTE to simplify code
>   memory: tegra210-emc: use DEFINE_SHOW_ATTRIBUTE to simplify code
>   memory: tegra186-emc: use DEFINE_SHOW_ATTRIBUTE to simplify code
> 
> [...]

Applied, thanks!

[1/4] memory: tegra20-emc: use DEFINE_SHOW_ATTRIBUTE to simplify code
      https://git.kernel.org/krzk/linux-mem-ctrl/c/94a052d7d52a70d8681644bd88062c61b0f986ce
[2/4] memory: tegra30-emc: use DEFINE_SHOW_ATTRIBUTE to simplify code
      https://git.kernel.org/krzk/linux-mem-ctrl/c/91fcc1dfa790d74b9a1dacfefdb023804dedd319
[3/4] memory: tegra210-emc: use DEFINE_SHOW_ATTRIBUTE to simplify code
      https://git.kernel.org/krzk/linux-mem-ctrl/c/82710f9114a7857052f012599fdb688b93ee218c
[4/4] memory: tegra186-emc: use DEFINE_SHOW_ATTRIBUTE to simplify code
      https://git.kernel.org/krzk/linux-mem-ctrl/c/56efd6435c6890a3a38a33d192a0f9d5c835a24b

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
