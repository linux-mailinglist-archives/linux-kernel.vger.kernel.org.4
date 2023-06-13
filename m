Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26EAA72ECCA
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 22:20:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240992AbjFMUUc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 16:20:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242050AbjFMUUN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 16:20:13 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 676062962;
        Tue, 13 Jun 2023 13:19:42 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686687579;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HE1N4P0d/WhniObXa5GtYC4fEZuwmn5LLuL6Wr0ZtK4=;
        b=Tf3UoS9LopV2MoDkt6mREw6JQ1H92mYf8JJR87y9KFj/g9Y6BCa1QsYyoSYpqQU8Kv513J
        pN4kb9E9e4kjmxzWqS2LDHP3scrieeSc067Bh5mzIcuZNGGRyI6Y3UbzyynDyXRmWCDwC/
        UTYLoIx7oveMp/6/NRRZXvvmsZPcCraBbhAPPeZy7w7QMifJcu7iOfGhCbl81K5+EANJqT
        B3IteW2VL5AvNnkNiS9WdZxIaX7WJQgq/vOtVU9GM3RuqBZKiYvYUssYiwiHsZHBZH5JOJ
        o32Xzk/Q71EPi97vaNCjxCLPhuCVLdS9Xhe8Y95dAsEYHGaFSiuPSqBA+HhiSw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686687579;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HE1N4P0d/WhniObXa5GtYC4fEZuwmn5LLuL6Wr0ZtK4=;
        b=Xp05f34xzTJaqdiVBn9l6bLgZ93PE8JGwnfn3n5pwFY//ykipWNnG09cAq9lqdTQfkJHHL
        3z+xTe5HLaRIWgCA==
To:     Eric DeVolder <eric.devolder@oracle.com>,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, david@redhat.com, osalvador@suse.de,
        corbet@lwn.net, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, bhe@redhat.com,
        ebiederm@xmission.com, kexec@lists.infradead.org, hpa@zytor.com,
        rafael@kernel.org, vgoyal@redhat.com, dyoung@redhat.com,
        lf32.dev@gmail.com, akpm@linux-foundation.org,
        naveen.n.rao@linux.vnet.ibm.com, zohar@linux.ibm.com,
        bhelgaas@google.com, vbabka@suse.cz, tiwai@suse.de,
        seanjc@google.com, linux@weissschuh.net, vschneid@redhat.com,
        linux-mm@kvack.org, linux-doc@vger.kernel.org,
        sourabhjain@linux.ibm.com, konrad.wilk@oracle.com,
        boris.ostrovsky@oracle.com
Subject: Re: [PATCH v23 4/8] crash: memory and CPU hotplug sysfs attributes
In-Reply-To: <40cacc6b-c3d1-c63b-e307-d95b2c53e399@oracle.com>
References: <20230612210712.683175-1-eric.devolder@oracle.com>
 <20230612210712.683175-5-eric.devolder@oracle.com>
 <2023061320-vindicate-usual-6643@gregkh>
 <13118eaa-6fae-7b45-9f3e-ab95e7d34729@oracle.com>
 <40cacc6b-c3d1-c63b-e307-d95b2c53e399@oracle.com>
Date:   Tue, 13 Jun 2023 22:19:39 +0200
Message-ID: <87h6rb6rok.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 13 2023 at 14:58, Eric DeVolder wrote:
> On 6/13/23 10:24, Eric DeVolder wrote:
>> On 6/13/23 03:03, Greg KH wrote:
>>> All of these #ifdefs should all be removed and instead use the
>>> is_visible() callback to determine if the attribute is shown or not,
>>> using the IS_ENABLED() test in the function.
>> 
>> ok, I'll correct this.
>
> I've been examining drivers/base/cacheinfo.c as a template for how to remove the
> #ifdefs and use the is_visible() callback for the drivers/base/cpu|memory.c files.
>
> I'm attempting to apply this technique to drivers/base/cpu.c. In this file, there
> are features that are compiled in/out based on the CONFIG settings, for example 
> CONFIG_ARCH_CPU_PROBE_RELEASE. My attempts at applying the technique thus far have
> resulted in link-time errors for missing symbols, ie. arch_cpu_probe() and
> arch_cpu_release().
>
> As I understand it, to use IS_ENABLED(XYZ) to guard-band conditional code, the contents
> of that code still needs to be compile-able (eg. no references to struct members with
> surrounding #ifdef CONFIG_XYZ) and link-able (eg. any called functions must also be
> compiled).

You can't obviously reference anything which is #ifdeffed out in a data
structure. But functions is a different story. All you needs is a
declaration.

void foo(void);

     if (IS_ENABLED(FOO))
     	foo();

Builds correctly if FOO=n and foo() is not built in. The wonders of dead
code elimination.

Thanks,

        tglx
