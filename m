Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E57167BC10
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 21:06:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235525AbjAYUGT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 15:06:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230044AbjAYUGR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 15:06:17 -0500
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EEDB38E92;
        Wed, 25 Jan 2023 12:06:07 -0800 (PST)
Received: by mail-ot1-f44.google.com with SMTP id f88-20020a9d03e1000000b00684c4041ff1so11796505otf.8;
        Wed, 25 Jan 2023 12:06:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8zQJwCHfiFi6VH+BLN1bNPbxexl2oTTiePtVA10gjBQ=;
        b=bVCfXlie4p6Mar5eHZ2ghOA6oYtrIUVjahfnzFSivkXBrCy2M9Mg77oDlBDmeF65aq
         pkimCeLKWz2jt//xlpnpnFQNyYEImVzPRhBCSAryxL24JpVkmDt7/yz5WAvkre6Vhp43
         zCtfzqSH0pgw9IQMLCaBOwe/xSCxPujpMBQzmM+lUIwEmJC+7VBRaELpQlXJ8i48Cddy
         L5IUa1DAl6vCA0KF3Y7STTxr6tYmXj5KsLZLINXR/44+6JwbDnZwVUO6FtsUApvkEEpQ
         /WvvzTbvKw6OiajjWFxQ5AIEU8qYVtFBX3ToYRM7w7i5pji7MGqA464kKLKvGSlHlOrx
         XzsA==
X-Gm-Message-State: AFqh2kr7qmpniPuaJQ+JqMx6Sp/ZQVGNf8PamDw75Eu/bgN00M2fY6g/
        HW8LLL9Vq03VXMP5UBdVXg==
X-Google-Smtp-Source: AMrXdXs6SM7I1OOUhLLfrwCPfKfHkcE6ouDZkfhmfkKp+JRlJHR3k7KwOPhsLyrO6hSP5EAouQVPpw==
X-Received: by 2002:a05:6830:1652:b0:686:4382:13aa with SMTP id h18-20020a056830165200b00686438213aamr17366869otr.32.1674677166280;
        Wed, 25 Jan 2023 12:06:06 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id g16-20020a9d6490000000b00684e09b43bdsm2567325otl.13.2023.01.25.12.06.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jan 2023 12:06:05 -0800 (PST)
Received: (nullmailer pid 2769611 invoked by uid 1000);
        Wed, 25 Jan 2023 20:06:04 -0000
Date:   Wed, 25 Jan 2023 14:06:04 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Neil Armstrong <neil.armstrong@linaro.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        - <devicetree@vger.kernel.org>,
        Peter Korsgaard <jacmet@sunsite.dk>,
        Le Ray <erwan.leray@foss.st.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Fugang Duan <fugang.duan@nxp.com>,
        Pragnesh Patel <pragnesh.patel@sifive.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        linux-arm-kernel@lists.infradead.org,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Kevin Hilman <khilman@baylibre.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        linux-riscv@lists.infradead.org, Lubomir Rintel <lkundrak@v3.sk>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-amlogic@lists.infradead.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Chester Lin <clin@suse.com>, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH v2 01/12] dt-bindings: serial: amlogic,meson-uart: allow
 other serial properties
Message-ID: <167467716404.2769558.11154438108014258073.robh@kernel.org>
References: <20230124091602.44027-1-krzysztof.kozlowski@linaro.org>
 <20230124091602.44027-2-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230124091602.44027-2-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 24 Jan 2023 10:15:51 +0100, Krzysztof Kozlowski wrote:
> Reference common serial properties bindings to allow typical serial
> properties:
> 
>   meson-axg-jethome-jethub-j100.dtb: serial@23000: 'bluetooth', 'uart-has-rtscts' do not match any of the regexes: 'pinctrl-[0-9]+'
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
> 
> ---
> 
> Changes since v1:
> 1. Add tag
> 2. Use local path (not absolute to /schemas/serial/serial.yaml)
> ---
>  .../devicetree/bindings/serial/amlogic,meson-uart.yaml       | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
