Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52C046B9CE4
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 18:19:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbjCNRTt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 13:19:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbjCNRTs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 13:19:48 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF49A2A171;
        Tue, 14 Mar 2023 10:19:47 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id m15so2363207qkn.9;
        Tue, 14 Mar 2023 10:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678814387;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WnQUIsJCZ6UmwE5GOvHliMVqSQ/A95JvCqwd5/j+yHo=;
        b=p3RADmW6SkvGIK/4EVPzXSu5AJfkAciKEUkF9EHvbGectNN97kFwN014S0SQ4VNfKi
         C8DFypHCThYnCHLmHAI7WmL46ARq5XE7biyM/tDzDOESH+CwNfWjecQmhVmyB1jBcbNG
         yly9nUCUeCpKbsxQ6y6Gr0nObDee+ttY+WHKQnHoUtXpdOxEOO/WdffxtKfMTx9wA10L
         e3lzbHJslpPaE2nPX9EvM0mEmFyoq/djDN+hrbPAk3fJjghdQ1Aj+9ZBicikwW5Q1ouZ
         CyouRD2TnY8wDB4TiB3arPZSLrcOENE8j65ayvoUjlPXFDAYIlOm4vnXCHviE6xDJoBC
         4EsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678814387;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WnQUIsJCZ6UmwE5GOvHliMVqSQ/A95JvCqwd5/j+yHo=;
        b=EQf/zTzE3vN1ANkppkVRXf3ohY+gLict9TcdiyAfbcTSawxHnqkYRV8r6q22njsifE
         mpfcZ4Tu0OQ5wuk4cTP3upd0H48x6a7IhuEx1GCME/Y+7uA+4gsRGCj+DJMmwLoSSngA
         iymgXspxyiCyy1Bpj3TutaUcy9DS7iepn3URGiHUS0GC/7BvmmT3IyFEGLSxeHeTJSG9
         xW1yYR1IeG9cPJfX9Rhn3aVBUPGuodPMI3GcqAsVs9BT4n93myOnToEHKH2FNBIVYshn
         b22qGTL69rtPPx0AI1EobZOnuJ2tt+QElTQ7BuaS7K5GyUfQnuIrtbXV5z+748k6e4l0
         k5sw==
X-Gm-Message-State: AO0yUKUmMVRg2hnFT35PM/GqeBAv0TUTCWA8tpW4Vh9vB6B7PUbZGOM9
        nBZwa+nqgobYmz2nJFlnHPq9B+/VlM94PS4DvtI=
X-Google-Smtp-Source: AK7set/XstngtVdzeXSX3rMRNMnXygcqmEIqcMB4Qa6iyPMPZTvIlN7BsG6/rIXuPJIM5kuT0hfmy+wPOJ2nGPLCjKc=
X-Received: by 2002:a05:620a:c81:b0:743:6092:91b4 with SMTP id
 q1-20020a05620a0c8100b00743609291b4mr4370897qki.14.1678814386793; Tue, 14 Mar
 2023 10:19:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230314134642.21535-1-clin@suse.com> <20230314134642.21535-4-clin@suse.com>
In-Reply-To: <20230314134642.21535-4-clin@suse.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 14 Mar 2023 19:19:10 +0200
Message-ID: <CAHp75Vc838SyGSRfnHEj4925efOhH3WwjVkdnGR+_a2VF3Z6gw@mail.gmail.com>
Subject: Re: [PATCH 3/3] pinctrl: s32cc: embed generic struct pingroup and pinfunction
To:     Chester Lin <clin@suse.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        NXP S32 Linux Team <s32@nxp.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Ghennadi Procopciuc <Ghennadi.Procopciuc@oss.nxp.com>,
        Andrei Stefanescu <andrei.stefanescu@nxp.com>,
        Radu Pirea <radu-nicolae.pirea@nxp.com>,
        =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        Matthias Brugger <mbrugger@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 14, 2023 at 3:47=E2=80=AFPM Chester Lin <clin@suse.com> wrote:
>
> Use generic data structure to describe pin control functions and groups i=
n
> S32 SoC family and drop duplicated struct members.

...

>  struct s32_pmx_func {
> -       const char *name;
> -       const char **groups;
> -       unsigned int num_groups;
> +       struct pinfunction data;
>  };

Since you have a single driver with this, just kill the entire custom
structure.

The way it's done in the pinctrl-intel.c is due to dozens of drivers
sharing the same data type and hence converting that will provoke
quite a noise for no benefit. Here it's not the case, so just kill it.

--=20
With Best Regards,
Andy Shevchenko
