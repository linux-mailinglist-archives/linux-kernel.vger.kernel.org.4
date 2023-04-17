Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CCAB6E555B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 01:40:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbjDQXkW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 19:40:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbjDQXkU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 19:40:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6041A103;
        Mon, 17 Apr 2023 16:40:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EEEAB6219B;
        Mon, 17 Apr 2023 23:40:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5137EC433EF;
        Mon, 17 Apr 2023 23:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681774818;
        bh=YRSpDLLO0Uo9m9k8X5YteEHYv2PhYNHD3aH2/tE6Q0A=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=iPbUwxzhJBABBG63TNk2/oKaT4lyKwtJjqc7gPJ81bu1sjJcnnLf0CxN0VEDvAl2v
         IvSGEWFWP2EcKeH0MufISW8W5NYKkry/QKq7qgLzYidQRNr1jVm8HhVMalZOhCeUau
         lRc6s0TVmcv36Khalz9gpR8jaaPzQ9Njtex6OLMdZWPs9xgTT8NclG5HbiVXG3cFwh
         WRjTb7X/1m8+zLHtJigKQyu+REJ/CZ0o+jhUFkDrQZ+6j3pBrBrZReL7EJrQCiDdFl
         GkBESzzxhgpdCKqUrkJY5YewMMpkjG498jwuS6UuPrMgVd4jrszZEepNQswxEo1uKs
         EWvcVt/Fa1Nrw==
Message-ID: <3251d8e89d5f047784149419c5bff7c0.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <ce6c952b-2e2b-67d9-5023-e740ed798758@quicinc.com>
References: <20230303092859.22094-1-quic_tdas@quicinc.com> <20230303092859.22094-2-quic_tdas@quicinc.com> <CAA8EJpq5xBF=Wt-1_hGR-7qZHREcALurmR4ucmMmZaC-R_7Ttg@mail.gmail.com> <ce6c952b-2e2b-67d9-5023-e740ed798758@quicinc.com>
Subject: Re: [PATCH 1/2] clk: qcom: common: Handle invalid index error
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Taniya Das <quic_tdas@quicinc.com>
Date:   Mon, 17 Apr 2023 16:40:16 -0700
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

Quoting Taniya Das (2023-04-16 21:40:48)
> Hi Dmitry,
>=20
> Thanks for the comments.
>=20
>=20
> On 3/3/2023 4:14 PM, Dmitry Baryshkov wrote:
> > On Fri, 3 Mar 2023 at 11:30, Taniya Das <quic_tdas@quicinc.com> wrote:
> >>
> >> Introduce start_index to handle invalid index error
> >> seen when there are two clock descriptors assigned
> >> to the same clock controller.
> >=20
> > Please provide details of the exact case that you are trying to solve
> > (this might go to the cover letter). I think the commit message is
> > slightly misleading here. Are you trying to add error messages or to
> > prevent them from showing up?
> >=20
>=20
> We are trying to avoid error messages from showing up.
>=20
> > I'm asking because error messages do not seem to correspond to patch
> > 2. You add start_index to make the kernel warn for the clock indices
> > less than LPASS_AUDIO_CC_CDIV_RX_MCLK_DIV_CLK_SRC =3D 4, while quoted
> > messages show indices 5,6,7.
> >=20
>=20
> Right, we want the kernel to warn if the clock index is less than=20
> start_index, along with that we also want to handle the case where=20
> num_rclks is uninitialized because of same clock descriptor being=20
> assigned to two clock controllers.

The start_index should be 0.
