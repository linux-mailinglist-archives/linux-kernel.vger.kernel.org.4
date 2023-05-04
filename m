Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 815356F64FB
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 08:29:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229951AbjEDG3l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 02:29:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbjEDG3i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 02:29:38 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 261A51FDA
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 23:29:38 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id d75a77b69052e-3ef36d814a5so667231cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 May 2023 23:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683181777; x=1685773777;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CadOrn/gd0bhiSJnQRcKqLdPORONrzWilIt3682xgJE=;
        b=OuHQdwJ5nqo6c1x+YhM5d7HUe9Kq+MPaPDncoNFAjmVWk8ZiLZmUjmZsaVnn1j5rqI
         2T7hO45/BHm8R50dcwhepETfSnZyK5UpywLamnVGMPD6fKrLvvtQVemvjf4V90Y4wgS8
         fgvd4CkJn+R0+bk7eX8PbTodNPhgjVTanoxmovmn69gX1FFOM/z125barX5XG5ZRd/uH
         bOqnpcHVjRyOZTT9zCq7k3qyFv8NmphP3mSq5k3EJmYnuAOF+Q2MwnT/9OVouLTBbNtW
         +aVUpgUnMPEAJre7Aicoh6/OjXef4khG7/+++SyNJqNufBQbq8WspdG7A5yjmbSsC58S
         Gjcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683181777; x=1685773777;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CadOrn/gd0bhiSJnQRcKqLdPORONrzWilIt3682xgJE=;
        b=IzKSQah+lkEpempvfzUjRSG1Z/PnGikWCA48zNzy4eO+btGcehyINXh6V43xAxQHX7
         5x7xtXDgvt3n5dDF+KRjEQM7PxEZAMSS9GDwNEyQ5+MO84z1InvV2GuSjUq8+zCNB7UK
         fKxi8Aj2NlaCgEaxSzfGK2R1yu9D8oOoaVFuJWh71QOJV0QR+kAcqmDmlLvTi+Sb9CO5
         1SaFFfVkn0INnon/PbCkcXTcwoJDjSFOcR33Pg7lERR5wRrPjhpV9AHnATbx8zKfMFKb
         PiFKMVhPcIQ519b1hAVjq2pmejr4bQ/58S1NEh+fJlJP1iWcdGcPrbcFZWWC5IkHSFYz
         00Ug==
X-Gm-Message-State: AC+VfDye7jIsIXVsELIcAxl/pCwmsi7y1Z8GAQGzAhJCDER6YKror2m3
        sGWvWOUfxI8kh70SSwUKFGUrlXMW6exf5u507sJIOw==
X-Google-Smtp-Source: ACHHUZ7mR9stFwowZvcNb0BZGX3rQiJYHCMjPeXa9GBP+k1snnzCx0nJC9u3C7z9qrMYx4F4o+kf6uFoyd5mFh7X688=
X-Received: by 2002:a05:622a:590:b0:3f2:2c89:f1ef with SMTP id
 c16-20020a05622a059000b003f22c89f1efmr148597qtb.5.1683181777178; Wed, 03 May
 2023 23:29:37 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1683022164.git.geert+renesas@glider.be> <483c4f520e4acc6357ebba3e605977b4c56374df.1683022164.git.geert+renesas@glider.be>
In-Reply-To: <483c4f520e4acc6357ebba3e605977b4c56374df.1683022164.git.geert+renesas@glider.be>
From:   David Gow <davidgow@google.com>
Date:   Thu, 4 May 2023 14:29:25 +0800
Message-ID: <CABVgOS=gH58gj9-Wf1K0CJ085XJag=oS-8ocx6oUhTHcW1gecw@mail.gmail.com>
Subject: Re: [PATCH 2/2] Input: tests - modular KUnit tests should not depend
 on KUNIT=y
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        linux-input@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 May 2023 at 18:17, Geert Uytterhoeven <geert+renesas@glider.be> wrote:
>
> While KUnit tests that cannot be built as a loadable module must depend
> on "KUNIT=y", this is not true for modular tests, where it adds an
> unnecessary limitation.
>
> Fix this by relaxing the dependency to "KUNIT".
>
> Fixes: fdefcbdd6f361841 ("Input: Add KUnit tests for some of the input core helper functions")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---

Works here, thanks!

Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David

>  drivers/input/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/input/Kconfig b/drivers/input/Kconfig
> index 735f90b74ee5ad44..3bdbd34314b3495a 100644
> --- a/drivers/input/Kconfig
> +++ b/drivers/input/Kconfig
> @@ -168,7 +168,7 @@ config INPUT_EVBUG
>
>  config INPUT_KUNIT_TEST
>         tristate "KUnit tests for Input" if !KUNIT_ALL_TESTS
> -       depends on INPUT && KUNIT=y
> +       depends on INPUT && KUNIT
>         default KUNIT_ALL_TESTS
>         help
>           Say Y here if you want to build the KUnit tests for the input
> --
> 2.34.1
>
