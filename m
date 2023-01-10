Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 114A5664310
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 15:20:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234551AbjAJOUA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 09:20:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234592AbjAJOTd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 09:19:33 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AE1E3BEAC;
        Tue, 10 Jan 2023 06:19:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CC54761739;
        Tue, 10 Jan 2023 14:19:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25AF9C433D2;
        Tue, 10 Jan 2023 14:19:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673360369;
        bh=UucVdVB+wlfKnUeQwJ46t2EYD9RTtR+6ghoFcnBQk9s=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=kR4cYIybdVM6YV/C1h1zk/Bax7kJobwpho1wxh9ddp9/dtQgXxta+qP4rAPY2Hz7/
         /u6UFQni2GY4/V24M6MBWCpFzX/sOrcWGF7lb+tGm8oO/flciHwjNArif5y8WcQZUv
         7AJ34Vr1f4BsdQMg2+VJfuF5gJtz/LHSKmFmSRN6RLHFAH22MNqo0CogAwUsEeCcZh
         /kSrQzVfiHreGiQ84gJEZ/r6EwQ07aPxorMJEKNFm93xifnesIn7e7acoysIMZb/nj
         6NBX6E3LmO1pv3JNaRpm/g+iCSfhLNZe3lmzsE6FBy9I3TMzGpoe/9Gg/8R4ncNpGL
         ddF8Z6VXv3Hmg==
Message-ID: <94fd6fb5-c87a-b02e-40bc-b2e2c99529d5@kernel.org>
Date:   Tue, 10 Jan 2023 15:19:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] tools/rtla: Explicitly list libtraceevent dependency
To:     Daniel Wagner <dwagner@suse.de>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        linux-trace-devel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230110131805.16242-1-dwagner@suse.de>
 <42d1e999-79a6-94dc-cc88-77520ddce068@kernel.org>
 <20230110140814.2yz4if2e2fasnu7t@carbon.lan>
Content-Language: en-US
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
In-Reply-To: <20230110140814.2yz4if2e2fasnu7t@carbon.lan>
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

On 1/10/23 15:08, Daniel Wagner wrote:
> On Tue, Jan 10, 2023 at 02:55:03PM +0100, Daniel Bristot de Oliveira wrote:
>> On 1/10/23 14:18, Daniel Wagner wrote:
>>> The current libtracefs.pkg file lists the dependency on
>>> libtraceevent ("pkg-config --libs libtracefs" -> "-ltracefs
>>> -ltraceevent").
>>>
>>> Dan Nicholson's Guide to pkg-config[1] stats that "Libs: The link
>>> flags specific to this package and any required libraries that don't
>>> support pkg-config". Thus the current libtracefs.pkg is not correct.
>>>
>>> rtla is depending on libtraceevent but it doesn't express this in
>>> 'pkg-config' part to retrieve the correct build flags.
>>>
>>> In order to be able to update the "Libs:" section in the libtracefs
>>> project we need to list the dependency explicitly to avoid future linker
>>> failures.
>>
>> I am ok with it. Steve?
> 
> FWIW, this is change is also backwards compatible, meaning if you have system
> which has a libtracefs.pkg installed which lists libtraceevent in its Libs:
> section the 'pkg-config --libs libtracefs libtraceevent' command will return the
> identically string which is '-ltracefs -ltraceevent'.

Yeah, we know it. I've added both in the initial implementation, but Steven suggested
using only libtracefs because it depends on libtraceevent anyways. That is why
I am re-checking with him.

-- Daniel
