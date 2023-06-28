Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0369C741260
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 15:28:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232006AbjF1N1o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 09:27:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232115AbjF1N1B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 09:27:01 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B82EF2D63;
        Wed, 28 Jun 2023 06:25:26 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-4fb7769f15aso5061963e87.0;
        Wed, 28 Jun 2023 06:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687958725; x=1690550725;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TWEQbN86A0uWHo7Mv0YHpWVtQH6MiF6zeRclnXOWRDQ=;
        b=kIuz59to4JmWAP9SmF2819Scpgqe3vPA0S58LqpT08Mtg8b6YqDSMolY3qlaLqzBRq
         gvLG7j6wRtDaAGBAHklKjZfH+0J+blLP/jkXFS8QsVCGJ1e0I/EACXFmi0JjXVPj4XzA
         OPaqOFcgsMKK2HBjrUyRbPYvn0XuhJ5ZayHs2y95XwNMYjftFL3DzCflo4AZNKKYFOzJ
         fVrJdfivRuDYoBZDeelb6yefdxuk25JHI5RxObWZrculOrPrfkV+mO8H11jnmOQhaHcz
         AsYF8lIA5sf8Wq0+yopLJKmqrnsFltl8+5T7P6+IvlX7gY7Fk/+GgZ4q3YGgA6Ebns8Y
         A6Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687958725; x=1690550725;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TWEQbN86A0uWHo7Mv0YHpWVtQH6MiF6zeRclnXOWRDQ=;
        b=J2LDG84st+wBKPxCB+MVDf4uLQqUo0F/eftevKNznG9GEsJl4HFtBYF2XlZdJP3fjs
         0IUkUvkiQ8C5OD2l0k95+wErHYLo9LF51+OemV8RU1MbsIgZAL34Ntj2hCfqlaI0UC7n
         xdknrGUxxVGQUCuicS7jw7OPebisdYL5hf2r2hIUKM0f1Pmj4mapi/jUk0IyzCcdt1qN
         FTtQK/GIg/pLs+vuyTrueXU0JN1IrwRCvA4v79fY4+BsB+ckNtVyKeQq4pIPGZ67XBTD
         dx7duUs79PHWeYr7dRABCdyCIiwF2Vg38iSAF/xzdk1lawtKOKEDqI34NrqtKiqGrW+G
         +FNg==
X-Gm-Message-State: AC+VfDzcz0tt2uMhXol1W4E77On/6u99xn/nqLqH5h42fGBa4QwkD/6l
        nG/y0h6lgxKLn8dNxzSEdnzK4Nx2nf3BYaFKIwU=
X-Google-Smtp-Source: ACHHUZ5hjUSVG5IQFaE93brCgNksZL03omVGBIEEyvY3Gusi6WFzibws1HkoznD+ij1D6/MEVxklMwZ9hULE7BQ8Bzo=
X-Received: by 2002:ac2:5b83:0:b0:4f8:5472:7307 with SMTP id
 o3-20020ac25b83000000b004f854727307mr16840436lfn.31.1687958724653; Wed, 28
 Jun 2023 06:25:24 -0700 (PDT)
MIME-Version: 1.0
References: <1687955688-20809-1-git-send-email-quic_mojha@quicinc.com> <1687955688-20809-3-git-send-email-quic_mojha@quicinc.com>
In-Reply-To: <1687955688-20809-3-git-send-email-quic_mojha@quicinc.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 28 Jun 2023 16:24:48 +0300
Message-ID: <CAHp75Vcu6_Gr6Y8ThzOZdC34-sxOx9esYhpS2p22rAWjwv5Bkg@mail.gmail.com>
Subject: Re: [PATCH v4 02/21] kallsyms: Export kallsyms_lookup_name
To:     Mukesh Ojha <quic_mojha@quicinc.com>
Cc:     corbet@lwn.net, agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        keescook@chromium.org, tony.luck@intel.com, gpiccoli@igalia.com,
        mathieu.poirier@linaro.org, catalin.marinas@arm.com,
        will@kernel.org, linus.walleij@linaro.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-hardening@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 28, 2023 at 3:35=E2=80=AFPM Mukesh Ojha <quic_mojha@quicinc.com=
> wrote:
>
> Module like minidump providing debugging support will need to
> get the symbol information from the core kernel e.g to get
> the linux_banner, kernel section addresses bss, data, ro etc.
>
> commit 0bd476e6c671 ("kallsyms: unexport kallsyms_lookup_name()

Commit

>  and kallsyms_on_each_symbol()") unexports kallsyms_lookup_name
> due to lack of in-tree user of the symbol. Now, that minidump
> will one of its user, export it.

users

...

Is it a direct revert? Then make it visible by leaving pieces from `git rev=
ert`.

...

> -

If not, drop this stray change.

> +EXPORT_SYMBOL_GPL(kallsyms_lookup_name);


--=20
With Best Regards,
Andy Shevchenko
