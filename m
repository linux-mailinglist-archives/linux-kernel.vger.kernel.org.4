Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49C706E4196
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 09:48:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230045AbjDQHs4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 03:48:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbjDQHsw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 03:48:52 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCAE21BF6
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 00:48:51 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id f2so16123526pjs.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 00:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681717731; x=1684309731;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SoxNZpdn1HHFFTHQnEQSPesnrC0r0JBqOwFpAAsz2Tc=;
        b=nFlhCc39H9KHnsfKxPUrqKoFYe0nizIWXf+rPLilZlWO47hZ/CdS5Few5q9kvf7QU6
         2kLhsBXG+jZ6+VUoSb1jo2W6nUs/0zgREsY3gKEAWCwo1IxBwwGPdcjUYEcJeHapKRRC
         gVgjNQfuwqpxdnxYBQc9n+YGM1TFJZwbvX1uHWILxQf81H8RQAKugie9DZEQ5bBZt336
         i3YGA2sUMlS9R9cGaq8om1H/UQRfgefxqi1y7TUSiLouh8zCVgTzq+5n0jldEE0fukGu
         Iwwl7gI+CcKy3xirfbqGbvylQg7icZrKAcEWDgn9sADhy9Fzwl8zP31QXQgvfh0/ERMK
         wkJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681717731; x=1684309731;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SoxNZpdn1HHFFTHQnEQSPesnrC0r0JBqOwFpAAsz2Tc=;
        b=RWDqwjbPNWpgS+F56hxt5OTsewBNCJdGSYaU7T11Ye2LCy3pRUEWjpTybDfn00ANSz
         LV8V+WrSg52S95/be4DJRSWrkLnjyWe21gt/iZYHWsqQsODkFvUXoQE9KoHVdwJ358cf
         xp6G8vC9gk9KCtaSVbzq+ngTboZQSIlBY09CswvpUhG29ddadS/fJwUpALrcWcDCzQis
         dlt10yqvDZ5RVqOR77RJZElczPo/+U9sR/RfSWoHJhfeLZW19O4J4FVIsHrTW/BDeDlB
         dxZYCjFHBc1C076Rb5jWJ705L8CygZ2YzGzKMQVmFSUdeUfG2o9oUdGPccb+yT5JKVZN
         Irsw==
X-Gm-Message-State: AAQBX9eoIROmxv6gsuGcz5VYsU5fD2NmzIF3mFUn80Q9LguDZMf1mMoA
        nB++D3THC5QUKpYgcPziBjo=
X-Google-Smtp-Source: AKy350Za9LWc+u9SpDYBXSZNLVNaUStLL42eU/h9/NkP/65mV2jBfzHrCdpGUrihF8eMfGdhB3pAdw==
X-Received: by 2002:a17:902:c405:b0:1a1:a8db:495d with SMTP id k5-20020a170902c40500b001a1a8db495dmr16485143plk.4.1681717731019;
        Mon, 17 Apr 2023 00:48:51 -0700 (PDT)
Received: from smtpclient.apple ([47.243.123.68])
        by smtp.gmail.com with ESMTPSA id jf1-20020a170903268100b001a1ccb37847sm7047135plb.146.2023.04.17.00.48.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Apr 2023 00:48:50 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.300.101.1.3\))
Subject: Re: [PATCH v2] nvme/tcp: Add support to set the tcp worker cpu
 affinity
From:   Li Feng <lifeng1519@gmail.com>
In-Reply-To: <ZDz3TlFUxMxaO1W4@ovpn-8-16.pek2.redhat.com>
Date:   Mon, 17 Apr 2023 15:50:46 +0800
Cc:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <D8FFAFCB-5486-4211-9AC8-2779AE368183@gmail.com>
References: <20230413062339.2454616-1-fengli@smartx.com>
 <20230413132941.2489795-1-fengli@smartx.com>
 <ZDz3TlFUxMxaO1W4@ovpn-8-16.pek2.redhat.com>
To:     Ming Lei <ming.lei@redhat.com>
X-Mailer: Apple Mail (2.3731.300.101.1.3)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> 2023=E5=B9=B44=E6=9C=8817=E6=97=A5 =E4=B8=8B=E5=8D=883:37=EF=BC=8CMing =
Lei <ming.lei@redhat.com> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> On Thu, Apr 13, 2023 at 09:29:41PM +0800, Li Feng wrote:
>> The default worker affinity policy is using all online cpus, e.g. =
from 0
>> to N-1. However, some cpus are busy for other jobs, then the nvme-tcp =
will
>> have a bad performance.
>=20
> Can you explain in detail how nvme-tcp performs worse in this =
situation?
>=20
> If some of CPUs are knows as busy, you can submit the nvme-tcp io jobs
> on other non-busy CPUs via taskset, or scheduler is supposed to choose
> proper CPUs for you. And usually nvme-tcp device should be saturated
> with limited io depth or jobs/cpus.
>=20
>=20
> Thanks,=20
> Ming
>=20

Taskset can=E2=80=99t work on nvme-tcp io-queues, because the worker cpu =
has decided at the nvme-tcp =E2=80=98connect=E2=80=99 stage,
not the sending io stage. Assume there is only one io-queue, the binding =
cpu is CPU0, no matter io jobs
run other cpus.


