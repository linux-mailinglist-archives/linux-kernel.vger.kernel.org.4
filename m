Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C27706642E3
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 15:11:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232539AbjAJOLI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 09:11:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238699AbjAJOKT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 09:10:19 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2999F8E9AD
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 06:09:38 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 30D3576F86;
        Tue, 10 Jan 2023 14:09:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1673359777; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CFFRTCJnSEzh0nJjMr3PiPszbqYyiFaiPxqpet2DREU=;
        b=uEhyzeCj+TFutv5Uxvpn3vtgGl7XNwosQHzJNwJS/SlPOSxjlPmlimTDGqrJoX9Zjn8dhX
        QpD31T/4puilFvX88mIhV3NsBUfJbQ7JXUCRw5EkSBqI3YP88aHe57tyfd7BwXX0JDAxPz
        INLAHGkI7KO9VRLoeyh2EQtF3B5KhUk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1673359777;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CFFRTCJnSEzh0nJjMr3PiPszbqYyiFaiPxqpet2DREU=;
        b=r1/u8PFlBFrdhYY/sIP8NAxW/BdQMHpHIoiu2rpOE/e3hgnJUCelhGKnxp2kZJC1eAYyt1
        s8mB42cPnXoFB+Dg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0986E1358A;
        Tue, 10 Jan 2023 14:09:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id JKCvAaFxvWPhUwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Tue, 10 Jan 2023 14:09:37 +0000
Message-ID: <d024b846-9282-4ecd-eafd-2e5571932a72@suse.cz>
Date:   Tue, 10 Jan 2023 15:09:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [linus:master] [mm, slub] 0af8489b02:
 kernel_BUG_at_include/linux/mm.h
Content-Language: en-US
To:     Oliver Sang <oliver.sang@intel.com>
Cc:     Hyeonggon Yoo <42.hyeyoo@gmail.com>, oe-lkp@lists.linux.dev,
        lkp@intel.com, Mike Rapoport <rppt@linux.ibm.com>,
        Christoph Lameter <cl@linux.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Matthew Wilcox <willy@infradead.org>
References: <202212312021.bc1efe86-oliver.sang@intel.com>
 <41276905-b8a5-76ae-8a17-a8ec6558e988@suse.cz>
 <Y7Qxucg5le7WOzr7@xsang-OptiPlex-9020> <Y7VBFLHY/PMbb4XS@hyeyoo>
 <Y7Yr3kEkDEd51xns@xsang-OptiPlex-9020>
 <3f7fa3b3-9623-5c4c-94b1-a41dea6eaaf2@suse.cz>
 <Y7weKyxIY+QFYq6j@xsang-OptiPlex-9020> <Y71t89JMgtRoNHM/@xsang-OptiPlex-9020>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <Y71t89JMgtRoNHM/@xsang-OptiPlex-9020>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/10/23 14:53, Oliver Sang wrote:
> hi all,
> 
> On Mon, Jan 09, 2023 at 10:01:15PM +0800, Oliver Sang wrote:
>> 
>> On Fri, Jan 06, 2023 at 11:13:15AM +0100, Vlastimil Babka wrote:
>> 
>> > And if the rate at the parent (has it increased thanks to the
>> > DEBUG_PAGEALLOC?) is sufficient to bisect to the truly first bad commit. Thanks!
>> 
>> got it. Thanks for suggestion!
>> 
>> since 0af8489b02 is based on v6.1-rc2, we will test (both rectorture and boot)
>> with same config upon v6.1-rc2 to see if it's really clean there.
>> if so we will use dmesg.invalid_opcode:#[##] to trigger new bisect.
>> 
>> will keep you updated. Thanks
> 
> by more tests, we cannot make sure the v6.1-rc2 is clean, so we also checked
> v6.1-rc1 and v6.0. from results, we have low confidence that we can make a
> successful bisection based on them [1][2]. could you suggest?

So am I reading it right, that the probleam appears to be introduced between
v6.0 (0 failures) and v6.1-rc1 (>0 failures)? But agree that with such low
incidence, it's hard to bisect.

> a further information not sure if it's helpful, [1][2] are both i386 based.
> we also tried to run boot tests on x86_64 upon commit 0af8489b02, whatever
> with or without CONFIG_DEBUG_PAGEALLOC/CONFIG_DEBUG_PAGEALLOC_ENABLE_DEFAULT,
> we never obseve similar issues (also run 999 times).

Yeah it looks very much like something that manifests only on i386 (perhaps
only in QEMU as well?) and never x86_64.

What might be interesting then is v6.1-rc1 with further modified config to
enabled CONFIG_SLUB_DEBUG and CONFIG_SLUB_DEBUG_ON. Maybe it will catch the
culprit sooner. Or maybe it will obscure the bug instead, unfortunately.

Thanks for all your effort!

> [1]
> boot results:
> =========================================================================================
> compiler/kconfig/rootfs/sleep/tbox_group/testcase:
>   gcc-11/i386-randconfig-a012-20221226+CONFIG_DEBUG_PAGEALLOC+CONFIG_DEBUG_PAGEALLOC_ENABLE_DEFAULT/debian-11.1-i386-20220923.cgz/1/vm-snb/boot
> 
>             v6.0                    v6.1-rc1                    v6.1-rc2 56d5a2b9ba85a390473e86b4fe4 0af8489b0216fa1dd83e264bef8
> ---------------- --------------------------- --------------------------- --------------------------- ---------------------------
>        fail:runs  %reproduction    fail:runs  %reproduction    fail:runs  %reproduction    fail:runs  %reproduction    fail:runs
>            |             |             |             |             |             |             |             |             |
>            :999          0%           2:999          0%           1:999          1%          11:999         21%         208:999   dmesg.invalid_opcode:#[##]
>            :999          0%            :999          0%            :999          0%           2:999          5%          51:999   dmesg.kernel_BUG_at_include/linux/mm.h
>            :999          0%           1:999          0%            :999          0%           4:999          4%          40:999   dmesg.kernel_BUG_at_include/linux/page-flags.h
>            :999          0%           1:999          0%           1:999          0%           4:999         11%         111:999   dmesg.kernel_BUG_at_lib/list_debug.c
>            :999          0%            :999          0%            :999          0%            :999          0%           2:999   dmesg.kernel_BUG_at_mm/page_alloc.c
>            :999          0%            :999          0%            :999          0%           1:999          0%           3:999   dmesg.kernel_BUG_at_mm/usercopy.c
> 
> [2]
> rcutorture results:
> =========================================================================================
> compiler/kconfig/rootfs/runtime/tbox_group/test/testcase/torture_type:
>   gcc-11/i386-randconfig-a012-20221226+CONFIG_DEBUG_PAGEALLOC+CONFIG_DEBUG_PAGEALLOC_ENABLE_DEFAULT/debian-11.1-i386-20220923.cgz/300s/vm-snb/default/rcutorture/tasks-tracing
> 
>             v6.0                    v6.1-rc1                    v6.1-rc2 56d5a2b9ba85a390473e86b4fe4 0af8489b0216fa1dd83e264bef8
> ---------------- --------------------------- --------------------------- --------------------------- ---------------------------
>        fail:runs  %reproduction    fail:runs  %reproduction    fail:runs  %reproduction    fail:runs  %reproduction    fail:runs
>            |             |             |             |             |             |             |             |             |
>            :999          0%           3:999          0%            :999          1%           8:998         20%         200:999   dmesg.invalid_opcode:#[##]
>            :999          0%            :999          0%            :999          0%            :998          5%          51:999   dmesg.kernel_BUG_at_include/linux/mm.h
>            :999          0%            :999          0%            :999          0%           3:998          4%          42:999   dmesg.kernel_BUG_at_include/linux/page-flags.h
>            :999          0%           3:999          0%            :999          0%           4:998         10%         102:999   dmesg.kernel_BUG_at_lib/list_debug.c
>            :999          0%            :999          0%            :999          0%            :998          0%           2:999   dmesg.kernel_BUG_at_mm/page_alloc.c
>            :999          0%            :999          0%            :999          0%           1:998          0%           3:999   dmesg.kernel_BUG_at_mm/usercopy.c
> 
>> 
>> > 
>> > 

