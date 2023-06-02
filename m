Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE9C572029F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 15:07:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235917AbjFBNHX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 09:07:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235464AbjFBNHU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 09:07:20 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 859BB1B5
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 06:07:19 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id 6a1803df08f44-628f267aa5aso3597806d6.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jun 2023 06:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685711238; x=1688303238;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RAI4vy7gsUhap988dUNs7BKw8upS15dtgSM+VQvSEy8=;
        b=lSdiN6qXb01JDFh7xVCXNtJWGHjWni9tPWdGWAgSyFBRjuoPvUMBqa7C8INDifwZ+H
         7/28dqNVGUgZ0yMqB7Iqc+rry+/bLYL3Kh9tHKIkpD+X6HW2jOZk2QTY6TWY9LJH1ghw
         2OHafWQe0kLj0AgQw+GaImQsH8GvQMx1GjVeJnIbMK8nmbXqmwYbmKNzF4puhnvCuPwD
         1eqUDexjmX04YO5lNWI0pPOec+ULtmrcWvY/KqCZJ4w80EN0bSbrY/8jsuVhbHx9SpNY
         8oQUq+6CcHpfzTzhlk/vOwXqE7olwW5j+pEswRQDSJr4nqfx7V2YoOiNBvgdJsWMsdyf
         v6Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685711238; x=1688303238;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RAI4vy7gsUhap988dUNs7BKw8upS15dtgSM+VQvSEy8=;
        b=RMmEnosmpLNQMISgxrS71xE+kMXSkKw+1dFZDleuP9KZT/MS7e/PZb5fMyxbVfa9FV
         HL+KeLt5ES5U/gKPOwb6pXesPLM7evOKzA/zIjA/xBYip7rD4t+kEEo9l2ksXMIh16vi
         qmxdvcd6k7R3WjfTsvek+qXCD/2SU0woVcHQZmwr+5JPbAChKRdBcVQzEHtzJaA16aba
         YU/XxEqD1kHNRUIVolUvSPB907sHjJXJOm+otiQ2RWzEB1p+A9eVCsqJkC9yGAeNQI9Z
         Vn0XkI1AxHBhp2Zr2ti5lcLm3aXYYiPsPNzRneKTHce3gpVbXQ7ACgy/Bm9CSFyLVFdw
         7qIA==
X-Gm-Message-State: AC+VfDy1mbzRLq+z5X7kYsLFcvhG7Q/mI9zZqK3+xD10oL9NNYs0+R3m
        VV/sh/E9dbG4urXi3sNGINNH3y0Eno/a8FoZpKs7Iw==
X-Google-Smtp-Source: ACHHUZ4h6QFgC70g3Tm8W5gJdO09duxPAozEZ1wU7UWxUx+ToaQIyE3xchZLn1sLYCdRxrhXyN74lcExyjydetLiOyU=
X-Received: by 2002:a05:6214:27ec:b0:626:cf8:633c with SMTP id
 jt12-20020a05621427ec00b006260cf8633cmr13482756qvb.38.1685711238577; Fri, 02
 Jun 2023 06:07:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230324063357.1.Ifdf3625a3c5c9467bd87bfcdf726c884ad220a35@changeid>
 <CAMi1Hd1avQDcDQf137m2auz2znov4XL8YGrLZsw5edb-NtRJRw@mail.gmail.com>
 <552345c5-b1e9-41f6-f275-b6eeeb51df25@linaro.org> <CAMi1Hd05z8uBotO4vs7Ropmt7W2gSA__tTu_=X1t0mze7bXrhg@mail.gmail.com>
 <CAD=FV=VSFDe445WEVTHXxU1WS_HGUV5jR5E8_Vgd4eyhn3rHyA@mail.gmail.com>
 <CAMi1Hd28FJUjB8A-9YF7xpKOzSyNWXX3qung4aDjpLBhOvw_eA@mail.gmail.com>
 <CAD=FV=W13L0H88G1gt8qRnXfpV-_7E9QfHufN_a23_B1bb=aww@mail.gmail.com>
 <CAMi1Hd1WCtNvNaY_kVMx5F8T0nMVHvsjk9LsSETCMWWQyaq_Vw@mail.gmail.com>
 <CAD=FV=W5Y_SHp0y2MEs8d1k255bm_PXdRYEmYei+g79pjnzYuA@mail.gmail.com> <CAMi1Hd2OeL940r7jq0=Z_oxE8MYVioy0YnJXQC_5e0vJONd2sQ@mail.gmail.com>
In-Reply-To: <CAMi1Hd2OeL940r7jq0=Z_oxE8MYVioy0YnJXQC_5e0vJONd2sQ@mail.gmail.com>
From:   Amit Pundir <amit.pundir@linaro.org>
Date:   Fri, 2 Jun 2023 18:36:42 +0530
Message-ID: <CAMi1Hd1WF77UF0khEs0XFFvS05issVNo1=sxY9e+VcNFFOCcuQ@mail.gmail.com>
Subject: Re: [PATCH] regulator: qcom-rpmh: Revert "regulator: qcom-rpmh: Use PROBE_FORCE_SYNCHRONOUS"
To:     Doug Anderson <dianders@chromium.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Saravana Kannan <saravanak@google.com>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Jun 2023 at 13:00, Amit Pundir <amit.pundir@linaro.org> wrote:
>
> On Thu, 1 Jun 2023 at 19:35, Doug Anderson <dianders@chromium.org> wrote:
> >
> > If you reorder the nodes in the device tree, I think it'll change the
> > probe order. Does that affect anything? I'm wondering if there's some
> > sort of delayed reaction from a previous regulator.
>
> Hi, Bumping lvs1 and lvs2 regulators up to the top of the list in the
> DTS https://bugs.linaro.org/show_bug.cgi?id=5975#c4 does seem to work.
> I can't reproduce the crash in 125 reboots so far, while I'm still
> testing with only qcom-rpmh-regulator kernel module. I'll do some more
> testing with full system running and send this re-ordering fix I can't
> reproduce the crash further.

Hi, successfully rebooted AOSP with v6.4-rc4 on DB845c about 100+
times with this above mentioned lvs nodes reordering in the device
tree. I don't see any obvious functionality breakage in my limited
smoke testing so far either. I'll post this workaround/fix for review
on the lkml.

Regards,
Amit Pundir
