Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1939A74C035
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jul 2023 02:48:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbjGIAsg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jul 2023 20:48:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjGIAsf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jul 2023 20:48:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5866F1B1
        for <linux-kernel@vger.kernel.org>; Sat,  8 Jul 2023 17:48:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D2C7060B6A
        for <linux-kernel@vger.kernel.org>; Sun,  9 Jul 2023 00:48:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAD8CC433CB;
        Sun,  9 Jul 2023 00:48:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1688863713;
        bh=NpI7oDWpqAVs0CHykF8fwhNiyx1mUm8S3ReSuS96Jgg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=E96WqHPzB7bKJYspthaeV3NEac3yO784gTNlA8sR517nkvNQ7bkU6uojS8BzpUFTc
         EblVG1EXztwCwa1yo6FjeFFWRtT8zU7VSpMwJcHYoBQLfynrw5Vtcjf/Eqcpp5fqJE
         be5ZRThsPJLp44DoMAOMwGL2HDBxYkGbEWqghf/M=
Date:   Sat, 8 Jul 2023 17:48:32 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Raul E Rangel <rrangel@chromium.org>
Cc:     linux-kernel@vger.kernel.org, mario.limonciello@amd.com,
        kramasub@chromium.org, Alexander Potapenko <glider@google.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Li Zhe <lizhe.67@bytedance.com>,
        "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Zhou jie <zhoujie@nfschina.com>
Subject: Re: [PATCH] init: Don't proxy console= to earlycon
Message-Id: <20230708174832.0af1d974cf67805dfc8ad655@linux-foundation.org>
In-Reply-To: <20230707191721.1.Id08823b2f848237ae90ce5c5fa7e027e97c33ad3@changeid>
References: <20230707191721.1.Id08823b2f848237ae90ce5c5fa7e027e97c33ad3@changeid>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  7 Jul 2023 19:17:25 -0600 Raul E Rangel <rrangel@chromium.org> wrote:

> Right now we are proxying the `console=XXX` command line args to the
> param_setup_earlycon. This is done because the following are
> equivalent:
> 
>     console=uart[8250],mmio,<addr>[,options]
>     earlycon=uart[8250],mmio,<addr>[,options]
> 
> In addition, when `earlycon=` or just `earlycon` is specified on the
> command line, we look at the SPCR table or the DT to extract the device
> options.
> 
> When `console=` is specified on the command line, it's intention is to
> disable the console. Right now since we are proxying the `console=`
> flag to the earlycon handler, we enable the earlycon_acpi_spcr_enable
> variable when an SPCR table is present. This means that we
> inadvertently enable the earlycon.
> 
> This change makes it so we only proxy the console= command if it's
> value is not empty. This way we can correctly handle both cases.
> 

I hope someone understands this ;)

Please "grep -r earlycon Documentation" and check for suitable places
to update our documentation.


