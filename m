Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45F536BFAE8
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Mar 2023 15:39:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbjCROi5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Mar 2023 10:38:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjCROiz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Mar 2023 10:38:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3265320569
        for <linux-kernel@vger.kernel.org>; Sat, 18 Mar 2023 07:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679150291;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bkuGVXmQ0b90eKYogKSZlQ+nSCpX7L6mEXOicznEHc8=;
        b=hO7Nv2Q+n8ByjHHcj326yhWITJ123aQJBVd0s+EafH8D2BkG90ni0W9hgBYXJOFkxhmKvt
        q2iFhAI+moBVVamBXrsRKiDN/5V9sxqcA5pLljCrImUOK6+jEoh6ZFohGQUbtxLfk1kd9f
        m2VEISJrfkM4lfYtmDLqYA6Vu65KrLM=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-671-OeI2dL7RP7G4x82b72Jacg-1; Sat, 18 Mar 2023 10:38:09 -0400
X-MC-Unique: OeI2dL7RP7G4x82b72Jacg-1
Received: by mail-io1-f72.google.com with SMTP id p3-20020a6b8d03000000b00753e534ddd5so2723806iod.14
        for <linux-kernel@vger.kernel.org>; Sat, 18 Mar 2023 07:38:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679150289;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bkuGVXmQ0b90eKYogKSZlQ+nSCpX7L6mEXOicznEHc8=;
        b=PZfCeOXuAM8sFFp5fnqzCdjT1RmYq3NuCAfjHxDw/VB4SoE/FP6xLZVSTh1l/CjW+P
         0STCBXB3k9TOEjdcVUsxMiXeM2W6a8A6y0Y32pjxWwksuTLh/kWzBbSR6f3m9C+NYbdg
         LI7Ogi6eq5+Uwz581RGJEW4sTVBzKMTa8kIjzctmNa3aPhrW+k/WejC/KNpP0QvLSS/u
         MridkWL3zAnWrp7KiTGer7NJJr4XOLC1j/S6z0Wg3KU0nqH+drVZcMrIZ++wKBM/ryqJ
         38M1A7eBQ58M1BuQF8veSmRH1lBDPgdMU3lZWvXy0SxUQws8YmZqaDhtAk0BNKvmEeLL
         L7Fg==
X-Gm-Message-State: AO0yUKUEe52fDPRgYO7iHhbwswVDHT/PnFHSvcG456GdxarhS0zxB3LT
        M0ev2xDbTBG1WK1aPwNfS+xRrPuA2NnPrWbK5w3UgH5HAZC1F9NcIihQPcunMIYPEn7sBpJTRTA
        AjXuvX8lzoFm9xPe+oya10xki
X-Received: by 2002:a92:c749:0:b0:315:5651:3317 with SMTP id y9-20020a92c749000000b0031556513317mr1460475ilp.14.1679150289133;
        Sat, 18 Mar 2023 07:38:09 -0700 (PDT)
X-Google-Smtp-Source: AK7set+VuOXtQ96p+9VArU3RoaPfUQrDvtrrrrFhhAbqJp3w/tDnUvKQYRZGKS1MLuev0DR4h2M4mg==
X-Received: by 2002:a92:c749:0:b0:315:5651:3317 with SMTP id y9-20020a92c749000000b0031556513317mr1460465ilp.14.1679150288812;
        Sat, 18 Mar 2023 07:38:08 -0700 (PDT)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id r15-20020a92c5af000000b00313ca4be5e1sm1439985ilt.12.2023.03.18.07.38.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Mar 2023 07:38:07 -0700 (PDT)
Date:   Sat, 18 Mar 2023 08:38:06 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     liulongfang <liulongfang@huawei.com>
Cc:     <jgg@nvidia.com>, <shameerali.kolothum.thodi@huawei.com>,
        <jonathan.cameron@huawei.com>, <cohuck@redhat.com>,
        <linux-kernel@vger.kernel.org>, <linuxarm@openeuler.org>
Subject: Re: [PATCH v8 3/5] hisi_acc_vfio_pci: register debugfs for
 hisilicon migration driver
Message-ID: <20230318083806.41a121f9.alex.williamson@redhat.com>
In-Reply-To: <ed124c05-9ebe-57e7-51bb-52edf6061646@huawei.com>
References: <20230217084831.35783-1-liulongfang@huawei.com>
        <20230217084831.35783-4-liulongfang@huawei.com>
        <20230310164016.7888a207.alex.williamson@redhat.com>
        <fbdda52e-06b4-9e74-7880-e75df5aef546@huawei.com>
        <d62c93da-e0c9-ddd6-3e2b-bf1a9b62058b@huawei.com>
        <20230314091704.22e8349a.alex.williamson@redhat.com>
        <ed124c05-9ebe-57e7-51bb-52edf6061646@huawei.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

On Sat, 18 Mar 2023 17:07:38 +0800
liulongfang <liulongfang@huawei.com> wrote:

> On 2023/3/14 23:17, Alex Williamson wrote:
> > I was thinking:
> >=20
> > vfio
> > =E2=94=9C=E2=94=80=E2=94=80 <name1>
> > =E2=94=82=C2=A0=C2=A0 =E2=94=94=E2=94=80=E2=94=80 migration
> > =E2=94=82=C2=A0=C2=A0     =E2=94=9C=E2=94=80=E2=94=80 hisi_acc
> > =E2=94=82=C2=A0=C2=A0     =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=
=94=80 attr
> > =E2=94=82=C2=A0=C2=A0     =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=
=94=80 data
> > =E2=94=82=C2=A0=C2=A0     =E2=94=82=C2=A0=C2=A0 =E2=94=94=E2=94=80=E2=
=94=80 debug
> > =E2=94=82=C2=A0=C2=A0     =E2=94=94=E2=94=80=E2=94=80 state
> > =E2=94=94=E2=94=80=E2=94=80 <name2>
> >     =E2=94=94=E2=94=80=E2=94=80 migration
> >         =E2=94=9C=E2=94=80=E2=94=80 hisi_acc
> >         =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 attr
> >         =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 data
> >         =E2=94=82=C2=A0=C2=A0 =E2=94=94=E2=94=80=E2=94=80 debug
> >         =E2=94=94=E2=94=80=E2=94=80 state
> >=20
> > My concern is that if {attr,data,debug} have driver specific
> > definitions, they should have their own driver specific namespace.
> > Thanks,
> >  =20
>=20
> Do <name1> and <name1> refer to dev_name()?

Yes

> Is the file name "hisi_acc" defined by the driver?

Yes, this is the drive defined namespace.  Thanks,

Alex

