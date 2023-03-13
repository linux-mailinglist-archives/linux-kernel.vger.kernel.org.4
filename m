Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 972646B6FAD
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 07:54:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbjCMGy3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 02:54:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjCMGy0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 02:54:26 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 083AD212BE
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 23:54:26 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id er25so16272847edb.5
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 23:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678690464;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bIoV2xJYDTbb1UalWQULGuAdymYZ3w9nAI3fZAHW7M8=;
        b=xNv5XLBlsJJ275Vl4Xrc1CcHCMuMk3XEs1ECiW2OD+maR6+cK6D9l9jCujEjN5+fuo
         67zYEuKts59bpYMmE7mpY2/+MonQlZ2h3gssUVbv0BAZlsYglnSk5KmEuQkly2Ih4oTV
         f45djX1Tzmv1ssh82oWvdqAG/i3YMWOX8OUPBIvQwhN8+pqqz/cHIi4MGUbcnc5mUuKX
         IZiJetxa1jtdvyx/CMaNM64uCuC0seNDxhzFFsrfXnXfw4tYNeQ5+XqDsn4aQY+YcuIK
         cNJLUbHAWqW3464rvCk8uMifTunjNUckf/XJogwmFPkLBSrQGQ3hJoMUAorWa6fIJc/+
         GVkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678690464;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bIoV2xJYDTbb1UalWQULGuAdymYZ3w9nAI3fZAHW7M8=;
        b=ymGfJnpCdIlbg87SkmbP/2ErlHLZuRj/D314fFUPPGg5kD36ymxpUr20ZLjdSO88TO
         VYxYFInmF7SUiyD1FVcA4aSmUMz92xm1uKKqPX0ScmVz8bAEY0dAG26n1xob3op8dLPR
         gicperfYzj82BZUHJZJV2KPM1mpJdeIQ0Lhao3VJgztQSyVOuVuFPN30BsV2nziAXZ94
         fGzP4p/ZuV6OUuNNgahm3eFS+4I7wmTOgAJa+n4Jvyb64rPLBZxE/Tx7/AkIO7MOeMAz
         pxk+5YVW/OaTQsyVt/IXV/Vg2sjUpnl5Ys2WT1CT/4nJv6v0eDLHn6he/RzA1+fWCIsk
         nN3w==
X-Gm-Message-State: AO0yUKXx8oxQNZFA78us93KBNqvr6HFRxaic7TRm53wZwqpYTjWqwxUT
        RvHsgKUv9ZR8Auk+btGWUM+7Ng==
X-Google-Smtp-Source: AK7set9DrtbET7TFieqMAgqh8MbJhCKsjonWr80cpjQtC72vcZfz/WSER140svYpDzrzq6czCQrFlw==
X-Received: by 2002:a50:ed97:0:b0:4fa:ad62:b1a0 with SMTP id h23-20020a50ed97000000b004faad62b1a0mr5379721edr.41.1678690464557;
        Sun, 12 Mar 2023 23:54:24 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:f052:f15:3f90:fcb3])
        by smtp.gmail.com with ESMTPSA id i25-20020a508719000000b004fce9ff4830sm364508edb.88.2023.03.12.23.54.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Mar 2023 23:54:24 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Rob Herring <robh@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] memory: atmel-ebi: Use of_property_present() for testing DT property presence
Date:   Mon, 13 Mar 2023 07:54:22 +0100
Message-Id: <167869045873.7821.6259088320363219902.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230310144711.1543295-1-robh@kernel.org>
References: <20230310144711.1543295-1-robh@kernel.org>
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

On Fri, 10 Mar 2023 08:47:11 -0600, Rob Herring wrote:
> It is preferred to use typed property access functions (i.e.
> of_property_read_<type> functions) rather than low-level
> of_get_property/of_find_property functions for reading properties. As
> part of this, convert of_get_property/of_find_property calls to the
> recently added of_property_present() helper when we just want to test
> for presence of a property and nothing more.
> 
> [...]

Applied, thanks!

[1/1] memory: atmel-ebi: Use of_property_present() for testing DT property presence
      https://git.kernel.org/krzk/linux-mem-ctrl/c/538c7b5b5d8b5364454494e5fe4125b0b47195f1

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
