Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D29B167C091
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 00:05:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235950AbjAYXFG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 18:05:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbjAYXFE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 18:05:04 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A621A10412;
        Wed, 25 Jan 2023 15:05:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3042861647;
        Wed, 25 Jan 2023 23:05:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79C0CC433EF;
        Wed, 25 Jan 2023 23:05:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674687902;
        bh=QWzWtdHUy/769l77DiAcYt1zff7lP4hM9m1EdTQD9Oc=;
        h=In-Reply-To:References:Subject:From:To:Date:From;
        b=IO+QfJvv1fQs5p926ogMgxMHPeUXSWuPPCjueJ8YVJkisKlk9peNWxqUYW1vT2yLq
         90k9nkyOpbh0PHIxoxwT4BaYPkYqsFwFOKqE3eFMIwfOR3nf1ydeXakm/acyqt6fsr
         f6412waqN0rnJYTFif4UpLpDI9LblKdJTwLV6s53wlDqNfy9Fcmb89Kx1S8qzzHuMo
         UVPzN/HR4zBvBGdh6RC56PD2EWFcj/8DpFzaSvHjni+zjfg0mIyM+MZs0Q5r7sZNhA
         8nfGFfHeB4fIF+ylE4+M3nTK9MHj0nkJq0qOEhDXwUrvStAxexeW3kr4cwR1UpyLKd
         yrPpYNavcqLhA==
Message-ID: <17615d7cf32feb4cda1c9948e184e69e.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <0c06bfb5-c0b7-c3eb-4c99-8e77280a942c@linaro.org>
References: <1674322340-25882-1-git-send-email-quic_srivasam@quicinc.com> <030115dd-f489-5d4e-c993-e9fa8b550f04@linaro.org> <43bea488-7a71-aec3-508c-6a541d5db508@quicinc.com> <0c06bfb5-c0b7-c3eb-4c99-8e77280a942c@linaro.org>
Subject: Re: [RESEND v5 0/6] Add resets for ADSP based audio clock controller driver
From:   Stephen Boyd <sboyd@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
        agross@kernel.org, andersson@kernel.org, broonie@kernel.org,
        konrad.dybcio@somainline.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, mturquette@baylibre.com,
        quic_plai@quicinc.com, quic_rohkumar@quicinc.com,
        robh+dt@kernel.org, swboyd@chromium.org
Date:   Wed, 25 Jan 2023 15:05:00 -0800
User-Agent: alot/0.10
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Krzysztof Kozlowski (2023-01-23 00:01:02)
> On 23/01/2023 06:13, Srinivasa Rao Mandadapu wrote:
> >=20
> > On 1/22/2023 7:21 PM, Krzysztof Kozlowski wrote:
> > Thanks for Your time Krzysztof!!!
> >> On 21/01/2023 18:32, Srinivasa Rao Mandadapu wrote:
> >>> Add resets and remove qdsp6ss clcok controller for audioreach based p=
latforms.
> >>>
> >>> Changes since v4:
> >>>      -- Update Fixes tag in Merge lpasscc into lpass_aon patch.
> >>>      -- Revert removal of clk_regmap structure in Merge lpasscc into =
lpass_aon patch.
> >>>
> >> Your v5 before resend have build issues. Please fix.
> >=20
> > In v5, one commit missed to amend local changes.Hence resent it.
> >=20
> > on Resent patch series no build issues.
>=20
> Resend means you send the same patches. If you change patches, it's not
> resend but new version.
>=20

I'm waiting for a new version now.
