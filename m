Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED269666BEC
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 08:57:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236564AbjALH5T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 02:57:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239601AbjALH5I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 02:57:08 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C66224261B
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 23:57:02 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 28AA93890E;
        Thu, 12 Jan 2023 07:57:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1673510221; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=H9B578gU4xYlZbJfgh8jqVWXUwMf6alESeHSZuKeXhg=;
        b=PqlquS20KWr3jofPSqktutqwNbQLSNFykZFJsglcB590xp+A+HQ3/bMNF6ytvv35B2UG7Y
        ohB0cRhKbUjdrdfaUD6JF7MDK+Iu6oA3mG2/84oSNV2UoK3lh20HSPNqbdaaqN6QgRnELi
        iPGc4Lnuo1w0ZL50kgN3xgtkn0sRoh8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1673510221;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=H9B578gU4xYlZbJfgh8jqVWXUwMf6alESeHSZuKeXhg=;
        b=96sTO8Iqs/5QTFJMl+nO/9eaBizPEv9zqC/46l5IocbGEcNeJ3r/KSVv6WtWJ46FCu5g7W
        u5W5tXL6hRadKMDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 01243134B3;
        Thu, 12 Jan 2023 07:57:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id qMv/Oky9v2OsYQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Thu, 12 Jan 2023 07:57:00 +0000
Message-ID: <bbf4fc3e-a9c2-83aa-d50a-8f7cb5b2bf4b@suse.cz>
Date:   Thu, 12 Jan 2023 08:56:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [linus:master] [mm, slub] 0af8489b02:
 kernel_BUG_at_include/linux/mm.h
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
 <d024b846-9282-4ecd-eafd-2e5571932a72@suse.cz>
 <Y7+7KUyuo/9HeCF2@xsang-OptiPlex-9020>
Content-Language: en-US
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <Y7+7KUyuo/9HeCF2@xsang-OptiPlex-9020>
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

On 1/12/23 08:47, Oliver Sang wrote:
> hi, Vlastimil,
> 
> On Tue, Jan 10, 2023 at 03:09:36PM +0100, Vlastimil Babka wrote:
>> On 1/10/23 14:53, Oliver Sang wrote:
>> > hi all,
>> > 
>> > On Mon, Jan 09, 2023 at 10:01:15PM +0800, Oliver Sang wrote:
>> >> 
>> >> On Fri, Jan 06, 2023 at 11:13:15AM +0100, Vlastimil Babka wrote:
>> >> 
>> >> > And if the rate at the parent (has it increased thanks to the
>> >> > DEBUG_PAGEALLOC?) is sufficient to bisect to the truly first bad commit. Thanks!
>> >> 
>> >> got it. Thanks for suggestion!
>> >> 
>> >> since 0af8489b02 is based on v6.1-rc2, we will test (both rectorture and boot)
>> >> with same config upon v6.1-rc2 to see if it's really clean there.
>> >> if so we will use dmesg.invalid_opcode:#[##] to trigger new bisect.
>> >> 
>> >> will keep you updated. Thanks
>> > 
>> > by more tests, we cannot make sure the v6.1-rc2 is clean, so we also checked
>> > v6.1-rc1 and v6.0. from results, we have low confidence that we can make a
>> > successful bisection based on them [1][2]. could you suggest?
>> 
>> So am I reading it right, that the probleam appears to be introduced between
>> v6.0 (0 failures) and v6.1-rc1 (>0 failures)? But agree that with such low
>> incidence, it's hard to bisect.
> 
> yeah, you are reading it right :)
> 
>> 
>> > a further information not sure if it's helpful, [1][2] are both i386 based.
>> > we also tried to run boot tests on x86_64 upon commit 0af8489b02, whatever
>> > with or without CONFIG_DEBUG_PAGEALLOC/CONFIG_DEBUG_PAGEALLOC_ENABLE_DEFAULT,
>> > we never obseve similar issues (also run 999 times).
>> 
>> Yeah it looks very much like something that manifests only on i386 (perhaps
>> only in QEMU as well?) and never x86_64.
>> 
>> What might be interesting then is v6.1-rc1 with further modified config to
>> enabled CONFIG_SLUB_DEBUG and CONFIG_SLUB_DEBUG_ON. Maybe it will catch the
>> culprit sooner. Or maybe it will obscure the bug instead, unfortunately.
> 
> oh, seems, unfortunalately, 'obscure' happen :(

Actually no, by "obscure" means with CONFIG_SLUB_DEBUG it wouldn't happen
anymore. But this is the opposite, it seems to happen a lot. I would have
preferred that slub debugging catches some slab misuse, but this seems
useful too. With such fail rates you can perhaps try ealier kernels than 6.0
and eventually find the truly clean and first bad release and bisect?

> we enabled CONFIG_SLUB_DEBUG and CONFIG_SLUB_DEBUG_ON, along with
> CONFIG_DEBUG_PAGEALLOC and CONFIG_DEBUG_PAGEALLOC_ENABLE_DEFAULT
> 
> boot (we also add the test for v6.2-rc3):
> =========================================================================================
> compiler/kconfig/rootfs/sleep/tbox_group/testcase:
>   gcc-11/i386-randconfig-a012-20221226+CONFIG_DEBUG_PAGEALLOC+CONFIG_DEBUG_PAGEALLOC_ENABLE_DEFAULT+CONFIG_SLUB_DEBUG_ON/debian-11.1-i386-20220923.cgz/1/vm-snb/boot
> 
>             v6.0                    v6.1-rc1                    v6.1-rc2 56d5a2b9ba85a390473e86b4fe4 0af8489b0216fa1dd83e264bef8                    v6.2-rc3
> ---------------- --------------------------- --------------------------- --------------------------- --------------------------- ---------------------------
>        fail:runs  %reproduction    fail:runs  %reproduction    fail:runs  %reproduction    fail:runs  %reproduction    fail:runs  %reproduction    fail:runs
>            |             |             |             |             |             |             |             |             |             |             |
>          43:999          3%          68:999          4%          84:999          6%          99:999          5%          94:999          4%          86:999   dmesg.invalid_opcode:#[##]
>           4:999         -0%           2:999          0%           7:999          0%           8:999          0%           4:999         -0%            :999   dmesg.kernel_BUG_at_include/linux/mm.h
>           3:999          0%           4:999          0%           3:999          0%           7:999          0%           5:999          1%           9:999   dmesg.kernel_BUG_at_include/linux/page-flags.h
>          34:999          3%          61:999          4%          73:999          5%          81:999          5%          85:999          4%          74:999   dmesg.kernel_BUG_at_lib/list_debug.c
>            :999          0%            :999          0%            :999          0%           1:999          0%            :999          0%            :999   dmesg.kernel_BUG_at_mm/internal.h
>           3:999         -0%           1:999         -0%            :999         -0%           2:999         -0%            :999         -0%           2:999   dmesg.kernel_BUG_at_mm/page_alloc.c
>            :999          0%            :999          0%           2:999          0%            :999          0%            :999          0%           2:999   dmesg.kernel_BUG_at_mm/usercopy.c
> 
> 
> since now even the v6.0 is not clean, attached one dmesg FYI
> 
> 
> below is from rcutorture:
> =========================================================================================
> compiler/kconfig/rootfs/runtime/tbox_group/test/testcase/torture_type:
>   gcc-11/i386-randconfig-a012-20221226+CONFIG_DEBUG_PAGEALLOC+CONFIG_DEBUG_PAGEALLOC_ENABLE_DEFAULT+CONFIG_SLUB_DEBUG_ON/debian-11.1-i386-20220923.cgz/300s/vm-snb/default/rcutorture/tasks-tracing
> 
>             v6.0                    v6.1-rc1                    v6.1-rc2 56d5a2b9ba85a390473e86b4fe4 0af8489b0216fa1dd83e264bef8                    v6.2-rc3
> ---------------- --------------------------- --------------------------- --------------------------- --------------------------- ---------------------------
>        fail:runs  %reproduction    fail:runs  %reproduction    fail:runs  %reproduction    fail:runs  %reproduction    fail:runs  %reproduction    fail:runs
>            |             |             |             |             |             |             |             |             |             |             |
>          47:999          3%          72:999          4%          91:999          4%          88:999          3%          76:999          4%          84:999   dmesg.invalid_opcode:#[##]
>           4:999          0%           8:999          1%          10:999          0%           5:999          0%           4:999         -0%            :999   dmesg.kernel_BUG_at_include/linux/mm.h
>           3:999         -0%           2:999          0%           5:999          0%           5:999         -0%           2:999          1%           8:999   dmesg.kernel_BUG_at_include/linux/page-flags.h
>          38:999          2%          61:999          4%          75:999          4%          78:999          3%          68:999          4%          73:999   dmesg.kernel_BUG_at_lib/list_debug.c
>           1:999          0%           1:999          0%           1:999         -0%            :999          0%           2:999          0%           2:999   dmesg.kernel_BUG_at_mm/page_alloc.c
>           1:999         -0%            :999         -0%            :999         -0%            :999         -0%            :999          0%           1:999   dmesg.kernel_BUG_at_mm/usercopy.c
>> 
>> Thanks for all your effort!
>> 
>> > [1]
>> > boot results:
>> > =========================================================================================
>> > compiler/kconfig/rootfs/sleep/tbox_group/testcase:
>> >   gcc-11/i386-randconfig-a012-20221226+CONFIG_DEBUG_PAGEALLOC+CONFIG_DEBUG_PAGEALLOC_ENABLE_DEFAULT/debian-11.1-i386-20220923.cgz/1/vm-snb/boot
>> > 
>> >             v6.0                    v6.1-rc1                    v6.1-rc2 56d5a2b9ba85a390473e86b4fe4 0af8489b0216fa1dd83e264bef8
>> > ---------------- --------------------------- --------------------------- --------------------------- ---------------------------
>> >        fail:runs  %reproduction    fail:runs  %reproduction    fail:runs  %reproduction    fail:runs  %reproduction    fail:runs
>> >            |             |             |             |             |             |             |             |             |
>> >            :999          0%           2:999          0%           1:999          1%          11:999         21%         208:999   dmesg.invalid_opcode:#[##]
>> >            :999          0%            :999          0%            :999          0%           2:999          5%          51:999   dmesg.kernel_BUG_at_include/linux/mm.h
>> >            :999          0%           1:999          0%            :999          0%           4:999          4%          40:999   dmesg.kernel_BUG_at_include/linux/page-flags.h
>> >            :999          0%           1:999          0%           1:999          0%           4:999         11%         111:999   dmesg.kernel_BUG_at_lib/list_debug.c
>> >            :999          0%            :999          0%            :999          0%            :999          0%           2:999   dmesg.kernel_BUG_at_mm/page_alloc.c
>> >            :999          0%            :999          0%            :999          0%           1:999          0%           3:999   dmesg.kernel_BUG_at_mm/usercopy.c
>> > 
>> > [2]
>> > rcutorture results:
>> > =========================================================================================
>> > compiler/kconfig/rootfs/runtime/tbox_group/test/testcase/torture_type:
>> >   gcc-11/i386-randconfig-a012-20221226+CONFIG_DEBUG_PAGEALLOC+CONFIG_DEBUG_PAGEALLOC_ENABLE_DEFAULT/debian-11.1-i386-20220923.cgz/300s/vm-snb/default/rcutorture/tasks-tracing
>> > 
>> >             v6.0                    v6.1-rc1                    v6.1-rc2 56d5a2b9ba85a390473e86b4fe4 0af8489b0216fa1dd83e264bef8
>> > ---------------- --------------------------- --------------------------- --------------------------- ---------------------------
>> >        fail:runs  %reproduction    fail:runs  %reproduction    fail:runs  %reproduction    fail:runs  %reproduction    fail:runs
>> >            |             |             |             |             |             |             |             |             |
>> >            :999          0%           3:999          0%            :999          1%           8:998         20%         200:999   dmesg.invalid_opcode:#[##]
>> >            :999          0%            :999          0%            :999          0%            :998          5%          51:999   dmesg.kernel_BUG_at_include/linux/mm.h
>> >            :999          0%            :999          0%            :999          0%           3:998          4%          42:999   dmesg.kernel_BUG_at_include/linux/page-flags.h
>> >            :999          0%           3:999          0%            :999          0%           4:998         10%         102:999   dmesg.kernel_BUG_at_lib/list_debug.c
>> >            :999          0%            :999          0%            :999          0%            :998          0%           2:999   dmesg.kernel_BUG_at_mm/page_alloc.c
>> >            :999          0%            :999          0%            :999          0%           1:998          0%           3:999   dmesg.kernel_BUG_at_mm/usercopy.c
>> > 
>> >> 
>> >> > 
>> >> > 
>> 
>> 

