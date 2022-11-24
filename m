Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01E55637E4D
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 18:32:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229500AbiKXRba (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 12:31:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiKXRb3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 12:31:29 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AD6C134108
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 09:31:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C1C00621B1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 17:31:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DA77C433C1;
        Thu, 24 Nov 2022 17:31:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669311087;
        bh=VppZ7d9iMOH7sKJH9n8k65LOO/8jSDoMVN0wLOIpdNE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=jlWYUTkAwr5it7ct0sKRZToUsswIvtTWcrHijxlecPnBBUOUTQL0F7iIQNWkIN4o1
         L1IvRUAaYq7Nm4NpdyCYoKLZGIsV3CnIOFLs/bsRqmF1OqJev9y2qJUAau7yytBZHX
         t7/6sZugPAAKDx+TQPaPM2R3q/uZPm5bhfnq3YAScZVeyfIAjenQEfxVFo5Ig3XT7R
         1lwCikOcXkfHLg+GxTWUCXwfJQnzljTEOhhhbSIFdokkChHqrxJgAnUXBWGyE1nS0m
         FrjG4wgpEoGRkGBH5CXUoMNvi2N0Yn/oAy81N+18KneDcD9sqY60i4XsZJOSmjhOQv
         /uroPFrZrjJcw==
Message-ID: <8cc1c8a0-7d2c-e653-2ab9-40d040eebbb3@kernel.org>
Date:   Thu, 24 Nov 2022 18:31:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [for-next][PATCH 05/11] tracing/osnoise: Add osnoise/options file
Content-Language: en-US
To:     Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>
References: <20221124145019.782980678@goodmis.org>
 <20221124145046.156919074@goodmis.org>
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
In-Reply-To: <20221124145046.156919074@goodmis.org>
Content-Type: text/plain; charset=UTF-8
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

On 11/24/22 15:50, Steven Rostedt wrote:
> From: Daniel Bristot de Oliveira <bristot@kernel.org>
> 
> Add the tracing/osnoise/options file to control
> osnoise/timerlat tracer features. It is a single
> file to contain multiple features, similar to
> the sched/features file.
> 
> Reading the file displays a list of options. Writing
> the OPTION_NAME enables it, writing NO_OPTION_NAME disables
> it.
> 
> The DEAFULTS is a particular option that resets the options
> to the default ones.
> 
> It uses a bitmask to keep track of the status of the option. When
> needed, we can add a list of static keys, but for now
> it does not justify the memory increase.
> 
> Link: https://lkml.kernel.org/r/f8d34aefdb225d2603fcb4c02a120832a0cd3339.1668692096.git.bristot@kernel.org


Hi Steve,

Yesterday I sent a v2 of this patch series, adding some more options [1].

But as you already queued these, and as there is no real difference from the
v1 and v2 in these code patches, I think the best way is for me to send a v3
with the additional patches, build on top of the ftrace/core.

(Is it a bad idea? let me know :-))

[1] https://lore.kernel.org/lkml/cover.1669115208.git.bristot@kernel.org/ 

-- Daniel

