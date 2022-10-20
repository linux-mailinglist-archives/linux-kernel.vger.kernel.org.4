Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B6AA606B85
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 00:47:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbiJTWry (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 18:47:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbiJTWrv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 18:47:51 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4932722D5B4;
        Thu, 20 Oct 2022 15:47:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6358FB829BA;
        Thu, 20 Oct 2022 22:47:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BCA9C4347C;
        Thu, 20 Oct 2022 22:47:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666306065;
        bh=Z6h4fiMZNTudlMNmgFxn8uqKN4ZLGwFX1pM5STB8bgU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=IuajgbaZ3oMMFzM2Ml6ZpGykxu+wOiuilmGDZ+yYrSAlxR8f9MESQB+MbEgKj36+w
         NHpIABG3CUdOqot6h0sUGXNNE1QrKy9ZEtAYVL0AUL1LOHMwaXndPJzas4rqJTzGW4
         2OQRiSLrEHwkgzTtTjhP8EunkBv/wLfGdi0go4jlkc9ucVKLfvnONxsYegH9huFDxa
         Oh2edeFrOFo1B3FN0Wi589hUqWpSaFjsRC2YT9E+Oc+K7PxQDXoeLRkfPB3dBlHSda
         sM7GDvsxCIRaHfqCNyO7z4J57TlfwqHxFLF/ZBgpgEWs0L0j51I6M6DmXrJPq0hnVU
         7sp8OuBqfFG0A==
Received: by mail-ua1-f44.google.com with SMTP id j6so1103819uaa.10;
        Thu, 20 Oct 2022 15:47:44 -0700 (PDT)
X-Gm-Message-State: ACrzQf2oNyu+THrETl8YD15ym4PLnl4L7kJBkZAunE7RuHd4Jz7AGzkW
        5ben/lDSfllNWfN1dAWSxt1QAQ1LlwxDibpCbQ==
X-Google-Smtp-Source: AMsMyM6SRs5iGDxFTlJ6d06xbMPre8Gf5kzb+q2tHwbla775ouzvqQs0W/dPfISyGmCqQavruBkETdveDQXsBvMf2xU=
X-Received: by 2002:a67:c088:0:b0:39b:1bb3:bdd1 with SMTP id
 x8-20020a67c088000000b0039b1bb3bdd1mr8506943vsi.85.1666306063880; Thu, 20 Oct
 2022 15:47:43 -0700 (PDT)
MIME-Version: 1.0
References: <20221014151302.27641-1-afd@ti.com>
In-Reply-To: <20221014151302.27641-1-afd@ti.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 20 Oct 2022 17:47:34 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+O0_i3k_3S=W6C-n+ZE7GRKKhOQ7HR54QutmMJq54a_Q@mail.gmail.com>
Message-ID: <CAL_Jsq+O0_i3k_3S=W6C-n+ZE7GRKKhOQ7HR54QutmMJq54a_Q@mail.gmail.com>
Subject: Re: [PATCH] kbuild: Allow DTB overlays to built from .dtso named
 source files
To:     Andrew Davis <afd@ti.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        devicetree@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 14, 2022 at 10:13 AM Andrew Davis <afd@ti.com> wrote:
>
> Currently DTB Overlays (.dtbo) are build from source files with the same
> extension (.dts) as the base DTs (.dtb). This may become confusing and
> even lead to wrong results. For example, a composite DTB (created from a
> base DTB and a set of overlays) might have the same name as one of the
> overlays that create it.
>
> Different files should be generated from differently named sources.
>  .dtb  <-> .dts
>  .dtbo <-> .dtso
>
> We do not remove the ability to compile DTBO files from .dts files here,
> only add a new rule allowing the .dtso file name. The current .dts named
> overlays can be renamed with time. After all have been renamed we can
> remove the other rule.

There was a patch from Geert converting everything. I'd rather not
support both ways.

Rob
