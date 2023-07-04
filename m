Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DCB374765F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 18:23:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231549AbjGDQXR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 12:23:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbjGDQXP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 12:23:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92365DC
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 09:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688487754;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JEbE+8f35ggewzZYNnfdnK2Dc2UOo1hQkfffSP6zams=;
        b=AhqQATK7MbD/onEC91KqqFjhPhPKWOdhPoTTwYCerGhsgNTemEoyAQqG3eKo9RynFg/DMq
        q84iWS8Lz+OsEgSevNlAbnlrU9FKD54PosoOeigJEAnu19kACnsWCPsaadDQLi5YS+2P3U
        oShkDOtUvtSCfXnw6Zz+BfQCy4kRGwY=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-203-0FHX78ioMsC3SnhKV8U1Bg-1; Tue, 04 Jul 2023 12:22:33 -0400
X-MC-Unique: 0FHX78ioMsC3SnhKV8U1Bg-1
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-565d1b86a64so49246167b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jul 2023 09:22:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688487753; x=1691079753;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JEbE+8f35ggewzZYNnfdnK2Dc2UOo1hQkfffSP6zams=;
        b=MOeNVgWlzMKHGi/72oRorvH6cD80VM/O3rCFJ1qcE9vh/+UNPkNw9AASalBqRD4pNo
         ONTekc/5xlWuBCSI0VrbbdKXi96WeoF7RFgzEpQ4VfP+PGL4D0vCsIswGtJFkmGtZ7dH
         BajnLMy7N93UmBLUNHsN43IkN+mYyC3E0PybgeEa5D+R4b3Ffl3EWhSse//X4VRwqM3P
         8RvGVYUBqS3skM9DJcp+2a/5hOHMW4hUVwelLeW++bJqSh4IMR28/Q3cow+e6Lj2nXrH
         xAAAplCnFqUH83XzvUb5WT3cLnANEgM//0G0NG5f1x5gd2hiEOs/vkyv2YeGE0ZEvK0i
         qzyw==
X-Gm-Message-State: ABy/qLYWXFWc/KSuk6z3xySJf8GZxck2mulvBIOj8WADj3A6n8Gse3k3
        5SWaaabWsZ16gvS7KT0wMfjeggQG7RcNKCaTKRQ3mLODMHMOe9rfng8HiJXy0Wl162rFx4yfIq8
        hRJ+oJHoBNxPfkfOwDdfrAGbM+sfnW/0Xxv162Y1q/sf6v4lv
X-Received: by 2002:a81:9283:0:b0:577:1a7f:1d8 with SMTP id j125-20020a819283000000b005771a7f01d8mr14270075ywg.22.1688487752906;
        Tue, 04 Jul 2023 09:22:32 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEnaRG0fc85OSCzWDXGD+BlmBU/HE7Uhfv9CtyDA+iKGrH0x/UCTkyS27cEdrHyKES76iZNdLnALUJ32kb3KMM=
X-Received: by 2002:a81:9283:0:b0:577:1a7f:1d8 with SMTP id
 j125-20020a819283000000b005771a7f01d8mr14270064ywg.22.1688487752732; Tue, 04
 Jul 2023 09:22:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230704104725.2510-1-machel@vivo.com>
In-Reply-To: <20230704104725.2510-1-machel@vivo.com>
From:   Alexander Aring <aahringo@redhat.com>
Date:   Tue, 4 Jul 2023 12:22:21 -0400
Message-ID: <CAK-6q+jQcyyAtMD5tjzjrJg8Auy6HuugJomiSokwRhqRifVpCA@mail.gmail.com>
Subject: Re: [Cluster-devel] [PATCH v1] fs:dlm:Fix NULL pointer dereference
 bug in accept_from_sock()
To:     Wang Ming <machel@vivo.com>
Cc:     Christine Caulfield <ccaulfie@redhat.com>,
        David Teigland <teigland@redhat.com>, cluster-devel@redhat.com,
        linux-kernel@vger.kernel.org, opensource.kernel@vivo.com
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

Hi,

On Tue, Jul 4, 2023 at 6:56=E2=80=AFAM Wang Ming <machel@vivo.com> wrote:
>
> newcon -> sock is NULL but dereferenced.
> First check newcon. Whether sock is a null pointer.
> If so, the subsequent operations are skipped.
> If it is not empty, perform subsequent operations.
>

did you experience some null pointer dereference? If so, on which kernel wa=
s it?

> Signed-off-by: Wang Ming <machel@vivo.com>
> ---
>  fs/dlm/lowcomms.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/fs/dlm/lowcomms.c b/fs/dlm/lowcomms.c
> index 9f14ea9f6..ea18b9478 100644
> --- a/fs/dlm/lowcomms.c
> +++ b/fs/dlm/lowcomms.c
> @@ -1081,9 +1081,12 @@ static int accept_from_sock(void)
>                 add_sock(newsock, newcon);
>

Here in add_sock() we assign newcon->sock =3D newsock. It cannot fail
and newsock cannot be null, so holding the newcon->sock_lock write
protected _should_ be safe that others don't manipulate newcon->sock.
It should, that's why I am asking if you experienced some issue here?

>                 /* check if we receved something while adding */
> -               lock_sock(newcon->sock->sk);
> -               lowcomms_queue_rwork(newcon);
> -               release_sock(newcon->sock->sk);

see above, newcon->sock should always be set at this point.

> +               if (newcon->sock) {
> +                       lock_sock(newcon->sock->sk);
> +                       lowcomms_queue_rwork(newcon);
> +                       release_sock(newcon->sock->sk);
> +               }
> +
>         }
>         up_write(&newcon->sock_lock);
>         srcu_read_unlock(&connections_srcu, idx);

- Alex

