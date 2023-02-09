Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5EB5690EE6
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 18:09:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbjBIRJ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 12:09:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbjBIRJz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 12:09:55 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3659663C5;
        Thu,  9 Feb 2023 09:09:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=phCTxcbgxw7FtuZUnxHPNrqcA7/WuhObbVrjgltQtJw=; b=CBOj0X0nET8K2sqI5zBMupAVWU
        xkyhCMvJ9F+eem/4Wn0ZOuIIu2cyotjL/iy4yuKtLgnFFEK/tQ0PJTGEHgCV1Mu7c3sjoWdrNktHs
        XKLxydkiXZ/4LGcDi1K6IwJthyxhFru5LeoZBrD5XNPbtclL8483ZKfTeO8h7lbr9P6iynDyh8UTJ
        35m/LWI7Oe9+41KI5lssvqUsnbnrJkwam6v49NdCf1WbCo6LRYsS85h061MqKbfE+Wha4GYgZpHhe
        314qY9F/JKeBWVzOeJhyqkhv1h3IdCoi4bqfTCkgd6RtJyolZdGnKu1bdEIqN3tp4Rb2NoJxpu8dk
        iiibuDkg==;
Received: from [2601:1c2:980:9ec0::df2f]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pQAQZ-002Wx4-6H; Thu, 09 Feb 2023 17:09:43 +0000
Message-ID: <478c5730-f3c3-103a-fab2-829f1099c8b5@infradead.org>
Date:   Thu, 9 Feb 2023 09:09:42 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] m68k: allow PM menu options for COMPILE_TEST
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        linux-m68k@lists.linux-m68k.org
References: <20230209010635.24016-1-rdunlap@infradead.org>
 <CAMuHMdUrmKsi0arun17uVkAaoRe2vs1Xy_XY8Mb2dA6wu8q9iQ@mail.gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <CAMuHMdUrmKsi0arun17uVkAaoRe2vs1Xy_XY8Mb2dA6wu8q9iQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

On 2/9/23 06:03, Geert Uytterhoeven wrote:
> Hi Randy,
> 
> On Thu, Feb 9, 2023 at 2:06 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>> Allow PM options for COMPILE_TEST. This quietens a kconfig
>> warning.
>>
>> This is similar to a patch for Sparc32 that was suggested by
>> Arnd.
>>
>> WARNING: unmet direct dependencies detected for PM
>>   Depends on [n]: !MMU [=y]
>>   Selected by [y]:
>>   - SUN20I_PPU [=y] && (ARCH_SUNXI || COMPILE_TEST [=y])
>>
>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> 
> Thanks for your patch!
> 
>> --- a/arch/m68k/Kconfig
>> +++ b/arch/m68k/Kconfig
>> @@ -126,7 +126,7 @@ menu "Kernel Features"
>>
>>  endmenu
>>
>> -if !MMU
>> +if !MMU || COMPILE_TEST
>>  menu "Power management options"
> 
> I think this is the wrong solution.
> All other selects of PM are done by architecture/platform-gating

Yes, which is where they should be.

> symbols, and none of them can be enabled for compile-testing.
> 
> So either SUN20I_PPU should depend on PM, or ARCH_SUNXI
> should select PM.

I'll do the first choice since I shouldn't be the one to make
a platform config change without knowing about the platform.

Thank you.
-- 
~Randy
