Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FD7C6F4E90
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 03:26:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229524AbjECB0L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 21:26:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjECB0J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 21:26:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3524E7;
        Tue,  2 May 2023 18:26:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 62A2B6279F;
        Wed,  3 May 2023 01:26:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8D2CC433EF;
        Wed,  3 May 2023 01:26:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683077167;
        bh=yfXb6HBJfxGRsvQq8x+uwZmeOtzJNT0zUqOBlv/LAns=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=CvTmqCbXoAiH5sPH8UAlhlCuUxgkYv7LnY2PXuJ+6qejtZqfFGVYVr+/1supPfl9W
         wYbjQHzrvEEswXpMZZtOzkvvOFzV0I4LF5EiB6XDtfGlQB88JMkSVf0WV7XFzj85oP
         s1K3NfSUErcRXTrWw8ufHmlXTk2N8bqGZ0l+20GERQX/rhL/BTk70oCmoPR6qmNDUc
         ozqQ4fCA1fB1nX0aJhTqAtAqMLb+QRtTaYF71xsVZ1KSC9BMTXau5/dGrSQgjjI2x3
         e4a2tZ39qithnSu3rWeST/z8B/kWC6isG7ajbu2b1zG/NjKDi2iMA9puhFyynoTa5a
         rr1l21t+xVnWQ==
Message-ID: <bbe8ffe3e2f45ae697d7002dbff0c92a.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230418123756.62495-2-hal.feng@starfivetech.com>
References: <20230418123756.62495-1-hal.feng@starfivetech.com> <20230418123756.62495-2-hal.feng@starfivetech.com>
Subject: Re: [PATCH v2 1/1] clk: starfive: Fix RESET_STARFIVE_JH7110 can't be selected in a specified case
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Paul Gazzillo <paul@pgazz.com>,
        Necip Fazil Yildiran <fazilyildiran@gmail.com>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Hal Feng <hal.feng@starfivetech.com>,
        Xingyu Wu <xingyu.wu@starfivetech.com>,
        linux-kernel@vger.kernel.org
To:     Hal Feng <hal.feng@starfivetech.com>, linux-clk@vger.kernel.org,
        linux-mm@kvack.org, oe-kbuild-all@lists.linux.dev
Date:   Tue, 02 May 2023 18:26:05 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Hal Feng (2023-04-18 05:37:56)
> When (ARCH_STARFIVE [=3Dn] && COMPILE_TEST [=3Dy] && RESET_CONTROLLER [=
=3Dn]),
> RESET_STARFIVE_JH7110 can't be selected by CLK_STARFIVE_JH7110_SYS
> and CLK_STARFIVE_JH7110_AON.
>=20
> Add a condition `if RESET_CONTROLLER` to fix it. Also, delete redundant
> selected options of CLK_STARFIVE_JH7110_AON because these options are
> already selected by the dependency.
>=20
> Fixes: edab7204afe5 ("clk: starfive: Add StarFive JH7110 system clock dri=
ver")
> Fixes: b2ab3c94f41f ("clk: starfive: Add StarFive JH7110 always-on clock =
driver")
> Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
> ---

Applied to clk-next
