Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D9E36AB611
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 06:40:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbjCFFka (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 00:40:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbjCFFk1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 00:40:27 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C7D51A49D;
        Sun,  5 Mar 2023 21:40:26 -0800 (PST)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1pZ3a7-0005ht-2J; Mon, 06 Mar 2023 06:40:19 +0100
Message-ID: <3d6a30ee-f093-f5b6-a193-cd86320f9452@leemhuis.info>
Date:   Mon, 6 Mar 2023 06:40:18 +0100
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
From:   Thorsten Leemhuis <linux@leemhuis.info>
Subject: Re: [PATCH v3] docs: describe how to quickly build a trimmed kernel
In-Reply-To: <ZAVp6jdeWzYcisUO@debian.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1678081226;cbc15c05;
X-HE-SMSGID: 1pZ3a7-0005ht-2J
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06.03.23 05:19, Bagas Sanjaya wrote:
> On Sun, Mar 05, 2023 at 02:04:44PM +0100, Thorsten Leemhuis wrote:
>> + * Create the build configuration for your kernel based on an existing
>> +   configuration.
>> +
>> +   If you already prepared such a '.config' file yourself, copy it to
>> +   ~/linux/ and run ``make olddefconfig``.
>> +
>> +   Use the same command, if your distribution or somebody else already tailored
>> +   your running kernel to your or your hardware's needs: the make target
>> +   'olddefconfig' will then try to use that kernel's .config as base.
>> +
>> +   Using this make target is fine for everybody else, too -- but you often can
>> +   save a lot of time by using this command instead::
>> +
>> +     yes "" | make localmodconfig
>> +
>> +   This will try to pick your distribution's kernel as base, but then disable
>> +   modules for any features apparently superfluous for your setup. This will
>> +   reduce the compile time enormously, especially if you are running an
>> +   universal kernel from a commodity Linux distribution.
>> +
>> +   There is a catch: the make target 'localmodconfig' will disable kernel
>> +   features you have not directly or indirectly through some program utilized
>> +   since you booted the system. You can reduce or nearly eliminate that risk by
>> +   using tricks outlined in the reference section; for quick testing purposes
>> +   that risk is often negligible, but it is an aspect you want to keep in mind
>> +   in case your kernel behaves oddly.
> 
> If your distro config have ``CONFIG_IKCONFIG=y``, you can copy from
> procfs::
> 
>     zcat /proc/config.gz > .config

Localmodconfig afaics does that automatically and I'm pretty sure
olddefconfig does that, too (but I didn't check either). So no need to
explain this in the text afaics.

> If it isn't the case, you may want to enable the aforementioned config
> option.

That or put them in /boot/config-$(uname -r). But well, that is
something the provider of the running kernel needs to do, so it won't
help the reader if we mention it here.

Or do you think the guide should explain this to ensure people can
pickup their config from there again in case they deleted their build
artifacts? Hmmm. I currently tend to think that's not worth making the
text longer for, as at that point it might be better to restart from
scratch with a distro config anyway.

Ciao, Thorsten
