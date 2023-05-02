Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B22F6F3EA7
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 09:58:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233676AbjEBH6p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 03:58:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbjEBH6n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 03:58:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A202FE5D
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 00:58:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 37A5361189
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 07:58:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 461B0C433D2;
        Tue,  2 May 2023 07:58:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683014321;
        bh=Di+CY58Mv1cLOwK0+fli+h3/RPyphg1Iwtqi2Gwr6eA=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=kcVYZpebOC6xC0QkmQBTYDQZYx5R33S7Ypws5NSx3jDLx2wILj8ros1iIGVyB7rPs
         8WRstCiJXKIaOhMLY6oKD/z1kijc5O88vABkRo1TaI8rydX/+BYPprUpgiLoAuUTgn
         BLf3rP2MarCUvLyDgUrRZK/xDZrh9untWS461OKBnK7yFZIz32vbGyUhDATfuV7aNO
         egqLj0a183XPG/4veOvev3w5gRR7kCyHAWYUxq3WOIaSYiqzhjvfhrZTQmsmQ2MH4B
         Y7+wZc6c4KMbmODxcptwzIP0pTmDjW4U6hKA+mukEy4epQXSF0WFqwcq5F8S6iRgkI
         Tg7fUgBSoId4Q==
From:   =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To:     Philipp Tomsich <philipp.tomsich@vrull.eu>,
        Jessica Clarke <jrtc27@jrtc27.com>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Kito Cheng <kito.cheng@sifive.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        matthias.bgg@gmail.com,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        Greentime Hu <greentime.hu@sifive.com>, nick.knight@sifive.com,
        christoph.muellner@vrull.eu, richard.henderson@linaro.org,
        arnd@arndb.de, linux-kernel@vger.kernel.org,
        Heiko Stuebner <heiko.stuebner@vrull.eu>
Subject: Re: [PATCH 0/4] Expose the isa-string via the AT_BASE_PLATFORM aux
 vector
In-Reply-To: <CAAeLtUADqnwrgBjhDd+iNfwhMU6YBiMUZzeopVMAh0Jq19W9JA@mail.gmail.com>
References: <20230424194911.264850-1-heiko.stuebner@vrull.eu>
 <87ednz7roh.fsf@all.your.base.are.belong.to.us>
 <7DD2C38C-CBB3-41EE-A195-50E4C2451B7E@jrtc27.com>
 <CAAeLtUADqnwrgBjhDd+iNfwhMU6YBiMUZzeopVMAh0Jq19W9JA@mail.gmail.com>
Date:   Tue, 02 May 2023 09:58:38 +0200
Message-ID: <87jzxrnp01.fsf@all.your.base.are.belong.to.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Philipp Tomsich <philipp.tomsich@vrull.eu> writes:

> It is a pity that the current interface was designed without involving
> RVI (and that I had to ask my team to put together a patch set for
> further discussion, given that none of the other major vendors in RVI
> stepped forward).  I guarantee that plenty of reviewers would have
> highlighted that a central registry (even if it is just a kernel
> header) should be avoided.

Are you claiming that the hwprobe work was not done in the open, but
secretly merged? That is not only incorrect, but rude to upstream RISC-V
Linux developers. I suggest you review how you interact with upstream
kernel work.

Why didn't RVI get involved in the review of the series? The expectation
cannot be that all open source projects go to RVI, but rather the other
way around.

Take a look at commit ea3de9ce8aa2 ("RISC-V: Add a syscall for HW
probing"). Your team was very much involved in the review.


Bj=C3=B6rn
