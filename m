Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D21B723E33
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 11:49:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236896AbjFFJtC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 05:49:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237572AbjFFJsr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 05:48:47 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED5DFE73
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 02:48:33 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-30e4eec95c8so388027f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 02:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686044912; x=1688636912;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s/OX2oP8YZaGEVBQ6cH5rJxVRniqBzCLdpv0TF2IIbE=;
        b=Cw6pOzihmkYF8h33rai75/+GXFTJtKHokyyjx8kKNgiGctxzj1IaZyVZhA8I+ceaPc
         v5mn+gRwjcB6nEvs+CW9ACkBNeY0COhYRJsO4nP4NBo0dvLD9gJZug9S4OcbESL6SMT+
         GOgwXlGceKShwgp0wGoHM3z0kjcx5tRUy9Q+3+2T80gGhdPRKe/jEr/3xgSIpk9KjqgA
         u/5dPK31yy0vdLuyi00rTrKfpUvfCZjTt6ybg4JcTiiu/HB86Kss7DbSBoPPdAIbRXzH
         PTMaXEFab/tDu1cblKGhTpZu/jQlWsGDClb7vC7uIxDn85qPz+H4EZT9efHUt3tY4SG9
         8I0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686044912; x=1688636912;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s/OX2oP8YZaGEVBQ6cH5rJxVRniqBzCLdpv0TF2IIbE=;
        b=iuzvEVoLZ1B2WH2jy8Mpgmqxy+XsginGuZRTvZFhIB2RqjeFvRseb/XiHn7O6IX+tE
         88xJbeBSTnz0wWSSx1SjzvinaeLwlt8deBYlNKQ2hJHt09cdanQLpFvXpifYZVU0qemf
         6b2XQkkJv7QEWszcxT+ZDkyE0TselE2w2REYYttt4Zt9FPdpHO93scGMk07f7s9FvTvI
         M7FYDm1Z5c6By40HgfF5Ndaptu+cn2tg3YEjMVR+Wbot1TXmwwlR4RYPLUztYoTBVOVg
         vQoksL4vJoDqKIJuQ0zz5ILunEK1igLtJlzVRP9q3KMRneVxRuMjWKhC/yUxNshHasnX
         Z05Q==
X-Gm-Message-State: AC+VfDx5Rxq6DVVvfpc6Sog8Sg+mNyAeOa0zsMknPzJHTvcYpWqeaV5i
        MRWvBuxF7al88tAzWL2kyb8GUA==
X-Google-Smtp-Source: ACHHUZ7IBxiyJzVQU8c4azyK+pahsRosjuqLcfM+qc1zx7YHDvmeg/So6+h8vb2cHh/DpIJYCvWZ6A==
X-Received: by 2002:a5d:534a:0:b0:307:a36b:e7b1 with SMTP id t10-20020a5d534a000000b00307a36be7b1mr1654311wrv.5.1686044912446;
        Tue, 06 Jun 2023 02:48:32 -0700 (PDT)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id y20-20020a05600c365400b003f60fb2addbsm17089178wmq.44.2023.06.06.02.48.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jun 2023 02:48:31 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        =?utf-8?q?Rafa=C5=82_Mi=C5=82ecki?= <zajec5@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Michael Walle <michael@walle.cc>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?utf-8?q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>
In-Reply-To: <20230327141611.25131-1-zajec5@gmail.com>
References: <20230327141611.25131-1-zajec5@gmail.com>
Subject: Re: [PATCH V6 0/3] nvmem: add fixed cells layout
Message-Id: <168604491026.228888.3615401302386007929.b4-ty@linaro.org>
Date:   Tue, 06 Jun 2023 10:48:30 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 27 Mar 2023 16:16:08 +0200, Rafał Miłecki wrote:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> NVMEM bindings received a new feature recently: layouts. They allow
> defining NVMEM device content in a separated DT node named
> "nvmem-layout". That improvement results in cleaner and more generic
> bindings.
> 
> [...]

Applied, thanks!

[1/3] dt-bindings: nvmem: layouts: add fixed-layout
      commit: 4d0c9ce1a7a26947269a15fad622f1ffb6698627
[2/3] dt-bindings: nvmem: convert base example to use NVMEM fixed cells layout
      commit: 75dd9c7a421a239be6e7bd48e6b3a1474500fe98
[3/3] nvmem: core: add support for fixed cells *layout*
      commit: ac1c0d15aedc0863031bc8d678d5f96ab11d3a41

Best regards,
-- 
Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

