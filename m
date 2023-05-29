Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E12771418B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 03:08:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230158AbjE2BI3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 May 2023 21:08:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbjE2BI1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 May 2023 21:08:27 -0400
Received: from smtp.tom.com (smtprz25.163.net [106.38.219.110])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97B5BC6
        for <linux-kernel@vger.kernel.org>; Sun, 28 May 2023 18:08:25 -0700 (PDT)
Received: from my-app02.tom.com (my-app02.tom.com [127.0.0.1])
        by freemail02.tom.com (Postfix) with ESMTP id 25DB6B00D36
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 09:08:23 +0800 (CST)
Received: from my-app02.tom.com (HELO smtp.tom.com) ([127.0.0.1])
          by my-app02 (TOM SMTP Server) with SMTP ID 1163715245
          for <linux-kernel@vger.kernel.org>;
          Mon, 29 May 2023 09:08:23 +0800 (CST)
Received: from antispam1.tom.com (unknown [172.25.16.55])
        by freemail02.tom.com (Postfix) with ESMTP id 02F93B00CBF
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 09:08:23 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tom.com; s=201807;
        t=1685322503; bh=6+v18S+49ZmwsY7ArmeI7lTtnBWs6GUHMqy2kd4a530=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=U4Dirvv/EZFAPQ+x73uw0d8AefzdCJte43iKWsUQ+MZ2AG6Dveu6l1vyxezkJAIir
         q31Ve0Z2zAwcYS2wapMc0GwYJf0yjM35Zy6PWFD9ZYMvMBjpdCxkDlzd2BLXdAh+vd
         IW0qTSLMxhZy4BrL7/Wy6IgrK5cMoP0KPyM8qAAU=
Received: from antispam1.tom.com (antispam1.tom.com [127.0.0.1])
        by antispam1.tom.com (Postfix) with ESMTP id E4DD6D41A0E
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 09:08:22 +0800 (CST)
X-Virus-Scanned: Debian amavisd-new at antispam1.tom.com
Received: from antispam1.tom.com ([127.0.0.1])
        by antispam1.tom.com (antispam1.tom.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id whFHpQwnbI_G for <linux-kernel@vger.kernel.org>;
        Mon, 29 May 2023 09:08:19 +0800 (CST)
Received: from [172.30.38.103] (unknown [180.167.10.98])
        by antispam1.tom.com (Postfix) with ESMTPA id F3F90D416AE;
        Mon, 29 May 2023 09:08:18 +0800 (CST)
Message-ID: <65d4f191-6823-b65e-c570-4180993c67f3@tom.com>
Date:   Mon, 29 May 2023 09:08:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] media: dvb_ringbuffer: Return -EFAULT if copy fails
Content-Language: en-US
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     YongSu Yoo <yongsuyoo0215@gmail.com>, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Dan Carpenter <dan.carpenter@linaro.org>
References: <41a9c6a6-4b9a-4d84-9e32-09bf64c65b6c@kili.mountain>
 <aab14cc4-0400-c114-f180-6db943fd7e32@nfschina.com>
 <7466fead-1b99-4a78-86cb-5dd8a9baec19@kili.mountain>
 <20230526114539.0520dcbf@sal.lan>
From:   Longsuhui <Jack_sun@tom.com>
In-Reply-To: <20230526114539.0520dcbf@sal.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/5/26 18:45, Mauro Carvalho Chehab wrote:
> Em Wed, 24 May 2023 10:20:38 +0300
> Dan Carpenter <dan.carpenter@linaro.org> escreveu:
>
>> On Wed, May 24, 2023 at 01:20:27PM +0800, Su Hui wrote:
>>> It's confusing about the comment on function declaration.
>>>
>>>      /**
>>>       * dvb_ringbuffer_write_user - Writes a buffer received via a user
>>> pointer
>>>
>>>      ..........
>>>
>>>       * Return: number of bytes transferred or -EFAULT
>>>
>>> But the function Only returns  the number of bytes transferred.
>>>
>>> Maybe the comment should be modified because it never returns -EFAULT.
>> To be honest, I think that -EFAULT is probably a better return.  But
>> there is no way we could apply the patch with that commit message.  The
>> commit message doesn't explain the problem for the user or why returning
>> the number of bytes copied is not correct in this case.
>>
>> I think that maybe it's not too late to change this to return -EFAULT,
>> but it would have been easier to make the change in 2014 before there
>> were many users.  Also it would be easier if you were testing this on
>> real hardware.
> It is too late to change the API here, as this could break userspace.
>
> Basically, DVB subsystem normally works with a Kernel-implemented ringbuffer
> that transfers MPEG TS data between kernelspace/userspace. The size is
> set via an ioctl (DMX_SET_BUFFER_SIZE). By the way, such uAPI is older
> than 2014. It was added upstream on Kernel 2.6.
>
> The buffer size is usually big. For instance, dvbv5-zap uses:
>
> 	#define DVB_BUF_SIZE      (4096 * 8 * 188)
>
> The normal operation is that data will be received from a MPEG-TS
> stream, although it is also possible to send data on cable TV, when
> using dvb net interface.
>
> While on several boards, the hardware<->kernel transfer happens on
> 188-bytes packages, there are some hardware out there where the
> data passed from/to kernel is not 188-bytes aligned.
>
> The normal operation (receiving a TV broadcast) means that the Kernel
> will be filling a ringbuffer containing the data passed from the
> hardware. The size of the such buffer is adjusted via DMX_SET_BUFFER_SIZE
> and contains MPEG TS packets of 188-bytes. Userspace will be in an
> endless loop that will be waiting for data to arrive at the ringbuffer,
> copying received data its own userspace buffer. If the buffer is not set
> to a multiple of 188, it should be up to userspace to handle incomplete
> frames. The same occurs if the data is 204-bytes aligned. Btw, userspace
> can detect the packet size, based on the frame content.
>
> On such example, if a ringbuffer transfer would be passing 1554 bytes,
> it means that 8 MPEG-TS frames are complete, and that 50 bytes of the
> next frame was also transfered from/to userspace.
>
> It should be up to userspace to ensure that those extra 50 bytes will
> be probably taken into account by the application and ensure that the
> remaining 138 bytes will be handled at the next from/to userspace
> data transfer.
>
> Not the best API, but any change there will break userspace.
>
> In particular, this patch will completely break transfers if the
> buffer size is not 188-bytes aligned.
>
> so,
>
> NACK.
>
> Su,
>
> Did you find any real problem with this? On what hardware/application?
There is no real problem with this.
I understand, and this patch is wrong.
Sorry to bother you.

Su Hui

>
> Regards,
> Mauro
>
