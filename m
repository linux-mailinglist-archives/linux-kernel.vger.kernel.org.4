Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27C6667CB05
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 13:41:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237170AbjAZMl3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 07:41:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236057AbjAZMl1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 07:41:27 -0500
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B343B5FE9
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 04:41:26 -0800 (PST)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-4ff07dae50dso21244817b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 04:41:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Nf5mwNyIhAmS7BcanhkZNeHv5W1oOYm/mfJbebJe4X0=;
        b=hAVlauBJdtqKIV8Q1qPegeXm+Bf6/qwZoOzNQZ0x9qS2rqCqX5spRM2mBMIoGwMYwJ
         E8k4iqm+1uEfBu0HNEdesxlx2TI/8dhrlcTTTdFHpyKDK1JAdq5Wn4eb3uQAEHkCpzdt
         +AFlgDv2iliaoomJwzHBZ4pyM80oFBXjWEDk8oL7bTMn15hZeAx0ZVCHdSbM8fyS4M4Y
         1kEv0h1gG7quwzQqDdwFNx86PfzSXmXuH4CVvP5pgwky/T2vhannKw2IQrsGx91MkO3X
         l0KPxllZuUB4ryDBhz4X/8+aQEuGiUORlVNpnkVclIt+H/8Ubh9+FZrOaSPWayjpwNOD
         /oag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Nf5mwNyIhAmS7BcanhkZNeHv5W1oOYm/mfJbebJe4X0=;
        b=l5jwYbm6EauMz8MipC72+UYa+Aqz3S/Y4hGSmsmnx+0XqIq5JUsyuJDKn9wx3Tn3b/
         B6pISSJjiWCT2zvFeoeuFNPcbc8CHnfGv8klId00Go4Tf1J8U1FjFZW7LWR+WCuFXAf4
         m2RsBqgmDE2JGrJzz316llOCyyJ5Tu90RP+d/WlLykFxiw3wmSRS86+Bzvzt70zLiCmN
         y9Xk14lcVLkFxPuPicTbc6fnk8Jgz41YQPmjaMD8TQjo17lOGK0X7NwmKMEE5yd0SCHh
         aL78ThiqqMfLkSp9oy3Yd4f3Fi868YiG5n1ApFJzxi7PhS229657xObW0HWALZXhDLwo
         wUXA==
X-Gm-Message-State: AO0yUKUlyJL2wHHTAIsoPCHxiJ+rfyvR5nZ41IlvNrHYDfazFS8R29NO
        bP7H4W7HPuetzLOaBmanccNUOpZWap7H6tbixjNM3Q==
X-Google-Smtp-Source: AK7set/xIl7nJOCYp6XmtbYMHKcEfVgXGSXeP8EKcJT0D/9K/9zMNrqeV4/NgbFy/UrJtoAn1fy5XmM2WhiVxiSiCgI=
X-Received: by 2002:a0d:e701:0:b0:506:66f5:fd24 with SMTP id
 q1-20020a0de701000000b0050666f5fd24mr924262ywe.130.1674736886013; Thu, 26 Jan
 2023 04:41:26 -0800 (PST)
MIME-Version: 1.0
References: <20230113220703.45686-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20230113220703.45686-1-andriy.shevchenko@linux.intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 26 Jan 2023 13:41:14 +0100
Message-ID: <CACRpkdYWJ_=ZkVBDfXisSBeNgJCHQn-mikqd3YQTjMd0R2fLGQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] pinctrl: qcom: Unify accessing to device fwnode
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 13, 2023 at 11:06 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> The device fwnode can be get via dev_fwnode() getter.
> Use it where it makes sense.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Patch applied!

Yours,
Linus Walleij
