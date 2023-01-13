Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7432D6694D2
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 11:54:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241448AbjAMKyH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 05:54:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241137AbjAMKxP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 05:53:15 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 124A96CFDA
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 02:51:47 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id u9so51452419ejo.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 02:51:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n88waqGTR2qgw5bwPqegEMpBejAirJWOqGyFgCgKiAQ=;
        b=MDcLv5yYReavS5+8xilTGkmE8urRNHqDswLNcnka4QRqpvorWf1ZZxcjUd6kRf4WFz
         N4jyTpZN8NyIg1T9tcRzBhZ+iQsKwY60l9px9uwOieWZgJG7RJ6jvBqzlx/6GEBkQ94e
         xSfM3xyXBVZWKvCdE302WwdKNdLHXsFftMZGMC7+UsC+LvGcnMvazBIFmSY6lKgRkp3E
         R8udS00M4lsPCI8OzK6aHzEkw72QngoJuxKglCjZv0WT7S7O3fp88PEdZp4lIAzCIeIa
         gT4ucLgJRIJmn9XPakvaLehp2mhGyfB/c3cDqBnv8b0byogkvqWnfwyBsfwFNv04x8ES
         xQ+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n88waqGTR2qgw5bwPqegEMpBejAirJWOqGyFgCgKiAQ=;
        b=qd4p2yk06VZPcIQgdC+2zUKNa97jO0XXnU7+Uaq9+8n8GjX4HZYFucYslEkuU71d67
         O2WpW2QhUywsWRAjeW+ffszsXWRA9Aqj/aNccY3i05nnHbqv7H/KtgVODEx9sD9gHoAd
         e5gb9HXZreBzUbk56E1h6JhXWXVUxhvVh85dA5CflpJQ8/cAUwmSKCTKub0It7zANHua
         RTgyoh6U+uVv3dm7ELIq0ZewE+zNSbmwl+n1CKpswIeG/gvptKlfM/8+Uu4PgZqleJMD
         z8epdWcaCULhNsSAsqOYz7WwSGOZOvIJ0DU4fJkntek6Hu5rkewIFdGWEAcuIybFSA9K
         LwAQ==
X-Gm-Message-State: AFqh2kp2NYnL+DPE2UcDqri2ZZ5snZrpgihv6jz7YiVYJPOyV3riqfGH
        +ABh7CyvU3hCr3rUuJjYNl84Gg==
X-Google-Smtp-Source: AMrXdXv2KLHb/vh4U+JhP07lOkD0cQx5+/tmjRAOQ3T3eRyfy+M7/seM93gDm58joz2AVOLnYYp1bA==
X-Received: by 2002:a17:906:da09:b0:7c0:e5c6:2a6d with SMTP id fi9-20020a170906da0900b007c0e5c62a6dmr2536575ejb.39.1673607105617;
        Fri, 13 Jan 2023 02:51:45 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id u1-20020a1709061da100b0086b7ffb3b92sm146352ejh.205.2023.01.13.02.51.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 02:51:45 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Wei Xu <xuwei5@hisilicon.com>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: hisilicon: align LED node names with dtschema
Date:   Fri, 13 Jan 2023 11:51:36 +0100
Message-Id: <167360709873.32944.9243558336647166949.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221125144140.477225-1-krzysztof.kozlowski@linaro.org>
References: <20221125144140.477225-1-krzysztof.kozlowski@linaro.org>
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

On Fri, 25 Nov 2022 15:41:39 +0100, Krzysztof Kozlowski wrote:
> The node names should be generic and DT schema expects certain pattern:
> 
>   hisilicon/hi3660-hikey960.dtb: leds: wlan_active_led: Unevaluated properties are not allowed ('linux,default-trigger' was unexpected)
> 
> 

Applied, thanks!

[1/1] arm64: dts: hisilicon: align LED node names with dtschema
      https://git.kernel.org/krzk/linux-dt/c/d0931f1d5e9c1655cfa8128edd14e813b4044801

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
