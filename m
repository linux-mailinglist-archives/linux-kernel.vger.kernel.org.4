Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6B176CC8E4
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 19:12:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229525AbjC1RMs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 13:12:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjC1RMq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 13:12:46 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A3C09750
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 10:12:44 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-5456249756bso242458017b3.5
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 10:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680023563;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PbNlEte7WMbmZc6PNi2hN6381AIGaQueRvLWr852tYk=;
        b=hGcLW+xd5490BDPJ/p03Anuj876RlSmx7zN13qOmso06WFk2oeF3Z2U7ElD5onoAIm
         PSnG2CnS1jEHm4+6KVVUvbh2Gi74u7nOYs9i9wDwSmUMaJd6XerTa2p9mO3nPeRWmJ1x
         kPSkVTLcoNGt4iO+cvbWHzR6Rzp5S8e/kglowo6Y+We1xYOvSpLE587jkRm97kvxM5w4
         GcPp+mRmMRE3eIsG9kTldxK3q95+Emh7FM1jK02fFuxHr6iU8JWiKU1s9biPFqrbmqdO
         jWDiGaSUUda69BGHJ5d5JKoDyRJFsy7SL3D8pCYq3E+9CIkrgVJWTBiWuhaUCMg1KiSY
         SuqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680023563;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PbNlEte7WMbmZc6PNi2hN6381AIGaQueRvLWr852tYk=;
        b=DaYkTADiTpJ/5ro//YntF0PCRgC2H221VhkGj3Ami6G6MROkcLOIZShzoUOJ37v6DP
         d7H45PW+lT5dkKbUD7kVJ8PxXdeeMieR2OAn61dKyfVYC8rOVzDUM9lV2rb5Vr4R3c6G
         l6pqfNaBkpusIvV7/PI2cJd2vxst39tGXYzjD9J6RR6afKg5drtnnkFCbe0edlTMjN72
         4Jg2/WZqtx7ye2R+lBCmimnbFCQ37STUoWuaXEYBypyCLT7Rg7717yMsYBuvmXozEBDt
         xrAE7+d9Q4G+FB2yIe+pBHozJWW49RUhGQ7keE5w4CeJwJ5wpDYqriZ6BdH4x7sDuCEm
         /RZw==
X-Gm-Message-State: AAQBX9fI/gpTAxT5jSZF8AoB0yo4nPkbAE+77+WZ7gmLWEAPVFMgaeYN
        qRdmFvPQVtpzhj4OWwk3s+aL0GaadvuoVChnTCRnyQ==
X-Google-Smtp-Source: AKy350bFaBtEkhs/Q734XnSZoEzi2GmilGfdhaKEyLnDFyrn9pan2V0E1H+rbZ9emo1clHbanpioAtt3rLbMgI+rvEc=
X-Received: by 2002:a81:d44d:0:b0:545:f7cb:f3ad with SMTP id
 g13-20020a81d44d000000b00545f7cbf3admr3214498ywl.10.1680023563419; Tue, 28
 Mar 2023 10:12:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230306224127.1689967-1-vipinsh@google.com> <20230306224127.1689967-13-vipinsh@google.com>
 <ZBzPeETL7/R1Qwwe@google.com>
In-Reply-To: <ZBzPeETL7/R1Qwwe@google.com>
From:   Vipin Sharma <vipinsh@google.com>
Date:   Tue, 28 Mar 2023 10:12:07 -0700
Message-ID: <CAHVum0f3F51Nu=vxP_qStp+DW+q9AOZKh4RQTrz-Jk-=T9CYnQ@mail.gmail.com>
Subject: Re: [Patch v4 12/18] KVM: x86/mmu: Allocate NUMA aware page tables on
 TDP huge page splits
To:     David Matlack <dmatlack@google.com>
Cc:     seanjc@google.com, pbonzini@redhat.com, bgardon@google.com,
        jmattson@google.com, mizhang@google.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 23, 2023 at 3:15=E2=80=AFPM David Matlack <dmatlack@google.com>=
 wrote:
>
> On Mon, Mar 06, 2023 at 02:41:21PM -0800, Vipin Sharma wrote:
> > +
> > +void *kvm_mmu_get_free_page(gfp_t gfp, int nid)
> > +{
> > +#ifdef CONFIG_NUMA
>
> Is this #ifdef necessary? alloc_pages_node() is defined regardless of
> CONFIG_NUMA.
>

It is not necessary. Only advantage will be skipping the if()
condition check. I will remove it.

> > +     struct page *page;
> > +
> > +     if (nid !=3D NUMA_NO_NODE) {
> > +             page =3D alloc_pages_node(nid, gfp, 0);
> > +             if (!page)
> > +                     return (void *)0;
> > +             return page_address(page);
> > +     }
> > +#endif /* CONFIG_NUMA */
> > +     return (void *)__get_free_page(gfp);
> > +}
> > +
