Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96607651B86
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 08:25:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233329AbiLTHZC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 02:25:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233191AbiLTHYx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 02:24:53 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 869C09FF7
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 23:24:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 190F96128D
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 07:24:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85303C433D2;
        Tue, 20 Dec 2022 07:24:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671521091;
        bh=fic7UtMekVGEyz7xE6CP02+SrSkeyzgkK1qckUpJxvo=;
        h=Date:To:Cc:References:From:Subject:In-Reply-To:From;
        b=BgCC8unpIs6R9kXkB5SLbQ0dhtZZTWyvqbAMbGoTcTfehE9vDNoJUdFpaW4zq31DR
         +UZcfx5gdsxhRR5a40U2Wrlpt29QpnyGwVD/YgVLfAOLHV6Pr/eBjvUWcSd/5VYuN8
         xCCDVsMKwVkiihX9ZHZ9lXJIRd78Ng0+wUcHnpvtEeZXjGASC5e2vxl2ADfAbOXjHY
         wB7g0XiqfjM7Y5IsuwiZMPJHANDPtNtY7P79f4s1q123xaYECW8+StaIEQ/48JsdQK
         LsVqm5Xa/XfqgzZAq4lhVvEhqGM4PVMM9cUu08D3zszOviLDAVGfrmNrlBNUPgbsB3
         WwXbTxYq0ga2Q==
Message-ID: <4414ea75-7fd9-258c-789a-3026c1117630@kernel.org>
Date:   Tue, 20 Dec 2022 15:24:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Content-Language: en-US
To:     Yangtao Li <frank.li@vivo.com>, jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <20221219132517.17576-1-frank.li@vivo.com>
From:   Chao Yu <chao@kernel.org>
Subject: Re: [PATCH v2] f2fs: merge f2fs_show_injection_info() into
 time_to_inject()
In-Reply-To: <20221219132517.17576-1-frank.li@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/12/19 21:25, Yangtao Li wrote:
> There is no need to additionally use f2fs_show_injection_info()
> to output information. Concatenate time_to_inject() and
> __time_to_inject() via a macro. In the new __time_to_inject()
> function, pass in the caller function name. And in order to avoid
> this inline function is not expanded causing __builtin_return_address(0)
> return address of of time_to_inject(), mark time_to_inject() as
> __always_inline.

IMO, we'd better have a good reason (maybe performace related) to change
inline to __always_inline, rather than avoiding printed message change
due to compile option.

> -static inline bool time_to_inject(struct f2fs_sb_info *sbi, int type)
> +#define time_to_inject(sbi, type) __time_to_inject(sbi, type, __func__)
> +static __always_inline bool __time_to_inject(struct f2fs_sb_info *sbi, int type,
> +								    const char *func_name)

How about:

#define time_to_inject(sbi, type) __time_to_inject(sbi, type, __func__,	\
					__builtin_return_address(0))
static inline bool __time_to_inject(struct f2fs_sb_info *sbi, int type,
				const char *func, const char *parent_func)

Thanks,
