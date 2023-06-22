Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B28D73A444
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 17:05:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232365AbjFVPFs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 11:05:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232363AbjFVPFB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 11:05:01 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 277DC1FEA
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 08:04:53 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2b45bc83f26so104321781fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 08:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687446291; x=1690038291;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kvR6VJJ0Vdf3BAw38hXaTQ2ZyJL9cLPWH20S5WdBxwg=;
        b=N4RpyhOtgUx2MHonjr+YEqKhVycFiEBZ85GGc45BzVGgOY6G47d4TalscUpjq8ho/f
         W2GNkM25dg3K5e4clg7FPNWanAa68ri/w4srR7VUiUzd76lMfNZ7YM+CEz0jGpunopwy
         QPrMToxO7EBczWHI0IPcctBNsrK4klXgn2uKufJpDAzAB+cdlSh1NwdEGy9BEXVpj3PL
         tZLbhGrtENnnJMzrIUgB7yivwrdLA8sQK/j0rKcxTOrJoHAesuBjf78zv+LmybzxRHTP
         aAVDxP4maEHfSNIgPwAn5FP0j9bJa9NaA9PERH8zJdXgrUK3fV5uEUfg/J7itvYvs8nh
         Odbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687446291; x=1690038291;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kvR6VJJ0Vdf3BAw38hXaTQ2ZyJL9cLPWH20S5WdBxwg=;
        b=dgUfpi7xV02/k62HzfHMgak7SJH4/CapbeEEJsZdPSsXBuDRURgWuDM9VRz8W/E9f9
         mMJ9R6+IX911VmP14xDhJG/UhLH4Ea4OKPgpPk6DksaoMrixts4WkLf/xxFaEiWo3G/R
         uVJDC/hPwNrDHhDDtJyep/YMf9TuD8JIgftimieBZ6aU7XyCZmpJfy/xwKVVNEti+C6q
         Vr6A8q9y1qKiyY/iLl23AldU9hKYVf7e9+SV36ijSYUmvLpClf8wtizfijOzLADbsyjn
         kfjCv10Xe+ZgXTMxvjfzfWgBDyPf8HhLEN015w5S3w38rfllR0P8oaG/exUESDss32JQ
         xr6w==
X-Gm-Message-State: AC+VfDxR5zSE9BNqP8cNKLwy55f+gjzowDj8MxW+Yu6QSFVOxYlmE22f
        xLCt/ehImaQvxjHqC+VuY3CDwsRE9tI8z29QBFx7Tg==
X-Google-Smtp-Source: ACHHUZ7PucJySX2IoCiWGqUjV5sxCns+38Rvu1inY2IjJNcp6aY7W3bHXqQlco1hxJM+1CD/hMmxNxgySpw2hq0gYzo=
X-Received: by 2002:a2e:86d3:0:b0:2b5:8c84:ebdf with SMTP id
 n19-20020a2e86d3000000b002b58c84ebdfmr2422388ljj.42.1687446291263; Thu, 22
 Jun 2023 08:04:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230622085112.1521-1-masahisa.kojima@linaro.org> <8ce9f761-347d-1e8c-17d7-241d88c82451@siemens.com>
In-Reply-To: <8ce9f761-347d-1e8c-17d7-241d88c82451@siemens.com>
From:   Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date:   Thu, 22 Jun 2023 18:04:15 +0300
Message-ID: <CAC_iWjJ28uKVpz_FrJ6dcUjCkrV9w5UO4WRr9SQxYFPmtmj59w@mail.gmail.com>
Subject: Re: [PATCH v6 0/4] introduce tee-based EFI Runtime Variable Service
To:     Jan Kiszka <jan.kiszka@siemens.com>
Cc:     Masahisa Kojima <masahisa.kojima@linaro.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org,
        Johan Hovold <johan+linaro@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jan,

On Thu, 22 Jun 2023 at 17:56, Jan Kiszka <jan.kiszka@siemens.com> wrote:
>
> On 22.06.23 10:51, Masahisa Kojima wrote:
> > This series introduces the tee based EFI Runtime Variable Service.
> >
> > The eMMC device is typically owned by the non-secure world(linux in
> > this case). There is an existing solution utilizing eMMC RPMB partition
> > for EFI Variables, it is implemented by interacting with
> > OP-TEE, StandaloneMM(as EFI Variable Service Pseudo TA), eMMC driver
> > and tee-supplicant. The last piece is the tee-based variable access
> > driver to interact with OP-TEE and StandaloneMM.
> >
> > Changelog:
> > v5 -> v6
> > - new patch #4 is added in this series, #1-#3 patches are unchanged.
> >   automatically update super block flag when the efivarops support
> >   SetVariable runtime service, so that user does not need to manually
> >   remount the efivarfs as RW.
>
> But that is not yet resolving the architectural problem with that
> userspace daemon dependency. What are the next steps for that now?

We are trying to find some cycles to work on that, however, I don't
have a time estimate on that.  But the question is different here.
Since this addresses the problems distros have wrt to SetVariableRT
(even for a limited set of platforms) are we ok pulling this in?  I
can't think of a technical reason we shouldn't.  The supplicant
limitations are known and the firrmwareTPM has a similar set of
problems.

Thanks
/Ilias

>
> Thanks,
> Jan
>
> --
> Siemens AG, Technology
> Competence Center Embedded Linux
>
