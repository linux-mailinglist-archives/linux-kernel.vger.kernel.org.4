Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74E4C6DB1E8
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 19:39:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231210AbjDGRj1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 13:39:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230369AbjDGRjH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 13:39:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B90C3C155;
        Fri,  7 Apr 2023 10:38:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1491E65329;
        Fri,  7 Apr 2023 17:38:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1B8EC4339E;
        Fri,  7 Apr 2023 17:38:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680889123;
        bh=ShYE/NmpoSW62Nvk+UDzbzXRAyY8hKK3U9ol2L/cDjg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=M0dcZC1PwRN2HkRpAf18Y8Sc3xtdV99EC+vxYRCkvNNAP+f919nIOyOf5C1k+lysA
         DsIPR1Qt8nC4oUYnjInR8TIxqXfTv7etNNAZFIr8N3Z4pgJcnzOnfgGSt+8WWdyUnl
         AtCK3R+vmetr+XaPeV8TeeBy7ElBS52aIWcd/f+6IC92wBZ6VtySpHzS+akBWGLAPm
         9FGQ7rTD0MB43HTwT8UqysfMbMPTFlPqN0cgjcBIFUJ0L4OURVzzGJE92PFWqiUUkv
         QzbufEidnsWI3M3Syk9Vjk2T1AbA0NyhHej5ZBtJs+zEboLXJ09NMin4l6aPtNNsSc
         ndslYUpGWzB9w==
From:   Bjorn Andersson <andersson@kernel.org>
To:     dri-devel@lists.freedesktop.org, Rob Clark <robdclark@gmail.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Akhil P Oommen <quic_akhilpo@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Douglas Anderson <dianders@chromium.org>,
        Chia-I Wu <olvaffe@gmail.com>, Luca Weiss <luca@z3ntu.xyz>,
        Sean Paul <sean@poorly.run>,
        Nathan Chancellor <nathan@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "open list:DEVICE FREQUENCY DEVFREQ" <linux-pm@vger.kernel.org>,
        Rob Clark <robdclark@chromium.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "moderated list:DMA BUFFER SHARING FRAMEWORK" 
        <linaro-mm-sig@lists.linaro.org>, Daniel Vetter <daniel@ffwll.ch>,
        freedreno@lists.freedesktop.org,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DMA BUFFER SHARING FRAMEWORK" 
        <linux-media@vger.kernel.org>, linux-arm-msm@vger.kernel.org
Subject: Re: (subset) [PATCH v2 00/23] drm/msm+PM+icc: Make job_run() reclaim-safe
Date:   Fri,  7 Apr 2023 10:41:19 -0700
Message-Id: <168088927578.2561591.14585371270684166515.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230320144356.803762-1-robdclark@gmail.com>
References: <20230320144356.803762-1-robdclark@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Mar 2023 07:43:22 -0700, Rob Clark wrote:
> From: Rob Clark <robdclark@chromium.org>
> 
> Inspired by https://lore.kernel.org/dri-devel/20200604081224.863494-10-daniel.vetter@ffwll.ch/
> it seemed like a good idea to get rid of memory allocation in job_run()
> fence signaling path, and use lockdep annotations to yell at us about
> anything that could deadlock against shrinker/reclaim.  Anything that
> can trigger reclaim, or block on any other thread that has triggered
> reclaim, can block the GPU shrinker from releasing memory if it is
> waiting the job to complete, causing deadlock.
> 
> [...]

Applied, thanks!

[20/23] soc: qcom: smd-rpm: Use GFP_ATOMIC in write path
        commit: 5808c532ca0a983d643319caca44f2bcb148298f

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
