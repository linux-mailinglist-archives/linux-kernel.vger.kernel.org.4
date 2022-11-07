Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E44BA61FAB6
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 18:00:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232636AbiKGRAr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 12:00:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232417AbiKGRAo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 12:00:44 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03AC122B05
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 09:00:42 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id i21so18568039edj.10
        for <linux-kernel@vger.kernel.org>; Mon, 07 Nov 2022 09:00:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=aK/Mb1lQmrWp0WIZzAQZyGa5kst0gFmBMRnnMnq6heo=;
        b=YEKGVkj/9lV6H+WKl0DAv5UsTSd+466O/ymx34swbdZo5yizFGQodVqLifmQr1B9Ts
         P//nlccbfUoJEv5iOO2ROpD1floSrnCSDZBZ8NO14TGSi7FGdj52KeZbbE8QJ6dB0UzZ
         Yzal/BE/Z4JuuZAvAx4mN8D0lQbULbSyaxyGI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aK/Mb1lQmrWp0WIZzAQZyGa5kst0gFmBMRnnMnq6heo=;
        b=7Dtc1cRXHyB2cwX5pgrr6oXFwBrIifB78G18ox/hNzMRgx4frSBANa6/1ncnGh1rVK
         X7GYQrypYbvpjsdGddWbLn6uymP1LcHHVbWEGZhf8kJsyNMlmbSsPUc9InmldzM+9EY3
         J1izrSCzptfUiTXB+jbJJBvEH7TNvBHDNQZWIYuotViMQZwtXt1r3YY1xvXX2N1OtGZK
         arwjQZCioZLkUrntKGjY/sD3PrbjLRmmeWtEPlDLwdyCzHl5CQ4ybQYYgYX+yjXJsaHc
         Bb7I8mrjwkFgJwuP+dx3vgT0GIkGUq21FvALPsdEpO+JnqMnwI2zmgi63V0pbDjGi5Td
         MupQ==
X-Gm-Message-State: ACrzQf1vZdNC2HkFER6pbBCH04N3FoINY/nowzjjpYzT0DfQPZacwFVe
        jn+RH8vtDC4QYiTfcqAOz8ZO826rgidZhac5
X-Google-Smtp-Source: AMsMyM4MDkXcguL/aqLsVTGvmnIz0JgIhPbo+9wZACV68ozgWIXOM57HvIXdCOrJ0r4W89DO+nyy6Q==
X-Received: by 2002:a05:6402:1f84:b0:455:27b8:27aa with SMTP id c4-20020a0564021f8400b0045527b827aamr50637541edc.243.1667840440103;
        Mon, 07 Nov 2022 09:00:40 -0800 (PST)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com. [209.85.128.45])
        by smtp.gmail.com with ESMTPSA id en6-20020a056402528600b0044e937ddcabsm4495367edb.77.2022.11.07.09.00.32
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Nov 2022 09:00:37 -0800 (PST)
Received: by mail-wm1-f45.google.com with SMTP id v7so7297041wmn.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Nov 2022 09:00:32 -0800 (PST)
X-Received: by 2002:a05:600c:2212:b0:3cf:6068:3c40 with SMTP id
 z18-20020a05600c221200b003cf60683c40mr34107154wml.57.1667840431739; Mon, 07
 Nov 2022 09:00:31 -0800 (PST)
MIME-Version: 1.0
References: <1666159535-6447-1-git-send-email-quic_c_skakit@quicinc.com>
 <CAE-0n52N6oxSLoU_=Cq1xK9bVX7H+AvPsR3dLepMNjKywdffvQ@mail.gmail.com> <21cd992c-334e-3a28-f3ac-68a49a4ef00b@quicinc.com>
In-Reply-To: <21cd992c-334e-3a28-f3ac-68a49a4ef00b@quicinc.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 7 Nov 2022 09:00:18 -0800
X-Gmail-Original-Message-ID: <CAD=FV=WRCJ6d6jTHH2ZHvuh+c4yTeXhS_D5LZcvfMn1c4NP2aA@mail.gmail.com>
Message-ID: <CAD=FV=WRCJ6d6jTHH2ZHvuh+c4yTeXhS_D5LZcvfMn1c4NP2aA@mail.gmail.com>
Subject: Re: [PATCH] clk: qcom: Update the force mem core bit for GPU clocks
To:     "Satya Priya Kakitapalli (Temp)" <quic_c_skakit@quicinc.com>
Cc:     Stephen Boyd <swboyd@chromium.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_tdas@quicinc.com, linux-clk@vger.kernel.org
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

On Sun, Nov 6, 2022 at 9:38 PM Satya Priya Kakitapalli (Temp)
<quic_c_skakit@quicinc.com> wrote:
>
>
> On 10/28/2022 5:54 AM, Stephen Boyd wrote:
> > Quoting Satya Priya (2022-10-18 23:05:35)
> >> From: Taniya Das <quic_tdas@quicinc.com>
> >>
> >> There are few GPU clocks which are powering up the memories
> >> and thus enable the FORCE_MEM_PERIPH always for these clocks
> >> to force the periph_on signal to remain active during halt
> >> state of the clock.
> > I take it that missing this causes GPU to lose state when it suspends
> > and that confuses the driver?
>
>
> It is more related to GPU SMMU states and the stability issues that are
> encountered.

I see a very similar code sequence for sc7180. Is any similar fix
needed for sc7180, or is this something unique for sc7280?

-Doug
