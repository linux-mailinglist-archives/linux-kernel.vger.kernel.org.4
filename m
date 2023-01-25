Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 580E767C0AE
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 00:15:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234182AbjAYXPs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 18:15:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjAYXPq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 18:15:46 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 105D93B67A;
        Wed, 25 Jan 2023 15:15:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 5E0E6CE2248;
        Wed, 25 Jan 2023 23:15:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87AE6C433D2;
        Wed, 25 Jan 2023 23:15:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674688542;
        bh=HM9cYqq/Wx50VCJDYc4v22id5b4Gv1NOMWPHBYRQCmE=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=UHxc0S8L6FPfYYs7vVH3oUNGJpFy3Ml1RD1hT9LOHgy8VKZoj1d1iHEtVD4hTH4/x
         VCDgNgBIX6aVdJXCq/zbVi5Fa6tEWfuXI/aGE2ErOSdjPsxrtNFmDHH6EKsacYfNRk
         1w6sA6QBchdRNyPoamEQYxlq4o4E0fuTiaiJsnWSU+zznNewpkPN3IudK3r4qM6Vom
         WY0Elb+AQGSE6BPL98xG3ZhqknW3TWiGZuOFqqE5DsRctcHh7MkAyv/weO/5a8zZ95
         kZEqRzCHCjV08QCnsV+cSSTlchtD/7IKvXTP2sMOfBYTHdnEFqeYlRFYdI91NuQ0eI
         dyNaRaNtRIXAg==
Message-ID: <6db0c9da3a05ee8adaf7262ebce16d3d.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <df133e5a-8030-0774-091c-6f8e0692e945@linaro.org>
References: <20230118132254.2356209-1-dmitry.baryshkov@linaro.org> <20230118132254.2356209-8-dmitry.baryshkov@linaro.org> <7055af43f4a8894ac34e53c5847fb3de.sboyd@kernel.org> <63f017c7-d320-a996-7bda-33d263a847bc@linaro.org> <525ef5cdefe987c3412249760324eb09.sboyd@kernel.org> <df133e5a-8030-0774-091c-6f8e0692e945@linaro.org>
Subject: Re: [PATCH v4 7/7] clk: qcom: add the driver for the MSM8996 APCS clocks
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Taniya Das <quic_tdas@quicinc.com>
Date:   Wed, 25 Jan 2023 15:15:40 -0800
User-Agent: alot/0.10
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Konrad Dybcio (2023-01-25 14:05:27)
>=20
> On 25.01.2023 22:56, Stephen Boyd wrote:
> >=20
> > So it is waiting for the CPU clk to be stable? The comment is not clear.
> Okay, so perhaps this is just a misunderstanding because of a lackluster
> comment.. This SYS_APCS_AUX (provided by this driver) is one of the CPU
> clock sources (and probably the "safest" of them all, as it's fed by
> GPLL0 and not the CPU PLLs) the delay is there to ensure it can
> stabilize after setting the divider to DIV2. In a theoretical case, the
> big 8996 cpucc driver could select this clock as a target for one (or
> both) of the per-cluster muxes and it could put the CPUs in a weird state.
>=20
> As unlikely as that would be, especially considering 8996 (AFAIK) doesn't
> use this clock source coming out of reset / bootloader, this lets us
> ensure one less thing can break.

Great! I look forward to a better comment.
