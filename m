Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 967786FA2D0
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 11:01:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233673AbjEHJBU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 05:01:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233563AbjEHJAt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 05:00:49 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB05A2270F
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 02:00:30 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-96652cb7673so156575966b.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 May 2023 02:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683536410; x=1686128410;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ejjUf3UhefMW93WcjTbWvKOhNpZJMFCL2XeOa7VnfAw=;
        b=WYtbRAaF2sKjpvMepkFkq+Fwhli5J3fIJ97D6jInSByD1BZ8n6Ur1NIMuUdv5/by9H
         0Y+/lpzHexhUBkoMwcIbqGRqQTosVn+CgEpexSwU9uavevf4PkEQSyLwEzHM6gar/FLH
         1AF0yh0a/Y658LaX25k+xDNrCeg855ydeVUs026eMsTcaSkLuW9IPPcutvHgnG+dfR08
         2Wazm7xPq7SSflvAq0R9+7NR3x9hQ0i2BS36epGqoRHEqJNX/wUErALh6Svn0hwLDr4B
         rhf97pAWYOr8NHgPDXiHlLxzEydEVJ0uXpRgiTI7rdS/gLU7PX4CX31QHMvLEXgG4Jty
         hGqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683536410; x=1686128410;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ejjUf3UhefMW93WcjTbWvKOhNpZJMFCL2XeOa7VnfAw=;
        b=WArYtigNelvvFDhD2r2tH/8hGVG7QnJLZI4xMc5r63ngrmYs4PwTZJOE2F5VoR+fgN
         nfHcxSE1NHU2NU2yVXkYIHuJLVKrQhQz7kh2Xqt6Ka30M3GbxdU+TPo7mWr+qvMMGlBX
         cBaun0ZBAdRZqYxNyk0M7amC5jWKqWLmBnaGOIhLjLlcy0oVGYz+fzsrC0VViGQGIqi+
         0mH/wsbAvQGsb+nootxfyHnl+7SzNDcp2PbG5xhnLFoB/Izyd4zgfKNZgF3zaoIUfWQp
         MyBflOX5MgrlSOw7Uk2a0CkMjrEpuAN5FvfK3rdF9ZACRuvygruDftI8VDAAXbgdyg5o
         gszw==
X-Gm-Message-State: AC+VfDwyrbOx4s/XQP4czE+f7OR7BBNp186c+jxdf00CSEHHyL8R30sW
        DOJ4+wCInk1POo5lW3/SR9DVRwViY8KLwVk70J7gBQ==
X-Google-Smtp-Source: ACHHUZ5SvHuzfBpi8jC586eMp8FetafejLrfjgstWhsVJ4PeZERr9Y0aBG2zfjgno/z1UeouYDM4wg==
X-Received: by 2002:a17:906:ee86:b0:962:46d7:c8fc with SMTP id wt6-20020a170906ee8600b0096246d7c8fcmr8398127ejb.21.1683536410512;
        Mon, 08 May 2023 02:00:10 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:50e0:ebdf:b755:b300])
        by smtp.gmail.com with ESMTPSA id jz4-20020a170906bb0400b0094bb4c75695sm4718953ejb.194.2023.05.08.02.00.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 02:00:10 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Evgeniy Polyakov <zbr@ioremap.net>
Subject: Re: [PATCH] w1: Fix Kconfig indentation
Date:   Mon,  8 May 2023 10:59:43 +0200
Message-Id: <168353638585.78189.10538122594208042559.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20191120133826.12964-1-krzk@kernel.org>
References: <20191120133826.12964-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 20 Nov 2019 21:38:26 +0800, Krzysztof Kozlowski wrote:
> Adjust indentation from spaces to tab (+optional two spaces) as in
> coding style with command like:
> 	$ sed -e 's/^        /\t/' -i */Kconfig
> 
> 

Applied, thanks!

[1/1] w1: Fix Kconfig indentation
      https://git.kernel.org/krzk/linux-w1/c/4f5a5badb4eee46e43dc45be5e6058bff767eb80

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
