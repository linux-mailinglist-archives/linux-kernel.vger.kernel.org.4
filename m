Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BB826E82E7
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 22:55:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbjDSUz0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 16:55:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230086AbjDSUzY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 16:55:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 273A33C0D
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 13:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681937674;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NwC/+o9d6wvrtiLeiNvOscHp+/u8nRn/PrEmgvt3fZ8=;
        b=FL9cS9/pOw6Bh3LaF9o0I+aC2GfyhV23PEB8nuK7qyvpvM27dp+gO1GcvkfXsURDgJHEOA
        Y8C9q+JRLKbhi3hwOx5cQwxUVtvA2ZcZeKWEKo8wfdMuky0RfLu2x7F3TknvTeHv8sMnCm
        SGfLAaw0ARGQpCtD4Q0M9Kq2SkWJC78=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-20-TbPmwvlaO7mf8UYL0sJp5Q-1; Wed, 19 Apr 2023 16:54:33 -0400
X-MC-Unique: TbPmwvlaO7mf8UYL0sJp5Q-1
Received: by mail-qk1-f197.google.com with SMTP id o6-20020a374106000000b007467b5765d2so700273qka.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 13:54:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681937672; x=1684529672;
        h=mime-version:user-agent:content-transfer-encoding:organization
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NwC/+o9d6wvrtiLeiNvOscHp+/u8nRn/PrEmgvt3fZ8=;
        b=eGaiGZFEo7C/fGMJ3Ypc+aEJMJuAXIS2cpHUhJ5TVl9eYODk8kuLo3TaXAg/buVOBF
         TwNDPTCR1SZhl8enBI62eOa6TvOYe8OOyoSYaF41Uwox6cKF3L92daTkEODS6hs8nxZN
         cMUmsjz8o45dt2phMkijAj/JWqp3fFXYCUnthwIr+Jms9W11poFz3vPeIdWkM3kQdBya
         Jr3zQleU0gWwcaJzlUrr4ftKXhMCDDPQOlCP/X3uXyiNui/iGUoP54S7aY4taNcEPNYN
         gapOU9baFBsjtl2ZT2OBbdo0zLgKjDfI5POBOnL1/9uet6lzWKv/iBq2pXfIWnQIpSK3
         xYBw==
X-Gm-Message-State: AAQBX9cYEQZYYvXYexcAH8OjWBCGTsKqcU8bTmLeQfBa+zUbDaV4Rfvm
        BtOA644ek+lmCbgM+bd2AvznMLoQgmnlWwvsj3kwv3txUo+30c12C6cZ3aWNBbJyWPlP2GToX+S
        Umv7OLgNwhJrGD+jg3NETDug9
X-Received: by 2002:ac8:5910:0:b0:3ee:c749:ef6a with SMTP id 16-20020ac85910000000b003eec749ef6amr8266982qty.7.1681937672554;
        Wed, 19 Apr 2023 13:54:32 -0700 (PDT)
X-Google-Smtp-Source: AKy350b3829jv2r254VCx6kpqm7ULHjkMhhvujywKwLYY5dhb3sKHN4WPrlOjqpEmuMgq3oHObuJiA==
X-Received: by 2002:ac8:5910:0:b0:3ee:c749:ef6a with SMTP id 16-20020ac85910000000b003eec749ef6amr8266967qty.7.1681937672329;
        Wed, 19 Apr 2023 13:54:32 -0700 (PDT)
Received: from ?IPv6:2600:4040:5c62:8200::feb? ([2600:4040:5c62:8200::feb])
        by smtp.gmail.com with ESMTPSA id b34-20020a05620a272200b007435a646354sm4932800qkp.0.2023.04.19.13.54.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 13:54:31 -0700 (PDT)
Message-ID: <d0b9654c756069a6f0edcca6f4d410f7af592784.camel@redhat.com>
Subject: Re: [PATCH v2] drm: use mgr->dev in drm_dbg_kms in
 drm_dp_add_payload_part2
From:   Lyude Paul <lyude@redhat.com>
To:     Jeff Layton <jlayton@kernel.org>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Wayne.Lin@amd.com, alexdeucher@gmail.com,
        Jani Nikula <jani.nikula@linux.intel.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Date:   Wed, 19 Apr 2023 16:54:31 -0400
In-Reply-To: <20230419112447.18471-1-jlayton@kernel.org>
References: <20230419112447.18471-1-jlayton@kernel.org>
Organization: Red Hat Inc.
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Lyude Paul <lyude@redhat.com>

Thanks!

On Wed, 2023-04-19 at 07:24 -0400, Jeff Layton wrote:
> I've been experiencing some intermittent crashes down in the display
> driver code. The symptoms are ususally a line like this in dmesg:
>=20
>     amdgpu 0000:30:00.0: [drm] Failed to create MST payload for port 0000=
00006d3a3885: -5
>=20
> ...followed by an Oops due to a NULL pointer dereference.
>=20
> Switch to using mgr->dev instead of state->dev since "state" can be
> NULL in some cases.
>=20
> Link: https://bugzilla.redhat.com/show_bug.cgi?id=3D2184855
> Suggested-by: Jani Nikula <jani.nikula@linux.intel.com>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  drivers/gpu/drm/display/drm_dp_mst_topology.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> I've been running this patch for a couple of days, but the problem
> hasn't occurred again as of yet. It seems sane though as long as we can
> assume that mgr->dev will be valid even when "state" is a NULL pointer.
>=20
> diff --git a/drivers/gpu/drm/display/drm_dp_mst_topology.c b/drivers/gpu/=
drm/display/drm_dp_mst_topology.c
> index 38dab76ae69e..e2e21ce79510 100644
> --- a/drivers/gpu/drm/display/drm_dp_mst_topology.c
> +++ b/drivers/gpu/drm/display/drm_dp_mst_topology.c
> @@ -3404,7 +3404,7 @@ int drm_dp_add_payload_part2(struct drm_dp_mst_topo=
logy_mgr *mgr,
> =20
>  	/* Skip failed payloads */
>  	if (payload->vc_start_slot =3D=3D -1) {
> -		drm_dbg_kms(state->dev, "Part 1 of payload creation for %s failed, ski=
pping part 2\n",
> +		drm_dbg_kms(mgr->dev, "Part 1 of payload creation for %s failed, skipp=
ing part 2\n",
>  			    payload->port->connector->name);
>  		return -EIO;
>  	}

--=20
Cheers,
 Lyude Paul (she/her)
 Software Engineer at Red Hat

