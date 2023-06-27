Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EA5973FB87
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 13:59:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231665AbjF0L67 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 07:58:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231246AbjF0L6v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 07:58:51 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D66C1722;
        Tue, 27 Jun 2023 04:58:50 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Qr3C80dbtz4w2B;
        Tue, 27 Jun 2023 21:58:44 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1687867125;
        bh=DMI9usNvrSNruiGgU2vzUgMO0263STXJtbXbh2Pjm34=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=ZRT/Gwxnf/muFUzbV5/CYYrQkOzC8ev8SYk0jjQnrKFoNQvUIPLqlVZszNK6wFfo1
         aOSj5NXpgg9OX0qwloCURm8hXaV+bvKXM+P0qawrSdIjYxNv2kNkE4wgHN65sXnPZJ
         dF4nTWdJ22meg+mIX7/z05PKjhqPk5jfhVkoZ5ga283XvhPBB+SMPd83TnBYNczzOh
         jytqtVXtg6sACDOUbPkxVhvfVJeeTP7IGqjYvGEGAsKMRDu1RNiG59P8UzS3YeKdnx
         sEvH9GCQTLzuQixXGRjHEpRch8QrT6HiQ7UM44Jr2zMAWNQN9Gnhdh8peSJXfB1DpS
         I0e+PZzSc8WKQ==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Joel Stanley <joel@jms.id.au>, linuxppc-dev@lists.ozlabs.org
Cc:     linux-kbuild@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org, Nicolas Schier <nicolas@fjasle.eu>
Subject: Re: [PATCH] powerpc: remove checks for binutils older than 2.25
In-Reply-To: <CAK7LNAS=UCo_o-B0mgsR+SDb0sYwvQo90uag5sJ1UmB+8NqLjQ@mail.gmail.com>
References: <20230119082250.151485-1-masahiroy@kernel.org>
 <CACPK8XeGsWN+2L57=dfQWOTSo8df7_qrxhwvV4Ho0rkhV=0vSw@mail.gmail.com>
 <CAK7LNAQWtDHOs=K+qznt5U1WiDv86tChkj4zOer4wtVRB974OA@mail.gmail.com>
 <CAK7LNAS=UCo_o-B0mgsR+SDb0sYwvQo90uag5sJ1UmB+8NqLjQ@mail.gmail.com>
Date:   Tue, 27 Jun 2023 21:58:39 +1000
Message-ID: <87h6qtglqo.fsf@mail.lhotse>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Masahiro Yamada <masahiroy@kernel.org> writes:
> On Thu, Jan 19, 2023 at 9:37=E2=80=AFPM Masahiro Yamada <masahiroy@kernel=
.org> wrote:
>>
>> On Thu, Jan 19, 2023 at 9:12 PM Joel Stanley <joel@jms.id.au> wrote:
>> >
>> > On Thu, 19 Jan 2023 at 08:24, Masahiro Yamada <masahiroy@kernel.org> w=
rote:
>> > >
>> > > Commit e4412739472b ("Documentation: raise minimum supported version=
 of
>> > > binutils to 2.25") allows us to remove the checks for old binutils.
>> > >
>> > > There is no more user for ld-ifversion. Remove it as well.
>> >
>> > ppc kernels fail to link with 2.27 under some configurations:
>> >
>> >  https://github.com/linuxppc/issues/issues/388
>> >
>> > We may want to use ld-ifversion to exclude that version.
>>
>
> Ping?

Sorry. I've now applied the binutils 2.27 patch from Naveen, and this on
top with minor tweaks to make it apply. The result is in my next branch.

https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git/commit/?h=
=3Dnext

cheers
