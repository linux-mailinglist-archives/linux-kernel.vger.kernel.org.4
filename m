Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C962C6108CE
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 05:39:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235981AbiJ1Di7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 23:38:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235712AbiJ1Diw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 23:38:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69E43D0CDA
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 20:38:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5655D62591
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 03:38:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C884C43143;
        Fri, 28 Oct 2022 03:38:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666928330;
        bh=LlaI4t3FOeyLoIjMSrcnwjGr/jnLctc2/+mhw1nvwvw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=hhxzI6gTbO/hJXBbU7Jg9pg0rFmgnnSa7QMZs29ycIObFnUxzdmQBfKlYV4peGvMv
         rI0nZPSIXRDa/jFSxmvWfv4PjAml4mGt+s8piyNpxuK8DPRdOSP032ZA1ne1z31eN6
         fwl9HCp2nNS4zV3T96y+nroFqa6c8uzfNzVAKbWVq1pfD46pmre3aWHr8+kTiurNW9
         b7ITK0pTB/wTUT0QQvAvVJf1WSmNE6Mcpl2AwPIhvR+5WCHWEY/L+k7CSHozLtiyU1
         fcHP1sKy6//NR5oGIKCWvO8STaJBNoeQyWeTy2sTsSKMwBfct0noimqNZuWboYfFw0
         P7g+C5UcnTVsg==
Message-ID: <9b7357f3-5e5e-c1db-fdf8-613b6ad7bac3@kernel.org>
Date:   Fri, 28 Oct 2022 11:38:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH 3/3] f2fs: fix to f2fs_handle_critical_error when
 errors=remount-ro
Content-Language: en-US
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     Yangtao Li <frank.li@vivo.com>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <ab2f3576-bedd-8c27-5549-f9ff5462aee3@kernel.org>
 <20221028023303.28020-1-frank.li@vivo.com>
 <85b6be9b-5c5b-ace0-8084-4bd52ef64996@kernel.org>
 <Y1tJ4uKBa0ItHCBw@google.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <Y1tJ4uKBa0ItHCBw@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/10/28 11:17, Jaegeuk Kim wrote:
> On 10/28, Chao Yu wrote:
>> On 2022/10/28 10:33, Yangtao Li wrote:
>>>> It won't pollute global namespace since it's a static function just be used in f2fs/super.c...
>>>
>>> emm, I think it would be nice to see the f2fs_record_error_work symbol
>>> in the stack, it can be explicitly a function of f2fs. personal opinion for reference only.
>>
>> Oh, yes, let me update in original patch as well.
> 
> Chao,
> 
> It seems there're multiple bugs. Please apply this as well.
> 
> https://lore.kernel.org/linux-f2fs-devel/20221027180416.3786792-1-jaegeuk@kernel.org/T/#u

Jaegeuk,

Thanks, let me merge all those patches and do the test.

Thanks,

> 
>>
>>>
>>>> Do you mind letting me merge these two patches into original patch?
>>>> since original patch is still in dev branch, rather than mainline.
>>>
>>> Glad to see, if resend.
>>
>> Thanks, :)
>>
>>>
>>>> I guess it needs to stop ckpt thread as well...
>>>
>>> agree, :)
>>>
>>> Thanks,
