Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 384CD7047DA
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 10:31:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231655AbjEPIb0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 04:31:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231400AbjEPIbY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 04:31:24 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBED43C01
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 01:31:22 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-96598a7c5e0so2239927966b.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 01:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684225881; x=1686817881;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fJrRHHvdn9cIcQfp0JPPRbNPTEcfrFzeUxPf9kkkHTc=;
        b=j1beuBeSZe+UVyYZ1MAbv7wmEP7xdrMTg51dDEQpKh2/gBAdLrSbBP25YsjGg7fUwx
         5dAc1QLzct73WWzImcB3xUOppxKsN3TXMOweIgwnF0CVq3E1aPFxrrTA8i1AruavKaQL
         RnMlLhaAkwmHo1COZlGCZaWKGMm//PUwhqGQzCXKrYk0s0R4PrUjtFik+qPoGNwTOv++
         XiNyCfeoFdKAPZ9aMCDmtmaVCkYVQf5i2X04s2mxP8m+j3xATIF7Pii4WVzQhNSdJCwp
         5CEwN7I/9XyY1sEUHdA1fH4Lhnkj18IWSyKWSJ+QH4xWJYLrG+fHXM8r3ghz8iw3FBy/
         +YGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684225881; x=1686817881;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fJrRHHvdn9cIcQfp0JPPRbNPTEcfrFzeUxPf9kkkHTc=;
        b=C7eYmhK9As56LvveBP/1V72zkGcq+3a9j7yDrT6Z0h5B+5lz8Pkcg8LrTSiT5kebfp
         pmwsGqCf1MlAS2MSTHjNAb38eAQbQDrrP8EsG8kiyr0Dxo13yhL3QmR91RHScjk4YAcx
         EgiZHGrKku4JBg8Y5m7fN/aG25tdhwthA2RyOgDhYIbZd1uQP3721OAsuZ/GCUapaC0A
         jLkIQkHjVgxE775eP2FJiJ0yEUsxZa/8xVDK/41r8/glYpmiMvzUj2jXmqqpGwDn7IZT
         2sa21h3M8ya+mcZkXhwGGbmWpVnSMUcbhOwn2JgU8aOJNL17VpqJX6OQvy4yd3N9jRRs
         k+eQ==
X-Gm-Message-State: AC+VfDyeHd+G4ynNgPxmUL1w5gQJ1JoKeBUvQj9Y9UHQIvKoAG/MkCPs
        348cSoUFJ6sfQ3DmaRrAM24u2A==
X-Google-Smtp-Source: ACHHUZ6+jDG0i1U9Fqrfgt+X3qixvbCY3aIL6zYlY6ZsMgZKf0AGcygYOPl1aNEA7rNzqVUDd2Sw+Q==
X-Received: by 2002:a17:907:3609:b0:94f:4102:25c8 with SMTP id bk9-20020a170907360900b0094f410225c8mr34220660ejc.61.1684225881006;
        Tue, 16 May 2023 01:31:21 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:4d4a:9b97:62e:1439? ([2a02:810d:15c0:828:4d4a:9b97:62e:1439])
        by smtp.gmail.com with ESMTPSA id jz14-20020a17090775ee00b00969cbd5718asm10298198ejc.48.2023.05.16.01.31.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 May 2023 01:31:20 -0700 (PDT)
Message-ID: <cf1c6b8c-8a3f-eca1-948f-e41946d4c34c@linaro.org>
Date:   Tue, 16 May 2023 10:31:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v1] Documentation/process: add soc maintainer handbook
Content-Language: en-US
To:     Conor Dooley <conor@kernel.org>, soc@kernel.org
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Olof Johansson <olof@lixom.net>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org
References: <20230515-geometry-olympics-b0556ff8a5f7@spud>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230515-geometry-olympics-b0556ff8a5f7@spud>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/05/2023 21:20, Conor Dooley wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
> 
> Arnd suggested that adding maintainer handbook for the SoC "subsystem"
> would be helpful in trying to bring on board maintainers for the various
> new platforms cropping up in RISC-V land.
> 
> Add a document briefly describing the role of the SoC subsystem and some
> basic advice for (new) platform maintainers.
> 
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>



> +
> +What the SoC tree is not, however, is a location for architecture specific code
> +changes.  Each architecture has it's own maintainers that are responsible for
> +architectural details, cpu errata and the like.
> +
> +Information for (new) Sub-maintainers
> +-------------------------------------
> +
> +As new platforms spring up, they often bring with them new submaintainers,
> +many of whom work for the silicon vendor, and may not be familiar with the
> +process.
> +
> +devicetree ABI stability
> +~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +Perhaps one of the most important things to highlight is that dt-bindings
> +document the ABI between the devicetree and the kernel.  Once dt-bindings have
> +been merged (and appear in a release of the kernel) they are set in stone, and
> +any changes made must be compatible with existing devicetrees.  This means that,
> +when changing properties, a "new" kernel must still be able to handle an old
> +devicetree.  For many systems the devicetree is provided by firmware, and
> +upgrading to a newer kernel cannot cause regressions.  Ideally, the inverse is
> +also true, and a new devicetree will also be compatible with an old kernel,
> +although this is often not possible.

I would prefer to skip it and instead: enhance
Documentation/devicetree/bindings/ABI.rst and then reference it here.

> +
> +If changes are being made to a devicetree that are incompatible with old
> +kernels, the devicetree patch should not be applied until the driver is, or an
> +appropriate time later.  Most importantly, any incompatible changes should be
> +clearly pointed out in the patch description and pull request, along with the
> +expected impact on existing users.


> +
> +Driver branch dependencies
> +~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +A common problem is synchronizing changes between device drivers and devicetree
> +files, even if a change is compatible in both directions, this may require
> +coordinating how the changes get merged through different maintainer trees.
> +
> +Usually the branch that includes a driver change will also include the
> +corresponding change to the devicetree binding description, to ensure they are
> +in fact compatible.  This means that the devicetree branch can end up causing
> +warnings in the "make dtbs_check" step.  If a devicetree change depends on
> +missing additions to a header file in include/dt-bindings/, it will fail the
> +"make dtbs" step and not get merged.
> +
> +There are multiple ways to deal with this:
> +
> + - Avoid defining custom macros in include/dt-bindings/ for hardware constants
> +   that can be derived from a datasheet -- binding macros in header file should
> +   only be used as a last resort if there is no natural way to define a binding
> +
> + - Use literal values in the devicetree file in place of macros even when a
> +   header is required, and change them to the named representation in a
> +   following release

I actually prefer such solution:

 - Duplicate defines in the devicetree file hidden by #ifndef section
and remove them later in a following release

We can keep both, but mine above leads to cleaner changes in DTS file.

> +
> + - Defer the devicetree changes to a release after the binding and driver have
> +   already been merged
> +
> + - Change the bindings in a shared immutable branch that is used as the base for
> +   both the driver change and the devicetree changes

The policy told to me some time ago was that no merges from driver
branch or tree are allowed towards DTS branch, even if they come only
with binding header change. There are exceptions for this, e.g. [1], but
that would mean we need to express here rules for cross-tree merges.

[1]
https://lore.kernel.org/linux-samsung-soc/cced7901-a855-c733-e716-f4a7f822b213@canonical.com/T/#m6430408367e942ac28d01e447be84fcf34407743

> +
> +devicetree naming convention
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +The general naming scheme for devicetree files are as follows.  The aspects of a
> +platform that are set at the SoC level, like cpu cores, are contained in a file
> +named $soc.dtsi, for example, jh7100.dtsi.  Integration details, that will vary
> +from board to board, are described in $soc-$board.dtsi.  An example of this is
> +jh7100-beaglev-starlight.dts.  Often many boards are variations on a theme, and
> +frequently there are intermediate files, such as jh7100-common.dtsi, which sit
> +between the $soc.dtsi and $soc-$board.dts files, containing the descriptions of
> +common hardware.
> +
> +Some platforms also have System on Modules, containing an SoC, which are then
> +integrated into several different boards. For these platforms, $soc-$som.dtsi
> +and $soc-$som-$board.dts are typical.
> +
> +Directories are usually named after the vendor of the SoC at the time of it's
> +inclusion, leading to some historical directory names in the tree.
> +
> +dtbs_check
> +~~~~~~~~~~
> +
> +``make dtbs_check`` can be used to validate that devicetree files are compliant
> +with the dt-bindings that describe the ABI.  Please see :ref:`running-checks`
> +for more information on the validation of devicetrees.
> +
> +For new platforms, or additions to existing ones, ``make dtbs_check`` should not
> +add any new warnings.  For RISC-V, as it has the advantage of being a newer
> +architecture, ``make dtbs_check W=1`` is required to not add any new warnings.
> +If in any doubt about a devicetree change, reach out to the devicetree
> +maintainers.
> +
> +
> +Branches and Pull Requests
> +~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +Just as the main SoC tree has several branches, it is expected that
> +submaintainers will do the same. Driver, defconfig and devicetree changes should
> +all be split into separate branches and appear in separate pull requests to the
> +SoC maintainers.  Each branch should be usable by itself and avoid
> +regressions that originate from dependencies on other branches.
> +
> +Small sets of patches can also be sent as separate emails to soc@kernel.org,
> +grouped into the same categories.
> +
> +If changes do not fit into the normal patterns, there can be additional
> +top-level branches, e.g. for a treewide rework, or the addition of new SoC
> +platforms including dts files and drivers.
> +
> +Branches with a lot of changes can benefit from getting split up into separate
> +topics branches, even if they end up getting merged into the same branch of the
> +SoC tree.  An example here would be one branch for devicetree warning fixes, one
> +for a rework and one for newly added boards.
> +
> +Another common way to split up changes is to send an early pull request with the
> +majority of the changes at some point between rc1 and rc4, following up with one
> +or more smaller pull requests towards the end of the cycle that can add late
> +changes or address problems idenfied while testing the first set.
> +
> +While there is no cut-off time for late pull requests, it helps to only send
> +small branches as time gets closer to the merge window.
> +
> +Pull requests for bugfixes for the current release can be sent at any time, but
> +again having multiple smaller branches is better than trying to combine too many
> +patches into one pull request.
> +
> +The subject line of a pull request should begin with "[GIT PULL]" and made using
> +a tag, rather than a branch.  This tag should contain a short description

a signed tag

>  

Best regards,
Krzysztof

