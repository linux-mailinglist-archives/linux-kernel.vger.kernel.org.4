Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB8D06AD4D8
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 03:37:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230070AbjCGChn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 21:37:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230060AbjCGChf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 21:37:35 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5606B41B5C;
        Mon,  6 Mar 2023 18:36:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 92D8D611BD;
        Tue,  7 Mar 2023 02:36:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFFBFC4339C;
        Tue,  7 Mar 2023 02:36:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678156618;
        bh=mS7/Ly6KYmnkwiF7aynM/VJYcNcJt8vlQM7JFER0qmM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=O6+zDCz8oh0H6cFmiHh28Alq40UG4kiJO1u2xdsu9QJRgh4zbYN4llRv1ztxbR77w
         Rp2kbpV6MRUotFGuvm4HERkIWaVDqkCdSfwD8U+JBVDIYRyNu+ztnQqbd3jVvuzrpB
         yEJs0V6BlNHlOl5pKUXilZi26l+cvyWj1nDRPm7GrThjdGOXnf+0HKVn8UpeQlOz4X
         XWJaWRGqP6POv+7zehD5si6/nRiepALlsOJFHycKel83VA4i2/TrdrPIf7D4TGGeDv
         OVcLReyfb3v6e4JeLjhsosWJ6eIJeDW9dw0OnitzPqcp1eNfKw2l0S/0klr7U+8ITC
         aSYZMmOUWPqdg==
Received: by mail-ot1-f54.google.com with SMTP id l15-20020a9d7a8f000000b0069447f0db6fso6467997otn.4;
        Mon, 06 Mar 2023 18:36:57 -0800 (PST)
X-Gm-Message-State: AO0yUKVkQVcBefgbzjlCkQ5/7W62OQIe+yVRdy3Qkg1VUmYzNxKNNzw7
        Iw/svS3+ahSFxCjRMIuDI2Dteu9yBAd9pD3Kt1M=
X-Google-Smtp-Source: AK7set+S9TKIQLs7b3lLmjJBn4kR8ct4XO01APIqQlTf96nVELXPK8QSr9NOMfW9O2Bw1NCkjd5DPOJMrFxqtDDi0zI=
X-Received: by 2002:a05:6830:308c:b0:688:d14c:34d3 with SMTP id
 g12-20020a056830308c00b00688d14c34d3mr4030130ots.1.1678156617196; Mon, 06 Mar
 2023 18:36:57 -0800 (PST)
MIME-Version: 1.0
References: <20230306224752.8417-1-afd@ti.com>
In-Reply-To: <20230306224752.8417-1-afd@ti.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 7 Mar 2023 11:36:21 +0900
X-Gmail-Original-Message-ID: <CAK7LNARO=OGXeR7XXkfWhRj7vu52uHPczCgNzNo0D18w21J=kg@mail.gmail.com>
Message-ID: <CAK7LNARO=OGXeR7XXkfWhRj7vu52uHPczCgNzNo0D18w21J=kg@mail.gmail.com>
Subject: Re: [PATCH] kbuild: Disallow DTB overlays to built from .dts named
 source files
To:     Andrew Davis <afd@ti.com>
Cc:     Sascha Hauer <s.hauer@pengutronix.de>,
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
        Nicolas Schier <nicolas@fjasle.eu>, devicetree@vger.kernel.org,
        linux-kbuild@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 7, 2023 at 7:48=E2=80=AFAM Andrew Davis <afd@ti.com> wrote:
>
> As a follow up to the series allowing DTB overlays to built from .dtso
> files. Now that all overlays have been renamed, remove the ability to
> build from overlays from .dts files to prevent any files with the old
> name from accidental being added.
>
> Signed-off-by: Andrew Davis <afd@ti.com>

Acked-by: Masahiro Yamada <masahiroy@kernel.org>

if Rob picks this up.


> ---
>  scripts/Makefile.lib | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
> index 100a386fcd71..68d0134bdbf9 100644
> --- a/scripts/Makefile.lib
> +++ b/scripts/Makefile.lib
> @@ -418,9 +418,6 @@ endif
>  $(obj)/%.dtb: $(src)/%.dts $(DTC) $(DT_TMP_SCHEMA) FORCE
>         $(call if_changed_dep,dtb)
>
> -$(obj)/%.dtbo: $(src)/%.dts $(DTC) FORCE
> -       $(call if_changed_dep,dtc)
> -
>  $(obj)/%.dtbo: $(src)/%.dtso $(DTC) FORCE
>         $(call if_changed_dep,dtc)
>
> --
> 2.39.2
>


--=20
Best Regards
Masahiro Yamada
