Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26DEF67F05F
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 22:25:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231461AbjA0VYr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 16:24:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231902AbjA0VYh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 16:24:37 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A744F5254;
        Fri, 27 Jan 2023 13:24:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 586ADB821E7;
        Fri, 27 Jan 2023 21:24:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E296BC433D2;
        Fri, 27 Jan 2023 21:24:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674854674;
        bh=X77o2EN7hu23p9QesyJvTlz4zrfiHmazTL3NOd2r6wc=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=XYDjhkCvEFwo2gbUTAUv8mpgCTLgHgubvIVMl3pIylJTF22WS4Bw4wU/Qa3Unrno1
         kp/Qj8On1hPhQw2TaXJThKLilmLJXzJXHmx93JmmowCfh1OuJ0tit/vi9sogWv3iT8
         OBELeFFu7BB5yYsfhrMwKRX12wCVajOmjlhM7cV3OkQ8HVVcn4iRjd7B8/WodfxUG3
         2o7JTCqicknaCsFfV7+/pHmq7OXhCC8qnVUVCWQAhlrJYVCnr+aalpSpLvBSWtuH10
         RnkdVlOZFc60UVt+aFG5zeLtXJzYx5/ySWmf7VBhg4coSfCuHMyulAZBX+9IFVB7QL
         tsBZD3Udy97Eg==
Message-ID: <73c3a79bb8b429d8f2ef23c5d2666a8a.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <7d0582ac-e5c1-7dbf-8063-f6ea8cb59862@linaro.org>
References: <20230118132254.2356209-1-dmitry.baryshkov@linaro.org> <20230118132254.2356209-8-dmitry.baryshkov@linaro.org> <7055af43f4a8894ac34e53c5847fb3de.sboyd@kernel.org> <7d0582ac-e5c1-7dbf-8063-f6ea8cb59862@linaro.org>
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
Date:   Fri, 27 Jan 2023 13:24:31 -0800
User-Agent: alot/0.10
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Dmitry Baryshkov (2023-01-26 14:51:51)
> On 25/01/2023 23:38, Stephen Boyd wrote:
> > Quoting Dmitry Baryshkov (2023-01-18 05:22:54)
> >> diff --git a/drivers/clk/qcom/apcs-msm8996.c b/drivers/clk/qcom/apcs-m=
sm8996.c
> >> new file mode 100644
> >> index 000000000000..7e46ea8ed444
> >> --- /dev/null
> >> +++ b/drivers/clk/qcom/apcs-msm8996.c
> >> @@ -0,0 +1,76 @@
> >> +
> >> +       /*
> >> +        * Register the clock as fixed rate instead of being a child o=
f gpll0
> >> +        * to let the driver register probe as early as possible.
> >=20
> > The function doesn't block or return EPROBE_DEFER if the clk is orphaned
> > when registered. Why is this necessary? Are you getting defered by the
> > fw_devlink logic thinking it needs to defer probe of this driver until
> > gpll0 provider probes? We should fix fw_devlink to not do that. Maybe if
> > the node is a clk provider (#clock-cells exists) then we don't wait for
> > clocks property to be provided, because the clk core already handles
> > that itself.
>=20
> Letting clock-controllers probe was my idea for the patch, but it was=20
> delayed again by Saravana, see [1], [2]

Ah, I didn't see it because linux-clk wasn't Cced and I look at that
mail pile less regularly.
