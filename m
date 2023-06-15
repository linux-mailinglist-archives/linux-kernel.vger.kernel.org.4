Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E009731F37
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 19:35:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229525AbjFORfW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 13:35:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230392AbjFORfR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 13:35:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57F1E1FDD;
        Thu, 15 Jun 2023 10:35:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E037E63974;
        Thu, 15 Jun 2023 17:35:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F052C433C8;
        Thu, 15 Jun 2023 17:35:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686850515;
        bh=MRH2gBGbTm6Nfz0Le3aIme9e/tvq/PhgScHQ4D5E9Z0=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=Lz+GZOxNuTy/88ASn7yaHQLEjS8IJ8PcCqlKzfQV4y67dWEiq2AbdK2aeuVYURTj7
         xQmwR0hGKKuTAtjCcbmSQ5C3yjS7Qw8uV7cA1meILJ45yl8TnB4PYghKuuf24p5FNM
         ex7DTia6S85aEtAOWFqixnYSdG6YuoEySjWN4q1NzGACwP5s2ssAL/AnJF8R+23Clm
         rpdgJWhq7sqrynlaFkIQCh31olY2CYTAvNnFE7IFlSCw3XVonbTnKfNfRyjsv22thD
         Yu2AQDJffYWyRkT6nUbZokdMFG/gN5LYgVTnmOB3DYj+ZDi/dsbgVp6WpNaEmqYdTO
         5SKSVaGapc0lA==
Message-ID: <f526046568e6bbc8dc567109e6911f65.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <8568eead-90f6-ce15-d483-4d72dbab6294@linaro.org>
References: <20230526-topic-smd_icc-v6-0-263283111e66@linaro.org> <0764b5fda92acb995ffbd05c4b3d2b2f.sboyd@kernel.org> <8568eead-90f6-ce15-d483-4d72dbab6294@linaro.org>
Subject: Re: [PATCH v6 00/22] Restructure RPM SMD ICC
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Georgi Djakov <djakov@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>
Date:   Thu, 15 Jun 2023 10:35:12 -0700
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

Quoting Konrad Dybcio (2023-06-15 00:52:07)
> On 15.06.2023 02:49, Stephen Boyd wrote:
> > Quoting Konrad Dybcio (2023-06-14 11:04:19)
> >> This series reshuffles things around, moving the management of SMD RPM
> >> bus clocks to the interconnect framework where they belong. This helps
> >> us solve a couple of issues:
> >>
> >> 1. We can work towards unused clk cleanup of RPMCC without worrying
> >>    about it killing some NoC bus, resulting in the SoC dying.
> >>    Deasserting actually unused RPM clocks (among other things) will
> >>    let us achieve "true SoC-wide power collapse states", also known as
> >>    VDD_LOW and VDD_MIN.
> >>
> >> 2. We no longer have to keep tons of quirky bus clock ifs in the icc
> >>    driver. You either have a RPM clock and call "rpm set rate" or you
> >>    have a single non-RPM clock (like AHB_CLK_SRC) or you don't have an=
y.
> >>
> >> 3. There's less overhead - instead of going through layers and layers =
of
> >>    the CCF, ratesetting comes down to calling max() and sending a sing=
le
> >>    RPM message. ICC is very very dynamic so that's a big plus.
> >>
> >> The clocks still need to be vaguely described in the clk-smd-rpm drive=
r,
> >> as it gives them an initial kickoff, before actually telling RPM to
> >> enable DVFS scaling.  After RPM receives that command, all clocks that
> >> have not been assigned a rate are considered unused and are shut down
> >> in hardware, leading to the same issue as described in point 1.
> >=20
> > Why can't we move the enable of DVFS scaling call to the interconnect
> > driver as well? We want the clk driver to not reference the interconnect
> > resources at all.
> That would result in no rpmcc ratesetting on platforms without a function=
al
> interconnect driver. The DVFS call concerns both bus and !bus clocks.
>=20

That's the intent. Probe the interconnect driver to get bus clk rate
setting.

What are the !bus clocks managed by RPM?
