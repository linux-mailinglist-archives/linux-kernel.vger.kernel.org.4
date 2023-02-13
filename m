Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C26506944F4
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 13:00:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbjBMMAD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 07:00:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjBMMAB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 07:00:01 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50BCF17172
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 03:59:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676289560;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=P69Z5ADefECQaVigK14re30Iy1qGGLvGB0eZAssHA6w=;
        b=fbJAKZolKsm/i2ju9GUBLldxi34yiwhwb8PHyfFfcaIBzFuvdB3ufkvZtremiDahOP6n5l
        f9TxXG7hfEVafHi+OfoAOkEZPfSM+zBRjGJmJ7mH1FHOrh7+otNiNLBG7Cx0E9wrr2+quj
        CIHxm2XePUpvF/RV/Lz1HfoRaSLInNA=
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-402-OX2OQX7CPqKblRNMiB0alw-1; Mon, 13 Feb 2023 06:59:19 -0500
X-MC-Unique: OX2OQX7CPqKblRNMiB0alw-1
Received: by mail-vs1-f72.google.com with SMTP id bk38-20020a05610254a600b003f3633a1a04so2465868vsb.20
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 03:59:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P69Z5ADefECQaVigK14re30Iy1qGGLvGB0eZAssHA6w=;
        b=b+V90sHkD/0pPPtbtVudbHLL9FA9g1rZL3U6MmghFKfH1/6EDW30UjQ59kYI6m80Ya
         GX9/g3tqOnref5Ok5QGAoD6xujNloPcOpIvwG9HdoT6VwEtD4Frl5wv3JBw5lZ7bWHyp
         JgDji0nQRcAgPkpW0go5TJtp0P8dkfVxREFzP/kbEr9LvVCkROdkhrPMoBGpxZoRcZVo
         1F36vssFTZflqWnPaHn7ZR2iHjJPISM2DCCxjgAzxbt3qitE0L7NMpS6fSFae9KNJTO9
         R7+MiHa+7aUPcbnaB2YAIMoJC/qA1pjw/hFkLb09W825xFq2D5igfyczsI/tcCRvAjWI
         skYA==
X-Gm-Message-State: AO0yUKWB3/yuRPgOvQDFGNeB3Sbr9CKelUFkghuq7ZZyEmzD/d4t4TMA
        Nxpsdzf6nUDzZ7oijzc2W8mrjNG0Lx06Ea2RqM4yJRa4jGkW16fdsOp/6pcS9V3aNFVLXp4bEBp
        3y0MpUPAaLEAlhon0d7T/l8eSxz1MBcjG2Xt+w5RB
X-Received: by 2002:a1f:28d8:0:b0:401:5dc0:439f with SMTP id o207-20020a1f28d8000000b004015dc0439fmr697215vko.33.1676289558737;
        Mon, 13 Feb 2023 03:59:18 -0800 (PST)
X-Google-Smtp-Source: AK7set+4tZju16RoVCDo6v7tREO+1gsmeF9WlTEqa4Y+ytbbaPJ48q9hz3PS1XBNBosBmPEHLhdd7V1g3WqzGmaoly4=
X-Received: by 2002:a1f:28d8:0:b0:401:5dc0:439f with SMTP id
 o207-20020a1f28d8000000b004015dc0439fmr697208vko.33.1676289558502; Mon, 13
 Feb 2023 03:59:18 -0800 (PST)
MIME-Version: 1.0
References: <20230208200957.14073-1-djeffery@redhat.com>
In-Reply-To: <20230208200957.14073-1-djeffery@redhat.com>
From:   Maurizio Lombardi <mlombard@redhat.com>
Date:   Mon, 13 Feb 2023 12:59:07 +0100
Message-ID: <CAFL455kEoLQF+vc2MGmtLdrQ-=U+HJzqgknZmM54iCPJD1p_mA@mail.gmail.com>
Subject: Re: [PATCH] scsi: target: iscsi: set memalloc_noio with loopback
 network connections
To:     David Jeffery <djeffery@redhat.com>
Cc:     target-devel@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Mike Christie <michael.christie@oracle.com>,
        Laurence Oberman <loberman@redhat.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

st 8. 2. 2023 v 21:10 odes=C3=ADlatel David Jeffery <djeffery@redhat.com> n=
apsal:
>
>
> +       /*
> +        * If the iscsi connection is over a loopback device from using
> +        * iscsi and iscsit on the same system, we need to set memalloc_n=
oio to
> +        * prevent memory allocation deadlocks between target and initiat=
or.
> +        */
> +       rcu_read_lock();
> +       dst =3D rcu_dereference(conn->sock->sk->sk_dst_cache);
> +       if (dst && dst->dev && dst->dev->flags & IFF_LOOPBACK)
> +               loopback =3D true;
> +       rcu_read_unlock();

Hi Mike,
I tested it, it works. The customer also confirmed that it fixes the
deadlock on his setup.

Maurizio

