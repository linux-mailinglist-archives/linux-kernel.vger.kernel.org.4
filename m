Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6676B6420AF
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 01:02:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230453AbiLEACU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Dec 2022 19:02:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230254AbiLEACT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Dec 2022 19:02:19 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5FC1DFDC
        for <linux-kernel@vger.kernel.org>; Sun,  4 Dec 2022 16:02:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8637BB80B4E
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 00:02:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A942C433D6;
        Mon,  5 Dec 2022 00:02:13 +0000 (UTC)
Message-ID: <62ee3765-b4fc-db79-5281-7295e43f4314@linux-m68k.org>
Date:   Mon, 5 Dec 2022 10:02:11 +1000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH linux-next] m68k: use strscpy() to instead of strncpy()
To:     yang.yang29@zte.com.cn, geert@linux-m68k.org
Cc:     linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        xu.panda@zte.com.cn
References: <202212031410566533649@zte.com.cn>
Content-Language: en-US
From:   Greg Ungerer <gerg@linux-m68k.org>
In-Reply-To: <202212031410566533649@zte.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Xu,

On 3/12/22 16:10, yang.yang29@zte.com.cn wrote:
> From: Xu Panda <xu.panda@zte.com.cn>
> 
> The implementation of strscpy() is more robust and safer.
> 
> Signed-off-by: Xu Panda <xu.panda@zte.com.cn>
> Signed-off-by: Yang Yang <yang.yang29@zte.com>

Thanks. Seeing as this is non-MMU related I'll take this through
the m68knommu git tree. Applied to the for-next branch.

Regards
Greg



> ---
>   arch/m68k/kernel/setup_no.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/arch/m68k/kernel/setup_no.c b/arch/m68k/kernel/setup_no.c
> index cb6def585851..37fb663559b4 100644
> --- a/arch/m68k/kernel/setup_no.c
> +++ b/arch/m68k/kernel/setup_no.c
> @@ -90,8 +90,7 @@ void __init setup_arch(char **cmdline_p)
>   	config_BSP(&command_line[0], sizeof(command_line));
> 
>   #if defined(CONFIG_BOOTPARAM)
> -	strncpy(&command_line[0], CONFIG_BOOTPARAM_STRING, sizeof(command_line));
> -	command_line[sizeof(command_line) - 1] = 0;
> +	strscpy(&command_line[0], CONFIG_BOOTPARAM_STRING, sizeof(command_line));
>   #endif /* CONFIG_BOOTPARAM */
> 
>   	process_uboot_commandline(&command_line[0], sizeof(command_line));

