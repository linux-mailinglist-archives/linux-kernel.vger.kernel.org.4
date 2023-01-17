Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B03F66DC27
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 12:19:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236801AbjAQLTb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 06:19:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236678AbjAQLSO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 06:18:14 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D307A34577
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 03:18:12 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id e3so20988285wru.13
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 03:18:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yNRGNwlNlCSw2219mzmzcHuVoA6n0rLRFLEvc8LW6gY=;
        b=Iyxg74bBYLWGp513et7gB2YXtL7HK3kYuRl7xNOwXLaR0QDkm7sCLEM+NWaPJW9lBm
         QQ4vUuI9S0KMD3ghyn6LJaOnJrpLD0lN4r0tTEkCTa+1SxfEOix+jowDPpRywuutMSzd
         HU55Jx5wMdWXCeLVfGIbKD8xAtFxeYKbc6MprBdj8Wv7LGvCdAKHwYpr8EiE6ohtTcf0
         PGEJtxLDbrKeMFDuRDSmJxT+Z/6cCOXebbU0texdQUj9tQoj2uQuSaBcnIlARRW4HEBs
         JLONPAuPSCH/h9MUNhrCFc2jocqEkCyLFVQ5ShH5VfqouxTQbXc9T8m1ApLc3k4JyjGR
         GSDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yNRGNwlNlCSw2219mzmzcHuVoA6n0rLRFLEvc8LW6gY=;
        b=b1ikisvznNMH1cByOxUWVkQh7HfOVK3suO+svrCwddgHWjnXNa4unoOmw+D/1vOMm4
         4HjThazwgqCgjTwJFEfkx3lXQifavaYxTczKphazv7SjNMn5BXwp/nGkYLJMpf7ZxqXO
         yxbYrWRPJ3766q5rjls+ro76xFl+/18JINZicMRSIhqGBBDoxxobeYlmgksMxs/5TAyu
         AjYzBRPXoo3JSVh6HJ+o3eBE53DOCgpWAF7f+bmyeVLuC5HkYH6yvD29PDOh7Bmwapic
         La8Ny7JmUAlnfc1Em0hQZ1nnp0UG1oZaKkgWUk+iGROtA5ZMpxRp67Hc/1Cvw65gIIg0
         6pCQ==
X-Gm-Message-State: AFqh2kp8O7DOfX4j+46s6RXxRHbZ13nQtFyCGXSLMsW3p8/JzZzcP12U
        tAWcKTGAO1kyXFdFuPLpH2PaCA==
X-Google-Smtp-Source: AMrXdXuVWtE1Ni5EZq32Gzte0bp61JbiooFjWQqGOkD1Z37NFu6Rgo4WQWMFnOMwCLhEHBq3tOmVPQ==
X-Received: by 2002:a5d:6b4d:0:b0:2bb:f88b:43b6 with SMTP id x13-20020a5d6b4d000000b002bbf88b43b6mr2637076wrw.3.1673954291241;
        Tue, 17 Jan 2023 03:18:11 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id w10-20020a5d404a000000b00275970a85f4sm28466717wrp.74.2023.01.17.03.18.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 03:18:10 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Padmanabhan Rajanbabu <p.rajanbabu@samsung.com>,
        alim.akhtar@samsung.com, rcsekar@samsung.com, robh+dt@kernel.org,
        lgirdwood@gmail.com, aswani.reddy@samsung.com,
        krzysztof.kozlowski+dt@linaro.org, s.nawrocki@samsung.com,
        tiwai@suse.com, pankaj.dubey@samsung.com, broonie@kernel.org,
        perex@perex.cz
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-samsung-soc@vger.kernel.org, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH v4 4/5] arm64: dts: fsd: Add codec node for Tesla FSD
Date:   Tue, 17 Jan 2023 12:18:02 +0100
Message-Id: <167395418605.64421.2322020488377607185.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230116103823.90757-5-p.rajanbabu@samsung.com>
References: <20230116103823.90757-1-p.rajanbabu@samsung.com> <CGME20230116103908epcas5p49d65b8a38b8ecfeda508960a9543193d@epcas5p4.samsung.com> <20230116103823.90757-5-p.rajanbabu@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Jan 2023 16:08:22 +0530, Padmanabhan Rajanbabu wrote:
> Add device tree node support for codec on Tesla FSD platform.
> 
> 

Applied, thanks!

[4/5] arm64: dts: fsd: Add codec node for Tesla FSD
      https://git.kernel.org/krzk/linux/c/be8599d07a6a184a790054b9b229c0b37e418014

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
