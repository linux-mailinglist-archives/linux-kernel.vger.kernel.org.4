Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 787646DCFFE
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 05:11:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbjDKDLE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 23:11:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230004AbjDKDKw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 23:10:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D51A1BC1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 20:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681182607;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PIRYPPRzMr0WDaISNXv8JTRc994C6mm8nrgRnA2e2II=;
        b=fNmYq7YNFmzcVcmC9xHFrmxNMWODFvtLoP2qWQ2IzwmuSkP+6aqjf0epNaCWgp056ysSFX
        +QgNng7BYRKFEijfOWka8OJc3NOEfjqIBruqEHgK+Lz8dogMrEXIRXtRcQpRrUiFyKqUv9
        hKCve9IksJ+mVO/wLiSktirk7hDeohQ=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-218-APUkmq5XOx6cedAKNAWvCQ-1; Mon, 10 Apr 2023 23:09:58 -0400
X-MC-Unique: APUkmq5XOx6cedAKNAWvCQ-1
Received: by mail-oo1-f69.google.com with SMTP id t1-20020a4a96c1000000b0053e37b1fb91so953911ooi.8
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 20:09:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681182597; x=1683774597;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PIRYPPRzMr0WDaISNXv8JTRc994C6mm8nrgRnA2e2II=;
        b=MNA+evPSh3wvrrOJQ3rbWf5a3qeYix6ppl0/fKbwxbAVB3G+S7eMhJCePNpR740clI
         dvZ18GPH9XdynHUXDLit3ZvWN/GF6Au54AhN9Zhsdi9apyF2LNQc7r8et8McwXeeJeuP
         hNC5Cc0ceQJ/NMDkiOAvOGlvV4/DxZmy/Umjw0uNvnxh/aGbelFTW6Vq0aTVXjJB4XDU
         tCK6rqUe3kyfwsmEhZhi9vWi3RqAGCRiJoiJmsGuhsOqCQL8Q0iwx6i4TGCiSZQSqc04
         KTHqgZ2gwM26wHXN7Shc9nRcOM7+TigjFpzM3cMD9SixSKo51BB9nIzFtl6WiZn0N23a
         vBWA==
X-Gm-Message-State: AAQBX9cM5C0mgmuxtOE4WIeRHBDrA3N9qHfUVcIjJ86ivDUfXdNeB5ET
        Jvu46mgMEwKICInIGnJsiqvZK9teOg04492OtF2JI+gB4sOFQC0+ohulysFHteo01elk+w6Fuzr
        LeHfua2vLDqc6Hyab4bicfGE+gsSjOhIJpo+xLN+MT0yuOdJolIm+Qw==
X-Received: by 2002:a54:4108:0:b0:389:86c3:b1fb with SMTP id l8-20020a544108000000b0038986c3b1fbmr1767291oic.9.1681182597579;
        Mon, 10 Apr 2023 20:09:57 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZeucJf+EbWtNuhPzUoVMqvWrsCF6D+3DIu6eOe4RcryYcADiNhudEFaSmmkr0WQmH0aZjfEc0FYx82LleldDo=
X-Received: by 2002:a54:4108:0:b0:389:86c3:b1fb with SMTP id
 l8-20020a544108000000b0038986c3b1fbmr1767284oic.9.1681182597366; Mon, 10 Apr
 2023 20:09:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230410150130.837691-1-lulu@redhat.com>
In-Reply-To: <20230410150130.837691-1-lulu@redhat.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Tue, 11 Apr 2023 11:09:46 +0800
Message-ID: <CACGkMEvTdgvqacFmMJZD4u++YJwESgSmLF6CMdAJBBqkxpZKgg@mail.gmail.com>
Subject: Re: [PATCH] vhost_vdpa: fix unmap process in no-batch mode
To:     Cindy Lu <lulu@redhat.com>
Cc:     mst@redhat.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 10, 2023 at 11:01=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote:
>
> While using the no-batch mode, the process will not begin with
> VHOST_IOTLB_BATCH_BEGIN, so we need to add the
> VHOST_IOTLB_INVALIDATE to get vhost_vdpa_as, the process is the
> same as VHOST_IOTLB_UPDATE
>
> Signed-off-by: Cindy Lu <lulu@redhat.com>
> ---
>  drivers/vhost/vdpa.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> index 7be9d9d8f01c..32636a02a0ab 100644
> --- a/drivers/vhost/vdpa.c
> +++ b/drivers/vhost/vdpa.c
> @@ -1074,6 +1074,7 @@ static int vhost_vdpa_process_iotlb_msg(struct vhos=
t_dev *dev, u32 asid,
>                 goto unlock;
>
>         if (msg->type =3D=3D VHOST_IOTLB_UPDATE ||
> +           msg->type =3D=3D VHOST_IOTLB_INVALIDATE ||

I'm not sure I get here, invalidation doesn't need to create a new AS.

Or maybe you can post the userspace code that can trigger this issue?

Thanks

>             msg->type =3D=3D VHOST_IOTLB_BATCH_BEGIN) {
>                 as =3D vhost_vdpa_find_alloc_as(v, asid);
>                 if (!as) {
> --
> 2.34.3
>

