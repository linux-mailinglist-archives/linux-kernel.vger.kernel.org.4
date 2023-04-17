Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B4876E4197
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 09:49:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230213AbjDQHtB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 03:49:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbjDQHsz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 03:48:55 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3710E2106
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 00:48:53 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id hg14-20020a17090b300e00b002471efa7a8fso11663488pjb.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 00:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681717732; x=1684309732;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SoxNZpdn1HHFFTHQnEQSPesnrC0r0JBqOwFpAAsz2Tc=;
        b=BEGN4X3DPm7/u9fz19Gd1E1z4Ul0bVHDfLMsS3jstC+U3YeSQIz+oaz4+lYJNBKk90
         hVcWrXP9qH0ultvKGGRviYuRiMZPm05IVYoiBlF6Squ4SBSfa5MqEqU/pptHLXX0d9y4
         vFD5pJkNDftUHQ/SxAC3mlN6xmemeJSSET133w+9aPmBypY9NefrHOBgyHSMiyihpmHo
         H5SaPppboSm/XyktlBt4vL6Wf9ZngCZut/Gan1OnRVRn53Wh7gnb65QuFLkcJMF6JwL2
         K8N6KEFv/ZE+7aVVaPIYZ3j3lb7K3dpt4vQPAj8x9zDZg9KgFe5oL8dLGiPZjBUWPPl8
         ZawA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681717732; x=1684309732;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SoxNZpdn1HHFFTHQnEQSPesnrC0r0JBqOwFpAAsz2Tc=;
        b=V5042SuJKF354rZQLsUnKS4EWTcrmVIcuIsgQo5lZoyJvvCyBBU2cPaFrXatNUa7K3
         /HrRd/f14EGnzIihn6oGAFRFyXIOGM0UcATpFOX4yNHP6fJRyfS4nWsGe9Tzu+66EL6a
         iNIRDzo9nICeHuTN/R2jafmiS559ycTjl9bMI3JwqW9eb/ziChR4l/snIZnFH+dFvHkn
         mIM0fb8IfJjM5+6auN9kpHlUIfMVJhNlyx7jkk7KyEjhEGKCeE0GTD8GF3GwtTTJjBIj
         QcmyuPtdbv2lODTSPtod+u3uU2hZc+zBMy4etPAsbqM2YtIcFKjt3KPH+9G57nfBQD/v
         +mXw==
X-Gm-Message-State: AAQBX9dxVtyDY0GfLgpD4L4BH4Gt9KNk2l7oN221yVT/GhwBXEOtDflZ
        w9H7T+dSOcB+VP050oJEgRagoo12N/WgzIStIzo=
X-Google-Smtp-Source: AKy350bO4Q0M4kNPGuZKaddfaYMY0bADMV/2ahTSkkcQKdYQeoBzU5SUux9JweQmWyx05g9THNRdxA==
X-Received: by 2002:a17:902:f549:b0:1a6:84be:a08f with SMTP id h9-20020a170902f54900b001a684bea08fmr12862881plf.64.1681717732560;
        Mon, 17 Apr 2023 00:48:52 -0700 (PDT)
Received: from smtpclient.apple ([47.243.123.68])
        by smtp.gmail.com with ESMTPSA id e9-20020a170902744900b001a641ea111fsm7002425plt.112.2023.04.17.00.48.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Apr 2023 00:48:52 -0700 (PDT)
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
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
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


