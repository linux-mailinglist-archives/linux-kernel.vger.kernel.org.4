Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59F766DAE3E
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 15:49:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231247AbjDGNs6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 09:48:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231757AbjDGNsS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 09:48:18 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0974FBDD8
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 06:46:42 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id 98e67ed59e1d1-2449d3400d6so161211a91.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Apr 2023 06:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680875197;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZL321vaITWn9sq0TM/dZld2xfZM7ieaEWlwJnFULcKo=;
        b=kX12iSDYPTc/jNWI/Shc8ryP57t5aEJe6dCb/WMczQssEYLicItq9gB9dV7uM6EBZd
         HvxFSx8v/lDlcZRtF1tzF6whyY+6UrmmJUEzdC9ZLJR+dda2MvA/7oUSxpLgeInB/POm
         Su74NLfmxkvKDnKgdWXQqhWJqQ17l+u6wV8Q233LYvItrgXBUAjy0prMpNT+xDJgIxZ8
         HmgQB2Jdp1gSDuO3tpXsmjlL3edgxU6Vqi1mUHX5koE0q0XWVtIAQT8N//rrRnkC+yxv
         I4IMsbF6r3RAOo3rC5XYdjYa8/s5ShRBVLBmC4KcbEmQsXcigR+3E1wJTOuF1WVTjWak
         xilA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680875197;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZL321vaITWn9sq0TM/dZld2xfZM7ieaEWlwJnFULcKo=;
        b=pMEvPB+7IJAbyDPZ+tjsuv+UFAwBWT4+VFrmKhUKC/bxUtSU7+PkixqnqUbSmYKgK5
         louXFDfgnMSxljCGbgkIsc5xPJT8zc6sc0uK0PkRXguatsR8jou+JebX37BId4c/gCnn
         wKsSuatQztu8uNd5TWn34MGGfRV8id1/8B7laKvhUI1wpoAGK6qWLOzPUMN31Pa3ZRBu
         vJruJOVKEzScpGUCbi1IQwePFDMf0MJBti0SMMiKmUP8JgrjpanjSQzkNOBAZ5y5h8Gn
         mH/+EDCYd5ZsLcOkbYm5dmRkWw4QWRd9oY25yBsOhd/qv9tqvgpjGFA8zslNvG0kXlY3
         Cujw==
X-Gm-Message-State: AAQBX9eoMn6ASrvEKFSm9dsfSDlbpoA9SKInZED/WJ5M4KXSZ1pSVJ+L
        n5er6bAMqEd6/XMiQGBYcwM=
X-Google-Smtp-Source: AKy350YaVuyemhEJIxnNyz0NWio4uKYlJsvlUnwsS6Msz0fskX2OH31jxejr8ZW2tYTR1B7iwI4pdw==
X-Received: by 2002:a62:1989:0:b0:626:1c2a:2805 with SMTP id 131-20020a621989000000b006261c2a2805mr2273160pfz.25.1680875197221;
        Fri, 07 Apr 2023 06:46:37 -0700 (PDT)
Received: from debian.me (subs03-180-214-233-76.three.co.id. [180.214.233.76])
        by smtp.gmail.com with ESMTPSA id b8-20020aa78108000000b0062d7c0dc4f4sm3067550pfi.80.2023.04.07.06.46.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Apr 2023 06:46:36 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id BEB061067F2; Fri,  7 Apr 2023 20:46:32 +0700 (WIB)
Date:   Fri, 7 Apr 2023 20:46:32 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Kautuk Consul <kconsul@linux.vnet.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Fabiano Rosas <farosas@linux.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Chao Peng <chao.p.peng@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: PPC: BOOK3S: book3s_hv_nested.c: improve branch
 prediction for k.alloc
Message-ID: <ZDAeuL2fz1aEW6rz@debian.me>
References: <20230407093147.3646597-1-kconsul@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6caTa8mxFTuMf/uP"
Content-Disposition: inline
In-Reply-To: <20230407093147.3646597-1-kconsul@linux.vnet.ibm.com>
X-Spam-Status: No, score=1.3 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6caTa8mxFTuMf/uP
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 07, 2023 at 05:31:47AM -0400, Kautuk Consul wrote:
> I used the unlikely() macro on the return values of the k.alloc
> calls and found that it changes the code generation a bit.
> Optimize all return paths of k.alloc calls by improving
> branch prediction on return value of k.alloc.

What about below?

"Improve branch prediction on kmalloc() and kzalloc() call by using
unlikely() macro to optimize their return paths."

That is, try to avoid first-person construct (I).

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--6caTa8mxFTuMf/uP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZDAetAAKCRD2uYlJVVFO
o8WRAQDI+qrr3elgQo4FKB1f8DWaii9J1c8omUyFNKUt/TOr0AEAvj3x7tljbC01
Cs/ZW4kFNxjJHwgIY5bhRfZr28QfbA4=
=4KC8
-----END PGP SIGNATURE-----

--6caTa8mxFTuMf/uP--
