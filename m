Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E42E62E116
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 17:07:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240331AbiKQQHT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 11:07:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240424AbiKQQG5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 11:06:57 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 780247992E
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 08:06:50 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668701208;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LH7PkteBjunaTcVYVshaCNBO+i72KyFfIeTcJ3EfnIU=;
        b=rlueZ7GyrhblHM0fJulaxjkoPhPXhY8eONFWN8rxEu48o12uS+cpGlTruIFwC53Fdw/by9
        tD2SclxGaNAeWbqYtzz6XzCeWEGq7LwmYqW1yPYB28/p66uX9XMswzQp69lyaOX7984IPc
        pPqmT7RVLCGYapiCyY0iq1YQ+b/qoNwQK7Hd9/5lgurqlEoGaoTnj4JyIJoIcbg1T5hTqd
        hLMWx55rRsJCrquCQ3U3XPyIa/Ufqqq8pf/LUJOSfysjZpLeGUaN8ag4YNg+nFoQu+rmJK
        GiHSTtu+Ys0WWMx8pwSlf2WltWA/0T5gOKrC9KzN3PSYRSI6ar3V0FH0B/I1Pw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668701208;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LH7PkteBjunaTcVYVshaCNBO+i72KyFfIeTcJ3EfnIU=;
        b=IZRERlfOS+N8rzSW5JgEWI02YEBnZ28dob5bibmD012xgbhdG1EJCBGGhu4/mzjd3rYvjK
        HZdQnWIzj0fdcKCQ==
To:     Hillf Danton <hdanton@sina.com>
Cc:     syzbot <syzbot+6fb78d577e89e69602f9@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, pbonzini@redhat.com,
        syzkaller-bugs@googlegroups.com,
        Steven Rostedt <rosted@goodmis.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Subject: Re: [syzbot] WARNING in call_timer_fn
In-Reply-To: <20221117125523.3783-1-hdanton@sina.com>
References: <0000000000009d5daa05ed9815fa@google.com>
 <20221117024511.3606-1-hdanton@sina.com>
 <20221117125523.3783-1-hdanton@sina.com>
Date:   Thu, 17 Nov 2022 17:06:48 +0100
Message-ID: <87wn7tlg4n.ffs@tglx>
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

On Thu, Nov 17 2022 at 20:55, Hillf Danton wrote:
> On 17 Nov 2022 12:54:28 +0100 Thomas Gleixner <tglx@linutronix.de>
>> 
>> The work has been canceled already before in the same function and there
>> are some more delayed works which can trigger this.
>> 
>> So no, this whole close_sync() function is prone to teardown races and
>> just slapping a single cancel here without deeper analysis does not cut
>> it.
>
> Agree.
>
> A set of sync cancelations can do the job, given what is defined in struct
> hci_dev wrt workqueue.

It's only part of the solution because you also have to prevent that
work is queued from other parts of the code....

