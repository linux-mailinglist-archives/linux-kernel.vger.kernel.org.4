Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA3F36FA379
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 11:37:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233778AbjEHJhe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 05:37:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233765AbjEHJhc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 05:37:32 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58ECA1721
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 02:37:30 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-50bdd7b229cso8201423a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 May 2023 02:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683538649; x=1686130649;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TBtL4cWfszS4ROjDUwHjteKkG2Q8u0EKVxKvzxIQ24U=;
        b=rO0e9rufK3H4pXHtw79hf7tFhQ/KXkAJ7HhbxEGTEUZOYRsfrbfFhWS3W3mrExakFb
         atjAxhsdiaGKYerczIA1inr6agUwB+h8/helKWZL3zBu/NK3sHB7Ry/A7zQ5EE40oA8B
         K6yG+GuFAS0DZWJ0FJxVVKHJxIElqWo6jFoAhXUq0uhTPpCU/uU8cfmMP6RZh/9igune
         XVWRIizvq54VgxQxsQ4nQ3njArlZnBVrqQuJvoiDlvO1bpnquItReUoo+kP7cW7NLFWD
         0ryaHhWGumGjHo2JFOvIu85emj2G2S23orb1OoOBoqFhKKsjKG0xp4DfD1Eql+9GtMQ2
         LLLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683538649; x=1686130649;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TBtL4cWfszS4ROjDUwHjteKkG2Q8u0EKVxKvzxIQ24U=;
        b=BOEFvQyxaCecl59KYTcd5r65klMbReT1SdDsDSotfuhb4R0882MfdPoZyPkpucNx/z
         Szgn76YIYwddm9iTTjUgIbiMZqtes8rpFfdwXia25L0yo5Nx9N/PgtS8e1LrIMWeArh3
         WS3b5kj2rrrsULN5IXN23YMG7W3JncBGs9Ft+Mrv7KYFqds5K69iqS1kGQR/VM34B6bO
         1oV+CxyQgHCEOEQ47zSaZvJyyVLubgLcBUuRwpFOcaUoeyOrt4o6XuR8MEYFOpvIX2Rd
         ulwzB1cryxe3FlrBjey2Hlgnx9jJRR/FnjIfgNfleO1g9P94BkLj8qEYlAbTtqjMpa/G
         navw==
X-Gm-Message-State: AC+VfDwKagBkxr5wgjLBcDdfazdhxFMDqrOsYowoxfPv1sjvXQqXZV5O
        dpoa26WXo9XdgLFZnU53Il3HAA==
X-Google-Smtp-Source: ACHHUZ5h0ILKxQCVccGldVRtqE6oDI4WtFhK7pSgdSbqQ+S4aV452b+GEAJJS+jVaXLbJcss3YfSEw==
X-Received: by 2002:a17:907:8a13:b0:961:2956:2ede with SMTP id sc19-20020a1709078a1300b0096129562edemr8911942ejc.44.1683538648932;
        Mon, 08 May 2023 02:37:28 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:50e0:ebdf:b755:b300])
        by smtp.gmail.com with ESMTPSA id h13-20020a1709070b0d00b0094efdfe60dcsm4649244ejl.206.2023.05.08.02.37.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 02:37:28 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Sasha Finkelstein <7d578vix8hzw@opayq.net>,
        Thierry Reding <thierry.reding@gmail.com>,
        asahi@lists.linux.dev, linux-pwm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: adjust file entry for ARM/APPLE MACHINE SUPPORT
Date:   Mon,  8 May 2023 11:37:25 +0200
Message-Id: <168353863936.84657.5087723574907362646.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230424114043.22475-1-lukas.bulwahn@gmail.com>
References: <20230424114043.22475-1-lukas.bulwahn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 24 Apr 2023 13:40:43 +0200, Lukas Bulwahn wrote:
> Commit de614ac31955 ("MAINTAINERS: Add entries for Apple PWM driver") adds
> an entry for Documentation/devicetree/bindings/pwm/pwm-apple.yaml, but
> commit 87a3a3929c71 ("dt-bindings: pwm: Add Apple PWM controller") from
> the same patch series actually adds the devicetree binding file with the
> name apple,s5l-fpwm.yaml.
> 
> Adjust the file entry to the file actually added.
> 
> [...]

Applied, thanks!

[1/1] MAINTAINERS: adjust file entry for ARM/APPLE MACHINE SUPPORT
      https://git.kernel.org/krzk/linux-dt/c/196a1716a2ecdcbc61e6b299362897f0ccbd26c1

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
