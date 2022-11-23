Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BAE5635BE7
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 12:37:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237324AbiKWLhF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 06:37:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236964AbiKWLgs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 06:36:48 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DFFF88FA1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 03:35:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669203354;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xVVWYg1ojQ5Ky304sIHU9yPUD5W1oOvyCKbrxX5jWnQ=;
        b=KW0+OnwNBZviUqBf5rsbDRlUeYWzGWnCZUENolxyuJmHtjcaf7xlerjuTEcpMcQWYTJtnv
        jbup1J0aJXDAZh73DQgsdeJs5/DqbwwNVo7MnazPzbxNYKV1KUM0HWvWTGlqBcMPxwnv17
        FbB2Uwpm4vRZSNYEYr9jeXLw/A37tJY=
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com
 [209.85.160.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-352-NTfa2qWXNhexPTM9EOMIDw-1; Wed, 23 Nov 2022 06:35:53 -0500
X-MC-Unique: NTfa2qWXNhexPTM9EOMIDw-1
Received: by mail-oa1-f69.google.com with SMTP id 586e51a60fabf-13c6efaa955so8406583fac.11
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 03:35:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xVVWYg1ojQ5Ky304sIHU9yPUD5W1oOvyCKbrxX5jWnQ=;
        b=OANSdq4RL8MMgK2WIW5C4SnwrG/MuLmqGah/MDKHbgR5uJetiOrTsRVhTIh81tGbjz
         jiJocNs1q1MDyu1Ep7ViGUkX+smRky4OXihkHpjLNSe2RBCpfEoYEjl6ygJpKCc5uEoO
         0j+Otx2KpLKT7Dxhatbcj0nQyj7dT0z9d6kGTCSCsK0bR2gzl9U+fRfqLTiw/20KuH0K
         CjkWJrN51OEfhY68MALvojR/XaX7Ya1RdGn10jR6dhyHOsY986dM8Vs0w6G3DDVdauXE
         e9slN+aEao6ixOtGkOb7rmi6M/gHEuhqLO3ohD6rgDIjt8pG03FeUozM77C9PPUfZbwt
         piGg==
X-Gm-Message-State: ANoB5pk8dT0Aib2hS2aVgXxS8SzPE0/WjiMOu0+2Yq39Fhumugw3KM3H
        iXslEWQzxJDCjyNY1bBZtwfxjsNlShjyVoVObSlfwM5HkhO4uix7HEraQfJPhmDpdyvg+4YC74j
        9sc4iHQ3qWSR0j5QsTCHs+iFFO1bb6GXaEM4wal4a
X-Received: by 2002:aca:6701:0:b0:35a:dea7:545a with SMTP id z1-20020aca6701000000b0035adea7545amr13424136oix.143.1669203352763;
        Wed, 23 Nov 2022 03:35:52 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7N5c1Zj+grZMihYOY1KQL4O5uK7NFPxX2CnrbNLix6CdSekUw9qsLiANstbHJpNSuudAEE4rlWAMEqx2sMUD0=
X-Received: by 2002:aca:6701:0:b0:35a:dea7:545a with SMTP id
 z1-20020aca6701000000b0035adea7545amr13424126oix.143.1669203352528; Wed, 23
 Nov 2022 03:35:52 -0800 (PST)
MIME-Version: 1.0
References: <20221117155502.1394700-1-eperezma@redhat.com>
In-Reply-To: <20221117155502.1394700-1-eperezma@redhat.com>
From:   Lei Yang <leiyang@redhat.com>
Date:   Wed, 23 Nov 2022 19:35:16 +0800
Message-ID: <CAPpAL=xabY1hAG+=A92fPpRLYJxmk_AKtS+-QonUvwg-LfTQaw@mail.gmail.com>
Subject: Re: [PATCH] vdpa_sim_net: Offer VIRTIO_NET_F_STATUS
To:     =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
Cc:     linux-kernel@vger.kernel.org, mst@redhat.com,
        virtualization@lists.linux-foundation.org,
        Jason Wang <jasowang@redhat.com>,
        Stefano Garzarella <sgarzare@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QE applied this path in the test environment, and did regression
testing with a vdpa simulator device; there are no new issues raised
by this patch.

Tested-by: Lei Yang <leiyang@redhat.com>

Eugenio P=C3=A9rez <eperezma@redhat.com> =E4=BA=8E2022=E5=B9=B411=E6=9C=882=
3=E6=97=A5=E5=91=A8=E4=B8=89 18:36=E5=86=99=E9=81=93=EF=BC=9A
>
> VIRTIO_NET_S_LINK_UP is already returned in config reads since vdpasim
> creation, but the feature bit was not offered to the driver.
>
> Tested modifying VIRTIO_NET_S_LINK_UP and different values of "status"
> in qemu virtio-net options, using vhost_vdpa.
>
> Not considering as a fix, because there should be no driver trusting in
> this config read before the feature flag.
>
> Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> ---
>  drivers/vdpa/vdpa_sim/vdpa_sim_net.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c b/drivers/vdpa/vdpa_sim=
/vdpa_sim_net.c
> index c3cb225ea469..30cfcfcf97f7 100644
> --- a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
> +++ b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
> @@ -27,6 +27,7 @@
>
>  #define VDPASIM_NET_FEATURES   (VDPASIM_FEATURES | \
>                                  (1ULL << VIRTIO_NET_F_MAC) | \
> +                                (1ULL << VIRTIO_NET_F_STATUS) | \
>                                  (1ULL << VIRTIO_NET_F_MTU) | \
>                                  (1ULL << VIRTIO_NET_F_CTRL_VQ) | \
>                                  (1ULL << VIRTIO_NET_F_CTRL_MAC_ADDR))
> --
> 2.31.1
>
>

