Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 500EC655C9E
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Dec 2022 09:33:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230244AbiLYId1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Dec 2022 03:33:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiLYIdY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Dec 2022 03:33:24 -0500
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com [IPv6:2607:f8b0:4864:20::c2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CB745FC3
        for <linux-kernel@vger.kernel.org>; Sun, 25 Dec 2022 00:33:23 -0800 (PST)
Received: by mail-oo1-xc2e.google.com with SMTP id d2-20020a4ab202000000b004ae3035538bso1409023ooo.12
        for <linux-kernel@vger.kernel.org>; Sun, 25 Dec 2022 00:33:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=W+48L8Ebv4aPP9Sakn0pKuKNsmP77TbDjxN1IU0ghN8=;
        b=C/KrYpL0yQVWEjfNR/+zh7hkyjCD67VfVkBqy1K8+RQKSfbhpUBLc1qOTnF0fCDGyX
         abvvTi4Ix3YCZHlLWgq3LiOzF+h0Jtp54tbGUKxFzIMPy/Mpzyd09v75l/qsGq59dvEP
         vZcgG8Ifqg0FTq8C+68pJIcdKu6utedNm/1HHAE+7dAImU3/8jOyGUz2zzzOU3yxHeGw
         IK0IUzxxXjHgH/x/hO0Dr1CepqxRhwo1OODAk+gO3kUB4ZRcnKyOhX2CD1WcT86Y+PTw
         Epqv/zocptsxO/54HcQBq6fKOw8yBahgM+C3M/0Kxcc0eVkTLtMKyM/ZJawcDJtSjg/6
         SihA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W+48L8Ebv4aPP9Sakn0pKuKNsmP77TbDjxN1IU0ghN8=;
        b=3KOs4wyhwH6QF+tv/V3LOolc5ssyheIbOLkkFtYFc/2ZXubcyzfeeseav/DOpfQcSp
         YiImmZ9Sl2laYUz3Qn9gsnP/MXC92tNfroFq3No2l2qiezxvAQg0GiUz416vEWzb79bS
         BjMfAGUdSRe59f0DqginJdWwMsiLE2hEvW7SKkvx5TCgVjnvw2uKttEdXYy9H4TrCXMy
         rA3JQ6O8EYLzvN1PVgXq03lPRplN2gcoqV1EYqbUkTAH3v0gIqPZriT0Vz+sphqL0kWJ
         bxwpf/TtGXJarlDPmIVE+iNFIv/bBvOZB5sNcIVRZCLpnk7RUTfA2CU7j2FN+Pjd5vEM
         0+Ew==
X-Gm-Message-State: AFqh2krPVNaJyns7C+g2hGGu6nEDBnnek3PYD3wPhbgXZr4+jh2UeRCR
        uMtFUiqTgIjO7dbgb7ZoevKTkw==
X-Google-Smtp-Source: AMrXdXvLMgnRzgpvkvKHbG2Qq8+wQ0bi6W7/3nrnjeyJTI28yHtg1Aezw0WEm0FwzzMz0ZLIptgr6Q==
X-Received: by 2002:a4a:df0e:0:b0:49f:dec4:10db with SMTP id i14-20020a4adf0e000000b0049fdec410dbmr7115498oou.0.1671957202776;
        Sun, 25 Dec 2022 00:33:22 -0800 (PST)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id m2-20020a4add02000000b004a3d98b2ccdsm3213620oou.42.2022.12.25.00.33.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Dec 2022 00:33:22 -0800 (PST)
Date:   Sun, 25 Dec 2022 00:33:13 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Christoph Hellwig <hch@infradead.org>
cc:     Keith Busch <kbusch@kernel.org>, Hugh Dickins <hughd@google.com>,
        Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: 6.2 nvme-pci: something wrong
In-Reply-To: <Y6ff4tpk1Su/Q9bP@infradead.org>
Message-ID: <6715d48b-7670-527-38ab-42f865fe3c10@google.com>
References: <572cfcc0-197a-9ead-9cb-3c5bf5e735@google.com> <Y6d37vGSCKvfJhzD@kbusch-mbp.dhcp.thefacebook.com> <Y6ff4tpk1Su/Q9bP@infradead.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="-1463760895-442772056-1671957202=:1683"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463760895-442772056-1671957202=:1683
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Sat, 24 Dec 2022, Christoph Hellwig wrote:
> On Sat, Dec 24, 2022 at 03:06:38PM -0700, Keith Busch wrote:
> > Your observation is a queue-wrap condition that makes it impossible for
> > the controller know there are new commands.
> >=20
> > Your patch does look like the correct thing to do. The "zero means one"
> > thing is a confusing distraction, I think. It makes more sense if you
> > consider sqsize as the maximum number of tags we can have outstanding a=
t
> > one time and it looks like all the drivers set it that way. We're
> > supposed to leave one slot empty for a full NVMe queue, so adding one
> > here to report the total number slots isn't right since that would allo=
w
> > us to fill all slots.
>=20
> Yes, and pcie did actually do the =E2=80=90 1 from q_depth, so we should
> drop the +1 for sqsize.  And add back the missing BLK_MQ_MAX_DEPTH.
> But we still need to keep sqsize updated as well.
>=20
> > Fabrics drivers have been using this method for a while, though, so
> > interesting they haven't had a simiar problem.
>=20
> Fabrics doesn't have a real queue and thus no actual wrap, so
> I don't think they will be hit as bad by this.
>=20
> So we'll probably need something like this, split into two patches.
> And then for 6.2 clean up the sqsize vs q_depth mess for real.

This patch is working fine for me; and, in the light of Keith's
explanation, so far as I can tell, seems the right thing to do.

Thanks!
Hugh

>=20
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 95c488ea91c303..5b723c65fbeab5 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -4926,7 +4926,7 @@ int nvme_alloc_io_tag_set(struct nvme_ctrl *ctrl, s=
truct blk_mq_tag_set *set,
> =20
>  =09memset(set, 0, sizeof(*set));
>  =09set->ops =3D ops;
> -=09set->queue_depth =3D ctrl->sqsize + 1;
> +=09set->queue_depth =3D min_t(unsigned, ctrl->sqsize, BLK_MQ_MAX_DEPTH -=
 1);
>  =09/*
>  =09 * Some Apple controllers requires tags to be unique across admin and
>  =09 * the (only) I/O queue, so reserve the first 32 tags of the I/O queu=
e.
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index f0f8027644bbf8..ec5e1c578a710b 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -2332,10 +2332,12 @@ static int nvme_setup_io_queues(struct nvme_dev *=
dev)
>  =09if (dev->cmb_use_sqes) {
>  =09=09result =3D nvme_cmb_qdepth(dev, nr_io_queues,
>  =09=09=09=09sizeof(struct nvme_command));
> -=09=09if (result > 0)
> +=09=09if (result > 0) {
>  =09=09=09dev->q_depth =3D result;
> -=09=09else
> +=09=09=09dev->ctrl.sqsize =3D dev->q_depth - 1;
> +=09=09} else {
>  =09=09=09dev->cmb_use_sqes =3D false;
> +=09=09}
>  =09}
> =20
>  =09do {
> @@ -2536,7 +2538,6 @@ static int nvme_pci_enable(struct nvme_dev *dev)
> =20
>  =09dev->q_depth =3D min_t(u32, NVME_CAP_MQES(dev->ctrl.cap) + 1,
>  =09=09=09=09io_queue_depth);
> -=09dev->ctrl.sqsize =3D dev->q_depth - 1; /* 0's based queue depth */
>  =09dev->db_stride =3D 1 << NVME_CAP_STRIDE(dev->ctrl.cap);
>  =09dev->dbs =3D dev->bar + 4096;
> =20
> @@ -2577,7 +2578,7 @@ static int nvme_pci_enable(struct nvme_dev *dev)
>  =09=09dev_warn(dev->ctrl.device, "IO queue depth clamped to %d\n",
>  =09=09=09 dev->q_depth);
>  =09}
> -
> +=09dev->ctrl.sqsize =3D dev->q_depth - 1; /* 0's based queue depth */
> =20
>  =09nvme_map_cmb(dev);
> =20
>=20
---1463760895-442772056-1671957202=:1683--
