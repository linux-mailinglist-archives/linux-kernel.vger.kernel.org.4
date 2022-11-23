Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8B05634DDC
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 03:28:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235195AbiKWC2V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 21:28:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234023AbiKWC2M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 21:28:12 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE2192D1E1;
        Tue, 22 Nov 2022 18:27:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 73E4661A02;
        Wed, 23 Nov 2022 02:27:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B82CDC433B5;
        Wed, 23 Nov 2022 02:27:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669170465;
        bh=j70E8biRidyKpLWNs2x+HXH8VmJwsFnhf56UTmYl1vs=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=IEmCDi4Et0Ynn5CD3ufKKdYIiFcttpG4ACNm+45fulJTTXqrpaxRk+Jfbx2bvPrpM
         1eZQ6pDT5SQjmjpaB0OShwdxykbvbm8PyBuks7ap0LYRRjn0HJ9zo//3P5wdsxTpt6
         OQyJTDDDkEbq4ieuyPau1acMrKbNxdpfAjlghBMoJOZy2ZjAjfCj39XhzHAdFJi9ee
         DW3wEdR6hnLdV4m5cQZncCscMTvVjOM2Zlo9hb5qXBoTpNn6Dt488g4jDP49V1XPzS
         MXtCiXGZIqLsfbl7OGn8KRtmm8UmYKT4NmwU/gFc0x01ONVSGEbdCx9Lnb0VNLBbSr
         J/FpHYvlUotiQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20221115152956.21677-1-quic_shazhuss@quicinc.com>
References: <20221115152956.21677-1-quic_shazhuss@quicinc.com>
Subject: Re: [PATCH v3] clk: qcom: gcc-sc8280xp: add cxo as parent for three ufs ref clks
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     bmasney@redhat.com, agross@kernel.org, mturquette@baylibre.com,
        ahalaney@redhat.com, Shazad Hussain <quic_shazhuss@quicinc.com>,
        Johan Hovold <johan+linaro@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
To:     Shazad Hussain <quic_shazhuss@quicinc.com>, andersson@kernel.org,
        johan@kernel.org
Date:   Tue, 22 Nov 2022 18:27:42 -0800
User-Agent: alot/0.10
Message-Id: <20221123022745.B82CDC433B5@smtp.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Shazad Hussain (2022-11-15 07:29:56)
> The three UFS reference clocks, gcc_ufs_ref_clkref_clk for external
> UFS devices, gcc_ufs_card_clkref_clk and gcc_ufs_1_card_clkref_clk for
> two PHYs are all sourced from CXO.
>=20
> Added parent_data for all three reference clocks described above to
> reflect that all three clocks are sourced from CXO to have valid
> frequency for the ref clock needed by UFS controller driver.
>=20
> Fixes: d65d005f9a6c ("clk: qcom: add sc8280xp GCC driver")
> Link: https://lore.kernel.org/lkml/Y2Tber39cHuOSR%2FW@hovoldconsulting.co=
m/
> Signed-off-by: Shazad Hussain <quic_shazhuss@quicinc.com>
> Tested-by: Johan Hovold <johan+linaro@kernel.org>
> Reviewed-by: Johan Hovold <johan+linaro@kernel.org>
> Tested-by: Andrew Halaney <ahalaney@redhat.com>
> Reviewed-by: Andrew Halaney <ahalaney@redhat.com>
> Reviewed-by: Reviewed-by: Brian Masney <bmasney@redhat.com>
> ---

Fixed the double Rb

Applied to clk-fixes
