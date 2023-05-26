Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D009F71281A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 16:14:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243655AbjEZOOR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 10:14:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237404AbjEZOOP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 10:14:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 603E1116;
        Fri, 26 May 2023 07:14:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DE9276502D;
        Fri, 26 May 2023 14:14:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04ED7C433EF;
        Fri, 26 May 2023 14:14:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685110453;
        bh=E7mpy7SJ9yejkkLCnA+9EJpYhZ/fdVkiMDu4+8NZN2Y=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=Ytj8DhoC0MYxfulX/FoNXAWaW4KGrvA8fxzDoQmBBcp0KRG+6I2qh/a4oh94El/s0
         /3ipvcxxQ1RTsLmei+zMRd7bnV6biGWdOJ6ReCxskBo6VrdlHyw/bSSNuHzPeOAQSe
         5SAdxB/l3REg4zmhMoweWxwlKj5r49sstFbq8JtguXriZhbHI7bux18J/wQGGHQNvG
         5Q6LwaIMXUNf83Rk9jcpzD8trlcerfNQljvQExtNLP6y6ZOj+nX7sAhcrE5Z/Ndmzs
         /glQ/94zCq9N9N/jfQweimEg7BSJTB6ReB9R/G6JCeNRQ8n/YgmSBvjY/JwY6zUG2r
         CEuBZxRi5f8+A==
From:   Kalle Valo <kvalo@kernel.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-wireless@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, tony0620emma@gmail.com,
        Peter Robinson <pbrobinson@gmail.com>,
        Ping-Ke Shih <pkshih@realtek.com>, jernej.skrabec@gmail.com,
        Larry Finger <Larry.Finger@lwfinger.net>
Subject: Re: [PATCH wireless-next v2 1/4] wifi: rtw88: sdio: Check the HISR RX_REQUEST bit in rtw_sdio_rx_isr()
References: <20230522202425.1827005-2-martin.blumenstingl@googlemail.com>
        <168503099830.22756.1444846830853755949.kvalo@kernel.org>
        <CAPDyKFr5X+rhx=0mUiy_w0Aik9re5WD71xn-H_hrbTDR1L08ww@mail.gmail.com>
Date:   Fri, 26 May 2023 17:14:07 +0300
In-Reply-To: <CAPDyKFr5X+rhx=0mUiy_w0Aik9re5WD71xn-H_hrbTDR1L08ww@mail.gmail.com>
        (Ulf Hansson's message of "Fri, 26 May 2023 15:11:24 +0200")
Message-ID: <87ttvzji34.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ulf Hansson <ulf.hansson@linaro.org> writes:

> On Thu, 25 May 2023 at 18:10, Kalle Valo <kvalo@kernel.org> wrote:
>
>>
>> Martin Blumenstingl <martin.blumenstingl@googlemail.com> wrote:
>>
>> > rtw_sdio_rx_isr() is responsible for receiving data from the wifi chip
>> > and is called from the SDIO interrupt handler when the interrupt status
>> > register (HISR) has the RX_REQUEST bit set. After the first batch of
>> > data has been processed by the driver the wifi chip may have more data
>> > ready to be read, which is managed by a loop in rtw_sdio_rx_isr().
>> >
>> > It turns out that there are cases where the RX buffer length (from the
>> > REG_SDIO_RX0_REQ_LEN register) does not match the data we receive. The
>> > following two cases were observed with a RTL8723DS card:
>> > - RX length is smaller than the total packet length including overhead
>> >   and actual data bytes (whose length is part of the buffer we read from
>> >   the wifi chip and is stored in rtw_rx_pkt_stat.pkt_len). This can
>> >   result in errors like:
>> >     skbuff: skb_over_panic: text:ffff8000011924ac len:3341 put:3341
>> >   (one case observed was: RX buffer length = 1536 bytes but
>> >    rtw_rx_pkt_stat.pkt_len = 1546 bytes, this is not valid as it means
>> >    we need to read beyond the end of the buffer)
>> > - RX length looks valid but rtw_rx_pkt_stat.pkt_len is zero
>> >
>> > Check if the RX_REQUEST is set in the HISR register for each iteration
>> > inside rtw_sdio_rx_isr(). This mimics what the RTL8723DS vendor driver
>> > does and makes the driver only read more data if the RX_REQUEST bit is
>> > set (which seems to be a way for the card's hardware or firmware to
>> > tell the host that data is ready to be processed).
>> >
>> > For RTW_WCPU_11AC chips this check is not needed. The RTL8822BS vendor
>> > driver for example states that this check is unnecessary (but still uses
>> > it) and the RTL8822CS drops this check entirely.
>> >
>> > Reviewed-by: Ping-Ke Shih <pkshih@realtek.com>
>> > Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
>>
>> 4 patches applied to wireless-next.git, thanks.
>>
>> e967229ead0e wifi: rtw88: sdio: Check the HISR RX_REQUEST bit in rtw_sdio_rx_isr()
>> 9be20a822327 wifi: rtw88: rtw8723d: Implement RTL8723DS (SDIO) efuse parsing
>> 09fcdbd28404 mmc: sdio: Add/rename SDIO ID of the RTL8723DS SDIO wifi cards
>> a3b125ceb45e wifi: rtw88: Add support for the SDIO based RTL8723DS chipset
>
> If it's not too late, feel free to add my ack for patch3. Nevermind,
> if it adds additional work for you.

We don't rebase wireless trees so I can't add it anymore, sorry. But
thanks for reviewing it.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
