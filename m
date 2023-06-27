Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DFED73FD1A
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 15:46:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229513AbjF0Nq2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 09:46:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230479AbjF0Nq0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 09:46:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E284C2115
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 06:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687873536;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ke8XtFgDnQ3FKSI0uaIkAHLijeswZt+d/C720oEmj8g=;
        b=YsuE1nPoIDEAMvK+/zuLYxdOk+c++7H61lsYy6wRPMFMVYN6TOMDYqZG60N94yy5WEUhzf
        fFG0oQfPdjE1i5hY3dxyx/gHFu30H6byecdf3ydgQ0xPxeaDxtUR5/ljUwqYWaOD0Cf8mH
        I9pz/Lgj7wY5wrE4Uyb0q4Kq6Vnnl1c=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-155-2H2lRl8zMAG6hi1PdoXlIQ-1; Tue, 27 Jun 2023 09:45:34 -0400
X-MC-Unique: 2H2lRl8zMAG6hi1PdoXlIQ-1
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-1b8303cd306so300675ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 06:45:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687873533; x=1690465533;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ke8XtFgDnQ3FKSI0uaIkAHLijeswZt+d/C720oEmj8g=;
        b=R1AmgRdsd52jzJtzbecvj8w2pshiqeWN9Z30db3L9BJ16DPiLKiHlaqb02BXZjZ4qi
         PYWC5Vc4KFR6KsroXkyM10SGc9xikhjTtjZo5Z266/plq3erVEVzUGasFg4SSryKxof9
         IKUYEjBHHkdKgi3ss0xRgzV77dOtysBcPvtcOXLEQu9tyi0lySWRRvx9d0Inab1lfUA3
         VSykjpJZ3aHaqVgP50uGMkZ/YAVyZCW7TkaoGVB9w5/PMWrzUQlon3gazbmlF++BtFef
         bFEsdZfkP+jau/YhFiBr1frlEmj0rkdAxva5kA2baYiq59A9tVPYCazTkcC5kyGqOLr+
         M5uQ==
X-Gm-Message-State: AC+VfDybEHdmJ5ChA6qZ8iMQSO579Q2dPU5SYWGe0922wWZcx4h6ToRX
        +7l1t32AW1OIIdY3y4t/cSJ23TFL7lxrVsVr4Ihoes36J4+MpNz14ZAGpGZEouNA9xjAC0QRYTI
        v/HwIHAQmRNHSARMYWA7O1uoSk8dqX7EdA9V2paCZbwNBoi42
X-Received: by 2002:a17:902:b193:b0:1b5:1654:96d4 with SMTP id s19-20020a170902b19300b001b5165496d4mr7092072plr.4.1687873533134;
        Tue, 27 Jun 2023 06:45:33 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6IthMHxZNbH8GTaGgIOza/GtvEVEKrKV37oXPkunKMrBHpu386zDko3S+M9ZBeuKxpniGopjQCoXrgnCg6hFs=
X-Received: by 2002:a17:902:b193:b0:1b5:1654:96d4 with SMTP id
 s19-20020a170902b19300b001b5165496d4mr7092055plr.4.1687873532820; Tue, 27 Jun
 2023 06:45:32 -0700 (PDT)
MIME-Version: 1.0
References: <ZJk1XTtgLFxIcxzp@bu2204.myguest.virtualbox.org>
In-Reply-To: <ZJk1XTtgLFxIcxzp@bu2204.myguest.virtualbox.org>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Tue, 27 Jun 2023 15:45:20 +0200
Message-ID: <CAHc6FU6P-BK=rU2w6JcswJsf93TwgvtUNNBe8LU4n2djuNjn_Q@mail.gmail.com>
Subject: Re: [PATCH v2] gfs2: Replace deprecated kmap_atomic() by kmap_local_page()
To:     Deepak R Varma <drv@mailo.com>
Cc:     Bob Peterson <rpeterso@redhat.com>, cluster-devel@redhat.com,
        linux-kernel@vger.kernel.org, Ira Weiny <ira.weiny@intel.com>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Sumitra Sharma <sumitraartsy@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 26, 2023 at 8:51=E2=80=AFAM Deepak R Varma <drv@mailo.com> wrot=
e:
> kmap_atomic() is deprecated in favor of kmap_local_{folio,page}().

I'll apply this, convert the remaining instances of kmap_atomic(), and
switch to memcpy_{from,to}_page() where appropriate.

Thanks,
Andreas

> Therefore, replace kmap_atomic() with kmap_local_page() in
> gfs2_internal_read() and stuffed_readpage().
>
> kmap_atomic() disables page-faults and preemption (the latter only for
> !PREEMPT_RT kernels), However, the code within the mapping/un-mapping in
> gfs2_internal_read() and stuffed_readpage() does not depend on the
> above-mentioned side effects.
>
> Therefore, a mere replacement of the old API with the new one is all that
> is required (i.e., there is no need to explicitly add any calls to
> pagefault_disable() and/or preempt_disable()).
>
> Signed-off-by: Deepak R Varma <drv@mailo.com>
> ---
> Note: The Patch is build tested only. I will be happy to run recommended =
testing
> with some guidance if required.
>
> Changes in v2:
>    - Update patch description to correct the replacement function name fr=
om
>      kmap_local_folio to kmap_local _page
>
>
>  fs/gfs2/aops.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/fs/gfs2/aops.c b/fs/gfs2/aops.c
> index 3b41542d6697..7bd92054d353 100644
> --- a/fs/gfs2/aops.c
> +++ b/fs/gfs2/aops.c
> @@ -432,10 +432,10 @@ static int stuffed_readpage(struct gfs2_inode *ip, =
struct page *page)
>         if (error)
>                 return error;
>
> -       kaddr =3D kmap_atomic(page);
> +       kaddr =3D kmap_local_page(page);
>         memcpy(kaddr, dibh->b_data + sizeof(struct gfs2_dinode), dsize);
>         memset(kaddr + dsize, 0, PAGE_SIZE - dsize);
> -       kunmap_atomic(kaddr);
> +       kunmap_local(kaddr);
>         flush_dcache_page(page);
>         brelse(dibh);
>         SetPageUptodate(page);
> @@ -498,12 +498,12 @@ int gfs2_internal_read(struct gfs2_inode *ip, char =
*buf, loff_t *pos,
>                                 continue;
>                         return PTR_ERR(page);
>                 }
> -               p =3D kmap_atomic(page);
> +               p =3D kmap_local_page(page);
>                 amt =3D size - copied;
>                 if (offset + size > PAGE_SIZE)
>                         amt =3D PAGE_SIZE - offset;
>                 memcpy(buf + copied, p + offset, amt);
> -               kunmap_atomic(p);
> +               kunmap_local(p);
>                 put_page(page);
>                 copied +=3D amt;
>                 index++;
> --
> 2.34.1
>
>
>

