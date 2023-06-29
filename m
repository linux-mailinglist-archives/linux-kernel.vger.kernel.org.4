Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 345D8742A82
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 18:21:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232440AbjF2QVE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 12:21:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232421AbjF2QVC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 12:21:02 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32E172D7F
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 09:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Cc:Content-ID:Content-Description;
        bh=9Swsu6T6iCmcyucr6iqf2XEYc9qOiNmC8LbPDgOq4Jo=; b=u2SGpDLcP9XhWOGumUk4v6kGxl
        gEkGk7BDvYF+KKLBiKDX4+dUzQfz5n9qEGMQe/hGStlDMCDvOjQoNmWyJ43nGq0mea6diaIiwYTcP
        AuD87HZ3OEGMMmyw3OAQQDrAlyovAOBvujtAA2GQ3i5HuCxQhwly+Rpg+Zz3x7+uO9RLgpgoo6yhE
        diXBr3mHCkAiAmaGiWKjSJS2gLPIKd0497UuyW3VCG51kWYVBHrXlYomuqAddun92xYgUSoeT9XZL
        G09jJ5K2T0tOfB0acaQikMQt+NcHnwBh7ZpK+SzHwf3X+mb3cgpMeX/EL8bsRUXLERxZjRX7mfQSv
        AV4bHuhg==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qEuOA-001W9Q-33;
        Thu, 29 Jun 2023 16:20:58 +0000
Message-ID: <599ba86b-1f33-4ba2-5781-cd98ecfa985c@infradead.org>
Date:   Thu, 29 Jun 2023 09:20:56 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH] umh: fix build warning with CONFIG_SYSCTL disabled
Content-Language: en-US
To:     Matteo Rizzo <matteorizzo@google.com>, jarkko@kernel.org,
        mcgrof@kernel.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>
References: <20230629161044.1995505-1-matteorizzo@google.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230629161044.1995505-1-matteorizzo@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 6/29/23 09:10, Matteo Rizzo wrote:
> When CONFIG_SYSCTL is not defined proc_cap_handler is not used. This
> causes a build warning with -Wunused-function.
> 
> kernel/umh.c:497:12: error: unused function 'proc_cap_handler'
> [-Werror,-Wunused-function]
> static int proc_cap_handler(struct ctl_table *table, int write,
>            ^
> 1 error generated.
> 
> Fixes: 861dc0b46432 ("sysctl: move umh sysctl registration to its own file")
> Signed-off-by: Matteo Rizzo <matteorizzo@google.com>

Arnd sent this same patch on 2023-June-07.

I have been wondering why it has not been merged...

> ---
>  kernel/umh.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/umh.c b/kernel/umh.c
> index 41088c5c39fd..1b13c5d34624 100644
> --- a/kernel/umh.c
> +++ b/kernel/umh.c
> @@ -494,6 +494,7 @@ int call_usermodehelper(const char *path, char **argv, char **envp, int wait)
>  }
>  EXPORT_SYMBOL(call_usermodehelper);
>  
> +#if defined(CONFIG_SYSCTL)
>  static int proc_cap_handler(struct ctl_table *table, int write,
>  			 void *buffer, size_t *lenp, loff_t *ppos)
>  {
> @@ -544,7 +545,6 @@ static int proc_cap_handler(struct ctl_table *table, int write,
>  	return 0;
>  }
>  
> -#if defined(CONFIG_SYSCTL)
>  static struct ctl_table usermodehelper_table[] = {
>  	{
>  		.procname	= "bset",

thanks.
-- 
~Randy
