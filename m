Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C19773F0D5
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 04:29:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230064AbjF0C3r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 22:29:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbjF0C3p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 22:29:45 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 030F5199A;
        Mon, 26 Jun 2023 19:29:44 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id 46e09a7af769-6b71cdb47e1so3639658a34.2;
        Mon, 26 Jun 2023 19:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687832983; x=1690424983;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7s3J7mtj2DOT05cABKB4L4599zUF5rb8Gns79BnadUM=;
        b=nJqHWenFI/MLjK7BeJH7sTGYYzoSNt10WsYID0G02bMhy1n68WLfT3ZyHqiNFtl9qi
         GFOr/fTkJg2mcLBQjzczNBZ2i7V1H9NxykzsU8EZqXjlmziF2wGVCBhCyTXiE2vaBaiq
         sTMNAJXUnmSkGXi110SD1WrOwYYbwX9ns7dLHkJmzCXdir4ExBg3qYcYZZ6otVksIzFz
         uIPP+lHjhN/sFRS0la+atGEmSABIA+SqMEQ7XN3gFWeGob+nhb2fb2mUCN4LpiOCm6oG
         1NRlpcEBzEFz3lP5OIAa1VrYuWnt1Nr1vc7cP7Il21y6PIF0LFpooEZ15CI/q1v6ONue
         4NGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687832983; x=1690424983;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7s3J7mtj2DOT05cABKB4L4599zUF5rb8Gns79BnadUM=;
        b=G+jJ4voOqP1pqXhMurAyMsCxHmoZ65bL7Ni3ggb1bdDfSAV2zvD6ZuDjYJnV+SxuT3
         dWZo2uRXtfzvLUbP3awEOwHbA4Uh1hmXOUchYBaS2GlHmcuFGAI/FwIfnSy3Z72V/1CH
         ECJvRkbsHSIgNr+A8NnjCkSvEh2uszGNQCaBBq3OEs6naM/QWNJ0RX3UR6XXiie0ohbZ
         XLD6SsQPl8VdJscrmbcEAuFrtp1onXJsEh682einS9wJWM5P5Zdmoc2G6zafJqjGYr2c
         8nBlreEbNC1elVIN1nnqhz4dH/gigOVHov+Y4D7H7VXEU9pebYnQsFdf+TdKE3XIj6pQ
         EU9Q==
X-Gm-Message-State: AC+VfDzqEcKbCH1aGYD8keL9yOCnTJdNeIGt7+pLiMv9sosi6H/J58n9
        eodGcvI6vQgwGxrPNcH504g=
X-Google-Smtp-Source: ACHHUZ6IwQ9FELesSLU/UHwcmF0hCmBoDWfKnYld0eaSg231u/frP7cFaztMIwvdsHyGV/NyTGXk0w==
X-Received: by 2002:a05:6359:62f:b0:127:d8c1:b829 with SMTP id eh47-20020a056359062f00b00127d8c1b829mr20826988rwb.27.1687832983046;
        Mon, 26 Jun 2023 19:29:43 -0700 (PDT)
Received: from debian.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id q17-20020a62ae11000000b00679dc747738sm1759832pff.10.2023.06.26.19.29.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 19:29:42 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 92C3781BD58D; Tue, 27 Jun 2023 09:29:37 +0700 (WIB)
Date:   Tue, 27 Jun 2023 09:29:36 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        Florian Westphal <fw@strlen.de>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Lingutla Chandrasekhar <clingutla@codeaurora.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        "J. Avila" <elavila@google.com>,
        Vivek Anand <vivekanand754@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Thomas Renninger <trenn@suse.com>,
        Shuah Khan <shuah@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux Netfilter Development <netfilter-devel@vger.kernel.org>,
        Netfilter Core Developers <coreteam@netfilter.org>,
        Linux Networking <netdev@vger.kernel.org>,
        Linux Power Management <linux-pm@vger.kernel.org>
Subject: Re: Fwd: High cpu usage caused by kernel process when upgraded to
 linux 5.19.17 or later
Message-ID: <ZJpJkL3dPXxgw6RK@debian.me>
References: <01ac399d-f793-49d4-844b-72cd8e0034df@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="90Q4kbwiz0bo494z"
Content-Disposition: inline
In-Reply-To: <01ac399d-f793-49d4-844b-72cd8e0034df@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--90Q4kbwiz0bo494z
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 23, 2023 at 07:58:51AM +0700, Bagas Sanjaya wrote:
> Hi,
>=20
> I notice a regression report on Bugzilla [1]. Quoting from it:
>=20
> > kernel process "kworker/events_power_efficient" uses a lot of cpu power=
 (100% on ESXI 6.7, ~30% on ESXI 7.0U3 or later) after upgrading from 5.17.=
3 to 5.19.17 or later.
> >=20
> > dmesg log:
> > [ 2430.973102]  </TASK>
> > [ 2430.973131] Sending NMI from CPU 1 to CPUs 0:
> > [ 2430.973241] NMI backtrace for cpu 0
> > [ 2430.973247] CPU: 0 PID: 22 Comm: kworker/0:1 Not tainted 6.3.3 #1
> > [ 2430.973254] Hardware name: VMware, Inc. VMware Virtual Platform/440B=
X Desktop Reference Platform, BIOS 6.00 11/12/2020
> > [ 2430.973258] Workqueue: events_power_efficient htable_gc [xt_hashlimi=
t]
> > [ 2430.973275] RIP: 0010:preempt_count_sub+0x2e/0xa0
> > [ 2430.973289] Code: 36 01 85 c9 75 1b 65 8b 15 a7 da f8 5e 89 d1 81 e1=
 ff ff ff 7f 39 f9 7c 16 81 ff fe 00 00 00 76 3b f7 df 65 01 3d 8a da f8 5e=
 <c3> cc cc cc cc e8 98 aa 25 00 85 c0 74 f2 8b 15 da 71 ed 00 85 d2
> > [ 2430.973294] RSP: 0018:ffffb15ec00dbe58 EFLAGS: 00000297
> > [ 2430.973299] RAX: 0000000000000000 RBX: ffffb15ec12ad000 RCX: 0000000=
000000001
> > [ 2430.973302] RDX: 0000000080000001 RSI: ffffffffa1c3313b RDI: 0000000=
0ffffffff
> > [ 2430.973306] RBP: dead000000000122 R08: 0000000000000010 R09: 0000746=
e65696369
> > [ 2430.973309] R10: 8080808080808080 R11: 0000000000000018 R12: 0000000=
000000000
> > [ 2430.973312] R13: 0000000000001e2b R14: ffffb15ec12ad048 R15: ffff91c=
279c26a05
> > [ 2430.973316] FS:  0000000000000000(0000) GS:ffff91c279c00000(0000) kn=
lGS:0000000000000000
> > [ 2430.973320] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [ 2430.973324] CR2: 000055fc138890e0 CR3: 000000010810e002 CR4: 0000000=
0001706f0
> > [ 2430.973374] Call Trace:
> > [ 2430.973388]  <TASK>
> > [ 2430.973390]  __local_bh_enable_ip+0x32/0x70
> > [ 2430.973413]  htable_selective_cleanup+0x95/0xc0 [xt_hashlimit]
> > [ 2430.973428]  htable_gc+0xf/0x30 [xt_hashlimit]
> > [ 2430.973440]  process_one_work+0x1d4/0x360
> > [ 2430.973459]  ? process_one_work+0x360/0x360
> > [ 2430.973467]  worker_thread+0x25/0x3b0
> > [ 2430.973476]  ? process_one_work+0x360/0x360
> > [ 2430.973483]  kthread+0xe1/0x110
> > [ 2430.973499]  ? kthread_complete_and_exit+0x20/0x20
> > [ 2430.973507]  ret_from_fork+0x1f/0x30
> > [ 2430.973526]  </TASK>
>=20
> See Bugzilla for the full thread and perf output.
>=20
> Anyway, I'm tracking it in regzbot so that it doesn't fall through
> cracks unnoticed:
>=20
> #regzbot introduced: v5.17.3..v5.19.17 https://bugzilla.kernel.org/show_b=
ug.cgi?id=3D217586
> #regzbot title: kworker/events_power_efficient utilizes full CPU power af=
ter kernel upgrade
>=20

The reporter had found the culprit (see Bugzilla for more information), thus
telling regzbot:

#regzbot introduced: 6ad0ad2bf8a67e
#regzbot title: retbleed reporting causes high cpu utilization due to kwork=
er/events_power_efficient
#regzbot link: https://lore.kernel.org/all/PH0PR05MB8448A203A909959FAC754B7=
AAF439@PH0PR05MB8448.namprd05.prod.outlook.com/
#regzbot link: 6ad0ad2bf8a67e

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--90Q4kbwiz0bo494z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZJpJiwAKCRD2uYlJVVFO
o1jRAP4q8brZctIPnGZqlJZqlJEMRnc4sRukxEX4ieIUH5Xn0QEA1g/dJoM/iQbR
z2LBNutalMJVqVv8mRZOw176rScpTw0=
=xdMq
-----END PGP SIGNATURE-----

--90Q4kbwiz0bo494z--
