Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1759694D3E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 17:49:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229922AbjBMQtS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 11:49:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbjBMQtQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 11:49:16 -0500
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com [IPv6:2607:f8b0:4864:20::e2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DE8D6A46
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 08:49:15 -0800 (PST)
Received: by mail-vs1-xe2c.google.com with SMTP id j5so4705385vsc.8
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 08:49:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tvhGy8ETPL11zqdmZC/xExmWZp35rJjo2Y2WgSoKKbY=;
        b=Weloq8u9lXxJ8tOY5uJNK934GqHg+5Bp+ylQGnTS9Ir5oR8JwoU1fM+/KT7nphG+5z
         6nXDJ3bTR5xkogGeNIV1QQSMnLOxUpsxooMOeL2wmWPfVS9Uabbv3SpWXv8tVMUHnVbD
         aHrPh2nvYk3lxoEPomJXsN40APlgbZfrPDSV8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tvhGy8ETPL11zqdmZC/xExmWZp35rJjo2Y2WgSoKKbY=;
        b=6vgnQCA9Myhth/BKbbxB12qiD4/Y4+FvSdO42KF1tj3LQBQZO4aZektaFoJ4sTf575
         Ocm0Rvw5nPmK1wWnxa6ysf2eQ2gho8N+RHm6BvG6vwLjzY3L99Qq/5zOHST9P08u2MeX
         fNv7yieOyNGQiu1AcX7ktixl6O6QM6EXHV116Z1zl9WXsyegA4kWMq5FKT90sdrvAtnU
         V49d7EMWF13KdsXSiIe1WTO9e8uDQXVKOlBEJmrnjzBsdRyWoIan1Bj4kINtuxL2Sfcz
         NlJKUXxVYYnh+DBWrDB7yHFmD2oxhWfVYZY/fsbvHCQI81A+OhXNeSL+01Mx1tDdkjRw
         BRTg==
X-Gm-Message-State: AO0yUKUGxN+SiLIznGb4rcapc63x/ga7FERoIWYQbFHXv6FssXL9WZAz
        gY10DdSGDkUTS7TQpkNuiNLbmBZKW3Jk6DMl
X-Google-Smtp-Source: AK7set+zJCmDjvXgXfpfVFZIRTbTvza8ui5nVPMlI7wrSUjXmTS+nGuW4/Yeb1JALVM8DJ+oP9GywA==
X-Received: by 2002:a67:1747:0:b0:3fb:8618:95a3 with SMTP id 68-20020a671747000000b003fb861895a3mr14216899vsx.27.1676306954291;
        Mon, 13 Feb 2023 08:49:14 -0800 (PST)
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com. [209.85.217.44])
        by smtp.gmail.com with ESMTPSA id r27-20020ab04a5b000000b0068a5f6a7b6dsm528067uae.10.2023.02.13.08.49.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Feb 2023 08:49:12 -0800 (PST)
Received: by mail-vs1-f44.google.com with SMTP id a2so2630052vsq.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 08:49:12 -0800 (PST)
X-Received: by 2002:a05:6102:1590:b0:411:c7ae:5b47 with SMTP id
 g16-20020a056102159000b00411c7ae5b47mr2628026vsv.68.1676306952068; Mon, 13
 Feb 2023 08:49:12 -0800 (PST)
MIME-Version: 1.0
References: <20230213105803.v2.1.I610cef0ead2d5df1f7bd18bc0e0ae040b03725d0@changeid>
 <Y+ppFm40+gmVK6NU@google.com>
In-Reply-To: <Y+ppFm40+gmVK6NU@google.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 13 Feb 2023 08:49:00 -0800
X-Gmail-Original-Message-ID: <CAD=FV=X3Tj8V7cSzY+JQwdNRRqiqQC80cPHQci8f_HPp8y_q2g@mail.gmail.com>
Message-ID: <CAD=FV=X3Tj8V7cSzY+JQwdNRRqiqQC80cPHQci8f_HPp8y_q2g@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: dts: qcom: sc7280: Adjust zombie PWM frequency
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Owen Yang <ecs.taipeikernel@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Abner Yen <abner.yen@ecs.com.tw>, Harvey <hunge@google.com>,
        Bob Moragues <moragues@google.com>,
        Gavin Lee <gavin.lee@ecs.com.tw>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
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

On Mon, Feb 13, 2023 at 8:45 AM Matthias Kaehlcke <mka@chromium.org> wrote:
>
> On Mon, Feb 13, 2023 at 10:59:05AM +0800, Owen Yang wrote:
> > Tune the PWM to solve screen flashing issue and high frequency noise.
> > While at it, the comment for the PWM settings incorrectly said we were using a 5kHz duty cycle. It should have said "period", not "duty cycle".
>
> Please split this into two lines
>
> > Correct this while updating the values.
> >
> > Signed-off-by: Owen Yang <ecs.taipeikernel@gmail.com>
>
> Reviewed-by: Matthias Kaehlcke <mka@chromium.org>

Reviewed-by: Douglas Anderson <dianders@chromium.org>
