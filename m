Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AD6C69A7E7
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 10:13:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230026AbjBQJNK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 04:13:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjBQJNI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 04:13:08 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCD785D3D9;
        Fri, 17 Feb 2023 01:13:07 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id q14-20020a17090a430e00b00233d7314c1cso636784pjg.5;
        Fri, 17 Feb 2023 01:13:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qRi4qv/JnEMGemRZsZtBO6rNmWmI/s0rWmsETpJ/eLA=;
        b=IChadKiG/gbD6T3s+PAGqLnDPiZ0XoAklQvs0isOnXteLhc3LOHg1yaN1X5j1VxVho
         hSDVrfvGpY5LyrKiGUa+bX4ZLZxiK9KF88nE1oScOvD7f0BnmQLSAgzBg0cVJOsmV0eW
         jGlMVQAeZyXPS4lNmojVjLYwcOcC1vXu3Tr9qPgoSg+h3d44M5i5+FJ5lqS2Xb55DQ/L
         Ykdw38gUiu9ySW4X2XiEd95dgprycZ3gGjyVorWaQgj5ugB19YhAoomFpq9dwmRkUlxU
         HvgL42s8NZwVOZHw6d2QaGcHMyiY2H8sbxgCkjKDKdQGEnd7MNeMqz3/HTqumF/z301m
         Otqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qRi4qv/JnEMGemRZsZtBO6rNmWmI/s0rWmsETpJ/eLA=;
        b=fH82Byganeaz1RMVcXL/9r75k8tF8VVJ4ggWJu+cwfvwNWKfVaJ8K9QfiBwWHvblfW
         RN5j+ZsWNp9mNV8Bmde8mmFWD2/9na7t3MMqGovxnfQ1FDHVf1Mg/5T+hQvj1SlQxboN
         PT2K9GpDFqDrNJ0r6HNv+boiX1U8A+qRWBCALGawHL20aPuKKstuwbUXy4IOENcQsPVc
         BzVyXTY3CV848PMAlJ6o4E2mqok0xaBv3xBCK9I7NK3UcZ71W+k/OjK86SctFQGqs1tA
         b29sHaFQiyY0+Pjh2WFnR3JrMNAysJWxnLdPkupMnKo/Nf7agMfqe/70OJxVmoqGnPaG
         /yYQ==
X-Gm-Message-State: AO0yUKVU1OnIJZlTSTjqhnpM7yFDAO+9dX/yV6DHg6KmVR7e38ZZOX0+
        uUqHneMbt1Q+4lx0RPY4ratK1aBu/PYt/8vg9rQ=
X-Google-Smtp-Source: AK7set/xyw+LBFsaAEeg68CEWu0qdnXmvLHaC4GTEtJkNexEctcug/wbNW/HflvR+mHK+4Si3hCvzg8AJoADRJ5PpQk=
X-Received: by 2002:a17:902:d384:b0:198:f92d:9a2c with SMTP id
 e4-20020a170902d38400b00198f92d9a2cmr109313pld.2.1676625187206; Fri, 17 Feb
 2023 01:13:07 -0800 (PST)
MIME-Version: 1.0
References: <20230202064124.22277-1-zyytlz.wz@163.com> <20230213070906-mutt-send-email-mst@kernel.org>
 <Y+u51GN1uf3i0A4+@fedora>
In-Reply-To: <Y+u51GN1uf3i0A4+@fedora>
From:   Zheng Hacker <hackerzheng666@gmail.com>
Date:   Fri, 17 Feb 2023 17:12:55 +0800
Message-ID: <CAJedcCyNbG85=zwGaTFBO0q8x1bKNBsNueVBfoMRpeqRJp500g@mail.gmail.com>
Subject: Re: [PATCH v2] scsi: virtio_scsi: Fix poential NULL pointer
 dereference in virtscsi_rescan_hotunplug
To:     Stefan Hajnoczi <stefanha@redhat.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Zheng Wang <zyytlz.wz@163.com>, jasowang@redhat.com,
        pbonzini@redhat.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com,
        virtualization@lists.linux-foundation.org,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        security@kernel.org, alex000young@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Get it ^^

Thanks,
Zheng

Stefan Hajnoczi <stefanha@redhat.com> =E4=BA=8E2023=E5=B9=B42=E6=9C=8815=E6=
=97=A5=E5=91=A8=E4=B8=89 00:42=E5=86=99=E9=81=93=EF=BC=9A
>
> On Mon, Feb 13, 2023 at 07:09:50AM -0500, Michael S. Tsirkin wrote:
> > On Thu, Feb 02, 2023 at 02:41:24PM +0800, Zheng Wang wrote:
> > > There is no check about the return value of kmalloc in
> > > virtscsi_rescan_hotunplug. Add the check to avoid use
> > > of null pointer 'inq_result' in case of the failure
> > > of kmalloc.
> > >
> > > Signed-off-by: Zheng Wang <zyytlz.wz@163.com>
> > > ---
> >
> > I fixed a typo in subject and tweaked the patch a bit
>
> Thanks for picking this patch up.
> https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git/commit/?h=
=3Dlinux-next&id=3D4a8fc6e3ac68ce4c355d1f4473ef1d8468b23bdc
>
> Stefan
