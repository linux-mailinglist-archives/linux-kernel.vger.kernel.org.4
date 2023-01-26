Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A55867C87F
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 11:25:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237104AbjAZKZt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 05:25:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237060AbjAZKZo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 05:25:44 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD2EB1AC
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 02:25:43 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id n7so1263716wrx.5
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 02:25:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O0xiT0T4xtX7uB2pkSW3dPxd2vep+tPVszlXRHyCJtQ=;
        b=T7KsCr6mroWif8B6CU7f+lGiinRN4Yv7efveZ1HlCc5M/mVQDnAm1yXWxCiOEauzR+
         3MzpmVLqqAJlnTIjsHBYknyKedpi/wJCnAY3Tq3H4R/RK98JaVsrY7LIRTi8mkjVWaC9
         AI95ru2GjzyMhwAeiYQOfCDbQ/vI7ta3NyXL1gdus8TuRQLL5onubTygSwrE+WluWrym
         AaYHYHr56LNtoX5D7WKmIqayG4Zo8yG6mTHv6hTPSKJX84M65t7lILz4Z+knskBD7K1u
         9qu/sdH2MUGX5RlEercPD54JTGfvT5MpdbOtW9FlEz6VRC2oyJsfRi6uDmxcoQ9txMXg
         K+NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O0xiT0T4xtX7uB2pkSW3dPxd2vep+tPVszlXRHyCJtQ=;
        b=OXYVlvvGfM9PnTycLFkXKUer1Yq90lnoLivC4NEOv3g4cnPhNhisvtcHW94crHGA64
         yTaHY2h6WPK97FOSG0McUU0zZlU7brLmF0YmlwCXpMK2XsNkT+gK0M0cVwAFsBtc5iys
         pA+oKV5LXnsHkpRgs3WpXvkqpE4EwuyZLtZMRwIBQ454YAJHJKCgvqxIN7sIZzJBlmGD
         MnuCtlGKCry64rkM2ZTGgbB0EgvXR+ZyvXJPUxSVaVpG2wQAMkaedH981om3xgwn91GR
         uCEv0cq7rFKLQ6mlH/f09NkNkhP0IC75LIPr0NEPhvZlczhp4UMmoPoNvKzHZHR+ZwND
         8+Uw==
X-Gm-Message-State: AFqh2koSqTa9WDldkXD0F+QuZ3bxUJddeCET3FYVXWhBfk11Ia+Qvzn+
        eCp/16TQg/BHYD65lnqbqBs/QEviJez/GA1t
X-Google-Smtp-Source: AMrXdXsFdJaRBucGrQlOcDTqH2SRBriRqNpii6EYPKLvt40cwsdPWlzhM4kXsIkOb4ZnrjlYJ9u8vA==
X-Received: by 2002:a05:6000:1a8f:b0:2be:3fa7:ab4e with SMTP id f15-20020a0560001a8f00b002be3fa7ab4emr31431567wry.38.1674728743246;
        Thu, 26 Jan 2023 02:25:43 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id t8-20020a5d6908000000b002bc7e5a1171sm886514wru.116.2023.01.26.02.25.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jan 2023 02:25:42 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Antoine Tenart <atenart@kernel.org>,
        Tsahee Zidenberg <tsahee@annapurnalabs.com>,
        linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH] ARM: dts: alpine: align UART node name with bindings
Date:   Thu, 26 Jan 2023 11:25:28 +0100
Message-Id: <167472873009.13092.11827472590137405360.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230123151545.369762-1-krzysztof.kozlowski@linaro.org>
References: <20230123151545.369762-1-krzysztof.kozlowski@linaro.org>
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

On Mon, 23 Jan 2023 16:15:45 +0100, Krzysztof Kozlowski wrote:
> Bindings expect UART/serial node names to be "serial".
> 
> 

Applied, thanks!

[1/1] ARM: dts: alpine: align UART node name with bindings
      https://git.kernel.org/krzk/linux-dt/c/55eecc11eafa3ef307d68dcc3f802ad38aa1be0a

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
