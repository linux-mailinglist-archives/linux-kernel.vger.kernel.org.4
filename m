Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FA015FF422
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 21:36:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231320AbiJNTg4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 15:36:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbiJNTgx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 15:36:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FADC189821;
        Fri, 14 Oct 2022 12:36:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AF99C61C06;
        Fri, 14 Oct 2022 19:36:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C745C433D6;
        Fri, 14 Oct 2022 19:36:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665776212;
        bh=eEjhidYj5VNDiYpsn0HCO9fjIL2iJoV/K1rtE5CgI+c=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=hh6OMbuLYYkASYw11pxYoljgA2UiKs3kot9AoYNPCPFO8QRgzGmnX7Iqkub/mNvCp
         /WH49y9IFDgsbYhBLm86ry6R7MuRi+fP5mIkqW0sBDUkEhO5TXea9chdhqroaA7aJC
         gdFRcBmUSN+D8ToYTXW6/jCZf5ne/iIgSarYfptVWYlg1ZLCgFPQG8GrOs4vH498At
         KuAjBhT/G+L0dDXV+5slII16jNcDOV+mLSHeHZBKpD7hrTQDz8NkTUMial/yZgOYcE
         +KHv7H6DCLgeK8CKlMUPgvGGJ03d7fdWYvV2g9WgZckCrYRes7IDJRnxWYWb/jwIe+
         fj/Uc/fEKrqgA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20221012135619.wxyzuqheolhypoec@houat>
References: <20221011135548.318323-1-angelogioacchino.delregno@collabora.com> <20221012085555.3nls7ja56vlnaz2w@houat> <c4a1eb9f-016d-c184-e494-c869038b87ff@collabora.com> <20221012094004.jgiyvmbgomiyedik@houat> <6e76f90f-3b6a-330d-6902-b31bf3d33ad4@collabora.com> <20221012114813.6d6adro746w5bd7c@houat> <decfd5e5-a48b-b2d1-f21b-1a4d52e05538@collabora.com> <20221012135619.wxyzuqheolhypoec@houat>
Subject: Re: [PATCH v2] clk: mediatek: clk-mux: Add .determine_rate() callback
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     mturquette@baylibre.com, matthias.bgg@gmail.com,
        chun-jie.chen@mediatek.com, miles.chen@mediatek.com,
        wenst@chromium.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Maxime Ripard <maxime@cerno.tech>
Date:   Fri, 14 Oct 2022 12:36:50 -0700
User-Agent: alot/0.10
Message-Id: <20221014193652.0C745C433D6@smtp.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Maxime Ripard (2022-10-12 06:56:19)
>=20
> I think we need to address this in multiple ways:
>=20
> - If you have ftrace enabled on that platform, running with "tp_printk
>   trace_event=3Dclk:*" in the kernel command line on a failing kernel wou=
ld
>   be great, so that we can figure out what is happening exactly.
>=20
> - We really need to merge your patch above as well;
>=20
> - And, if we can, we should forbid to register a mux without a
>   determine_rate implementation. We have to take into account that some
>   muxes are going to be RO and won't need a determine_rate
>   implementation at all, but a clock with a set_parent and without a
>   determine_rate seems like a weird combination.
>=20

So should I apply this patch now on clk-next? Given this regression I'm
leaning towards not sending off the clk rate request this merge window
and letting it bake another cycle.
