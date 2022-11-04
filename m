Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 410CD61A0BD
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 20:19:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbiKDTTY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 15:19:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbiKDTTW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 15:19:22 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD0FE1EAEC;
        Fri,  4 Nov 2022 12:19:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 465B8B82C15;
        Fri,  4 Nov 2022 19:19:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5A5BC433C1;
        Fri,  4 Nov 2022 19:19:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667589559;
        bh=0RirpirjsLnaVPx1PgTePlEUSgmd94GAbbiGvTlUvaA=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=THsipqpFeDHQzK5Wjt0lROYi2TKljfvb3U5POh+Arg4GREwG3NKh+6kcpkbj81GuS
         TM5FVc5RUqBjU8ZhFNCceMs/n/Tt5XiDeOlCvRK4dqounnFZ/otTfRuLdIY0oJBMPJ
         VJJHJpSni/3lcdj2hPn7di6aN/+JfoT81cZtLK3LVSkBrbJNEfBL/D/Pr57Y9+iUV7
         7jXKrit0hfndiSZ330VkMIHlAKEirLgzVBpJWPrpqe9OJQIjJoRqeY3WaFXFJw8nUW
         mQZI/VVWix2tpzwCjFk6Me5NpMg4slyzkCoE8lwGMBgZk3n4HtbT2PvEPQev50mF8y
         2idMn/RQUSeWA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20221103183030.3594899-1-swboyd@chromium.org>
References: <20221103183030.3594899-1-swboyd@chromium.org>
Subject: Re: [PATCH v3] clk: qcom: gdsc: Remove direct runtime PM calls
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        patches@lists.linux.dev, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        linux-arm-msm@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Taniya Das <quic_tdas@quicinc.com>,
        Satya Priya <quic_c_skakit@quicinc.com>,
        Douglas Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Date:   Fri, 04 Nov 2022 12:19:16 -0700
User-Agent: alot/0.10
Message-Id: <20221104191918.D5A5BC433C1@smtp.kernel.org>
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Stephen Boyd (2022-11-03 11:30:30)
> We shouldn't be calling runtime PM APIs from within the genpd
> enable/disable path for a couple reasons.
>=20
> First, this causes an AA lockdep splat[1] because genpd can call into
> genpd code again while holding the genpd lock.
>=20
> WARNING: possible recursive locking detected
> 5.19.0-rc2-lockdep+ #7 Not tainted

Applied to clk-fixes
