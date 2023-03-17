Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C81EE6BF0EB
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 19:43:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbjCQSnb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 14:43:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbjCQSn1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 14:43:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CEAF3C11;
        Fri, 17 Mar 2023 11:43:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EF7AB6122C;
        Fri, 17 Mar 2023 18:43:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4285AC433EF;
        Fri, 17 Mar 2023 18:43:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679078604;
        bh=gy+ZW99p4w4RpqQo3NdtvUz0QkM5X7Lm4e/MMSQeaf8=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=IyHLA/WdqQAVt850meu4OaFI/H0vbL+H0xuVv1REkv8tm2quCsIxZQ8QYhwApXiWy
         HthXXvgM80HWpXW2Il+QNY33g0MWa/EC2uWtuMxGXeqP1+c8I0aphM23ZoCEhEsutt
         B+1ar8qmNK/3OOBqWmE4Ppx78dtlmq1/oeKcQwXZW3uI+NU3VBN6/qs36sx+WJdxXl
         f1faTrEFusLfmS/GkvbpkN/jouUnIIouz5kgnn3I8/6GmkLnZAJI+Ep1OLfAWImev0
         6+xzxv8qUbBUB4IL6q0rw/G6Mo+5CEzO10CcIBhJfiunq6oFbI8CElEmILhWSgTjH9
         ipDCQTNMRDMGQ==
Message-ID: <06cc8339e30eb38175e04058b69b41ca.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230317141622.1926573-4-quic_mohs@quicinc.com>
References: <20230317141622.1926573-1-quic_mohs@quicinc.com> <20230317141622.1926573-4-quic_mohs@quicinc.com>
Subject: Re: [PATCH v9 3/4] clk: qcom: lpassaudiocc-sc7280: Add required gdsc power domain clks in lpass_cc_sc7280_desc strcuture
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Mohammad Rafi Shaik <quic_mohs@quicinc.com>
To:     Mohammad Rafi Shaik <quic_mohs@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, broonie@kernel.org,
        konrad.dybcio@somainline.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, mturquette@baylibre.com,
        quic_plai@quicinc.com, quic_visr@quicinc.com, robh+dt@kernel.org,
        swboyd@chromium.org
Date:   Fri, 17 Mar 2023 11:43:22 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just remove strcuture from the subject.

Quoting Mohammad Rafi Shaik (2023-03-17 07:16:21)
> Add the gdsc's in lpass_cc_sc7280_desc strcuture,

s/strcuture/struct/

> When qcom,adsp-pil-mode is enabled, gdsc's required to solve

Just 'GDSCs', because gdsc isn't owning anything.

> dependencies in lpass_audiocc probe.

I think you're saying that we need to register the GDSCs when
qcom,adsp-pil-mode is set in the qcom,sc7280-lpassaoncc node. Otherwise,
we don't get any GDSCs provided by that node when we should always be
providing them.

>=20
> Fixes: 4ab43d171181 ("clk: qcom: Add lpass clock controller driver for SC=
7280")

If the above is right, then this fixes tag is wrong. It should really be=20

Fixes: 0cbcfbe50cbf ("clk: qcom: lpass: Handle the regmap overlap of lpassc=
c and lpass_aon")

right?
