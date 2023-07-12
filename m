Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50EBD7503EE
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 11:58:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229475AbjGLJ6F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 05:58:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233202AbjGLJ57 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 05:57:59 -0400
Received: from imap4.hz.codethink.co.uk (imap4.hz.codethink.co.uk [188.40.203.114])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E82E1724;
        Wed, 12 Jul 2023 02:57:58 -0700 (PDT)
Received: from [134.238.52.102] (helo=[10.8.4.22])
        by imap4.hz.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
        id 1qJWbV-00CShV-Ka; Wed, 12 Jul 2023 10:57:50 +0100
Message-ID: <cd21c350-467c-6c77-7e4c-928a3982b5ed@codethink.co.uk>
Date:   Wed, 12 Jul 2023 10:57:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2] ACPI: NFIT: limit string attribute write
Content-Language: en-GB
To:     Dave Jiang <dave.jiang@intel.com>, nvdimm@lists.linux.dev
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        lenb@kernel.org
References: <20230711093708.23692-1-ben.dooks@codethink.co.uk>
 <b17104fe-a743-e933-288b-9245887b3a2c@intel.com>
From:   Ben Dooks <ben.dooks@codethink.co.uk>
Organization: Codethink Limited.
In-Reply-To: <b17104fe-a743-e933-288b-9245887b3a2c@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/07/2023 16:28, Dave Jiang wrote:
> 
> 
> On 7/11/23 02:37, Ben Dooks wrote:
>> If we're writing what could be an arbitrary sized string into an 
>> attribute
>> we should probably use sysfs_emit() just to be safe. Most of the other
>> attriubtes are some sort of integer so unlikely to be an issue so not
>> altered at this time.
>>
>> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
>> ---
>> v2:
>>    - use sysfs_emit() instead of snprintf.
>> ---
>>   drivers/acpi/nfit/core.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
>> index 9213b426b125..d7e9d9cd16d2 100644
>> --- a/drivers/acpi/nfit/core.c
>> +++ b/drivers/acpi/nfit/core.c
>> @@ -1579,7 +1579,7 @@ static ssize_t id_show(struct device *dev,
>>   {
>>       struct nfit_mem *nfit_mem = to_nfit_mem(dev);
>> -    return sprintf(buf, "%s\n", nfit_mem->id);
>> +    return snprintf(buf, PAGE_SIZE, "%s\n", nfit_mem->id);
> 
> Doesn't look like you updated your patch with your new changes....

Ooops, sorry about that. Will sort that for v2++

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius

https://www.codethink.co.uk/privacy.html

