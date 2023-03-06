Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22D1A6AB944
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 10:07:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbjCFJHi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 04:07:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbjCFJHd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 04:07:33 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAF221F5EF;
        Mon,  6 Mar 2023 01:07:31 -0800 (PST)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1pZ6oZ-0007Rz-WC; Mon, 06 Mar 2023 10:07:28 +0100
Message-ID: <b12d433e-62ea-3ac4-dd97-be0288f1335f@leemhuis.info>
Date:   Mon, 6 Mar 2023 10:07:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Content-Language: en-US, de-DE
To:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        regressions@lists.linux.dev
References: <1a788a8e7ba8a2063df08668f565efa832016032.1678021408.git.linux@leemhuis.info>
 <ZAVp6jdeWzYcisUO@debian.me>
 <3d6a30ee-f093-f5b6-a193-cd86320f9452@leemhuis.info>
 <f53f84b5-9da7-0726-2e1f-f7e81e8ecd24@gmail.com>
From:   Thorsten Leemhuis <linux@leemhuis.info>
Subject: Re: [PATCH v3] docs: describe how to quickly build a trimmed kernel
In-Reply-To: <f53f84b5-9da7-0726-2e1f-f7e81e8ecd24@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1678093652;e0a85556;
X-HE-SMSGID: 1pZ6oZ-0007Rz-WC
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06.03.23 09:57, Bagas Sanjaya wrote:
> On 3/6/23 12:40, Thorsten Leemhuis wrote:
>>> If your distro config have ``CONFIG_IKCONFIG=y``, you can copy from
>>> procfs::
>>>
>>>     zcat /proc/config.gz > .config
>> <snipped>
>>
>>> If it isn't the case, you may want to enable the aforementioned config
>>> option.
>>
>> That or put them in /boot/config-$(uname -r). But well, that is
>> something the provider of the running kernel needs to do, so it won't
>> help the reader if we mention it here.
>>
>> Or do you think the guide should explain this to ensure people can
>> pickup their config from there again in case they deleted their build
>> artifacts? Hmmm. I currently tend to think that's not worth making the
>> text longer for, as at that point it might be better to restart from
>> scratch with a distro config anyway.
>>
> 
> I think it depends whether someone would pick from /proc/config.gz or
> /boot/config. My kernel configuration have CONFIG_IKCONFIG=y but I
> often copy the config from the latter instead, since I booted with
> arbitrary kernel version when compiling two or three versions, and I
> want to ensure that the config used is from correct version (i.e.
> I use /boot/config-5.15.x-string to build 5.15.x+1 kernel).

Well, I'd say for most users the file that was automatically picked up
by olddefconfig/localmodconfig will be the right one. And for cases like
yours there is already this in the text:

```
The make targets try to find the configuration for your running kernel
automatically, but might choose poorly. A line like ‘# using defaults
found in /boot/config-6.0.7-250.fc36.x86_64’ or ‘using config:
‘/boot/config-6.0.7-250.fc36.x86_64’ tells you which file they picked.
If that is not the intended one, simply store it as ‘~/linux/.config’
before using these make targets.
```

Or am I missing something?

Ciao, Thorsten
