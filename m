Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C961162F25E
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 11:19:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241556AbiKRKTH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 05:19:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241539AbiKRKTD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 05:19:03 -0500
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2B148FFB0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 02:19:01 -0800 (PST)
Received: by mail-yb1-xb32.google.com with SMTP id j2so5106200ybb.6
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 02:19:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tBs0v/AQXyxwwfbSaQaCoIqfpGGXzeZqIxgiWimaOPA=;
        b=bSgsQmfkDhv3OYUgw2yEhksuc1DdpqHCfr2RGBITntdaf/HMDyp9oDLyHWp1uQpJlj
         f9rdiesdcT2IICTetNWWj/+KArVFdmTmwsSuyQdaOaxEbUCcYKnwFefs+jVAGvVFDLMH
         FpkdgdbBylfaVDbLSILPkuJztqN36XM2RIpsSIVO53c17Uw0/Gqdz8U1+vWL+iDKraOV
         I+xkF1/heDefTTCUbXF5odeS6rJ0bElHb23FhB12mdkPRA3YtlLzzVVozX1n/ZFhKyIT
         cfElQT9kczvn1mhsz3MwlbD4CoVwxmf/W8GYdUh9A0AQiomZynBUbmT4Mtxft3XUZMTw
         7M/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tBs0v/AQXyxwwfbSaQaCoIqfpGGXzeZqIxgiWimaOPA=;
        b=UzDi8CSgzSV2Bw25bVStnc6BUjmbD+O6IsyXWIjB0y+MkHwIcMGkVY3t1tX6OwzOug
         PWtT+YYZLtgKeJxPqLO2OCQjaarLHgRaQpNie9PI3UdOFWfn1RUKsFvSDkHVuwBpFsDb
         R9WcJGjzHZ96bJr7ZGaEqi9Wy/wkG8p4pTtEGxa4RnENMzIm4iYPuV0VOcIKcICrrjI3
         tji4eOJpJk7t1y9cymfJLpRaAdTRn/Vhe6ELKGR/wu51sOn/UpwV5j+jr8iPi8anFAfA
         Yb4NfiTHIDub+TDeCJ8MZm3HePL2kSQyKQpmTYQ2jr9w4AZBn4/NOFLi7lbksDHNYDZS
         P8qA==
X-Gm-Message-State: ANoB5pk2ri2Y1IHaO/KCUk5B5DaZZokgmNyHc7ozGlP6ipxKtlkDkLpl
        fp2swZ4WRC5FDUD8ljYpb82KHfHqc/SBoqPOWkgdOw==
X-Google-Smtp-Source: AA0mqf686eZ3z8ANHkMxehql392uJXU0Hg+WK81SK/sFgDiirmhQo7SA3f/ka+RNE7a+a59jYwoe7VGM3EJAuavBtAw=
X-Received: by 2002:a05:6902:11cd:b0:6e7:f2ba:7c0f with SMTP id
 n13-20020a05690211cd00b006e7f2ba7c0fmr3896476ybu.55.1668766740582; Fri, 18
 Nov 2022 02:19:00 -0800 (PST)
MIME-Version: 1.0
References: <CAO4mrfdb1UdjQxr0zLH9J8b6T+8kn4UOm-sO6nZ2aKErKg7i0A@mail.gmail.com>
 <CAG_fn=UHgpEcGLjvHu8ze6jV8q_R9uSnvbeijsFFNmqchAe6OA@mail.gmail.com> <f632781defea57a3c919ae91430f42e09f268de1.camel@redhat.com>
In-Reply-To: <f632781defea57a3c919ae91430f42e09f268de1.camel@redhat.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Fri, 18 Nov 2022 02:18:49 -0800
Message-ID: <CANn89iKmsJvV+U+xvYgqoBS6JTdQpvAwMC+-at7DWyApuwxicA@mail.gmail.com>
Subject: Re: KASAN: double-free in kfree
To:     Paolo Abeni <pabeni@redhat.com>
Cc:     Alexander Potapenko <glider@google.com>,
        Wei Chen <harperchen1110@gmail.com>,
        mathew.j.martineau@linux.intel.com, matthieu.baerts@tessares.net,
        davem@davemloft.net, kuba@kernel.org, netdev@vger.kernel.org,
        mptcp@lists.linux.dev, linux-kernel@vger.kernel.org,
        yoshfuji@linux-ipv6.org, dsahern@kernel.org, nathan@kernel.org,
        ndesaulniers@google.com, trix@redhat.com,
        syzkaller-bugs@googlegroups.com, syzkaller@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 18, 2022 at 1:57 AM Paolo Abeni <pabeni@redhat.com> wrote:
>
> On Fri, 2022-11-18 at 09:50 +0100, Alexander Potapenko wrote:
> > On Fri, Nov 18, 2022 at 8:37 AM Wei Chen <harperchen1110@gmail.com> wro=
te:
> > >
> > > Dear Linux Developer,
> > >
> > > Recently when using our tool to fuzz kernel, the following crash was =
triggered:
> > >
> > > HEAD commit: 4fe89d07 Linux v6.0
> > > git tree: upstream
> > > compiler: clang 12.0.0
> > > console output:
> > > https://drive.google.com/file/d/1_CdtSwaMJZmN-4dQw1mmZT0Ijq28X8aC/vie=
w?usp=3Dshare_link
> > > kernel config: https://drive.google.com/file/d/1ZHRxVTXHL9mENdAPmQYS1=
DtgbflZ9XsD/view?usp=3Dsharing
> > >
> > > Unfortunately, I didn't have a reproducer for this bug yet.
> >
> > Hint: if you don't have a reproducer for the bug, look at the process
> > name that generated the error (syz-executor.0 in this case) and try
> > the program from the log with that number ("executing program 0")
> > preceding the report:
> >
> > r0 =3D accept4(0xffffffffffffffff, &(0x7f0000000600)=3D@in=3D{0x2, 0x0,
> > @multicast2}, &(0x7f0000000680)=3D0x80, 0x80000)
> > r1 =3D socket$nl_generic(0x10, 0x3, 0x10)
> > r2 =3D syz_genetlink_get_family_id$mptcp(&(0x7f00000002c0), 0xfffffffff=
fffffff)
> > sendmsg$MPTCP_PM_CMD_DEL_ADDR(r1, &(0x7f0000000300)=3D{0x0, 0x0,
> > &(0x7f0000000000)=3D{&(0x7f0000000280)=3D{0x28, r2, 0x1, 0x0, 0x0, {},
> > [@MPTCP_PM_ATTR_ADDR=3D{0x14, 0x1, 0x0, 0x1,
> > [@MPTCP_PM_ADDR_ATTR_ADDR4=3D{0x8, 0x3, @multicast2=3D0xac14140a},
> > @MPTCP_PM_ADDR_ATTR_FAMILY=3D{0x6, 0x1, 0x2}]}]}, 0x28}}, 0x0)
> > sendmsg$MPTCP_PM_CMD_FLUSH_ADDRS(r0,
> > &(0x7f0000000780)=3D{&(0x7f00000006c0), 0xc,
> > &(0x7f0000000740)=3D{&(0x7f0000000700)=3D{0x1c, r2, 0x4, 0x70bd28,
> > 0x25dfdbfb, {}, [@MPTCP_PM_ATTR_SUBFLOWS=3D{0x8, 0x3, 0x8}]}, 0x1c},
> > 0x1, 0x0, 0x0, 0x4c890}, 0x20008040)
> > shmat(0xffffffffffffffff, &(0x7f0000ffd000/0x2000)=3Dnil, 0x1000)
> > r3 =3D shmget$private(0x0, 0x3000, 0x40, &(0x7f0000ffd000/0x3000)=3Dnil=
)
> > shmat(r3, &(0x7f0000ffc000/0x2000)=3Dnil, 0x7000)
> > syz_usb_connect$uac1(0x0, 0x8a,
> > &(0x7f0000000340)=3DANY=3D[@ANYBLOB=3D"12010000000000206b1f010140000102=
03010902780003010000000904000000010100000a2401000000020106061d154a00ffac190=
b2404007f1f0000000000000004010000010200000904010101010240000824020100000000=
09050109000000000000250100241694c11a11c200000009040200000102002009040201010=
502000009058209000000f456c30000fd240100000000000000000076af0bc3ac1605de4480=
cca53afa66f00807f17fb00132f9de1d1ec1d987f75530448d06a723ae111cb967ab97001d8=
26aaf1c7eb0f9d0df07d29aa5a01e58ccbbab20f723605387ba8179874ad74d25d7dd7699a8=
3189ba9c8b58980ea9cb58dd3a5afe7244a9d268d2397ac42994de8924d0478b17b13a564f6=
96432da53be08aff66deb52e3f7c90c28079a9562280b9fda5f881598636375cc77499c22fe=
673fe447ac74c25c0e2df0901d8babcdf31f59a3a15daae3f2"],
> > 0x0)
> > r4 =3D socket$alg(0x26, 0x5, 0x0)
> > bind$alg(r4, &(0x7f0000002240)=3D{0x26, 'skcipher\x00', 0x0, 0x0,
> > 'cts(cbc-twofish-3way)\x00'}, 0x58)
> > r5 =3D accept4(r4, 0x0, 0x0, 0x0)
> > syz_genetlink_get_family_id$nl80211(&(0x7f00000003c0), r5)
> > sendmsg$NL80211_CMD_SET_WOWLAN(r5, &(0x7f0000000440)=3D{0x0, 0x0,
> > &(0x7f0000000400)=3D{&(0x7f0000000480)=3DANY=3D[], 0x3e0}}, 0x0)
> > syz_genetlink_get_family_id$team(&(0x7f0000000040), r5)
> >
> >
> > > IMPORTANT: if you fix the bug, please add the following tag to the co=
mmit:
> > > Reported-by: Wei Chen <harperchen1110@gmail.com>
> >
> > @Eric, does this have something to do with "tcp: cdg: allow
> > tcp_cdg_release() to be called multiple times" ?
>
> The double free happens exactly in the same location and the tested
> kernel does not contain Eric's fix. This splat is a little different -
> it looks like the relevant chunk of memory has been re-used by some
> other task before being double-freed - still I think this is the same
> issue address by commit 72e560cb8c6f8 ("tcp: cdg: allow
> tcp_cdg_release() to be called multiple times").


Yes, this looks very similar to me.
