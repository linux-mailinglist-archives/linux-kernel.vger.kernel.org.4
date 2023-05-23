Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBCB670E23C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 18:49:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237792AbjEWQsE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 12:48:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235765AbjEWQsA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 12:48:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC06DC2
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 09:47:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 693CF633D8
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 16:47:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 834DAC4339B;
        Tue, 23 May 2023 16:47:58 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="bKXyBMM6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1684860475;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VRnFnF2rQ2+ju+Gq8ha9DasxaZ50kRA51/t/mC1MNRc=;
        b=bKXyBMM6Ynf4xlS+DcAXug1HT+aBCBtX0QAkIw/7Gdct1dutOKcDHuFQj8qND+XuLuyPQY
        fhm6OzU6U0um1SvmV3yXaZDwoAh1+zHHY6C+lWFnHP2gVdzpJWdHiXUHXVJHsXS8z+NQEm
        B/S6saEzTlSwpfaLgf83xBuB1hMrWOE=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 8dab202c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Tue, 23 May 2023 16:47:55 +0000 (UTC)
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-456d241fcdcso5279e0c.0;
        Tue, 23 May 2023 09:47:54 -0700 (PDT)
X-Gm-Message-State: AC+VfDw+yUly+jFxphFrMSTw6W7DfKbA8zLGl2TfZ+oW57DwJOAPO4zH
        6VCeggNtttyHKYHIfAheJCdsje1XssEmZqg3r6Y=
X-Google-Smtp-Source: ACHHUZ7pSg6rKoXYHLBucwCvcc2dnGFD3Vb69NZfzEXA8Y6n1t4H/1zQ7ymb48vBWNR0yG99WjJFpgNhwCtRWu2e3iA=
X-Received: by 2002:a67:e34f:0:b0:430:229e:9386 with SMTP id
 s15-20020a67e34f000000b00430229e9386mr4404544vsm.6.1684860473351; Tue, 23 May
 2023 09:47:53 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000c0b11d05fa917fe3@google.com> <ZGzfzEs-vJcZAySI@zx2c4.com>
 <20230523090512.19ca60b6@kernel.org> <ZGzmWtd7itw6oFsI@zx2c4.com> <20230523094606.6f4f8f4f@kernel.org>
In-Reply-To: <20230523094606.6f4f8f4f@kernel.org>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Tue, 23 May 2023 18:47:41 +0200
X-Gmail-Original-Message-ID: <CAHmME9pEu2cvrSQd+Rg8Cp=KDfKEfjeiPPgF-WecXLHyRZVjcw@mail.gmail.com>
Message-ID: <CAHmME9pEu2cvrSQd+Rg8Cp=KDfKEfjeiPPgF-WecXLHyRZVjcw@mail.gmail.com>
Subject: Re: [syzbot] [wireguard?] KASAN: slab-use-after-free Write in enqueue_timer
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     edumazet@google.com,
        syzbot <syzbot+c2775460db0e1c70018e@syzkaller.appspotmail.com>,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        davem@davemloft.net, linux-kernel@vger.kernel.org,
        pabeni@redhat.com, wireguard@lists.zx2c4.com, jann@thejh.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 23, 2023 at 6:46=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Tue, 23 May 2023 18:14:18 +0200 Jason A. Donenfeld wrote:
> > So, IOW, not a wireguard bug, right?
>
> What's slightly concerning is that there aren't any other timers
> leading to
>
>   KASAN: slab-use-after-free Write in enqueue_timer
>
> :( If WG was just an innocent bystander there should be, right?

Well, WG does mod this timer for every single packet in its RX path.
So that's bound to turn things up I suppose.
