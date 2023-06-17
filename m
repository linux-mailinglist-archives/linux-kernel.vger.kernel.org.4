Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29E6173430C
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 20:29:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346290AbjFQS24 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 14:28:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbjFQS2y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 14:28:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE01E1999;
        Sat, 17 Jun 2023 11:28:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6AA3861138;
        Sat, 17 Jun 2023 18:28:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64AB9C433C8;
        Sat, 17 Jun 2023 18:28:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687026531;
        bh=DIQI2aiPOqmTZwoXiyYS0cVloN0L8cK8fYmkEg4zs9Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WbtOZGRdTYByXuA/REJfyXx5w/wO/ggga9iEtYL4FlGhkdYD9IR0H4E6NUxNkrDgR
         rsaK5RzWLMnjH8LV5S+aG2k/AgWr4lfwxnQL55o1c4dknFXPZraGPHmMJ7wpYq9yXb
         zqXffiTmgABgNuUuhcwmuMuvrgy3xYLcOTdGuEz6PSPGGDikE88cm8468FONj9cS6r
         7jsKKW/UVHJC9TWYXdRY1KDOwXbZGte+pjj5G2f4kHlM9bfe6f2r019NTZq0nskG7g
         50NNMxYoHNcdD4Fgy+9lzAwjcsRKC76/jJZnu9IBQV/E/ThbWCkW7GKY9ScI3B8leq
         iYuIIgQ5WWf2Q==
From:   Conor Dooley <conor@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Jisheng Zhang <jszhang@kernel.org>
Cc:     conor@kernel.org, Conor Dooley <conor.dooley@microchip.com>,
        Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, arnd@arndb.de
Subject: Re: [PATCH v3 0/8] Add Sipeed Lichee Pi 4A RISC-V board support
Date:   Sat, 17 Jun 2023 19:20:43 +0100
Message-Id: <20230617-duress-phantom-3da79e33f204@spud>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230617161529.2092-1-jszhang@kernel.org>
References: <20230617161529.2092-1-jszhang@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1288; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=NHJtQzxObh7bfZ36xoARCKxRiu8T393ZQ6X51ZnJ1sc=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDCm9PyvZw7o3PF+yaPuySV+rtoq+b54np7xvtYS5OGtYv kZInPnqjlIWBjEOBlkxRZbE230tUuv/uOxw7nkLM4eVCWQIAxenAExEdSHDP+25u+fVud761HXA d+Oj61H11xLz9h0zNhHkfvaq7Yx1lx8jw8NWnVO1n96aPdoeUvtVzv3yqmP8b0yf+3448oiLy8J RlRsA
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Conor Dooley <conor.dooley@microchip.com>

On Sun, 18 Jun 2023 00:15:21 +0800, Jisheng Zhang wrote:
> Sipeed's Lichee Pi 4A development board uses Lichee Module 4A core
> module which is powered by T-HEAD's TH1520 SoC. Add minimal device
> tree files for the core module and the development board.
> 
> Support basic uart/gpio/dmac drivers, so supports booting to a basic
> shell.
> 
> [...]

Applied to riscv-dt-for-next, thanks!

[1/8] dt-bindings: interrupt-controller: Add T-HEAD's TH1520 PLIC
      https://git.kernel.org/conor/c/a04cc7391d88
[2/8] dt-bindings: timer: Add T-HEAD TH1520 clint
      https://git.kernel.org/conor/c/413c24b03f4e
[3/8] dt-bindings: riscv: Add T-HEAD TH1520 board compatibles
      https://git.kernel.org/conor/c/89b0186ab532
[4/8] riscv: Add the T-HEAD SoC family Kconfig option
      https://git.kernel.org/conor/c/da47ce003963
[5/8] riscv: dts: add initial T-HEAD TH1520 SoC device tree
      https://git.kernel.org/conor/c/8e396880a864
[6/8] riscv: dts: thead: add sipeed Lichee Pi 4A board device tree
      https://git.kernel.org/conor/c/5af4cb0c42c5
[7/8] MAINTAINERS: add entry for T-HEAD RISC-V SoC
      https://git.kernel.org/conor/c/1203f584fe66
[8/8] riscv: defconfig: enable T-HEAD SoC
      https://git.kernel.org/conor/c/318afa081204

I'll send it to Arnd as a "RISC-V Devicetrees for v6.5 Part 2" once it
has been in linux-next for a day or two.

Going forward, who is going to pick up the patches and send the PRs to
Arnd? I wrote a document that should be in v6.5 about SoC tree
submaintainer stuff that is worth reading:
https://lore.kernel.org/all/20230606-escapable-stuffed-7ca5033e7741@wendy/

I'll do it if nobody else is willing to, but I don't want to be
responsible for applying patches for all the platforms that pop up,
especially for ones that I don't even have the hardware for ;)

Thanks,
Conor.
