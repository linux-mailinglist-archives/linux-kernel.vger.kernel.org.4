Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55B596F3D1F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 07:48:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233506AbjEBFsQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 01:48:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233294AbjEBFsP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 01:48:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDE6A19B7
        for <linux-kernel@vger.kernel.org>; Mon,  1 May 2023 22:48:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 79EE36188A
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 05:48:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87E96C433A1;
        Tue,  2 May 2023 05:48:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683006492;
        bh=QFgaj7LjOrwpefjycjAmRiPltPmbzaKTfT0CxHr+JHM=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=hfa//+lu0sjGGGOxJsmQ44lujZhVUV+VfiLQUr0aH/LzssxPSs2lOuCQt22bq5KvA
         Wd+Y8u5Apo4fAjESUe3gn7M49eiSL8pt6WCiAitd7kUMepo2bUEsdbhdV7J6az9z7n
         I4LP9FNdulOHXU3bJqm5xUJhFQB+e8aFqAzD+0F3REly8K+dod9oBXxU3eVIfgYqh3
         76np80FnIzeGF7TmEt7vw+0BPCnRB8z70XaLzMVW15BekKWUOdjb6NZxrhDIFwAu0v
         p9qVVUBSc7TP6ffTQgWhCuoXxcH9ZqIzDGavMrYmeDb/GJviWwFQ564PsBSDWtEofD
         JABXIA36Kf2oQ==
From:   =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To:     Jessica Clarke <jrtc27@jrtc27.com>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Kito Cheng <kito.cheng@sifive.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        matthias.bgg@gmail.com,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        Greentime Hu <greentime.hu@sifive.com>, nick.knight@sifive.com,
        christoph.muellner@vrull.eu, philipp.tomsich@vrull.eu,
        richard.henderson@linaro.org, arnd@arndb.de,
        linux-kernel@vger.kernel.org,
        Heiko Stuebner <heiko.stuebner@vrull.eu>
Subject: Re: [PATCH 0/4] Expose the isa-string via the AT_BASE_PLATFORM aux
 vector
In-Reply-To: <7DD2C38C-CBB3-41EE-A195-50E4C2451B7E@jrtc27.com>
References: <20230424194911.264850-1-heiko.stuebner@vrull.eu>
 <87ednz7roh.fsf@all.your.base.are.belong.to.us>
 <7DD2C38C-CBB3-41EE-A195-50E4C2451B7E@jrtc27.com>
Date:   Tue, 02 May 2023 07:48:10 +0200
Message-ID: <878re77085.fsf@all.your.base.are.belong.to.us>
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

Jessica Clarke <jrtc27@jrtc27.com> writes:

> All I wanted was some simple extension string -> version number function
> as a standardised userspace interface... because at the end of the day
> people just want to know =E2=80=9Ccan I use extension Y?=E2=80=9D, possib=
ly with a
> minimum version. But maybe there=E2=80=99s some hope that Linux libcs will
> translate such queries into poking at this hwprobe thing.

Using hwprobe to plumb such an interface for, say libcs, was what I was
envisioning.

> Though god knows what they=E2=80=99re going to do about vendor extensions,
> especially if those vendor extensions only get supported in vendor
> forks of the kernel (who=E2=80=99s allocating their encodings? Xvendorfoo
> exists to namespace them and give vendors control...).

"they're"? I'm sure your input on how to design such an interface would
be be much appreciated!

My view is that the "design upfront" strategy here hasn't really worked
out, so the hwprobe approach is to start small, and extend when there's
need. Hopefully, there will be fewer pains with this approach.

That's why I was very surprised to see this series, which introduces Yet
Another Interface.


Bj=C3=B6rn
