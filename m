Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E615672A517
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 23:05:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229896AbjFIVF5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 17:05:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjFIVFz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 17:05:55 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EFA4358E
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 14:05:54 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-565a022ef06so20166507b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jun 2023 14:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686344753; x=1688936753;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3r39wuzTsS9xYxplRKTYr5FPCI7llaPoOWnnNkuMMsk=;
        b=oWqsFt8rrI2cTkrMOZDO63fKjzVonN2R6CRpJ4Qpv8VrEC9PwLLRdo6fvIDXzMqbWU
         MCL9JQEYMgGi1cAfDfnBxqXXRhFirceGmIh9iL60Ch2/AzS09A7x84n60XzAcXG7kkvI
         E/dL1t27A+8gqa5n2KAuJdGMzDDLbUwLnwS1Vny61JNzRWzUW4/llupUDpAAQRfdzTSI
         PdezuqxMd5C/VOccVnUEzUHKA3ylazNH9wgPNpzbtXI+5a13GmfJ+e9pKnt5zeTkpwTK
         fw70De7FHPwgvcwqrGfTv48YpBDrha1t7PB3/CxPt1N0DLI0/bwJNVhCnkwN6QtvTav7
         zX8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686344753; x=1688936753;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3r39wuzTsS9xYxplRKTYr5FPCI7llaPoOWnnNkuMMsk=;
        b=BkRMA7H6KEIRk25bHdvej74Mc0ZDw1CRLBtkz+Oe3xP+puJuki9/BrfvAenz1UHY8s
         LIoS88DykerwrKSWL+UVtrNjekH9UBxX55XvGWfKhbtoqqJ28EwCHatb719Wd0DLP9dO
         tAOP75z1gbjQPHztLt9S7cIpnXNLw+Tn8OSc8UNXvZOpteAy2okXb0k8rR3EkQJvc34S
         OjM48Myy0n8hgSVkh1Fh8Ag7x7ZxE4eEa/one2ms79OSJugCrTaWQCaHprQ7j60fYh+P
         0HayKAnknt0kMLLS6EXoNChzEElGqjIuWfUFTsbdUbFd2/dA+cFcN/J2PHngoOS+MonO
         QYQg==
X-Gm-Message-State: AC+VfDxxViGdO0mhdWntWnBIDN8zmg6BIHLZhHbjucaCz1kKGTVmndYr
        5r7dnW0sUm8LaSkrY2mVUeoj3Pt32HOgh6q8Gn0pXg==
X-Google-Smtp-Source: ACHHUZ6zAJw3vwna8czLhvW2LNWOrVkyLLE4YwmYrh3Hvv6IxuJyqP5M/++p7ZXt9nC/2LmuHtMkYzyLbtN5tKWm40o=
X-Received: by 2002:a81:d345:0:b0:559:deed:f363 with SMTP id
 d5-20020a81d345000000b00559deedf363mr2563607ywl.2.1686344753319; Fri, 09 Jun
 2023 14:05:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230609202722.3634721-1-arnd@kernel.org>
In-Reply-To: <20230609202722.3634721-1-arnd@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 9 Jun 2023 23:05:40 +0200
Message-ID: <CACRpkdZhad+Hk-ES_ptx1HFoSv=L2WWcUsS5huGN25fj0nK0iA@mail.gmail.com>
Subject: Re: [PATCH] Input: ads7846 - fix pointer cast warning
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        kernel test robot <lkp@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Luca Ellero <l.ellero@asem.it>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Fri, Jun 9, 2023 at 10:27=E2=80=AFPM Arnd Bergmann <arnd@kernel.org> wro=
te:

> From: Arnd Bergmann <arnd@arndb.de>
>
> The previous bugfix caused a warning on 64-bit builds:
>
> drivers/input/touchscreen/ads7846.c:1126:17: warning: cast to smaller int=
eger type 'u32' (aka 'unsigned int') from 'const void *' [-Wvoid-pointer-to=
-int-cast]
>
> Change the cast back to something that works on both 32-bit and 64-bit
> kernels.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202306100442.jStknDT1-lkp@i=
ntel.com/
> Fixes: 8f7913c04f6a7 ("Input: ads7846 - Fix usage of match data")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Excellent fix, thanks! Sorry for not predicting this.

Yours,
Linus Walleij
