Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4962868CF83
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 07:32:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230223AbjBGGca (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 01:32:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229865AbjBGGc1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 01:32:27 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C56F193EA;
        Mon,  6 Feb 2023 22:32:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 1B3AACE1C78;
        Tue,  7 Feb 2023 06:32:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A06F5C433D2;
        Tue,  7 Feb 2023 06:32:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675751542;
        bh=BM31iNLFopS5FV6b55CPDvqToJbz28aRbpAuedR3Wg0=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=PaGOfHg8GAh6cLctTj+gwXlACn71B6RQGviIMwip2g/oq7XsohntDT9cHKQLfn0OU
         ZsWEARVAVvOxE3lZ7MeDaExdM1B9gfE0+mdMugyt9zDF+daBT5sNsBQER1o2ljJ0t1
         iycJPdO62eaWALdOvzCeayx4TICusi6vEbbIRprTM8JV5X0QlnwyC/tbI/4EQ9wHdl
         +e9gldY2f4bmCX3vpWmMF4hqkeIFqQQvHGt8I4nwtSP8WJ0Qqo0MI9g751FujEkjiH
         v/XUIdIVUNa58m+9jG5U6nWlLf3x5TduQodDtfYkLvfYgY3kpe8aQmWlGRiUBxf7t7
         4tqErvkByrhAQ==
Date:   Tue, 07 Feb 2023 06:32:18 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>,
        Evan Green <evan@rivosinc.com>
CC:     Palmer Dabbelt <palmer@rivosinc.com>, vineetg@rivosinc.com,
        heiko@sntech.de, slewis@rivosinc.com,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Bresticker <abrestic@rivosinc.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Atish Patra <atishp@rivosinc.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Celeste Liu <coelacanthus@outlook.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Dao Lu <daolu@rivosinc.com>, Guo Ren <guoren@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Ruizhe Pan <c141028@gmail.com>,
        Sunil V L <sunilvl@ventanamicro.com>,
        Tobias Klauser <tklauser@distanz.ch>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v2 2/6] RISC-V: Add a syscall for HW probing
User-Agent: K-9 Mail for Android
In-Reply-To: <Y+HsE397cY4HF+5K@kroah.com>
References: <20230206201455.1790329-1-evan@rivosinc.com> <20230206201455.1790329-3-evan@rivosinc.com> <Y+HsE397cY4HF+5K@kroah.com>
Message-ID: <C3C21677-5250-4120-9A4F-24945C1EE51B@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Evan, Greg,


On 7 February 2023 06:13:39 GMT, Greg KH <gregkh@linuxfoundation=2Eorg> wr=
ote:
>On Mon, Feb 06, 2023 at 12:14:51PM -0800, Evan Green wrote:
>> We don't have enough space for these all in ELF_HWCAP{,2} and there's n=
o
>> system call that quite does this, so let's just provide an arch-specifi=
c
>> one to probe for hardware capabilities=2E  This currently just provides
>> m{arch,imp,vendor}id, but with the key-value pairs we can pass more in
>> the future=2E
>
>Ick, this is exactly what sysfs is designed to export in a sane way=2E
>Why not just use that instead?  The "key" would be the filename, and the
>value the value read from the filename=2E  If the key is not present, the
>file is not present and it's obvious what is happening, no fancy parsing
>and ABI issues at all=2E

https://lore=2Ekernel=2Eorg/linux-riscv/20221201160614=2Expomlqq2fzpzfmcm@=
kamzik/

This is the sysfs interface that I mentioned drew
suggested on the v1=2E
I think it fits ~perfectly with what Greg is suggesting too=2E

>
>Bonus is that you will also properly document all valid key/value pairs
>in Documentation/ABI/ when you do this, so it reinforces what the code
>should be doing correctly=2E
>
>thanks,
>
>greg k-h
