Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10592750295
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 11:13:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232806AbjGLJMt convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 12 Jul 2023 05:12:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjGLJMo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 05:12:44 -0400
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEFC8F9;
        Wed, 12 Jul 2023 02:12:43 -0700 (PDT)
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-bc379e4c1cbso7771951276.2;
        Wed, 12 Jul 2023 02:12:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689153163; x=1691745163;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K9F/x6582lk37reIeB18SnK4WCkuUe1D9J8p4xQoxLk=;
        b=GyZpZxu9DfV8ebVuI9GfzgPn/5x6Xy2uhg1RwBR1aQIhMcxCgSlxgmvOC1qv401ZvF
         5cxbSeZGrpoGTHh4r3UXjw/89Aq7mKROxYImuI6sBraty4Z52pYd4eDGpgXg9+huzSMb
         zuItOLPHHfqaJ9YN9O7IyHqov17trzCeeTyj69lyEi1PHzZEhCOVpeKh4IisPF735w6c
         VOs9jFYqaz6Hwi3DIMbWW9JNRcDmJjtlV0MuL7Y/Zm82+cloLHTDIy33DgTQGsSiBH4n
         dtRDyr7/UvgFxgD8vtE74K4t475U1lZEbtV0vZZTneNcTPUnq2udnvFB4JSa5rEsUfwD
         HMTA==
X-Gm-Message-State: ABy/qLYaqOGxo3lsRARw9V0dSkUU6R2erOKak0Q993ZBtns2lOt0pj+9
        6InVTWHiZwkyVuvPb5UVlJ2BYZin/CgFsA==
X-Google-Smtp-Source: APBJJlFXS1MAWsa3tSyUiLO/LR1WxuGeQRENeoebikp/W8MX90mLJPrpyHYkg4Y/kxrNaaY6iFU7cA==
X-Received: by 2002:a25:adda:0:b0:c76:173c:6718 with SMTP id d26-20020a25adda000000b00c76173c6718mr11346245ybe.1.1689153162722;
        Wed, 12 Jul 2023 02:12:42 -0700 (PDT)
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com. [209.85.219.169])
        by smtp.gmail.com with ESMTPSA id p8-20020a25f448000000b00c62e0df7ca8sm856853ybe.24.2023.07.12.02.12.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jul 2023 02:12:42 -0700 (PDT)
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-c2cf4e61bc6so7771211276.3;
        Wed, 12 Jul 2023 02:12:42 -0700 (PDT)
X-Received: by 2002:a25:4c85:0:b0:c24:4536:1723 with SMTP id
 z127-20020a254c85000000b00c2445361723mr17223170yba.26.1689153162357; Wed, 12
 Jul 2023 02:12:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230712-squealer-walmart-9587342ddec1@wendy>
In-Reply-To: <20230712-squealer-walmart-9587342ddec1@wendy>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 12 Jul 2023 11:12:28 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWzHSPRjJRyj0BWEBD6t6MMmRSzkbu9coGZS4bcd8yEjA@mail.gmail.com>
Message-ID: <CAMuHMdWzHSPRjJRyj0BWEBD6t6MMmRSzkbu9coGZS4bcd8yEjA@mail.gmail.com>
Subject: Re: [PATCH v1] riscv: dts: renesas: clean up dtbs_check W=1 warning
 due to empty phy node
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     conor@kernel.org, Magnus Damm <magnus.damm@gmail.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 12, 2023 at 10:15 AM Conor Dooley
<conor.dooley@microchip.com> wrote:
> dtbs_check w/ W=1 complains:
> Warning (unit_address_vs_reg): /soc/ethernet@11c20000/ethernet-phy@7: node has a unit name, but no reg or ranges property
> Warning (avoid_unnecessary_addr_size): /soc/ethernet@11c20000: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property
>
> The ethernet@11c20000 node is guarded by an `#if (!SW_ET0_EN_N)` in
> rzg2ul-smarc-som.dtsi, where the phy child node is added. In
> rzfive-smarc-som.dtsi, the ethernet node is marked disabled & the
> interrupt properties are deleted from the phy child node. As a result,
> the produced dts looks like:
>         ethernet@11c20000 {
>                 compatible = "renesas,r9a07g043-gbeth\0renesas,rzg2l-gbeth";
>                 /* snip */
>                 #address-cells = <0x01>;
>                 #size-cells = <0x00>;
>                 status = "disabled";
>
>                 ethernet-phy@7 {
>                 };
>         };
>
> Adding a corresponding `#if (!SW_ET0_EN_N)` around the node in
> rzfive-smarc-som.dtsi avoids the complaint, as the empty child node is
> not added:
>         ethernet@11c20000 {
>                 compatible = "renesas,r9a07g043-gbeth\0renesas,rzg2l-gbeth";
>                 /* snip */
>                 #address-cells = <0x01>;
>                 #size-cells = <0x00>;
>                 status = "disabled";
>         };
>
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-devel for v6.6.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
