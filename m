Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0848569DD0A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 10:39:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233965AbjBUJjs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 04:39:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233985AbjBUJjp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 04:39:45 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97CDC2448D
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 01:38:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676972338;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=T373vQv/bScNDxJBPlPsndv81C2bk1FJ2KP5pg5qs/Y=;
        b=e07k5uclJjEfNEdvv9ao4d6rLvlBakLPL0FrKZ4Pn9qGPEh0LgK5UwM4CkliqJQ+w6GZOO
        CRUflqomUQ92N9GGjdFqFea9MNb3LUnmOHOzfRct7+P/9wBnveaZ5UJM6NFqOqeSUPzPWO
        XmldxTimxObG+Z7Hktw2fJdiYc2m4Pc=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-474-Y0hBm0jHOf6vNHZkGruFmQ-1; Tue, 21 Feb 2023 04:38:57 -0500
X-MC-Unique: Y0hBm0jHOf6vNHZkGruFmQ-1
Received: by mail-qk1-f199.google.com with SMTP id y1-20020a05620a09c100b0070630ecfd9bso1620189qky.20
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 01:38:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T373vQv/bScNDxJBPlPsndv81C2bk1FJ2KP5pg5qs/Y=;
        b=BRQB/FgcRg/thO4o5XoG3/eDqxKNCx6TatmuMzgdRnUHvldM2e8gZqq1oeb5FhRQ5i
         CfVDWFaC/z/DCTdmFF+5oQX9IRZKW7tUf3+yGocPqiZ/Bv9Q5Zg1EZ0x44S6wABQW8aa
         ZIri65y7nATMNKuwpKD7Wy4crU/JC4mY8AbcZ744wSNhRfSyKCf3TPFRUD1CR5fXdfbw
         pne2PrFtTmYrySpgzr6iZmMDT8+/hyYVOwgJQ8iuKJI12pgCQe1ZBouMq+LI7vFipIB8
         s0ARY1PZ6vCsP9OYbiA/Atj0OW1deQUA0v3QaU9cmoVFSOQSmI3A0Ekv+BP+lyyX+unm
         JMkg==
X-Gm-Message-State: AO0yUKWN2wPZxB1RV5qS8bMNQh9KGMVSy1V6eA6nRgUsdd+CcqcfOVB1
        Zt93mDLVqyM+1Hd01sEyWrGdXemfP1i4yHmpu01TfP43RSDapTPPKEyWXtcGH+CB0kVJhQ2DBEt
        FY+t6uYYE28okmsEGq/VEBzlr
X-Received: by 2002:a05:622a:1a92:b0:3b6:309e:dfe1 with SMTP id s18-20020a05622a1a9200b003b6309edfe1mr8968770qtc.3.1676972337086;
        Tue, 21 Feb 2023 01:38:57 -0800 (PST)
X-Google-Smtp-Source: AK7set+p6Xvxm9V7AIYXQkW1fmOdaYaqQP1z96A/mL/2xugaW5HkHIJ/25vUgMZC9XoU5je+Jxh5mA==
X-Received: by 2002:a05:622a:1a92:b0:3b6:309e:dfe1 with SMTP id s18-20020a05622a1a9200b003b6309edfe1mr8968754qtc.3.1676972336798;
        Tue, 21 Feb 2023 01:38:56 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-121-8.dyn.eolo.it. [146.241.121.8])
        by smtp.gmail.com with ESMTPSA id x191-20020a3763c8000000b007402fdda195sm2837520qkb.123.2023.02.21.01.38.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Feb 2023 01:38:56 -0800 (PST)
Message-ID: <35332e079ffea4cc91a4d21fdbf9d2ba244ac203.camel@redhat.com>
Subject: Re: [PATCH v2] bnx2: remove deadcode in bnx2_init_cpus()
From:   Paolo Abeni <pabeni@redhat.com>
To:     Maxim Korotkov <korotkov.maxim.s@gmail.com>,
        Rasesh Mody <rmody@marvell.com>
Cc:     GR-Linux-NIC-Dev@marvell.com,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Michael Chan <mchan@broadcom.com>,
        Vadim Fedorenko <vadim.fedorenko@linux.dev>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        lvc-project@linuxtesting.org
Date:   Tue, 21 Feb 2023 10:38:52 +0100
In-Reply-To: <20230219152225.3339-1-korotkov.maxim.s@gmail.com>
References: <20230219152225.3339-1-korotkov.maxim.s@gmail.com>
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

On Sun, 2023-02-19 at 18:22 +0300, Maxim Korotkov wrote:
> The load_cpu_fw function has no error return code
> and always returns zero. Checking the value returned by
> this function does not make sense.
> As a result, bnx2_init_cpus() will also return only zero
> Therefore, it will be safe to change the type of functions
> to void and remove checking
>=20
> Found by Security Code and Linux Verification
> Center (linuxtesting.org) with SVACE
>=20
> Fixes: 57579f7629a3 ("bnx2: Use request_firmware()")
> Signed-off-by: Maxim Korotkov <korotkov.maxim.s@gmail.com>

I agree with Vadim, this looks like net-next material.

The net-next tree is currently closed. Please re-post when net-next re-
opens, in ~2 weeks, with the Fixes tag stripped.

Thanks!

Paolo

