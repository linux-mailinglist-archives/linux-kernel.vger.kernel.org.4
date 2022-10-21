Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 088D06072CD
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 10:48:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbiJUIsE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 04:48:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbiJUIrl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 04:47:41 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8EB124E3BD
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 01:47:35 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id e18so3286850edj.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 01:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bavV4P7OKw1IgK2eENvgKNwFDV/aull6H4XXgOQpF28=;
        b=na72mVoy6itxA2pHRQgFnosyJadW+mGN6I6QtP7L3uR33LBrk0wJ1eosT21RUeIrbI
         xNXhR0wFZ74DBNa4nPMnI09fAf5iDTYdCKW6WDNpoJuPHfBqGYXMbqrxBZdFQeLCqs3a
         WQEuSzVQeo1ES8jA3UfXjxweeU5OAGz46OmBQoEBzzEYqiwSqgmDq9mcDzaITp2J4jMp
         1TiES7vsBseX++pJ+m4jDHSGVEjS8XgHo6zvFCCowrxccFK+7fmP+cwDP8s06BhsBksw
         FxJkKUmb7DZf9zFcEJNd3KDCbqeAvKIVeSUJIvMoYKoS0TsKrEg9IoJIfPYheVCzsdWQ
         s6VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bavV4P7OKw1IgK2eENvgKNwFDV/aull6H4XXgOQpF28=;
        b=X9+/RoycyTCnDYkw/bZ+Ww2ECaXAV6ENg9zMT4ZOUryAhhMA3dfZPaBxfYPofBogKz
         SRIZAAkUEJo6fC44NAHgP0OaRagfPSHQx1Q753cwDz5GSqgFK6Fgkp0ahBOMOpUyaEdS
         +OEqg1yzg1yia+VXj1NmCOZZzXPMfZL2KTLxoIfyWMmlEiEj2eXVyhF5HJZicr5C1DxM
         DUZGegoLwMLYmCzpaYbnueAapxsxOB05F/TMfiX/DHRSWX+TwH2nSv8AT2FQNOXzqP3B
         umkqEY5Du4P4DpPo83njqAy2/UQ3crQaqKX3ej9ekruNOdstIoqkTRew5Ug+vMA9FVVG
         CQBg==
X-Gm-Message-State: ACrzQf2YC2Uies9zP2BeA3k5rguqfyppA2w1u7QELtsWSoKrw1Wijrp2
        A56P+CRnnK2BaQCKxs8nuQiohmk0UVF8s6Ebo8T48Q==
X-Google-Smtp-Source: AMsMyM5m5PWCf90NaTE5OHeDUo06IyVSolnkSSrIJd0MYpGJ7n8h2an2M3VrJ2IRoqy4HZVLC44OdaLmgJ0Os3ekt0o=
X-Received: by 2002:a05:6402:4029:b0:45b:d50c:b9b0 with SMTP id
 d41-20020a056402402900b0045bd50cb9b0mr16152859eda.126.1666342053103; Fri, 21
 Oct 2022 01:47:33 -0700 (PDT)
MIME-Version: 1.0
References: <20221018151223.80846-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20221018151223.80846-1-andriy.shevchenko@linux.intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 21 Oct 2022 10:47:21 +0200
Message-ID: <CACRpkdZ0EtkGS+3SPTtJ9Q_oHVAnbicViEYii0uZYo+SFQGPCg@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] pinctrl: cy8c95x0: Don't use cy8c95x0_set_mode() twice
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Patrick Rudolph <patrick.rudolph@9elements.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 18, 2022 at 5:16 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> Instead, call it once in cy8c95x0_pinmux_mode() and if selector is 0,
> shortcut the flow by returning 0 immediately.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Patch applied!

Yours,
Linus Walleij
