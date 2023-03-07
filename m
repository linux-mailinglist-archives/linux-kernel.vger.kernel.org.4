Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEAD66AD331
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 01:12:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229792AbjCGAMO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 19:12:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjCGAMM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 19:12:12 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCC684ECF6
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 16:11:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678147884;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fOzDuJrDxV1m0d9OGwSp4ESW3MVpzmUb4ORlvJ2wcQA=;
        b=R6Lsgb1VKZXBvJ+L/QoRN99vlz4vYdocNY3aj0xLhuuIAuma1Cticm/+9mVCQB/QohIBCj
        ZFzsmbn/D82p+C2UM/pqf2LNsGhuFSwKII1u3HXfDikfY3YTuxpFnrZUVYxe2EsHKZxs2s
        UZ+M1Gd57rELeLu43TlUrdn3Sqt1ue8=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-33-qhGUmoYtOHq6pctGFHWjOw-1; Mon, 06 Mar 2023 19:11:21 -0500
X-MC-Unique: qhGUmoYtOHq6pctGFHWjOw-1
Received: by mail-qt1-f197.google.com with SMTP id ga17-20020a05622a591100b003bfdf586476so6246522qtb.7
        for <linux-kernel@vger.kernel.org>; Mon, 06 Mar 2023 16:11:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678147881;
        h=mime-version:user-agent:content-transfer-encoding:organization
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fOzDuJrDxV1m0d9OGwSp4ESW3MVpzmUb4ORlvJ2wcQA=;
        b=rvLmHwnuHhTD3IMVRRtqWeCvVNYLhPYSUEY3yVF5iZ+em1up10meQAjWc29YV9Eopd
         J+ao4gqugA+g0M2/1xDJlLE+cBx2svVxDMvvL1DMvauLR3+WN8HUXZn9HZz3MiFPlxPQ
         kr9MQXbUFMYdQz7TU2TIb0j7TDjMxiujscm/WlfEs/G3cSuv7Fj8/LmeFS4GgLcBeVLA
         NWjt8CIQAaUKwmeIzW712SHdSyfIVtk1cf+P2gIPMR6+oAqr1brTW+DDSStdPuIwGJnm
         rb94tnx/pEndYAuejIfseuar10Ma1JWdut/NWkZ1Fc7a8gik8lPVriV5D0le4upTe9eB
         /9MQ==
X-Gm-Message-State: AO0yUKV5a7+mta6h0RTPY4pZwyEthgiGY92WOmdYiE45ORm/dO7XxDTA
        rvQEwAPf0ABPpTABZTGVgjcYxDT+WCO5yj4FZ6ZVZlEA1bVrfBUgBxahy1zTQHXClNX/ZvCNIsx
        rE7VD9zjWpZefJTxJVMYlxTsA
X-Received: by 2002:ac8:5751:0:b0:3b9:bc8c:c1f8 with SMTP id 17-20020ac85751000000b003b9bc8cc1f8mr28359391qtx.3.1678147881102;
        Mon, 06 Mar 2023 16:11:21 -0800 (PST)
X-Google-Smtp-Source: AK7set8BM7AUsiRefOt1umMJ4Dth06Cpb8323Q/aybM3/LmMXC+QAMfwEyfV8FMCNIXFRNS5DobkXw==
X-Received: by 2002:ac8:5751:0:b0:3b9:bc8c:c1f8 with SMTP id 17-20020ac85751000000b003b9bc8cc1f8mr28359368qtx.3.1678147880861;
        Mon, 06 Mar 2023 16:11:20 -0800 (PST)
Received: from ?IPv6:2600:4040:5c68:6800::feb? ([2600:4040:5c68:6800::feb])
        by smtp.gmail.com with ESMTPSA id m190-20020a3758c7000000b006ff8a122a1asm8411153qkb.78.2023.03.06.16.11.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Mar 2023 16:11:20 -0800 (PST)
Message-ID: <5882bd80983ac04a32676f07622cba7d0e245e55.camel@redhat.com>
Subject: Re: [PATCH] drm/nouveau/mmu: fix use-after-free bug in
 nvkm_vmm_pfn_map
From:   Lyude Paul <lyude@redhat.com>
To:     Zheng Wang <zyytlz.wz@163.com>, nouveau@lists.freedesktop.org
Cc:     bskeggs@redhat.com, kherbst@redhat.com, airlied@gmail.com,
        hackerzheng666@gmail.com, alex000young@gmail.com,
        security@kernel.org, daniel@ffwll.ch, Julia.Lawall@inria.fr,
        linux-kernel@vger.kernel.org
Date:   Mon, 06 Mar 2023 19:11:18 -0500
In-Reply-To: <20221029074654.203153-1-zyytlz.wz@163.com>
References: <20221029074654.203153-1-zyytlz.wz@163.com>
Organization: Red Hat Inc.
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Actually - could you resend this with dri-devel@lists.freedesktop.org added=
 to
the cc list just to make patchwork happy?

On Sat, 2022-10-29 at 15:46 +0800, Zheng Wang wrote:
> If it failed in kzalloc, vma will be freed in nvkm_vmm_node_merge.
> The later use of vma will casue use after free.
>=20
> Reported-by: Zheng Wang <hackerzheng666@gmail.com>
> Reported-by: Zhuorao Yang <alex000young@gmail.com>
>=20
> Fix it by returning to upper caller as soon as error occurs.
>=20
> Signed-off-by: Zheng Wang <zyytlz.wz@163.com>
> ---
>  drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmm.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmm.c b/drivers/gpu/=
drm/nouveau/nvkm/subdev/mmu/vmm.c
> index ae793f400ba1..04befd28f80b 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmm.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmm.c
> @@ -1272,8 +1272,7 @@ nvkm_vmm_pfn_map(struct nvkm_vmm *vmm, u8 shift, u6=
4 addr, u64 size, u64 *pfn)
>  						       page -
>  						       vmm->func->page, map);
>  			if (WARN_ON(!tmp)) {
> -				ret =3D -ENOMEM;
> -				goto next;
> +				return -ENOMEM;
>  			}
> =20
>  			if ((tmp->mapped =3D map))

--=20
Cheers,
 Lyude Paul (she/her)
 Software Engineer at Red Hat

