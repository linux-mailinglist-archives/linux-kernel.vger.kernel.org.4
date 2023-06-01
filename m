Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5949719CA7
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 14:55:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232389AbjFAMzC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 08:55:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232252AbjFAMyw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 08:54:52 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68576124;
        Thu,  1 Jun 2023 05:54:49 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4QX5gm3jPHz4whk;
        Thu,  1 Jun 2023 22:54:44 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1685624085;
        bh=OZ/5HE/soAZZFHMXDiilpjDsIee5iu2+4q2X3qd67Kk=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=Gzr/Hmhjs2KUDi4nnp0MTHzIyL0PHDDlwEtr+CBgyllamdBOtERawuTPq1+Z0snRe
         RqvCFjm/AWFD80J4BeLp2QSQym1ZXeBiTft476K8ziJUbnMOsjsA8RguD3AXyBM5ye
         BB8D+ZLSQhYU4+sMbj/eMXeZOxXpMmvnOSbuYx4SljrZQOjCTWzd6GgU2ijA91cw2e
         hBlD1wH6lVO9+LZrJWD78PbLEnkVDbcqxmqj/xz6NryKP4Qh8wL5EamqBP+0kxiavr
         heyBgrKUWteT0TNw6HQ7F6eykkAzJNWrx0xo+P2Vm3YnPQiCg8krOBryTkoo95eIfg
         HINee5Siuuv1g==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Maninder Singh <maninder1.s@samsung.com>, bcain@quicinc.com,
        npiggin@gmail.com, christophe.leroy@csgroup.eu,
        keescook@chromium.org, nathanl@linux.ibm.com, ustavoars@kernel.org,
        alex.gaynor@gmail.com, gary@garyguo.net, ojeda@kernel.org,
        pmladek@suse.com, wedsonaf@google.com,
        linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, Onkarnath <onkarnath.1@samsung.com>
Subject: Re: [PATCH 2/2] powerpc/xmon: use KSYM_NAME_LEN in array size
In-Reply-To: <CANiq72nf-MC36hHzv0ZpR+qUyaf3mhF+rfqpMcVbw0AheuRBpA@mail.gmail.com>
References: <CGME20230529111404epcas5p2d540d726dcf3e21aae2a6a0958e2eea5@epcas5p2.samsung.com>
 <20230529111337.352990-1-maninder1.s@samsung.com>
 <20230529111337.352990-2-maninder1.s@samsung.com>
 <CANiq72=QeTgtZL4k9=4CJP6C_Hv=rh3fsn3B9S3KFoPXkyWk3w@mail.gmail.com>
 <87ilc8ym6v.fsf@mail.lhotse>
 <CANiq72nf-MC36hHzv0ZpR+qUyaf3mhF+rfqpMcVbw0AheuRBpA@mail.gmail.com>
Date:   Thu, 01 Jun 2023 22:54:42 +1000
Message-ID: <87jzwngx65.fsf@mail.lhotse>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Miguel Ojeda <miguel.ojeda.sandonis@gmail.com> writes:
> On Thu, Jun 1, 2023 at 4:02=E2=80=AFAM Michael Ellerman <mpe@ellerman.id.=
au> wrote:
>>
>> > Side-note: in `get_function_bounds()`, I see `kallsyms_lookup()` being
>> > used, but the name seems discarded? Can
>> > `kallsyms_lookup_size_offset()` be used instead, thus avoiding the
>> > usage of the buffer there to begin with?
>>
>> A few lines below it uses the modname, and AFAICS there's no (easy) way
>> to lookup the modname without also looking up the name.
>
> Hmm... I think you are looking at the `xmon_print_symbol()` one? I was
> referring to the `get_function_bounds()` one, where the `modname`
> parameter is `NULL` (and the `name` contents are not used, only
> whether it was found or not).

Yes you're right, apparently I can't read :}

cheers
