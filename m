Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8792E702AFC
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 13:00:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240385AbjEOLAA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 07:00:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229963AbjEOK75 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 06:59:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A76F912E;
        Mon, 15 May 2023 03:59:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3C9D86227C;
        Mon, 15 May 2023 10:59:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C90AC433D2;
        Mon, 15 May 2023 10:59:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684148395;
        bh=aaXWGFW+W+Mx8ejKT43D62hQkzh/cnrA202CHaOIB0E=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=cinKTZS02ZdwiyFq5/nt+Upe7lCXbgUPqNR9AhZfckd5rzhO9QU90GgbLvZ4QWbko
         vsg5v4oexO+PPAMxwfq+YTRH9+gxeOjz2FD09+GrTQRIVcwge7tqqcp00K7T8USMTV
         0AWv6mjVF80KB8jSRtW2wRP19BRqKUIy4qg3hkrQdUaO5GSksoBRGT0NNG2+PJ8wLN
         Mr1eZ1BSKharxEFkA84pNQFgURked16MwqWgvr52X83oh1qIeLEW8p4SWweB9qSMTQ
         mWGT4tBfWfeEFn4gTzjum8kKPk57568J3O6mrFyS5UB3iOerxhYppqTLpr/gf/V3lp
         zQ6XS1PjNeDUg==
From:   Kalle Valo <kvalo@kernel.org>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        "linux-wireless\@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tony0620emma\@gmail.com" <tony0620emma@gmail.com>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Rudi Heitbaum <rudi@heitbaum.com>
Subject: Re: [PATCH wireless v1] wifi: rtw88: sdio: Always use two consecutive bytes for word operations
References: <20230514200345.502807-1-martin.blumenstingl@googlemail.com>
        <a0bf69fdb10b42a989a9b14e490e2f07@realtek.com>
Date:   Mon, 15 May 2023 13:59:50 +0300
In-Reply-To: <a0bf69fdb10b42a989a9b14e490e2f07@realtek.com> (Ping-Ke Shih's
        message of "Mon, 15 May 2023 00:36:27 +0000")
Message-ID: <87mt25n9ll.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> writes:

>> -----Original Message-----
>> From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
>> Sent: Monday, May 15, 2023 4:04 AM
>> To: linux-wireless@vger.kernel.org
>> Cc: linux-kernel@vger.kernel.org; Ping-Ke Shih <pkshih@realtek.com>; tony0620emma@gmail.com;
>> kvalo@kernel.org; Martin Blumenstingl <martin.blumenstingl@googlemail.com>; Larry Finger
>> <Larry.Finger@lwfinger.net>; Rudi Heitbaum <rudi@heitbaum.com>
>> Subject: [PATCH wireless v1] wifi: rtw88: sdio: Always use two consecutive bytes for word operations
>> 
>> The Allwinner sunxi-mmc controller cannot handle word (16 bit)
>> transfers. So and sdio_{read,write}w fails with messages like the
>> following example using an RTL8822BS (but the same problems were also
>> observed with RTL8822CS and RTL8723DS chips):
>>   rtw_8822bs mmc1:0001:1: Firmware version 27.2.0, H2C version 13
>>   sunxi-mmc 4021000.mmc: unaligned scatterlist: os f80 length 2
>>   sunxi-mmc 4021000.mmc: map DMA failed
>>   rtw_8822bs mmc1:0001:1: sdio read16 failed (0x10230): -22
>> 
>> Use two consecutive single byte accesses for word operations instead. It
>> turns out that upon closer inspection this is also what the vendor
>> driver does, even though it does have support for sdio_{read,write}w. So
>> we can conclude that the rtw88 chips do support word access but only on
>> SDIO controllers that also support it. Since there's no way to detect if
>> the controller supports word access or not the rtw88 sdio driver
>> switches to the easiest approach: avoiding word access.
>> 
>> Reported-by: Larry Finger <Larry.Finger@lwfinger.net>
>> Closes: https://lore.kernel.org/linux-wireless/527585e5-9cdd-66ed-c3af-6da162f4b720@lwfinger.net/
>
> "Closes:" seems not a regular tag. Use "Link: " instead.

Actually the documentation now talks about Closes tag:

https://docs.kernel.org/process/5.Posting.html#patch-formatting-and-changelogs

I guess this tag is a recent addition?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
