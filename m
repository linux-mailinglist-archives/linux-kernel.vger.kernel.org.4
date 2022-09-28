Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68A655ED349
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 05:07:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232796AbiI1DHT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 23:07:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232303AbiI1DG4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 23:06:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A98641CE914;
        Tue, 27 Sep 2022 20:06:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 09E7861CF8;
        Wed, 28 Sep 2022 03:06:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EABAC43140;
        Wed, 28 Sep 2022 03:06:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664334414;
        bh=JSYL6zTmI1v/knH5ePUdorTCFFcn9txmwuF5JUvMOQU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LaLGV5KjmFnB3t5VgsUkcBNhy5oymIPKuAof5O/qx2Yo7HsQ12SfCWm2wg1KKd2EM
         FyE4R1VEklBPBZ+8lVOr9Xm/znkuvtNIJelclX0qb+TY5yGagPedDxkfbMOw7ep4iI
         GBBBCjKJUXOvp5PJowp9Nwd3fZf3kHChX0gwU2JkmOgc+/x2gSN5Jzxtqs7qE/mfv2
         1p78d2k6HFzEHE4GkhJT3ifLnr93dbJ9NKhvNvZg2Or4MRFyoq2f/biUSA93qiUjnw
         e/6/RR+dhvi4rHnorczf2sTHXt+MloByJRkkU05oNhgOdhA73lbXJ1RQ+Jg8Ne9pZ1
         zvYp9V2EeXpLw==
From:   Bjorn Andersson <andersson@kernel.org>
To:     sboyd@kernel.org, konrad.dybcio@somainline.org, mka@chromium.org,
        mturquette@baylibre.com, quic_rjendra@quicinc.com,
        agross@kernel.org
Cc:     johan+linaro@kernel.org, dianders@chromium.org,
        linux-clk@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_kriskura@quicinc.com,
        angelogioacchino.delregno@collabora.com
Subject: Re: (subset) [PATCH v3 1/3] clk: qcom: gdsc: Fix the handling of PWRSTS_RET support
Date:   Tue, 27 Sep 2022 22:06:48 -0500
Message-Id: <166433439998.1849007.9991122378265739432.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220920111517.10407-1-quic_rjendra@quicinc.com>
References: <20220920111517.10407-1-quic_rjendra@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Sep 2022 16:45:15 +0530, Rajendra Nayak wrote:
> GDSCs cannot be transitioned into a Retention state in SW.
> When either the RETAIN_MEM bit, or both the RETAIN_MEM and
> RETAIN_PERIPH bits are set, and the GDSC is left ON, the HW
> takes care of retaining the memory/logic for the domain when
> the parent domain transitions to power collapse/power off state.
> 
> On some platforms where the parent domains lowest power state
> itself is Retention, just leaving the GDSC in ON (without any
> RETAIN_MEM/RETAIN_PERIPH bits being set) will also transition
> it to Retention.
> 
> [...]

Applied, thanks!

[1/3] clk: qcom: gdsc: Fix the handling of PWRSTS_RET support
      commit: d399723950c45cd9507aef848771826afc3f69b0
[2/3] clk: qcom: gcc-sc7180: Update the .pwrsts for usb gdsc
      commit: d9fe9f3fefe74d15e280fce628bff1b6fc6d9675
[3/3] clk: qcom: gcc-sc7280: Update the .pwrsts for usb gdscs
      commit: e3ae3e899aa0322ff685fd7cf1322c6670da7db7

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
