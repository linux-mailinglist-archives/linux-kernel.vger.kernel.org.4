Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1EDF6645E5
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 17:20:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233598AbjAJQUe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 11:20:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234235AbjAJQUS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 11:20:18 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AAD35D432
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 08:19:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673367569;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Vo+r1QQ4ck/ppanavjFv3Ae00jvXHJ/nRrcL6yv9HGA=;
        b=GiCU01eoB1jNrcbv3ujvWW+qHPmG7ONrsBWgKXAC80vzP+iqOWrWwUzzRyd9aIQ2lUNv5I
        X9w5ELbLi8L6V7b9WNGNzalJWeR+eiKTP69lPsInc4wqZt0TZ5DzVNIhyBQLCOPyKDDYzk
        lDdCU3YEvCGdRHupei5nJXAA9gho9l4=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-348-dQVGclW5PtmQRQI06-mTqA-1; Tue, 10 Jan 2023 11:19:28 -0500
X-MC-Unique: dQVGclW5PtmQRQI06-mTqA-1
Received: by mail-lf1-f72.google.com with SMTP id bp18-20020a056512159200b004b59c4fb76bso4626029lfb.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 08:19:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Vo+r1QQ4ck/ppanavjFv3Ae00jvXHJ/nRrcL6yv9HGA=;
        b=fYj/q7pZoX7p+kvkN9kjKH1o24YDf0AOi+RBv77XZ0cgKH3NPpKVxFhhWwDdYWvs18
         FFWnLu+B5siF2RXfRVi4rI93oD5x5c/H1Jccy6UGVnBpUAKvTumCA0Ac2lif0wnGE9T/
         k2d+sGewDjP20GAt+oAjqATkCTZhttXRnb37hrbnGPnhAWiIHivfwPC5KG4UZUXFWRqh
         Sa2/h/KPQPAxaqdoz8tgdUMMImKl80fNKAopqElCGtcGnNXRK/tOMbybogm4YMR2FeVB
         NivowcAVJkocbTULUnbGtji0Bp0ldV3pl6bjAayhf961jE8XbWXkfBb5qjJ3+9eHmViI
         awew==
X-Gm-Message-State: AFqh2kq9dDqAFSTA4wvIDL8lrpcUIOTANya59QcekDdVyUMh0n5q0msq
        WDjOFqG946OJAhA2sBPmVwJgZQRaJ84xShjl7YO7d/Ha8DB2JX9BGOU/Z0m6Vo4r6L0vldtY7ub
        HOfZRW0xUAJ9Xvf+PgVDREKCs
X-Received: by 2002:a05:6512:1688:b0:4ca:fa75:a64a with SMTP id bu8-20020a056512168800b004cafa75a64amr19815675lfb.0.1673367566850;
        Tue, 10 Jan 2023 08:19:26 -0800 (PST)
X-Google-Smtp-Source: AMrXdXs9mNJdkoKcb9Bdob/hPwc/Y8uVxKrapTtbGK5haICO4IputBLiq8G82i1OgWpJOQdtSnW/HA==
X-Received: by 2002:a05:6512:1688:b0:4ca:fa75:a64a with SMTP id bu8-20020a056512168800b004cafa75a64amr19815666lfb.0.1673367566672;
        Tue, 10 Jan 2023 08:19:26 -0800 (PST)
Received: from greebo.mooo.com (c-e6a5e255.022-110-73746f36.bbcust.telenor.se. [85.226.165.230])
        by smtp.gmail.com with ESMTPSA id y19-20020ac24473000000b004946b549a19sm2256542lfl.45.2023.01.10.08.19.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jan 2023 08:19:26 -0800 (PST)
Message-ID: <16f071eb34083b6248dd50b204e8f9979b091647.camel@redhat.com>
Subject: Re: [PATCH 2/6] composefs: Add on-disk layout
From:   Alexander Larsson <alexl@redhat.com>
To:     Brian Masney <bmasney@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        gscrivan@redhat.com
Date:   Tue, 10 Jan 2023 17:19:25 +0100
In-Reply-To: <Y7by8Pv6z+Z1o3pu@x1>
References: <cover.1669631086.git.alexl@redhat.com>
         <cbe0d67a97c8b5157de06cedb67c88794c9c304e.1669631086.git.alexl@redhat.com>
         <Y7by8Pv6z+Z1o3pu@x1>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.2 (3.46.2-1.fc37) 
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

On Thu, 2023-01-05 at 10:55 -0500, Brian Masney wrote:
> On Mon, Nov 28, 2022 at 12:16:23PM +0100, Alexander Larsson wrote:
> > This commit adds the on-disk layout header file of composefs.
> >=20
> > Signed-off-by: Alexander Larsson <alexl@redhat.com>
> > Signed-off-by: Giuseppe Scrivano <gscrivan@redhat.com>
>=20
> Add Co-Developed-By: Giuseppe ... ?
>=20
> Full disclosure: I'm not a file system developer but I'll attempt to
> help with the review of this series.
>=20

Thanks. I did various changes to the github repo based on your review,
here are the outstanding comments:

>=20
> > +struct cfs_header_s {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u8 version;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u8 unused1;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u16 unused2;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u32 magic;
>=20
> Should the magic number appear first?

I don't think so, the version number is essentially part of the full
magic string.
>=20

>=20
--=20
=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D=
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
=3D-=3D-=3D
 Alexander Larsson                                            Red Hat,
Inc=20
       alexl@redhat.com            alexander.larsson@gmail.com=20
He's a notorious vegetarian filmmaker who knows the secret of the alien
invasion. She's an artistic tomboy nun married to the Mob. They fight=20
crime!=20

