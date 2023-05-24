Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88EAE70F08E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 10:24:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbjEXIYL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 04:24:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234171AbjEXIYG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 04:24:06 -0400
Received: from smtp.tom.com (smtprz25.163.net [106.38.219.110])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B67E612B
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 01:24:04 -0700 (PDT)
Received: from my-app02.tom.com (my-app02.tom.com [127.0.0.1])
        by freemail02.tom.com (Postfix) with ESMTP id 72110B00D37
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 16:24:01 +0800 (CST)
Received: from my-app02.tom.com (HELO smtp.tom.com) ([127.0.0.1])
          by my-app02 (TOM SMTP Server) with SMTP ID 594827488
          for <linux-kernel@vger.kernel.org>;
          Wed, 24 May 2023 16:24:01 +0800 (CST)
Received: from antispam1.tom.com (unknown [172.25.16.55])
        by freemail02.tom.com (Postfix) with ESMTP id 4ACE0B00CBF
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 16:24:01 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tom.com; s=201807;
        t=1684916641; bh=pK9utf2+TTB2BqTHLR4D+VpjAz3YXX/EvXNU8ORYyBA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=GCud4YdqwTMexDSYQqxCH8FlFCFY1dorSiB2ryCn9qCth6ORu8ATRqnXN9M5u6H4K
         AwoIsVGUBm3huzLaXHKErGXzmY6tBLwP6JyxTNjJG5/xGrknPvlmUodmsZhNg7v751
         jB/DuAKjmDD4WPAXm611b8F6Zmhld0R0aU6qYePg=
Received: from antispam1.tom.com (antispam1.tom.com [127.0.0.1])
        by antispam1.tom.com (Postfix) with ESMTP id 3190FD41AD1
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 16:24:01 +0800 (CST)
X-Virus-Scanned: Debian amavisd-new at antispam1.tom.com
Received: from antispam1.tom.com ([127.0.0.1])
        by antispam1.tom.com (antispam1.tom.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id VmGR4O6u3zn3 for <linux-kernel@vger.kernel.org>;
        Wed, 24 May 2023 16:24:00 +0800 (CST)
Received: from [172.30.38.103] (unknown [180.167.10.98])
        by antispam1.tom.com (Postfix) with ESMTPA id 99329D416F1;
        Wed, 24 May 2023 16:23:57 +0800 (CST)
Message-ID: <5e03a89f-726d-9351-6235-9b610e8a9389@tom.com>
Date:   Wed, 24 May 2023 16:23:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] media: dvb_ringbuffer: Return -EFAULT if copy fails
Content-Language: en-US
To:     Dan Carpenter <dan.carpenter@linaro.org>,
        Su Hui <suhui@nfschina.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        YongSu Yoo <yongsuyoo0215@gmail.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
References: <41a9c6a6-4b9a-4d84-9e32-09bf64c65b6c@kili.mountain>
 <aab14cc4-0400-c114-f180-6db943fd7e32@nfschina.com>
 <7466fead-1b99-4a78-86cb-5dd8a9baec19@kili.mountain>
From:   Longsuhui <Jack_sun@tom.com>
In-Reply-To: <7466fead-1b99-4a78-86cb-5dd8a9baec19@kili.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/5/24 15:20, Dan Carpenter wrote:
> On Wed, May 24, 2023 at 01:20:27PM +0800, Su Hui wrote:
>> It's confusing about the comment on function declaration.
>>
>>      /**
>>       * dvb_ringbuffer_write_user - Writes a buffer received via a user
>> pointer
>>
>>      ..........
>>
>>       * Return: number of bytes transferred or -EFAULT
>>
>> But the function Only returns  the number of bytes transferred.
>>
>> Maybe the comment should be modified because it never returns -EFAULT.
> To be honest, I think that -EFAULT is probably a better return.  But
> there is no way we could apply the patch with that commit message.  The
> commit message doesn't explain the problem for the user or why returning
> the number of bytes copied is not correct in this case.
>
> I think that maybe it's not too late to change this to return -EFAULT,
> but it would have been easier to make the change in 2014 before there
> were many users.  Also it would be easier if you were testing this on
> real hardware.
>
> Possibly other people think the current behavior is correct or that it
> is too late to change it.  That's also fine.  I'm not a domain expert
> here.
I understand it.
Thanks a lot!

Su Hui

>
> regards,
> dan carpenter
>
