Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7186364E9BA
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 11:47:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230444AbiLPKr3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 05:47:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230352AbiLPKrJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 05:47:09 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D3031A7
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 02:47:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D724CB81B2A
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 10:47:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 424CCC433D2;
        Fri, 16 Dec 2022 10:47:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671187625;
        bh=GW47qGrPqF8CWC+Youkq+IO1MFrfcW5vndIuiRUvzRM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=E3fPudGa6StFQxmn4+3QO7yhd+6HAUS3uW7xK3ebXggA7JKM0SYZyZ0tO/aub63mc
         2MkG9axMPSSUq9kWW+wL/zF1W9H6SB4a5o8cd3F8BC3XKRBlae5cvSHLRZ8fFYUie3
         XhP+JJprIXerazBZ5Mm1+5EYqyjP9Yf+7VaR+VQjRTr/GXnN4dOJ791FuELQk50JA9
         H9FKpjKMGqgikranAQp/OOUktY/TY3dpyCRCDfKe1qM1s1VI0oJzlmGLZBOOy6dZNG
         4vCkLebDCcPjcSZqFdXHu2mLWzh/AzedWgiHsKpgEtAsJyG5oVAVV9M3VNcol/21st
         5i7+OFdoiEC7Q==
Message-ID: <a2c286e1-470f-ff83-196a-f7ea490096ff@kernel.org>
Date:   Fri, 16 Dec 2022 18:47:01 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] f2fs: merge f2fs_show_injection_info() into
 time_to_inject()
Content-Language: en-US
To:     Yangtao Li <frank.li@vivo.com>, jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <dedae282-2d13-cc12-95b8-98cfd377d98c@kernel.org>
 <20221216034811.4603-1-frank.li@vivo.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20221216034811.4603-1-frank.li@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/12/16 11:48, Yangtao Li wrote:
>> After moving f2fs_show_injection_info() core functionality into time_to_inject(),
>> __builtin_return_address(0) result changes from return address of caller of
>> f2fs_show_injection_info() to return address of time_to_inject().
> 
> I tried the __builtin_return_address(1) parameter just now, and no error
> was reported when compiling, but a null pointer problem will be triggered
> when the kernel is running.
> 
> I thought about it, and the print address didn't seem clear enough.
> Let's just print the line number of the caller?

That will cause a regression when searching last injection call paths after
bug occurs, since there are many similar callers of time_to_inject, but the
caller's call paths are different. So, IMO, it's useful to keep
__builtin_return_address in the log to distinguish the real call path of
fault injection.

> 
> #define time_to_inject(sbi, type) __time_to_inject(sbi, type, __func__, __LINE__)

Any way to pass __builtin_return_address(0) from parameter in __time_to_inject(...)?

Thanks,

> static inline bool __time_to_inject(struct f2fs_sb_info *sbi, int type,
>                                      const char *func_name, unsigned int line)
> {
>      struct f2fs_fault_info *ffi = &F2FS_OPTION(sbi).fault_info;
> 
>      if (!ffi->inject_rate)
>          return false;
> 
>      if (!IS_FAULT_SET(ffi, type))
>          return false;
> 
>      atomic_inc(&ffi->inject_ops);
>      if (atomic_read(&ffi->inject_ops) >= ffi->inject_rate) {
>          atomic_set(&ffi->inject_ops, 0);
>          printk_ratelimited("%sF2FS-fs (%s) : inject %s in [%s] %d\n",
>              KERN_INFO, sbi->sb->s_id, f2fs_fault_name[type],
>              func_name, line);
>          return true;
>      }
>      return false;
> }
> 
> Thx,
> Yangtao
