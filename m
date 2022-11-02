Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61882616E83
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 21:22:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230499AbiKBUWJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 16:22:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbiKBUWB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 16:22:01 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0C9160D9
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 13:21:59 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id k2so7000201qkk.7
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 13:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jKf1AZN1upy0m4CnP97oesJwstbvc2dNJ3YZhCp9WhQ=;
        b=lmwKfTBW+fGXftv+S1bfMULI/HWwwwgxv5tlm2kZavMBnS/dlaNwvFsFBwjmn9Muwk
         wBrbBM9b/CHU3YjQWU76KGo2W/5UqNIRyt9wwT6gTyxAX3Kr5C+faGaN1Olg+o/XE6w6
         N/5cp5yGfkl0hKY/Qi66/Zp1GDnjGxXEYWuzOQdZITwTi/jRwpBmX+SfouD3yRf4egOE
         ja2JrmZtEqzqm31tRh/KWpFbYGWxuPERZc2odMHADR5z8+bH5SnX59W7FBwb7A22zihf
         ZV4HLFnMZkUBlixzNviNqmkRiCFudLbWJPHXGwMxGJDnkkTt7NlytN35TTVe0NfdxklR
         XRfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jKf1AZN1upy0m4CnP97oesJwstbvc2dNJ3YZhCp9WhQ=;
        b=30R4gJoBKaIVWG60dxfYcsMvbnxA+0z4LqJ/J14c1ysXLHAU+XS1h5PuC6M+mPlBp2
         KvBhQWS0uy52mD7K6OyRfcybgHvPSt9KK6mtCiqRSKbPn6gMBxaoRdORKL9V6nmF/5P5
         5xjm+/ldKyQ3z1qrNvcFjn6Bo4LVtML9cQBQrhoSJW15bNeLgYav7ubRo9HgPjBt+ePo
         7xOlCTapH3eMeybdhxUV/JwwR/GayRkmraNih8u5lj8eICZ/0Oz4t3bswlENTgcintZ7
         K2u8hYyCGwdXZU6Gxa3Kp+XukUZIkdSDKd4koS5/RMNhTk4bc/4wLeaMYbL7YFpNSBRO
         TG9g==
X-Gm-Message-State: ACrzQf3TRGckwBgHeHKHwWqe0OfnvofrsxuvW4omODrg4zHTQW94UTdN
        70/yfqNDVhfhYFn+TexwlgiVVA==
X-Google-Smtp-Source: AMsMyM7p7P11WRXHvtNIRgHXbGxhYQCqLZUNUwC7G+DJ3N4mTOWpwIUQl+ih57hdGQeyp7GKoDpgKw==
X-Received: by 2002:a05:620a:164c:b0:6fa:4d1b:787a with SMTP id c12-20020a05620a164c00b006fa4d1b787amr7128409qko.87.1667420519173;
        Wed, 02 Nov 2022 13:21:59 -0700 (PDT)
Received: from krzk-bin.. ([2601:586:5000:570:28d9:4790:bc16:cc93])
        by smtp.gmail.com with ESMTPSA id f11-20020ac8498b000000b00399ad646794sm7119581qtq.41.2022.11.02.13.21.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 13:21:58 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Pierre Gondois <pierre.gondois@arm.com>,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Sriranjani P <sriranjani.p@samsung.com>,
        Shashank Prashar <s.prashar@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Aswani Reddy <aswani.reddy@samsung.com>,
        devicetree@vger.kernel.org, Alim Akhtar <alim.akhtar@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob.Herring@arm.com
Subject: Re: (subset) [PATCH 20/20] arm64: dts: Update cache properties for tesla
Date:   Wed,  2 Nov 2022 16:21:56 -0400
Message-Id: <166742051293.139492.11245653117636211417.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221031092125.533621-1-pierre.gondois@arm.com>
References: <20221031092125.533621-1-pierre.gondois@arm.com>
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

On Mon, 31 Oct 2022 10:21:19 +0100, Pierre Gondois wrote:
> The DeviceTree Specification v0.3 specifies that the cache node
> 'compatible' and 'cache-level' properties are 'required'. Cf.
> s3.8 Multi-level and Shared Cache Nodes
> 
> The recently added init_of_cache_level() function checks
> these properties. Add them if missing.
> 
> [...]

Applied, thanks!

[20/20] arm64: dts: Update cache properties for tesla
        https://git.kernel.org/krzk/linux/c/3f0d4a02c7490f1aa15764ed85dcf0881bf66b9e

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
