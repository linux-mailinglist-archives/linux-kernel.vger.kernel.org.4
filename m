Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E917719051
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 04:02:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230433AbjFACC3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 22:02:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjFACC2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 22:02:28 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA9D2A3;
        Wed, 31 May 2023 19:02:25 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4QWqBz5Fkpz4x42;
        Thu,  1 Jun 2023 12:02:19 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1685584941;
        bh=EKqPUa5BbsNp2IS+PVeURMLivGy9/PqofQB8JVPKzHk=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=iVM+pWfOIbhHL9f9DmsNTYSYsnsKADtZjQT9IBkW+solKs/5jaM7HmHXujPBPR3sR
         wMMXiW8q5QUIc2tF+b7pContzFBOjsvsrQZp+PB993f8ACrE562bCVTAPxc4nHPlVT
         1JaDyr37YE8RGysSYBHCWpx6blwoqIhVENU7L02HS4t35C05grIv/jnerzHXtBFxkr
         LlFZ4pTbtpMi1kzvCtW/E0KSPxtdyhZedudAUHM4yCfBKpWkN+tj7x/zD6gocR2QVp
         hI0nknDZgWcSY2pAmQYBBAJ+nUybSxOQcns2PjvlZPakzmphOIgWmf3ANOTX/gtTkW
         24NljidWcxz/Q==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Maninder Singh <maninder1.s@samsung.com>
Cc:     bcain@quicinc.com, npiggin@gmail.com, christophe.leroy@csgroup.eu,
        keescook@chromium.org, nathanl@linux.ibm.com, ustavoars@kernel.org,
        alex.gaynor@gmail.com, gary@garyguo.net, ojeda@kernel.org,
        pmladek@suse.com, wedsonaf@google.com,
        linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, Onkarnath <onkarnath.1@samsung.com>
Subject: Re: [PATCH 2/2] powerpc/xmon: use KSYM_NAME_LEN in array size
In-Reply-To: <CANiq72=QeTgtZL4k9=4CJP6C_Hv=rh3fsn3B9S3KFoPXkyWk3w@mail.gmail.com>
References: <CGME20230529111404epcas5p2d540d726dcf3e21aae2a6a0958e2eea5@epcas5p2.samsung.com>
 <20230529111337.352990-1-maninder1.s@samsung.com>
 <20230529111337.352990-2-maninder1.s@samsung.com>
 <CANiq72=QeTgtZL4k9=4CJP6C_Hv=rh3fsn3B9S3KFoPXkyWk3w@mail.gmail.com>
Date:   Thu, 01 Jun 2023 12:02:16 +1000
Message-ID: <87ilc8ym6v.fsf@mail.lhotse>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Miguel Ojeda <miguel.ojeda.sandonis@gmail.com> writes:
> On Mon, May 29, 2023 at 1:14=E2=80=AFPM Maninder Singh <maninder1.s@samsu=
ng.com> wrote:
>>
>> +static char tmpstr[KSYM_NAME_LEN];
>
> Reviewed-by: Miguel Ojeda <ojeda@kernel.org>
>
> Side-note: in `get_function_bounds()`, I see `kallsyms_lookup()` being
> used, but the name seems discarded? Can
> `kallsyms_lookup_size_offset()` be used instead, thus avoiding the
> usage of the buffer there to begin with?

A few lines below it uses the modname, and AFAICS there's no (easy) way
to lookup the modname without also looking up the name.

> Side-note 2: in `scanhex()`, I see a loop `i<63` using `tmpstr` which
> then is used to do a `kallsyms_lookup_name()`, so I guess symbols
> larger than 64 couldn't be found. I have no idea about what are the
> external constraints here, but perhaps it is possible to increase the
> `line` buffer etc. to then allow for bigger symbols to be found.

Yeah that looks wrong. I don't see any symbols that long in current
kernels, but we should fix it.

Thanks for looking.

cheers
