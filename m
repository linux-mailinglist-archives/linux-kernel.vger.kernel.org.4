Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 403C15BCB14
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 13:53:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229852AbiISLxG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 07:53:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229773AbiISLxD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 07:53:03 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 362EF2B273
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 04:53:00 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id 13so34828790ejn.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 04:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=nT165KwVdFzwm9eF9hv47+7oQR3xfKBQSGECoZbQrwQ=;
        b=yxgCOqzLUyZrbNS4xKX5orKTBMvizkj8LApdrsboHhv1LbRJsGmwXA8RGbPu3gBBuh
         FedWCjxfgxuqKWro5LoPnoe3uzhqQB/ZerkOoD9pRkTkAfS9FTvSU5tpyLNoeK32LfEx
         Ypyx8Wrwn9iVFWdoiWr0/wRotNyfEZ132Ie443HVgprSsl2dE2weO7eimWWW6CWzTCLj
         kib2TaC0B9G+aTGGOHtFDfg/3WEjtyxfzvur9/gSU8g8fugCT6EUxHgOVKcoYSHzkaJp
         tnc7CYpvrdFe73phEFjpXjxJlQxep7v13tdy/Me5WvgM7VsuuQHw1lBt+11ZMfNJ8AVU
         bO0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=nT165KwVdFzwm9eF9hv47+7oQR3xfKBQSGECoZbQrwQ=;
        b=B2HJw2aLQiN/KMwyHrm5XbgHwhkCbjQiFpdMb3FO69ZAKgL6/x7+aX5FoMJdMnp+zK
         mR42mlo/5ebYi533c+gP7jprzKXLX51HgJBECLxydRo17M91ZFlc7NX3UKXfWkiPg9Wu
         kkFKdGQdEe6V6aey9t5yxF2iKb9TwRatOhw/oydVihOh/3qzQXxy8rzPazYzxVXWfwRb
         ce5U9hkoSrN0+VM9J6FGOgbZUM2gaD9o7wpUnDhYFsjvxm0nZU7zWGS5C0mKdS9KPM8+
         lUNzSUaB2RQaRGFVPGGHPYC4ztUdpEi97FFMneD2ktPmIlpIk6SDgVOXgTyGPvgqNv6x
         gvsg==
X-Gm-Message-State: ACrzQf1QjweZBRiXGlEIvR1zay9cOB+aYnTe6H/TBGPl+PEByiO6G5U8
        CwJQYXsJoaQ2fDdHb0UEEuFWfal5bZ5Pl0dDua1Muw==
X-Google-Smtp-Source: AMsMyM5ygi7n4k1vCY3ONaJjWG8v/roOjtXTbkg/tYw05LbaZacpnV8RloAcNYT8n3C/14MsyoxS3UvBxJzajdsfuqA=
X-Received: by 2002:a17:906:58c8:b0:6fe:91d5:18d2 with SMTP id
 e8-20020a17090658c800b006fe91d518d2mr12779573ejs.190.1663588378814; Mon, 19
 Sep 2022 04:52:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220912210624.4527-1-quic_amelende@quicinc.com>
In-Reply-To: <20220912210624.4527-1-quic_amelende@quicinc.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 19 Sep 2022 13:52:46 +0200
Message-ID: <CACRpkdYb+RRspmF_tDrD8ESQCNBBNaTDXbVuPhW-keWJ1owBtg@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] Add Support for Qualcomm SPMI GPIOs
To:     Anjelique Melendez <quic_amelende@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, konrad.dybcio@somainline.org,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_collinsd@quicinc.com, quic_jprakash@quicinc.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 12, 2022 at 11:06 PM Anjelique Melendez
<quic_amelende@quicinc.com> wrote:

> This series provides support and fixes for Qualcomm SPMI GPIOs.

Patches applied for next!

Yours,
Linus Walleij
