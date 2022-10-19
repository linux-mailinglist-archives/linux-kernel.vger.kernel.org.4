Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73765603957
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 07:44:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbiJSFow (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 01:44:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbiJSFos (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 01:44:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCC3727CCC;
        Tue, 18 Oct 2022 22:44:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 584186158B;
        Wed, 19 Oct 2022 05:44:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F9F7C433D7;
        Wed, 19 Oct 2022 05:44:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666158285;
        bh=E8UeC0WUnxsuYD3yKW5jYAZL9kBreTcaaWUL/RKE5Mc=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=Tm5M5aZeCspKAgAE40+Z7Eonk0w7qN17zV3XqKPpQWOQGLKM7rzHYw15e1nNtNnKq
         ZeryNqk31iy9TKufis/saWf0Ye1HDevE4231iZ96WhnPyUmHrBKdaRSepHUya01eKi
         8S2XsZXLiFsj4wi8iyxjQymFLKspZ3pd5lbwOzJU0HdaCLYLt/kYuavq+SXMrovYcP
         uRl3lxgN5fnr3aw/wd04bZvwkXY/YybNjG5Gre/eEJuF0yFz4UYfotpkc/A/P90age
         8Q/cfzYQ2RBl9Qr41mgu/+MMl5t3x9wkQqOfA3feyMKwUjt5laiBlTmY41l1RVYLIw
         n/h57mAiRkxOw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2] wifi: ath10k: Delay the unmapping of the buffer
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20221012142733.32420-1-quic_youghand@quicinc.com>
References: <20221012142733.32420-1-quic_youghand@quicinc.com>
To:     Youghandhar Chintala <quic_youghand@quicinc.com>
Cc:     <ath10k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Youghandhar Chintala <quic_youghand@quicinc.com>,
        Douglas Anderson <dianders@chromium.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <166615828224.31701.17876502388354120236.kvalo@kernel.org>
Date:   Wed, 19 Oct 2022 05:44:44 +0000 (UTC)
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Youghandhar Chintala <quic_youghand@quicinc.com> wrote:

> On WCN3990, we are seeing a rare scenario where copy engine hardware is
> sending a copy complete interrupt to the host driver while still
> processing the buffer that the driver has sent, this is leading into an
> SMMU fault triggering kernel panic. This is happening on copy engine
> channel 3 (CE3) where the driver normally enqueues WMI commands to the
> firmware. Upon receiving a copy complete interrupt, host driver will
> immediately unmap and frees the buffer presuming that hardware has
> processed the buffer. In the issue case, upon receiving copy complete
> interrupt, host driver will unmap and free the buffer but since hardware
> is still accessing the buffer (which in this case got unmapped in
> parallel), SMMU hardware will trigger an SMMU fault resulting in a
> kernel panic.
> 
> In order to avoid this, as a work around, add a delay before unmapping
> the copy engine source DMA buffer. This is conditionally done for
> WCN3990 and only for the CE3 channel where issue is seen.
> 
> Below is the crash signature:
> 
> wifi smmu error: kernel: [ 10.120965] arm-smmu 15000000.iommu: Unhandled
> context fault: fsr=0x402, iova=0x7fdfd8ac0,
> fsynr=0x500003,cbfrsynra=0xc1, cb=6 arm-smmu 15000000.iommu: Unhandled
> context fault:fsr=0x402, iova=0x7fe06fdc0, fsynr=0x710003,
> cbfrsynra=0xc1, cb=6 qcom-q6v5-mss 4080000.remoteproc: fatal error
> received: err_qdi.c:1040:EF:wlan_process:0x1:WLAN RT:0x2091:
> cmnos_thread.c:3998:Asserted in copy_engine.c:AXI_ERROR_DETECTED:2149
> remoteproc remoteproc0: crash detected in
> 4080000.remoteproc: type fatal error <3> remoteproc remoteproc0:
> handling crash #1 in 4080000.remoteproc
> 
> pc : __arm_lpae_unmap+0x500/0x514
> lr : __arm_lpae_unmap+0x4bc/0x514
> sp : ffffffc011ffb530
> x29: ffffffc011ffb590 x28: 0000000000000000
> x27: 0000000000000000 x26: 0000000000000004
> x25: 0000000000000003 x24: ffffffc011ffb890
> x23: ffffffa762ef9be0 x22: ffffffa77244ef00
> x21: 0000000000000009 x20: 00000007fff7c000
> x19: 0000000000000003 x18: 0000000000000000
> x17: 0000000000000004 x16: ffffffd7a357d9f0
> x15: 0000000000000000 x14: 00fd5d4fa7ffffff
> x13: 000000000000000e x12: 0000000000000000
> x11: 00000000ffffffff x10: 00000000fffffe00
> x9 : 000000000000017c x8 : 000000000000000c
> x7 : 0000000000000000 x6 : ffffffa762ef9000
> x5 : 0000000000000003 x4 : 0000000000000004
> x3 : 0000000000001000 x2 : 00000007fff7c000
> x1 : ffffffc011ffb890 x0 : 0000000000000000 Call trace:
> __arm_lpae_unmap+0x500/0x514
> __arm_lpae_unmap+0x4bc/0x514
> __arm_lpae_unmap+0x4bc/0x514
> arm_lpae_unmap_pages+0x78/0xa4
> arm_smmu_unmap_pages+0x78/0x104
> __iommu_unmap+0xc8/0x1e4
> iommu_unmap_fast+0x38/0x48
> __iommu_dma_unmap+0x84/0x104
> iommu_dma_free+0x34/0x50
> dma_free_attrs+0xa4/0xd0
> ath10k_htt_rx_free+0xc4/0xf4 [ath10k_core] ath10k_core_stop+0x64/0x7c
> [ath10k_core]
> ath10k_halt+0x11c/0x180 [ath10k_core]
> ath10k_stop+0x54/0x94 [ath10k_core]
> drv_stop+0x48/0x1c8 [mac80211]
> ieee80211_do_open+0x638/0x77c [mac80211] ieee80211_open+0x48/0x5c
> [mac80211]
> __dev_open+0xb4/0x174
> __dev_change_flags+0xc4/0x1dc
> dev_change_flags+0x3c/0x7c
> devinet_ioctl+0x2b4/0x580
> inet_ioctl+0xb0/0x1b4
> sock_do_ioctl+0x4c/0x16c
> compat_ifreq_ioctl+0x1cc/0x35c
> compat_sock_ioctl+0x110/0x2ac
> __arm64_compat_sys_ioctl+0xf4/0x3e0
> el0_svc_common+0xb4/0x17c
> el0_svc_compat_handler+0x2c/0x58
> el0_svc_compat+0x8/0x2c
> 
> Tested-on: WCN3990 hw1.0 SNOC WLAN.HL.2.0-01387-QCAHLSWMTPLZ-1
> 
> Tested-by: Douglas Anderson <dianders@chromium.org>
> Signed-off-by: Youghandhar Chintala <quic_youghand@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

acd4324e5f1f wifi: ath10k: Delay the unmapping of the buffer

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20221012142733.32420-1-quic_youghand@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

