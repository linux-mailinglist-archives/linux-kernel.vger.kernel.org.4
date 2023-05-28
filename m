Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 723EC713762
	for <lists+linux-kernel@lfdr.de>; Sun, 28 May 2023 03:21:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229477AbjE1BV2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 May 2023 21:21:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjE1BV0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 May 2023 21:21:26 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04E8CD3
        for <linux-kernel@vger.kernel.org>; Sat, 27 May 2023 18:21:25 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-51492ae66a4so967428a12.1
        for <linux-kernel@vger.kernel.org>; Sat, 27 May 2023 18:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1685236883; x=1687828883;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XwTMqNXJxZngfAiFWVhcJnTq6nmvJ33/9Fzz5GiyWWk=;
        b=HvdtVhLAR2W1pMjW56B3uOfnxErxKXMBHe25hDnziAGoKKyrn69dT85wVYtO6XW/aF
         RJ1+2DEL9xyBI6PpLm4YDWEYvWMdZa9hQRcNtst5RjoQL0plq/YbQTe7hjgm1ddB0sdP
         VaAQBLskb0r7tUwLLOZnGMkO2NZvMHH/mZ6es=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685236883; x=1687828883;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XwTMqNXJxZngfAiFWVhcJnTq6nmvJ33/9Fzz5GiyWWk=;
        b=I0YEUtyNgAngTCbMtKQk0pWugzOhn1ZBAKZ30IefezMZ1ltIoHQJ+oq+Za2oG8tbZH
         2D23fLcwhDbmss/IU+S2JAZSmOLeUPSGXTAIk+lIV8nZ7JdL+ThXbqBful1RU0Krx9ZF
         QEyQ6FVPKz1GaueCp+quTnJf3pRZhlA7LR8wfmIrFk6teP0mHVahlYg2PSKRa4SZ5nDy
         23Cdv+tMSVTuzjrwfYM55Qy8E90k+NO0V0XeelJdkhEDP0RlSxMwCt+PCr2lPcHukxIU
         DWHgclipqOwnNoQ5+lCEHdUgGl3GS8pRJEKLirj+e1DHWsM+93CZ+BcNl4O0pXb6HaRk
         AiYw==
X-Gm-Message-State: AC+VfDwIW4pIM/0IMJbE4ze7+WtI9FSjS02C/r3KtS92elfWyNN/D5uH
        T3ybW9oygb3v0V2oZr1O8ucwmsIFAzu8p57qwDWokdiO
X-Google-Smtp-Source: ACHHUZ4t7WkAEvaxruaz7WEvPxE8oV9YIyKVFzNjXqN5zwpwmJ98ZM0g1WeS3eE8ZDy9trPUcoHCqQ==
X-Received: by 2002:a17:907:e86:b0:965:6d21:48bc with SMTP id ho6-20020a1709070e8600b009656d2148bcmr7035107ejc.75.1685236882965;
        Sat, 27 May 2023 18:21:22 -0700 (PDT)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com. [209.85.218.41])
        by smtp.gmail.com with ESMTPSA id k12-20020a170906128c00b00965a52d2bf6sm3960193ejb.88.2023.05.27.18.21.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 27 May 2023 18:21:21 -0700 (PDT)
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-96f8d485ef3so326863266b.0
        for <linux-kernel@vger.kernel.org>; Sat, 27 May 2023 18:21:21 -0700 (PDT)
X-Received: by 2002:a17:907:2682:b0:96a:440b:d5c8 with SMTP id
 bn2-20020a170907268200b0096a440bd5c8mr5866751ejc.59.1685236880680; Sat, 27
 May 2023 18:21:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230522025124.5863-1-michael.christie@oracle.com>
 <20230522025124.5863-4-michael.christie@oracle.com> <20230522123029.GA22159@redhat.com>
 <cfca7764-d210-6df9-e182-2c093101c6cf@oracle.com> <20230522174757.GC22159@redhat.com>
 <20230523121506.GA6562@redhat.com> <87bkib6nxr.fsf@email.froward.int.ebiederm.org>
 <20230524141022.GA19091@redhat.com> <87ttw1zt4i.fsf@email.froward.int.ebiederm.org>
 <20230525115512.GA9229@redhat.com> <87y1lcxwcj.fsf@email.froward.int.ebiederm.org>
 <CAHk-=wj4DS=2F5mW+K2P7cVqrsuGd3rKE_2k2BqnnPeeYhUCvg@mail.gmail.com>
 <87cz2mrtnk.fsf@email.froward.int.ebiederm.org> <CAHk-=whsi9JFP-okH3jXHrA8rh8bMuuSt6ZgkmPwiDMAn437qA@mail.gmail.com>
 <87mt1pmezu.fsf@email.froward.int.ebiederm.org>
In-Reply-To: <87mt1pmezu.fsf@email.froward.int.ebiederm.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 27 May 2023 18:21:03 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjkLs3PU+MaF67TBQpUcZZEhoc9MB0iXYamb7FDPH6mOw@mail.gmail.com>
Message-ID: <CAHk-=wjkLs3PU+MaF67TBQpUcZZEhoc9MB0iXYamb7FDPH6mOw@mail.gmail.com>
Subject: Re: [PATCH 3/3] fork, vhost: Use CLONE_THREAD to fix freezer/ps regression
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        Mike Christie <michael.christie@oracle.com>,
        linux@leemhuis.info, nicolas.dichtel@6wind.com, axboe@kernel.dk,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, mst@redhat.com,
        sgarzare@redhat.com, jasowang@redhat.com, stefanha@redhat.com,
        brauner@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 27, 2023 at 6:17=E2=80=AFPM Eric W. Biederman <ebiederm@xmissio=
n.com> wrote:
>
> It seems like a good approach for including in the -rc series.
> I think the change should look more like my change below.

I have no objections. My patch was a fairly "hack and slash" thing to
just disassociate the IO workers entirely from the core dumping. Yours
seems to be slightly more surgical.

                  Linus
