Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DCE06106DB
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 02:31:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235235AbiJ1AbD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 20:31:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235164AbiJ1AbA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 20:31:00 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7802378202;
        Thu, 27 Oct 2022 17:30:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D1031B826AC;
        Fri, 28 Oct 2022 00:30:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E83AC433D6;
        Fri, 28 Oct 2022 00:30:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666917056;
        bh=7AzsoUE0rePpZbDqReVe3Q4DRi9Xz6YXEX1Qv13iM14=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=Olckj3vv9hu4ai3gmJOB1gAkrx/e8s467ngyyU0jziLGXp4acIubZ4KUFTOVI3D/v
         coH7hSDl7knKh3k7V0HK+bqe5fA5ranAc6h6+WGmjbQwdyazlWR4UYEBpCSuLQMI5s
         CElCk59xG2+IqqPdg+GBIWh785z7tkjWH767L1mpLPOfmfaDfpRl1i3lFwywddf2eW
         9FCBoDSfzr/aFacknU6vwnP5cQh+kZOot1tMYZN4QOvs3MoviOtd9vDgX3e1ipSg4c
         gbbs+fTvuZo8+YnQ9iqaQSdmj65aYkObr5By8B9TQpdo6fde874TpGy0viWmyof+hb
         CDj9Ld9bbEBMw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20221018070653.gsvnacqe7chvzux2@houat>
References: <20221011135548.318323-1-angelogioacchino.delregno@collabora.com> <20221012085555.3nls7ja56vlnaz2w@houat> <c4a1eb9f-016d-c184-e494-c869038b87ff@collabora.com> <20221012094004.jgiyvmbgomiyedik@houat> <6e76f90f-3b6a-330d-6902-b31bf3d33ad4@collabora.com> <20221012114813.6d6adro746w5bd7c@houat> <decfd5e5-a48b-b2d1-f21b-1a4d52e05538@collabora.com> <20221012135619.wxyzuqheolhypoec@houat> <20221014193652.0C745C433D6@smtp.kernel.org> <20221018070653.gsvnacqe7chvzux2@houat>
Subject: Re: [PATCH v2] clk: mediatek: clk-mux: Add .determine_rate() callback
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, mturquette@baylibre.com,
        matthias.bgg@gmail.com, chun-jie.chen@mediatek.com,
        miles.chen@mediatek.com, wenst@chromium.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
To:     Maxime Ripard <maxime@cerno.tech>
Date:   Thu, 27 Oct 2022 17:30:54 -0700
User-Agent: alot/0.10
Message-Id: <20221028003056.6E83AC433D6@smtp.kernel.org>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Maxime Ripard (2022-10-18 00:06:53)
>=20
> We spent some time with Angelo yesterday debugging this, and it's still
> not clear to me what happens.
>=20
> He provided a significant amount of traces, and we first checked that
> the round_rate part of set_rate was returning something meaningful, and
> it does. The rate is fine, the parent is too, everything's great.
>=20
> Next we checked the decisions by clk_calc_new_rates, and it does return
> the proper top clock, and its proper rate.
>=20
> Finally, we hooked into clk_change_rate() to see what kind of decision
> it was enforcing, and it seems to be ok as well. It doesn't change
> parent, and it sets the proper rate, in both cases.
>=20
> There's still one thing we haven't checked: one of the clock in the tree
> (the parent of the one we want to change the rate on, and it has
> SET_RATE_PARENT) has a notifier. As we've had a bug recently over this
> I've not ruled out that this could be a similar bug.
>=20
> I don't really think it is though, since the notifier callback doesn't
> use the data provided by the framework:
> https://elixir.bootlin.com/linux/v6.1-rc1/source/drivers/clk/mediatek/clk=
-mux.c#L279
>=20
> I've pushed a branch for Angelo to test, just to confirm.
>=20
> So... yeah. I can't explain the regression at this point. Do you have an
> idea?

I don't really know. If the removal of WARN_ON() helps then it sounds
like a console related problem where we hang the system trying to print
the warning to the console. Did you try replacing that case with a
trace_printk()?

>=20
> The good news is, since you merged this patch the regression is
> invisible now to that platform. We still could encounter it on another
> platform, but maybe it will also have a more obvious setup to replicate?
>=20

I guess that's good news :-/
