Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9C0D7199D9
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 12:32:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232302AbjFAKck (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 06:32:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232009AbjFAKci (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 06:32:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D8F1133;
        Thu,  1 Jun 2023 03:32:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F3CAA63920;
        Thu,  1 Jun 2023 10:32:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B199C433EF;
        Thu,  1 Jun 2023 10:32:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685615545;
        bh=dt6p3Brt1Itsty6Taal/O+e66TI2Zbp2bCYp/pFVGaw=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=gFapp66adfNYkz+UlBv5CMml4HXuFfXtVf6eLzE6XDqSe34qVIkSfa0CigUpSGk9c
         h9yqhWQtpk7A3j6Cd4X/jNX3tsSS+9zitXnZ6/aZlvp6+/RDJkIpfICV2/zOf3bX53
         YCdQYy7Wq3Ig2BEDmUxKNOAK4cD+0p5kmijgqb3mRC+mbtS86i+G73jr/dX/7r4B4m
         GmCghaIZbmMBc9Lg8QdAXAbviL1+z6VZv5cmiz0y6sLEM9UHOvYPr4GMe6Omd5IOMT
         RUI3aH2CBt1ZnNmpruIpW6hvnhZxa5nwOcmdKFQFnKLBX5M2Hc+NF82AQR1Awdv+0E
         IXyE1ZtjiBN+w==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: ath10k: Trigger STA disconnect after reconfig
 complete
 on hardware restart
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230518101515.3820-1-quic_youghand@quicinc.com>
References: <20230518101515.3820-1-quic_youghand@quicinc.com>
To:     Youghandhar Chintala <quic_youghand@quicinc.com>
Cc:     <ath10k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_mpubbise@quicinc.com>,
        Youghandhar Chintala <quic_youghand@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <168561554040.17301.14211213140833705181.kvalo@kernel.org>
Date:   Thu,  1 Jun 2023 10:32:23 +0000 (UTC)
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Youghandhar Chintala <quic_youghand@quicinc.com> wrote:

> Currently, on WCN3990, the station disconnect after hardware recovery is
> not working as expected. This is because of setting the
> IEEE80211_SDATA_DISCONNECT_HW_RESTART flag very early in the hardware
> recovery process even before the driver invokes ieee80211_hw_restart().
> On the contrary, mac80211 expects this flag to be set after
> ieee80211_hw_restart() is invoked for it to trigger station disconnect.
> 
> Set the IEEE80211_SDATA_DISCONNECT_HW_RESTART flag in
> ath10k_reconfig_complete() instead to fix this.
> 
> The other targets are not affected by this change, since the hardware
> params flag is not set.
> 
> Tested-on: WCN3990 hw1.0 SNOC WLAN.HL.3.2.2.c10-00754-QCAHLSWMTPL-1
> 
> Fixes: 2c3fc50591ff ("ath10k: Trigger sta disconnect on hardware restart")
> Signed-off-by: Youghandhar Chintala <quic_youghand@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

75bd32f5ce94 wifi: ath10k: Trigger STA disconnect after reconfig complete on hardware restart

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230518101515.3820-1-quic_youghand@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

