Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AE6B704302
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 03:41:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbjEPBlv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 21:41:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbjEPBlt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 21:41:49 -0400
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C5CBE76
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 18:41:48 -0700 (PDT)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-18b1c643219so5616562fac.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 18:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684201307; x=1686793307;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vOedSJ17V8iHt8KHOe3xnYUuoXUkebVLJNVs3KstdqI=;
        b=aUHNG7WIgh65aeOq/mwYfz+62LGweoGA/GHSVSaepQsF8GDMGY5iN4EV+lDiTkP6Gy
         UGEVeUcU8hw6rh9Sg2yz0hySRiFvwpx4o19DT9lRfptAnEOo0IzYBnrqHN5w6hTXv8jw
         Xk4owUbp1ktPr+cFzASk8e8UJl+jWZO2bkRWk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684201307; x=1686793307;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vOedSJ17V8iHt8KHOe3xnYUuoXUkebVLJNVs3KstdqI=;
        b=WYRAZzUD5wL3+ERb8HFpZO83VDK1ilFHsf48D3UJ3GFvn0Ox0SC4+iXzfeYP6SUkwZ
         iGM097B38q7NJOIHoath0AZ69LBop17hkJ4Rv2Q3a74F+rke3ozbByjcVqR0plEnsudY
         7SU2zKP0Ar01mbWMbM6CTTSdImuewiIWy5PrRXFISiyrMICdmM/6eES4HBSuEKib7Xqj
         UA4+iATu5hzBHXchjCgzhNMj0aJBoLh0fF0W55MHo37pgGqovhsP0V19o5jNvKwq4KXb
         9Tm4HiE1d+wkRyXcosk2WG2SOntiGQ7anSZGWEjFl7EynaQypByEDV0X5OqmlO2tL3OV
         FUEw==
X-Gm-Message-State: AC+VfDwAyjdyFWLVQZwKbZZTzWOgy7qdc+o0N3YwLp0UgsGuFmHar8Np
        vb8iJGAVkraEOajwl8sEmBBZp2iuhZbqffWlgJbA3w==
X-Google-Smtp-Source: ACHHUZ6rcT//gO0BfDl+K3mf6a3mSdpI7F1kSMtj1wRAbxCuSDTjM4Co5wJy7waK4krsWK3J03Yy/z+tGlWnJZuPMCs=
X-Received: by 2002:a05:6870:e14e:b0:196:8dc3:4e16 with SMTP id
 z14-20020a056870e14e00b001968dc34e16mr5220391oaa.39.1684201306869; Mon, 15
 May 2023 18:41:46 -0700 (PDT)
MIME-Version: 1.0
References: <CABi2SkXjN+5iFoBhxk71t3cmunTk-s=rB4T7qo0UQRh17s49PQ@mail.gmail.com>
In-Reply-To: <CABi2SkXjN+5iFoBhxk71t3cmunTk-s=rB4T7qo0UQRh17s49PQ@mail.gmail.com>
From:   Jeff Xu <jeffxu@chromium.org>
Date:   Mon, 15 May 2023 18:41:35 -0700
Message-ID: <CABi2SkUfsOWKGdFqgXZg=0AcnUj=AOFb9JmYfp=RwDp_5AcH0Q@mail.gmail.com>
Subject: Re: mprotect outbound check.
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, linux-hardening@vger.kernel.org,
        Jorge Lucangeli Obes <jorgelo@chromium.org>,
        lstoakes@gmail.com, Liam.Howlett@oracle.com, peterx@redhat.com,
        zhangpeng.00@bytedance.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ Peter, Lian, Lorenzo

Is this related to this hotfix ?
      mm/mprotect: fix do_mprotect_pkey() return on error


Thanks!

-Jeff






On Mon, May 15, 2023 at 11:00=E2=80=AFAM Jeff Xu <jeffxu@chromium.org> wrot=
e:
>
> Noticed there is a slight change for mprotect between 6.1 and 6.4 RC1
>
> For example:
> Consider the case below:
> 1 mmap(0x5000000, PAGE_SIZE,  ...)
> 2 mprotect(0x5000000, PAGE_SIZE*4, ...)
>
> in 6.1 and before, 2 will fail, and in 6.4 RC1, it will pass.
>
> I know that munmap will accept out-of-bound cases like this (because
> memory is freed anyway).
>
> Is this change intentional ?
>
> Thanks!
> Best regards,
> -Jeff
