Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4886611F7B
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 04:56:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbiJ2C4H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 22:56:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbiJ2C4E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 22:56:04 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE2782497F
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 19:55:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 792C3B82AA2
        for <linux-kernel@vger.kernel.org>; Sat, 29 Oct 2022 02:55:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE97CC433C1;
        Sat, 29 Oct 2022 02:55:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667012114;
        bh=4p6l9uU/+Q4/g298HdI5bm5iguuaGyzOH1SBYsIlANQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=LLAM5JooYqDcii3mtr/+UTqz1yiDZ5B2cHI1w/i4iqkkMRFbe0AJnHQ0AXF0oH1TS
         2omUhxKhMChiSAqr9jXLwogD7RCNiQST0GMIaOp0UXyVjjsvisFHEHs0qZJ8dlvFhm
         6yyB7C8kHpr3STNT6wI59d0kSHor8UOjtIgulwjwdpdYk1QVEPkJhusnxGCQgYC59g
         zdK6hqY09mgHMG/dDk26AIS0aSpRFOqyj8sGk2Z+6qiZQhvPrFPm0trekZkYnzeusV
         vzByR81eeH7B+HVgLC8+nUZYVXoNG/88+BcqCKTGwwcYId2caUYxY6LaaInMrZnjgC
         WDuI97LQ1pWyA==
Message-ID: <56fbc5fb-4c82-005c-5cc9-84dfaeddf106@kernel.org>
Date:   Sat, 29 Oct 2022 10:55:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [f2fs-dev] [PATCH v2 1/2] f2fs: fix the assign logic of iocb
Content-Language: en-US
To:     Mukesh Ojha <quic_mojha@quicinc.com>, jaegeuk@kernel.org,
        mhiramat@kernel.org
Cc:     quic_pkondeti@quicinc.com, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
References: <1666861961-12924-1-git-send-email-quic_mojha@quicinc.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <1666861961-12924-1-git-send-email-quic_mojha@quicinc.com>
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

On 2022/10/27 17:12, Mukesh Ojha wrote:
> commit 18ae8d12991b ("f2fs: show more DIO information in tracepoint")
> introduces iocb field in 'f2fs_direct_IO_enter' trace event
> And it only assigns the pointer and later it accesses its field
> in trace print log.
> 
> Unable to handle kernel paging request at virtual address ffffffc04cef3d30
> Mem abort info:
> ESR = 0x96000007
> EC = 0x25: DABT (current EL), IL = 32 bits
> 
>   pc : trace_raw_output_f2fs_direct_IO_enter+0x54/0xa4
>   lr : trace_raw_output_f2fs_direct_IO_enter+0x2c/0xa4
>   sp : ffffffc0443cbbd0
>   x29: ffffffc0443cbbf0 x28: ffffff8935b120d0 x27: ffffff8935b12108
>   x26: ffffff8935b120f0 x25: ffffff8935b12100 x24: ffffff8935b110c0
>   x23: ffffff8935b10000 x22: ffffff88859a936c x21: ffffff88859a936c
>   x20: ffffff8935b110c0 x19: ffffff8935b10000 x18: ffffffc03b195060
>   x17: ffffff8935b11e76 x16: 00000000000000cc x15: ffffffef855c4f2c
>   x14: 0000000000000001 x13: 000000000000004e x12: ffff0000ffffff00
>   x11: ffffffef86c350d0 x10: 00000000000010c0 x9 : 000000000fe0002c
>   x8 : ffffffc04cef3d28 x7 : 7f7f7f7f7f7f7f7f x6 : 0000000002000000
>   x5 : ffffff8935b11e9a x4 : 0000000000006250 x3 : ffff0a00ffffff04
>   x2 : 0000000000000002 x1 : ffffffef86a0a31f x0 : ffffff8935b10000
>   Call trace:
>    trace_raw_output_f2fs_direct_IO_enter+0x54/0xa4
>    print_trace_fmt+0x9c/0x138
>    print_trace_line+0x154/0x254
>    tracing_read_pipe+0x21c/0x380
>    vfs_read+0x108/0x3ac
>    ksys_read+0x7c/0xec
>    __arm64_sys_read+0x20/0x30
>    invoke_syscall+0x60/0x150
>    el0_svc_common.llvm.1237943816091755067+0xb8/0xf8
>    do_el0_svc+0x28/0xa0
> 
> Fix it by copying the required variables for printing and while at
> it fix the similar issue at some other places in the same file.
> 
> Fixes: 18ae8d12991b ("f2fs: show more DIO information in tracepoint")
> Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
