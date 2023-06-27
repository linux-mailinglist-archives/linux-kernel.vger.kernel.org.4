Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4304973F122
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 05:05:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbjF0DFI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 23:05:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230271AbjF0DFE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 23:05:04 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93A2CED
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 20:05:02 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id d75a77b69052e-401d1d967beso138441cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 20:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687835101; x=1690427101;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Udfkb7SVUpoKn3jnskw7T04Cur4Mk4q30DewKVsVPBw=;
        b=7dXkce0taLND+PJoW+Jbed5b0GMFVghZW9QTkNtQ/meQQ+G4/JcOxPI9Kz0HTIpUjJ
         DVPqS8EWIMWDNLQb9jkhcv0ZsAV/EK12K1no2eVRvJkp1/XJsLCtTp+lt5ximqKd3QcA
         O/4FOzC2WA2gGIIWEdtacwm2FXxfG0SQAhL3dtnCVqkZxjmSj6j+j9svH7NJ0A6Nj9Rb
         jKGMzazG69HvNtEOmK94lVQRbs31Ue4JFIlJhwIOy1XZl8cJtEk1tGxwOUPkGV61Icm6
         b01rBLpfsO2BiVCGWGTplTaE03Ks9gzUEE9/yTs/Jw+v/FzXpBLgUpA5jsREDvfG7KVe
         F4+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687835101; x=1690427101;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Udfkb7SVUpoKn3jnskw7T04Cur4Mk4q30DewKVsVPBw=;
        b=DVGKcAsGP2VSscWmfUshUz3j5hkuS3uTMoLgCsJoJusJhJOKqsIPIZhM1eMk8HadmT
         MSm+d0ANNZ5o8A1l7TsN16U2MdmApUL+YKdy3DLCcXZrDdHs8AdIQkls/zMBvVs8jBaf
         W9VWJXCi7S1FXLdd1bfg5T8zDgf1JO6FxQ/tCzKY7OSLlmLmvXEeSblpzPcimP913Z8V
         tl25eJnTS1MjtUF31tXI0tYoAs7AV8223pgz5eGRk3K3zSwOLisfAIty6Zc/+i+hajHN
         SZaNMG63jWt5WU0C50jV55YLdcgjzN55+Tnv3b6mnfrvuKa1yLKyHOms5nAUnfLXbYuU
         nyGg==
X-Gm-Message-State: AC+VfDzdWzWD0StpnKOwYC/rkRjPxN3GirKgMN0Mmunnn1AYAnicS+t1
        /o4fdU2C9ZkP3GSy23UOp+kGJaQKU3ex92FFhycPbQ==
X-Google-Smtp-Source: ACHHUZ6aOgvPbYHnS1BNpa8jCA1x3qA5T/74s8rMt4G/rjNue/yoRJoe9/AmYeGifNbUrQ7LDjo+Du5iRcRAq+DY/jI=
X-Received: by 2002:a05:622a:1014:b0:3ed:210b:e698 with SMTP id
 d20-20020a05622a101400b003ed210be698mr71765qte.7.1687835101534; Mon, 26 Jun
 2023 20:05:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230626171430.3167004-1-ryan.roberts@arm.com> <20230626171430.3167004-8-ryan.roberts@arm.com>
In-Reply-To: <20230626171430.3167004-8-ryan.roberts@arm.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Mon, 26 Jun 2023 21:04:25 -0600
Message-ID: <CAOUHufbhVM-+zMUvHy0zeTb1ZFnDWnvD+=f6v9YxNJ_h5bjaRw@mail.gmail.com>
Subject: Re: [PATCH v1 07/10] mm: Batch-zap large anonymous folio PTE mappings
To:     Ryan Roberts <ryan.roberts@arm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Yin Fengwei <fengwei.yin@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-alpha@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-s390@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 26, 2023 at 11:15=E2=80=AFAM Ryan Roberts <ryan.roberts@arm.com=
> wrote:
>
> This allows batching the rmap removal with folio_remove_rmap_range(),
> which means we avoid spuriously adding a partially unmapped folio to the
> deferrred split queue in the common case, which reduces split queue lock
> contention.
>
> Previously each page was removed from the rmap individually with
> page_remove_rmap(). If the first page belonged to a large folio, this
> would cause page_remove_rmap() to conclude that the folio was now
> partially mapped and add the folio to the deferred split queue. But
> subsequent calls would cause the folio to become fully unmapped, meaning
> there is no value to adding it to the split queue.
>
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> ---
>  mm/memory.c | 119 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 119 insertions(+)

We don't really need this patch for the series to work. So again, I'd
split it out.
