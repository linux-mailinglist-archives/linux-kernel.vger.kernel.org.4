Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2E4E6B2627
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 15:01:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231623AbjCIOBm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 09:01:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230185AbjCIOAX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 09:00:23 -0500
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ED3F4ECD1
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 05:58:14 -0800 (PST)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-536c02c9dfbso36009187b3.11
        for <linux-kernel@vger.kernel.org>; Thu, 09 Mar 2023 05:58:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678370293;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=h2y6QDQG/TAZRXyZk306/rRInMHlB69SkUEYaGz2stI=;
        b=svF1mz3VQbXcXWYB1S0ldYiBKKN8f/cTKs4pOovoMrctkqn4b02YYdHGND2lk8uG3u
         IBI3/P5JToSO8lPqdvd11mgg1S0tv0R3VcNXdIEdCoF7QtXJmdLzsMoh43TIDpzOF+HD
         vB1xZF3PPR51aI766jujuDi0lEXCqr8V6vD7W47Hwez1wucANSCNWZ8beNFTUs0JX1JP
         ghapBcNT9yXfUsQysdi96lvgSBxrePpNz5uCRluUgupFssEKHMZCcuOFGdOD0gkHCM20
         kzHbO7WV9DaIbgR1+eO/pPgK8101Kk5EU1vNggaunfoHMkYG8vvdkpa7llLiXTBrgWAf
         6PoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678370293;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h2y6QDQG/TAZRXyZk306/rRInMHlB69SkUEYaGz2stI=;
        b=SuWQNgD1Z0rl7GIrt5lH2z6yCNx+oD74H0gfINz6Xh9mHxncTQGYPVLqcUf8ithOoH
         hs5rB80eHNyDOjH74K/iD05EXAROHI0q1E64W18Ft0ylzYLa+RGZYvybpP4p6f1Z+MjM
         DKPojFjpK3WNHr25czABmr/2bBsB3/2ci41OkNxtmzhvP6gxErnqgcmMCwe2LDf/hVuW
         iNM9pFmOggsMcc8r28RQrpmiIWhXuFKAZGgyKwd5p9FSCHvFPvnnX7aq11onBo+tJkq5
         Q9aQ+lfnH+UHRR19JmUCYFCJhdoB3tIsqJ9ZS0jWswKid+eJ0Rpdh/ndd8W7irV/CfrX
         gIkw==
X-Gm-Message-State: AO0yUKVRpmNX2kS3zpndBugO3qcCIplWweAu4Agq6KgB75bAleY+rSiV
        Xo3aOO10U3flqvtrBQP/twQNATBUwGxs4WDW4j55aw==
X-Google-Smtp-Source: AK7set95MU4XZ8BWZzLEK2+DVoz+Hpik4vCE9vP7gUDCd7geIa+dFDSa7ahGPRwbjikNTH9UUKzNOfUUTbKCUv/k69A=
X-Received: by 2002:a81:4005:0:b0:532:e887:2c23 with SMTP id
 l5-20020a814005000000b00532e8872c23mr14603176ywn.9.1678370293417; Thu, 09 Mar
 2023 05:58:13 -0800 (PST)
MIME-Version: 1.0
References: <20230307182557.42215-1-andriy.shevchenko@linux.intel.com> <20230307182557.42215-2-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20230307182557.42215-2-andriy.shevchenko@linux.intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 9 Mar 2023 14:58:02 +0100
Message-ID: <CACRpkdY4beehqZbbn0+qVyfcja7eBVPETe3bh3vT3Q3JBN=JCg@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] gpiolib: Access device's fwnode via dev_fwnode()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <brgl@bgdev.pl>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 7, 2023 at 7:25 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> GPIO device's fwnode should be accessed via dev_fwnode().
> Make sure that gpiochip_setup_dev() follows that.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
