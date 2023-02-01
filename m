Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1E7E68707C
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 22:30:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230080AbjBAVa4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 16:30:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbjBAVay (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 16:30:54 -0500
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5308C1BAC8
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 13:30:53 -0800 (PST)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-142b72a728fso8749fac.9
        for <linux-kernel@vger.kernel.org>; Wed, 01 Feb 2023 13:30:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NgdKD3H9mgDQON/t2X8SjCaChArekQATvJoWKyGZGmg=;
        b=kGsB4KzVW1jc2YXqJosMPeTO2nwtwE+Pi8H5Nihpr7hdI70Gfnpd7EYcbnuRmfN4oI
         k8rP11hJaeVh2WXcHpCPkPj0oGpo9YvPTnOfytuNu3/yOW+unXDm/b+vPMT294oOJCYt
         lFO3id921nCiRTmJzjmEIn7F+oBm9ZzDFsrRjXHwcO/ObsZc2RfakZGDz2kG171Ge+Yi
         j/zgK2sbdFt0HsJTvqngQLyJKRCPKmXaFmG0jko8nHK0wyQQy0KlW0QUBIPagcu/fUUv
         HHEl0CaVlEKKwgLFYyOTMrUkzc/KG6zka/McVW5GgJZ/cj4ApW9cD1RsC7Vgbu22RE6V
         kv0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NgdKD3H9mgDQON/t2X8SjCaChArekQATvJoWKyGZGmg=;
        b=hI3hMSba0SBXwWH3EJ7K2KfKLZJ/gbFc8t8ipw27iAN1Gg3gmLH1+91+M/nZucCb9l
         16hjQ+3cP+tf6f4FHzhVP/6GW0XnDWEB+1ncy7Jn9m26Ow4nC7zooVF2iE9zNRbuJv2b
         Xyi5jNPEcqXlH9wC2pV2EqgLO8mY8MYXEc7nZXvtzQDTTDiIpyRknWWV4LtuH5uZAYoV
         GYCkqNonosg6VyeRmH/tyqCmBbfBQ1Kd5yIBtYIzL6XQF2J3IHhSQ7fwm/1yt0+GeIeO
         KdqODt1YNReWGX34G1FSQSqDg/iIjC8fORICcaGF5cfpHxa9w8JkxJdCQZJRfcljevAH
         nDiw==
X-Gm-Message-State: AO0yUKUqyp9rU9GgqW0eQ7whcfjWVUA/+dLywlZJt4lpI7ey96a+Z+BV
        sGnbCXTz6CibjdNpRI+7KxQFBbQJAvc=
X-Google-Smtp-Source: AK7set/QY/d1daC9EZmHAbAPWtWblcaHg1zYZUGoOPEAVYWsLI9zt0KS8QpjZyhiqwDgedrpVw5vDg==
X-Received: by 2002:a05:6870:c69a:b0:15b:9ee2:4c36 with SMTP id cv26-20020a056870c69a00b0015b9ee24c36mr2298513oab.35.1675287052193;
        Wed, 01 Feb 2023 13:30:52 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id ny9-20020a056870be0900b001631c92e8b6sm8324563oab.4.2023.02.01.13.30.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 13:30:51 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 1 Feb 2023 13:30:49 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     linux-kernel@vger.kernel.org
Subject: Re: OOM on objtool when building x86_64:allyesconfig on system
 running v6.1.x kernels
Message-ID: <20230201213049.GA3192152@roeck-us.net>
References: <20230123231101.GA3398733@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230123231101.GA3398733@roeck-us.net>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 23, 2023 at 03:11:03PM -0800, Guenter Roeck wrote:
> Hi all,
> 
> when trying to build x86_64:allyesconfig on a system running v6.1.x kernels
> (currently 6.1.7), I keep getting OOM errors in objtool.
> 
> [360871.492187] objtool invoked oom-killer: gfp_mask=0x140dca(GFP_HIGHUSER_MOVABLE|__GFP_COMP|__GFP_ZERO), order=0, oom_score_adj=0
> [360871.492194] CPU: 4 PID: 1158479 Comm: objtool Not tainted 6.1.7-spi+ #1
> [360871.492196] Hardware name: Micro-Star International Co., Ltd. MS-7B89/B450M MORTAR MAX (MS-7B89), BIOS 2.H0 07/27/2022
> [360871.492198] Call Trace:
> [360871.492199]  <TASK>
> [360871.492202]  dump_stack_lvl+0x49/0x63
> [360871.492206]  dump_stack+0x10/0x16
> [360871.492207]  dump_header+0x4f/0x216
> [360871.492209]  oom_kill_process.cold+0xb/0x10
> [360871.492211]  out_of_memory+0x1cf/0x520
> ...
> [360871.492254] Mem-Info:
> [360871.492256] active_anon:743423 inactive_anon:6755060 isolated_anon:0
>                  active_file:847 inactive_file:1145 isolated_file:0
>                  unevictable:665 dirty:8 writeback:0
>                  slab_reclaimable:475477 slab_unreclaimable:69268
>                  mapped:2213 shmem:760735 pagetables:16035
>                  sec_pagetables:0 bounce:0
>                  kernel_misc_reclaimable:0
>                  free:92647 free_pcp:10 free_cma:0
> ...
> [360871.492446] Out of memory: Killed process 1158479 (objtool) total-vm:25987600kB, anon-rss:25766820kB, file-rss:1444kB, shmem-rss:180kB, UID:1000 pgtables:50464kB oom_score_adj:0
> 
> The system has 32GB of memory. I do not see the problem on other systems
> running v5.15.y kernels, or on the same system before installing a v6.1.x
> kernel. I don't think I have ever seen the problem on the same system
> when trying to build an older kernel either.
> 
> Has anyone else observed a similar problem ? Any idea what might be
> going on, or what I can do to help tracking this down ?
> 

Just to close this: There is nothing special going on ... except
that objtool now requires so much memory (24+ GB) when building
x86_64:allyesconfig that one of my systems simply ran out.
Adding 16GB of swap on that system fixed the problem.

Guenter
