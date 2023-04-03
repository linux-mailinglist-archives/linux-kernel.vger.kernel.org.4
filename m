Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F22506D45DD
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 15:32:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232054AbjDCNcB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 09:32:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232559AbjDCNb7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 09:31:59 -0400
Received: from forward501c.mail.yandex.net (forward501c.mail.yandex.net [178.154.239.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 028C2A4
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 06:31:57 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-33.iva.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-33.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:2016:0:640:1006:0])
        by forward501c.mail.yandex.net (Yandex) with ESMTP id DE4535EF50;
        Mon,  3 Apr 2023 16:31:55 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-33.iva.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id rVNgRulWlGk0-l4X6HZXH;
        Mon, 03 Apr 2023 16:31:55 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1680528715;
        bh=QFh2Qzhmxh/G7C5fjFWTwiJiilCSTiKC1fL8nFAOZyk=;
        h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
        b=JAoQkerD3dS1q+fAQJvhjnxFjnuGpEcwxi+rEkPbJe2EBfcckaqmg0wXbQRWQ/ovJ
         eSjTFr5G0t2Sgz/RWe5Njyoxo6JVQ2x8eK6lgnmxMm5gEctuPUrGNZHa0pY7YFBmID
         xCraE1i3+FiNMVnkKlltaDke35t/rNbGfRSgRscI=
Authentication-Results: mail-nwsmtp-smtp-production-main-33.iva.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
Message-ID: <07fe91e7-104a-32d0-e59b-c1d2d459fdbe@yandex.ru>
Date:   Mon, 3 Apr 2023 18:31:52 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: MREMAP_FIXED unmaps dest on error
Content-Language: en-US
To:     David Hildenbrand <david@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     linux-mm@kvack.org,
        =?UTF-8?Q?Jakub_Mat=c4=9bna?= <matenajakub@gmail.com>,
        Hugh Dickins <hughd@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
References: <18c36a78-4082-fab6-c7c9-69a249516803@yandex.ru>
 <cba955a3-e41e-adce-954a-9a55d6d97065@redhat.com>
From:   stsp <stsp2@yandex.ru>
In-Reply-To: <cba955a3-e41e-adce-954a-9a55d6d97065@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

03.04.2023 16:58, David Hildenbrand пишет:
> On 30.03.23 17:48, stsp wrote:
>> Hello.
>>
>> The attached test-case demonstrates a
>> bug in mremap(). If MREMAP_FIXED is used
>> over an existing mapping and mremap() fails,
>> destination area gets unmapped.
>> AFAIK the failed syscall should have no
>> observable effects.
>
> I remember that holds for various mapping-related syscalls: if 
> something goes wrong, the end result is not guaranteed to be what we 
> had before the syscall.
>
> For example, if you use mmap(MAP_FIXED) to replace part of an exiting 
> mapping, we first munmap what's there and then try to mmap the new 
> mapping. If something goes wrong while doing that, we cannot simple 
> undo what we already did.
>
> Long story short: the semantics of these syscalls has never been to 
> leave the system in the state as it was before in case anything goes 
> wrong.
>
>
> As another example, if you do an mprotect() that covers multiple VMAS, 
> and there is an issue with the last VMA, all but the last VMA will 
> have their permissions changed.
>
Thanks for info.
Is this documented in a man page?
I wonder how do you deal with mmap() and
mprotect() on such occasions. mremap()
is an extension, but mmap() and mprotect()
are from posix, so is it a compliant impl?

Also my example shows another bug
that the VMAs are not merged after I
restore the protection of one of them,
allowing them to merge.

