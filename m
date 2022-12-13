Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A84064B8AD
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 16:40:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235847AbiLMPkK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 10:40:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235639AbiLMPkI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 10:40:08 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 012252F8
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 07:40:07 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id fc4so37392206ejc.12
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 07:40:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ILpM5LpfCtgvaR8spaJOQHAQvN8pz0k7KsYQo/byGFY=;
        b=sZzomQln12xbOyxq7mY5YoVaS67L5yz42RZHr9MiVzgi6cQndzXus//tHvmSSRAYCm
         PuIATHpqLjfe2LUIKwU1i/HnUf8vOei/VUbVmESxl54PrKT1L5Chcxl8557KRWJD7sk+
         jS63vZN50ZqRuIbWZL5ZioEgd1osZDl6FSLeYY+uxSslgDdc2sxBqQoAnwXjuGFJiMnT
         Zond65wcql5KQ8PtvcDg9dDneqOV3Fy2p4BU6tML5Q87kISChQqhxUMM2eGTrQYdkjEA
         QbiYUpbudn6iW9tAi3LvVbHlHa2dh7YZpJT2Vh5GIkgfujJAZeQjfhDsWka+zUKjlIFm
         T6LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ILpM5LpfCtgvaR8spaJOQHAQvN8pz0k7KsYQo/byGFY=;
        b=yysSirf7tjmZ+S/Aycb+leJ+VWSuwVHOOR0oGq2bMRxTyrOzr59QEwJ4NkAYdHZeVA
         XfqODUVajPS6QHtj3L50QiG8YvCTtwTMlsx6hpnl4AqseSfEO30dHR7EbgAD9pi99i+c
         WT6YXZYawMcr2pD981tVLzVecLFLivw64eV7fiEboJ64I6hEVWPtZqe+zGHN2MXXp7G7
         OJ0uAzABWDsGzV0wz0IcYhfiDeC/8Wx46UGZGO1KVV35VuQxV9BaUKikoSPmXULt1kQH
         5GpETpIJ1GzBaaYzip/2JeSzy5cePM9f1p6I7IAOrtxGGRScwj9e8NleoKf8lvK49bRl
         rjNQ==
X-Gm-Message-State: ANoB5pmZ3lhdf9jssuj7sj76bwcKtOn7sQMW8IszuNTEDLMPWunzCIlm
        R52w+6vkjnhmEpaM14Pk8WaFsQ==
X-Google-Smtp-Source: AA0mqf7SkuuK2blorw3tUDWeJ2H1w26BHN1Tqo0IqrMNBnWdp/57ukQKq+lPGeiaExqBPXyHVjZ2+Q==
X-Received: by 2002:a17:906:86ca:b0:7c0:f2cf:23fb with SMTP id j10-20020a17090686ca00b007c0f2cf23fbmr18484888ejy.52.1670946005511;
        Tue, 13 Dec 2022 07:40:05 -0800 (PST)
Received: from mbp-di-paolo.station (net-2-37-165-98.cust.vodafonedsl.it. [2.37.165.98])
        by smtp.gmail.com with ESMTPSA id b18-20020a1709063cb200b007ba46867e6asm4760257ejh.16.2022.12.13.07.40.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Dec 2022 07:40:05 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH V10 0/8] block, bfq: extend bfq to support multi-actuator
 drives
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <20221209094442.36896-1-paolo.valente@linaro.org>
Date:   Tue, 13 Dec 2022 16:40:03 +0100
Cc:     linux-block <linux-block@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Arie van der Hoeven <arie.vanderhoeven@seagate.com>,
        Rory Chen <rory.c.chen@seagate.com>,
        Glen Valante <glen.valante@linaro.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <A0328388-7C6B-46A4-A05E-DCD6D91334AE@linaro.org>
References: <20221209094442.36896-1-paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
X-Mailer: Apple Mail (2.3445.104.11)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jens, Damien,
can we consider this for 6.2?

Thanks,
Paolo

> Il giorno 9 dic 2022, alle ore 10:44, Paolo Valente =
<paolo.valente@linaro.org> ha scritto:
>=20
> Hi,
> here is the V10, it differs from V9 in that it applies the
> recommendation by Damien in [2].
>=20
> Here is the whole description of this patch series again.  This
> extension addresses the following issue. Single-LUN multi-actuator
> SCSI drives, as well as all multi-actuator SATA drives appear as a
> single device to the I/O subsystem [1].  Yet they address commands to
> different actuators internally, as a function of Logical Block
> Addressing (LBAs). A given sector is reachable by only one of the
> actuators. For example, Seagate=E2=80=99s Serial Advanced Technology
> Attachment (SATA) version contains two actuators and maps the lower
> half of the SATA LBA space to the lower actuator and the upper half to
> the upper actuator.
>=20
> Evidently, to fully utilize actuators, no actuator must be left idle
> or underutilized while there is pending I/O for it. To reach this
> goal, the block layer must somehow control the load of each actuator
> individually. This series enriches BFQ with such a per-actuator
> control, as a first step. Then it also adds a simple mechanism for
> guaranteeing that actuators with pending I/O are never left idle.
>=20
> See [1] for a more detailed overview of the problem and of the
> solutions implemented in this patch series. There you will also find
> some preliminary performance results.
>=20
> Thanks,
> Paolo
>=20
> [1] =
https://www.linaro.org/blog/budget-fair-queueing-bfq-linux-io-scheduler-op=
timizations-for-multi-actuator-sata-hard-drives/
> [2] =
https://lore.kernel.org/lkml/20221208104351.35038-1-paolo.valente@linaro.o=
rg/T/#t
>=20
> Davide Zini (3):
>  block, bfq: split also async bfq_queues on a per-actuator basis
>  block, bfq: inject I/O to underutilized actuators
>  block, bfq: balance I/O injection among underutilized actuators
>=20
> Federico Gavioli (1):
>  block, bfq: retrieve independent access ranges from request queue
>=20
> Paolo Valente (4):
>  block, bfq: split sync bfq_queues on a per-actuator basis
>  block, bfq: forbid stable merging of queues associated with different
>    actuators
>  block, bfq: move io_cq-persistent bfqq data into a dedicated struct
>  block, bfq: turn bfqq_data into an array in bfq_io_cq
>=20
> block/bfq-cgroup.c  |  94 +++----
> block/bfq-iosched.c | 584 ++++++++++++++++++++++++++++++--------------
> block/bfq-iosched.h | 142 ++++++++---
> block/bfq-wf2q.c    |   2 +-
> 4 files changed, 566 insertions(+), 256 deletions(-)
>=20
> --
> 2.20.1

