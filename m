Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C94D55E6D02
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 22:27:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbiIVU1F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 16:27:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbiIVU1D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 16:27:03 -0400
Received: from beige.elm.relay.mailchannels.net (beige.elm.relay.mailchannels.net [23.83.212.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03AAC110B0A;
        Thu, 22 Sep 2022 13:26:59 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|siddhesh@gotplt.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id E3806E0D0F;
        Thu, 22 Sep 2022 20:26:58 +0000 (UTC)
Received: from pdx1-sub0-mail-a304 (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 91923E0969;
        Thu, 22 Sep 2022 20:26:57 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1663878417; a=rsa-sha256;
        cv=none;
        b=0N1xJPA19d3g/7XSq1TDi5gK5QkWtsFzlBoGXCXaKgvnAMRo/aSKLz+LvTEZEBb91IUhf4
        kePAdZk1WSHWmBChXjjLfneLYErYDG7l707iyxxT9Q+NlBChNSwRdsVaZh4ea885qCx0lT
        q1eNyzjob9xfRw62+BzzGjxZarqwQKN/EtDk3yAoa4ALlYec5eKKzNoLroq8qxNZihM/gf
        feaR4VUdhOZZcIhJSRfZPGcVLIUgZQac9BEEyclNcpANzLyijIpmSbs3AI34JWKYwxkxbo
        tJqlOJ4s1Cpb4H6D5U/r+sXpx5St1GWwLOaqhjvVpb843hyVGtGTHiuNOyintQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1663878417;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=GWlJfwNbM+RBUcr+LC1OwrrEPQoaeo4v3LxR/u+AkoU=;
        b=MB6IEeJu1fY5/1eQHZb+Y7vQ4KLTdYk7bRAA8r7kxsAMXldDv1OlbcNuO/qcqEWpKHkioV
        mJ3h4b6vxxM5dhbhz6Tp0fGpblIM1Ni3S7AIKVP9XSCvinWb5Uo4X83maamXYrOxnNGwSm
        UFb1oLXnhp/SeqKJRfkQAOV5iNeCAaaBfdyILhCn43N7U5VSoZAc7/wUfzhn0AJ6UzNDos
        Hl3cAjFepbh020PIYMvl9cuhDnZSYtEThzOnQjcHX63u2BncXHH+SbgYuRYlut7bE8aN7J
        U1DPXE5xf9kfcgIhvue2lOb541KMjuwXxHkEaALBVV6g8Lk+g2QIkWU4TloPgA==
ARC-Authentication-Results: i=1;
        rspamd-64f49dbfc4-tqm99;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=siddhesh@gotplt.org
X-Sender-Id: dreamhost|x-authsender|siddhesh@gotplt.org
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|siddhesh@gotplt.org
X-MailChannels-Auth-Id: dreamhost
X-Robust-Thread: 549f3fc70ee53b42_1663878418000_474975912
X-MC-Loop-Signature: 1663878418000:1607438317
X-MC-Ingress-Time: 1663878417999
Received: from pdx1-sub0-mail-a304 (pop.dreamhost.com [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.126.240.206 (trex/6.7.1);
        Thu, 22 Sep 2022 20:26:57 +0000
Received: from [192.168.0.182] (bras-vprn-toroon4834w-lp130-16-184-147-84-238.dsl.bell.ca [184.147.84.238])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: siddhesh@gotplt.org)
        by pdx1-sub0-mail-a304 (Postfix) with ESMTPSA id 4MYRdr0XNtzB3;
        Thu, 22 Sep 2022 13:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gotplt.org;
        s=dreamhost; t=1663878417;
        bh=GWlJfwNbM+RBUcr+LC1OwrrEPQoaeo4v3LxR/u+AkoU=;
        h=Date:Subject:To:Cc:From:Content-Type:Content-Transfer-Encoding;
        b=xynVUy7ve+n+dzMALyLMksOuiXJZJBKdcBotnnpAEYjBA0eEOEW31TrSR/TOQ3Me1
         Idbmw035xgwwfeD89ROdj5SufEP1T6T11GpAmmilp5GKItiERD4BLjBQbWEUbI2g8k
         528SFXG8Q3LY4HWedXr4OnJfBlUKqmoMqIGr+qu1jMNYQv+GYJIjd8xSSIVYKYONcY
         XQBnIpy2Fp4prAcCHlAiMDanzr4Kxa0h2D6VWpNzvElOmi0dJLdwadkahoUQN6C8pj
         whWl6WxIy7PjzKHNYjEOIFleuISRwo9hsQk0tpsLAGewfk93wAOD7HkJOG2oqb00F/
         nBSY8IBdQ5Otg==
Message-ID: <e2a0debe-e99f-2259-1cb9-35193c387c82@gotplt.org>
Date:   Thu, 22 Sep 2022 16:26:54 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 0/4] fortify: Use __builtin_dynamic_object_size() when
 available
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>, linux-hardening@vger.kernel.org
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Arnd Bergmann <arnd@arndb.de>, Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Tom Rix <trix@redhat.com>, Miguel Ojeda <ojeda@kernel.org>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
References: <20220920192202.190793-1-keescook@chromium.org>
From:   Siddhesh Poyarekar <siddhesh@gotplt.org>
In-Reply-To: <20220920192202.190793-1-keescook@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-09-20 15:21, Kees Cook wrote:
> Hi,
> 
> This adjusts CONFIG_FORTIFY_SOURCE's coverage to include greater runtime
> size checking from GCC and Clang's __builtin_dynamic_object_size(), which
> the compilers can track either via code flow or from __alloc_size() hints.
> 

FTR, I ran a linux build using gcc with allyesconfig and 
fortify-metrics[1] to get a sense of how much object size coverage would 
improve with __builtin_dynamic_object_size.  With a total of 3,877 
__builtin_object_size calls, about 11.37% succeed in getting a result 
that is not (size_t)-1.  If they were replaced by 
__builtin_dynamic_object_size as this patch proposes, the success rate 
improves to 16.25%, which is a ~1.4x improvement.

This is a decent improvement by itself but it can be amplified further 
by adding __attribute__((access (...)))[2] to function prototypes and 
definitions, especially for functions that take in buffers and their 
sizes as arguments since __builtin_dynamic_object_size in gcc is capable 
of recognizing that and using it for object size determination (and 
hence to fortify calls) within those functions.

Thanks,
Sid

[1] https://github.com/siddhesh/fortify-metrics
[2] https://gcc.gnu.org/onlinedocs/gcc/Common-Function-Attributes.html
