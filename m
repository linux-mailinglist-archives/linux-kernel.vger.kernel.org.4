Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C50076194C4
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 11:47:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229493AbiKDKrd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 06:47:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiKDKr3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 06:47:29 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 279332B255;
        Fri,  4 Nov 2022 03:47:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C9BDAB82CE2;
        Fri,  4 Nov 2022 10:47:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24297C433D6;
        Fri,  4 Nov 2022 10:47:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667558846;
        bh=DWz46wrxY7QGNiIIHg0vhNtEyE79lpwGrqHDoC7UyUI=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=YKzWjFCKKxCr+q9VzMHoXZ6cDcTlzFCUo3QEsEFMyxRMz7uWrLw14Nq6qcDBMesi7
         kCWe14MmP8HW8obaJMBnO2LHBcRoRgN73FcPkDKo8Jgp9p15jMo3e4dSSLDAzyPt16
         nm/hw2vxqAZLl2+rY46NBJSLbFyGctuah85V1Ui+OCWgz68MP0xx9hl/B3VBuEqNcC
         APhOGJRfnBhOCxrzICqeGm1i5/QdEgm3BKwZIADi/Uc1cxl26MeymXaRrhLYYfDZ6x
         ePoA6FOL611PIckOPZd3vVaH7HDlpvVuQ9UKlQTgt50H1wLwUhsMUuqx30WSDl1f1h
         44BFNAWCzRfQg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2] wifi: ath11k: Trigger sta disconnect on hardware
 restart
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20221104085403.11025-1-quic_youghand@quicinc.com>
References: <20221104085403.11025-1-quic_youghand@quicinc.com>
To:     Youghandhar Chintala <quic_youghand@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Youghandhar Chintala <quic_youghand@quicinc.com>,
        kernel test robot <lkp@intel.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <166755883456.9892.7557940279708188243.kvalo@kernel.org>
Date:   Fri,  4 Nov 2022 10:47:24 +0000 (UTC)
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Youghandhar Chintala <quic_youghand@quicinc.com> wrote:

> Currently after the hardware restart triggered from the driver, the
> station interface connection remains intact, since a disconnect trigger
> is not sent to userspace. This can lead to a problem in targets where
> the wifi mac sequence is added by the firmware.
> 
> After the target restart, its wifi mac sequence number gets reset to
> zero. Hence AP to which our device is connected will receive frames with
> a  wifi mac sequence number jump to the past, thereby resulting in the
> AP dropping all these frames, until the frame arrives with a wifi mac
> sequence number which AP was expecting.
> 
> To avoid such frame drops, its better to trigger a station disconnect
> upon target hardware restart which can be done with API
> ieee80211_reconfig_disconnect exposed to mac80211.
> 
> The other targets are not affected by this change, since the hardware
> params flag is not set.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> 
> Tested-on: WCN6750 hw1.0 AHB WLAN.MSL.1.0.1-00887-QCAMSLSWPLZ-1
> 
> Signed-off-by: Youghandhar Chintala <quic_youghand@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

This had a new warning:

drivers/net/wireless/ath/ath11k/mac.c:8056: Blank lines aren't necessary before a close brace '}'

I fixed it in the pending branch.

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20221104085403.11025-1-quic_youghand@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

