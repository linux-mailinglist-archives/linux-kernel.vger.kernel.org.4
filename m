Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86D3A6C5AE2
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 00:57:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbjCVX5g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 19:57:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230150AbjCVX5e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 19:57:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8552F305DE;
        Wed, 22 Mar 2023 16:57:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DAB0462351;
        Wed, 22 Mar 2023 23:57:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30014C433EF;
        Wed, 22 Mar 2023 23:57:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679529451;
        bh=y9U/5hZyFfh0oQkHVBhuHaZSSNPer4aXYq7GpolG5rU=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=hlTMsxwsdHEPbcZ0FHd0U3HCMN+5KMbB4GdzyMoynPPZs7M3Qulola3FMclIzMBGy
         MA7IFAqYndlH8nBQt2vxK/XtVd/DEocK2WNMBtztWjrQrEjTcaf6mKYAaLYklXaw2Y
         ccaJGUBIm0ZGvP+2ZkucdrrfK0BsWLYn+hV1JDOU2MkkKVEq4lBB3SYKqS55TF9w8K
         g73lN0U5uwtbmEX7W6uySdtlT0wnOrAoWPGY88DPUrYN4Bj2pgcF9sJo6QorusZx4s
         0pnDosayty3cjQPJ1PXT23JXZKQmywKg0PkvASpPD/i+jZLydr4DxMcWmW1qVJkh+b
         8aJmkhStClcSw==
Message-ID: <ce3e64bedd449e6c782e243c28cf4945.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <b4beb457-8581-4b2f-8655-2e3f82a94f75@spud>
References: <20230320103750.60295-1-hal.feng@starfivetech.com> <20230320103750.60295-12-hal.feng@starfivetech.com> <b4beb457-8581-4b2f-8655-2e3f82a94f75@spud>
Subject: Re: [PATCH v6 11/21] dt-bindings: clock: Add StarFive JH7110 system clock and reset generator
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Michael Turquette <mturquette@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Ben Dooks <ben.dooks@sifive.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        linux-kernel@vger.kernel.org
To:     Conor Dooley <conor@kernel.org>,
        Hal Feng <hal.feng@starfivetech.com>
Date:   Wed, 22 Mar 2023 16:57:29 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Conor Dooley (2023-03-22 14:53:37)
>=20
> This leaves me wondering which clocks are *actually* required for a
> functioning system - is it actually just osc and one of gmac1_rmii_refin
> or gmac1_rgmii_rxin.
>=20
> I really don't want you to have to go and spell out every combination of
> clocks to have some sort of validation here.
>=20
> Stephen, Rob or Krzysztof, do you have any guidance on this situation
> (assuming I've not made a fool of myself)? There's probably something
> "obvious" that I'm missing, as I am sure this is not a unique problem.
>=20

You can always use '<0>' if the pad isn't connected for that clk input.
It's not great, but it works, so there's an escape hatch if you need it.
