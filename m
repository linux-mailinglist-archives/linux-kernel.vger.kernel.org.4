Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03DE464EEA8
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 17:10:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232604AbiLPQKj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 11:10:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231288AbiLPQJs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 11:09:48 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F175A8FF9;
        Fri, 16 Dec 2022 08:09:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8BF8F62163;
        Fri, 16 Dec 2022 16:09:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1AF5C433EF;
        Fri, 16 Dec 2022 16:09:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671206972;
        bh=Pd4cwhB/ZU6dBLtjwdLjnwes8/oi7QJg2yi0YsWb/s8=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=NtRD3VndI817OODNmbTpU841LM8EChnIpjTQ5bWsg1ipK9e6AjcPz2Iz5KNzoORgC
         if68KOtpvOquSNF8C/SwqZYQAWIH6g62XGFy+douxnxiTH28vAvIj+x/rXQp/n2y8f
         djEd4KOlkTbCGqzw6v50SaqoIx7pdkStQRIMpt0QH5++CFe8zSgQpoXXGctsStJomM
         6pePh3cpi2p2nAP8wYWhj+zzOHHD/1/o6h0zk7qTpFmkluFhpWPldlMKm1DBfvV2U3
         cYMV8/mNlEaUvGH9Q9dWrBGz7tdsxcYO1dssn0ksciG9rYWcG9mIa7E3grAD/lAg1M
         aoIyRmXyBeqPQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20221215203751.2.Ic128c1df50b7fc9a6b919932a3b41a799b5ed5e8@changeid>
References: <1671117062-26276-1-git-send-email-quic_akhilpo@quicinc.com> <20221215203751.2.Ic128c1df50b7fc9a6b919932a3b41a799b5ed5e8@changeid>
Subject: Re: [PATCH 2/5] clk: qcom: gdsc: Support 'synced_poweroff' genpd flag
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Akhil P Oommen <quic_akhilpo@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
To:     Akhil P Oommen <quic_akhilpo@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Clark <robdclark@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        dri-devel@lists.freedesktop.org,
        freedreno <freedreno@lists.freedesktop.org>,
        linux-arm-msm@vger.kernel.org
Date:   Fri, 16 Dec 2022 08:09:29 -0800
User-Agent: alot/0.10
Message-Id: <20221216160931.E1AF5C433EF@smtp.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Akhil P Oommen (2022-12-15 07:10:58)
> Add support for the newly added 'synced_poweroff' genpd flag. This allows
> some clients (like adreno gpu driver) to request gdsc driver to ensure
> a votable gdsc (like gpucc cx gdsc) has collapsed at hardware.
>=20
> Signed-off-by: Akhil P Oommen <quic_akhilpo@quicinc.com>
> ---
>=20
>  drivers/clk/qcom/gdsc.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/clk/qcom/gdsc.c b/drivers/clk/qcom/gdsc.c
> index 9e4d6ce891aa..575019ba4768 100644
> --- a/drivers/clk/qcom/gdsc.c
> +++ b/drivers/clk/qcom/gdsc.c
> @@ -136,7 +136,8 @@ static int gdsc_update_collapse_bit(struct gdsc *sc, =
bool val)
>         return 0;
>  }
> =20
> -static int gdsc_toggle_logic(struct gdsc *sc, enum gdsc_status status)
> +static int gdsc_toggle_logic(struct gdsc *sc, enum gdsc_status status,
> +               bool force_sync)

Maybe just 'wait'? That matches kernel style and is short.
