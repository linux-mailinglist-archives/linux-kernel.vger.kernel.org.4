Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CDA2652038
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 13:12:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230238AbiLTMMS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 07:12:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229827AbiLTMMN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 07:12:13 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A967186D0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 04:12:09 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B44E475BE1;
        Tue, 20 Dec 2022 12:12:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1671538328; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zInJCrnP9Q15J8+sxqGGs3MW8bZCld6DrfyEqo4NzTo=;
        b=zrs/ggIWxaRTJZ/Nv3X5Ww8zkI3zElv73OkqJMfJUlngk1QJwK9SeHsL2S/qnHsN8M19KD
        pTjx7azZRy4uFD7zr6qU7H+81IVfHrk6hf/MZCF7axZeS9bFz7k4QMmPiHkJsCzOY4Cqag
        hDWf/5+583OzosNR21su6Q3ndKRzCOo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1671538328;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zInJCrnP9Q15J8+sxqGGs3MW8bZCld6DrfyEqo4NzTo=;
        b=u0UQ6+BP0IfvVrDXqaJBTNq5hYJAoY18qKdd2EaG2Oi1panNXoOiMdx2DSP8OeDiK89ETF
        UtX4nRloxcd5b9DA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9B46213254;
        Tue, 20 Dec 2022 12:12:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 1RjwJJimoWNIawAAMHmgww
        (envelope-from <mliska@suse.cz>); Tue, 20 Dec 2022 12:12:08 +0000
Message-ID: <098a2144-e2e0-4235-a401-fbff83fe8087@suse.cz>
Date:   Tue, 20 Dec 2022 13:12:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] gcov: Add support for checksum field
To:     Peter Oberparleiter <oberpar@linux.ibm.com>,
        Rickard Andersson <rickaran@axis.com>,
        linux-kernel@vger.kernel.org
Cc:     rickard314.andersson@gmail.com
References: <20221219150621.3310033-1-rickaran@axis.com>
 <1da3f764-4445-2135-3292-2912c2e8e778@linux.ibm.com>
Content-Language: en-US
From:   =?UTF-8?Q?Martin_Li=c5=a1ka?= <mliska@suse.cz>
In-Reply-To: <1da3f764-4445-2135-3292-2912c2e8e778@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/19/22 17:48, Peter Oberparleiter wrote:
> On 19.12.2022 16:06, Rickard Andersson wrote:
>> From: Rickard x Andersson <rickaran@axis.com>
>>
>> In GCC version 12.1 a checksum field was added.
> 
> Thanks for the patch!
> 
> In another e-mail you mentioned that this patch fixes a kernel crash
> during boot when using gcov-kernel with GCC 12. Please add this
> information to the commit message and if possible the platform on which
> this occurs.
> 
> Also this patch fixes a missing piece from a previous patch, so please add:
> 
> Fixes: 977ef30a7d88 ("gcov: support GCC 12.1 and newer compilers")
> Cc: <stable@vger.kernel.org>
> 
> Finally I reviewed and tested the patch and it looks good to me, so
> please add:
> 
> Reviewed-by: Peter Oberparleiter <oberpar@linux.ibm.com>
> Tested-by: Peter Oberparleiter <oberpar@linux.ibm.com>
> 
> Please resend with these commit message changes. Thanks!
> 
> For the record: I wondered why my testing of the previous patch with GCC
> 12 didn't catch this. It turns out that this crash does not occur on
> architectures with 8-byte pointer alignment such as s390x where I
> performed my tests. Consider this pahole output on s390x without the patch:
> 
> struct gcov_info {
> [...]
>         unsigned int       stamp;                /*    16     4 */
>         /* XXX 4 bytes hole, try to pack */
>         const char  *      filename;             /*    24     8 */
> [...]
> }
> 
> And with the patch:
> 
> struct gcov_info {
> [...]
>        unsigned int       stamp;                /*    16     4 */
>        unsigned int       checksum;             /*    20     4 */
>        const char  *      filename;             /*    24     8 */
> [...]
> }
> 
> As can be seen, the offset of the filename and subsequent fields does
> not change because the new field fills an alignment hole. It would
> change (resulting in a crash during boot) if the alignment-requirement
> of the const char *filename field would be different.

Hello.

Thank you Peter for the deep analysis and it finally explains why I didn't notice
while I was working on 977ef30a7d88.

Please add my review:

Reviewed-By: Martin Liska <mliska@suse.cz>

Thanks,
Martin

> 
>>
>> Signed-off-by: Rickard x Andersson <rickaran@axis.com>
>> ---
>>  kernel/gcov/gcc_4_7.c | 5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/kernel/gcov/gcc_4_7.c b/kernel/gcov/gcc_4_7.c
>> index c699feda21ac..04880d8fba25 100644
>> --- a/kernel/gcov/gcc_4_7.c
>> +++ b/kernel/gcov/gcc_4_7.c
>> @@ -85,6 +85,7 @@ struct gcov_fn_info {
>>   * @version: gcov version magic indicating the gcc version used for compilation
>>   * @next: list head for a singly-linked list
>>   * @stamp: uniquifying time stamp
>> + * @checksum: unique object checksum
>>   * @filename: name of the associated gcov data file
>>   * @merge: merge functions (null for unused counter type)
>>   * @n_functions: number of instrumented functions
>> @@ -97,6 +98,10 @@ struct gcov_info {
>>  	unsigned int version;
>>  	struct gcov_info *next;
>>  	unsigned int stamp;
>> + /* Since GCC 12.1 a checksum field is added. */
>> +#if (__GNUC__ >= 12)
>> +	unsigned int checksum;
>> +#endif
>>  	const char *filename;
>>  	void (*merge[GCOV_COUNTERS])(gcov_type *, unsigned int);
>>  	unsigned int n_functions;
> 

