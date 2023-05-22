Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A90070BA3D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 12:35:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232466AbjEVKfO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 06:35:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232377AbjEVKfM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 06:35:12 -0400
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F8AADC
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 03:35:10 -0700 (PDT)
Received: from mail.ispras.ru (unknown [83.149.199.84])
        by mail.ispras.ru (Postfix) with ESMTPSA id 4E18744C1016;
        Mon, 22 May 2023 10:35:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 4E18744C1016
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
        s=default; t=1684751707;
        bh=mSXND4dopui4Y7LqvtuGYun98AfqkQSXgYHcHwjTLcQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=j8IkVeKTt4of7mwQ7PGKXZ+0SOU028M167IWZdutlk0vPKGy8/WLAfT4I/nFza/R4
         NDEpZiQ+AQmIwzRTEvIKztIDm8hIIcOqVZk5HI9pOtOE2iYCGvPunBpbsriUlmUo6P
         v81slCWiU3DxnNt5Nm9yPhg+Al1d0f/LKsCzROGo=
MIME-Version: 1.0
Date:   Mon, 22 May 2023 13:35:07 +0300
From:   Alexey Izbyshev <izbyshev@ispras.ru>
To:     David Hildenbrand <david@redhat.com>
Cc:     Florent Revest <revest@chromium.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, akpm@linux-foundation.org,
        catalin.marinas@arm.com, anshuman.khandual@arm.com,
        joey.gouly@arm.com, mhocko@suse.com, keescook@chromium.org,
        peterx@redhat.com, broonie@kernel.org, szabolcs.nagy@arm.com,
        kpsingh@kernel.org, gthelen@google.com, toiwoton@gmail.com
Subject: Re: [PATCH v2 3/5] mm: Make PR_MDWE_REFUSE_EXEC_GAIN an unsigned long
In-Reply-To: <bb08b91c-6c7b-a7a0-d4a7-68ddea46277f@redhat.com>
References: <20230517150321.2890206-1-revest@chromium.org>
 <20230517150321.2890206-4-revest@chromium.org>
 <bb08b91c-6c7b-a7a0-d4a7-68ddea46277f@redhat.com>
User-Agent: Roundcube Webmail/1.4.4
Message-ID: <884d131bbc28ebfa0b729176e6415269@ispras.ru>
X-Sender: izbyshev@ispras.ru
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-05-22 11:55, David Hildenbrand wrote:
> On 17.05.23 17:03, Florent Revest wrote:
>> Alexey pointed out that defining a prctl flag as an int is a footgun
>> because, under some circumstances, when used as a flag to prctl, it 
>> can
>> be casted to long with garbage upper bits which would result in
>> unexpected behaviors.
>> 
>> This patch changes the constant to a UL to eliminate these
>> possibilities.
>> 
>> Signed-off-by: Florent Revest <revest@chromium.org>
>> Suggested-by: Alexey Izbyshev <izbyshev@ispras.ru>
>> ---
>>   include/uapi/linux/prctl.h       | 2 +-
>>   tools/include/uapi/linux/prctl.h | 2 +-
>>   2 files changed, 2 insertions(+), 2 deletions(-)
>> 
>> diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
>> index f23d9a16507f..6e9af6cbc950 100644
>> --- a/include/uapi/linux/prctl.h
>> +++ b/include/uapi/linux/prctl.h
>> @@ -283,7 +283,7 @@ struct prctl_mm_map {
>>     /* Memory deny write / execute */
>>   #define PR_SET_MDWE			65
>> -# define PR_MDWE_REFUSE_EXEC_GAIN	1
>> +# define PR_MDWE_REFUSE_EXEC_GAIN	(1UL << 0)
>>     #define PR_GET_MDWE			66
>>   diff --git a/tools/include/uapi/linux/prctl.h 
>> b/tools/include/uapi/linux/prctl.h
>> index 759b3f53e53f..6e6563e97fef 100644
>> --- a/tools/include/uapi/linux/prctl.h
>> +++ b/tools/include/uapi/linux/prctl.h
>> @@ -283,7 +283,7 @@ struct prctl_mm_map {
>>     /* Memory deny write / execute */
>>   #define PR_SET_MDWE			65
>> -# define PR_MDWE_REFUSE_EXEC_GAIN	1
>> +# define PR_MDWE_REFUSE_EXEC_GAIN	(1UL << 0)
>>     #define PR_GET_MDWE			66
>> 
> 
> Both are changing existing uapi, so you'll already have existing user
> space using the old values, that your kernel code has to deal with no?

I'm the one who suggested this change, so I feel the need to clarify.

For any existing 64-bit user space code using the kernel and the uapi 
headers before this patch and doing the wrong prctl(PR_SET_MDWE, 
PR_MDWE_REFUSE_EXEC_GAIN) call instead of the correct prctl(PR_SET_MDWE, 
(unsigned long)PR_MDWE_REFUSE_EXEC_GAIN), there are two possibilities 
when prctl() implementation extracts the second argument via va_arg(op, 
unsigned long):

* It gets lucky, and the upper 32 bits of the argument are zero. The 
call does what is expected by the user.

* The upper 32 bits are non-zero junk. The flags argument is rejected by 
the kernel, and the call fails with EINVAL (unexpectedly for the user).

This change is intended to affect only the second case, and only after 
the program is recompiled with the new uapi headers. The currently 
wrong, but naturally-looking prctl(PR_SET_MDWE, 
PR_MDWE_REFUSE_EXEC_GAIN) call becomes correct.

The kernel ABI is unaffected by this change, since it has been defined 
in terms of unsigned long from the start.

Thanks,
Alexey
