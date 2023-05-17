Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3ACD705FB9
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 08:10:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232332AbjEQGKA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 02:10:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbjEQGJ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 02:09:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CA2830D2;
        Tue, 16 May 2023 23:09:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2ED4F631AE;
        Wed, 17 May 2023 06:09:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65E3BC433D2;
        Wed, 17 May 2023 06:09:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684303795;
        bh=SFhUhSfjEdWXkfr//BUUbfd9TZQ3NWaa2FnutJPNa3g=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=sxelD4VK6J4eHsVtS5/RTsDTn+tcBN2uRZsMgYjKYgKi5GUsQmkoS62MB8ZMXEwKl
         fERAGa+h8KOxgun9PK50O8/axJp0KkFKm+qQfObijfqMFRfIrWIOk2wV+pW6KAB9Td
         XTM3Ar+ssIsCZ8PhvcqCUJ7xL5KK8TSc03T656b/OouqIXObD1HZQcJv3v0RImrGhS
         6sEn9r5yHP6ZQ2oxbeBF4mvhhFSkwHZuezOMAga2xz4u8plbDmJKa7cd75yuc+KfXa
         I+ulsHzun5n1VjhTlHWcrsKLGsjc7fhoz7OSV55//gPwLcAwT1xOGC5HosJ6nvknRT
         L042bLclSpRuQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH wireless v2] wifi: rtw88: sdio: Always use two consecutive
 bytes for word operations
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230515195043.572375-1-martin.blumenstingl@googlemail.com>
References: <20230515195043.572375-1-martin.blumenstingl@googlemail.com>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        pkshih@realtek.com, tony0620emma@gmail.com,
        jernej.skrabec@gmail.com, linux-sunxi@lists.linux.dev,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Rudi Heitbaum <rudi@heitbaum.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <168430378778.24096.6636792783589733385.kvalo@kernel.org>
Date:   Wed, 17 May 2023 06:09:53 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Blumenstingl <martin.blumenstingl@googlemail.com> wrote:

> The Allwinner sunxi-mmc controller cannot handle word (16 bit)
> transfers. So and sdio_{read,write}w fails with messages like the
> following example using an RTL8822BS (but the same problems were also
> observed with RTL8822CS and RTL8723DS chips):
>   rtw_8822bs mmc1:0001:1: Firmware version 27.2.0, H2C version 13
>   sunxi-mmc 4021000.mmc: unaligned scatterlist: os f80 length 2
>   sunxi-mmc 4021000.mmc: map DMA failed
>   rtw_8822bs mmc1:0001:1: sdio read16 failed (0x10230): -22
> 
> Use two consecutive single byte accesses for word operations instead. It
> turns out that upon closer inspection this is also what the vendor
> driver does, even though it does have support for sdio_{read,write}w. So
> we can conclude that the rtw88 chips do support word access but only on
> SDIO controllers that also support it. Since there's no way to detect if
> the controller supports word access or not the rtw88 sdio driver
> switches to the easiest approach: avoiding word access.
> 
> Reported-by: Larry Finger <Larry.Finger@lwfinger.net>
> Closes: https://lore.kernel.org/linux-wireless/527585e5-9cdd-66ed-c3af-6da162f4b720@lwfinger.net/
> Reported-by: Rudi Heitbaum <rudi@heitbaum.com>
> Link: https://github.com/LibreELEC/LibreELEC.tv/pull/7837#issue-1708469467
> Fixes: 65371a3f14e7 ("wifi: rtw88: sdio: Add HCI implementation for SDIO based chipsets")
> Reviewed-by: Ping-Ke Shih <pkshih@realtek.com>
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

Patch applied to wireless.git, thanks.

cb0ddaaa5db0 wifi: rtw88: sdio: Always use two consecutive bytes for word operations

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230515195043.572375-1-martin.blumenstingl@googlemail.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

