Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03F9D7355F9
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 13:39:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230450AbjFSLjW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 07:39:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230187AbjFSLjU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 07:39:20 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E0AA102
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 04:39:19 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id 5614622812f47-39ecf031271so939522b6e.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 04:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687174759; x=1689766759;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZwN949FKpBoWup2vDeMXlLf5SOCscoemI7m4b6lJA/8=;
        b=eK5mbO/TtsfutJ429U/4gnlj1YStQsbigOZHRgvirpyMsMbJraRqH2/6HT40hpn0vQ
         Uiaw5kvWTxGdHpgb+Ydcv4y/5DDIr/RaZfwmHJqCRVxDwHUIQ241HRTSxPl1e4XISu9k
         K73FwoLrHzMBYpTAsU5BskfZ6scg4JMA+QeqgA4F7Uz19nc5OKbhrMI36g3HAAu6k7ec
         XAtlDvOqaKcaWzPcp2R3VbTtnRb8PY9GjAzGRhRrtEtKmW8a8HjEEhrLkkjZOlbTbkzM
         T11ctpZhM715Xjja0PLMQPU4ajcLYKJa1HwnrMX4qVJw/L5W37JaMoGCCaM0yPE5Qzky
         3AWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687174759; x=1689766759;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZwN949FKpBoWup2vDeMXlLf5SOCscoemI7m4b6lJA/8=;
        b=IN2J0mMaiY35/MAC5sJoNI7rNExCkB4bo8rSxmQpydiCmpnnG6hjvsAJcAofhQnMC8
         pXOU7XfYS5N4IEdRgESPhf4zGv/5Bpn5lqivteQOZKuHOEdELuOkzL516ciSNhg8QABV
         UrJYBl14+g06h/nJuVAtubsBVx01nOMHrWkBS0KeHmCTl8jt2gxKTeR9g7IajDeHZPnK
         GCIZWzPX75txYZz0npFzynOWIEJ0lQ6n1bDC36AteNrFHmSHF9pwpI14M5dPEjhAc6qC
         TzluiyeY72BsCPG4dXrWtkjcYBJpcYhnrjDU+8rE6L03krs5+8DAM3x/8k7JMQ3v3LVe
         q8Lw==
X-Gm-Message-State: AC+VfDxMC1Z4heksnPYaWMZsf2AWKlRVRYYe/aCVLIyGO1K8jYIgxEll
        aJLXkQ9F7QyyPPfPF2GShPKk7pnnz20qiw==
X-Google-Smtp-Source: ACHHUZ7MWF5wfJAo5Db1NwDaEK6A1f4h4cgigIOU/a+DjKf6Js76gWjW4UBqTQxN/g9Fvnvu6dJfPQ==
X-Received: by 2002:a05:6808:1449:b0:3a0:3144:dd3c with SMTP id x9-20020a056808144900b003a03144dd3cmr756493oiv.2.1687174758766;
        Mon, 19 Jun 2023 04:39:18 -0700 (PDT)
Received: from smtpclient.apple ([2402:d0c0:2:a2a::1])
        by smtp.gmail.com with ESMTPSA id gf4-20020a17090ac7c400b0026094c23d0asm1480961pjb.17.2023.06.19.04.39.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Jun 2023 04:39:18 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.400.51.1.1\))
Subject: Re: [PATCH] list: Remove unnecessary WRITE_ONCE()
From:   Alan Huang <mmpgouride@gmail.com>
In-Reply-To: <CANn89iJgM1-SBzHXDdur+MgK2cBBeOacKOWz=zPyEa2mee3fOw@mail.gmail.com>
Date:   Mon, 19 Jun 2023 19:39:04 +0800
Cc:     paulmck@kernel.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <4E6A0BCB-02F4-4AB9-BE56-7FC7C15A6B2C@gmail.com>
References: <20230619090336.145738-1-mmpgouride@gmail.com>
 <CANn89iJgM1-SBzHXDdur+MgK2cBBeOacKOWz=zPyEa2mee3fOw@mail.gmail.com>
To:     Eric Dumazet <edumazet@google.com>
X-Mailer: Apple Mail (2.3731.400.51.1.1)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> 2023=E5=B9=B46=E6=9C=8819=E6=97=A5 19:02=EF=BC=8CEric Dumazet =
<edumazet@google.com> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> On Mon, Jun 19, 2023 at 11:03=E2=80=AFAM Alan Huang =
<mmpgouride@gmail.com> wrote:
>>=20
>> Commit c54a2744497d("list: Add hlist_unhashed_lockless()") added
>> various WRITE_ONCE() to pair with the READ_ONCE() in
>> hlist_unhashed_lockless(), but there is no need to protect
>> ->next with WRITE_ONCE(). Therefore, this commit removes those
>> unnecessary WRITE_ONCE().
>=20
> Why are they unnecessary ?

There is no reader locklessly read ->next.

These functions are protected by something like spin_lock, only the =
thread running=20
the function can access ->next.

> They seem just fine to me.
> Please elaborate.

