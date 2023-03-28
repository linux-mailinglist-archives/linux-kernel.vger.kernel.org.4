Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 644B26CC9A3
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 19:49:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbjC1RtN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 13:49:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbjC1Rsn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 13:48:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9647D301;
        Tue, 28 Mar 2023 10:48:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6A09B618F1;
        Tue, 28 Mar 2023 17:48:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCFF2C433D2;
        Tue, 28 Mar 2023 17:48:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680025714;
        bh=ksYek1bvUMLYnCew1+mEmDZuLGTzn7CLWILhJMWLiRE=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=t9PdvvBf1/Bxi8gwVhioMwjJr5XvulDRb/Kz3QjTK9l1v4Z4QHRvF/vNjBCyQ8US4
         ovWK31oyqwkRF+cowHl0NqatlhxZPETyq+Lba+D+gv2RWaFo3Fp4TfY9GEKvC1j2SX
         WmQBtjslQQAFODvfh/fAOCIfHqYWrwnFFSfVg+vQHYO56qGzo64rDOrmTE35PWReog
         wilak6oBWi+QUjiEmXmq3SKoluZkmPfbYzEo3qW/QIcXjayfnAB5veQsdokZYAY0XJ
         AID65wlSzObTnJ3Lp/JIlfrF7Uj+ZX57pTkV8kQdAn5DbHQsNEvqkq/avhYeq9qZb6
         asVYKBQHERWEw==
Message-ID: <81d8a7b18901c85fd24705977e6b9ce3.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230328021912.177301-5-ychuang570808@gmail.com>
References: <20230328021912.177301-1-ychuang570808@gmail.com> <20230328021912.177301-5-ychuang570808@gmail.com>
Subject: Re: [PATCH v6 04/12] dt-bindings: reset: nuvoton: add binding for ma35d1 IP reset control
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        arnd@arndb.de, schung@nuvoton.com, mjchen@nuvoton.com,
        Jacky Huang <ychuang3@nuvoton.com>
To:     Jacky Huang <ychuang570808@gmail.com>, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lee@kernel.org, mturquette@baylibre.com, p.zabel@pengutronix.de,
        robh+dt@kernel.org
Date:   Tue, 28 Mar 2023 10:48:32 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jacky Huang (2023-03-27 19:19:04)
> +description:
> +  The system reset controller can be used to reset various peripheral
> +  controllers in MA35D1 SoC.
> +
> +properties:
> +  compatible:
> +    const: nuvoton,ma35d1-reset
> +
> +  '#reset-cells':
> +    const: 1
> +
> +required:
> +  - compatible
> +  - '#reset-cells'
> +
> +additionalProperties: false
> +
> +examples:
> +  # system reset controller node:
> +  - |
> +
> +    system-management@40460000 {
> +        compatible =3D "nuvoton,ma35d1-sys", "syscon", "simple-mfd";
> +        reg =3D <0x40460000 0x200>;
> +
> +        reset-controller {
> +            compatible =3D "nuvoton,ma35d1-reset";
> +            #reset-cells =3D <1>;
> +        };

This is prescribing driver details to the system-management node. The
reset-controller node should be removed, the #reset-cells moved up one
level, and the "nuvoton,ma35d1-sys" should match a driver that registers
an auxiliary device for reset functionality. Is anything besides child
nodes like 'reset-controller' using the syscon@40460000?
