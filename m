Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4764A69DCF9
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 10:35:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233606AbjBUJf1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 04:35:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbjBUJfZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 04:35:25 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AFC4222DB
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 01:34:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676972076;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eVxCrxXAn3hc/57NPIQoqiKS7loYJZHlmG/lcyLJuCU=;
        b=W6KZIl7k6rvddGvA1IXzbOI32E0FAuoG/1TkGFIGSqxFD/ukWtOnJe4hWDRpd6lBFPrBf3
        Qn2vtfQoJbYivypeQx7BuAuDEJPMweMCYuctUmMbMKwgvMbmmSuuK1bF7ECpF+wL8V0k/x
        Cj6E0syctbx46Uae2ymFsEGh/d4aSRY=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-179-btMptzQMPhi-fp9HHdAw8A-1; Tue, 21 Feb 2023 04:34:35 -0500
X-MC-Unique: btMptzQMPhi-fp9HHdAw8A-1
Received: by mail-qv1-f72.google.com with SMTP id ef20-20020a0562140a7400b004c72d0e92bcso1756308qvb.12
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 01:34:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eVxCrxXAn3hc/57NPIQoqiKS7loYJZHlmG/lcyLJuCU=;
        b=hR4rwKDdsNxOvdKKFWJSd9ppW6sL9hNLR7ddWNGDs6ziuLQxjmdEjIjicJulnETxm7
         oUfSVDSjrKZbUpPMZenXtGcwRRZoGaf5Ee05nCY87XEjiisRpgnV/npwfDDbACqFehjP
         t4/Jj0aq9qDHLFvOnzWiectL2zirDjEgsDHwKA5NihmoeHTqM0Qk6pzfrXcAqh6uoPFY
         prb/XdsquYXyKRMshXWzfr4w8gJI/KCFRbAAYIVBTQd4viaPsrPZjUuw/ofn+3BX8iEH
         LAfFuErfIabY87piPCcXr8eTpgH511CRRzdVdizNTQnqlcRsowlGFano5DRwMUhRkT1+
         sG6g==
X-Gm-Message-State: AO0yUKUrUhmqrJB8/wMd4UXtcXDa/Y+ZYIXHPap2fCbtap5YmIzH52OO
        tXWw6abXjUj5x/EeJpDk0Bska+9c//jPI1d9oMC+/556ZLQE6x8iIVbYLm7nE7hXvf45xFLeP0/
        XndYBGLZKw+fgtE4blRvyKvnj
X-Received: by 2002:a05:622a:1002:b0:3b8:5199:f841 with SMTP id d2-20020a05622a100200b003b85199f841mr7288663qte.0.1676972074692;
        Tue, 21 Feb 2023 01:34:34 -0800 (PST)
X-Google-Smtp-Source: AK7set+nG7PTi2OBqnICNinT/VzsN7qeMG1pK+wliixmn/uO8G5I5CTumsIYVx9FEhVR0txtWNJ2mw==
X-Received: by 2002:a05:622a:1002:b0:3b8:5199:f841 with SMTP id d2-20020a05622a100200b003b85199f841mr7288633qte.0.1676972074406;
        Tue, 21 Feb 2023 01:34:34 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-121-8.dyn.eolo.it. [146.241.121.8])
        by smtp.gmail.com with ESMTPSA id 126-20020a370384000000b0073b338b4eb1sm532116qkd.133.2023.02.21.01.34.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Feb 2023 01:34:33 -0800 (PST)
Message-ID: <5ad788427171d3c0374f24d4714ba0b429cbcfdf.camel@redhat.com>
Subject: Re: [PATCH v2] bnxt: avoid overflow in bnxt_get_nvram_directory()
From:   Paolo Abeni <pabeni@redhat.com>
To:     Simon Horman <simon.horman@corigine.com>,
        Maxim Korotkov <korotkov.maxim.s@gmail.com>
Cc:     Michael Chan <michael.chan@broadcom.com>,
        Pavan Chebbi <pavan.chebbi@broadcom.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
Date:   Tue, 21 Feb 2023 10:34:30 +0100
In-Reply-To: <Y/Iuu9SiAxh7qhJM@corigine.com>
References: <20230219084656.17926-1-korotkov.maxim.s@gmail.com>
         <Y/Iuu9SiAxh7qhJM@corigine.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
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

On Sun, 2023-02-19 at 15:14 +0100, Simon Horman wrote:
> On Sun, Feb 19, 2023 at 11:46:56AM +0300, Maxim Korotkov wrote:
> > The value of an arithmetic expression is subject
> > of possible overflow due to a failure to cast operands to a larger data
> > type before performing arithmetic. Used macro for multiplication instea=
d
> > operator for avoiding overflow.
> >=20
> > Found by Security Code and Linux Verification
> > Center (linuxtesting.org) with SVACE.
> >=20
> > Fixes: c0c050c58d84 ("bnxt_en: New Broadcom ethernet driver.")
> > Signed-off-by: Maxim Korotkov <korotkov.maxim.s@gmail.com>
> > Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
>=20
> I agree that it is correct to use mul_u32_u32() for multiplication
> of two u32 entities where the result is 64bit, avoiding overflow.
>=20
> And I agree that the fixes tag indicates the commit where the code
> in question was introduced.
>=20
> However, it is not clear to me if this is a theoretical bug
> or one that can manifest in practice - I think it implies that
> buflen really can be > 4Gbytes.
>=20
> And thus it is not clear to me if this patch should be for 'net' or
> 'net-next'.

... especially considered that both 'dir_entries' and 'entry_length'
are copied back to the user-space using a single byte each.

Cheers,

Paolo

