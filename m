Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AA1E638CDE
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 16:01:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230219AbiKYPBf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 10:01:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230178AbiKYPB2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 10:01:28 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A4D94090D
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 07:01:27 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id e7-20020a17090a77c700b00216928a3917so7947152pjs.4
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 07:01:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YzoqxWzLbAC5xaHv8eIezGdeIdLYxY/4HqUGgZdz7Wg=;
        b=kH2Y3AbvfupiLGAvBUpirk8wOJGQvhlGXVI+TfDSUxOl8Je0lhyt7M93SsymrAoud9
         h8cFSWSTqxMUROM0H3V7xWIODzPRwg3ELTUP0F6XECXzf3DjNWcw6Ik9v8+GOrtNX5Cm
         ZSNYkpgs/h1h2rp9L87+Go1SFzDiP+9pTOu8TZ8npftunTgpx/0V8nSomCBgHla4VIHn
         Dy5CxI2d+NG5mQ/Icl4P0XRXXKoZz+cjjM1XIrET1kQQJ6xd9Kex9LMBpTuNj65gHk1i
         RLcevdCo7p/+djBxzaGpSDD92VetqSy81l6taHZeLlS3RFsM2yp/XWCsmeT4IVEMsDIM
         Cl8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YzoqxWzLbAC5xaHv8eIezGdeIdLYxY/4HqUGgZdz7Wg=;
        b=F6ZFL+k2JdpingKCLAPwbL3oxpfvzWfrNHmIOKvLGdoyIHPIhwtCPWsfa2AoY23oQd
         ZOsf6RZqUd7DUs6QidBcWh1WJpuilWJbVdZjoMKla8cYynLIUhMEyY/Np/cypC41t3NQ
         RdpG7aO9sWJUjgzv1tgSpnDt0wMEdZZD6KGxiC5Z0C2NOpWPxFJvzl4bw2k2UCw9uN2s
         qOcwrMy7X76/dofQycmr/kGwjfnCGIyMe25lRjWW5qwnRyaNL5HKMoS+z95O/JgPihHS
         AXBqYL0We5Gyl+/bxydtjrA8xICcr6j+q7RfmCFhyUbVzQOWFgIjUMXTdHS/SnOz0DBi
         F3yw==
X-Gm-Message-State: ANoB5pnZtI08LOnQU2K43LDpZDYEl5drApWGqHjrcUdsuKAobXURjrfS
        sKxo3b1M4UEAUzlctxhUfMG4bxmYy12PFPUjWIvLzg==
X-Google-Smtp-Source: AA0mqf6shePmYKZfIf2OuYXE1zqCj37yUbefhBb4iV1YXC+qj6V5THYvuSCQVCkOaevgbGxM+Iz85hWJZHl4Ut5UbPc=
X-Received: by 2002:a17:903:258b:b0:189:1b50:f9e with SMTP id
 jb11-20020a170903258b00b001891b500f9emr19878838plb.74.1669388486600; Fri, 25
 Nov 2022 07:01:26 -0800 (PST)
MIME-Version: 1.0
References: <20221125112201.240178-1-krzysztof.kozlowski@linaro.org>
 <20221125112201.240178-4-krzysztof.kozlowski@linaro.org> <CAPLW+4nSLP4ZpnzYrOfMu0uOQ0OYnWsnZ=sUppxts6O_3-yYZg@mail.gmail.com>
 <ff33d45c-f4ad-49f3-24b6-b15b4af5aa83@linaro.org>
In-Reply-To: <ff33d45c-f4ad-49f3-24b6-b15b4af5aa83@linaro.org>
From:   Sam Protsenko <semen.protsenko@linaro.org>
Date:   Fri, 25 Nov 2022 09:01:15 -0600
Message-ID: <CAPLW+4kHef4pMNMbc8kvKzM0v0qBMoX6zwH1QCQKcLLubfcWXg@mail.gmail.com>
Subject: Re: [PATCH 4/4] dt-bindings: soc: samsung: exynos-sysreg: add clocks
 for Exynos850
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org,
        Sriranjani P <sriranjani.p@samsung.com>,
        Chanho Park <chanho61.park@samsung.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Nov 2022 at 08:49, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 25/11/2022 15:38, Sam Protsenko wrote:
> > On Fri, 25 Nov 2022 at 05:22, Krzysztof Kozlowski
> > <krzysztof.kozlowski@linaro.org> wrote:
> >>
> >> Exynos850 has dedicated clock for accessing SYSREGs.  Allow it, even
> >> though Linux currently does not enable them and relies on bootloader.
> >>
> >
> > Not sure if this description is correct. Of course, there is no driver
> > for "samsung,exynos850-sysreg" compatible at the moment, so the next
> > compatible from the list ("syscon") is used for Exynos850. And
> > "syscon" driver (drivers/mfd/syscon.c) actually does control the
> > clocks. I remember adding "clocks" property to Exynos850 dts to fix
> > actual problem. Also, the "clocks" property is not described in
> > Documentation/devicetree/bindings/mfd/syscon.yaml, didn't really check
> > if it's ok or it's just missing.
> >
> > Other than that comment:
> >
> > Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>
> >
> >> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>
> Ah, then commit msg is not good. I'll update it and maybe the clocks
> should be required for Exynos850?
>

Yeah, looks like all Exynos850 sysreg blocks have dedicated clock.
Please make it required. And thanks for working on that! :)

> Best regards,
> Krzysztof
>
