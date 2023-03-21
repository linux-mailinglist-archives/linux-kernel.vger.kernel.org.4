Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAC316C2A69
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 07:31:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229981AbjCUGbh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 02:31:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230114AbjCUGbc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 02:31:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71B902CC47
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 23:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679380241;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hLfcaciqC2sQRgVuiIt5OYHvRdezwnP+Ui5lox0wguk=;
        b=PF7iTdHplJ8+x6scSvXfSY5ot6SfSz1aKBq+W6awOj1QpQtUVwGqq1v8T0ngN08+p1RRUs
        g+nDjTw9Uc1pE+hOV9n14lMfEQmkZQzh2JXWpCgamTzrn3v+igRMJdN7BKxWhuGIrcCj0N
        yrmz1gc+mMCJTmnSt62qgJOdFEOV84M=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-335-MkyCVHvsOCK5H4fynVf_dg-1; Tue, 21 Mar 2023 02:30:40 -0400
X-MC-Unique: MkyCVHvsOCK5H4fynVf_dg-1
Received: by mail-ot1-f72.google.com with SMTP id c2-20020a9d75c2000000b0069e5dd6ff38so5410950otl.16
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 23:30:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679380240;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hLfcaciqC2sQRgVuiIt5OYHvRdezwnP+Ui5lox0wguk=;
        b=psCkvx7x4Oyw7f1h7rWYzAiBvDv29PQPOZlks3vC8NzBCPO1evZaV6hc8acsnkUoPv
         5nKQZaA7rmB1Eeyl4HMOM0VrD228R/g3Vr23TvR3u3FVwzC/Aiyy9YwUxkyvb2Phw27e
         yFbYjjiaighxh41KjgqFUPBbmMqO1h/U0Qa022p3aBnO39iTZfDz9vC8KJtUKLw9NLlD
         kotqUUDJyTGBAF3bMTo1bzs1XR37jDobsfr7UbjPFpjZ/SILAfdTt4zV2yKIl1+cfuim
         cBQ2smPRsR2GaIjE01JfBiXuXd9oJIXFQpQZgTApq0tSinoU0NqKnON1yBhbpMOTAfNy
         BTeA==
X-Gm-Message-State: AO0yUKWp4kWq8lcxU01TWcjHS5gGtoQskO6ImltOV7qzPj6ZsTg57/2P
        eFRauyNwhwOW4YRh0g1KhuBZr467r6NAzhgeNUtVhWtKh+4ZmRXqD6k0hl24yD8JqyyC/dz9luM
        /o2Xe2davy3Q5uGTGnZ9vQJ8J
X-Received: by 2002:a05:6870:e9a6:b0:177:896a:cb06 with SMTP id r38-20020a056870e9a600b00177896acb06mr532669oao.17.1679380239775;
        Mon, 20 Mar 2023 23:30:39 -0700 (PDT)
X-Google-Smtp-Source: AK7set+sAnExMk7SZzECJpvie0SkEMvlJl4END4aZkWBt8HSEfwk2lzAbzgMlaR1FWZJdyt92s7VUw==
X-Received: by 2002:a05:6870:e9a6:b0:177:896a:cb06 with SMTP id r38-20020a056870e9a600b00177896acb06mr532663oao.17.1679380239515;
        Mon, 20 Mar 2023 23:30:39 -0700 (PDT)
Received: from ?IPv6:2804:1b3:a801:b074:274d:d04e:badc:c89f? ([2804:1b3:a801:b074:274d:d04e:badc:c89f])
        by smtp.gmail.com with ESMTPSA id bd35-20020a056871b32300b00177be9585desm4021051oac.1.2023.03.20.23.30.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 23:30:39 -0700 (PDT)
Message-ID: <4f35f41c143b02b6b815e7eb527ca3acd8b4aabe.camel@redhat.com>
Subject: Re: [RFC PATCH 0/6] Deduplicating RISCV cmpxchg.h macros
From:   Leonardo =?ISO-8859-1?Q?Br=E1s?= <leobras@redhat.com>
To:     Conor Dooley <conor@kernel.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Date:   Tue, 21 Mar 2023 03:30:35 -0300
In-Reply-To: <8f698f49-135a-4263-8471-96f406919cb1@spud>
References: <20230318080059.1109286-1-leobras@redhat.com>
         <8f698f49-135a-4263-8471-96f406919cb1@spud>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Conor, thanks for the feedback!


On Sun, 2023-03-19 at 20:35 +0000, Conor Dooley wrote:
> On Sat, Mar 18, 2023 at 05:00:54AM -0300, Leonardo Bras wrote:
> > While studying riscv's cmpxchg.h file, I got really interested in=20
> > understanding how RISCV asm implemented the different versions of=20
> > {cmp,}xchg.
> >=20
> > When I understood the pattern, it made sense for me to remove the=20
> > duplications and create macros to make it easier to understand what exa=
ctly=20
> > changes between the versions: Instruction sufixes & barriers.
> >=20
> > I split those changes in 3 levels for each cmpxchg and xchg, resulting =
a=20
> > total of 6 patches. I did this so it becomes easier to review and remov=
e=20
> > the last levels if desired, but I have no issue squashing them if it's=
=20
> > better.
> >=20
> > Please provide comments.
> >=20
> > Thanks!
> > Leo
> >=20
> > Leonardo Bras (6):
> >   riscv/cmpxchg: Deduplicate cmpxchg() asm functions
> >   riscv/cmpxchg: Deduplicate cmpxchg() macros
> >   riscv/cmpxchg: Deduplicate arch_cmpxchg() macros
>=20
> >   riscv/cmpxchg: Deduplicate xchg() asm functions
>=20
> FWIW, this patch seems to break the build pretty badly:
> https://patchwork.kernel.org/project/linux-riscv/patch/20230318080059.110=
9286-5-leobras@redhat.com/

Thanks for pointing out!

It was an intermediary error:
Sufix for amoswap on acquire version was "d.aqrl" instead of the
correct".d.aqrl", and that caused the fail.

I did not notice anything because the next commit made it more general, and=
 thus
removed this line of code. I will send a v2-RFC shortly.

I see that patch 4/6 has 5 fails, but on each one of them I can see:
"I: build output in /ci/workspace/[...]", or
""I: build output in /tmp/[...]".

I could not find any reference to where this is saved, though.
Could you point where can I find the error output, just for the sake of fur=
ther
debugging?

>=20
> Patches 1 & 5 also add quite a lot of sparse issues (like 1000), but I
> think that may be more of an artifact of the testing process as opposed
> to something caused by this patchset.

For those I can see the build output diffs. Both added error lines to
conchuod/build_rv64_gcc_allmodconfig.
I tried to mimic this with [make allmodconfig + gcc build with
CROSS_COMPILE=3Driscv64-linux-gnu- ] but I could not get any error in any p=
atch.

For patch 1/6 it removes as much error lines (-) as it adds (+), and the er=
ror
messages are mostly the same, apart for an line number.

For patch 5/6 it actually adds many more lines, but tracking (some of) the
errors gave me no idea why.

>=20
> Cheers,
> Conor.

Thanks a lot!
Leo


