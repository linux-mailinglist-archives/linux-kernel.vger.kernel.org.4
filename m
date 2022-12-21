Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1290D652B87
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 03:41:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234214AbiLUCle (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 21:41:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbiLUClb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 21:41:31 -0500
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB5FD1D0EC
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 18:41:30 -0800 (PST)
Received: by mail-qt1-x82e.google.com with SMTP id c7so12727188qtw.8
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 18:41:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fMhzqhqWq7UkrwtJ6ZqboyA3KFySyX0rXKAhLHPSdxI=;
        b=l3utyhobS6jS5RhkL2EKink3aSp7+2VybDeEXko1NcMcqStPk1+tFzxDNvKrGu8ffd
         LL8fxBQRBnsoL7MQz7KzDa+HJRuURIRzpjwN1XC9uFMIVcDg1emThrU2NYPk70waUUnH
         +QGtxyvyvOex0N1E7n/948MavKr8bQU3HUc60=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fMhzqhqWq7UkrwtJ6ZqboyA3KFySyX0rXKAhLHPSdxI=;
        b=sPJCoSvVAeB74YdPDppbiUo+iHQ4uGPd19WSYbVN7Ve/+aWyduLwhAwmm+miYnBVI3
         EhMCMNb3KZ9Nu3FlWZccFk1CezqzK1cwdnTUD4hF//hrJ8D1J/SNE7277u8js1mo3O9k
         Fxyn2tQ3dK6LYe78VHsuvh9mq/dHHOJz2qmFy+ekiTw4M53eVqKdSMmfGRGp/r+ftnC/
         9YJKltXz8FoLASPk2Ykc0aL6mw0SQL97PJVLzMUTSn8ToccbNyXTTmXAdz1tC6nEfSl6
         I+ZJzyfNL7YK4uYLJ00ZPFVMW8CYs0wHf2LmyuXjHVXnNX8MJ6UP583zYjngkvinyA1j
         d6MQ==
X-Gm-Message-State: AFqh2krvWfiSywu/KnsZA507BJyLPKZobvTQ4jpvBbD9lEFC2gmNbfi2
        hKPDzmNvir3yWbsmc074jN6Bhw==
X-Google-Smtp-Source: AMrXdXsXSk03wijWPMH7tmFpozZvDgbIcfRVQH3NWQ0YJTsvJWJT3pFsqo0N2zFyB6t4H9DjiagPYg==
X-Received: by 2002:ac8:735a:0:b0:3a6:2170:b089 with SMTP id q26-20020ac8735a000000b003a62170b089mr6859611qtp.12.1671590489812;
        Tue, 20 Dec 2022 18:41:29 -0800 (PST)
Received: from smtpclient.apple (c-98-249-43-138.hsd1.va.comcast.net. [98.249.43.138])
        by smtp.gmail.com with ESMTPSA id i17-20020a05620a405100b006fcb77f3bd6sm10471535qko.98.2022.12.20.18.41.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Dec 2022 18:41:28 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Joel Fernandes <joel@joelfernandes.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [RFC 0/2] srcu: Remove pre-flip memory barrier
Date:   Tue, 20 Dec 2022 21:41:17 -0500
Message-Id: <0B1950D8-9319-4F25-B14B-4ED949A57BE0@joelfernandes.org>
References: <20221221004957.GA29021@lothringen>
Cc:     linux-kernel@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
In-Reply-To: <20221221004957.GA29021@lothringen>
To:     Frederic Weisbecker <frederic@kernel.org>
X-Mailer: iPhone Mail (20B101)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Dec 20, 2022, at 7:50 PM, Frederic Weisbecker <frederic@kernel.org> wro=
te:
>=20
> =EF=BB=BFOn Tue, Dec 20, 2022 at 07:15:00PM -0500, Joel Fernandes wrote:
>> On Tue, Dec 20, 2022 at 5:45 PM Frederic Weisbecker <frederic@kernel.org>=
 wrote:
>> Agreed about (1).
>>=20
>>> _ In (2), E pairs with the address-dependency between idx and lock_count=
.
>>=20
>> But that is not the only reason. If that was the only reason for (2),
>> then there is an smp_mb() just before the next-scan post-flip before
>> the lock counts are read.
>=20
> The post-flip barrier makes sure the new idx is visible on the next READER=
's
> turn, but it doesn't protect against the fact that "READ idx then WRITE lo=
ck[idx]"
> may appear unordered from the update side POV if there is no barrier betwe=
en the
> scan and the flip.
>=20
> If you remove the smp_mb() from the litmus test I sent, things explode.

Sure I see what you are saying and it=E2=80=99s a valid point as well. Howev=
er why do you need memory barrier D (labeled such in the kernel code) for th=
at? You already have a memory barrier A before the lock count is read. That w=
ill suffice for the ordering pairing with the addr dependency.
In other words, if updater sees readers lock counts, then reader would be ma=
king those lock count updates on post-flip inactive index, not the one being=
 scanned as you wanted, and you will accomplish that just with the mem barri=
er A.

So D fixes the above issue you are talking about (lock count update), howeve=
r that is already fixed by the memory barrier A. But you still need D for th=
e issue I mentioned (unlock counts vs flip).

That=E2=80=99s just my opinion and let=E2=80=99s discuss more because I cann=
ot rule out that I am missing something with this complicated topic ;-)

Thanks.=
