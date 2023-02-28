Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A8026A58D0
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 13:05:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231502AbjB1MFD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 07:05:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231543AbjB1ME6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 07:04:58 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DE112DE52
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 04:04:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677585854;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KCJidl22u1cKfAyMeW4PYXi3JfewoKCLf6JCBtPv+4E=;
        b=imXD55bt2Gev2i/p6DR6bULaPt8kaQ8CGOQuC/kI2EHs5iMUnSiTVfE6pNlqy2BEE809QJ
        ibgVYLZFzbpbKWGNd4IT3xKS8Vr3YesTjE71JKzcMhpfSBjfLyDDrUA4HoFoud5863mGIZ
        dUkj7xJVEONxt6D2YpkNODvp1R6roU0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-546-CVHzQ5ZkPQSowccCc1USbg-1; Tue, 28 Feb 2023 07:04:13 -0500
X-MC-Unique: CVHzQ5ZkPQSowccCc1USbg-1
Received: by mail-wm1-f72.google.com with SMTP id j6-20020a05600c1c0600b003eaf882cb85so4155319wms.9
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 04:04:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KCJidl22u1cKfAyMeW4PYXi3JfewoKCLf6JCBtPv+4E=;
        b=d0gfySyyHCW4lyYixe9cRUj/zTbu9TqKkylNjNeSszcs5V0ZwMMVSoWIran69S1emI
         msN40VUtfWSAc4kk13KF4MN/N1HknBO0sYwcLZFu54Fv77G3QE/ljhDl6yofmZi0dBLC
         Yr4zbxOW1Q6Z7FAXKrDdsVHhrECoNTHpU5nzXXcM7f4bnPkjXKMTN3P+LSzTPIEcvLp4
         urPTGVmAHnFLvrooZjnKSShMtLWgOa7hzsR4AP9sabdb+HM6Eb6jRLepvuo5MgcpFnOW
         O6LC3l03CVdc5Btgcnz/bWIgi2JWQeo6egIqY0oQGJ4k6NolkMRGtBbhokSBfDqLjihn
         9o0A==
X-Gm-Message-State: AO0yUKW7dNMeZ6imgGXYvJpmumwgWka+lotxlOA1mdxmzqrtsZeVDb29
        oKtgApSOMCCApHtRQq7wOmRQ6kkmylib8R1vLkBXJpF3x1jItBHQKH0y1MqkBd6Voh6Yaanf3e6
        0xaKCFH+ULxofdvr9zlr0f+jQ
X-Received: by 2002:a05:600c:35cc:b0:3ea:840c:e8ff with SMTP id r12-20020a05600c35cc00b003ea840ce8ffmr2220083wmq.3.1677585852441;
        Tue, 28 Feb 2023 04:04:12 -0800 (PST)
X-Google-Smtp-Source: AK7set+i4oLcSfX/DPlO4reXLr5cplrlWIwAVs7488OSTZEYMFEEjdYGmSLF3oxgzaF/YTdKk1RNSg==
X-Received: by 2002:a05:600c:35cc:b0:3ea:840c:e8ff with SMTP id r12-20020a05600c35cc00b003ea840ce8ffmr2220063wmq.3.1677585852119;
        Tue, 28 Feb 2023 04:04:12 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-121-8.dyn.eolo.it. [146.241.121.8])
        by smtp.gmail.com with ESMTPSA id l8-20020a05600c1d0800b003de2fc8214esm13242664wms.20.2023.02.28.04.04.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 04:04:11 -0800 (PST)
Message-ID: <85dae3d33c5b19b968313069c7c5342d688852b2.camel@redhat.com>
Subject: Re: [PATCH] sched: delete some api is not used
From:   Paolo Abeni <pabeni@redhat.com>
To:     lingfuyi <lingfuyi@126.com>, jhs@mojatatu.com, davem@davemloft.net
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        lingfuyi <lingfuyi@kylinos.cn>, k2ci <kernel-bot@kylinos.cn>
Date:   Tue, 28 Feb 2023 13:04:10 +0100
In-Reply-To: <20230228031241.1675263-1-lingfuyi@126.com>
References: <20230228031241.1675263-1-lingfuyi@126.com>
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

On Tue, 2023-02-28 at 11:12 +0800, lingfuyi wrote:
> From: lingfuyi <lingfuyi@kylinos.cn>
>=20
> fix compile errors like this:
> net/sched/cls_api.c:141:13: error: =E2=80=98tcf_exts_miss_cookie_base_des=
troy=E2=80=99
> defined but not used [-Werror=3Dunused-function]
>=20
> Reported-by: k2ci <kernel-bot@kylinos.cn>
> Signed-off-by: lingfuyi <lingfuyi@kylinos.cn>

This has been already addressed by:

commit 37e1f3acc339b28493eb3dad571c3f01b6af86f6
Author: Nathan Chancellor <nathan@kernel.org>
Date:   Fri Feb 24 11:18:49 2023 -0700

    net/sched: cls_api: Move call to tcf_exts_miss_cookie_base_destroy()

Thanks,

Paolo

