Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DC09730C32
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 02:28:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233912AbjFOA2P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 20:28:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjFOA2N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 20:28:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 395F3268A;
        Wed, 14 Jun 2023 17:28:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C512463A6C;
        Thu, 15 Jun 2023 00:28:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29DDDC433C8;
        Thu, 15 Jun 2023 00:28:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686788891;
        bh=XaltGBrfhglFbHY3ssTTjmpnwDD40AZoGcQsyArt+K0=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=PJqStyRIv9SMNSfgk1rsrgtw6kU92JWbqqwwV4OPd+PIUgkzH9hsoTHjEX0cjvjS6
         G+nH222bmJChSzvXTdsbNeGzn3iwk/FGMW3W8AerGXXaJ6bHFgQhLVC0BzepKEYb0q
         E9LDO9mD9Ok47vmkoZV2COvyVahocmXo1akA3PSGh1ZR0MekB2h/fzuxGAJtaDhrMM
         LeuzRLNDdb1D6tjziJm1WvDKosfL2vQ6fA8RQf3duZgk2yRnw5LxtrhzKjYXxJSjGy
         q7YSa1qC+kSEDS623HCp4iP+xukbu2iVfIvTNl2LGeyiRCQxgM+Gdm3fTI57QwsBL5
         ivUzAHyJWn6gA==
Message-ID: <d251be3e02b2fe28357c884e39fe7601.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <64749bf4.5d0a0220.325c0.64b5@mx.google.com>
References: <20230427150717.20860-1-ansuelsmth@gmail.com> <20230427150717.20860-3-ansuelsmth@gmail.com> <82072c2b-8483-6fb6-a9d1-c9882825c9cb@linaro.org> <6473e34c.df0a0220.33a79.6c95@mx.google.com> <4afbcdd0-a11c-4826-d669-2ffc9488a8b6@linaro.org> <64749bf4.5d0a0220.325c0.64b5@mx.google.com>
Subject: Re: [PATCH v4 2/3] clk: qcom: clk-rcg2: add support for rcg2 freq multi ops
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
To:     Christian Marangi <ansuelsmth@gmail.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Wed, 14 Jun 2023 17:28:08 -0700
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

Quoting Christian Marangi (2023-05-29 05:34:57)
> On Mon, May 29, 2023 at 02:12:23PM +0200, Konrad Dybcio wrote:
> > On 28.05.2023 14:37, Christian Marangi wrote:
> > > On Sat, May 27, 2023 at 06:11:16PM +0200, Konrad Dybcio wrote:
> > >> On 27.04.2023 17:07, Christian Marangi wrote:
> > >>> +  * Force the first conf if we can't find a correct config.
> > >>> +  */
> > >>> + if (unlikely(i =3D=3D f->num_confs))
> > >>> +         best_conf =3D f->confs;
> > >> Is that a supported scenario or would it be a device driver / clock
> > >> driver error?
> > >>
> > >=20
> > > It's to handle case for the 2 continue in the loop and arriving in a
> > > situation where best_conf was never set?
> > >=20
> > > Should we return a warning and an ERR_PTR? Idea was to provide a best
> > > effort selection.
> > Hm.. I'm not sure what's the expected behavior here.. Stephen?
> >=20
>=20
> I have this implementation rady, if you want I can send this revision
> and discuss that in v5 directly. It's WARN and returning -EINVAL.

I'd only have a WARN if you never expect to hit that case. Otherwise, it
should return -EINVAL and not warn. At a quick glance it sounds like
some sort of rounding policy, so just make sure the
round_rate/determine_rate implementation agrees with what set_rate()
will do and it should be good.
