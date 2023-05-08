Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEF476FA2DA
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 11:01:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233612AbjEHJBp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 05:01:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233368AbjEHJA7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 05:00:59 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10E972269E
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 02:00:36 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-50bc070c557so8321547a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 May 2023 02:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683536415; x=1686128415;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+ZK4HXU+j2dP/a9t3IMfCPc5nhez1B0OHSKgYXQ0vJI=;
        b=paJcSMDXBxw/b9+X9ALSXZ35DpzalJ10w4uWRfTSsr+wuwv54FU9A8X4xw5ffWW1Jp
         hY5nqafL5x6tVhOO28qkYVy94GMY+DBOLziwlO12YUDsElKPmOJjElI5YaOo1gw1Cp+2
         dloSS4uCbUSaZ5riyyxZX5F4SkU05eBMLMJYqpurcyq61vYAZHFR3keCg4KRiJm3Vg2s
         oqzDOZQa9lrt75OeeVay5li22isi0TUyO5SCHTa7mkXSBCWmSzNmvlazh/68SfajyCOh
         8h9XiRwBRIjEytRgzIuSTPb7570jHicewnL4JGfXcePPGZIrrBMbsP2IJxY4azyIqSqQ
         Xs+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683536415; x=1686128415;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+ZK4HXU+j2dP/a9t3IMfCPc5nhez1B0OHSKgYXQ0vJI=;
        b=PyQgh4yk+cPeWVaYunJ7GxgRkTkciegHf4urEbhHH6319FbnzcSdzzkTANh1PQsNNJ
         4G9H4+lnfg8sXxxmL3OC03hpEeW7hcviOd/o2O1hTHsEJbp/zg8NiZWWO7gjqhzvm9+0
         lt4JT+LLhnvx4ZRZYOj8jQjxtL7MX2fiNNw0rUF2/xYCJHdSHvmglL48Ckn+bcnSxime
         fCPKm9s1YNyTg2rBdGOLrGMiji07bd75csTTQjry2479tnfbjcoQlF1cSErvxAAnCeWN
         ZH0S4EBt3TomHvdV9/aBcgPX+fK13zWA1WYvjCzxF0Z44XH6/Z8e3w0wQTZUtHsLkguI
         yE6g==
X-Gm-Message-State: AC+VfDzbo244tjje2+PtbQyNwiwLk/CVhP2v1LMzUXzMFVg6YbhheHiq
        pWq+eZ+jk1b0HeWC691jZLyFfQ==
X-Google-Smtp-Source: ACHHUZ6WZKuGaVzlSS+2SCWz23y4bxXqR/Q/LG/FYevd+yIv81CV9MJsXYDKhfnV+ww6rEfbvb1cCQ==
X-Received: by 2002:a17:907:6e0b:b0:949:5db4:7888 with SMTP id sd11-20020a1709076e0b00b009495db47888mr9222849ejc.27.1683536415023;
        Mon, 08 May 2023 02:00:15 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:50e0:ebdf:b755:b300])
        by smtp.gmail.com with ESMTPSA id jz4-20020a170906bb0400b0094bb4c75695sm4718953ejb.194.2023.05.08.02.00.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 02:00:14 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     zbr@ioremap.net, jdelvare@suse.com, linux@roeck-us.net,
        Liang He <windhl@126.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org
Subject: Re: [PATCH] drivers: w1: Add missing of_node_put() in w1.c
Date:   Mon,  8 May 2023 10:59:47 +0200
Message-Id: <168353638587.78189.13850750261340939366.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220615125105.3966317-1-windhl@126.com>
References: <20220615125105.3966317-1-windhl@126.com>
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


On Wed, 15 Jun 2022 20:51:05 +0800, Liang He wrote:
> In __w1_attach_slave_device, we really need not to use of_node_put
> in normal path as the reference is escaped by sl. However, we need
> of_node_put in the fail path before put_device.
> 
> 

Applied, thanks!

[1/1] drivers: w1: Add missing of_node_put() in w1.c
      https://git.kernel.org/krzk/linux-w1/c/51cbbcd6469b2a32e222ec220039af20a16f2769

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
