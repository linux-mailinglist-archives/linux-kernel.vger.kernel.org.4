Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF9F6741302
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 15:50:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231178AbjF1Nui (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 09:50:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbjF1Nuf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 09:50:35 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FD7C10D5;
        Wed, 28 Jun 2023 06:50:34 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3fba8e2aa52so17890895e9.1;
        Wed, 28 Jun 2023 06:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687960233; x=1690552233;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X9AT/plmLRAFXDyCQCDh4MBEPDmmZs0M8tMAQ+3zWko=;
        b=iq4Xo6B6DkKxinr4q6XTxbpXE/9W1zEbwB16gDr6fQKE2xm08tjSXSft+sUlCgtXBs
         ldcSDhwHq7Pmq+aY+apM8NKYsA6x0hpypJN2uQfZXd9QzK3+Q+QGybsy36+Gzh1jLI9C
         A5NGA3I2SmGz+ta8iQehTr7YCEvN8+4xlhw+jCP7Pl55Ss6c5rzR+z40LFCSDdjOR8Re
         BvGcTdyzjSOGq9Tk2RaQiZxhgYUfQb3fVm4bXmbmB3H3/dRJweaB1P2MapQMkeYtNfuc
         zmGcp3hZeejk26ST1j4vicqDrqnYtOpfl1xCwx68W9AHH0WxrVydCfsgd954eY3leTtT
         jSIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687960233; x=1690552233;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X9AT/plmLRAFXDyCQCDh4MBEPDmmZs0M8tMAQ+3zWko=;
        b=bFGfyxiLmWQ7CsQJom/P3Pwu2ZtHa9s25nhd+zZYFs1A61tLlZ1J5j2acLAQXFZc0O
         MSVUZbJ6p4TFMfnwXQa+/vU3QEfqcSCLtfLhPQ6v7W4iuozwuYaKjpDmGlj/pnMRe7ww
         LSz0q1aCJsRPjKSS8GgNbC0H3s4Ro76OwXlY00EtV3B644QlEapsLf2f2+Fz+dtitx0y
         6FifrQQvKR1Pt4vbhfTfLwFp4uDXXhWn0yFoZZ9dN0FlHutx+KkFBmm5jvmEaMY2f7Hn
         CPL7/j70ZXBTs46UbOjF9mPp5vh5sotS4867UyEdVnwBuo/uvvqg+SxDQN988okoR62n
         uVWA==
X-Gm-Message-State: AC+VfDxCWIwJg/WgJPT/oN1EcDKcDHxakk22SYUmBuEA9LvmchOfsTIY
        6KcMiwYOzYCnOJAZ7c3gSJQ=
X-Google-Smtp-Source: ACHHUZ4YFQRRYc4yP6nx4uJrRjsQgeq1yAEouQrVvmbwu5WL/c22dHbzVAvYxuN4HlrmSpqhJqVMfA==
X-Received: by 2002:a1c:f70d:0:b0:3f7:3685:1e10 with SMTP id v13-20020a1cf70d000000b003f736851e10mr27256747wmh.40.1687960232602;
        Wed, 28 Jun 2023 06:50:32 -0700 (PDT)
Received: from suse.localnet (host-95-238-98-134.retail.telecomitalia.it. [95.238.98.134])
        by smtp.gmail.com with ESMTPSA id k16-20020a05600c0b5000b003fba6709c68sm4692562wmr.47.2023.06.28.06.50.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 06:50:31 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Tyler Hicks <code@tyhicks.com>,
        Christian Brauner <brauner@kernel.org>,
        Dave Chinner <dchinner@redhat.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Al Viro <viro@zeniv.linux.org.uk>, ecryptfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] fs/ecryptfs: Replace kmap{,_atomic}() with
 kmap_local_page()
Date:   Wed, 28 Jun 2023 15:50:30 +0200
Message-ID: <23780760.ouqheUzb2q@suse>
In-Reply-To: <20230426172223.8896-1-fmdefrancesco@gmail.com>
References: <20230426172223.8896-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On mercoled=EC 26 aprile 2023 19:22:20 CEST Fabio M. De Francesco wrote:
> kmap() and kmap_atomic() have been deprecated in favor of
> kmap_local_page().
>=20
> Therefore, replace kmap() and kmap_atomic() with kmap_local_page().

After two months from submission, I haven't received any comments on this=20
short series yet, except for a "Reviewed by" tag from Ira on patch 1/3 only.

I would appreciate any comments/reviews/acks and would especially like to k=
now=20
if anything is preventing these patches from being applied.

Thank you all in advance,

=46abio

> Tested in a QEMU/KVM x86_32 VM, 6GB RAM, booting a kernel with
> HIGHMEM64GB enabled.
>=20
> v1->v2: Patches 1/3 and 2/3 were not grouped in a series. Patch 3/3 is
> new. Therefore, currently one series groups all conversions needed if
> fs/ecryptfs. The subject of 2/3 changed to differentiate between it and
> 3/3. Furthermore, the commit messages of 1/3 and 2/3 have been largely
> reworked.
>=20
> Fabio M. De Francesco (3):
>   fs/ecryptfs: Replace kmap() with kmap_local_page()
>   fs/ecryptfs: Use kmap_local_page() in ecryptfs_write()
>   fs/ecryptfs: Use kmap_local_page() in copy_up_encrypted_with_header()
>=20
>  fs/ecryptfs/crypto.c     |  8 ++++----
>  fs/ecryptfs/mmap.c       |  4 ++--
>  fs/ecryptfs/read_write.c | 12 ++++++------
>  3 files changed, 12 insertions(+), 12 deletions(-)
>=20
> --
> 2.40.0



