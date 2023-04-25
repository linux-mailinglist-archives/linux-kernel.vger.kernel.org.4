Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ACD16ED9D0
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 03:24:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232846AbjDYBYv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 21:24:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232815AbjDYBYt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 21:24:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ADBE5277;
        Mon, 24 Apr 2023 18:24:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 955C6621BD;
        Tue, 25 Apr 2023 01:24:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9DF7C433D2;
        Tue, 25 Apr 2023 01:24:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682385888;
        bh=T7EvH2flz7r0yejnh3Y8Zgihn3vRMWwnaw/B65iiSck=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=iHvBd5rshkoX58teEXxJFAijZbUh1+lHUlolLCKUP0WfaSf3nnbh3G0r1SVQZv3zK
         h/1dif6N+6qUowV/VKAT8KC92LO4vMrYL+OKwA0qjl/r+dJSM+PQl4pJ6S/BwYc7YK
         +5MkpD1ALO5mj/axYYg8+c6rf2yaKkmNdgHPh7HfsRSWGa12btHKS9EEkDI41sggRw
         xx1SkF/9AJs1FNDVijQ95siiQ3pukPpbkujJDS7hXV0pKOEyz5l+NrqlVi2/6BdxZt
         V6vvXqgxetVl1sAPgWQssemT375Rjch+stRV1OkP82kavTmRSUn0Ixg0A52o2fSBCS
         xXp9tFsrzKMMA==
Message-ID: <c428d3a4466b1a608e3e8b2434e8d5d9.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230421-clk-v1-1-bb503f2f2cf3@outlook.com>
References: <20230421-clk-v1-1-bb503f2f2cf3@outlook.com>
Subject: Re: [PATCH] clk: use ULONG_MAX as the initial value for the iteration in clk_mux_determine_rate_flags()
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yang Xiwen <forbidden405@outlook.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Yang Xiwen via B4 Relay 
        <devnull+forbidden405.outlook.com@kernel.org>,
        forbidden405@outlook.com
Date:   Mon, 24 Apr 2023 18:24:44 -0700
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

Quoting Yang Xiwen via B4 Relay (2023-04-21 08:56:38)
> From: Yang Xiwen <forbidden405@outlook.com>
>=20
> Currently, clk_mux_determine_rate_flags() use 0 as the initial value for
> selecting the best matching parent. However, this will choose a
> non-existant rate(0) if the requested rate is closer to 0 than the
> minimum rate the parents have.
>=20
> Fix that by initializing the initial value to ULONG_MAX and treat it as a
> magic number.

Can you add a unit test to clk_test.c as well?
