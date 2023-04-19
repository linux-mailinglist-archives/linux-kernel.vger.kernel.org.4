Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E07756E74A0
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 10:06:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232001AbjDSIG1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 04:06:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231652AbjDSIGX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 04:06:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59BC719BF
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 01:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681891537;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eaSWM1p/1F2OsyeRmKVT5vjHT5ufcFeSlZRPaUZrx54=;
        b=Vfi/q66K4+Wx0IPUmOwKmiQUQJo/UV45kuYkWSaBIcZZaow+42QIRek3h1m2CGrrc2HR2B
        aK4OUe6gDpGT21UkGmdtGPDZO0q0aoWjYqFFT11vnUh3XcGmxYmpddSr1/T0w8iVvDH6iF
        CFOcoUG5bhzS8b++Dc/off3s2MFC0nA=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-356-MsAvmCrsPmmNyzUtzi58Yg-1; Wed, 19 Apr 2023 04:05:35 -0400
X-MC-Unique: MsAvmCrsPmmNyzUtzi58Yg-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2449eceadbfso3575021a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 01:05:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681891535; x=1684483535;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eaSWM1p/1F2OsyeRmKVT5vjHT5ufcFeSlZRPaUZrx54=;
        b=LFF8dz7WNzCCU/QrS7aBwX6olAEyrdSBCmKH39PSORZMchP/skPPNmBEci7rNWXWHB
         uPt37mHlxRvsWLQ/47dyO7hcASgzY6RFL/uyn7ivxa5pF0axdAl9pSuniFq+KzdxmGa3
         kJaolgFGRDP5mWui1UcNfsdDa0JBZr46Q4lxHgafO3FCYiGJW46pP5JhPN+7q2rNO9aT
         eL3BqU/PsFgpK/QyPHwxS/YteJJqtsoDIKW3s3udbIq6MiS2gxETJPy3+a3+UFJmNLJz
         HOxQMBWsQuGvBTx6CPW7UteUxW+KuGMhK76YmJvgyKPjqCAbpjfgD6ru4ZaiOKUR1mqL
         GLCA==
X-Gm-Message-State: AAQBX9e61kADpOZfHRHYSnEWzPHqg10OYu/Kfhrz5NBV1KP+owK6Pcx8
        bL1Dqal1ZcHN/Tzo5CZhpvg+Ac8gYrxHSMnRAjV0qK6n9QoA9ubXaQyPyBs9KkomEAsWFTHf7jK
        UGpWY0h5MA+AIbP6DSVSuPj9TYGV11esNOu3tVYva
X-Received: by 2002:a17:90a:fe86:b0:233:f393:f6cd with SMTP id co6-20020a17090afe8600b00233f393f6cdmr2240620pjb.5.1681891534859;
        Wed, 19 Apr 2023 01:05:34 -0700 (PDT)
X-Google-Smtp-Source: AKy350Zc6e9mxsrb5Vm/dQ5S7WTiVHDZ6r+CiglqnHJTOYDcdSZpa33HrUd9uLCOAU+gvh4WW/4NBNRuoAd+QSrZ0AU=
X-Received: by 2002:a17:90a:fe86:b0:233:f393:f6cd with SMTP id
 co6-20020a17090afe8600b00233f393f6cdmr2240601pjb.5.1681891534406; Wed, 19 Apr
 2023 01:05:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230419072736.172593-2-haifeng.xu@shopee.com>
In-Reply-To: <20230419072736.172593-2-haifeng.xu@shopee.com>
From:   Miklos Szeredi <mszeredi@redhat.com>
Date:   Wed, 19 Apr 2023 10:05:23 +0200
Message-ID: <CAOssrKfCiByavRNekRUOCv==AEvWAO6B6=tAASyYdvWj9XRhBw@mail.gmail.com>
Subject: Re: [PATCH 2/2] vfs: clean up d_backing_inode() function
To:     Haifeng Xu <haifeng.xu@shopee.com>
Cc:     viro@zeniv.linux.org.uk, bigeasy@linutronix.de, mcgrof@kernel.org,
        xiubli@redhat.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If we are touching that function, I'd just get rid of it completely
(s/d_backing_inode/d_inode/).

Thanks,
Miklos

On Wed, Apr 19, 2023 at 9:27=E2=80=AFAM Haifeng Xu <haifeng.xu@shopee.com> =
wrote:
>
> Using an extra variable to record the inode is unnecessary, return it
> directly.
>
> Signed-off-by: Haifeng Xu <haifeng.xu@shopee.com>
> ---
>  include/linux/dcache.h | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/include/linux/dcache.h b/include/linux/dcache.h
> index 13023c7211d6..97324b6434e5 100644
> --- a/include/linux/dcache.h
> +++ b/include/linux/dcache.h
> @@ -540,9 +540,7 @@ static inline struct inode *d_inode_rcu(const struct =
dentry *dentry)
>   */
>  static inline struct inode *d_backing_inode(const struct dentry *upper)
>  {
> -       struct inode *inode =3D upper->d_inode;
> -
> -       return inode;
> +       return upper->d_inode;
>  }
>
>  /**
> --
> 2.25.1
>

