Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DC18730497
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 18:09:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230507AbjFNQJU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 12:09:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230273AbjFNQJR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 12:09:17 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A708A1FC8
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 09:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=qsRJI92Cr6ygcvJHeEVi6gQ8y10LaqKJ15yNeqo7lMM=; b=fC6KX1MRplony2LsSW3jdBN5oE
        D4sBdMsn5Xc7dT2/apIFSYZkr+E2FQp0ehaez9qKFmYzTk16k5PgFQsFIQ/tPuVH0Tpov844N+lk1
        s7EozNtmoBnh3gTBo13M0uyMCGpExZEKI3dLUdwgn+5o2pi0NNKazpFTGCu4ho+I4gNXyVw6XxkWo
        M8WrAHn6gIW6S2dThq6h1Zp75TE7YRGYwzdPEY/cx2E1j3M5I3L7vQwJaV99tmf1gCPlDX8QUORPh
        ynLew6NT6UimsxTrOd8HNrxHBbiv7R9v/RVqGPfmM2HYoCQBAVNLuDMS1WL8fXdZKukLQpQBRvki0
        M2XWvvog==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q9T3X-00CA7n-0c;
        Wed, 14 Jun 2023 16:09:11 +0000
Message-ID: <5ea2d183-d042-d62e-918a-ab0199331d89@infradead.org>
Date:   Wed, 14 Jun 2023 09:09:10 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH] sysctl: fix unused proc_cap_handler() function warning
Content-Language: en-US
To:     Arnd Bergmann <arnd@kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Huacai Chen <chenhuacai@kernel.org>,
        linux-kernel@vger.kernel.org
References: <20230607120857.3621364-1-arnd@kernel.org>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230607120857.3621364-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/7/23 05:08, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Since usermodehelper_table() is marked static now, we get a
> warning about it being unused when SYSCTL is disabled:
> 
> kernel/umh.c:497:12: error: 'proc_cap_handler' defined but not used [-Werror=unused-function]
> 
> Just move it inside of the same #ifdef.
> 
> Fixes: e6944e3b75df7 ("sysctl: move umh sysctl registration to its own file")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>


Acked-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org> # build-tested

Thanks.

> ---
>  kernel/umh.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/umh.c b/kernel/umh.c
> index d5dc3cc92d5c6..2f9249c2bf6ce 100644
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

-- 
~Randy
