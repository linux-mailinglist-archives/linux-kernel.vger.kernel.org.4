Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 977917374D8
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 21:03:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230322AbjFTTDT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 15:03:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230332AbjFTTDP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 15:03:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D7801BB;
        Tue, 20 Jun 2023 12:03:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9F0F76143A;
        Tue, 20 Jun 2023 19:03:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 027C0C433C0;
        Tue, 20 Jun 2023 19:03:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687287793;
        bh=ocvoJaordZ1TmlmbaY9HWKdK1EpPxdWV+jQBrjGqsz8=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=g6LqWydJv61aqdGT6skHOGjWhq8GG+OjQuc7/OrXG213LQwLrMUihQuCNVnnY1Aps
         F1XLUe/P64KBUpw345PEaatgc0kmvIyWDrqmfsYTIGXi73G8Le06vKRnm4rBQOt+Z+
         bwoD6Xnf862/5R2PdHjZ6LV+mbVllpwFNzANe4WohHCxHn6DVMTus5x0cLwVBmUiQE
         g84C8ntWDQcfkNYfJGWup82rN+GNXzfTzoRzB+onuyMHPO/DM14wcZLeTpI8EX8Xkp
         AlNU3QPehwns+UZH8Srbze/DNsW316BHznQtD4nXKhDWjHocWS36X6+YaFQNjqP90c
         OP85jUwnB2PgQ==
Message-ID: <e91019a0ed5f61634fbefca855da1f33.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230619112253.v2.1.I13f060c10549ef181603e921291bdea95f83033c@changeid>
References: <20230619112253.v2.1.I13f060c10549ef181603e921291bdea95f83033c@changeid>
Subject: Re: [PATCH v2] clk: Fix memory leak in devm_clk_notifier_register()
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Fei Shao <fshao@chromium.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
To:     Fei Shao <fshao@chromium.org>
Date:   Tue, 20 Jun 2023 12:03:10 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Fei Shao (2023-06-18 20:22:53)
> devm_clk_notifier_register() allocates a devres resource for clk
> notifier but didn't register that to the device, so the notifier didn't
> get unregistered on device detach and the allocated resource was leaked.
>=20
> Fix the issue by registering the resource through devres_add().
>=20
> Fixes: 6d30d50d037d ("clk: add devm variant of clk_notifier_register")
> Signed-off-by: Fei Shao <fshao@chromium.org>
> ---

Applied to clk-next

It would be nice to also add a test or two for this.
