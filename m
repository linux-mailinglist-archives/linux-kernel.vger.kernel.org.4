Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDA68605C41
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 12:26:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbiJTK0v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 06:26:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbiJTK0U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 06:26:20 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64E105B517
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 03:26:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 053A9B826B2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 10:26:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46A15C433B5;
        Thu, 20 Oct 2022 10:26:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666261571;
        bh=f+0yPKgGnSqCnJlJw84xS5/DPdIIoIUMMcramBkoJ94=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ZWCeDfKvFQWoyNZfDzoGwFx4FMVmIblYaTmZ2fDULFNFcFzj4kTZFsb8UxZzsN+KC
         gt5b/SScb+2a67EsJi9vhWwWIVeqk2O5dLrY4uy6vqIWZJBzIsklSvLjIPrv/WkScV
         rX2Ep0ndgzhCMEZ9p+e0SOOjjaYARBkKFV2TM6AV9JHqTeNHDPFjzNE9hcz4mzVJvf
         4OMQnCOSJ8m1vvDSFu5uPgCSyudGeTwNW6NtCF2NIPIBFSuR6tQ9PdIj10z9BbYUnx
         ezLHZOODQllmbQ3RWIvpC57SBBYhC/9zvwI0CyFmy5D0i0RFTBBPlxzISqKLppOk69
         YZcSiKAcNk4qw==
Message-ID: <7d8de936-fa3c-3bd8-2415-e97c8a868666@kernel.org>
Date:   Thu, 20 Oct 2022 18:26:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH] f2fs: fix the assign logic of iocb
Content-Language: en-US
To:     Mukesh Ojha <quic_mojha@quicinc.com>, jaegeuk@kernel.org,
        mhiramat@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <1666196277-27014-1-git-send-email-quic_mojha@quicinc.com>
 <35c29f27-96c6-6d74-1efb-1588cbf430a2@kernel.org>
 <8cb1ce88-2e49-745a-dd40-29a084ce285b@quicinc.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <8cb1ce88-2e49-745a-dd40-29a084ce285b@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/10/20 17:27, Mukesh Ojha wrote:
> Hi,
> 
> On 10/20/2022 2:31 PM, Chao Yu wrote:
>> On 2022/10/20 0:17, Mukesh Ojha wrote:
>>> commit 18ae8d12991b ("f2fs: show more DIO information in tracepoint")
>>> introduces iocb field in 'f2fs_direct_IO_enter' trace event
>>> And it only assigns the pointer and later it accesses its field
>>> in trace print log.
>>>
>>> Fix it by correcting data type and memcpy the content of iocb.
>>
>> So the implementation below is wrong, right? since it just assign __entry->name
>> with dentry->d_name.name rather than copyiny entirely, so that, during printing
> 
> I think, yes.
> 
> About the patch, we were getting error as below on doing

Thanks for the explanation. :)

What do you think of adding below info into commit message? and fixing all
similar issues of include/trace/events/f2fs.h in one patch?

Thanks,

> 
> echo 51200 > /d/tracing/buffer_size_kb
> echo 1 > /d/tracing/events/f2fs/f2fs_direct_IO_enter/enable
> echo 1 > /d/tracing/tracing_on
> cat /d/tracing/trace_pipe > ftrace.log
> 
> Run something which exercise this path.
> 
> Unable to handle kernel paging request at virtual address ffffffc04cef3d30
> Mem abort info:
> ESR = 0x96000007
> EC = 0x25: DABT (current EL), IL = 32 bits
> 
>   pc : trace_raw_output_f2fs_direct_IO_enter+0x54/0xa4
>   lr : trace_raw_output_f2fs_direct_IO_enter+0x2c/0xa4
>   sp : ffffffc0443cbbd0
>   x29: ffffffc0443cbbf0 x28: ffffff8935b120d0 x27: ffffff8935b12108
>   x26: ffffff8935b120f0 x25: ffffff8935b12100 x24: ffffff8935b110c0
>   x23: ffffff8935b10000 x22: ffffff88859a936c x21: ffffff88859a936c
>   x20: ffffff8935b110c0 x19: ffffff8935b10000 x18: ffffffc03b195060
>   x17: ffffff8935b11e76 x16: 00000000000000cc x15: ffffffef855c4f2c
>   x14: 0000000000000001 x13: 000000000000004e x12: ffff0000ffffff00
>   x11: ffffffef86c350d0 x10: 00000000000010c0 x9 : 000000000fe0002c
>   x8 : ffffffc04cef3d28 x7 : 7f7f7f7f7f7f7f7f x6 : 0000000002000000
>   x5 : ffffff8935b11e9a x4 : 0000000000006250 x3 : ffff0a00ffffff04
>   x2 : 0000000000000002 x1 : ffffffef86a0a31f x0 : ffffff8935b10000
>   Call trace:
>    trace_raw_output_f2fs_direct_IO_enter+0x54/0xa4
>    print_trace_fmt+0x9c/0x138
>    print_trace_line+0x154/0x254
>    tracing_read_pipe+0x21c/0x380
>    vfs_read+0x108/0x3ac
>    ksys_read+0x7c/0xec
>    __arm64_sys_read+0x20/0x30
>    invoke_syscall+0x60/0x150
>    el0_svc_common.llvm.1237943816091755067+0xb8/0xf8
>    do_el0_svc+0x28/0xa0
> 
> -Mukesh
