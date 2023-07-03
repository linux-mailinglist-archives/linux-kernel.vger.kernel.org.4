Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6F2874583A
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 11:18:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230080AbjGCJSz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 05:18:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231165AbjGCJSs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 05:18:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E55EEE59
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 02:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688375848;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8HHzoJ5KB9PwbED6aCUVdjiUMf88jiN+uGVsp2SPg0Q=;
        b=YhE5YIJWqQoVibT2E5sLiY/bJUD20zm5gC9Y7Ub2+bWowLeFfkCak/+SZy3boG/fxgLQYI
        riSYSzJPUMkt0Z2RdIOrrgh7kc1rpgm9Cd0fzo8HFUCnDYJp2YgVUGKLCGGtqWLfEV18Ca
        fyne6u5mcbWLtDIxDBZ6wOOII+ZpV6o=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-591-uVTD_1aKMI6GYzMOrsU7ZA-1; Mon, 03 Jul 2023 05:17:26 -0400
X-MC-Unique: uVTD_1aKMI6GYzMOrsU7ZA-1
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-1b7f0264306so39262795ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jul 2023 02:17:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688375845; x=1690967845;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8HHzoJ5KB9PwbED6aCUVdjiUMf88jiN+uGVsp2SPg0Q=;
        b=S6iUG1ZKVQgVzUyW1NG/WOeDJqfKmz+7T1bKvlQwOtR6CaTybhj91xqD+GcOpDWU/t
         +ZgG9avEJ0E8twcIMYHaxg148ZD8ZHnf6anxT10Q/IXMGxr6Cy/2Z8/Q4dHHLgpGcwty
         gle0A86EwjFvuEQxBuANfn04XPiYYSEBzdyvWZewf2NrnozOhTvimmD27D1iIgL+9zuV
         K9EK9qA9YDaYsmLfFL/2ilK7jbwg3f8IWkZ74KOpeuxjAk5XB6evJ0oOxTyIVfPuduQX
         nCKc4i+VBuotk24vCnP1vLY7m90vWNEQbSSaaW0oPwuU5RoVtGYYctq+sqCoWas8uPFW
         9pIA==
X-Gm-Message-State: ABy/qLZ5oWPUu3ue+DWNHL5tjG/K/nD5EojY9EHFqNs0cBI90A+GsBTg
        lEILG7ZuUu4DJWlR/1JED3swZfD0jLis5NFQN0YOOr3bN/GZlH7j7mKm6v9KhCkDUurCoQLjIG7
        JPx8nDQZR9E7oqDFd/0BRQ14TNBoiaAIBp5sT5F3u
X-Received: by 2002:a17:903:22ce:b0:1b8:9b90:e2bc with SMTP id y14-20020a17090322ce00b001b89b90e2bcmr914059plg.52.1688375845568;
        Mon, 03 Jul 2023 02:17:25 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFvcAIY9KsHTFSp2HQjjW2SLm2ABVtM2SXsV/67vEEWu50uv1ZaslAjF6b7RfDyYT6a4Pk8632wNdrsXX5WZ/w=
X-Received: by 2002:a17:903:22ce:b0:1b8:9b90:e2bc with SMTP id
 y14-20020a17090322ce00b001b89b90e2bcmr914045plg.52.1688375845264; Mon, 03 Jul
 2023 02:17:25 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1688073459.git.drv@mailo.com>
In-Reply-To: <cover.1688073459.git.drv@mailo.com>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Mon, 3 Jul 2023 11:17:13 +0200
Message-ID: <CAHc6FU5WZafgAutKpVRC1jPMNpGCh+M_i+tmCZw0dGCBUXe1ug@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] gfs2: kmap{_atomic} conversion to kmap_local_{page/folio}
To:     Deepak R Varma <drv@mailo.com>
Cc:     Bob Peterson <rpeterso@redhat.com>, cluster-devel@redhat.com,
        linux-kernel@vger.kernel.org, Ira Weiny <ira.weiny@intel.com>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Sumitra Sharma <sumitraartsy@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Deepak,

On Thu, Jun 29, 2023 at 11:48=E2=80=AFPM Deepak R Varma <drv@mailo.com> wro=
te:
> This patch series proposes to replace the kmap/kmap_atomic implementation=
 to the
> preferred kmap_local_* APIs.
>
> The code blocks for this module where kmap/kmap_atomic calls are implemen=
ted do
> not appear to depend on disabling page-faults or preemption. Hence such c=
ode
> blocks are safe for converting to improved kmap_local_{page,folio} APIs.
>
> Note: The proposed patches are build tested only.
>
> Initially, only a single patch was sent and now being converted into a pa=
tch
> series including the other files/functions of this module. Hence all patc=
hes,
> that are included for the first time in this series are also marked as v3=
.
>
> Changes in v3:
>    - Patch set introduced to include all gfs2 kmap conversions
>    - Patches 3/6 through 6/6 are included to build the series
>    - Initial stand-alone patch split into 2 patches [1/6 and 2/6]

I have already merged version 2 of this patch series and I've fixed up
the remaining issues in follow-up patches; see the cluster-devel
mailing list:

https://listman.redhat.com/archives/cluster-devel/2023-June/024391.html
https://listman.redhat.com/archives/cluster-devel/2023-June/024392.html
https://listman.redhat.com/archives/cluster-devel/2023-June/024393.html

As well as our for-next branch:

https://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git/log/?h=
=3Dfor-next

As far as I can see, there is nothing in v3 of your patches that I
haven't addressed already. Please speak out if I've missed anything.

Thanks,
Andreas


>
> Changes in v2:
>    - 3/6 to 6/6: None.
>    - 1/6 + 2/6: Correct patch description for the replacement function na=
me from
>      kmap_local_folio to kmap_local_page
>
> Deepak R Varma (6):
>   gfs2: Replace kmap_atomic() by kmap_local_page() in stuffed_readpage
>   gfs2: Replace kmap_atomic()+memcpy by memcpy_from_page()
>   gfs2: Replace kmap() by kmap_local_page() in gfs2_unstuffer_page
>   gfs2: Replace kmap_atomic() by kmap_local_page() in lops.c
>   gfs2: Replace kmap() by kmap_local_page() in gfs2_read_super
>   gfs2: Replace kmap_atomic() by kmap_local_page() in
>     gfs2_write_buf_to_page
>
>  fs/gfs2/aops.c       | 13 ++++++-------
>  fs/gfs2/bmap.c       |  4 ++--
>  fs/gfs2/lops.c       | 12 ++++++------
>  fs/gfs2/ops_fstype.c |  4 ++--
>  fs/gfs2/quota.c      |  4 ++--
>  5 files changed, 18 insertions(+), 19 deletions(-)
>
> --
> 2.34.1
>
>
>

