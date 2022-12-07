Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4CC86463FA
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 23:20:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbiLGWUB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 17:20:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbiLGWT5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 17:19:57 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20C5069AAC;
        Wed,  7 Dec 2022 14:19:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C3057B8218F;
        Wed,  7 Dec 2022 22:19:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76E6AC43470;
        Wed,  7 Dec 2022 22:19:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670451594;
        bh=Z6y1S2c4O/wQVEci3pG8Cjc3WmkGbiLwEfx3oMfIjck=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=OCzOmaGjJvSkeIY2d/ch72xW78HASiWEjCv+COoZdnTgvkbcLvkwqw9nRliNM7Nr7
         Vh5ZKgh6udrB+8stTTSMByhHAjlcp/qqbJ8HcYxS+wKcLi1v5EH17QABp3OodWWQja
         nYT3Yw8ShUY/8OMh7z0R0HWl2YvOAvbMtSypH42zZvCp7RNFIfLybieNj/DV0uJCOC
         BXDbq3pjWQpAMu2LpGYfaqHQN+39X8JkC3xgx7kA8D1GV5VPtn0dLPsNpkiNHGrtNo
         Q/c3+qkPf0oeD9Bvjzrb5Q2jX7ab7UTYIxO+yMVw608bhxM/dSOw681DSkG5CKRMPl
         GSbjoaiZaYfmA==
Received: by mail-ua1-f50.google.com with SMTP id e24so6502644uam.10;
        Wed, 07 Dec 2022 14:19:54 -0800 (PST)
X-Gm-Message-State: ANoB5pnDavVVUGpwlR+N8IDCtBRXSn5dXe6aQxCmM0VROPydGBFiBW6F
        v0G0mLmWjWehJeunLuxNtFwS4ijmWn9IKG3WAA==
X-Google-Smtp-Source: AA0mqf7sjL89XYXP7++xV6ahJfBPE5ZnuFqEZVVoFHM87m+y1bCKE4MXIBGEtgCvE7SaKjFdqV+bCcJFTgMrIRcBLr0=
X-Received: by 2002:ab0:1006:0:b0:419:70a:90cb with SMTP id
 f6-20020ab01006000000b00419070a90cbmr32720021uab.36.1670451593309; Wed, 07
 Dec 2022 14:19:53 -0800 (PST)
MIME-Version: 1.0
References: <20221207162435.1001782-1-herve.codina@bootlin.com>
In-Reply-To: <20221207162435.1001782-1-herve.codina@bootlin.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 7 Dec 2022 16:19:42 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJiZU=sHVPc92nDNoqUjm7FUb=u0izGYa+irkUW1XmA_w@mail.gmail.com>
Message-ID: <CAL_JsqJiZU=sHVPc92nDNoqUjm7FUb=u0izGYa+irkUW1XmA_w@mail.gmail.com>
Subject: Re: [PATCH v3 0/9] Add the Renesas USBF controller support
To:     Herve Codina <herve.codina@bootlin.com>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        Gareth Williams <gareth.williams.jx@renesas.com>,
        linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 7, 2022 at 10:24 AM Herve Codina <herve.codina@bootlin.com> wrote:
>
> Hi,
>
> This series add support for the Renesas USBF controller (USB Device
> Controller) available in the Renesas RZ/N1 SoC.
>
> Based on previous review:
>   https://lore.kernel.org/all/20221114111513.1436165-3-herve.codina@bootlin.com/
>
> A new strategy is proposed to handle the H2MODE bit from CFG_USB
> register compared to the previous versions on the series. As a
> reminder, H2MODE bit allows to configure the internal USB Port
> interface for two hosts or one host and one device.

Is this case any different from all the phandle properties we have in
bindings that point to some misc registers somewhere else you need to
poke? If so, I'm not really a fan of duplicating the information.

We also have cases of of_find_compatible_node(NULL, NULL,
"foo-bar-syscon") which is a dependency expressed in the driver, but
not DT. In either case, adding 'depends-on' would be an ABI break as
you are requiring a DT change.

> This new strategy is:
>   - Add the new generic 'depends-on' property in the device tree.
>
>     This generic property expresses an simple functionnal dependency
>     that does not rely on a specific topic. It is an 'order only'
>     dependency that can be used for dependencies between consumers
>     and producers that are not based on a specific infrastructure
>     and not need other relationship than this simple 'order only'
>     (ie no API is provided between the provider and the consumer)

Isn't getting a regmap an API?

Rob
