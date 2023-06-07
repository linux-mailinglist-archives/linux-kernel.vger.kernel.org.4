Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99627725F25
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 14:23:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240786AbjFGMXc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 08:23:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240731AbjFGMX1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 08:23:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12F76AA;
        Wed,  7 Jun 2023 05:23:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A423463E9C;
        Wed,  7 Jun 2023 12:23:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18BA1C433A0;
        Wed,  7 Jun 2023 12:23:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686140605;
        bh=wQ2PthgiSFSOfoeNAKPOnBXd5R0adG06am8FVzxfcJw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Ud3ksMoEq/FBB5EuoUaiBccr8CZyRR/z3n7H6ok6I3EPowgCgAZ3keeUbin8q5D1K
         XU/pA+9KhZ+QVNgzOQjvnHt/DBu0qLOuRQGmmdRQgaxW6VEog6S3+Z34K/4QioLbT+
         3ueE4qMum4G+LS9kqqnaXV8C1Oe4awHivIJLX7By8EP6hLL1Gb2TzDezDfgWxx+Sdi
         kqm6hDp9PnZT7wncc4AZUGGz2FCyY7o5Xm81jZ36IcoQakLBR6YTSy66CpcawIFKcL
         75I0GWOdwz5EErHVhbUfYTUSIBs1aXFV9kfvVMZN5zFwE/nkNwMeuftR9PWOlQFkCv
         jDNUqMVktFhtA==
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-39a505b901dso6370144b6e.0;
        Wed, 07 Jun 2023 05:23:25 -0700 (PDT)
X-Gm-Message-State: AC+VfDxLVRjBotA1qSrJAG+VqH13U1JjXaf/W2NApd3VNuqsPmb+ccCv
        g0AJk7spOLI4CsQ4YszShE97RCwDJrCQHbnVmrk=
X-Google-Smtp-Source: ACHHUZ4V2qShsZwg8uGrWwqg+PFp2SDpEctQMURgTG6Q7SjWwq6hI9v7HmsEd05fxytwd0m5Foyh3rNQtwEK/l6JxWE=
X-Received: by 2002:aca:6546:0:b0:39b:3491:c5b8 with SMTP id
 j6-20020aca6546000000b0039b3491c5b8mr5323539oiw.52.1686140604279; Wed, 07 Jun
 2023 05:23:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230607061417.13636-1-jirislaby@kernel.org>
In-Reply-To: <20230607061417.13636-1-jirislaby@kernel.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Wed, 7 Jun 2023 21:22:47 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQsBBKPpHUdqcQmTcoU-CSqmWC2cV+uz+xWuqgBm7Wq=Q@mail.gmail.com>
Message-ID: <CAK7LNAQsBBKPpHUdqcQmTcoU-CSqmWC2cV+uz+xWuqgBm7Wq=Q@mail.gmail.com>
Subject: Re: [PATCH] streamline_config.pl: handle also ${CONFIG_FOO}
To:     "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>,
        andreas.noever@gmail.com, michael.jamet@intel.com,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        YehezkelShB@gmail.com, Steven Rostedt <rostedt@goodmis.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 7, 2023 at 3:14=E2=80=AFPM Jiri Slaby (SUSE) <jirislaby@kernel.=
org> wrote:
>
> From: Jiri Slaby <jslaby@suse.cz>
>
> streamline_config.pl currently searches for CONFIG options in Kconfig
> files as $(CONFIG_FOO). But some Kconfigs (e.g. thunderbolt) use
> ${CONFIG_FOO}. So fix up the regex to accept both.
>
> This fixes:
> $ make LSMOD=3D`pwd/`/lsmod localmodconfig
> using config: '.config'
> thunderbolt config not found!!
>
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> Cc: andreas.noever@gmail.com
> Cc: michael.jamet@intel.com
> Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
> Cc: YehezkelShB@gmail.com
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
> ---


Applied to linux-kbuild.
Thanks.


--=20
Best Regards
Masahiro Yamada
