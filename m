Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FFCC64DB2C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 13:30:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbiLOM36 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 07:29:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbiLOM34 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 07:29:56 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1B49630B
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 04:29:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671107353;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=azxeLNToEWGXGUFEKotp2Hg2gxmsr4NhJhcqNr+au/c=;
        b=BDV7z3ws1DvEt/RFn26zjyytFevoexa+BfmLsQeg+BrJBtRI92D+MosTzuNN3n3eNTs29Q
        FP8UEaAWWLqCpvBDaL/P8sLHAXVUjvpK+zrDHlerCFC2/i5thnbEn6GzzT/zxdjeV39RzQ
        lBnlm6I5HAHdTdDQDqGMZ5BmCU0OT3E=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-267-QVvP-mveMLqOgOHHDbEJ-Q-1; Thu, 15 Dec 2022 07:29:08 -0500
X-MC-Unique: QVvP-mveMLqOgOHHDbEJ-Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CB502299E74A;
        Thu, 15 Dec 2022 12:29:06 +0000 (UTC)
Received: from oldenburg.str.redhat.com (unknown [10.2.16.5])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 38B281121314;
        Thu, 15 Dec 2022 12:29:03 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Cc:     Darius Rad <darius@bluespec.com>,
        Vineet Gupta <vineetg@rivosinc.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Andrew Waterman <andrew@sifive.com>, stillson@rivosinc.com,
        Paul Walmsley <paul.walmsley@sifive.com>, anup@brainfault.org,
        atishp@atishpatra.org, guoren@kernel.org,
        Conor Dooley <conor.dooley@microchip.com>,
        greentime.hu@sifive.com, vincent.chen@sifive.com,
        andy.chiu@sifive.com, arnd@kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        libc-alpha@sourceware.org, christoph.muellner@vrull.eu,
        Aaron Durbin <adurbin@rivosinc.com>, linux@rivosinc.com
Subject: Re: RISCV Vector unit disabled by default for new task (was Re:
 [PATCH v12 17/17] riscv: prctl to enable vector commands)
References: <mhng-975b1d7b-7b3f-4e88-804c-8b22787f9588@palmer-ri-x1c9>
        <e9cf13a9-561a-3438-00f0-41fe2631888d@rivosinc.com>
        <Y5irn63DQkwumfvW@bruce.bluespec.com>
        <8fe9cfaf-2cbc-8de6-3928-067de9113bfc@rivosinc.com>
        <Y5qByfCtpV0uNID3@bruce.bluespec.com>
        <877cysx4yf.fsf@all.your.base.are.belong.to.us>
Date:   Thu, 15 Dec 2022 13:28:59 +0100
In-Reply-To: <877cysx4yf.fsf@all.your.base.are.belong.to.us>
 (=?utf-8?Q?=22Bj=C3=B6rn_T=C3=B6pel=22's?=
        message of "Thu, 15 Dec 2022 12:48:56 +0100")
Message-ID: <87h6xwdf5g.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Bj=C3=B6rn T=C3=B6pel:

>> For SVE, it is in fact disabled by default in the kernel.  When a thread
>> executes the first SVE instruction, it will cause an exception, the kern=
el
>> will allocate memory for SVE state and enable TIF_SVE.  Further use of S=
VE
>> instructions will proceed without exceptions.  Although SVE is disabled =
by
>> default, it is enabled automatically.  Since this is done automatically
>> during an exception handler, there is no opportunity for memory allocati=
on
>> errors to be reported, as there are in the AMX case.
>
> Glibc has an SVE optimized memcpy, right? Doesn't that mean that pretty
> much all processes on an SVE capable system will enable SVE (lazily)? If
> so, that's close to "enabled by default" (unless SVE is disabled system
> wide).

Yes, see sysdeps/aarch64/multiarch/memcpy.c:

  static inline __typeof (__redirect_memcpy) *
  select_memcpy_ifunc (void)
  {
    INIT_ARCH ();
=20=20
    if (sve && HAVE_AARCH64_SVE_ASM)
      {
        if (IS_A64FX (midr))
          return __memcpy_a64fx;
        return __memcpy_sve;
      }
=20=20
    if (IS_THUNDERX (midr))
      return __memcpy_thunderx;
=20=20
    if (IS_THUNDERX2 (midr) || IS_THUNDERX2PA (midr))
      return __memcpy_thunderx2;
=20=20
    if (IS_FALKOR (midr) || IS_PHECDA (midr))
      return __memcpy_falkor;
=20=20
    return __memcpy_generic;
  }
=20=20
And the __memcpy_sve implementation actually uses SVE.

If there were a prctl to select the vector width and enable the vector
extension, we'd have to pick a width in glibc anyway.  Likewise for any
other libc, the Go runtime, and so on.  That's why I think the kernel is
in a better position to handle this.

> AMX is a bit different from SVE and V; SVE/V is/would be used by glibc
> for memcpy and such, where I doubt that AMX would be used there. Then
> again, there's AVX512 which many argue that "turned on by default" was a
> mistake (ABI breakage/power consumption).

I don't think AMX is useful for string operations or the math functions
currently implemented in glibc.

Not everything in AVX-512 has high power consumption on relevant CPUs.
Furthermore, the extra registers that don't need VZEROUPPER help us to
avoid transactions aborts in RTM mode.  If we had to enable AVX-512
explicitly in every process, I'm not sure if we would be using it today.
The complicated choices around AVX-512 (and AVX2 for earlier CPUs)
aren't particularly unique.  These functions have different trade-offs
(optimizing for single thread/single process usage vs global system
behavior) on other architectures, too.

> There will likely be V support in glibc (str*/mem*). For systems that
> prefer having V "always-on", the UX of requiring all binaries to
> explicitly call prctl() is not great (as Andrew pointed out in earlier
> posts). A V knob based on some system policy in crt0? :-P

It wouldn't be in crt0 (statically linked), it would be in the dynamic
loader.  So not quite as bad if policy revisions are required.  But
glibc is not the only provider of userspace startup code, so future
tuning of userspace policy will remain complicated.

Thanks,
Florian

