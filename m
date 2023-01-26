Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88B3667C883
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 11:25:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237130AbjAZKZy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 05:25:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237088AbjAZKZr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 05:25:47 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 229013400D
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 02:25:45 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id n7so1263756wrx.5
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 02:25:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HEohK6WsZnnZQE1XEaaNmVSZHrsCyyc5P37uY0vfyuE=;
        b=J6svHmw17ESxKTDiRf+mlTmjoMRhMVy29IeNOO9FfygQeR2Fbj/vgnZl5NEJeD+tMd
         SDDpnHhOqVVsxNGq5LLsIG+B6UdxE5EoDwDtpPvwxnrdYf7ARenrgGyjY3V4FPYzll1f
         bEJabj7pZ8uRNKGyjiujrVXbdZnynpeVVTrevpiQd3QOgPv/Q/oSeuOKuDM9tSTEc5PK
         XInaK48RuSGEgiSv0bU8Qx04OIAaMdDf6EOwUC+M7hDv62y6YPVPdlI2j09CMTVVBZE9
         KTAn0oPFTlM3mOF3lMfrg1fNMf255B40vC+A5PgU1s87q1Z13zEFtuXqm/tbG+mpRw6R
         akKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HEohK6WsZnnZQE1XEaaNmVSZHrsCyyc5P37uY0vfyuE=;
        b=gNWGXvsnTFRwV7tol6R7LFxXDAA1yI7z5mM1isquUMrVJF7L1tI8MF+3xqaG69ONO3
         CXF/GrMAqhFFZgQlsHe18OqCJn5iom3H3kyf2PkpzgTPAHLBU5Odf/+c9/CU6ua7hPjm
         1+ogfRh8yeyR9QuCc2ttTuuWbEvOjpQ0HQFdFseZKBUqX6EkIe2n6M9h6k6soBiY4IZ8
         gnmOSB3YKbmTz0DrDFy3uwpQY1nomjRQsbaE5oFXAuICaUDvd9W5AsVJOGF1/v5BbQhO
         6QUy5cS903GLgOGnPinnMKwB6TkNSoj/2L16CJ30A2o2tRZ7kocJo02Pc2sQxbl7t6Tl
         WIkQ==
X-Gm-Message-State: AO0yUKXmoYXjLtNmyO0kUeiiNoyEt6MQWWmKM4btukpqaT2o8KfRZsAf
        N6tdH80Dy5uOEaZLz7PPNRHAxA==
X-Google-Smtp-Source: AK7set+3IQ24+W6zktNXyrxsNES79+e6UERDQkrpgRBWniC+zRetCvrUOnRKnhwDMv9ANAYnKs4fBw==
X-Received: by 2002:a5d:64ee:0:b0:2bf:b7e3:7c82 with SMTP id g14-20020a5d64ee000000b002bfb7e37c82mr7901356wri.57.1674728744386;
        Thu, 26 Jan 2023 02:25:44 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id t8-20020a5d6908000000b002bc7e5a1171sm886514wru.116.2023.01.26.02.25.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jan 2023 02:25:44 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Liviu Dudau <liviu.dudau@arm.com>
Subject: Re: [PATCH] ARM: dts: arm: align UART node name with bindings
Date:   Thu, 26 Jan 2023 11:25:29 +0100
Message-Id: <167472873009.13092.12381861125634891317.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230123151533.369533-1-krzysztof.kozlowski@linaro.org>
References: <20230123151533.369533-1-krzysztof.kozlowski@linaro.org>
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

On Mon, 23 Jan 2023 16:15:33 +0100, Krzysztof Kozlowski wrote:
> Bindings expect UART/serial node names to be "serial".
> 
> 

Applied, thanks!

[1/1] ARM: dts: arm: align UART node name with bindings
      https://git.kernel.org/krzk/linux-dt/c/cba9e7dbf1119e9f11cef0379a88c42a92029bde

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
