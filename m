Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 315CD705404
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 18:36:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231324AbjEPQgL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 12:36:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbjEPQgA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 12:36:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EA9AD040
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 09:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684254887;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=53NKQ5uw9SnRFMJTCe9LxwJTjXKaTTMdxaGXn1HcNvI=;
        b=SNMEPZwFFdN13UhiQ8O/WjGp85JyzlVIEVWFRt6xiM377HAZ7Colou0QxME4fxaDVuHbVT
        gfQvj8UdWbbrexoaFci7IAHD3H+wyZ3xxYZeoqleQARVFUNU2bq0bqucQuW/BCAulreikg
        jYlLyEiWQWvB9lWqGr9QnRiu++EZdbo=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-492-rwj2_qq2PIm4fpUGn_sxWQ-1; Tue, 16 May 2023 12:34:45 -0400
X-MC-Unique: rwj2_qq2PIm4fpUGn_sxWQ-1
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-3f387d3b41eso8749541cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 09:34:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684254885; x=1686846885;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=53NKQ5uw9SnRFMJTCe9LxwJTjXKaTTMdxaGXn1HcNvI=;
        b=in4oYC5HS9sDJADINGYkd3c8m9Nrmrutyp1la3+LfuOmuD3LZQkvDrHJHQ0Abr41Am
         5pSzRj/H1HTDsT69hSm2Jq63e9PYj0Csx0TSgXN8a3FRVUwRdPkYdX/NpCGvkE3PeH8G
         4JPdh4xkUhUDKdhyMsY4zhAYF6HjAb7kBjbGsmfDKLnp6yVuNLY2iqqOZRhtRp0EjLua
         H66wLBKlfPS06EU/KJrbDUknmehJ8Ay21n72/PqfAQaFB32gBAMDlyxCd8tf5g8hnrwB
         k4rn2Ph1Y6FtKX7A19Yed6DCiQnXZijrxT1/lUlCrzY+PyTg+Kc/iaj9R7hYPEgk9UGO
         ez4w==
X-Gm-Message-State: AC+VfDwKbIz5xFg7/EjmeEhj37aSdMi8ADPkmKHLnXzVSWiu8YqIP/wV
        eUnCDPkgFc/hSiDN+CXoc/jX4u+MAWGM7uE2PxueeeYhP2Ir9f+QYhiDNHQJ3S1bNzfgieniQRU
        8GdULc73wfSEkvm/WzNrb7SCNbdkTWaFg
X-Received: by 2002:a05:622a:1883:b0:3ef:3912:ab3e with SMTP id v3-20020a05622a188300b003ef3912ab3emr241899qtc.2.1684254884939;
        Tue, 16 May 2023 09:34:44 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ45k6UsYhy0Q1O9scbqGvnXiic8Hnt7VxHTJtSYtfcme6kIxey26s7vFgM/LTlqpcCOXk5E4g==
X-Received: by 2002:a05:622a:1883:b0:3ef:3912:ab3e with SMTP id v3-20020a05622a188300b003ef3912ab3emr241870qtc.2.1684254884693;
        Tue, 16 May 2023 09:34:44 -0700 (PDT)
Received: from x1n (bras-base-aurron9127w-grc-62-70-24-86-62.dsl.bell.ca. [70.24.86.62])
        by smtp.gmail.com with ESMTPSA id d28-20020ac84e3c000000b003dd8ad765dcsm6336150qtw.76.2023.05.16.09.34.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 09:34:44 -0700 (PDT)
Date:   Tue, 16 May 2023 12:34:42 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Jeff Xu <jeffxu@chromium.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, linux-hardening@vger.kernel.org,
        Jorge Lucangeli Obes <jorgelo@chromium.org>,
        lstoakes@gmail.com, Liam.Howlett@oracle.com,
        zhangpeng.00@bytedance.com
Subject: Re: mprotect outbound check.
Message-ID: <ZGOworXBstm+jmw3@x1n>
References: <CABi2SkXjN+5iFoBhxk71t3cmunTk-s=rB4T7qo0UQRh17s49PQ@mail.gmail.com>
 <CABi2SkUfsOWKGdFqgXZg=0AcnUj=AOFb9JmYfp=RwDp_5AcH0Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABi2SkUfsOWKGdFqgXZg=0AcnUj=AOFb9JmYfp=RwDp_5AcH0Q@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 15, 2023 at 06:41:35PM -0700, Jeff Xu wrote:
> + Peter, Lian, Lorenzo
> 
> Is this related to this hotfix ?
>       mm/mprotect: fix do_mprotect_pkey() return on error

Doesn't look like to me, that seems to only avoid replacing an error with
another error, rather than stop returning error for any case.

AFAIU this shouldn't be intentional, but Liam could correct.  Maybe a
bisection would show at least when it got changed?

> 
> 
> Thanks!
> 
> -Jeff
> 
> 
> 
> 
> 
> 
> On Mon, May 15, 2023 at 11:00 AM Jeff Xu <jeffxu@chromium.org> wrote:
> >
> > Noticed there is a slight change for mprotect between 6.1 and 6.4 RC1
> >
> > For example:
> > Consider the case below:
> > 1 mmap(0x5000000, PAGE_SIZE,  ...)
> > 2 mprotect(0x5000000, PAGE_SIZE*4, ...)
> >
> > in 6.1 and before, 2 will fail, and in 6.4 RC1, it will pass.
> >
> > I know that munmap will accept out-of-bound cases like this (because
> > memory is freed anyway).
> >
> > Is this change intentional ?
> >
> > Thanks!
> > Best regards,
> > -Jeff
> 

-- 
Peter Xu

