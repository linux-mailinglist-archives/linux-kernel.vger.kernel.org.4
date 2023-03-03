Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8517E6A9913
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 15:07:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbjCCOG7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 09:06:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbjCCOG5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 09:06:57 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 060BF61512;
        Fri,  3 Mar 2023 06:06:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 78CFF617EB;
        Fri,  3 Mar 2023 14:06:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 888B3C433D2;
        Fri,  3 Mar 2023 14:06:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677852399;
        bh=KNAuHE4kn9aaRylxCx4K5Env+Q8vYKX8tfM4BLlzUGU=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=F1G5/aT1BpCAwkq3s6gCe4qzHvlhogm93F1cUXBhfnuN/O2BN9hKTIGKIXvtI97IH
         ciGV4CB+uiXIoy5yLoydHF/mqaY5Gkb+SoXknmuPekN/7KIheB8XxUBnUFH46Phx00
         vGSamN2DTm01Al78B/V09jYs8UD6/nzvpeqv+WTLWx9ea2LpZLCBqc4EsBkevXYDRn
         l0kzIwzOhKwZ3VvjBoGlBLtkH+zUEQ02CbCOKB7spz5Ju0JVdSXY2ACT/qrniEsaAr
         K+Zd3XsuN6RoYCARXsMVvYpxN0Isfl8hwEAJ4jP6BsM+35d+OFyeRDQDTRgiA+PkbK
         SYtI74lX1fi+A==
Date:   Fri, 3 Mar 2023 15:06:41 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Reka Norman <rekanorman@chromium.org>
cc:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Li Qiong <liqiong@nfschina.com>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: intel-ish-hid: ipc: Fix potential use-after-free
 in work function
In-Reply-To: <20230227024938.2265017-1-rekanorman@chromium.org>
Message-ID: <nycvar.YFH.7.76.2303031506310.1142@cbobk.fhfr.pm>
References: <20230227024938.2265017-1-rekanorman@chromium.org>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Feb 2023, Reka Norman wrote:

> When a reset notify IPC message is received, the ISR schedules a work
> function and passes the ISHTP device to it via a global pointer
> ishtp_dev. If ish_probe() fails, the devm-managed device resources
> including ishtp_dev are freed, but the work is not cancelled, causing a
> use-after-free when the work function tries to access ishtp_dev. Use
> devm_work_autocancel() instead, so that the work is automatically
> cancelled if probe fails.
> 
> Signed-off-by: Reka Norman <rekanorman@chromium.org>

Applied, thank you.

-- 
Jiri Kosina
SUSE Labs

