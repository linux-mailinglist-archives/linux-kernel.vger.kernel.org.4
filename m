Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E67D6AAE8C
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Mar 2023 09:10:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbjCEIKw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Mar 2023 03:10:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjCEIKu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Mar 2023 03:10:50 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96AAEEB54;
        Sun,  5 Mar 2023 00:10:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 405AFB80942;
        Sun,  5 Mar 2023 08:10:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1CECC4339C;
        Sun,  5 Mar 2023 08:10:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678003845;
        bh=MuuRgcA2SK0KtsfkRXWe9vtpoHAbvlIgFEaN+WS+Ka4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=PuR//aMRF01TtHLuXoiLnA4jMzgmzqcKrbxIyV5EzqEQv+pIiAc9YEWFPj7GQjRxn
         txF0TNRnt/PGzfsyWztf7dHHm0uxFiGQ+HHjyxTcmiOMwgbpRt0y59vy2hu0fQSOui
         m8euxNdIFMLqODHQnyNuchWLy1fjbWlag3YrCxgwjOo1W0cP5GWDH1Nu+2+ECZwlgt
         Ki8nP75teksYqMY9v5vYs30f9k9MsZmLpfYb4NBao86sfkUpT3QGKmefFUkyOLUdXg
         kWROTjf2LK5gUa6N+6Pd4aO0wxg4aWi2mp5hUEXE4TcHIapGKalnmBhnOz4SvYdESI
         xA5pPyW+69GoQ==
Received: by mail-ot1-f50.google.com with SMTP id e9-20020a056830200900b00694651d19f6so849030otp.12;
        Sun, 05 Mar 2023 00:10:45 -0800 (PST)
X-Gm-Message-State: AO0yUKW/yfK9FfpKHR3x8tLTeslVoBDYfaTiEDdDv5k4YFHm1ZZahp2/
        8VBpQ8QIScBQOec82kjUUvCXCSnFC4rMCwqodsA=
X-Google-Smtp-Source: AK7set8+X8UYYW7FdWrjFjAN2ijVn+1/+c3oiv16LLk/6CvYx3oVEk618Vu8Ah+3bf9oqvAL6epjfchpDgjnlL/KbEo=
X-Received: by 2002:a05:6830:3374:b0:693:ce5a:7a72 with SMTP id
 l52-20020a056830337400b00693ce5a7a72mr2138120ott.0.1678003845218; Sun, 05 Mar
 2023 00:10:45 -0800 (PST)
MIME-Version: 1.0
References: <20221205163157.269335-1-nick.alcock@oracle.com> <20221205163157.269335-3-nick.alcock@oracle.com>
In-Reply-To: <20221205163157.269335-3-nick.alcock@oracle.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sun, 5 Mar 2023 17:10:08 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQLttPD=Ae==e0CYeQtS78=o_JZFK+zxa29JnUYio52Ug@mail.gmail.com>
Message-ID: <CAK7LNAQLttPD=Ae==e0CYeQtS78=o_JZFK+zxa29JnUYio52Ug@mail.gmail.com>
Subject: Re: [PATCH v10 02/13] kbuild: bring back tristate.conf
To:     Nick Alcock <nick.alcock@oracle.com>
Cc:     mcgrof@kernel.org, linux-modules@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
        arnd@arndb.de, akpm@linux-foundation.org, eugene.loh@oracle.com,
        kris.van.hees@oracle.com,
        Victor Erminpour <victor.erminpour@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 6, 2022 at 1:32=E2=80=AFAM Nick Alcock <nick.alcock@oracle.com>=
 wrote:
>
> tristate.conf was dropped because it is not needed to build
> modules.builtin any more, and doing so avoids one round of recursion
> through the build tree to build it.  But it has one property that can be
> obtained in no other way in the current tree: it provides a
> machine-readable record of whether a module is tristate or not.
> (modules.builtin.objs, just added, uses modinfo, which is recorded in
> the source files themselves, but it is Kconfig that actually controls
> whether something can be built as a module.)
>
> So bring it back for this purpose.  (Thanks to the refactoring in
> the 5.16 timeframe, this is basically a reimplementation of commit
> 8b41fc4454e36fbfdbb23f940d023d4dece2de29 rather than a simple
> reversion.)
>
> A verifier that uses it will be added in the next commit.

>
> Signed-off-by: Nick Alcock <nick.alcock@oracle.com>
> Reviewed-by: Victor Erminpour <victor.erminpour@oracle.com>
> Reviewed-by: Kris Van Hees <kris.van.hees@oracle.com>



IIRC, I said please do not do this.
Please do not come back with this again.

NACK.






--
Best Regards
Masahiro Yamada
