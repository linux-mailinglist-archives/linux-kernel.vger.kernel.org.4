Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3DAA644411
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 14:07:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234728AbiLFNGu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 08:06:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229867AbiLFNG2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 08:06:28 -0500
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F17A2CE30;
        Tue,  6 Dec 2022 05:05:00 -0800 (PST)
Received: by mail-ot1-f45.google.com with SMTP id m7-20020a9d6447000000b0066da0504b5eso9174958otl.13;
        Tue, 06 Dec 2022 05:05:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MXIFyP+UTIEk0Yojx26A5iXgnHl9m8JY0GBl53V7tbQ=;
        b=DAyDgnWlOWLkq29DoSnPG8nifNlGFwi5wPs9uCyv5P9HF2S9EBZJ9T9NHZi3UyO/VZ
         TypTA7wNcRt8gZb+MLq6VFIiq6zLRqDDDkzSCD6ZqiWZwQW+om6kE4Vk5W3C2KNaVn7d
         VvPF38RU0XrOa4QgHJL/4mpxxdbBLfy9wm6FPGDgWE5hN2/eimNfMR9b5YWuyCs9Pskj
         CXjRkgo8LKYhHIcogKDY8O2IngQX6q8xCUol/5uHVfszkLtloozKFfVVj83gBeCY8y9k
         pNBTCnjbjjsZvC8T5QpQVwyVWojw6hyVHVCsuMjB+U5wEtcNGZdqMO2UHXmYbj4DI2II
         dHnQ==
X-Gm-Message-State: ANoB5pmdnxUSh3gC9XekFer3bpyirjuqAKUW+x5Jn93dQj8UdZu87hln
        3IDyBNV760glEpynzPRI6A==
X-Google-Smtp-Source: AA0mqf7Q/7VtDzt3A993Wg1brZgvtLz+mD83kkYPL9YunOoWHl5PrH+2cBdscmR+RDa3oJj02LwLrA==
X-Received: by 2002:a9d:578c:0:b0:66e:66c7:9f71 with SMTP id q12-20020a9d578c000000b0066e66c79f71mr15134597oth.333.1670331834777;
        Tue, 06 Dec 2022 05:03:54 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id h3-20020a9d6403000000b0066de9dc966fsm8861582otl.65.2022.12.06.05.03.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 05:03:51 -0800 (PST)
Received: (nullmailer pid 227640 invoked by uid 1000);
        Tue, 06 Dec 2022 13:03:50 -0000
Date:   Tue, 6 Dec 2022 07:03:50 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-amlogic@lists.infradead.org,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        linux-stm32@st-md-mailman.stormreply.com,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        linux-samsung-soc@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        devicetree@vger.kernel.org,
        Alain Volmat <alain.volmat@foss.st.com>,
        Yannick Fertre <yannick.fertre@foss.st.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Joe Tessler <jrt@google.com>, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-tegra@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Jeff Chase <jnchase@google.com>,
        Kevin Hilman <khilman@baylibre.com>
Subject: Re: [PATCH v2 6/9] media: dt-bindings: samsung,s5p-cec: convert to
 DT schema
Message-ID: <167033182977.227580.3241593783297091470.robh@kernel.org>
References: <20221205151845.21618-1-krzysztof.kozlowski@linaro.org>
 <20221205151845.21618-7-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221205151845.21618-7-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 05 Dec 2022 16:18:42 +0100, Krzysztof Kozlowski wrote:
> Convert Samsung S5P HDMI CEC adapter bindings to DT schema.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../bindings/media/cec/samsung,s5p-cec.yaml   | 66 +++++++++++++++++++
>  .../devicetree/bindings/media/s5p-cec.txt     | 36 ----------
>  MAINTAINERS                                   |  2 +-
>  3 files changed, 67 insertions(+), 37 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/media/cec/samsung,s5p-cec.yaml
>  delete mode 100644 Documentation/devicetree/bindings/media/s5p-cec.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
