Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D34D733ACF
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 22:28:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbjFPU2B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 16:28:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233194AbjFPU1z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 16:27:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C52F53AA8;
        Fri, 16 Jun 2023 13:27:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F1FCF6111F;
        Fri, 16 Jun 2023 20:27:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5511DC433C8;
        Fri, 16 Jun 2023 20:27:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686947266;
        bh=Csz7AYw+SYFqJ0XXgKmMeE5PEklNTVPGlubIPxkjLaw=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=sVoqsOr9cUAjopFEUQzIzHhtJf2t3y7CjDYMD7EVysk1K1iJagDr2jbzP+8aQLc4A
         vZXX5HqTj85mG7MkGBSzIpSXUar/Mtm7Y8q2Yca8UDGlekSXZtjvibxRo8RSgAovD8
         kgLtqS6kU0/64qxaXrGoaVelj8ZeH3W6ZOYrnXDqtYybfAPcOK3RHZ7H+6GsZDSAjO
         jKCM8AxnTT3zAsw7rB//9VQARkYkpLqnwpBIxVpVFdLKURUr6nCEt+2xCDzPjqUyGV
         7XBdtDxWDJJuk22fx8WwDvptKo9evm0wCAtsR0btB9zTF2Q94N/W01g9X8hk0juO4a
         jIRB4ch3rx48g==
Message-ID: <70c39db97475939719720ab1902aa1c1.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <825f06c1-cf87-c0e3-a9fc-f4ec0edaa0f8@linaro.org>
References: <20230526-topic-smd_icc-v6-0-263283111e66@linaro.org> <20230526-topic-smd_icc-v6-18-263283111e66@linaro.org> <e2afd4bde3e85db358d50553a60a744f.sboyd@kernel.org> <825f06c1-cf87-c0e3-a9fc-f4ec0edaa0f8@linaro.org>
Subject: Re: [PATCH v6 18/22] clk: qcom: smd-rpm: Separate out interconnect bus clocks
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org
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
Date:   Fri, 16 Jun 2023 13:27:42 -0700
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

Quoting Konrad Dybcio (2023-06-15 00:49:59)
> On 15.06.2023 02:48, Stephen Boyd wrote:
> > Quoting Konrad Dybcio (2023-06-14 11:04:37)
> >> @@ -1332,6 +1275,15 @@ static int rpm_smd_clk_probe(struct platform_de=
vice *pdev)
> >>                         goto err;
> >>         }
> >> =20
> >> +       for (i =3D 0; i < desc->num_icc_clks; i++) {
> >> +               if (!desc->icc_clks[i])
> >> +                       continue;
> >> +
> >> +               ret =3D clk_smd_rpm_handoff(desc->icc_clks[i]);
> >=20
> > This API can probably take a const struct clk_smd_rpm pointer as well.
> It would be great, but ideally we want to set r->enabled in that func
> for !bus clocks (for unused clk cleanup). I could probably introduce a
> separate function for the icc clocks that takes const.
>=20

Sure. Or have this take const and in the clk driver set r->enabled after
calling it. That's future code though, so just make it take const?
