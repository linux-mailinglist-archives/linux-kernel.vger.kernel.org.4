Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3C7E68B1A3
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Feb 2023 21:41:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbjBEUla (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Feb 2023 15:41:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbjBEUl2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Feb 2023 15:41:28 -0500
Received: from mx.flying-snail.de (mx.flying-snail.de [IPv6:2a06:1c40:3::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D46118B30;
        Sun,  5 Feb 2023 12:41:25 -0800 (PST)
Received: from [2a02:908:1b0:8800:2ff:ffff:fe11:2236] (helo=mondbasis.internal.flying-snail.de)
        by mx.flying-snail.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <pelzi@flying-snail.de>)
        id 1pOlp7-001mf8-Of; Sun, 05 Feb 2023 21:41:17 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=feldner-bv.de; s=s1; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=whm/UpYPY/Ro6ni+3/73Hsptp6MyxuBrrlblU/0ZqZg=; b=kVBbypM1wiI+90196dXqmAXD5w
        sEloqiGGWt3t+JsWO7K2PPhuRMEFKPyo9pXLHk8A/iAYxqIXRbETPwA6Yxi7i9da4B0lIxBnp33iK
        /DHtOMyycQ53Evf1+sh7QhWuSTYLMujuFVXgz9zB3fV+yO59jPeOXZhX52ic6gTx3+oVQGYi2N9+e
        8Zc87Z/3XseI9lSwejcR8ZLe8m7EP6vaddQ4eYGTBK023n746eCSV7K01fNCqIvoBUkeV/Aa5E1pF
        lHd6XR3hoI8x8MjJcZU67Q8P498Suzt2N07ST7OKz5xJF/bG+Z57Cg5zmpTftkxFJvKnjBF/CBjzv
        PMUpMdQQ==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=flying-snail.de; s=s1; h=Content-Transfer-Encoding:Content-Type:In-Reply-To
        :From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=whm/UpYPY/Ro6ni+3/73Hsptp6MyxuBrrlblU/0ZqZg=; b=E5CD8DrgTwBwai84RQwqe8TttP
        amGy2OUCM3+2QfTdaCCF65nR2wSkgpR1aqsIXggKoFMRzI90gbB/3EQmTWBO6+n+Q4WPJtYuZFNlz
        eSZiSYpmB4tgep6MAGqfVjtGBe6BmxKui9hWHJ59DjzJb61AgQMfA8zHrso3jsUY+WoRJVmcA/5ha
        z3GHYFt1O9oEfn5rGhTWLnmQjewxZsJAHHKTmrtrxetFvhfja6nOKfUDmhBm1VGUDSWUc6C68PpBS
        r+N/yvT1PopdJPr/NvNdQ3bfbCkx1gCVoCds2ebXn3Y7VtbDKtvTrB506pKN1PgMrpIbTK6XgmoJh
        QBWcCIqA==;
Received: from [2a02:908:1b0:8800:1554:6239:a4eb:816f]
        by mondbasis.internal.flying-snail.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <pelzi@flying-snail.de>)
        id 1pOlp1-000dX8-1C; Sun, 05 Feb 2023 21:41:16 +0100
Message-ID: <e1acd14e-400b-8896-bdc1-0b364cc52198@feldner-bv.de>
Date:   Sun, 5 Feb 2023 21:41:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH] iio: dht11: Read bit stream from IRQ on falling edges
 only
To:     harald@ccbib.org, Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <Y9a0RZ+inWs44Kn8@debian-qemu.internal.flying-snail.de>
 <20230130202216.42034309@jic23-huawei>
 <45efc11e5b4cdba3766f19190bb65840@ccbib.org>
From:   pelzi@flying-snail.de
In-Reply-To: <45efc11e5b4cdba3766f19190bb65840@ccbib.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Following up on Harald's remark, I can provide some first comparison 
data indeed:

Am 31.01.23 um 10:44 schrieb harald@ccbib.org:
> This seems like a really small benefit. And we would lose the
> low state timings in debug output, which I personally find quite
> convenient. Unless there is data, that this change actually improves
> something for somebody, I'd reject it.

Running test script against the original kernel module (see below where 
on):

#     real [s]    user [s]  sys [s]  success fails  err per succ
1     222,068     0,515     0,506     83     96     115,66 %
2     223,152     0,603     0,493     86     99     115,12 %
*3*   223,502     0,563     0,411     91     68     74,73 %
*4*   209,626     0,431     0,189     100    15     15,00 %
*5*   209,689     0,46      0,193     100    19     19,00 %
*6*   220,35      0,413     0,315     100    35     35,00 %


Running the patched module:

# 	Real 	User 	Sys 	Successes 	Failures 	Error rate
1 	223,061 	0,459 	0,258 	88 	25 	28,41 %
2 	222,431 	0,561 	0,367 	75 	57 	76,00 %
3 	225,675 	0,436 	0,178 	92 	19 	20,65 %
4 	222,746 	0,444 	0,194 	98 	23 	23,47 %
5 	222,668 	0,416 	0,205 	97 	20 	20,62 %
*6* 	204,126 	0,34 	0,138 	100 	0 	0,00 %
*7* 	210,495 	0,393 	0,199 	100 	16 	16,00 %
*8* 	212,563 	0,447 	0,139 	100 	19 	19,00 %

All tests run on the same board, Allwinner H3 sold as BananaPi M2 Zero,
under kernel 6.2.0-rc5+. The devicetree overlay is setting the
input-debounce property of &pio to 5µs, or, because of the excessive
error rates of the original driver in this configuration, to 1µs (lines
marked with an asterisk).

The test simply tries to read temperature and humidity from the IIO/dht11
exposed input files every 2 seconds, immediately repeating after an error.

Real/User/Sys is determined by good ol' time command, successes and
failures are counted by the test script.

Two aspects strike:

1) the patched version of the driver is working satisfactory even with
5µs input-debounce filter, where the original driver shows more failed
than successful reads in this configuration.

2) The error rate is consistently lower with the patched driver
(67,9% to 33,8% average)

I believe to see similar results, i.e. a noticable improvement on the error
rate, on my old trusted RaspberryPi 2B (without any devicetree fiddling, of
course), however without quantitative comparison and based on some Raspbian
patch level rather than based on kernel 6.2.0-rc5+.

Of course I have only access to a handful of DHT22 devices, most probably
from the same production batch. But I think at least I'd like to stick
with the patched version, tbh.

Hope this helps, let me know if it'd pay to work on another version of
the patch!

Best wishes

Andreas


