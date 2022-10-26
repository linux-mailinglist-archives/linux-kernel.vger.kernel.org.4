Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 839F460E0AA
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 14:31:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233419AbiJZMb2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 08:31:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233245AbiJZMbQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 08:31:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE7CE6D9D8;
        Wed, 26 Oct 2022 05:31:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 69D8B61E97;
        Wed, 26 Oct 2022 12:31:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08690C433C1;
        Wed, 26 Oct 2022 12:31:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666787471;
        bh=UAxsV8P09WzkrdPNh08BKdHmn8oLfrTBFNapEM78kNo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=fA/JWXasghCxaVHDLrB09Gj+o5/sS7Vje1jkXLO2S/yEjho4rL6nmuxnnIkYUBiqR
         MbLJbWk72GBvHeg5ZddQinU8XxKTanNhq8lqwFRHxfjten4w5xZ8xA4TNVEi3svDBM
         MkmJe/0pmK2JSI3NtJsEasiO3wd5ne/F/a9YzRv4QoINnDra+sx7nUGbBcw5XcfesK
         cEH3THbvY6Vp2WpH0aBF8ntwlKgl3td+8X9CKPE0ORCnR4f1XbC+qS4BdJecVsNG2R
         LAC9zxhXoxE/A3Xw2gnujpC+nyJxeaRB83MkspXOVDv35cNGpZGZ5qXs1DcX0I6iqU
         wSddhUgyEcwVQ==
Message-ID: <dec2d423-9f22-e172-abe7-29a9dad8cf12@kernel.org>
Date:   Wed, 26 Oct 2022 14:31:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH 2/3] tools/rv: Add in-kernel monitor interface
To:     Steven Rostedt <rostedt@goodmis.org>,
        linux-trace-devel@vger.kernel.org
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <cover.1666776642.git.bristot@kernel.org>
 <d52a15b93acb15142551b8e84ff4bcd934de22ce.1666776642.git.bristot@kernel.org>
Content-Language: en-US
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
In-Reply-To: <d52a15b93acb15142551b8e84ff4bcd934de22ce.1666776642.git.bristot@kernel.org>
Content-Type: text/plain; charset=UTF-8
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

On 10/26/22 12:44, Daniel Bristot de Oliveira wrote:
> Add the ability to control and trace in-kernel monitors. This is
> a generic interface, it will check for existing monitors and enable
> standard setup, like enabling reactors.

Oops, forgot to add spaces before #

> For example:
> 

 # rv list
> wip                      wakeup in preemptive per-cpu testing monitor. [OFF]
> wwnr                     wakeup while not running per-task testing model. [OFF]

 # rv mon wip --help
> 
>   help:
> 
>   usage: rv mon wwnr [-h] [-q] [-r reactor] [-s] [-v]
> 	-h/--help: print this menu and the reactor list
> 	-r/--reactor 'reactor': enables the 'reactor'
> 	-s/--self: when tracing (-t), also trace rv command
> 	-t/--trace: trace monitor's event
> 	-v/--verbose: print debug messages
> 
>   available reactors: nop printk panic

 # rv mon wip --trace
>           <TASK>-PID      [CPU]  TYPE       ID                    STATE x EVENT                    -> NEXT_STATE               FINAL
>               |   |          |     |        |                        |     |                           |                       |
>               rv-3613     [001] event     3613                  running x switch_out               -> not_running              Y
>             sshd-1248     [005] event     1248                  running x switch_out               -> not_running              Y
>           <idle>-0        [005] event       71              not_running x wakeup                   -> not_running              Y
>           <idle>-0        [005] event       71              not_running x switch_in                -> running                  N
>       kcompactd0-71       [005] event       71                  running x switch_out               -> not_running              Y
>           <idle>-0        [000] event      860              not_running x wakeup                   -> not_running              Y
>           <idle>-0        [000] event      860              not_running x switch_in                -> running                  N
>     systemd-oomd-860      [000] event      860                  running x switch_out               -> not_running              Y
>           <idle>-0        [000] event      860              not_running x wakeup                   -> not_running              Y
>           <idle>-0        [000] event      860              not_running x switch_in                -> running                  N
>     systemd-oomd-860      [000] event      860                  running x switch_out               -> not_running              Y
>           <idle>-0        [005] event       71              not_running x wakeup                   -> not_running              Y
>           <idle>-0        [005] event       71              not_running x switch_in                -> running                  N
>       kcompactd0-71       [005] event       71                  running x switch_out               -> not_running              Y
>           <idle>-0        [000] event      860              not_running x wakeup                   -> not_running              Y
>           <idle>-0        [000] event      860              not_running x switch_in                -> running                  N
>     systemd-oomd-860      [000] event      860                  running x switch_out               -> not_running              Y
>           <idle>-0        [001] event     3613              not_running x wakeup                   -> not_running              Y
> 
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>

I will fix this log to in the next version.

-- Daniel
