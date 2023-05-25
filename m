Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BFDB711089
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 18:10:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232250AbjEYQKl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 12:10:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231596AbjEYQKi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 12:10:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBCAC197;
        Thu, 25 May 2023 09:10:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3B66061757;
        Thu, 25 May 2023 16:10:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58393C4339C;
        Thu, 25 May 2023 16:10:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685031002;
        bh=iSGDiZcRAOZP9QDfA3b+KrqjP8hgBXB5BdpCRXEb0kE=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=JLrgHoPNQWg9xYlSsC7hRL8KjCHdpQtZKez3rHTFyvGRg6zed3yFm41mx9H8DjZeP
         i7fTlUCIV9jMho6j6N/KfIWqMAbUTb8yOREFed84Ts1k8dyAbYx8m8xMX0Y/HstftD
         oySFVpGQ5GgvjnG0OecTTXAJcMPKW0GfkH9h17RhcHgMGqiq1HKgJb80MFuPPfWbMU
         7b5ilNbcnmOQ/ZUjWxaFb/unrN1oc0N2cBQLVMN0NbfR7hOhKa6t/fd2L1IKKCZ3z0
         aS3j3GTT83Yd2N8bPVWOxm5spLtvjUulD8P8uUy4U2pxW8U6ENVe+HQXuIg28lSchz
         fyIwW/oLnWb3w==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH wireless-next v2 1/4] wifi: rtw88: sdio: Check the HISR
 RX_REQUEST bit in rtw_sdio_rx_isr()
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230522202425.1827005-2-martin.blumenstingl@googlemail.com>
References: <20230522202425.1827005-2-martin.blumenstingl@googlemail.com>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     linux-wireless@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, ulf.hansson@linaro.org,
        tony0620emma@gmail.com, Peter Robinson <pbrobinson@gmail.com>,
        Ping-Ke Shih <pkshih@realtek.com>, jernej.skrabec@gmail.com,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <168503099830.22756.1444846830853755949.kvalo@kernel.org>
Date:   Thu, 25 May 2023 16:10:00 +0000 (UTC)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Blumenstingl <martin.blumenstingl@googlemail.com> wrote:

> rtw_sdio_rx_isr() is responsible for receiving data from the wifi chip
> and is called from the SDIO interrupt handler when the interrupt status
> register (HISR) has the RX_REQUEST bit set. After the first batch of
> data has been processed by the driver the wifi chip may have more data
> ready to be read, which is managed by a loop in rtw_sdio_rx_isr().
> 
> It turns out that there are cases where the RX buffer length (from the
> REG_SDIO_RX0_REQ_LEN register) does not match the data we receive. The
> following two cases were observed with a RTL8723DS card:
> - RX length is smaller than the total packet length including overhead
>   and actual data bytes (whose length is part of the buffer we read from
>   the wifi chip and is stored in rtw_rx_pkt_stat.pkt_len). This can
>   result in errors like:
>     skbuff: skb_over_panic: text:ffff8000011924ac len:3341 put:3341
>   (one case observed was: RX buffer length = 1536 bytes but
>    rtw_rx_pkt_stat.pkt_len = 1546 bytes, this is not valid as it means
>    we need to read beyond the end of the buffer)
> - RX length looks valid but rtw_rx_pkt_stat.pkt_len is zero
> 
> Check if the RX_REQUEST is set in the HISR register for each iteration
> inside rtw_sdio_rx_isr(). This mimics what the RTL8723DS vendor driver
> does and makes the driver only read more data if the RX_REQUEST bit is
> set (which seems to be a way for the card's hardware or firmware to
> tell the host that data is ready to be processed).
> 
> For RTW_WCPU_11AC chips this check is not needed. The RTL8822BS vendor
> driver for example states that this check is unnecessary (but still uses
> it) and the RTL8822CS drops this check entirely.
> 
> Reviewed-by: Ping-Ke Shih <pkshih@realtek.com>
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

4 patches applied to wireless-next.git, thanks.

e967229ead0e wifi: rtw88: sdio: Check the HISR RX_REQUEST bit in rtw_sdio_rx_isr()
9be20a822327 wifi: rtw88: rtw8723d: Implement RTL8723DS (SDIO) efuse parsing
09fcdbd28404 mmc: sdio: Add/rename SDIO ID of the RTL8723DS SDIO wifi cards
a3b125ceb45e wifi: rtw88: Add support for the SDIO based RTL8723DS chipset

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230522202425.1827005-2-martin.blumenstingl@googlemail.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

