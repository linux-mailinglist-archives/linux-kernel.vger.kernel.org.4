Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D12F96CC979
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 19:42:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbjC1RmF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 13:42:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbjC1RmD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 13:42:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D67F4E06B;
        Tue, 28 Mar 2023 10:42:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6C0776181B;
        Tue, 28 Mar 2023 17:42:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1BFDC433EF;
        Tue, 28 Mar 2023 17:42:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680025321;
        bh=2SMsf25Os8n/Nh4s1s1UZQy+WrqVW8lL7AF37NLGxhE=;
        h=In-Reply-To:References:Subject:From:To:Date:From;
        b=cZIk5LMM/eQRh5i9MUcZzAdXLzyqXmMMnSXdA1QzSryyEEhco5byULYBGCPq7h+c6
         9Wh2FIUizPRVV9RfkIs6YelU4xYJlYjQSqyOKIVKxE15K6pakoOh8msL5zVC0zQImk
         sGBi4GXpIcK7zkmG3ZwZ1+xCN4m4PURdChHj1AbOnKh1hJ1iuKk6c0z0fJ16p2jy09
         ImHzGJ1tjz2RpJYb8LYLDr3USGDTgEswDxXbDoENWzS74n4RzfWGJt96QeSHNlEVfa
         nSfUYlp/4oc9htfgTAdKO/+ZzmflTnsZYVcIKVuCIqnK4e6Kn0BYm04HuyGkPHwogJ
         mBGHNemAn0ErA==
Message-ID: <5c89937f7b208e872af58636933194a0.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <fb9712fc-d103-769c-2ed7-51a08bbe76b2@quicinc.com>
References: <20230327163249.1081824-1-quic_mohs@quicinc.com> <b347395dd736194ae9392f2f6ea450b0.sboyd@kernel.org> <fb9712fc-d103-769c-2ed7-51a08bbe76b2@quicinc.com>
Subject: Re: [PATCH v1 0/4] Remove the qdsp6ss register from lpasscc
From:   Stephen Boyd <sboyd@kernel.org>
To:     Mohammad Rafi Shaik <quic_mohs@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, broonie@kernel.org,
        konrad.dybcio@somainline.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, mturquette@baylibre.com,
        quic_plai@quicinc.com, quic_rohkumar@quicinc.com,
        quic_visr@quicinc.com, robh+dt@kernel.org, swboyd@chromium.org
Date:   Tue, 28 Mar 2023 10:41:59 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Mohammad Rafi Shaik (2023-03-27 23:02:38)
>=20
> On 3/27/2023 11:11 PM, Stephen Boyd wrote:
> > Quoting Mohammad Rafi Shaik (2023-03-27 09:32:45)
> >> This patch set is to remove the qdsp6ss register from lpasscc to
> >> resolve memory conflict's between lpascc and ADSP remoteproc driver.
> > Is this related to the other patch series[1] ("[PATCH v9 0/4] Add resets
> > for ADSP based audio clock controller driver")? Does it supersede those?
> Thanks for comment,
>=20
> yes, its superseded form patch series[1] ("[PATCH v9 0/4] Add resets
> for ADSP based audio clock controller driver") which is required many
> changes.
>=20
> As the qdsp6ss clocks are being enabled in remoteproc driver,
> the qdsp6ss not required in lpasscc node.
>=20
> For audioreach solution required to create the remoteproc_adsp
> device tree node with base address 0x3000000 for remoteproc driver,
> as already this address being used in lpasscc node it's causing memory
> conflict.

Ok. Please add the details of superseded patch series to the cover
letter. It helps us understand what to do with the other patches on the
list.
