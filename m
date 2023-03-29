Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F4C36CF3C3
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 21:52:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbjC2Twz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 15:52:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbjC2Tww (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 15:52:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48C311711;
        Wed, 29 Mar 2023 12:52:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3469D61E06;
        Wed, 29 Mar 2023 19:52:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8769FC433EF;
        Wed, 29 Mar 2023 19:52:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680119545;
        bh=xcF9CuGA0ZvQlSz1cJNgsAOmxVDDBm9VrRmsouXIeZ4=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=mU+ah1ptkQ7L6P00ZxppANt2wrNejIXxnFHkVPslXsz3XjzIFNFu7LUZvL9SxHTFm
         a8xFcg5sGhMILcdyJsS7EBkfUD98uETjNeb4ZeweXPnid2N0Fs4YdMpOCyNwftTDmS
         CZnPkLP0SA+XvAvq3r7MOQLTtFIitTYST054I6c2WaXxNRCnhzIgIzKdjY3c0XjwQD
         BllKLQd3Gjlp0YMAsT5RpfaFIh7TemFY2TyEY7VJkSM9T2yP3ot3H5p74InozxyBbI
         rAZLyDJWF+nrbjSYVbiURkmBGtqxXiOsr4Oa+0zFpITHutDP3DFctKS2b2NK+j1YPL
         Ki6Sm3cpWsGdg==
Message-ID: <9fe53d8ae42e381f28715aaf8d2b7ae7.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230117135459.16868-5-ansuelsmth@gmail.com>
References: <20230117135459.16868-1-ansuelsmth@gmail.com> <20230117135459.16868-5-ansuelsmth@gmail.com>
Subject: Re: [PATCH v3 4/6] clk: qcom: clk-rcg2: don't re-search config on rcg2_set_rate
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Christian Marangi <ansuelsmth@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Christian Marangi <ansuelsmth@gmail.com>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Wed, 29 Mar 2023 12:52:23 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Christian Marangi (2023-01-17 05:54:57)
> Currently the rcg2 driver search the rate to apply 2 times.
> - In _freq_tbl_determine_rate for the determine_rate function used by
>   core clk to understand the best rate to set with set_rate
> - In rcg2_set_rate where the suggested rate is not trusted and searched
>   another time using a CEIL or FLOOR policy.
>=20
> This is fundamentally wrong as we are ignoring what core clock is
> deciding and just setting whatever clock configuration we want for the
> suggested clock. The problem is in the fact that the correct clock
> should have already be searched and selected with the determine_rate
> function and set_rate should just apply whatever clock was provided.

It sounds like you're assuming the rate coming into the set_rate clk_op
is rounded? Don't make that assumption. The set_rate clk_op should round
the rate again. The parent rate could have changed.
