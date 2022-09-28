Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 454375EE0CA
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 17:46:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233659AbiI1PqE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 11:46:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233391AbiI1Pp7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 11:45:59 -0400
Received: from smtp120.iad3b.emailsrvr.com (smtp120.iad3b.emailsrvr.com [146.20.161.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21E6152450
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 08:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
        s=20190130-41we5z8j; t=1664379954;
        bh=cx1KiCPdhE7cEd0dCaeLcbQpUa9d0MElYOPJrTQ8KKo=;
        h=Date:Subject:To:From:From;
        b=erOED7hHCjEkkIlXyRcZvENhQrxFc3qQXa7Eey+KzQyH3HbIdKM7uGBWXkYV0BlRA
         jiAlSmXrtNePWrUUOfcxzTD4VBAg5CtiFyynwKxxuBUitrNQEC3jp1Ff1Lo5BZrDN4
         N/EkSSvEjO7ohe9OB5oDJ98pnHdcSbD7Ep2aijuc=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp24.relay.iad3b.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id DA102401A5;
        Wed, 28 Sep 2022 11:45:53 -0400 (EDT)
Message-ID: <041a4643-decf-55fe-90a4-4728fc029220@mev.co.uk>
Date:   Wed, 28 Sep 2022 16:45:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH 1/7] comedi: Convert snprintf() to scnprintf()
To:     Greg KH <gregkh@linuxfoundation.org>,
        Jules Irenge <jbi.octave@gmail.com>
Cc:     hsweeten@visionengravers.com, linux-kernel@vger.kernel.org
References: <YzHxcb5VzWeSNKo0@fedora> <YzKS/3z2cQsFFfxD@kroah.com>
Content-Language: en-GB
From:   Ian Abbott <abbotti@mev.co.uk>
Organization: MEV Ltd.
In-Reply-To: <YzKS/3z2cQsFFfxD@kroah.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Classification-ID: 233e4c96-ebf3-4f29-912e-a7fa774859fe-1-1
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/09/2022 07:06, Greg KH wrote:
> On Mon, Sep 26, 2022 at 07:37:37PM +0100, Jules Irenge wrote:
>> Coccinnelle reports a warning
>> Warning: Use scnprintf or sprintf
>> Adding to that, there has been a slow migration from snprintf to scnprintf.
>> This LWN article explains the rationale for this change
>> https: //lwn.net/Articles/69419/
>> Ie. snprintf() returns what *would* be the resulting length,
>> while scnprintf() returns the actual length.
>>
>> Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
>> ---
>>   drivers/comedi/comedi_fops.c | 8 ++++----
>>   1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/comedi/comedi_fops.c b/drivers/comedi/comedi_fops.c
>> index 55a0cae04b8d..e8a0142d5894 100644
>> --- a/drivers/comedi/comedi_fops.c
>> +++ b/drivers/comedi/comedi_fops.c
>> @@ -396,7 +396,7 @@ static ssize_t max_read_buffer_kb_show(struct device *csdev,
>>   	mutex_unlock(&dev->mutex);
>>   
>>   	comedi_dev_put(dev);
>> -	return snprintf(buf, PAGE_SIZE, "%u\n", size);
>> +	return scnprintf(buf, PAGE_SIZE, "%u\n", size);
> 
> Ick, no, you should use sysfs_emit() if you really want to change these
> functions to "do the right thing".

There was a patch to do that by Xuezhi Zhang.  It got to PATCH v4.  I 
should have replied with a "Reviewed-By" tag, but I'd already done that 
for the earlier versions.

https://lore.kernel.org/lkml/20220901013423.418464-1-zhangxuezhi3@gmail.com/

-- 
-=( Ian Abbott <abbotti@mev.co.uk> || MEV Ltd. is a company  )=-
-=( registered in England & Wales.  Regd. number: 02862268.  )=-
-=( Regd. addr.: S11 & 12 Building 67, Europa Business Park, )=-
-=( Bird Hall Lane, STOCKPORT, SK3 0XA, UK. || www.mev.co.uk )=-
