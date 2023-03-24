Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C48B76C7DC1
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 13:10:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230377AbjCXMKJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 08:10:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230098AbjCXMKG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 08:10:06 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E151EB4D;
        Fri, 24 Mar 2023 05:10:05 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id g19so1214945qts.9;
        Fri, 24 Mar 2023 05:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679659804;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=htRMxat7UOnZPRu+jRdGPnFqsl30J3aasrV8Go9R93w=;
        b=P/AextpZD7nkHpndecr5UHmf+Q/i0PabbvtEw6fwft7WeNYskdRybP5PK6MpjzO+VI
         1XNPYzZvV6MXPbbcb2UPGfWkQxoCn2OjXnvR1FD4OTKSTP/G5VRrBCQPxIs8VbsS+U2l
         111VWOlGSTkRs5MXjMdmP16U0dIScfjfckwNEaoBJj2zXt+MZ2guNrLr+wvDzNGPzs9T
         CGjQkTfHst27KrmLfoObF04/HyiEDnuF+SKbcKC/hsV/lKVA6QCCtqFRYeZxnNkao7Ut
         WwsE2Nl+g2KvCr5h7/B7ppClxqWB7RG3iWh9Kb+1u80WpOG1zEAXY8E2mo0H4S1M5EOm
         rbbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679659804;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=htRMxat7UOnZPRu+jRdGPnFqsl30J3aasrV8Go9R93w=;
        b=8L4TMfd05MnPKCRGeyK8t/L7IBm98KMduHj7DrHrJuMdXgtKNWUGXT2IkCHJL+dZwv
         hJsRskeLh7aBWoxghRGh5ASp9wJED0Gwdt06hB/XMqgWlTxqMcnpL2yYiuwtz5QHFTYa
         cV+hXH6PVAVlRXlkDIgQ3vO4svpMdbDTfKlRtuQ6DJrW0CC4ivinoucopMMSo53F5zpU
         Y9QOtJ51gv/NWIfF9DG9g7pkrcSj1aOLSYkMJLgHLJyVpyCASqp2Vp0/+XW3VFl32AAW
         FYI07vw/4lTyYMajk765wX0eELmzIRF7gu5B33dW1CirqecXs459z7fuZ/T64qKO15YO
         MA1Q==
X-Gm-Message-State: AO0yUKVQ4z2WPZ59N6Gvbs2QjPgjQQ6o5qfgOeGnnFDgcqTXT41v+eso
        oCefBxkHAKf83UhKG8rmJ4UA2b8bFeRZwyloGhIcasSWBB8=
X-Google-Smtp-Source: AK7set83Gn9PKImvg9oepEkxkjvNTiNWUDhY8FlNzldTgyKs1c2jN/Z7sCtITTanAxpoY+lwuORHgIOSWWm1rTkn8fs=
X-Received: by 2002:a05:622a:20c:b0:3de:fa64:ff2b with SMTP id
 b12-20020a05622a020c00b003defa64ff2bmr961406qtx.0.1679659804560; Fri, 24 Mar
 2023 05:10:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230323205733.20763-1-asmaa@nvidia.com> <CAHp75Vd4m79RhG-_KLRNzr0SPzphG07fOiTWwmGCfx8Lz=+6Vg@mail.gmail.com>
In-Reply-To: <CAHp75Vd4m79RhG-_KLRNzr0SPzphG07fOiTWwmGCfx8Lz=+6Vg@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 24 Mar 2023 14:09:28 +0200
Message-ID: <CAHp75VcJf-peTtFA9xP28OYUCzGCeG-4Uw2aHLMrM0Sx5RoKvg@mail.gmail.com>
Subject: Re: [PATCH v1] gpio: mmio: fix calculation of bgpio_bits
To:     Asmaa Mnebhi <asmaa@nvidia.com>
Cc:     linus.walleij@linaro.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 24, 2023 at 2:07=E2=80=AFPM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Thu, Mar 23, 2023 at 10:57=E2=80=AFPM Asmaa Mnebhi <asmaa@nvidia.com> =
wrote:
> >
> > If the "ngpios" property is specified, bgpio_bits is calculated
> > as the round up value of ngpio. At the moment, the only requirement
> > specified is that the round up value must be a multiple of 8 but
> > it should also be a power of 2 because we provide accessors based
> > on the bank size in bgpio_setup_accessors().
>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

Btw, I do not see the initial patch in Bart's tree. I suppose you may
simply send a v5 of the original one with this fix applied inplace.

--=20
With Best Regards,
Andy Shevchenko
