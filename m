Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D9C4606B57
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 00:38:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbiJTWi3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 18:38:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbiJTWiW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 18:38:22 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA5071C5A73
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 15:38:21 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id d26so2952082ejc.8
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 15:38:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XAlG+R0L7V+c4eZDAFmMDuMjD1uoa7yYl/auqG4oieg=;
        b=lCSU0pfPqttzas41dzzOVDLE8MRyVU6xsbN3m/xliJTSEf2HWDALXIhYf3eFJpNqz2
         s/OINIMF4ZnOwrMjhjK67BPZNqp35rlxs7poQ+JinQUFanBXyXVN+aPFHV6f10MI54G6
         Fg7GdbnK+v2Th23F/IBs9FGrI+ORoqheZxqwI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XAlG+R0L7V+c4eZDAFmMDuMjD1uoa7yYl/auqG4oieg=;
        b=YxxGrCa+fZ3MFkvE10/d5vFVzAEUJ8SpfiLNkmB7qg0p9c3IgAdI6v4oTIBHCI4gT9
         H159YsROQZcPwL2rwXQlJWajAnQrJ1Yfp9qukAvaFJBtjf4BeG7hNK/onAipe2XxbqcC
         010dBqf7u8gBkMz7cf+8OgWBejpUJsEuqfz41wQsBs2KQ26CljK3+pgK1Yl9NHSXR2Im
         NEEM0dRYYpF/tVhKX2xSUA67p86s4MUviQ0NuHOiQEL/CtWl/59NeYZboTBgKcQu77xz
         PmoKnWye8z3ayr6czcSvhtJS37bJaXDozlScvtSOCdsw5f7XGTmuflIPIHcdWX2B1p8L
         dMnw==
X-Gm-Message-State: ACrzQf2AtltT1c5Hk6zybvGCIJk8X62eGCamVmyiNs5QwOUzJQMuJCd8
        q/LahBfseVlbLRJe6HowV+k1/rn2lg9BVCtR
X-Google-Smtp-Source: AMsMyM7+zJp9Z32kdytaI5kZmFXPzneAUfDQoVMw0p2tiHvryftNofbC/StNQlAAlKfDqdDTRyLhsQ==
X-Received: by 2002:a17:907:e93:b0:78d:b8ff:9b5f with SMTP id ho19-20020a1709070e9300b0078db8ff9b5fmr13079481ejc.12.1666305500570;
        Thu, 20 Oct 2022 15:38:20 -0700 (PDT)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com. [209.85.221.52])
        by smtp.gmail.com with ESMTPSA id sd42-20020a1709076e2a00b00722e50dab2csm10864609ejc.109.2022.10.20.15.36.43
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Oct 2022 15:37:17 -0700 (PDT)
Received: by mail-wr1-f52.google.com with SMTP id w18so1814238wro.7
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 15:36:43 -0700 (PDT)
X-Received: by 2002:adf:9d8a:0:b0:230:5212:d358 with SMTP id
 p10-20020adf9d8a000000b002305212d358mr10213052wre.405.1666305392092; Thu, 20
 Oct 2022 15:36:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220901024827.v3.1.I3aa360986c0e7377ea5e96c116f014ff1ab8c968@changeid>
 <166606235849.3553294.10700447109437637515.b4-ty@kernel.org>
In-Reply-To: <166606235849.3553294.10700447109437637515.b4-ty@kernel.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 20 Oct 2022 15:36:20 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WXGGHTAgH7O6MP3eOp4HLAwkBAOJ9L63ow3PSdkUtCYg@mail.gmail.com>
Message-ID: <CAD=FV=WXGGHTAgH7O6MP3eOp4HLAwkBAOJ9L63ow3PSdkUtCYg@mail.gmail.com>
Subject: Re: (subset) [PATCH v3 1/2] dt-bindings: arm: qcom: Document
 additional skus for sc7180 pazquel360
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        yunlong.jia@ecs.corp-partner.google.com, henrysun@google.com,
        devicetree@vger.kernel.org, moragues@chromium.org,
        agross@kernel.org, robh+dt@kernel.org,
        linux-arm-msm@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Oct 17, 2022 at 8:15 PM Bjorn Andersson <andersson@kernel.org> wrote:
>
> On Thu, 1 Sep 2022 02:49:57 +0000, Yunlong Jia wrote:
> > pazquel360 is an extension project based on pazquel.
> > We create 3 sku on pazquel360:
> >    sku 20 for LTE with physical SIM _and_ eSIM and WiFi
> >    sku 21 for WiFi only
> >    sku 22 for LTE with only a physical SIM
> >  Both sku20 and sku22 are LTE SKUs.
> >  One has the eSIM stuffed and one doesn't.
> >  There is a single shared device tree for the two.
> >
> > [...]
>
> Applied, thanks!
>
> [1/2] dt-bindings: arm: qcom: Document additional skus for sc7180 pazquel360
>       commit: 185d192d0a7b565a24b3f7456a2f84f169ab087a
> [2/2] arm64: dts: qcom: Add sc7180-pazquel360
>       commit: 2f72a4f54cdb4fd0ebea9a2dea65756d3e676be2

FWIW, it looks like you landed v3 instead of v5. See:

https://lore.kernel.org/r/20220923083657.v5.3.Iea2d2918adfff2825b87d428b5732717425c196f@changeid/

Presumably something about your process got confused because Yunlong
changed the email address they were sending it from (I think someone
requested not to use an "corp-partner" email address).

The other difference between v3 and v5 is the touchscreen. Presumably
Yunlong can send a followup patch to add the touchscreen atop what
you've landed.

-Doug
