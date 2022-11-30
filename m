Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB76F63E297
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 22:20:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbiK3VUa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 16:20:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbiK3VU1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 16:20:27 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC7418B190
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 13:20:25 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id ud5so44404478ejc.4
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 13:20:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=O/Z8JYSlIL5b/NaGmnUjVRx48qydsMASmxAsCA/K9VY=;
        b=JUEoYyGbYelG/R2BnPlxHeOgXELSGTlwMsJBPpwA13wQ1aBwg4OoDo5gbA/GNmqSZa
         bRcwHS+g5pqINlDo/prC0YD4RAuh6Tu4nU30bB83LRLstoc0/Hlnez//3Zrs/sMVYs1I
         MNkKE3p/oT3+gR+V9Bgg+BY4OJ2g1c1lMCT/g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O/Z8JYSlIL5b/NaGmnUjVRx48qydsMASmxAsCA/K9VY=;
        b=XVc5u1Xvm+/ZL6+A8kkZfEx8gJ+exi7KsVtamZYVSSOnQzzNrSakZElbTe9YrIKDh8
         5j0RdRXNJeGxJhU5U3fs29c09aZnsAGOCpdLq+Izxq9dYeGXFWZRJo9KGR9GTKUo6Apm
         Z8/UfPCCCb/wsqpZc6b/dYt8nmyE1bEAyVhYslvyXS8Gb0IYAVvnhPk0gEdTHyVvny7i
         69A4h+ucNK//p9Qte/jjo+kE6qck0ZnlQ+wDS2pVIGk3I1msoYO8Aa3x2oHGNNwwvOuE
         N276xj24Mi9jU8ABCqDI1YjGBwuyuNpJcuW/p8TJ3F4iWhCBJ7ufvLmpxqJvnCJU9cG9
         NHvA==
X-Gm-Message-State: ANoB5pnA6CjEUuG1x5jovqbyITEHqGOJYHFa4jekU1SBHX9t8IGp/lVG
        Y1ASvBaPn/nvKm+9DWcyXxF7y3bhUOoN7hCW
X-Google-Smtp-Source: AA0mqf4SkjWxvnnXnyoQ5zvoNdAs5JifPOBFwhgZQNz6661HwdUn/Tieq7rMkEqSo30bAX5RNOjLgg==
X-Received: by 2002:a17:906:a107:b0:77f:9082:73c7 with SMTP id t7-20020a170906a10700b0077f908273c7mr36682812ejy.517.1669843223876;
        Wed, 30 Nov 2022 13:20:23 -0800 (PST)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com. [209.85.221.51])
        by smtp.gmail.com with ESMTPSA id iy17-20020a170907819100b007c03fa39c33sm1033302ejc.71.2022.11.30.13.20.22
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Nov 2022 13:20:23 -0800 (PST)
Received: by mail-wr1-f51.google.com with SMTP id d1so29178433wrs.12
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 13:20:22 -0800 (PST)
X-Received: by 2002:adf:fb4c:0:b0:236:5270:735e with SMTP id
 c12-20020adffb4c000000b002365270735emr27787482wrs.659.1669843222443; Wed, 30
 Nov 2022 13:20:22 -0800 (PST)
MIME-Version: 1.0
References: <20221130142829.v10.1.Idfcba5344b7995b44b7fa2e20f1aa4351defeca6@changeid>
In-Reply-To: <20221130142829.v10.1.Idfcba5344b7995b44b7fa2e20f1aa4351defeca6@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 30 Nov 2022 13:20:09 -0800
X-Gmail-Original-Message-ID: <CAD=FV=VQ-NTEOtg7_BZRT8zMrmt0B1FEMxixCynmnCH+aciFqg@mail.gmail.com>
Message-ID: <CAD=FV=VQ-NTEOtg7_BZRT8zMrmt0B1FEMxixCynmnCH+aciFqg@mail.gmail.com>
Subject: Re: [PATCH v10 1/2] dt-bindings: arm: qcom: Add zombie
To:     Owen Yang <ecs.taipeikernel@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, Harvey <hunge@google.com>,
        Bob Moragues <moragues@google.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Gavin Lee <gavin.lee@ecs.com.tw>,
        Matthias Kaehlcke <mka@google.com>,
        Abner Yen <abner.yen@ecs.com.tw>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Nov 29, 2022 at 10:30 PM Owen Yang <ecs.taipeikernel@gmail.com> wrote:
>
> Add entries in the device tree binding for sc7280-zombie.
>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
>
> Signed-off-by: Owen Yang <ecs.taipeikernel@gmail.com>

When you send v11, please remove the blank line between the
Reviewed-by tags and the Signed-off-by tag. All tags should be
together.

-Doug
