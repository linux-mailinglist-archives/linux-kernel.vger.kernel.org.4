Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45BE56AF9F9
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 00:01:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230300AbjCGXBD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 18:01:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230052AbjCGXAk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 18:00:40 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6303996C3D
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 14:57:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678229835;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Y2LyFwXcQIcYGF8iAkhqDIIxOMMkwRfJpuYXazPS08Y=;
        b=imzZsUhOVmJP4h3ALRt9rO3KtXTPFX4w7D/pDQB6AUgIaHj8x77Dt67dLcUf+M+faEQePn
        +bz7Fw7riiWpztRkc6rRPPgKId4DUGlcIjbdBYbeQbPThpIgobD0lF19OYtTHRiaEQNzRE
        6UbktWCtx0D2DQsNPPu9LXEIWroRRts=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-209-1c3Maf1pOxSC79g_rPxf1w-1; Tue, 07 Mar 2023 17:50:55 -0500
X-MC-Unique: 1c3Maf1pOxSC79g_rPxf1w-1
Received: by mail-qk1-f198.google.com with SMTP id x14-20020ae9e90e000000b007429af46d5eso8254793qkf.12
        for <linux-kernel@vger.kernel.org>; Tue, 07 Mar 2023 14:50:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678229432;
        h=mime-version:user-agent:content-transfer-encoding:organization
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y2LyFwXcQIcYGF8iAkhqDIIxOMMkwRfJpuYXazPS08Y=;
        b=AxbLuXmqt6F49Yk1kf2OZYxqvL/CkcCcCZ7W0pb2tAI84CAdkgWG49BXAX9fW2mG27
         qp9z+4oIorRUNc4+0AXzicce4z+0iLKqhe1iE6GJrx7MHpmvxcy3hfLOlzwK46+p21O3
         9tqis+9M7mRemHlk1iAINbQwZasEfWasIWyti3EfnZXw/8ZaCm7SUTlWOzPqyEDq7oGP
         jWL0BX4nlrLoWEiYFSAbuPtPUS8h3Gnl/GlIU5lfsbKaP0FXP6Xb+3WuVV9oDXKiLcqg
         k+eZwcdfTuvrO+V4o/Adpj7ZlPWrFGZx3fUvUfn4p4vlkfIa2jvGwJmbKGr6WSJtmPVd
         Tolw==
X-Gm-Message-State: AO0yUKXfWkWAnQtTS2byRpWBI4WMk6bM+QENMIe6qZE6CIrlSJ/HEgs6
        Y5dRP8Q+G46m8z6WlLd5h/C2mkYJK7FqSVX3J5HzPM7cHEu+vxKiNLhaV28/o43Roz4OIEbZDO/
        JP4KC0SXBRT1SiIkxVe4/whHByAQRPkCW
X-Received: by 2002:ac8:5f83:0:b0:3bf:d07e:edf6 with SMTP id j3-20020ac85f83000000b003bfd07eedf6mr29489381qta.36.1678229432662;
        Tue, 07 Mar 2023 14:50:32 -0800 (PST)
X-Google-Smtp-Source: AK7set+fAl+u8fQ2G5Wb7L0bClfPehMChq1xc2zVWkDzlMZ5FpEupjFrdvUmM3UqA5658lgeZF5ZsQ==
X-Received: by 2002:ac8:5f83:0:b0:3bf:d07e:edf6 with SMTP id j3-20020ac85f83000000b003bfd07eedf6mr29489358qta.36.1678229432411;
        Tue, 07 Mar 2023 14:50:32 -0800 (PST)
Received: from ?IPv6:2600:4040:5c68:6800::feb? ([2600:4040:5c68:6800::feb])
        by smtp.gmail.com with ESMTPSA id r15-20020ac867cf000000b003bfc2fc3235sm10349179qtp.67.2023.03.07.14.50.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 14:50:31 -0800 (PST)
Message-ID: <ba3790cb9f3adcb4f7d3935ce9aa88ecacb3bf7d.camel@redhat.com>
Subject: Re: [PATCH 2/2] drm/nouveau/clk: avoid usage of list iterator after
 loop
From:   Lyude Paul <lyude@redhat.com>
To:     Jakob Koschel <jkl820.git@gmail.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Karol Herbst <kherbst@redhat.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Pietro Borrello <borrello@diag.uniroma1.it>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>
Date:   Tue, 07 Mar 2023 17:50:30 -0500
In-Reply-To: <20230301-drm-nouveau-avoid-iter-after-loop-v1-2-0702ec23f970@gmail.com>
References: <20230301-drm-nouveau-avoid-iter-after-loop-v1-0-0702ec23f970@gmail.com>
         <20230301-drm-nouveau-avoid-iter-after-loop-v1-2-0702ec23f970@gmail.com>
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

On Wed, 2023-03-01 at 18:25 +0100, Jakob Koschel wrote:
> +		}
> =C2=A0	}
> =C2=A0
> +	BUG_ON(!pstate);
> =C2=A0	nvkm_debug(subdev, "setting performance state %d\n", pstatei);
> =C2=A0	clk->pstate =3D pstatei;

We should probably also replace this with

	if (WARN_ON(!pstate)
		return -EINVAL;

--=20
Cheers,
 Lyude Paul (she/her)
 Software Engineer at Red Hat

