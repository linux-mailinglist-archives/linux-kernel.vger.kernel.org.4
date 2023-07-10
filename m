Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45E0D74CA4B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 05:17:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbjGJDR1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jul 2023 23:17:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjGJDRZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jul 2023 23:17:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77A26EC
        for <linux-kernel@vger.kernel.org>; Sun,  9 Jul 2023 20:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688959006;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=a62DSLSpXeASP7dYpa5HsA33PutQ3KjJO6C/G/Q8iAk=;
        b=EtDC9taNDHxe3UhqS0Y14C9GRRrvbHW+ueIqProwcxJlRByuZtx+cnvnRc7Z+G7cq9wh87
        wU5+SGTKeEdB3+kJ+G22FYsTIEf30g1tID9cqbrtAlJhwKGWro5WCVQVlKI7XiccCJngZH
        P42ZiJogMaJfuwV5F7AvW0EP+f4sVCc=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-29-oALFH_XQNfKjMc1ul4UMUA-1; Sun, 09 Jul 2023 23:16:45 -0400
X-MC-Unique: oALFH_XQNfKjMc1ul4UMUA-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2b701e0bb10so33311791fa.3
        for <linux-kernel@vger.kernel.org>; Sun, 09 Jul 2023 20:16:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688959004; x=1691551004;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a62DSLSpXeASP7dYpa5HsA33PutQ3KjJO6C/G/Q8iAk=;
        b=PBKz+/J31retzRxRbTiDtlun1w5AW6dmKoZK+Yvge2KEhDRY2V9v/gMTN+ocnk/K02
         FghOOkTaXwbUZJZY6FQyIKo3jI9Kxz3/S+GwDM64t5iE265jqsJNgQO358rmusVBG/QB
         HA4R5hhtHsOhZJLIw6NWzu8go3+tA2X2fldYfbAySWpox3yl2i8BSu4KCYk6VwPJ98Q+
         LxR9houAtp5Tq28+4XUj6bzkHG6gi4JBXWpGbnUFv7scUaP2Po54McZdKpd0r2dvi5CR
         XUXW0LMP5PqtveB33T4ixUvQy1F2p3s8e4E3HJiVUp09ez3C2d8Z1pqbnA0n0OtOgd1I
         deKQ==
X-Gm-Message-State: ABy/qLY1DtJhd0v8ExzJvKWsj6CMaH0BS/J7sgcdm9A8eSlAvk/+eFo/
        nLN8qYH9okjZv/jPz9C+N2mIOiEUvuboNAcGObKuPcTLz7s8qPA6LkTShZ8Bqrto8E/rxMwnR1E
        ohQ/brDl9nO8HAjPui7oV+9RdoOZi6+h+wY5gznhF
X-Received: by 2002:a05:651c:1025:b0:2b6:a22f:9fb9 with SMTP id w5-20020a05651c102500b002b6a22f9fb9mr8375727ljm.27.1688959004008;
        Sun, 09 Jul 2023 20:16:44 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEnVegvrkpNt0TR6XRnujYIiNrsRYYJzxc37gJtNWKUE7a5YX0jPBMxs0gFC9cJdQNoUf+kMZdSTNMkLAa3IKo=
X-Received: by 2002:a05:651c:1025:b0:2b6:a22f:9fb9 with SMTP id
 w5-20020a05651c102500b002b6a22f9fb9mr8375700ljm.27.1688959002988; Sun, 09 Jul
 2023 20:16:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230706231718.54198-1-shannon.nelson@amd.com>
In-Reply-To: <20230706231718.54198-1-shannon.nelson@amd.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Mon, 10 Jul 2023 11:16:32 +0800
Message-ID: <CACGkMEuD9DgK7CEp0cW-he3FAbzDVsvnhvouLWAMv9bUrq+ATA@mail.gmail.com>
Subject: Re: [PATCH virtio] pds_vdpa: protect Makefile from unconfigured debugfs
To:     Shannon Nelson <shannon.nelson@amd.com>
Cc:     rdunlap@infradead.org, mst@redhat.com,
        virtualization@lists.linux-foundation.org, brett.creeley@amd.com,
        netdev@vger.kernel.org, drivers@pensando.io, sfr@canb.auug.org.au,
        linux-next@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 7, 2023 at 7:17=E2=80=AFAM Shannon Nelson <shannon.nelson@amd.c=
om> wrote:
>
> debugfs.h protects itself from an undefined DEBUG_FS, so it is
> not necessary to check it in the driver code or the Makefile.
> The driver code had been updated for this, but the Makefile had
> missed the update.
>
> Link: https://lore.kernel.org/linux-next/fec68c3c-8249-7af4-5390-0495386a=
76f9@infradead.org/
> Fixes: a16291b5bcbb ("pds_vdpa: Add new vDPA driver for AMD/Pensando DSC"=
)
> Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

> ---
>  drivers/vdpa/pds/Makefile | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/vdpa/pds/Makefile b/drivers/vdpa/pds/Makefile
> index 2e22418e3ab3..c2d314d4614d 100644
> --- a/drivers/vdpa/pds/Makefile
> +++ b/drivers/vdpa/pds/Makefile
> @@ -5,6 +5,5 @@ obj-$(CONFIG_PDS_VDPA) :=3D pds_vdpa.o
>
>  pds_vdpa-y :=3D aux_drv.o \
>               cmds.o \
> +             debugfs.o \
>               vdpa_dev.o
> -
> -pds_vdpa-$(CONFIG_DEBUG_FS) +=3D debugfs.o
> --
> 2.17.1
>

