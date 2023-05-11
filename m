Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 731336FFCB8
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 00:37:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239426AbjEKWhz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 18:37:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239214AbjEKWhw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 18:37:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9EDF5584;
        Thu, 11 May 2023 15:37:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5EAF765171;
        Thu, 11 May 2023 22:37:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BADDCC433D2;
        Thu, 11 May 2023 22:37:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683844667;
        bh=+D78NZFIyG9cTjRHg49tXEf4K+BxuWLjB0MhRWS4xmE=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=LNceuXEs3YJ/BM9/ZeKGTCnwt2V1n/VFVwM1GOOT+pRx8Jf9wscrAqwTj/yh81exC
         CVFH98y0ClXaApMBqZbmjlRBCp2+5t/v2WkkmpzCWUyz41EMcg4UwyrGN/uXf4H+Tf
         3+1eKv65w6Fc4cSVaR+DMFgduf3ELmaNoULr49Svan9i2eUIsMVZgj3WygJnpEjNfp
         PCia0Bv0Qpej5ElOPrj0wAcf2OM+Dtu7CMf+3ZPLv7kgVlNWE9qkCIZUZyHkljWprr
         fsJN6fecyaRUyKevsnMySmDkh3zyfTUxDrJbCGt5ZwvIizy0bk3IFCk7DY/uBKkntu
         E7rb0olHklYXQ==
Message-ID: <ead66129a75a558badf81b07955b7cec.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230511092654.6d8fab41@haoge-QiTianM428-A376>
References: <20230509021214.17105-1-gehao@kylinos.cn> <b35458250af972d95c708792633c9a58.sboyd@kernel.org> <20230511092654.6d8fab41@haoge-QiTianM428-A376>
Subject: Re: [PATCH] mediatek/clk-mt8173-apmixedsys: use devm_of_iomap to avoid resource leak in clk_mt8173_apmixed_probe
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Hao Ge <gehao@kylinos.cn>, angelogioacchino.delregno@collabora.com,
        matthias.bgg@gmail.com, mturquette@baylibre.com,
        wenst@chromium.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
To:     Hao Ge <gehao618@163.com>
Date:   Thu, 11 May 2023 15:37:45 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Hao Ge (2023-05-10 18:26:54)
> On Wed, 10 May 2023 14:18:08 -0700
> Stephen Boyd <sboyd@kernel.org> wrote:
>=20
> > Quoting Hao Ge (2023-05-08 19:12:14)
> > > Use devm_platform_ioremap_resource to take the place of of_iomap for
> > > avoid that we don't called iounmap when return some error or remove
> > > device.
> > >=20
> > > Fixes: 4c02c9af3cb9 ("clk: mediatek: mt8173: Break down clock
> > > drivers and allow module build") Signed-off-by: Hao Ge
> > > <gehao@kylinos.cn> --- =20
> >=20
> > Is this v3?
> Hi Stephen
>=20
> yes,Perhaps you are too busy,I have not received a response
> in the future, so you are unsure about the status of V2.
> So I adjusted the code and title make changes smaller and
> sent V3 for it.It is precisely because of these that I did=20
> not continue the original mail thread.
>=20

I'm waiting for the usual mediatek clk driver folks to review the patch.
