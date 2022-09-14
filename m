Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D30935B81D8
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 09:12:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230125AbiINHMm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 03:12:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbiINHMk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 03:12:40 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18CF261B16;
        Wed, 14 Sep 2022 00:12:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B8113B815C6;
        Wed, 14 Sep 2022 07:12:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69900C433C1;
        Wed, 14 Sep 2022 07:12:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663139556;
        bh=oW1ddkzDyIEE8sB0njHBP/xb7iH2+2UCc497E5sslUo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DQ+U2T9wazLoo/Q2zuJscQzs+RATnyte4Jb5ndgWGC6CAa51zUS3PTJzL9lWWmzBA
         xr1lfPRmmhdS061DASACSUk0jdZ2HFD1Gf+s4HrqBnKlCdLS6HRBDg2kOUEg32m7Vc
         0GVwUpoY3gsFqqBrv+MXqXa9i4NKQqQaOSTkx8SbzU4y8T5x8nwj4+CCBUzT4/HWBl
         ZVDTa7EjCUAifImGThcdwnTpgvCTnz11itf+O6cUO5n7GaLNe2L4WGbEcYwnY9lckJ
         7fdOCIxljk9IMZCssP8bsNeoPWLKbB5uIcjsyenpHJL7ygDRIh76lSXS6+WvBrE79V
         XNq1eVHwGFsZA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1oYMZY-0003I6-Sj; Wed, 14 Sep 2022 09:12:36 +0200
Date:   Wed, 14 Sep 2022 09:12:36 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Rajendra Nayak <quic_rjendra@quicinc.com>, andersson@kernel.org,
        agross@kernel.org, konrad.dybcio@somainline.org,
        mturquette@baylibre.com, sboyd@kernel.org, johan+linaro@kernel.org,
        quic_kriskura@quicinc.com, dianders@chromium.org,
        linux-clk@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] clk: qcom: gcc-sc7280: Update the .pwrsts for usb
 gdsc
Message-ID: <YyF+5CQqcLQlXvzV@hovoldconsulting.com>
References: <20220901101756.28164-1-quic_rjendra@quicinc.com>
 <20220901101756.28164-3-quic_rjendra@quicinc.com>
 <YxDYJ+ONryLROBhL@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YxDYJ+ONryLROBhL@google.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 01, 2022 at 09:04:55AM -0700, Matthias Kaehlcke wrote:
> On Thu, Sep 01, 2022 at 03:47:56PM +0530, Rajendra Nayak wrote:
> > USB on sc7280 cannot support wakeups from low power states
> > if the GDSC is turned OFF. Update the .pwrsts for usb GDSC so it
> > only transitions to RET in low power.
> > 
> > Signed-off-by: Rajendra Nayak <quic_rjendra@quicinc.com>
> 
> Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
> Tested-by: Matthias Kaehlcke <mka@chromium.org>

Did you confirm that you actually hit the retention state?

IIUC, this series is equivalent to using ALWAYS_ON unless CX is actually
powered off during suspend.

Johan
