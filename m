Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26BC071FC3E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 10:41:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234283AbjFBIlj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 04:41:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjFBIlh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 04:41:37 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BEA4E2
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 01:41:33 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-5149b63151aso2535771a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jun 2023 01:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685695291; x=1688287291;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8FiPRksVwTU0uv6tmLJOjEd1jOPZ6IUlwXos5HMG0TM=;
        b=jTKJX2VyBW9B9ojbLrU4I8MfYleRmPGG/J0XYoNnbOWyjw0xvH5Q/x0ySATmif7Av1
         Z8VeDzVAADI0JxQ+iLxM5Ll8c6S1dcKcfoK7ZZwfb9b8CFDOAJZ30KAhcUSotx6KqAzK
         Ct084FiNIqx6VJfxr2Jal0pmKYk1gE0TCUZUx74CmPfLEnSrjjg/AQ49p7kDMFMXTxvI
         2+v8ZmTACXW6Yp2XJth+HuRPqQRUHFhlwzRZKt0sLVbMbzLf9L8QnpXrpEttck+6jNU7
         BZbeQvx0dyWObCMB33FDV/9aChFD0yYm/Uor3JKRgw8C+DBk8Zvl0Coh1vg1ITLOhYHs
         OeYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685695291; x=1688287291;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8FiPRksVwTU0uv6tmLJOjEd1jOPZ6IUlwXos5HMG0TM=;
        b=klVw4DlpsSKORHH63c4gXBBKaCM4nYyhDQwadBwoJfw09asi+J8+mYpNGclKdWL6wi
         F9+9KmtfcVPRLqX3PDGqYfFVTDejIFArx9XkyOiEGLPQEL9jU/P6qk6wmmQ4iQ3c9IWE
         kdBY0XWaG80ZV7Z6hTRpn6iktqEQlmqToLJGiGY1D+q8Eea4Bx7EwTKnGZKaMxmURc9t
         6X+jjEkP7JVDXyOR2eWnPq9NXbkjFdUaIdE6Y07luo3x0VCRuTdOmwZjbKoPliBHpgba
         HjZoadywTh6/tpwheV2Zuv8VRweiOByTpRIpPFTWCleJK5NGJneR1DncXtk1p3kX9MB8
         fHTw==
X-Gm-Message-State: AC+VfDwsN1+fdbhyORgrszte/a048oByeZ5PduNxe0jFXRhgrBZj+F2H
        rjbDhq+6mmtwlPvlqVyQK2s0Ng==
X-Google-Smtp-Source: ACHHUZ5r0zd6pbDHvl0B7Mw1KacvD+QZNrNAjVrYqRcvSWYc1/oX7IQXxZKQxVz+HXPIxyYUfl2V2w==
X-Received: by 2002:aa7:c45a:0:b0:514:8e4a:2d6f with SMTP id n26-20020aa7c45a000000b005148e4a2d6fmr1731876edr.23.1685695291526;
        Fri, 02 Jun 2023 01:41:31 -0700 (PDT)
Received: from krzk-bin.. ([178.197.199.204])
        by smtp.gmail.com with ESMTPSA id r6-20020aa7da06000000b0051631130dc9sm421864eds.54.2023.06.02.01.41.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jun 2023 01:41:31 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        linux@armlinux.org.uk,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] memory: atmel-sdramc: remove the driver
Date:   Fri,  2 Jun 2023 10:41:26 +0200
Message-Id: <168569528350.11883.3990598454561917436.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230516072405.2696225-1-claudiu.beznea@microchip.com>
References: <20230516072405.2696225-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 16 May 2023 10:24:05 +0300, Claudiu Beznea wrote:
> Driver does only clock request + enable for DDR clocks. DDR clocks are
> enabled by bootloader and need to stay that way in Linux. To avoid having
> these clocks disabled by clock subsystem in case there are no Linux
> consumers for them the clocks were marked as critical in clock drivers
> (in commit 68b3b6f1773d ("clk: at91: mark ddr clocks as critical")).
> With this, there is no need to have a separate driver that only does
> clock request + enable.
> 
> [...]

Applied, thanks!

[1/1] memory: atmel-sdramc: remove the driver
      https://git.kernel.org/krzk/linux-mem-ctrl/c/d3369a4b6f0164b8869a097547846ed4e5c9c47f

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
