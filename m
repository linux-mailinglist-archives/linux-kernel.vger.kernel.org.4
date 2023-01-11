Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D39A66585B
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 10:58:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235940AbjAKJ6I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 04:58:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238666AbjAKJ5M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 04:57:12 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E34EB499
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 01:54:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 58C9B61BA9
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 09:54:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4861BC433F1;
        Wed, 11 Jan 2023 09:54:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673430893;
        bh=egaZNlCfbk8HNqQyQyW+04UYl+HQzUblbmjTcc12IYg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=i92xkS2YE07YOLe67+GiXOsaso0zuSl8bOvrJJZMIq/5QKsU6cuZl7NwJaYIOotF3
         K7MYw0/OQKIfaEwgRMo7pcptqfQAwQF295ehKamT5l0W26eRzDb4ec/G5TNDbhbTcz
         e3MMNMR1ol79bzjO76NjIaPjO2cfs/Or8H66yyFevIDTA1CipDBNkudlBZmLfhBi9/
         mu416eaX0Zyqs5M2nzfFzCEHk4+bnl3lZct8mQZClU0k1XsO9UvxeCkv1ZRpI6A5bC
         OlvIBFU8HS6pYioKb4mi43mgJBlh4rmoU3n0JhYgUTM1L7TEu2EfzB7kldNix9D8sN
         DUQihRkpcDYJA==
Message-ID: <0acd9312-a4d2-20f0-eeaf-d1410dca48e1@kernel.org>
Date:   Wed, 11 Jan 2023 10:54:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] tracing/osnoise: Use built-in RCU list checking
To:     Chuang Wang <nashuiliang@gmail.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org
References: <20221227023036.784337-1-nashuiliang@gmail.com>
Content-Language: en-US
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
In-Reply-To: <20221227023036.784337-1-nashuiliang@gmail.com>
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

On 12/27/22 03:30, Chuang Wang wrote:
> list_for_each_entry_rcu() has built-in RCU and lock checking.
> 
> Pass cond argument to list_for_each_entry_rcu() to silence false lockdep
> warning when CONFIG_PROVE_RCU_LIST is enabled.
> 
> Execute as follow:
> 
>  [tracing]# echo osnoise > current_tracer
>  [tracing]# echo 1 > tracing_on
>  [tracing]# echo 0 > tracing_on
> 
> The trace_types_lock is held when osnoise_tracer_stop() or
> timerlat_tracer_stop() are called in the non-RCU read side section.
> So, pass lockdep_is_held(&trace_types_lock) to silence false lockdep
> warning.
> 
> Fixes: dae181349f1e ("tracing/osnoise: Support a list of trace_array *tr")
> Signed-off-by: Chuang Wang <nashuiliang@gmail.com>

Acked-by: Daniel Bristot de Oliveira <bristot@kernel.org>

Thanks!
-- Daniel
