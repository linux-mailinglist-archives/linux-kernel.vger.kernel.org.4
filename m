Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 181BB62FCE2
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 19:38:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242462AbiKRSiZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 13:38:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241522AbiKRSiV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 13:38:21 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9511A82BD0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 10:38:20 -0800 (PST)
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com [209.85.219.199])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 670AC3F135
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 18:38:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1668796699;
        bh=RYI02dFt068UY8kg1Ox7tYgeDjuqkOHogBD3aOmXEwg=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=vutEVjI0ad/P0pPg2V1NRd237Bgq66aqia+K+wjd9uuDGRiFC+4e2HOVUqVq6SCTN
         w3BDeVBgAV4kO1TCVWk83VmHC3RcyoVzjbtzTJfPwOXRm3s+vW7TCVQzZCgNdHEpvr
         GUS7IQakhzEVReqjUIUcJFnEdUnrkZxQbjsgJV4xDp28mSoy7mu4Plf7A7x3QcuX/2
         ZpNkpvlDs65tedn/TxpmdnWWz3WOSRSkX2mkIs/j/8Ss9aqOryAGlEQYRHqZ0sDMGj
         w4oFwPr6Bmdedku7wC1eHAVvK3J0xWevFe9bj55SDBctRVJhcQxiRHbaSv7dowsQ8S
         ayxycP5vl539g==
Received: by mail-yb1-f199.google.com with SMTP id f126-20020a255184000000b006cb2aebd124so5164470ybb.11
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 10:38:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RYI02dFt068UY8kg1Ox7tYgeDjuqkOHogBD3aOmXEwg=;
        b=6Pjm51c3sVlzlPhuYbBe98KS+NnWMu1pDGxxQOKC09ZmsOKV/WqOwPoneo9k/42TIw
         WfG1sxRWJJFkmU3DALb266wptdMrZ6EuGHveqmmYAj6U+JndQqN5Ucizc26qcSbkbMTt
         1nq6HyNaqqZS8YRO5CCpLJdPt+p7sh9PhVn7NVP+hK+I37abCWqsS9upXAagsUR7ofwJ
         cNWv3aWv0iw8MM2xusKcaIf+cQWcymNs/hnHqBNRvS5HkxjZZ8rzCPuIY0ct/yWtQtmg
         +5BwOo0ip8U/jdiaeE4TKuT0bCX8hDzO7h7JVqQkffiaZfI16WbhxSkj7/n2nhCcermY
         zSJw==
X-Gm-Message-State: ANoB5plp4W0HLJlNhKWWUgSzi1MmqHoAwCYFxfhswvUWmxu55f4qxU9o
        mwCROEWHumPPesevkYAu0cRpQ14mTqRzu7F0xFvPvwQnwD1lkygbO7mUnWLxlZ/aKPpU+N0IFDQ
        uYoxBDp/j/MJ1ZXwiDrp8213rlD4CpgmtKDkEwGWwWBou1dgB6RK48CrGeQ==
X-Received: by 2002:a25:510:0:b0:6d2:e45c:71c0 with SMTP id 16-20020a250510000000b006d2e45c71c0mr7835985ybf.153.1668796698037;
        Fri, 18 Nov 2022 10:38:18 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4IKtz+bGERRUU6t0gtG+/NROqFnzOSm0Wda5mFXqM87Jebl5N3WBApoYT3Wr9SjFb4XHz8OAX5vTxVq7XpuhI=
X-Received: by 2002:a25:510:0:b0:6d2:e45c:71c0 with SMTP id
 16-20020a250510000000b006d2e45c71c0mr7835971ybf.153.1668796697793; Fri, 18
 Nov 2022 10:38:17 -0800 (PST)
MIME-Version: 1.0
References: <20221118133216.17037-1-walker.chen@starfivetech.com>
In-Reply-To: <20221118133216.17037-1-walker.chen@starfivetech.com>
From:   Emil Renner Berthing <emil.renner.berthing@canonical.com>
Date:   Fri, 18 Nov 2022 19:38:01 +0100
Message-ID: <CAJM55Z_OGDrCHs++9w4FhG-mZzGzOsnHZT77Q6BDJOGWX7eXJQ@mail.gmail.com>
Subject: Re: [PATCH v1 0/4] JH7110 Power Domain Support
To:     Walker Chen <walker.chen@starfivetech.com>
Cc:     linux-riscv@lists.infradead.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Nov 2022 at 14:34, Walker Chen <walker.chen@starfivetech.com> wrote:
>
> This patchset adds power domain controller driver for the StarFive JH7110 SoC.
> The series has been tested on the VisionFive 2 board.

Hi Walker,

Thanks for upstreaming this! I've left some comments on the individual patches.

/Emil

> This patchset should be applied after the patchset [1], [2], [3]:
> [1] https://lore.kernel.org/all/20221118010627.70576-1-hal.feng@starfivetech.com/
> [2] https://lore.kernel.org/all/20221118011108.70715-1-hal.feng@starfivetech.com/
> [3] https://lore.kernel.org/all/20221118011714.70877-1-hal.feng@starfivetech.com/
>
> Walker Chen (4):
>   dt-bindings: power: Add StarFive JH7110 power domain definitions
>   dt-bindings: power: Add starfive,jh71xx-power bindings
>   soc: starfive: Add StarFive JH71XX pmu driver
>   riscv: dts: starfive: add power controller node
>
>  .../bindings/power/starfive,jh71xx-power.yaml |  46 +++
>  MAINTAINERS                                   |   8 +
>  arch/riscv/boot/dts/starfive/jh7110.dtsi      |   7 +
>  drivers/soc/Kconfig                           |   1 +
>  drivers/soc/Makefile                          |   1 +
>  drivers/soc/starfive/Kconfig                  |   9 +
>  drivers/soc/starfive/Makefile                 |   3 +
>  drivers/soc/starfive/jh71xx_pmu.c             | 380 ++++++++++++++++++
>  include/dt-bindings/power/jh7110-power.h      |  18 +
>  include/soc/starfive/pm_domains.h             |  15 +
>  10 files changed, 488 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/starfive,jh71xx-power.yaml
>  create mode 100644 drivers/soc/starfive/Kconfig
>  create mode 100644 drivers/soc/starfive/Makefile
>  create mode 100644 drivers/soc/starfive/jh71xx_pmu.c
>  create mode 100644 include/dt-bindings/power/jh7110-power.h
>  create mode 100644 include/soc/starfive/pm_domains.h
>
>
> base-commit: 094226ad94f471a9f19e8f8e7140a09c2625abaa
> prerequisite-patch-id: 8ebfffa09b478904bf7c516f76e2d824ddb60140
> prerequisite-patch-id: e8dd8258a4c4062eee2cf07c4607d52baea71f3a
> prerequisite-patch-id: d050d884d7b091ff30508a70f5ce5164bb3b72e5
> prerequisite-patch-id: 0e41f8cfd4861fcbf6f2e6a2559ce28f0450299e
> prerequisite-patch-id: 6e1652501859b85f101ff3b15ced585d43c71c1b
> prerequisite-patch-id: 587628a67adad5c655e5f998bf6c4a368ec07d3c
> prerequisite-patch-id: 596490c0e397df6c0249c1306fbb1d5bf00b5b83
> prerequisite-patch-id: dc873317826b50364344b25ac5cd74e811403f3d
> prerequisite-patch-id: a50150f41d8e874553023187e22eb24dffae8d16
> prerequisite-patch-id: 735e62255c75801bdc4c0b4107850bce821ff7f5
> prerequisite-patch-id: 9d2e83a2dd43e193f534283fab73e90b4f435043
> prerequisite-patch-id: 7a43e0849a9afa3c6f83547fd16d9271b07619e5
> prerequisite-patch-id: e7aa6fb05314bad6d94c465f3f59969871bf3d2e
> prerequisite-patch-id: 6276b2a23818c65ff2ad3d65b562615690cffee9
> prerequisite-patch-id: d834ece14ffb525b8c3e661e78736692f33fca9b
> prerequisite-patch-id: 4c17a3ce4dae9b788795d915bf775630f5c43c53
> prerequisite-patch-id: dabb913fd478e97593e45c23fee4be9fd807f851
> prerequisite-patch-id: ba61df106fbe2ada21e8f22c3d2cfaf7809c84b6
> prerequisite-patch-id: 287572fb64f83f5d931034f7c75674907584a087
> prerequisite-patch-id: 536114f0732646095ef5302a165672b3290d4c75
> prerequisite-patch-id: 258ea5f9b8bf41b6981345dcc81795f25865d38f
> prerequisite-patch-id: 8b6f2c9660c0ac0ee4e73e4c21aca8e6b75e81b9
> prerequisite-patch-id: e09e995700a814a763aa304ad3881a7222acf556
> prerequisite-patch-id: 841cd71b556b480d6a5a5e332eeca70d6a76ec3f
> prerequisite-patch-id: d074c7ffa2917a9f754d5801e3f67bc980f9de4c
> prerequisite-patch-id: 5f59bc7cbbf1230e5ff4761fa7c1116d4e6e5d71
> prerequisite-patch-id: d5da3475c6a3588e11a1678feb565bdd459b548e
> --
> 2.17.1
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
