Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B54E654548
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 17:42:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230156AbiLVQmK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 11:42:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbiLVQmH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 11:42:07 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9A7D27B0F
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 08:41:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671727292;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hMRqi31Tqol4IzcTAzBEdalwd4Hn1qAFrUhcqZ6OmAI=;
        b=FM43rFyMqmnOhK0f9bgyiydjDZwwrtT17PhRnYQFzwwiNK0SrUb8EL5hbD6Lt4oC71lewq
        bItdWP23a15Ij8/kCBKV/G0ZiwqPMoA7jSKBdO5F6+e9BGkdYYPDgxw2Vim38yNwFACRD7
        KVi4LfRgXhyBcRBrw+XwU3a2ZUOdRv8=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-9-wo2tnM8_PWOUibrNKcDkgw-1; Thu, 22 Dec 2022 11:41:30 -0500
X-MC-Unique: wo2tnM8_PWOUibrNKcDkgw-1
Received: by mail-qk1-f198.google.com with SMTP id ay34-20020a05620a17a200b00704bd9922c4so1300411qkb.12
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 08:41:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hMRqi31Tqol4IzcTAzBEdalwd4Hn1qAFrUhcqZ6OmAI=;
        b=2BfjoMt72aw9vPx2FDD5uYtqZMn1/4fNVZ82W9aOFb/hLCybR5XcSofawrATtak+bD
         47XJYtN8oNTt/Sw3RxACO+AVHBpudt+O5VmWtEhwQdYA6iLQDAfM8ZNdX8cXm63omQe/
         hirQzDJGYwjAFmkxPgn+K47uIyFd1dt0fyHyNh6oJjhEcU6fW6olmgK/v6oe/upRT4y5
         3DBNL5hIQwpH68BSikV9yibBLy/oWlS7gon7GLRQjGJv12sCiu4gwOvcNBKsagIRXFL2
         LoCb0xfu0UvYtCMOoy5AggMCmWOZSzRqoUtzZpIEuZVXLONR2T/kvfWhdq8HJGP9/wWS
         9VuA==
X-Gm-Message-State: AFqh2kr1HB1yXki0X4tDzUjFOvpUzwhuflu62zFf+oHpnM1tEgzYaOBO
        Cb9GD+BWuMXniqF9jKcCLgAv8ONWXvFYSBLqvczRhBIn3d9Un4Jb7ibDYo9O3blMI1yNmrRuern
        uajvCUOi64z+2OcxtWl0Rke/U67PFxFfsAVTE4MqE
X-Received: by 2002:a05:622a:5a85:b0:3ab:6bd6:d3bb with SMTP id fz5-20020a05622a5a8500b003ab6bd6d3bbmr32432qtb.6.1671727290157;
        Thu, 22 Dec 2022 08:41:30 -0800 (PST)
X-Google-Smtp-Source: AMrXdXtU2c1hlxcX3Ck+PUFWKZ3UCy5nPMxNKtznQaBCbs9iknGz+DTooceAgmQTuj3jd6OqthXsh+GlwW9480/ta3M=
X-Received: by 2002:a05:622a:5a85:b0:3ab:6bd6:d3bb with SMTP id
 fz5-20020a05622a5a8500b003ab6bd6d3bbmr32425qtb.6.1671727289960; Thu, 22 Dec
 2022 08:41:29 -0800 (PST)
MIME-Version: 1.0
References: <20221221224111.19254-1-vdronov@redhat.com> <20221221224111.19254-3-vdronov@redhat.com>
 <Y6OXuT95MlkNanSR@sol.localdomain>
In-Reply-To: <Y6OXuT95MlkNanSR@sol.localdomain>
From:   Vladis Dronov <vdronov@redhat.com>
Date:   Thu, 22 Dec 2022 17:41:18 +0100
Message-ID: <CAMusb+QuNN9bgWSFZnd_VVVie7uBdBOsn=Z+_k5RLv5F1QtPqQ@mail.gmail.com>
Subject: Re: [PATCH 2/6] crypto: xts - drop xts_check_key()
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     herbert@gondor.apana.org.au, davem@davemloft.net, nstange@suse.de,
        elliott@hpe.com, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, smueller@chronox.de
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Dec 22, 2022 at 12:33 AM Eric Biggers <ebiggers@kernel.org> wrote:
>
> On Wed, Dec 21, 2022 at 11:41:07PM +0100, Vladis Dronov wrote:
> ...skip...
> > -     /* ensure that the AES and tweak key are not identical */
> > +     /* ensure that the AES and tweak key are not identical
> > +      * when in FIPS mode or the FORBID_WEAK_KEYS flag is set.
> > +      */
> >       if ((fips_enabled || (crypto_skcipher_get_flags(tfm) &
> >                             CRYPTO_TFM_REQ_FORBID_WEAK_KEYS)) &&
> >           !crypto_memneq(key, key + (keylen / 2), keylen / 2))
>
> Please use the kernel style for block comments:
>
>         /*
>          * Ensure that the AES and tweak key are not identical when in FIPS mode
>          * or the FORBID_WEAK_KEYS flag is set.
>          */

Thanks Eric, I will wait a bit for more review notes and I will resend
the patchset.

Best regards,
Vladis

