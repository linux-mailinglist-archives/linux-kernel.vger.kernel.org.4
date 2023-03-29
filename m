Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44BC86CD000
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 04:35:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbjC2CfE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 22:35:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjC2CfC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 22:35:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8A7F2703;
        Tue, 28 Mar 2023 19:35:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3CAD061A3F;
        Wed, 29 Mar 2023 02:35:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 818F7C433D2;
        Wed, 29 Mar 2023 02:35:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680057300;
        bh=GqNruyQ94NkZ9NZt0BUZLkCLHVLlwAwMXOdfDeCJI04=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=ovg0HlNr3Bs88xxOHq4hcpTCtbM+6JRYm0WsI4AU+1u5NlvgImtKg6x2VOrNqhzmy
         TXo7abF/Uk6iVlsJedflsT7NZ1qXTPi9LYQirrguYQKQFJ3EEqf3ntsIOe0+zk5DES
         cpt/Nnb5NDzbaAuklKOJtjlLXpNzjYQlhUk+9DPff5rSRmNljbwFkKUgHVfwDPbGwW
         fKHdMZTPeIaw8iWgBjhJO9jC+OBXaaaSEIYp4m0C1Oo5OAeMfJFDmywcnwTL+RHc5F
         DNUQofY35JnnjosPfUZcGgfaHjDNSvTY/OrfctUMLtCFIke/F8qDhHgB87vERs5fK6
         zMZZ3BDDpf5DA==
Message-ID: <ce45ed77bb246d98adda4f478c020222.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230312161512.2715500-3-u.kleine-koenig@pengutronix.de>
References: <20230312161512.2715500-1-u.kleine-koenig@pengutronix.de> <20230312161512.2715500-3-u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 02/30] clk: tegra: Don't warn three times about failure to unregister
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
To:     Jonathan Hunter <jonathanh@nvidia.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?utf-8?q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Date:   Tue, 28 Mar 2023 19:34:58 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Uwe Kleine-K=C3=B6nig (2023-03-12 09:14:44)
> tegra124_dfll_fcpu_remove() calls tegra_dfll_unregister() and the former
> emits an error message if the latter fails. In that case
> tegra_dfll_unregister() already printed an error message. Additionally
> tegra124_dfll_fcpu_remove() returns an error code which results in yet
> another warning emitted by platform_remove().
>=20
> So drop the error message from tegra124_dfll_fcpu_remove() and let it
> return 0. (Retuning 0 has no side effect but suppressing the error
> message in platform_remove().)
>=20
> Also add two comments about exiting early being wrong. This is something
> that needs fixing separately.
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> ---

Applied to clk-next
