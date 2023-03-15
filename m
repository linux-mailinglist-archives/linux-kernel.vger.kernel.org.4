Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 282466BB16B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 13:27:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232521AbjCOM1Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 08:27:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232153AbjCOM0z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 08:26:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9D1F984D7
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 05:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678883078;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dPw/Ks6QBaOqWWxEpNJj00JEv+tZ3rSRjaNJhGrus/c=;
        b=PjdI6v/cJ52RoyAvWTaL1pdFw2MyhZbiAqYLUus3OhwXy8Xo/yP8VjCqKdlJ8WJPEY4liQ
        xDL9YYyrC/Semdqh7Dji49AmWLkPHD+67Ay1O6L6u0f7I4RmJ5CQXg7KSj1YPwwuwfjI53
        sOaAFdIelt5gzpjYnZ84AYIhwKeNclk=
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-128-hdFt_7jVOMaq9gagXe85Tw-1; Wed, 15 Mar 2023 08:24:37 -0400
X-MC-Unique: hdFt_7jVOMaq9gagXe85Tw-1
Received: by mail-vs1-f72.google.com with SMTP id i21-20020a05610221b500b004258d5ee8c4so3110181vsb.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 05:24:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678883077;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dPw/Ks6QBaOqWWxEpNJj00JEv+tZ3rSRjaNJhGrus/c=;
        b=ymEAuD4XY5iPVGUZnhQMPxMEpueHFfpD66iWqBeImeAU63nFruP10dd6uJlnxK2+Xn
         cX1ahEfT/yz2no9HWpoeC2YqgwGeQl8bgicrGM1OEJdPM9jNWlDYEW8PkqHUeD3tEXxq
         zattzkMet4BXn/iI031cYNsVyADdHmm19o/G/CqL/cOOXQ1U+A+dJ3koyUJHzEOcKzsh
         mBpmsc7kJ9LLeJOHraqdQrIvRIPGbgSrz/AeoXhAGB8VlxsLxUrxJoYGTp4Cx/TJ8wX4
         wxxH0of+O/OrNhEtv9GzxD9S9a9kq+D2Ev2NcyCOFkjgkrY1NVLJJs5MkFFK7sAo47DO
         MOxA==
X-Gm-Message-State: AO0yUKV9cH//aw45oG+5cBh9qnpN+XLf5sOdtJYg3yufvBa5e4A7q2eO
        XTShuUfpRTLhe1eme3Y2hjBiE+thXR661NpTPZBN1NhJvl150n/JKb4hQbgpX1qrRca4TYWvPFz
        xbGmGEEFynBYlOB6EnSU0AMdgspe+injbEUx5UW1N
X-Received: by 2002:a05:6102:3d97:b0:425:174e:7c58 with SMTP id h23-20020a0561023d9700b00425174e7c58mr8193957vsv.1.1678883076895;
        Wed, 15 Mar 2023 05:24:36 -0700 (PDT)
X-Google-Smtp-Source: AK7set8wfhDMle/ECyR887UDmJHj9xjcy2cD0mGT5pgqPQ3YLLnCDfFC1VZdfTh6dZNXpdmMaZNP1p48XVTQlld4a40=
X-Received: by 2002:a05:6102:3d97:b0:425:174e:7c58 with SMTP id
 h23-20020a0561023d9700b00425174e7c58mr8193947vsv.1.1678883076636; Wed, 15 Mar
 2023 05:24:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230131181820.179033-1-bgardon@google.com> <CABgObfaP7P7fk66-EGF-zPEk0H14u3YkM42FRXrEvU=hwFSYgg@mail.gmail.com>
 <CABgObfYAStAC5FgJfGUiJ=BBFtN7drD+NGHLFJY5fP3hQzVOBw@mail.gmail.com> <CALzav=c-wtJiz9M6hpPtcoBMFvFP5_2BNYoY66NzF-J+8_W6NA@mail.gmail.com>
In-Reply-To: <CALzav=c-wtJiz9M6hpPtcoBMFvFP5_2BNYoY66NzF-J+8_W6NA@mail.gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Date:   Wed, 15 Mar 2023 13:24:25 +0100
Message-ID: <CABgObfYm6roWVR0myT5rHUWRe7k09TkXgZ7rYAr019QZ80oQXQ@mail.gmail.com>
Subject: Re: [PATCH V5 0/2] selftests: KVM: Add a test for eager page splitting
To:     David Matlack <dmatlack@google.com>
Cc:     Ben Gardon <bgardon@google.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, Peter Xu <peterx@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Vipin Sharma <vipinsh@google.com>,
        Ricardo Koller <ricarkol@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 14, 2023 at 5:00=E2=80=AFPM David Matlack <dmatlack@google.com>=
 wrote:
> On Tue, Mar 14, 2023 at 7:23=E2=80=AFAM Paolo Bonzini <pbonzini@redhat.co=
m> wrote:
> > $ tools/testing/selftests/kvm/x86_64/dirty_log_page_splitting_test
> > Testing guest mode: PA-bits:ANY, VA-bits:48,  4K pages
> > guest physical test memory: [0x7fc7fe00000, 0x7fcffe00000)
> > =3D=3D=3D=3D Test Assertion Failure =3D=3D=3D=3D
> >   x86_64/dirty_log_page_splitting_test.c:195: __a =3D=3D __b
> >   pid=3D1378203 tid=3D1378203 errno=3D0 - Success
> >      1    0x0000000000402d02: run_test at dirty_log_page_splitting_test=
.c:195
> >      2    0x000000000040367c: for_each_guest_mode at guest_modes.c:100
> >      3    0x00000000004024df: main at dirty_log_page_splitting_test.c:2=
45
> >      4    0x00007f4227c3feaf: ?? ??:0
> >      5    0x00007f4227c3ff5f: ?? ??:0
> >      6    0x0000000000402594: _start at ??:?
> >   ASSERT_EQ(stats_populated.pages_4k, stats_repopulated.pages_4k) faile=
d.
> >     stats_populated.pages_4k is 0x413
> >     stats_repopulated.pages_4k is 0x412
>
> I wonder if pages are getting swapped, especially if running on a
> workstation. If so, mlock()ing all guest memory VMAs might be
> necessary to be able to assert exact page counts.

I don't think so, it's 100% reproducible and the machine is idle and
only accessed via network. Also has 64 GB of RAM. :)

Paolo

