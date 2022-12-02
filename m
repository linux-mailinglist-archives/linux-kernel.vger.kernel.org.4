Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76ACD64101C
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 22:40:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234654AbiLBVkl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 16:40:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233541AbiLBVkj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 16:40:39 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E818F117C
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 13:40:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 30BA8B820F4
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 21:40:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8E8EC433D6;
        Fri,  2 Dec 2022 21:40:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670017236;
        bh=xEX1gU5d5g9bK1jwmy+3WggnCkBcnz6d4DOza7/cIbc=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=porFOOad5EGmZHzBA3Qhpg+8BcRIFfHAzCV0N1052+8nhYd/6aRVdM5uku4zkWBfg
         iCa6LZrx3RdgjRfMSsRtaf6eRRLBdpcK/o3ULuDdJDEGjOA9QBBNslBrQHK7CMa/i/
         ABRu3yVa7fUYfYdDJxVPRMUtPePi6viOSUAZNxR55LqFkh7M3yeLMhlTXneHP7zER7
         F2wG6doyj8XuIndIL65C7QtDanuxLvksYEaueg7rXciYIHF55Vrw7AWD/mfOX4RAEa
         qy02oxwOyG0/wPWRy++OpGuCk+DGMPK5vX54TMFjXp5Q45pg7LRaiNexSeIVWZn4gG
         msPVlxSg8/C1A==
Message-ID: <33c88623-b08c-c8b9-e0b6-be8ce5694af0@kernel.org>
Date:   Fri, 2 Dec 2022 13:40:35 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH] ktest.pl minconfig: Unset configs instead of just
 removing them
Content-Language: en-MW
To:     Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20221202115936.016fce23@gandalf.local.home>
From:   John 'Warthog9' Hawley <warthog9@kernel.org>
In-Reply-To: <20221202115936.016fce23@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/2/22 08:59, Steven Rostedt wrote:
> From: Steven Rostedt <rostedt@goodmis.org>
> 
> After a full run of a make_min_config test, I noticed there were a lot of
> CONFIGs still enabled that really should not be. Looking at them, I
> noticed they were all defined as "default y". The issue is that the test
> simple removes the config and re-runs make oldconfig, which enables it
> again because it is set to default 'y'. Instead, explicitly disable the
> config with writing "# CONFIG_FOO is not set" to the file to keep it from
> being set again.
> 
> With this change, one of my box's minconfigs went from 768 configs set,
> down to 521 configs set.
> 
> Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
> ---
>   tools/testing/ktest/ktest.pl | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/ktest/ktest.pl b/tools/testing/ktest/ktest.pl
> index 590518144167..56135e7d2295 100755
> --- a/tools/testing/ktest/ktest.pl
> +++ b/tools/testing/ktest/ktest.pl
> @@ -3775,9 +3775,10 @@ sub test_this_config {
>       # .config to make sure it is missing the config that
>       # we had before
>       my %configs = %min_configs;
> -    delete $configs{$config};
> +    $configs{$config} = "# $config is not set";
>       make_new_config ((values %configs), (values %keep_configs));
>       make_oldconfig;
> +    delete $configs{$config};
>       undef %configs;
>       assign_configs \%configs, $output_config;
>   

Reviewed-by: John 'Warthog9' Hawley (VMware) <warthog9@eaglescrag.net>
