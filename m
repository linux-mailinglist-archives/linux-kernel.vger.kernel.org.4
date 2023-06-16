Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC2F1733A6C
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 22:06:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343863AbjFPUGo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 16:06:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230209AbjFPUGm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 16:06:42 -0400
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36F55359E
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 13:06:41 -0700 (PDT)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-1a2c9f087f0so1231053fac.3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 13:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686946000; x=1689538000;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OUAOcJJgWeLKPM/xF2GkuGhpodootZffZ1w5UrUmM2A=;
        b=SCP+UFTAEbi61pCdZMMomcocARY2TcdGTOInovhmvu9lJQPA5u0Jg0FfH9hS94x9LZ
         a5fHkaOxXIZM1PTjzY6SV7qbJC8ozcPe7u3+tKgAWg8UM4K+4dkPG6BkpV7Rf5jMhSZT
         kVV4tCydQ5aufNiRH539Q/F/j5pL0DaMqra+xpfcVLOv2rLnhsCASQEzPulILnYy382o
         /LDMkLbMrW4bZ3QLoABvZ8kQWA1l0vdD6chKvhxxxi+6lclB7lw+eK51DlTBHIqKad3R
         LIQPizamgh7ivl81+ZV+EF89XtZ1krd7N0ZVoVfk2mda4FVwWDaO5Aig2VQkzDMEj2hk
         b/ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686946000; x=1689538000;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OUAOcJJgWeLKPM/xF2GkuGhpodootZffZ1w5UrUmM2A=;
        b=Q67uCgT4z53B1vdpn4ccAd8dewXPZ9+b7/TPgT0xTKVIShgmYAzfvA3/fErlLFtg6t
         zyzkRinrLTuF120dMEmnl3FC80ERQyB3B+3fVimby0mXSJVfcVmmYsAJdn9HfI7J2TRt
         iFtMNh4jw/c69AEeN1frA9pYkz0HmiZLb6L+AkCqPGKCVIp0rhVemVo8bhmSsWEilnf/
         jz1mKZQararIpxi542USQ85/Cxhw/9kZPTR22q11/KyYnvYvYE7X0uZGiWrnDNg6bTIH
         KuhjcZjMZ2DPV3ssNt0xQvzFRq9QR50zao1JMoYH7/qT0+gfLNV5P27s3lULhHW4vgsJ
         yZRA==
X-Gm-Message-State: AC+VfDzYV2bVjtiLNi0FHlLF2aw2r7MrQ+3dMxS5U0quBG1sDN2hNOso
        UMQ/9O1F0KQvlaZIER5JErHCcbR1rspvwO4MyFTkjA==
X-Google-Smtp-Source: ACHHUZ75K3KBcIrOD/dTCPzbUfDJYBDcThDV31eSyMdQR30gv5EAxMrPJP3qrkBEZFYins48R5Wov/Uhfr+KXOuXKsU=
X-Received: by 2002:a05:6870:2e04:b0:1a6:8fa1:10b4 with SMTP id
 oi4-20020a0568702e0400b001a68fa110b4mr123529oab.37.1686946000401; Fri, 16 Jun
 2023 13:06:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230616035813.255062-1-jaswinder.singh@linaro.org>
 <165dd295-1b3a-5062-772a-613a7bf6fd45@linaro.org> <CAJe_ZhdV3yaKUVD43duO4hkGMByJhq7x9bN+eBXJdBXdxgDneg@mail.gmail.com>
 <e2b98d80-8e9a-6083-3bc5-677bef0d3263@linaro.org>
In-Reply-To: <e2b98d80-8e9a-6083-3bc5-677bef0d3263@linaro.org>
From:   Jassi Brar <jaswinder.singh@linaro.org>
Date:   Fri, 16 Jun 2023 15:06:29 -0500
Message-ID: <CAJe_ZhfeYmxjR7Hcht0F9rc97VG2JCFEEFB+S5kUhSCmsut3Cg@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: arm: socionext: add bindings for the
 Synquacer platform
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, robh@kernel.org,
        ilias.apalodimas@linaro.org, masahisa.kojima@linaro.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Jun 2023 at 11:47, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 16/06/2023 18:23, Jassi Brar wrote:
> > On Fri, 16 Jun 2023 at 05:15, Krzysztof Kozlowski
> > <krzysztof.kozlowski@linaro.org> wrote:
> >>
> >> On 16/06/2023 05:58, jaswinder.singh@linaro.org wrote:
> >>> From: Jassi Brar <jaswinder.singh@linaro.org>
> >>>
> >>> Socionext's DeveloperBox is based on the SC2A11B SoC (Synquacer).
> >>> Specify bindings for the platform and boards based on that.
> >>
> >> A nit, subject: drop second/last, redundant "bindings". The
> >> "dt-bindings" prefix is already stating that these are bindings.
> >>
> > I can remove it, but I see many mentions like "Fix bindings for"  "Add
> > binding for" etc in the subject line.
>
> Can we fix them as well?
>
??


> >
> >>
> >> Binding without it's user is usually useless. Where is the user?
> >>
> > It is required for SystemReady-2.0 certification.
>
> For what? If there is no user, it is not required for SR. We don't
> document compatibles for something which does not exist in the projects.
>
The dts/dtsi for synquacer will be added later.
I am sure you are aware that there are countless bindings without
actual use in any dts/dtsi. When exactly did it become mandatory to
have dts/dtsi for the bindings to be merged upstream?

-j
