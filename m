Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 282907433D4
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 06:59:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231235AbjF3E7T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 00:59:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjF3E7Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 00:59:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B27A02690;
        Thu, 29 Jun 2023 21:59:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4E05461666;
        Fri, 30 Jun 2023 04:59:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EDE8C433C8;
        Fri, 30 Jun 2023 04:59:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688101154;
        bh=IRu+s9y5tQnnGs3BI/S3nX9u7ytGDqeWVgNkOE0A/R4=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=Kt+0guXFY/Z1tubjCZDWZPs3l46Q9HLo/o0UQUuEGTnHtjsuX1mg8CGRa8S9XoMiK
         qYUW8mZ+HycMLFMKnNilSxleZmCLdsxB04WnOsiKniretDJmkZWlUbux48FNmdob4u
         mgQPFilHmg6uywxrUWC7mbZ7Wl3maPm3+XNkLmEs90mms1P0oNDyZjInd0za2vHkVq
         mgralHU7nWABOvJTb7xig9DNzJxvGopaYEnNEyvbjxDFsYzCWKZ8Vn7LWX1pWAj5+T
         HKS0YAOpqHp9FeQoiiuQdI6c1qTe5Lu/9rlAQoTMXo19xO3HLUZu156GMGvvG2+0GD
         Xb8rW1BrtuBKQ==
Message-ID: <270d732ee61a47d3e731646bd9a6e8c2.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230526-topic-smd_icc-v7-18-09c78c175546@linaro.org>
References: <20230526-topic-smd_icc-v7-0-09c78c175546@linaro.org> <20230526-topic-smd_icc-v7-18-09c78c175546@linaro.org>
Subject: Re: [PATCH v7 18/22] clk: qcom: smd-rpm: Separate out interconnect bus clocks
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
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
Date:   Thu, 29 Jun 2023 21:59:12 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Konrad Dybcio (2023-06-19 06:04:43)
> The interconnect bus clocks are now handled within the ICC framework.
> They still however need to get a kickstart *before* we call
> clk_smd_rpm_enable_scaling(), or RPM will assume that they should all
> be running at 0 kHz and the system will inevitably die.
>=20
> Separate them out to ensure such a kickstart can still take place.
>=20
> As a happy accident, the file got smaller:
>=20
> Total: Before=3D41951, After=3D41555, chg -0.94%
>=20
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---

Acked-by: Stephen Boyd <sboyd@kernel.org>
