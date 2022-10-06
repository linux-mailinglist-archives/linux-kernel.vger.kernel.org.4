Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F8E75F6E76
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 21:54:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232113AbiJFTx5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 15:53:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232117AbiJFTxv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 15:53:51 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACE91A8798
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 12:53:47 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id z3so3345017edc.10
        for <linux-kernel@vger.kernel.org>; Thu, 06 Oct 2022 12:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=unYkvJmsfR6dlOs+zRhOM60bKQNMvgN70UTbGzDFpNU=;
        b=XeRAWTD6REI3lmaLtlo7kvbRO5Y+EtS7cdn5tS9g95rBJG5rQqfSBch83/nVdYjZkI
         Z3H7ACRje5Os8DEpv8TmdNlDV9seyAAZlw8sjHyy04jQUv1y/T1Do2nlPr2GYG+B2/fk
         KBnLAtljSS4ih0sW8CXqu5SZSCAMRrdAlVv4s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=unYkvJmsfR6dlOs+zRhOM60bKQNMvgN70UTbGzDFpNU=;
        b=xw1BR/QITo5iPgWs5FnOD5/4Ywwk1kPsOZXavmZH9KkLJIa+CDDoFv1E5Ie/vu0BfS
         B5Rl0sQujZMMPljivOocFaFS5IasHCgV4vfRmX3/qOKTC6FYoj6v22jkfsZUTscnEHnj
         Xep/5JRuwz/K2TT424NC6tfelDCIBBDuBZ92kCz4/PpNhZ4WivxlhOJn5quPk7lSsyDD
         XHBfhobNov+ALOBpt7y4Phzc/SBTTnrJ8fe9ygDQu0p6+DvQKyM5jyMr9mGG6RNXVv2w
         xJPGYANKRktMBX1vo50XibqqAMCk/oE2Pn2FcpCo2MpgnnCqad3ysFywN+N6RnYV8su/
         oQvQ==
X-Gm-Message-State: ACrzQf2/VfB2y+QU8rASGv1IdNdl75l53UXO86TKe1RIguRTn43WjJte
        fieSmCS6Cd5I6okIIcv4XHZCp3ObUSJr0g==
X-Google-Smtp-Source: AMsMyM4o2C1qKa/FXlQiqsxVkrDRGh063J8LmKnWC85FNt7YcVL+rJ+5sV1W3h5xneCWHSMiAw5TWw==
X-Received: by 2002:aa7:cd4f:0:b0:458:6077:c3ac with SMTP id v15-20020aa7cd4f000000b004586077c3acmr1415363edw.32.1665086025608;
        Thu, 06 Oct 2022 12:53:45 -0700 (PDT)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com. [209.85.221.44])
        by smtp.gmail.com with ESMTPSA id su24-20020a17090703d800b00780982d77d1sm121327ejb.154.2022.10.06.12.53.44
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Oct 2022 12:53:45 -0700 (PDT)
Received: by mail-wr1-f44.google.com with SMTP id a10so4240073wrm.12
        for <linux-kernel@vger.kernel.org>; Thu, 06 Oct 2022 12:53:44 -0700 (PDT)
X-Received: by 2002:adf:f90d:0:b0:20c:de32:4d35 with SMTP id
 b13-20020adff90d000000b0020cde324d35mr997558wrr.583.1665086024696; Thu, 06
 Oct 2022 12:53:44 -0700 (PDT)
MIME-Version: 1.0
References: <20221006105823.532336-1-sheng-liang.pan@quanta.corp-partner.google.com>
 <20221006185333.v7.3.I52e4b4b20e2eb0ae20f2a9bb198aa6410f04cf16@changeid>
In-Reply-To: <20221006185333.v7.3.I52e4b4b20e2eb0ae20f2a9bb198aa6410f04cf16@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 6 Oct 2022 12:53:32 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Xe0x6pQ+Uq5Vo7cqvS0+O8qpwUwO-e6fWhSyFvdF-_Fg@mail.gmail.com>
Message-ID: <CAD=FV=Xe0x6pQ+Uq5Vo7cqvS0+O8qpwUwO-e6fWhSyFvdF-_Fg@mail.gmail.com>
Subject: Re: [PATCH v7 3/4] dt-bindings: input: touchscreen: Add goodix
 GT7986U touchscreen chip
To:     Sheng-Liang Pan <sheng-liang.pan@quanta.corp-partner.google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-input@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Oct 6, 2022 at 3:58 AM Sheng-Liang Pan
<sheng-liang.pan@quanta.corp-partner.google.com> wrote:
>
> Add an goodix touch screen chip GT7986U.

In theory you could beef up the commit message explaining that GT7986U
is expected to be fully compatible with a driver written for GT7375P,
but I wouldn't spin just for that.


> Signed-off-by: Sheng-Liang Pan <sheng-liang.pan@quanta.corp-partner.google.com>
> ---
>
> Changes in v7:
> - goodix gt7986 dt bindings added in v7
>
>  Documentation/devicetree/bindings/input/goodix,gt7375p.yaml | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/input/goodix,gt7375p.yaml b/Documentation/devicetree/bindings/input/goodix,gt7375p.yaml
> index fe1c5016f7f31..1c191bc5a1782 100644
> --- a/Documentation/devicetree/bindings/input/goodix,gt7375p.yaml
> +++ b/Documentation/devicetree/bindings/input/goodix,gt7375p.yaml
> @@ -16,8 +16,11 @@ description:
>
>  properties:
>    compatible:
> -    items:
> +    oneOf:
>        - const: goodix,gt7375p
> +      - items:
> +          - const: goodix,gt7986u
> +          - const: goodix,gt7375p

I haven't run this through schema validation, but from a visual
inspection it looks good to me.

Reviewed-by: Douglas Anderson <dianders@chromium.org>
