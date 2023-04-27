Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 937DA6EFFB4
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 05:09:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242944AbjD0DJY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 23:09:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242895AbjD0DJP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 23:09:15 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A4BE35AF;
        Wed, 26 Apr 2023 20:09:12 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Q6LLC06rnz4x5Q;
        Thu, 27 Apr 2023 13:09:06 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1682564947;
        bh=S9vkNzq/sWnQ+hKq02kIHxm1YcRt+uc5ZstHfvPkWpA=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=e1nt/ZiO8mHb9GEdS2Yydj8tDRxfv4ZT82IOTGN3flhKqTGusk1IG4Ic57tPh3QuE
         cMUCSzCTgN/qlohDGakAXqdCcyD89/Uxfl4Uzdyi03xL9Ynpiz1D7oRWYyTd/riNNT
         +VUqIxK4Dlr2CaJe+z4kcboYKQoD7tR99d5r3fBrv5/m7CksW6Is8Je421WZn/2gNe
         tzHhXFBchgbCRpA4nlADdN7G7P1h69RKXK6JULfpXQXpTv1E19Jfa/OUg/3KN2Pwxu
         6TeCw2N2QG6q+/zWtsTaCV0h+Xq4vbtN3neRftU1AM9dynCu0U2N59kj1ngUI0ZrSK
         JBaDokcmE8gfQ==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Zhouyi Zhou <zhouzhouyi@gmail.com>
Cc:     linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        rcu <rcu@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, lance@osuosl.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: BUG : PowerPC RCU: torture test failed with __stack_chk_fail
In-Reply-To: <CAABZP2xVCQhizytn4H9Co7OU3UCSb_qNJaOszOawUFpeo=qpWQ@mail.gmail.com>
References: <CAABZP2xJRGhPmfB-PrfesQKzP7fsuZsj+3TewAiLLW8u=YK4dg@mail.gmail.com>
 <87cz3tylwx.fsf@mail.concordia>
 <CAABZP2zr=jypD7w_o18o95QEj1nkFugLcNH5sbuSAY-caBQoeQ@mail.gmail.com>
 <CAABZP2xVCQhizytn4H9Co7OU3UCSb_qNJaOszOawUFpeo=qpWQ@mail.gmail.com>
Date:   Thu, 27 Apr 2023 13:09:06 +1000
Message-ID: <87v8hixbql.fsf@mail.concordia>
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

Zhouyi Zhou <zhouzhouyi@gmail.com> writes:
> On Tue, Apr 25, 2023 at 2:01=E2=80=AFPM Zhouyi Zhou <zhouzhouyi@gmail.com=
> wrote:
>> On Tue, Apr 25, 2023 at 6:07=E2=80=AFAM Michael Ellerman <mpe@ellerman.i=
d.au> wrote:
...
>> >
>> > There's 12.2.0 here:
>> >   https://mirrors.edge.kernel.org/pub/tools/crosstool/files/bin/x86_64=
/12.2.0/
>> >   https://mirrors.edge.kernel.org/pub/tools/crosstool/files/bin/ppc64l=
e/12.2.0/

> powerpc64le-linux-gnu-gcc-12 cross compiler on my Ubuntu 22.04 does
> not seem to have that issue as gcc-10 does

OK. So so far it's only that GCC 10 that shows the problem.

If you have time, you could use some of the other versions to narrow
down which versions show the bug:

  https://mirrors.edge.kernel.org/pub/tools/crosstool/files/bin/ppc64le/

There's an 11.0, 11.1 and 11.3 there, as well as 9.5 and so on.

There's=20
