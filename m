Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE18570B2D2
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 03:36:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231321AbjEVBgm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 May 2023 21:36:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjEVBgl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 May 2023 21:36:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C4DBCE;
        Sun, 21 May 2023 18:36:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D7332618F8;
        Mon, 22 May 2023 01:36:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E3E7C4339C;
        Mon, 22 May 2023 01:36:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684719399;
        bh=3a6HIZgqjyeRWgT87m3KTgynLfIiRHExtrFxopRT13Q=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=X6Q7dNEY1/JoKohD1lvetlc5T6tYoJG0sJ/gioVWbCbtge0lmnprNNniyseobdcty
         aEBcH4mg5NbH9LCTVAO2BaSuauj+/GPBfSyeV6BoDxMqWwyMyjB90dV45JHTpPwv3T
         1vOVtDSfcenWG6XgGl4RSOhepjTtuGc/WTTg9GgQnpU2fwxzNx1GXDujgcCdPW1jV+
         qsD3qAMZAvlWAXNuAY4rXyAvMBFCzJ9ZQXK+Viy98ZA3ZlSnrSFEkW0Y+T8/lPhxRn
         2fEjEDZy7oB4y1Yk/UqD8OhgtD4HI42Jox0AfzuBfaskCr1NT48P1DeEZwsniO23BT
         sAS24BwtH60Cw==
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-19cf62eb14aso423282fac.3;
        Sun, 21 May 2023 18:36:39 -0700 (PDT)
X-Gm-Message-State: AC+VfDzGY/V/CDJqXdNciNecKYETl7fd08lKgGQo1ixgKmrArwflmizS
        /F5H9XAjD+KuPV+0O5FSax/NNpX9aHThI5gsFR0=
X-Google-Smtp-Source: ACHHUZ5EtVReHVmIN/ALMHH1fAPlrcHZ9UgoUb8svROadc7mrJvRB7JbVFywTPIzwErAvQyZ0ojcQHArXUFlmwRXuzk=
X-Received: by 2002:a05:6870:31d4:b0:192:7320:ce with SMTP id
 x20-20020a05687031d400b00192732000cemr3936527oac.40.1684719398518; Sun, 21
 May 2023 18:36:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230306224752.8417-1-afd@ti.com> <ZAi+Qo1z2OkrqncP@fjasle.eu>
 <b3820dd3-83dd-278e-e9ad-814be0bc8cfa@ti.com> <1118291b-1137-6368-6202-e54151f01eb0@ti.com>
In-Reply-To: <1118291b-1137-6368-6202-e54151f01eb0@ti.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Mon, 22 May 2023 10:36:02 +0900
X-Gmail-Original-Message-ID: <CAK7LNAT2wQkGwZnCKwgsF6jW5ENRSgGN3vh2+Y8bbaw0WFhsBA@mail.gmail.com>
Message-ID: <CAK7LNAT2wQkGwZnCKwgsF6jW5ENRSgGN3vh2+Y8bbaw0WFhsBA@mail.gmail.com>
Subject: Re: [PATCH] kbuild: Disallow DTB overlays to built from .dts named
 source files
To:     Andrew Davis <afd@ti.com>
Cc:     Nicolas Schier <nicolas@fjasle.eu>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        devicetree@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 16, 2023 at 1:49=E2=80=AFAM Andrew Davis <afd@ti.com> wrote:
>
> On 3/8/23 9:01 AM, Andrew Davis wrote:
> > On 3/8/23 10:56 AM, Nicolas Schier wrote:
> >> On Mon, Mar 06, 2023 at 04:47:52PM -0600 Andrew Davis wrote:
> >>> As a follow up to the series allowing DTB overlays to built from .dts=
o
> >>> files. Now that all overlays have been renamed, remove the ability to
> >>> build from overlays from .dts files to prevent any files with the old
> >>          ^^^^
> >>
> >> The first "from" sounds superfluous to me.
> >>
> >
> > It is a typo, feel free to drop it locally whoever takes this patch.
> >
>
> Seems no one took this last cycle.. Still valid and applies for this one.


Seems it fell into a crack.

Now applied to linux-kbuild. Thanks.





> Andrew
>
> > Thanks,
> > Andrew
> >
> >> Kind regards,
> >> Nicolas
> >>> name from accidental being added.
> >>>
> >>> Signed-off-by: Andrew Davis <afd@ti.com>
> >>> ---
> >>>   scripts/Makefile.lib | 3 ---
> >>>   1 file changed, 3 deletions(-)
> >>>
> >>> diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
> >>> index 100a386fcd71..68d0134bdbf9 100644
> >>> --- a/scripts/Makefile.lib
> >>> +++ b/scripts/Makefile.lib
> >>> @@ -418,9 +418,6 @@ endif
> >>>   $(obj)/%.dtb: $(src)/%.dts $(DTC) $(DT_TMP_SCHEMA) FORCE
> >>>       $(call if_changed_dep,dtb)
> >>> -$(obj)/%.dtbo: $(src)/%.dts $(DTC) FORCE
> >>> -    $(call if_changed_dep,dtc)
> >>> -
> >>>   $(obj)/%.dtbo: $(src)/%.dtso $(DTC) FORCE
> >>>       $(call if_changed_dep,dtc)
> >>> --
> >>> 2.39.2
> >>



--=20
Best Regards
Masahiro Yamada
