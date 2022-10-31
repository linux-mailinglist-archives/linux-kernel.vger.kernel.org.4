Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2299E612F69
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 04:56:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229792AbiJaDz6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Oct 2022 23:55:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbiJaDzy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Oct 2022 23:55:54 -0400
Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58B30E49;
        Sun, 30 Oct 2022 20:55:53 -0700 (PDT)
Received: from [192.168.43.182] (unknown [62.168.35.125])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 620A9422D3;
        Mon, 31 Oct 2022 03:55:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1667188550;
        bh=VVJbZrf0diiwoA5FEx2u/I6vnvmh4+0O7MKR0BSmx5Q=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=o+MZYoXRBKxjIz6pKgBIC5GRfmun4LVBcWxoshZGsTJe3z6wUaMieqKothCRNMANC
         dJ1MBxCsU0cqc5iue86xjoD5xIrthoQkWHzTX3EDbL5QS8ly9HZQ/yf/OaNsVPyVSQ
         B4pngtYZQWTq4nHXAe0bGqsmjjy90k9VjYU/hiqEXGjjsDWmfL3ODTDMA35rQrF6qQ
         faAek33UcEiw5S0+EQc/+AWkZuh6DVekHb+2rd3/W9jr99IvhatbcK2Rlo+iEmHzbR
         DaAHNQ4Y9oY32Rf2y8apFXWegy3JO7uVf2q/LT7AbB9VQHkAVokZZz03JHOKHiMPBJ
         RrRfnZt1Z+hhA==
Message-ID: <dac1c2d5-367f-c8a7-c61e-c1774d98d602@canonical.com>
Date:   Sun, 30 Oct 2022 20:55:49 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: apparmor: global buffers spin lock may get contended
Content-Language: en-US
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Tomasz Figa <tfiga@chromium.org>, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org
References: <YO2S+C7Cw7AS7bsg@google.com>
 <cfd5cc6f-5943-2e06-1dbe-f4b4ad5c1fa1@canonical.com>
 <Y19GhTg8Q/3ym/VD@google.com>
From:   John Johansen <john.johansen@canonical.com>
Organization: Canonical
In-Reply-To: <Y19GhTg8Q/3ym/VD@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/30/22 20:52, Sergey Senozhatsky wrote:
> On (22/10/28 02:34), John Johansen wrote:
>>  From d026988196fdbda7234fb87bc3e4aea22edcbaf9 Mon Sep 17 00:00:00 2001
>> From: John Johansen <john.johansen@canonical.com>
>> Date: Tue, 25 Oct 2022 01:18:41 -0700
>> Subject: [PATCH] apparmor: cache buffers on percpu list if there is lock
>>   contention
>>
>> On a heavily loaded machine there can be lock contention on the
>> global buffers lock. Add a percpu list to cache buffers on when
>> lock contention is encountered.
>>
>> When allocating buffers attempt to use cached buffers first,
>> before taking the global buffers lock. When freeing buffers
>> try to put them back to the global list but if contention is
>> encountered, put the buffer on the percpu list.
>>
>> The length of time a buffer is held on the percpu list is dynamically
>> adjusted based on lock contention.  The amount of hold time is rapidly
>> increased and slow ramped down.
>>
>> Signed-off-by: John Johansen <john.johansen@canonical.com>
> 
> Reported-by: Sergey Senozhatsky <senozhatsky@chromium.org>

yep, thanks for catching that

