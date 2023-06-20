Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15BAB737774
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 00:27:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230042AbjFTW1g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 18:27:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjFTW1e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 18:27:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 196481735;
        Tue, 20 Jun 2023 15:27:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 77F0961291;
        Tue, 20 Jun 2023 22:27:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10869C433C8;
        Tue, 20 Jun 2023 22:27:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687300051;
        bh=PYb/T++jC5C/v/zU5chufo7iMHm0QuoDKNyvVuNCbzo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=kCaLqxuhAT5zzAt4Lz/LSU6TgxQ7tEaSYEwCXGthjQterhLrhLRNmDwtQzYmXG1sV
         AIwdz2Gu7+u4lLGh34WOL2xHDRuOc14qWGfA4Eov2QjOxNaY1qPz+jHDkzSGTAfIq4
         TiWWi30LfG4CCH8eSXBKziNgk5SoBIClrtZVzoDWRNa4kMHJHGMtMLBIDK3awMqIhV
         6+F5Pj5kfmKVkSsKIRVYfgAmz5/2bne1b6fu5UHOGAXCUVaWpMHCGcCk68EXZCesOM
         KvIq0RefYs8+8Ahe6nIt5ydfRikP06wpvEXbYOW1neey8gZqVSgxpbuz1kg9jWwb25
         d32/hJYTXgyAA==
Message-ID: <40af3815-b0ee-e96f-f7a8-9f0fe9f938d0@kernel.org>
Date:   Tue, 20 Jun 2023 17:27:29 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] nios2: Replace all non-returning strlcpy with strscpy
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>
Cc:     Azeem Shaikh <azeemshaikh38@gmail.com>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230530162358.984149-1-azeemshaikh38@gmail.com>
 <202305301620.346CC541@keescook>
 <45ed31e0-9ecd-56ea-c0d4-3c68a3fd8cf5@kernel.org>
 <202306201313.C425BCB@keescook>
From:   Dinh Nguyen <dinguyen@kernel.org>
In-Reply-To: <202306201313.C425BCB@keescook>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/20/23 15:15, Kees Cook wrote:
> On Tue, Jun 13, 2023 at 05:15:41PM -0500, Dinh Nguyen wrote:
>>
>>
>> On 5/30/23 18:20, Kees Cook wrote:
>>> On Tue, May 30, 2023 at 04:23:58PM +0000, Azeem Shaikh wrote:
>>>> strlcpy() reads the entire source buffer first.
>>>> This read may exceed the destination size limit.
>>>> This is both inefficient and can lead to linear read
>>>> overflows if a source string is not NUL-terminated [1].
>>>> In an effort to remove strlcpy() completely [2], replace
>>>> strlcpy() here with strscpy().
>>>> No return values were used, so direct replacement is safe.
>>>>
>>>> [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy
>>>> [2] https://github.com/KSPP/linux/issues/89
>>>>
>>>> Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>
>>>
>>> Reviewed-by: Kees Cook <keescook@chromium.org>
>>>
>>
>> Applied!
> 
> Thanks for taking this patch! I just wanted to double-check, though; I
> haven't seen it show up in -next yet. Is this still queued?
> 
> Thanks!

I've queued it for v6.5. Do you need it in v6.4?

Dinh
