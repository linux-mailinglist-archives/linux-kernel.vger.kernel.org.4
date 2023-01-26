Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DC2767C88A
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 11:26:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237144AbjAZK0H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 05:26:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237091AbjAZKZ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 05:25:57 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CCC734022
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 02:25:49 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id t18so1284034wro.1
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 02:25:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PN0gEZ0x/LWaC6fpF22w1ntBxlB65W1f5kQT7OUw554=;
        b=p2dOnMCPjPw1vhiJFX+7EdTXtYe2BuWGHEyKzKjC7asHveAoVNSczD/JBrqMeScIMe
         dlAshtQNV3oD71iSUClpZ1XQzJ27zx7BbgV8ZNe9xcCueMnvNg9W2VToXEVHYx/rK8zO
         WPJbbkTZUtcAIpNIAAE1wQQ5N6dcYEUd5AvEzlWxUdLw/ar7hsd48CZjwLfr6MK7AVQs
         SRLEOm5BxAWIrHi9gtiGkTt88XJ65pNn2bvKn0pYuYLXw6YnZNqO0MZA+nqoCuH1c8BF
         bzPsAbk3Qk9TkhT4wIM3vx4q8/tPOX9Cj+5Hx7gOJAj/2hLLqRtbcHefmiDLFaVgdvsf
         hn/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PN0gEZ0x/LWaC6fpF22w1ntBxlB65W1f5kQT7OUw554=;
        b=FiR+UwfiK8epp7HGq9oTlLRUlivQ9w/J/vZhhXXHGAb7vax7j22EFwqMRLykVuaCgI
         bRoovPVWwd/RA+D/foWIyUAy53XnjvgA4sO8LL81VaB5k1MEL9YYF2npwXKmhQk0GTAw
         mh2VVhOcQ7MvcGHEM4zLp7gj5DCVBlzZtIV5FYDMs983cofv4CqG3WB57cN5moCbCZc/
         V+menU3a149FDuM7kSLKAW1XTMT8EZnsCGkZkyi1PXQhl6Rzh8/MsEI6HJ4/aRZAeBu0
         S+k4wxCK6111QJfwHj7Tz2Z+4KoAPkDEmFSaM5/w8qN3U1AfCjd7N88y5sWLymEcmSzO
         1qKw==
X-Gm-Message-State: AO0yUKVAmNxQKUM6CFZ8NU32IARz5xOHK5vq05F56/wFz8FxgDguGAp2
        UsOp9ZGLof6kfb6GqoPUwG/MGLkl6jyVZW0H
X-Google-Smtp-Source: AK7set8ZBhBLq5obfmqPdJIL6OMbchPVIBIhIYMDYngnoWUTGDCPUimGS4X/PICoWSGsPLAgzi8XAg==
X-Received: by 2002:adf:b351:0:b0:2bf:ae4b:4cbf with SMTP id k17-20020adfb351000000b002bfae4b4cbfmr7965592wrd.55.1674728749208;
        Thu, 26 Jan 2023 02:25:49 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id t8-20020a5d6908000000b002bc7e5a1171sm886514wru.116.2023.01.26.02.25.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jan 2023 02:25:48 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Patrice Chotard <patrice.chotard@foss.st.com>
Subject: Re: [PATCH] ARM: dts: stih418: align OPP table names with DT schema
Date:   Thu, 26 Jan 2023 11:25:33 +0100
Message-Id: <167472873010.13092.4863789176201367439.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230120072110.138627-1-krzysztof.kozlowski@linaro.org>
References: <20230120072110.138627-1-krzysztof.kozlowski@linaro.org>
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

On Fri, 20 Jan 2023 08:21:10 +0100, Krzysztof Kozlowski wrote:
> DT schema expects names of operating points tables to match certain
> pattern:
> 
>   stih418-b2264.dtb: opp_table: $nodename:0: 'opp_table' does not match '^opp-table(-[a-z0-9]+)?$'
> 
> 

Applied, thanks!

[1/1] ARM: dts: stih418: align OPP table names with DT schema
      https://git.kernel.org/krzk/linux-dt/c/d2468138927cc18ac9923146d49e2a5d06377d1d

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
