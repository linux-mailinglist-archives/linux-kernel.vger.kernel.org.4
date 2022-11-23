Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FFF76362BE
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 16:06:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237752AbiKWPGO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 10:06:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237481AbiKWPGL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 10:06:11 -0500
Received: from conssluserg-06.nifty.com (conssluserg-06.nifty.com [210.131.2.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D727DB1;
        Wed, 23 Nov 2022 07:06:08 -0800 (PST)
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id 2ANF5sks007895;
        Thu, 24 Nov 2022 00:05:54 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com 2ANF5sks007895
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1669215954;
        bh=FcicfKxMXur2camuFtvNmMoesahp5Zu3Qyk4pgU2qGE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=JXT6e7ifPKuP0zvnbg4d9bJrUn/Mg4ynDmlUQlcYz20npO1py1Z5aodfI5OQatceD
         Y+6K+p46FpBc9FcnkyN/L6Lvk+4whcKjGbh/m5XHBNvZo9RuhXrOantj01PVfzG3gJ
         VlPrcWJyLflPywZ33jRvn+LyHVlIESTLvqMLPt6n7uFNhjXJpTizKykyAtjGCISVX1
         eSz+vbYfXtOcUd4yUYiHCszEw8C87LNlZ0kR1JF/3ESVeq0vqQLmDplXbED6me/7XC
         TbiBBlgrEnnsTvFttophvi+3vO8fEywlVeYVLQrkCCWenX63sHp/pNRS9naaJSdmuC
         ib5VnC93kqW7Q==
X-Nifty-SrcIP: [209.85.160.50]
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-13bd2aea61bso21161848fac.0;
        Wed, 23 Nov 2022 07:05:54 -0800 (PST)
X-Gm-Message-State: ANoB5pliZ/SzAEQdiHdUnBLuWWojWoWFBAp2kFEuyga0y8BzHBh9az1+
        +v1b0/l7gDVvHcP1SumCVv+f88VY0Lf+PpnIK98=
X-Google-Smtp-Source: AA0mqf6H8weAmID1s8Bzo/xGXbdTBWbDtDbdP2NrRREONOq5wBClQm1cvQC0kIXzBF8vGZDFOhji8yikV/htycJTQ2w=
X-Received: by 2002:a05:6870:3b06:b0:13b:5d72:d2c6 with SMTP id
 gh6-20020a0568703b0600b0013b5d72d2c6mr4925598oab.287.1669215953363; Wed, 23
 Nov 2022 07:05:53 -0800 (PST)
MIME-Version: 1.0
References: <20221118195307.86049-1-masahiroy@kernel.org> <20221118195307.86049-3-masahiroy@kernel.org>
In-Reply-To: <20221118195307.86049-3-masahiroy@kernel.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Thu, 24 Nov 2022 00:05:17 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQWdZSjQNXx+1D=he6KSPSqPg4FN1+OEg3RC3Q12t1dTw@mail.gmail.com>
Message-ID: <CAK7LNAQWdZSjQNXx+1D=he6KSPSqPg4FN1+OEg3RC3Q12t1dTw@mail.gmail.com>
Subject: Re: [PATCH 2/6] kbuild: make CONFIG_*_VERSION always 6-digit
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 19, 2022 at 4:53 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> CONFIG_*_VERSION is the version number of a tool in a 5 or 6-digit form.
> This is fine in the Kconfig perspective because Kconfig supports numeric
> comparison (<, <=, >, >=).
>
> It is harder in Makefiles due to make's limited numerical capabilities.
> So, we ask for shell's "test" command when we compare versions, but it
> needs some process forks.
>
> test-{le,ge,lt,gt} macros can compare versions by using only built-in
> functions, but the number of digits must be aligned for those macros
> to work correctly.
>
> This commit (ab)uses Kconfig's hex type, which allows '0' prefixes,
> in order to make CONFIG_*_VERSION always 6-digit.
>
> For example with GCC 9.5, CONFIG_GCC_VERSION=90500 will be turned
> into CONFIG_GCC_VERSION=090500.
>
> I touched several Kconfig files so that versions are consistently
> compared against 6-digit numbers although this is not mandated.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>


I terribly missed that CONFIG_*_VERSION changed the meaning
in C files (decimal -> octal).

I will drop this in V2.



-- 
Best Regards
Masahiro Yamada
