Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE98E6D3C46
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 06:04:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231205AbjDCEET (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 00:04:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjDCEER (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 00:04:17 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E48BC9767
        for <linux-kernel@vger.kernel.org>; Sun,  2 Apr 2023 21:04:15 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id s13so16236051wmr.4
        for <linux-kernel@vger.kernel.org>; Sun, 02 Apr 2023 21:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680494654;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dfpcCyJlBWrQogdsMi05FfYrfZ2wEfN0si9pF5mmMEo=;
        b=oN9vYChtrdLr6qfCCWuW5oLYxj0PGkE2qXn3Y35L0hH2MHGG2Vwe/tbq1lpBe/Xy6k
         TaaAdfp0xNENIfGPcTRpM7OVjbx2oHh/yFgBGdf+9rOQTzFCNT+YhAGOUy7J7MWRkgk+
         kcCZP/Du3jWWGykZfag67wmizfbzOq9XN/ZpuV9KoObb2BJiQANwBuhKrb4h/aNTYz0G
         y546vvfl59yhr/dnGewZxUk8+NWpTIajQfV2/cD9fT0Zg30Pv4TfSbXHNDWshzsqFnkN
         0p06vdRAu/MJR4ZNUfBK/QsMw4Fb4SA/RqL+jW1nFDPqA2aAHDrRAQoiiBu5ibYu/mpc
         zAhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680494654;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dfpcCyJlBWrQogdsMi05FfYrfZ2wEfN0si9pF5mmMEo=;
        b=72SBDQDCOganSCVfKjjzY25XtdJ6ssQdsS1fcdxnDkQkxSGbvH7xIHJRUcML2q915m
         e1TBfFpP7zv+8FQsnaVz6Gqc9hY+XZ87dGgYVju06I5cJz4MyAbIAplPcjUC2lJ5PS7i
         h0zYX/a3xW2cgcsaX4WkxzS4iiLpmKJKArJ6V1cVD084HI46Zf52XgKHrUuK/KYwAeXF
         CQ0tMJyvEz/lDTd2pWRu/LXYqmH2leAwSGAeWH7p/r9t/UKrN0cU4hwYhkdte31hrgVT
         nkOFvFnk6qImuEb+MYBAHa2h5dhUOetnNYLWQASFK7xmcqfftszHmBjcl0wsarWQa8zj
         fTxw==
X-Gm-Message-State: AO0yUKUaHDuSP4hxXvNF4R/9wnfMron25tIEvkBoR9b9kbF8CBkD/iUP
        DnKcCop5YFTxdDrXD7ufUc0=
X-Google-Smtp-Source: AK7set/nuMZskSO45lzGuF2YA589VfMcTt3xCFkljUrgjlBp1p0kQt63kTk+o+vX/k1vreZicE6aig==
X-Received: by 2002:a7b:ce0a:0:b0:3ed:237f:3da with SMTP id m10-20020a7bce0a000000b003ed237f03damr27017095wmc.22.1680494654247;
        Sun, 02 Apr 2023 21:04:14 -0700 (PDT)
Received: from suse.localnet (a-pi8-84.tin.it. [212.216.222.51])
        by smtp.gmail.com with ESMTPSA id u25-20020a7bc059000000b003ede06f3178sm10696915wmc.31.2023.04.02.21.04.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Apr 2023 21:04:13 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     =?utf-8?B?6YOt6L6J?= <guohui@uniontech.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, patches@lists.linux.dev
Subject: Re: [PATCH] mm: remove all the slab allocators
Date:   Mon, 03 Apr 2023 06:04:12 +0200
Message-ID: <3566797.hdfAi7Kttb@suse>
In-Reply-To: <CAPj211unsM2zM8Y-7iZ09jmKF135xZ6pSPzyzN2dkFvN=wUZFA@mail.gmail.com>
References: <20230401094658.11146-1-vbabka@suse.cz>
 <ZClhKouKa5e6/jha@casper.infradead.org>
 <CAPj211unsM2zM8Y-7iZ09jmKF135xZ6pSPzyzN2dkFvN=wUZFA@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On luned=C3=AC 3 aprile 2023 05:51:42 CEST Fabio M. De Francesco wrote:
> On Sun, 2 Apr 2023, 13:04 Matthew Wilcox, <willy@infradead.org> wrote:
> > On Sun, Apr 02, 2023 at 05:09:14PM +0800, =E9=83=AD=E8=BE=89 wrote:
> > > On 4/1/23 5:46 PM, Vlastimil Babka wrote:
> > > > As the SLOB removal is on track and the SLAB removal is planned, I=
=20
have
> > > > realized - why should we stop there and not remove also SLUB? What'=
s a
> > > > slab allocator good for in 2023? The RAM sizes are getting larger a=
nd
> > > > the modules cheaper [1]. The object constructor trick was perhaps
> > > > interesting in 1994, but not with contemporary CPUs. So all the slab
> > > > allocator does today is just adding an unnecessary layer of complex=
ity
> > > > over the page allocator.
> > >=20
> > > The slab allocator is very core and very important to the Linux kerne=
l.
> > > After the patch is merged into the mainline, it will have a very=20
profound
> > > impact on the development of the Linux kernel.
> >=20
> > https://en.wikipedia.org/wiki/April_Fools%27_Day
>=20
> Wow!
>=20
> The most interesting implication of this "patch" is that you noticed that
> some people may actually need the link above to be able to distinguish
> between foolishness and reality...
>=20
> Thanks :-)
>=20
> Fabio

Ah, I was so shocked that didn't realize was responding with the GMail app=
=20
from the tablet... :-)

=46abio



