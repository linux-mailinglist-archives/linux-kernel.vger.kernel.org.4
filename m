Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 623C0737554
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 21:49:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230433AbjFTTtU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 15:49:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230260AbjFTTtS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 15:49:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 962331712
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 12:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687290510;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7pbs/drRG44RLScvDGDXcKRWX9zC+yqJe8PG2S8eHDE=;
        b=fH7BvPeC3D2QGp6wXu25VT4zQYuK1IQMlKWczEgdDvSvGGYuaysu2ocp9YargFn+0jRQ/X
        8j8PV+gs/RlxbTuFrO6DiSGjZcX6mtqC/I08tXX1GKi2n209vGdl47zYGhPnXG33mT4K1K
        jl9tIFItA17BcW1sHMM9g9uqh032LgU=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-106-6c8wCamnP-aC3OeovymPPw-1; Tue, 20 Jun 2023 15:48:29 -0400
X-MC-Unique: 6c8wCamnP-aC3OeovymPPw-1
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-3ff2e6f220fso12980371cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 12:48:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687290507; x=1689882507;
        h=mime-version:user-agent:content-transfer-encoding:organization
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7pbs/drRG44RLScvDGDXcKRWX9zC+yqJe8PG2S8eHDE=;
        b=AKdTAZ/LabhHYyKbDTPv9JxTV1q+rOA1cHhOuuVsvRhE1lmH5TpQCqURGgFKA9ZTwu
         EXW8KdZ7kXTRQy1TKk8NQ2ySRQKasqMut86XkzUS2xvD5DSDrXmL7C5HbPNJwIqqmvJA
         Fj2aUszX+eby6XePvGRxZDHjojcirE/dxrg6Wl77NS/8vQmNzRv+B7QImAJnUKK6LfTk
         /L60KzwDFR3aJexkZ980J5NF0C9Pvc2APC9utIqb78dFOpq8mtzE/kcgcLqIOVegnVdd
         W6Y/KtqyXtCxyr372XMkju3qusWmiwfvRuy8xOL9rMjG02usYyZQKSV5U+x9DHSw+AZd
         dS+g==
X-Gm-Message-State: AC+VfDxYoaafXzTRmL0kvj1rfhRH1zKpanENQRvz5MPXyt6hZ78+g1rH
        UEXDq1IJe0s72/ZIFCJ47ZZqypvOZeigxGv7ua3WUy3XTGqDTTxriqBMbGQ1Ncx46cVQ0SuNsCf
        JxQ3VfBf8+zCVErd5LU3PZ48KmG8PLyHQ
X-Received: by 2002:a05:622a:20d:b0:3f1:f14f:9fd2 with SMTP id b13-20020a05622a020d00b003f1f14f9fd2mr18898891qtx.48.1687290506991;
        Tue, 20 Jun 2023 12:48:26 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4jeBZTU0kuiEsqkwtXQwJW6Ls0KhS80FffxQr7jYvYxqdSCiAQi086/7Hz51hwkvfeeU6I9A==
X-Received: by 2002:a05:622a:20d:b0:3f1:f14f:9fd2 with SMTP id b13-20020a05622a020d00b003f1f14f9fd2mr18898879qtx.48.1687290506768;
        Tue, 20 Jun 2023 12:48:26 -0700 (PDT)
Received: from ?IPv6:2600:4040:5c62:8200::feb? ([2600:4040:5c62:8200::feb])
        by smtp.gmail.com with ESMTPSA id ew4-20020a05622a514400b003fddfbc6e06sm1445151qtb.96.2023.06.20.12.48.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 12:48:26 -0700 (PDT)
Message-ID: <b441d8e53c9b5e95da447b3681bb9143448388fc.camel@redhat.com>
Subject: Re: [PATCH] drm/display/dp_mst: Fix missing check for return value
 of drm_atomic_get_mst_payload_state()
From:   Lyude Paul <lyude@redhat.com>
To:     Chenyuan Mi <cymi20@fudan.edu.cn>, airlied@gmail.com
Cc:     daniel@ffwll.ch, jani.nikula@intel.com, Wayne.Lin@amd.com,
        imre.deak@intel.com, alexander.deucher@amd.com,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Date:   Tue, 20 Jun 2023 15:48:25 -0400
In-Reply-To: <20230614160911.121716-1-cymi20@fudan.edu.cn>
References: <20230614160911.121716-1-cymi20@fudan.edu.cn>
Organization: Red Hat Inc.
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.3 (3.48.3-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hm, I suppose it's not -impossible- for this to return NULL, but if it does
return NULL that absolutely means something broke well before this point in
the code. More comments below:

On Wed, 2023-06-14 at 09:09 -0700, Chenyuan Mi wrote:
> The drm_atomic_get_mst_payload_state() function may
> return NULL, which may cause null pointer deference,
> and most other callsites of drm_atomic_get_mst_payload_state()
> do Null check. Add Null check for return value of
> drm_atomic_get_mst_payload_state().
>=20
> Found by our static analysis tool.
>=20
> Signed-off-by: Chenyuan Mi <cymi20@fudan.edu.cn>
> ---
>  drivers/gpu/drm/display/drm_dp_mst_topology.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/display/drm_dp_mst_topology.c b/drivers/gpu/=
drm/display/drm_dp_mst_topology.c
> index 38dab76ae69e..27f4bcf409ea 100644
> --- a/drivers/gpu/drm/display/drm_dp_mst_topology.c
> +++ b/drivers/gpu/drm/display/drm_dp_mst_topology.c
> @@ -4434,6 +4434,8 @@ void drm_dp_mst_atomic_wait_for_dependencies(struct=
 drm_atomic_state *state)
> =20
>  			new_payload =3D drm_atomic_get_mst_payload_state(new_mst_state,
>  								       old_payload->port);
> +			if (!new_payload)
> +				continue;

Could you change this check to:

	if (drm_WARN_ON(state->dev, !new_payload))

>  			new_payload->vc_start_slot =3D old_payload->vc_start_slot;
>  		}
>  	}

--=20
Cheers,
 Lyude Paul (she/her)
 Software Engineer at Red Hat

