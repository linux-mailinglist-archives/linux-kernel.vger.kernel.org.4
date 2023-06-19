Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90F2C734ACE
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 05:57:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229701AbjFSD5k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jun 2023 23:57:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbjFSD5f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jun 2023 23:57:35 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5059BC5
        for <linux-kernel@vger.kernel.org>; Sun, 18 Jun 2023 20:57:34 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id ca18e2360f4ac-77e2f4498d3so119836839f.1
        for <linux-kernel@vger.kernel.org>; Sun, 18 Jun 2023 20:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1687147053; x=1689739053;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jo1lPT4dJxUXmcsYL9c21QpbMwQpKCql33uWmmBp3AQ=;
        b=d28etc9GW+7SyTsfFDYvAxiGRbQt8jaXBBRUmXY2ZFTbwVKId+P0cvGMLdwTIYetnW
         BgDyrf9ADyqtbuQ9uuwYB/VsK56eT7VZcU+QPJAAtzaFttvk8/2atNUecJLL2dE+eBho
         SlruaguEbJP0brGHlkoMnpTfnaMLto7rjM+3w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687147053; x=1689739053;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jo1lPT4dJxUXmcsYL9c21QpbMwQpKCql33uWmmBp3AQ=;
        b=B7Xvpq8AV173qn/4KNIlUpjXtTN8OVtbgmT4qiREipgzEbOGoJtKLkidajz4CiZ4ty
         Qos9MSv7DS2mbNeAsP2AA9RWnlENKmS4DD6/UnDDsqg898uX/8vZSPyNpW6Htq1b/etA
         zu7h0jf1E2MU6wvjE3NLn56YGwsaCJx/UvoZtde7K+kMMnlSzHdytObuFQwk4/il3a+G
         KFQbFjSW9fh3TIRRRJqiQdX5Gs70csHda6x+ym4fs84HwF0MjL7lH6BmyB4jS5fq9493
         1fLGaaYvz6wBUH9lOq447ZAZ/SeFpD7g7jbMpIKwfYnPaeJkHTSMM2OHX2B7YSo+N+lk
         ClUw==
X-Gm-Message-State: AC+VfDx0zznita743bRAj5Y2+Jyf7wJCsjXvwqKYFQ6zxVBwlznXg7vL
        R9dA9HzM+HTijcWW8gzdkd8bW11Vyk3ldnJBE61qHw==
X-Google-Smtp-Source: ACHHUZ4F88xi5GfyAynKzBtFd//5SsWK8Yq1TbmqPbTvBIyJbAr/VHqjH/MdDYWUrq10f7kpJdRHIg==
X-Received: by 2002:a5d:84da:0:b0:77e:249e:d84 with SMTP id z26-20020a5d84da000000b0077e249e0d84mr6906330ior.5.1687147053553;
        Sun, 18 Jun 2023 20:57:33 -0700 (PDT)
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com. [209.85.166.50])
        by smtp.gmail.com with ESMTPSA id e9-20020a05660222c900b007748f491918sm8460150ioe.40.2023.06.18.20.57.32
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Jun 2023 20:57:32 -0700 (PDT)
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-77e24ace5a8so148176939f.0
        for <linux-kernel@vger.kernel.org>; Sun, 18 Jun 2023 20:57:32 -0700 (PDT)
X-Received: by 2002:a5d:9404:0:b0:774:8b28:6c34 with SMTP id
 v4-20020a5d9404000000b007748b286c34mr7383720ion.8.1687147052283; Sun, 18 Jun
 2023 20:57:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230617160901.1.I2b151cdf7a72d9e3ecc7ab2ff38409ebe6d65d6b@changeid>
 <71168ceb-8273-4067-d0e0-c6c219d4618e@web.de>
In-Reply-To: <71168ceb-8273-4067-d0e0-c6c219d4618e@web.de>
From:   Fei Shao <fshao@chromium.org>
Date:   Mon, 19 Jun 2023 11:56:56 +0800
X-Gmail-Original-Message-ID: <CAC=S1ngN=TFQa0Y4FoSCOTUs8HRi4NEP1OwY8WccUEUMG_UDeQ@mail.gmail.com>
Message-ID: <CAC=S1ngN=TFQa0Y4FoSCOTUs8HRi4NEP1OwY8WccUEUMG_UDeQ@mail.gmail.com>
Subject: Re: [PATCH] clk: Fix memory leak in devm_clk_notifier_register()
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, cocci@inria.fr
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 18, 2023 at 4:06=E2=80=AFAM Markus Elfring <Markus.Elfring@web.=
de> wrote:
>
> > This fixes the issue.
>
> Please replace this sentence by an imperative change suggestion.
>
> See also:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/D=
ocumentation/process/submitting-patches.rst?h=3Dv6.4-rc6#n94
>
> Regards,
> Markus

Thanks for the feedback. I just sent v2.

Regards,
Fei
