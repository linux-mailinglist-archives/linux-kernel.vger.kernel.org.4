Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E3BE6F40C3
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 12:10:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233754AbjEBKKT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 06:10:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbjEBKKQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 06:10:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 868315261
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 03:09:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1183061C64
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 10:09:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DF92C433A1;
        Tue,  2 May 2023 10:09:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683022198;
        bh=8gNEyWWACUeeP7m7t0N/tXXQmwetfjaFAJPzW/qAkvc=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=rPttr6hAeJqsGZPJsVvwf3Xw/k8Ltqgxi8wlnPBL01CGAamhvCP2yKD9IkMvFdZ8F
         xDgbjnVL9VsPawKuoxQb2NUIYnLcsPiRLzfQR4buUDu3zGtFMbPUo1g23PrLpDyVv+
         C6sStexoJUt9LY4Ah16xc+MpHUQt772yvzW9RlaCSLA6x6UvLXQhFTjjP8gRVecNtz
         D1kS1M11/IheHMV76bbKH1m6gzxrTRaHxNVd796hXuPHKi9iHep2pgQlPn0JCTn1N9
         5Z2rXEOij+5McZnr92Tfp5zdwIulrW00FqrjeA01tRTb6s4aygIelR5ZawVfRCAobd
         GJVdEy0eb2/2Q==
From:   =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To:     Philipp Tomsich <philipp.tomsich@vrull.eu>
Cc:     Jessica Clarke <jrtc27@jrtc27.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Kito Cheng <kito.cheng@sifive.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        matthias.bgg@gmail.com,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        Greentime Hu <greentime.hu@sifive.com>, nick.knight@sifive.com,
        christoph.muellner@vrull.eu, richard.henderson@linaro.org,
        arnd@arndb.de, linux-kernel@vger.kernel.org,
        Heiko Stuebner <heiko.stuebner@vrull.eu>
Subject: Re: [PATCH 0/4] Expose the isa-string via the AT_BASE_PLATFORM aux
 vector
In-Reply-To: <CAAeLtUCqyARVaY2YtVXWc_cucMOCbQ2RAd2y35pun_MMagEN_w@mail.gmail.com>
References: <20230424194911.264850-1-heiko.stuebner@vrull.eu>
 <87ednz7roh.fsf@all.your.base.are.belong.to.us>
 <7DD2C38C-CBB3-41EE-A195-50E4C2451B7E@jrtc27.com>
 <CAAeLtUADqnwrgBjhDd+iNfwhMU6YBiMUZzeopVMAh0Jq19W9JA@mail.gmail.com>
 <87jzxrnp01.fsf@all.your.base.are.belong.to.us>
 <CAAeLtUCqyARVaY2YtVXWc_cucMOCbQ2RAd2y35pun_MMagEN_w@mail.gmail.com>
Date:   Tue, 02 May 2023 12:09:55 +0200
Message-ID: <87pm7j9h8s.fsf@all.your.base.are.belong.to.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Philipp Tomsich <philipp.tomsich@vrull.eu> writes:

> On Tue, 2 May 2023 at 09:58, Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org> wro=
te:
>>
>> Philipp Tomsich <philipp.tomsich@vrull.eu> writes:
>>
>> > It is a pity that the current interface was designed without involving
>> > RVI (and that I had to ask my team to put together a patch set for
>> > further discussion, given that none of the other major vendors in RVI
>> > stepped forward).  I guarantee that plenty of reviewers would have
>> > highlighted that a central registry (even if it is just a kernel
>> > header) should be avoided.
>>
>> Are you claiming that the hwprobe work was not done in the open, but
>> secretly merged? That is not only incorrect, but rude to upstream RISC-V
>> Linux developers. I suggest you review how you interact with upstream
>> kernel work.
>
> Please don't put words into my mouth...
>
> I was merely pointing out that there was no engagement by the RVI
> member companies (in regard to this mechanism) within RVI, which would
> have prevented Jessica's issue.
> This would have also helped to address the concerns on vendor-defined
> extensions.
>=20
> Also who do you refer to when you say "how _you_ interact"?  If it is
> RVI that you refer to: it doesn't interact with upstream work
> directly, as it doesn't own any engineering resources.
> RVI provides a forum for member companies to come to an
> understanding/design and then have the member companies perform the
> work and take it upstream.

Thank you for clearing that up. I guess I was grouping RVI/RVI members
into one. Many of the RVI members have active kernel developers. One
could argue that the if there was a concern about current work, that it
would have been raised by members to RVI, no? But that's another
discussion, and maybe one that should be done between RVI members.

Apologies if I offended you, that was not my intention. If that was the
case; I'm very sorry, Philipp! I can say, that the timing of this series
made me a bit wary. My reading was "Oh, THEY didn't include us, and
going behind our back! Here's OUR solution!". Happy that wasn't the
case!

I'm convinced that we (upstream developers; some working for RVI member
companies, some not) still can make vendor-defined extensions work.

>> Why didn't RVI get involved in the review of the series? The expectation
>> cannot be that all open source projects go to RVI, but rather the other
>> way around.
>
> That is exactly the point I was making and which you seem to miss: RVI
> does not own any engineering resources and depends solely on its
> member companies to project into open source projects.

Ok.

>> Take a look at commit ea3de9ce8aa2 ("RISC-V: Add a syscall for HW
>> probing"). Your team was very much involved in the review.
>
> I am aware, as I had reviewed and commented on these are well.
> And my only request (was and) is that we need to figure out a way to
> efficiently deal with vendor-defined extensions.

Awesome, that makes two of us! Let's try to do that by collaborating on
what's upstream, and building on top of that.


Bj=C3=B6rn
