Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 119A870ECFF
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 07:20:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239311AbjEXFUv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 01:20:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239325AbjEXFUk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 01:20:40 -0400
Received: from mail.nfschina.com (unknown [42.101.60.195])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id CC5A41A1;
        Tue, 23 May 2023 22:20:31 -0700 (PDT)
Received: from [172.30.38.103] (unknown [180.167.10.98])
        by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPSA id 0F5CD1800E974C;
        Wed, 24 May 2023 13:20:27 +0800 (CST)
Message-ID: <aab14cc4-0400-c114-f180-6db943fd7e32@nfschina.com>
Date:   Wed, 24 May 2023 13:20:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] media: dvb_ringbuffer: Return -EFAULT if copy fails
Content-Language: en-US
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        YongSu Yoo <yongsuyoo0215@gmail.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
X-MD-Sfrom: suhui@nfschina.com
X-MD-SrcIP: 180.167.10.98
From:   Su Hui <suhui@nfschina.com>
In-Reply-To: <41a9c6a6-4b9a-4d84-9e32-09bf64c65b6c@kili.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2023/5/24 12:47, Dan Carpenter wrote:
> On Wed, May 24, 2023 at 07:23:45AM +0300, Dan Carpenter wrote:
>> On Wed, May 24, 2023 at 09:27:33AM +0800, Su Hui wrote:
>>> The copy_to/from_user() functions return the number of bytes remaining
>>> to be copied, but we want to return -EFAULT to the user.
>>>
> So basically these bugs are caused because people are used to functions
> returning negative error codes and they write some form of:
>
> 	ret = copy_from_user();
> 	if (ret)
> 		return ret;
>
> If you look at the code and you think, "They author thinks 'ret' is
> negative" then probably it is a bug.  The common false positives are
> in the core kernel where it does:
>
> 	return copy_from_user();
>
> and the caller checks:
>
> 	if (function_one() || function_two() || function_three())
> 		return -EFAULT;
>
> Those are done because it's a fast path and adding a lot of if
> statements would slow things down.  Driver code tends not to do this
> because normally drivers are not so performance sensitive and it's more
> important to be readable.
>
> So you have to look at the context a bit.

Thanks very much for your suggestion.

It's confusing about the comment on function declaration.

     /**
      * dvb_ringbuffer_write_user - Writes a buffer received via a user 
pointer

     ..........

      * Return: number of bytes transferred or -EFAULT

But the function Only returns  the number of bytes transferred.

Maybe the comment should be modified because it never returns -EFAULT.

I will look at the context more carefully next time , thanks again!

Su Hui

> regards,
> dan carpenter
>
