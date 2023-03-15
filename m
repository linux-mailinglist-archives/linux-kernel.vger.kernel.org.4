Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50F2F6BC14F
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 00:34:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233290AbjCOXeQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 19:34:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232856AbjCOXdg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 19:33:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 440B6A1FD4;
        Wed, 15 Mar 2023 16:32:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6C9C361E7F;
        Wed, 15 Mar 2023 23:32:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 009AFC433D2;
        Wed, 15 Mar 2023 23:32:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678923160;
        bh=Ic72wvND6rzUvwtFlHFhzvcUBlI9mIniEmsRnS6u05M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S9tJwDXvwKySFiAT6ROPVmZ6jxmFQj57tYXTDFq/aSNyuYZQZ7YMSmEs13129qxRv
         C+nCRgcGoccMhf+3x06Dqq9sQKRl6e0tkf0m1xpl/rfuaepOxZ2HZTTgtbpSU4nQTy
         cT7bAhF4SenVN5KygLaHRqWgTmAZ8NKfYKvP26eiLgxkgWThKZYxNfi/E9UAoxNOxa
         gT8J2pDIMajxGeTGcysMwqGVAEyAl319OAYSdonsfGKvJpHxR3Xm7Ax+gqF7cNMIws
         +/rii4z9lFsuHUT3nvrQ0vDTW0sYyZXD7BvuorbgoNoy8O65sHPV740S6GpbSizvYv
         r2c5n0SWumnEg==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        phone-devel@vger.kernel.org, Luca Weiss <luca@z3ntu.xyz>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        ~postmarketos/upstreaming@lists.sr.ht,
        Christian Marangi <ansuelsmth@gmail.com>,
        Andy Gross <agross@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH 0/2] Switch hfpll & krait clock drivers to .determine_rate
Date:   Wed, 15 Mar 2023 16:35:12 -0700
Message-Id: <167892332565.4030021.47769370794989533.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230212-clk-qcom-determine_rate-v1-0-b4e447d4926e@z3ntu.xyz>
References: <20230212-clk-qcom-determine_rate-v1-0-b4e447d4926e@z3ntu.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 12 Feb 2023 15:11:07 +0100, Luca Weiss wrote:
> While trying to get cpufreq working on msm8974 I've found an issue with
> clock rates above 2.11GHz (e.g. 2.15GHz). When a rate above this
> threshold gets requested the lowest possible frequency will be selected.
> 
> This is caused by an overflow of the "long" return type of .round_rate
> which has a maximum value of 2147483647 (2.14GHz) on 32-bit systems,
> which msm8974 is.
> 
> [...]

Applied, thanks!

[1/2] clk: qcom: clk-krait: switch to .determine_rate
      commit: a7074c3eb26e0193f2c6ed79987e633b7578024e
[2/2] clk: qcom: clk-hfpll: switch to .determine_rate
      commit: 04648b8fad219599ccc9b103188a38e72d339a3d

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
