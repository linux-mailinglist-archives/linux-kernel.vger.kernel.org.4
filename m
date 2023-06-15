Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0499730D82
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 05:27:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236382AbjFOD1A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 23:27:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237918AbjFOD0x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 23:26:53 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CEFE2682;
        Wed, 14 Jun 2023 20:26:49 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4QhSPm1K9Bz4wjB;
        Thu, 15 Jun 2023 13:26:36 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1686799607;
        bh=bmc6oqF5FNKBZGg1/rZAHOUSx4X5esqFgaD2hQBXRq8=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=KB2FyunhTuXf+jozautVWXZthKKCB+waS3cucwpJbJk0s24v4KKDQVWgg9Q1V6jR3
         0vEX2OWPXK/8QOdVINYGXUEXFhmEMCe6tR8/kJ2gs4NvUNlqzJka9/WRx2Av26B2bo
         vITH1k1S5enB4XE2YnFXxPCt6IWEd6YUcRno10b5k49kD4HUIdaDZUg9pyurS1KRTV
         HGZpbW1b+az+ld9IyfWGAhCPNIYxUEB/mIcl6YmKDvB1j32ka+tFJzfZQQ8K4TE/RF
         jdgpZreP8tke/E0lPR+QDG6MJzN4Q+6VqMmtmB3YLVvYFkFLRyyYqL9Imhecexc6g6
         0X6N/8mTgEXyA==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Eric DeVolder <eric.devolder@oracle.com>,
        Kees Cook <keescook@chromium.org>
Cc:     linux@armlinux.org.uk, catalin.marinas@arm.com, will@kernel.org,
        chenhuacai@kernel.org, geert@linux-m68k.org,
        tsbogend@alpha.franken.de, James.Bottomley@hansenpartnership.com,
        deller@gmx.de, ysato@users.sourceforge.jp, dalias@libc.org,
        glaubitz@physik.fu-berlin.de, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-ia64@vger.kernel.org, loongarch@lists.linux.dev,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, kernel@xen0n.name, npiggin@gmail.com,
        christophe.leroy@csgroup.eu, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu, hca@linux.ibm.com,
        gor@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com, hpa@zytor.com,
        paulmck@kernel.org, peterz@infradead.org, frederic@kernel.org,
        akpm@linux-foundation.org, ardb@kernel.org,
        samitolvanen@google.com, juerg.haefliger@canonical.com,
        arnd@arndb.de, rmk+kernel@armlinux.org.uk,
        linus.walleij@linaro.org, sebastian.reichel@collabora.com,
        rppt@kernel.org, kirill.shutemov@linux.intel.com,
        anshuman.khandual@arm.com, ziy@nvidia.com, masahiroy@kernel.org,
        ndesaulniers@google.com, mhiramat@kernel.org, ojeda@kernel.org,
        thunder.leizhen@huawei.com, xin3.li@intel.com, tj@kernel.org,
        gregkh@linuxfoundation.org, tsi@tuyoix.net, bhe@redhat.com,
        hbathini@linux.ibm.com, sourabhjain@linux.ibm.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
Subject: Re: [PATCH v1 00/21] refactor Kconfig to consolidate KEXEC and
 CRASH options
In-Reply-To: <8a97f096-2bdc-0298-a1c5-8d48dbf94179@oracle.com>
References: <20230612172805.681179-1-eric.devolder@oracle.com>
 <202306131314.EFA558B7@keescook>
 <8a97f096-2bdc-0298-a1c5-8d48dbf94179@oracle.com>
Date:   Thu, 15 Jun 2023 13:26:35 +1000
Message-ID: <87ilbpflsk.fsf@mail.lhotse>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Eric DeVolder <eric.devolder@oracle.com> writes:
> On 6/13/23 15:21, Kees Cook wrote:
>> On Mon, Jun 12, 2023 at 01:27:52PM -0400, Eric DeVolder wrote:
>>> The Kconfig is refactored to consolidate KEXEC and CRASH options from
>>> various arch/<arch>/Kconfig files into new file kernel/Kconfig.kexec.
>> 
>> This looks very nice!
>> 
> Thank you Kees!
>
>>> [...]
>>> - The boolean ARCH_HAS_<option> in effect allows the arch to determine
>>>    when the feature is allowed.  Archs which don't have the feature
>>>    simply do not provide the corresponding ARCH_HAS_<option>.
>>>    For each arch, where there previously were KEXEC and/or CRASH
>>>    options, these have been replaced with the corresponding boolean
>>>    ARCH_HAS_<option>, and an appropriate def_bool statement.
>>>
>>>    For example, if the arch supports KEXEC_FILE, then the
>>>    ARCH_HAS_KEXEC_FILE simply has a 'def_bool y'. This permits the
>>>    KEXEC_FILE option to be available.
>>>
>>>    If the arch has a 'depends on' statement in its original coding
>>>    of the option, then that expression becomes part of the def_bool
>>>    expression. For example, arm64 had:
>>>
>>>    config KEXEC
>>>      depends on PM_SLEEP_SMP
>>>
>>>    and in this solution, this converts to:
>>>
>>>    config ARCH_HAS_KEXEC
>>>      def_bool PM_SLEEP_SMP
>>>
>>>
>>> - In order to account for the differences in the config coding for
>>>    the three common options, the ARCH_SUPPORTS_<option> is used.
>>>    This options has a 'depends on <option>' statement to couple it
>>>    to the main option, and from there can insert the differences
>>>    from the common option and the arch original coding of that option.
>>>
>>>    For example, a few archs enable CRYPTO and CRYTPO_SHA256 for
>>>    KEXEC_FILE. These require a ARCH_SUPPORTS_KEXEC_FILE and
>>>    'select CRYPTO' and 'select CRYPTO_SHA256' statements.
>> 
>> Naming nit: "HAS" and "SUPPORTS" feel very similar, and looking at
>> existing configs, "ARCH_SUPPORTS_..." is already used for doing this
>> kind of bare "bool" management. e.g. see ARCH_SUPPORTS_INT128
>> 
>> It looks like you need to split "depends" and "select" so the options
>> can be chosen separately from the "selectable" configs.
>> 
>> How about naming this ARCH_SELECTS_<option>, since that's what it's
>> there for?
>> 
> I'm OK with this. Let's see if others agree?

Yeah please rename one or both of them. At a glance the difference
between HAS and SUPPORTS is very non-obvious.

I like Kees' suggestion to use ARCH_SUPPORTS and ARCH_SELECTS.

cheers
