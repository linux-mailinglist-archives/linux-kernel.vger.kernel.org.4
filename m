Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 471CC640B4B
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 17:54:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234046AbiLBQyP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 11:54:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234053AbiLBQyN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 11:54:13 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67D08CF799
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 08:54:12 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id n20so12991757ejh.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Dec 2022 08:54:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RRUu5j880fvIQ+LRTCFRQYqUzHmhqFqL/6To9Liu9v4=;
        b=J59ApYCfPIcN1afxnGVr2a0LLzMX+5isDs9IxUa9JntKqp3bS3e7pljAyyFAzel8u5
         Hs1eUEbJE5SjuKpzakUFT5vClEgkfHToJUxbyyHhQaG4WEPnf0afFIItRtw0o0cXk+25
         s/U8HaTcWtX5ZGVi7qklK3Evnr/TBtNE0V7fk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RRUu5j880fvIQ+LRTCFRQYqUzHmhqFqL/6To9Liu9v4=;
        b=Y/QSM4t0b+MQ79dfvhsi4EZTI3vxG66rSbUskU29oxm+UnopKz8xssjDKiptXutN7w
         YCNRktHB+Y9w7DJ6WwAASlf78fS0UFukyge2CAwkF8UFa7XdVh7x7Eb+QD5qMJEy9+JF
         hV6t3NTJTQO+dnBwU7S8VjQGC2raXyjloGKVm9X8h8hwSwh86pnZW+Xi8tCM1N3aYr2F
         kkpvVvn9hvOQMxIJ1Z5j8zMtVaBcyiUcTgSxXRvTO8bkGa3cCnToSKyh8XQwzT1W+a7n
         ZN2zXCNwq0/cXAW7hLaQnkNS81YO5c/NfCspSwBmL5w3tROHONy2UrU0Vl1HKGJ9ZzcO
         KV+g==
X-Gm-Message-State: ANoB5pmgzGCwcctW3mNnfMz90XCvBYV526rOLZcZJIHZyQtYowSYc/EQ
        3Ykf9Yc7gdQw8x1TGO2hd+MYjKCtDznElJjGAyU=
X-Google-Smtp-Source: AA0mqf4qtaKfXKLX37fBUgl4TFea/ExKHRBffz80eCEgKY6Hf0KuH+qaoAYCWWJjMsAxcNHK8M5RLQ==
X-Received: by 2002:a17:906:94e:b0:7ba:4617:3f17 with SMTP id j14-20020a170906094e00b007ba46173f17mr38755843ejd.226.1670000050850;
        Fri, 02 Dec 2022 08:54:10 -0800 (PST)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com. [209.85.221.54])
        by smtp.gmail.com with ESMTPSA id ca13-20020a170906a3cd00b007c08439161dsm3210129ejb.50.2022.12.02.08.54.09
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Dec 2022 08:54:09 -0800 (PST)
Received: by mail-wr1-f54.google.com with SMTP id h7so2657597wrs.6
        for <linux-kernel@vger.kernel.org>; Fri, 02 Dec 2022 08:54:09 -0800 (PST)
X-Received: by 2002:a5d:4950:0:b0:242:1f80:6cd9 with SMTP id
 r16-20020a5d4950000000b002421f806cd9mr12571444wrs.405.1670000049236; Fri, 02
 Dec 2022 08:54:09 -0800 (PST)
MIME-Version: 1.0
References: <20221202155738.383301-1-krzysztof.kozlowski@linaro.org> <20221202155738.383301-2-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221202155738.383301-2-krzysztof.kozlowski@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 2 Dec 2022 08:53:56 -0800
X-Gmail-Original-Message-ID: <CAD=FV=UPLssDromnt89RYbSEU9qq_t+CSyd5VhmD7b-9JkcMFA@mail.gmail.com>
Message-ID: <CAD=FV=UPLssDromnt89RYbSEU9qq_t+CSyd5VhmD7b-9JkcMFA@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] arm64: dts: qcom: sdm845: align TLMM pin
 configuration with DT schema
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

On Fri, Dec 2, 2022 at 7:57 AM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> DT schema expects TLMM pin configuration nodes to be named with
> '-state' suffix and their optional children with '-pins' suffix.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>
> ---
>
> Cc: Doug Anderson <dianders@chromium.org>
>
> Tested on Qualcomm RB3. Please kndly test a bit more on other devices.
> This should not have an functional impact.
>
> Changes since v2:
> 1. Bring back UART6 4-pin bias/drive strength to DTSI.

Just to be clear, it doesn't actually belong in the DTSI, but it was
there before your patch and it's fine if your patch series doesn't fix
the whole world. I'm OK with this one staying in the DTSI for now just
to keep things simpler.

One change missing in v3 that I would have expected based on our
discussion in the previous version would be to "Add UART3 4-pin mux
settings for use in db845c." I think you said you would do this, but I
don't see it done.

-Doug
