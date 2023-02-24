Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A5F86A1ED2
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 16:45:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbjBXPp1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 10:45:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjBXPpZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 10:45:25 -0500
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B8574A1DB;
        Fri, 24 Feb 2023 07:45:22 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: lina@asahilina.net)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 37BBA3FB17;
        Fri, 24 Feb 2023 15:45:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=asahilina.net;
        s=default; t=1677253521;
        bh=XJayZUdEhDtog5j7yqj8/MyMgPGm4QWOPiFPBxnyZ58=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=oqQsQ+iGjxejaNfyX5CHW2JHh5E+CHJihtTuh5VtJKs3DkwpQvDCW7sQWPRW3OJ7K
         pnTTr81oZuUw54MKm16//MnvzIi+Nf8a7Nxam23/ZAEvfya6/wKTEjga2fzuTsF2zS
         Riz+D0jtz9HxQxqzptup1jCb9k0DOPdTAORk5Snn3W9kPIocaKr8gTaWq/AquBnfot
         lpFxjamb5rDGYMcT5Fvjw7vdW0PvX+3C7qaatrb5ed0E5J9oa729+ItbIJ5ThsLyDM
         hB8Ur9ZNBNrNqeJCwEaPHLNf7YLXNZ0S30qu1ngztmZI5cToyc4lcBBd4rz1OwtNA3
         xB1h6ZMaxn/2Q==
Message-ID: <d7bba84e-2052-ccf9-7934-c87d8ae63136@asahilina.net>
Date:   Sat, 25 Feb 2023 00:45:14 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 2/5] rust: device: Add a minimal RawDevice trait
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=c3=b6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>, Arnd Bergmann <arnd@arndb.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Neal Gompa <neal@gompa.dev>, rust-for-linux@vger.kernel.org,
        linux-kernel@vger.kernel.org, asahi@lists.linux.dev
References: <20230224-rust-iopt-rtkit-v1-0-49ced3391295@asahilina.net>
 <20230224-rust-iopt-rtkit-v1-2-49ced3391295@asahilina.net>
 <Y/ieQ0UX/niAG1Hg@kroah.com>
 <ef3a3638-6381-87ab-d674-644306b6b6ce@asahilina.net>
 <Y/jFeZzZVCpBGvGv@kroah.com> <Y/jHeP4LileLYxO8@kroah.com>
 <bbc824ee-ef4e-40cb-f009-0d693d757869@asahilina.net>
 <Y/jW161RuT7OtlSf@kroah.com>
From:   Asahi Lina <lina@asahilina.net>
In-Reply-To: <Y/jW161RuT7OtlSf@kroah.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/02/2023 00.25, Greg Kroah-Hartman wrote:
> On Fri, Feb 24, 2023 at 11:44:59PM +0900, Asahi Lina wrote:
>> On 2023/02/24 23:19, Greg Kroah-Hartman wrote:>> Can we see some users
>> of this code posted so I can see how struct device
>>>> is going to work in a rust driver?  That's the thing I worry most about
>>>> the rust/C interaction here as we have two different ways of thinking
>>>> about reference counts from the two worlds and putting them together is
>>>> going to be "interesting", as can be seen here already.
>>>
>>> Also, where are you getting your 'struct device' from in the first
>>> place?  What bus is createing it and giving it to your rust driver?
>>
>> That would be platform for my GPU driver, matched via OF compatible.
> 
> Ick, a platform device?  The GPU isn't on the PCI bus?  Wow, that's
> horrid...

The internal NVMe controller also isn't on the PCI bus (which is worse
since that actually has standard PCI bindings)... nothing is on PCI
buses other than external PCI/Thunderbolt devices. There are no internal
fake-PCI devices on Apple Silicon like there are on Intel. That's how it
is on most SoCs (though Apple is the only vendor who has dared to go as
far as integrating NVMe as far as I know)...

~~ Lina
