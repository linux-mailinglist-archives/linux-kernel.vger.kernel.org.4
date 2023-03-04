Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 195B96AA62A
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Mar 2023 01:14:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbjCDAO0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 19:14:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjCDAOY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 19:14:24 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDD4425942
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 16:14:23 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1677888862;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rInuCI68a4gdGU88nDCyCf85QaUl4rAnsKIg8HYLARc=;
        b=DIbcQO7UtCgNcvC+8wi8VNaJ8WA1Jy8bVV7XYVjV41sGPWA4e/xXT022K0DdYFrTVsKdlA
        c9oiZXHT4kKxc9KhAvsrHFt83viUSpYIePdP+CZAT4WQE/LKcaGIINBPgGdVf9tekSGppK
        cFUg1xvo1Sq5cndTb0JURphfh/yKsnNb0X3Ccoygvb0TAXo+C8Z8MP5Vz84Y6zzplUuUEd
        ZvvE+A2OlcBnL9/mjrD0IzguGtHRDg6lVUe6Vxskp7CewinX3J43yEhkZL1K/RLuvZgJXs
        HD4G+FuvtPNY3NpBZ2yqRmGo3BcY2vUgXFoUDzMMEKS5hCPX92pHRyibc+WV0w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1677888862;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rInuCI68a4gdGU88nDCyCf85QaUl4rAnsKIg8HYLARc=;
        b=DLkFMZCrd7nbwHPA7T2QQMITWUhZRaOjblBGo95kUON0ORBI5BeKhNcqM2CdZuKr/iZRlO
        PNwtxL4srxivfwDQ==
To:     Schspa Shi <schspa@gmail.com>, Waiman Long <longman@redhat.com>
Cc:     swboyd@chromium.org, linux@roeck-us.net, wuchi.zero@gmail.com,
        linux-kernel@vger.kernel.org,
        syzbot+5093ba19745994288b53@syzkaller.appspotmail.com
Subject: Re: [PATCH 1/2] debugobject: fix concurrency issues with
 is_static_object
In-Reply-To: <m2a60t67nb.fsf@gmail.com>
References: <20230303161906.831686-1-schspa@gmail.com>
 <814636e6-9a8a-9ab1-03a0-ed3702024227@redhat.com>
 <m2a60t67nb.fsf@gmail.com>
Date:   Sat, 04 Mar 2023 01:14:21 +0100
Message-ID: <875ybhjrtu.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 04 2023 at 01:53, Schspa Shi wrote:
> Waiman Long <longman@redhat.com> writes:
>>> diff --git a/include/linux/debugobjects.h b/include/linux/debugobjects.h
>>> index 32444686b6ff4..544a6111b97f6 100644
>>> --- a/include/linux/debugobjects.h
>>> +++ b/include/linux/debugobjects.h
>>> @@ -30,6 +30,7 @@ struct debug_obj {
>>>   	enum debug_obj_state	state;
>>>   	unsigned int		astate;
>>>   	void			*object;
>>> +	bool			is_static;
>>>   	const struct debug_obj_descr *descr;
>>>   };
>>
>> The patch looks reasonable. My main concern is the increase in size of the
>> debug_obj structure. It is an additional 8 bytes on 64-bit arches. How much will
>> we save performance-wise by caching it in the debug_obj. Alternatively, you may
>> pack it within the current size by, maybe, reducing the size of state.
>>
>
> Yes, we can change this to:
>
> struct debug_obj {
> 	struct hlist_node	node;
> 	struct {
> 		enum debug_obj_state	state : 31;
> 		bool					is_static : 1;
> 	};

and thereby making debugobjects even more slower than it is right
now. Please check the resulting assembly code before proposing quick
"solutions".

Thanks,

        tglx
