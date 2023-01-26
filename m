Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 024AE67C87D
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 11:25:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237082AbjAZKZp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 05:25:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236992AbjAZKZn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 05:25:43 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73AB41AC
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 02:25:42 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id n7so1263601wrx.5
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 02:25:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h9mbkTJPJgNxRZ4b5KP2ORZT0ooITMMuraelrFYHiEA=;
        b=NmTwRCotAJRtu4RPUODpdooghL0iLWlfSCpKWrcldSXM478/QCyfnuXytbHCtvRA1K
         9ZUbJ6/IySsUm6FObDuvOdzYEbVEbT3iyJlFKrs3xyFwuZwFgM0TiIHKm6YJPcqLRNs8
         xKi8Hr35o/8ITFnMxD5WIXWfnlEBQwh+nhFWBxDvFK1yFXSe7N4MM1tynvocoDyWWAdA
         8UlyiZQ2+xOz9iB4wsYUiM7n8FqOYvnVmEPmTD98aRkoIbOFwWO4uf9/ilfDRnYHc7lt
         5TSXZe/ZL6YfzcDcweIHia4VHQqrK0qKQidfmc0Qm/fTnXs4QStQ/GnR/xMlchNpYdBR
         XuLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h9mbkTJPJgNxRZ4b5KP2ORZT0ooITMMuraelrFYHiEA=;
        b=aR0dsk5ehOq7imILrYXrs4AkbeEprzwcsGKWP8cAWLZ355X82m8T49Di/pkElXmgFq
         UkGGhRKCD/qH6M4TUQQJl6bxa+7xpSXD6o8nOGzRFi2myT9qJ704K2y5yvmqMLCDsaNU
         SngUSWEzzu3uchXGJnvUQSc1hMA2IpW/S8BUbmSUTEqU/KQR5tDRrhsanQyreNxP7FUO
         FdxVOZdl+IJ3J3GkMcYqf2D5i3NZCYg5rqjTSQrqO7MghpxURAs/dq9YH79xGCmFeacK
         qn+7ZiJuYEGRd+4HyAuWmdZjQzjg813XFCtvTtVjB2Hb5hi7mQoRiEiP7NLqZrChey8U
         MK4Q==
X-Gm-Message-State: AO0yUKUmcppnUdb22VSalY/mN7KO9NFwbCI+SEktTrDyhwWi6+gidfgm
        siIxHj0x4UTBSLBbaPyD/85jsCQiSKAltE5a
X-Google-Smtp-Source: AK7set+YiLit3kGDdI6Sv6YQ+BymzvRDcZ0YXW5YWynWAR1pqvzAjRzJBvcr51/JdIRT5U+EaLvf4g==
X-Received: by 2002:adf:e7d2:0:b0:2bf:b33b:fb7c with SMTP id e18-20020adfe7d2000000b002bfb33bfb7cmr7190186wrn.62.1674728740771;
        Thu, 26 Jan 2023 02:25:40 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id t8-20020a5d6908000000b002bc7e5a1171sm886514wru.116.2023.01.26.02.25.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jan 2023 02:25:40 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Antoine Tenart <atenart@kernel.org>,
        Tsahee Zidenberg <tsahee@annapurnalabs.com>,
        linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH] arm64: dts: amazon: drop deprecated serial device_type
Date:   Thu, 26 Jan 2023 11:25:26 +0100
Message-Id: <167472873009.13092.2072285159866642904.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230123151547.369791-1-krzysztof.kozlowski@linaro.org>
References: <20230123151547.369791-1-krzysztof.kozlowski@linaro.org>
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

On Mon, 23 Jan 2023 16:15:47 +0100, Krzysztof Kozlowski wrote:
> The device_type property is deprecated by Devicetree specification and
> bindings do not allow it.
> 
> 

Applied, thanks!

[1/1] arm64: dts: amazon: drop deprecated serial device_type
      https://git.kernel.org/krzk/linux-dt/c/91fef8a860faa1ab4c36ab04a789ab60f8caea56

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
