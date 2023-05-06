Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44A866F922D
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 15:06:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231960AbjEFNGT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 May 2023 09:06:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231892AbjEFNGN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 May 2023 09:06:13 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C4FD1942E
        for <linux-kernel@vger.kernel.org>; Sat,  6 May 2023 06:06:12 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-55a26b46003so42125467b3.1
        for <linux-kernel@vger.kernel.org>; Sat, 06 May 2023 06:06:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683378371; x=1685970371;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dS8atcxZJwQbExVYUG7qwyvLFr0woVdllJ5J88pacr0=;
        b=pZOMDYoBn4KKHsvhQqVVJVM1Jc2zPRMExhIMEZggmJ3tb7Yol4pPYD978e83PXvMlR
         kDUo55uvlrqZOdbHy7Lxnw1qk37kDBF6zWER0i7xFS5W7hKIy+48SYcnKm04uHLzJOAr
         z6HrWc4oF2MdBcQYX5CckSP3Q+QosRLBPuWQpeJmmqx/TPR1Vs1Vio/2hCSBHrYzDp/d
         Plz+1KHV8fKN87g8NgjWzskuWde1Pjb8LeWZoDdsJpEIGJvCPqwwA2Ju1jZz2Su/6yox
         Y0EgAG3/2Y1gyiVJPkaDrsGzH3cDu2EqaQkVFWScwhTk2pyzB8GHCCFzNNRZEKkeoRWd
         9oTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683378371; x=1685970371;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dS8atcxZJwQbExVYUG7qwyvLFr0woVdllJ5J88pacr0=;
        b=KjvZvYfdl93QSXSuexdNwJvJDRTJALYeFdFOIrL9880M70sECnYILW+EHFBRnGhFwt
         WyMEjtdgYGhJ4eDmvwql3HO2C4DQft9lu8p8TZYz50nPQ7cAcSAvjsWwu6WdzLXh8yJ/
         hbVBnh6gu+JNpgvhUKctKzonn6NvbkIsR5R7BhpfZRBoFd3oLqGhdmuNjwWqUj+dbiMi
         9R+BbofP1peb9ABRjFA27mwfTl0tiP/FhlLzjbwBCDqezpw8zTEwkc7PBTTDejK7rjKh
         lHq4I4vLqNl539yGV5Iw13a+zIecRVtOJY2Q9M8wFPQwD1Yx+y4wz/oeMdaPfoGmnvIj
         5juQ==
X-Gm-Message-State: AC+VfDxb0TPOVAxhjnHBdWiWh0P4xO2nL2Uc3IJQ/5ECMyxjA1QKoGpV
        1NjdHzV6cO092jXk/XZYhYUvLqZPyciwLi9mJvMG6A==
X-Google-Smtp-Source: ACHHUZ6MBhrjWIjpjNrtTBusrqWiBc1pp5i+0QA/EWcmAuKOLfnMBJbFYUX3yCk+qmOdn50UX6EKKAamK59BWwSVw/0=
X-Received: by 2002:a81:8449:0:b0:55a:6917:ee1b with SMTP id
 u70-20020a818449000000b0055a6917ee1bmr5454648ywf.43.1683378371734; Sat, 06
 May 2023 06:06:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230506085928.933737-1-haibo.chen@nxp.com> <20230506085928.933737-2-haibo.chen@nxp.com>
In-Reply-To: <20230506085928.933737-2-haibo.chen@nxp.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 6 May 2023 15:06:00 +0200
Message-ID: <CACRpkdYUGwEn-4T+Ay-KckO3ChFNqOrdVuP93u=gs5uc9fY0yw@mail.gmail.com>
Subject: Re: [PATCH 2/2] gpio: mxc: switch to dynamic allocat GPIO base
To:     haibo.chen@nxp.com
Cc:     brgl@bgdev.pl, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com,
        christophe.leroy@csgroup.eu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 6, 2023 at 10:56=E2=80=AFAM <haibo.chen@nxp.com> wrote:

> From: Haibo Chen <haibo.chen@nxp.com>
>
> gpiolib want to get completely rid of static gpiobase allocation,
> so switch to dynamic allocat GPIO base, also can avoid warning
> message:
>
> [    1.529974] gpio gpiochip0: Static allocation of GPIO base
> is deprecated, use dynamic allocation.
>
> Signed-off-by: Haibo Chen <haibo.chen@nxp.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
