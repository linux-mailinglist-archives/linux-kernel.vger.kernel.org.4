Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 953C7693E20
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 07:18:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbjBMGSf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 01:18:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjBMGSd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 01:18:33 -0500
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA3596EB0
        for <linux-kernel@vger.kernel.org>; Sun, 12 Feb 2023 22:18:32 -0800 (PST)
Received: by mail-ed1-f42.google.com with SMTP id fj20so11418238edb.1
        for <linux-kernel@vger.kernel.org>; Sun, 12 Feb 2023 22:18:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m3rZhYmbQ9fbwgROYiB/wmN9NMqj5qH9+IaNwrzbjRI=;
        b=dudEqK/w/SkHwE+hSgGhEOT/1LgNDIESuKtKkQvgRyCUSjd0JMymIL6IJC9o8Icv/B
         DceKr9uCKh0WJIfto/7hv34Jm9lKsZTURJvXaT+pd+ceqKlKd2MXtp8/916lAi7gSDc6
         kjvqMZmRMbKpX1STewi3HIPYUZKkYC65Sou7xTd7lEM4qTYMbucYpzD9G4Htw8fi9jcy
         lrba9obz5tNMwvubNTLyqHpwuV4i9+PMu0mC+JU33+NeF7UVfLUL6ZFSjjgnzWv2ec2q
         JV6DCY9A6uljvxJaPrV9O+TCRApJWyGmUEDdIINPz2uY0jd9cI7LIekJUlAvWX55Lt5R
         +JGw==
X-Gm-Message-State: AO0yUKW2iloSjcl50Jj3sX/0MySThk5oC/7Xr7hLXnDH32QjUKwFQA6z
        nI8S89M/KTeBXNWNagL7CEw=
X-Google-Smtp-Source: AK7set/UmW+8cDoNfsIorcbmS1fOjNTrNo2TSvt9hUox3Yltsa/RrhQekVGOLWaFcp/jAKRDaQNEvQ==
X-Received: by 2002:a50:a44a:0:b0:4ab:178d:3d9f with SMTP id v10-20020a50a44a000000b004ab178d3d9fmr17216287edb.28.1676269110949;
        Sun, 12 Feb 2023 22:18:30 -0800 (PST)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:49? ([2a0b:e7c0:0:107::aaaa:49])
        by smtp.gmail.com with ESMTPSA id n8-20020a1709067b4800b008af574fbfc2sm4454505ejo.33.2023.02.12.22.18.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Feb 2023 22:18:30 -0800 (PST)
Message-ID: <323c1b8d-c778-3175-79a0-5adcc0b470b9@kernel.org>
Date:   Mon, 13 Feb 2023 07:18:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: BUG: unable to handle kernel paging request in n_tty_open
To:     Dipanjan Das <mail.dipanjan.das@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     syzkaller <syzkaller@googlegroups.com>,
        Marius Fleischer <fleischermarius@googlemail.com>,
        Priyanka Bose <its.priyanka.bose@gmail.com>
References: <CANX2M5ayFcJsq7P2-mPAt0rvmfjYB9PaL0E2K7mKUxUC=TCTwA@mail.gmail.com>
Content-Language: en-US
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <CANX2M5ayFcJsq7P2-mPAt0rvmfjYB9PaL0E2K7mKUxUC=TCTwA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12. 02. 23, 18:00, Dipanjan Das wrote:
> Hi,
> 
> We would like to report the following bug which has been found by our
> modified version of syzkaller.
> 
> ======================================================
> description: BUG: unable to handle kernel paging request in n_tty_open
> affected file: drivers/tty/tty_ldisc.c
> kernel version: 6.2.0-rc5
> kernel commit: 41c66f47061608dc1fd493eebce198f0e74cc2d7
> git tree: kmsan
> kernel config: https://syzkaller.appspot.com/text?tag=KernelConfig&x=a9a22da1efde3af6
> crash reproducer: attached
> ======================================================
> Crash log:
> ======================================================
> RBP: 00007f7117670c30 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 000000000000000d
> R13: 00007f71165abf6c R14: 00007f71165abf60 R15: 00007f7117670d80
>   </TASK>
> BUG: unable to handle page fault for address: ffffd10016bfa050
> #PF: supervisor write access in kernel mode
> #PF: error_code(0x0002) - not-present page
> PGD 11410067 P4D 11410067 PUD 1157d067 PMD 31910067 PTE 0
> Oops: 0002 [#1] PREEMPT SMP
> CPU: 1 PID: 14496 Comm: syz-executor.4 Not tainted
> 6.2.0-rc5-00010-g41c66f470616 #8
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
> 1.13.0-1ubuntu1.1 04/01/2014
> RIP: 0010:n_tty_open+0xa5/0x240 drivers/tty/n_tty.c:1883

         ldata = vzalloc(sizeof(*ldata));
         if (!ldata)
                 return -ENOMEM;

         ldata->overrun_time = jiffies;

COuld you explain how this assignment can ever fail? ldata is either 
allocated correctly (non-NULL) and the assignment cannot fail or not 
(NULL) and the assignment cannot fail (as it doesn't happen).

thanks,
-- 
js
suse labs

