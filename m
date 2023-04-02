Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 637136D37FC
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Apr 2023 14:55:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230368AbjDBMzZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Apr 2023 08:55:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbjDBMzX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Apr 2023 08:55:23 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36EF8BB96;
        Sun,  2 Apr 2023 05:55:21 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id r7-20020a17090b050700b002404be7920aso25919011pjz.5;
        Sun, 02 Apr 2023 05:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680440121;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BpzI7Au0Q9dN4lD4MrjFVfTVGtzJnGuXlYcSG+gzAgM=;
        b=YRm7lKLzpWSTbjXr7/lR2eKETP18fhNBuZf4Z4FzVLBRsgmWVJ0KU07DRToZeZvcUt
         QRP3SSkWTkhAzZmMkI0cE1NINqjbS8K6c0vJWE4zDyRNb0KQnQlv5gFTl3WwrgGEqdwk
         0gYjSRKIwXqvR0Q8HNH+EkM+uUXcffaFLpa/q7XVTLmQ9ztzCRKttIOtO/1v4TJckkox
         CZoePAq9JMJad4uJyc27enzTyNviWi7Y81GucQi5c9AA3vTYXr9APemFODPGTYwwg9d/
         ZC1nx+ZG+I55QJibqC4Ync7u33OvqTMh56uVr3muA6nqjzayqDwXcgY7+szrgN93yZt3
         Cf0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680440121;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BpzI7Au0Q9dN4lD4MrjFVfTVGtzJnGuXlYcSG+gzAgM=;
        b=Y9fuZVO7gZnR53oNa4bh17kZ0fBShABDNnoTZVq0ZIimEliRoje2IAvrwz1NSWGuSX
         L0mbssNL9whCkjnEbIfQOXAKc1F54cVHho7lP7emBPg6loDvu+ldX7fRVxeY6VE3iyCz
         cSND1DWObz4r5xzHq5jAKG30qPnidBf3M3vHs6DRyvegXsntO10znV0IHRbCXVioeOnE
         IS5eebtBXs//Af0tPv/CQ21GeAt6kNALqIxeBD3GqRexyEnhsIRcbkJUb4Tza29n5DXT
         ov1VjMnUF0oOTV03P0DyFCSR7S2OpWwkYeeEaLSvyPhpHu3iKU1itAKjjPF4RHNSD6to
         Ba5Q==
X-Gm-Message-State: AO0yUKXCDi/IRAEoVWwtLjbphXj6S954nvuDf/THaIU2q4a6sC72k6Zi
        8G96dYMXvCPYRIS/eq7TEC8=
X-Google-Smtp-Source: AK7set9J/bkXp2IenXpcl+alnaEaJ4zMy00BFKY8+Lxc7qyJBXhV5hWxvqaGDWqoua6UVYXpUpoStg==
X-Received: by 2002:a05:6a20:4d94:b0:cc:d514:62cf with SMTP id gj20-20020a056a204d9400b000ccd51462cfmr24024616pzb.43.1680440120717;
        Sun, 02 Apr 2023 05:55:20 -0700 (PDT)
Received: from debian.me (subs28-116-206-12-38.three.co.id. [116.206.12.38])
        by smtp.gmail.com with ESMTPSA id u16-20020aa78490000000b006242f4a8945sm5004103pfn.182.2023.04.02.05.55.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Apr 2023 05:55:20 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id A138010665A; Sun,  2 Apr 2023 19:55:16 +0700 (WIB)
Date:   Sun, 2 Apr 2023 19:55:16 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Lucas Tanure <tanure@linux.com>,
        kernelnewbies <kernelnewbies@kernelnewbies.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org
Subject: Re: Kernel Panic - V6.2 - Reseved memory issue
Message-ID: <ZCl7NFN5igCkIaLz@debian.me>
References: <CAJX_Q+1Tjc+-TjZ6JW9X0NxEdFe=82a9626yL63j7uVD4LpxEA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Wq5IN3qnESGv29nn"
Content-Disposition: inline
In-Reply-To: <CAJX_Q+1Tjc+-TjZ6JW9X0NxEdFe=82a9626yL63j7uVD4LpxEA@mail.gmail.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Wq5IN3qnESGv29nn
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 02, 2023 at 09:10:36AM +0100, Lucas Tanure wrote:
> Log:
>=20
> [ 9.792966] SError Interrupt on CPU3, code 0x00000000bf000000 -- SError
> [ 9.792980] CPU: 3 PID: 3471 Comm: kded5 Tainted: G C 6.2.0 #1
> [ 9.792985] Hardware name: Khadas VIM3 (DT)
> [ 9.792987] pstate: 20000005 (nzCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=
=3D--)
> [ 9.792991] pc : kmem_cache_free_bulk.part.98+0x1f0/0x528
> [ 9.793004] lr : kmem_cache_free_bulk.part.98+0x2f8/0x528
> [ 9.793008] sp : ffff80000a2eb7f0
> [ 9.793009] x29: ffff80000a2eb7f0 x28: ffff00001f358518 x27: ffff00000000=
8800
> [ 9.793016] x26: ffff00000262b300 x25: ffff00000262b300 x24: 000000000000=
0001
> [ 9.793019] x23: ffff00000262b000 x22: 0000000000000000 x21: ffff00001f35=
8538
> [ 9.793022] x20: fffffc0000098ac0 x19: 0000000000000004 x18: 000000000000=
0040
> [ 9.793025] x17: 0000000000000018 x16: 00000000000007f8 x15: 000000000000=
0003
> [ 9.793028] x14: 0000000000000006 x13: ffff800008e48550 x12: 0000ffff9dc9=
1fff
> [ 9.793031] x11: 0000000000000004 x10: 0000000000000001 x9 : ffff000007e9=
3680
> [ 9.793035] x8 : 0000000000000020 x7 : ffff000001d2b100 x6 : 000000000000=
0007
> [ 9.793037] x5 : 0000000000000020 x4 : ffff000000008800 x3 : 000000000000=
0001
> [ 9.793040] x2 : 0000000000000007 x1 : 0000000000000000 x0 : ffff00001f35=
8540
> [ 9.793045] Kernel panic - not syncing: Asynchronous SError Interrupt
>=20
> This doesn't happen with downstream Khadas 6.2 kernel, and that's
> because the downstream kernel removed this from
> early_init_dt_reserve_memory (drivers/of/fdt.c):
>=20
> /*
> * If the memory is already reserved (by another region), we
> * should not allow it to be marked nomap, but don't worry
> * if the region isn't memory as it won't be mapped.
> */
> if (memblock_overlaps_region(&memblock.memory, base, size) &&
>     memblock_is_region_reserved(base, size))
>           return -EBUSY;
>=20

What commit on downstream kernel that fix the issue? Can you reproduce
on mainline with above conditional removed? Alternatively, can
you post the downstream fix here?

Also, can you find last working commit on mainline? If so, this is
regression.

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--Wq5IN3qnESGv29nn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZCl7LwAKCRD2uYlJVVFO
o9EWAQCPtYrbWdu3QEMuqKyChX9q9UnlkrbF0Vwm/6YqiqGRAgEAwqg0FslXEiJE
jh7cVhCBy9zWyiCJf+XjOLmQ9SPjTQA=
=w4gz
-----END PGP SIGNATURE-----

--Wq5IN3qnESGv29nn--
