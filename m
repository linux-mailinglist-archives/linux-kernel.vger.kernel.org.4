Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91FAE6E57D9
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 05:28:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbjDRD2C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 23:28:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbjDRD2A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 23:28:00 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFF57EE
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 20:27:58 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-63b70f0b320so1412746b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 20:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681788478; x=1684380478;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2c0AMbW2RxgIo0VKdo1CjfH1jpEcTYqmQQ8hwsx9mnc=;
        b=HJpD3D/XdBjbwkuiasNzbemaHaVzz4rX7TlDttolv6hHEmETIbARzqVy8gvO53PQpP
         z+8dZ50vHnq/exotr4M3qOSloiPXxyobUqWRmVT7OnqdMGr6DDg2R8GiRu1yc5MoJi9h
         mN7dMGLTZQrJq8wfJZaEhYOVDlevifrmjWdl4Ie0cPhBBOrKxCR0Iq3cc858hRD/mr3P
         r7gEWZ9UYtFuc3zc4t9XqSUG9+bkJicGcnNpAN/c5o94uBKDxnzd4vaN1Uzrx0Mye3Ge
         UORNVhW0j9IErebAEEzMJvXuHDgY2vBtMHhjSUuda+n3DCl+V3srYJ20kz7eS/T7z5hZ
         j2IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681788478; x=1684380478;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2c0AMbW2RxgIo0VKdo1CjfH1jpEcTYqmQQ8hwsx9mnc=;
        b=SrTi6s5hAxWKggMtGAv9QaV5W1foTodGMdgne9oUEBPEbk9k1gc8IJCmUBi8KYIeS9
         P/cbQuQSA560fxCch7RvAr1TIXiU01srTsNHeNVANSYoG/PCphoLyuISccprrrfQCgjI
         9d8OjyHh9HBpSaol14vaGisUm3IriPBKh3zQreXOqaFOcHpL5rxPlOHPstXlC/jfMKQR
         bMefbxNt5muB4y7A05AqdDFHDixYivWFAnmXnWN50LakHtTVoZhwE1a7lFCYWvMVWkzD
         jYUGIQ24jTvo0YXKJEHOpPJGAJB6E5dx7AeKYh3Kv15HBhP213QcdMqyQUHH03veQHcI
         5PoA==
X-Gm-Message-State: AAQBX9cGVrDt2ArfYVBx1jsYr2DHtCMNSbKpe26ksYj0d/S9PU10SFDZ
        5VKAgK1vnJOHDnLhIWZTKTg=
X-Google-Smtp-Source: AKy350bWfZMCe1mz+gBU6ovl3M8s1ndRJEWrBZoK2VcQTTmCXH+Qy6NV1L1oZe42yrHDGWPlaP5/AQ==
X-Received: by 2002:a17:903:41c6:b0:1a6:8268:9055 with SMTP id u6-20020a17090341c600b001a682689055mr884907ple.24.1681788477836;
        Mon, 17 Apr 2023 20:27:57 -0700 (PDT)
Received: from smtpclient.apple ([47.75.78.161])
        by smtp.gmail.com with ESMTPSA id o11-20020a170902bccb00b0019309be03e7sm8400294pls.66.2023.04.17.20.27.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Apr 2023 20:27:57 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.300.101.1.3\))
Subject: Re: [PATCH v2] nvme/tcp: Add support to set the tcp worker cpu
 affinity
From:   Li Feng <lifeng1519@gmail.com>
In-Reply-To: <d71d4924-d2f0-3252-5268-5dafd1ebbc39@grimberg.me>
Date:   Tue, 18 Apr 2023 11:29:54 +0800
Cc:     Ming Lei <ming.lei@redhat.com>, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
        "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <5976C351-B2EB-4C25-A2AA-2A64EDD8CCDE@gmail.com>
References: <20230413062339.2454616-1-fengli@smartx.com>
 <20230413132941.2489795-1-fengli@smartx.com>
 <ZDz3TlFUxMxaO1W4@ovpn-8-16.pek2.redhat.com>
 <D8FFAFCB-5486-4211-9AC8-2779AE368183@gmail.com>
 <ZDz9vv6tbmKyhK7h@ovpn-8-16.pek2.redhat.com>
 <d71d4924-d2f0-3252-5268-5dafd1ebbc39@grimberg.me>
To:     Sagi Grimberg <sagi@grimberg.me>
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



> 2023=E5=B9=B44=E6=9C=8817=E6=97=A5 =E4=B8=8B=E5=8D=889:33=EF=BC=8CSagi =
Grimberg <sagi@grimberg.me> =E5=86=99=E9=81=93=EF=BC=9A
>=20
>=20
>>>> On Thu, Apr 13, 2023 at 09:29:41PM +0800, Li Feng wrote:
>>>>> The default worker affinity policy is using all online cpus, e.g. =
from 0
>>>>> to N-1. However, some cpus are busy for other jobs, then the =
nvme-tcp will
>>>>> have a bad performance.
>>>>=20
>>>> Can you explain in detail how nvme-tcp performs worse in this =
situation?
>>>>=20
>>>> If some of CPUs are knows as busy, you can submit the nvme-tcp io =
jobs
>>>> on other non-busy CPUs via taskset, or scheduler is supposed to =
choose
>>>> proper CPUs for you. And usually nvme-tcp device should be =
saturated
>>>> with limited io depth or jobs/cpus.
>>>>=20
>>>>=20
>>>> Thanks,
>>>> Ming
>>>>=20
>>>=20
>>> Taskset can=E2=80=99t work on nvme-tcp io-queues, because the worker =
cpu has decided at the nvme-tcp =E2=80=98connect=E2=80=99 stage,
>>> not the sending io stage. Assume there is only one io-queue, the =
binding cpu is CPU0, no matter io jobs
>>> run other cpus.
>> OK, looks the problem is on queue->io_cpu, see =
nvme_tcp_queue_request().
>> But I am wondering why nvme-tcp doesn't queue the io work on the =
current
>> cpu? And why is queue->io_cpu introduced? Given blk-mq defines cpu
>> affinities for each hw queue, driver is supposed to submit IO request
>> to hardware on the local CPU.
>> Sagi and Guys, any ideas about introducing queue->io_cpu?
>=20
> Hey Ming,
>=20
> I have some vague memories wrt to this, but from what I recall:
>=20
> - The number of queues is dependent on both the controller and
> the user (Not a reason/motivation on its own, just clarifying).
>=20
> - It simply matches what pci does (to some extent, outside of rx side
> entropy that may exist), it just happens to take more cpu cycles due =
to
> the network stack overhead.
>=20
> - I didn't want io threads to change CPUs because of RFS/aRFS
> optimizations that people use, which allows the NIC to steer =
interrupts
> (and napi context) to where the io thread is running, and thus =
minimize
> latency due to improved locality. that on its own was shown to be =
worth
> over 30% reduction.
>=20
RFS works not good here. On my aarch64, the NIC irq is handled on NUMA =
node 2 CPU.
And nvme-tcp io-queue is busy on CPU0.

> - At some point nvme-tcp rx context used to run in softirq, and having
> to synchronize different cores (on different numa nodes maybe, depends
> on what RSS decided) when processing the socket resulted in high
> latency as well. This is not the case today (due to some nics back =
then
> that surfaced various issues with this) but it may be come back in
> the future again (if shown to provide value).
>=20
> - Also today when there is a sync network send from .queue_rq path,
> it is only executed when the running cpu =3D=3D queue->io_cpu, to =
avoid high
> contention. My concern is that if the io context is not bound to
> a specific cpu, it may create heavier contention on queue =
serialization.
> Today there are at most 2 contexts that compete, io context (triggered =
from network rx or scheduled in the submission path) and .queue_rq sync
> network send path. I'd prefer to not have to introduce more contention =
with increasing number of threads accessing an nvme controller.
>=20
> Having said that, I don't think there is a fundamental issue with
> using queue_work, or queue_work_node(cur_cpu) or
> queue_work_node(netdev_home_cpu), if that does not introduce
> additional latency in the common cases. Although having io threads
> bounce around is going to regress users that use RFS/aRFS...

