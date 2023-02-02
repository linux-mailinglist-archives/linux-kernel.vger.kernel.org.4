Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6E796881A7
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 16:22:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232427AbjBBPWb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 10:22:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231614AbjBBPW3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 10:22:29 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3D4B22798;
        Thu,  2 Feb 2023 07:22:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=9oOxos7ZA6TGusK+7tBr/VRDF4lwgh3CYWYUksgrt8Y=; b=p6wz6eR0yP3QuKyu63HEk27AiP
        eKJbFwjoa01zxVVXBk0BO9BrbUX7TIYxztkcEnxNvC+MfG35vdG72Mdh6L6EKu3R2n1MPUEM5YDKY
        0qc/jVohvK5DR4iVsUwro3IDRMSoS689LNEBEJV9EJrxMcRnJPh5vCFrktxgMiw04QgcRhhhlU8k4
        oXu8wzeIxTPFXXWCH59eAEi22qT5sWPy/QvoRTqZqQ2t5OgZ60qn1xiZBceB1LJ12bpAhhi8gyHTl
        2H3XCptZqQgXcv5idfXwqxcQDQGWhXR0jUYiX8RBSIcdmAOrIw+jjSN3hsyn1ygFt04H7KWwMcKkR
        3hI5FaFQ==;
Received: from [2601:1c2:d00:6a60::9526]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pNbPk-00GJuW-Uc; Thu, 02 Feb 2023 15:22:17 +0000
Message-ID: <ed617e7e-c4ca-109b-fa1a-2ffe9bd8a355@infradead.org>
Date:   Thu, 2 Feb 2023 07:22:15 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2] sh: implicit access_ok() needs an #include
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20230202053113.2782-1-rdunlap@infradead.org>
 <980912a0-f5a0-4dea-9b5b-565d05bc4a6c@app.fastmail.com>
 <CAMuHMdWPyTRh_E-jRET0zObm1+RYcPy0YrnVr-+ozEO84F0DWw@mail.gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <CAMuHMdWPyTRh_E-jRET0zObm1+RYcPy0YrnVr-+ozEO84F0DWw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/2/23 00:22, Geert Uytterhoeven wrote:
> Hi Arnd,
> 
> On Thu, Feb 2, 2023 at 8:52 AM Arnd Bergmann <arnd@arndb.de> wrote:
>> On Thu, Feb 2, 2023, at 06:31, Randy Dunlap wrote:
>>> Building arch/sh/ has a build error/warning that is fixed by
>>> adding an #include of a header file.
>>>
>>> ../arch/sh/include/asm/checksum_32.h: In function
>>> 'csum_and_copy_from_user':
>>> ../arch/sh/include/asm/checksum_32.h:53:14: error: implicit declaration
>>> of function 'access_ok' [-Werror=implicit-function-declaration]
>>>    53 |         if (!access_ok(src, len))
>>>       |              ^~~~~~~~~
>>>
>>> Fixes: 7fe8970a78a1 ("sh32: convert to csum_and_copy_from_user()")
>>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>>> Cc: Al Viro <viro@zeniv.linux.org.uk>
>>> Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
>>> Cc: Rich Felker <dalias@libc.org>
>>> Cc: linux-sh@vger.kernel.org
>>> Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
>>> Cc: Arnd Bergmann <arnd@arndb.de>
>>> Cc: Andrew Morton <akpm@linux-foundation.org>
>>> ---
>>> v2: add Subject: and patch description
>>
>> Thanks for the fix!
>>
>>>
>>>  arch/sh/include/asm/checksum_32.h |    1 +
>>>  1 file changed, 1 insertion(+)
>>>
>>> diff -- a/arch/sh/include/asm/checksum_32.h b/arch/sh/include/asm/checksum_32.h
>>> --- a/arch/sh/include/asm/checksum_32.h
>>> +++ b/arch/sh/include/asm/checksum_32.h
>>> @@ -7,6 +7,7 @@
>>>   */
>>>
>>>  #include <linux/in6.h>
>>> +#include <asm-generic/access_ok.h>
>>
>> This will work correctly, but it is not the intended usage of the
>> header. Anything in asm-generic/*.h should only be included by
>> a particular header, usually the asm/*.h with the same name or in this
>> case the asm/uaccess.h header.
>>
>> I think the correct fix here is to include asm/uaccess.h instead
>> of asm-generic/access_ok.h.
> 
> Which should already be there, or RSN:
> https://lore.kernel.org/all/167514181688.11863.771497291150527329.git-patchwork-notify@kernel.org

Good to see that. And thanks to both of you.

-- 
~Randy
