Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DE996F297E
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Apr 2023 18:21:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230483AbjD3QVo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Apr 2023 12:21:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230414AbjD3QVm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Apr 2023 12:21:42 -0400
Received: from smtp.smtpout.orange.fr (smtp-23.smtpout.orange.fr [80.12.242.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 446202D48
        for <linux-kernel@vger.kernel.org>; Sun, 30 Apr 2023 09:21:40 -0700 (PDT)
Received: from [192.168.1.18] ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id t9nspEGk8GGqgt9nspRtpg; Sun, 30 Apr 2023 18:21:37 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1682871698;
        bh=DeAGfZvHN94lPiUZiy7bZbEf4KghIhOEFbkJpiyOKIQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=ZJ3ZqHX6UGnsh+HN03vKMp5SOZj+PTWdSOjNmMMGyzCpKtCUWIRncuZTPFek5wv1R
         r8aAxKlRG5rgJ01aVc9/LxTE38riT3NxJSLUzKwVqwili4sBZh0NxWB/oyMxSM5ro1
         CXa8BAlDh/+AhQAgN/PkBGKKHnzwAPlSFYFfjFl/bNgeDcbZbc8DsWqPh5o27QZGo5
         uCi1mQ3FMe0tasUn9sNFeaaIhBESANdi7Q/Oe5bVIb6U87H93wdVwxSMFVVzB/TOSY
         Zfq6UdZWvSjDjXmKmLjqV/rrSS5sU3rYodJay6dsz4qgH1ggiIL96oyudoLk9EBLMP
         OCMUQTOt0W0OQ==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 30 Apr 2023 18:21:37 +0200
X-ME-IP: 86.243.2.178
Message-ID: <10a2d725-7721-f0af-3e2e-de5816730e5d@wanadoo.fr>
Date:   Sun, 30 Apr 2023 18:21:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] spi: Use non-atomic xxx_bit() functions
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-spi@vger.kernel.org
References: <6b8f405145d3d57a8026dc61ca3f1ae70d690990.1682847325.git.christophe.jaillet@wanadoo.fr>
 <ZE6N/oZ5DFI6td/0@finisterre.sirena.org.uk>
Content-Language: fr, en-GB
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <ZE6N/oZ5DFI6td/0@finisterre.sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 30/04/2023 à 17:49, Mark Brown a écrit :
> On Sun, Apr 30, 2023 at 11:35:35AM +0200, Christophe JAILLET wrote:
> 
>> Accesses to 'minors' are guarded by the 'device_list_lock' mutex. So, it is
>> safe to use the non-atomic version of (set|clear)_bit() in the
>> corresponding sections.
> 
> Is it a problem to use the atomic version?

Not at all. It just wastes a few cycles (in a place where it doesn't 
matter).

I spotted it while looking for some other patterns, so I sent a patch 
for it.

> 
>>   	if (status == 0) {
>> -		set_bit(minor, minors);
>> +		__set_bit(minor, minors);
>>   		list_add(&spidev->device_entry, &device_list);
> 
> The __ usually means something is the more complicated and less
> preferred API.

Ok, let keep things as-is and simple then.
Performance doesn't matter here, anyway.

CJ
