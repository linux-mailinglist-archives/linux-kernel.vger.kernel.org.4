Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C7677207AE
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 18:35:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236634AbjFBQfs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 12:35:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235350AbjFBQfp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 12:35:45 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A1E7B6
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 09:35:45 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id e9e14a558f8ab-33bf12b5fb5so114305ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jun 2023 09:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685723744; x=1688315744;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eL/RdfyvK4VHp5q8idUxK6LQ2FtGlS/ZCzpuZxH0Kr4=;
        b=U0K2SertVzjMjsq1mX8Q/Agt5nHLaEwoFNNH8N1Wlm8M0uFXbdDKASjMkLx/xaBuVG
         6IZ/XqhNtha76hmPs6PyclkP/DjtIULydrKkfEui4e3FarIvZyiU4mTjtvI+sDCEDA7p
         HC9FsVW7pusUaXJqes+HN0omNgRliN7khyr/fCFdHUkzynQTiv5dFuPQSDi7zkUaWKvy
         CA/QJW/xjLroJy3+My4d/5yesIP6UL+1FugGpUghsaBWHP2/Wz4KeztPNw5p1cYzzQjN
         TwOVG/bWKKUM2/4qTk90r1qPZuaed838+byuz/NehufvS0ipckD4U7et6gsJAcUD0SGw
         Aqtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685723744; x=1688315744;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eL/RdfyvK4VHp5q8idUxK6LQ2FtGlS/ZCzpuZxH0Kr4=;
        b=g2oP3jOCkNJYGTwcjSJNFnazEQe+I4ErVfkUj9ha+oChtVS0vlOFakdbTytkNG3FZX
         Koapt6l3otqgre6HKAbIWczrCYo60mSSbIeEB2gSYwiWI0v9PFQWGCpDG2Vrm+Hyv5H0
         xo3rHwWfwYlwtxzbqZPyEpSxfHvnDUROOLK0DQmWLxSaAJfpXf17SgYL87S497X72PA4
         VQwtb1prToruh7qQEcnJnu7BL7LGRBrMx9307g+2YuPgMgmD8S/7pcuoF/N1VzjK62WV
         GPiEkjt6zYJshaGogTT82N6przRh2lAf6tDDqbz+wnRmP2mkCvxxZFFrGvxeLbiGc0ia
         JCcQ==
X-Gm-Message-State: AC+VfDxbLANdQqe6bLBn4QMC0iE35M5UBGdvqldvNtHOYSIEkQU/WbVz
        QFw1jv8sfl8MWxSNIS5d2LzloH53m9tVuWd5CjdIzg==
X-Google-Smtp-Source: ACHHUZ7ERgLN87OyVJ5v5qBuR+nHPPKkYRfhwnOpN7C6Yk5dRXLnWBC8tclNySFapi7wnkNriSpvL6a7GG5gbcJ1rhM=
X-Received: by 2002:a05:6e02:1886:b0:33a:e716:a76f with SMTP id
 o6-20020a056e02188600b0033ae716a76fmr197727ilu.29.1685723744342; Fri, 02 Jun
 2023 09:35:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230602092949.545577-1-ryan.roberts@arm.com> <20230602092949.545577-3-ryan.roberts@arm.com>
In-Reply-To: <20230602092949.545577-3-ryan.roberts@arm.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Fri, 2 Jun 2023 10:35:08 -0600
Message-ID: <CAOUHufb5R_+eMxM28WWxXubPzUO4+c_1UHoXVAcWsKEyG1ndAQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] mm/damon/ops-common: atomically test and clear
 young on ptes and pmds
To:     Ryan Roberts <ryan.roberts@arm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        SeongJae Park <sj@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Uladzislau Rezki <urezki@gmail.com>, Zi Yan <ziy@nvidia.com>,
        Mike Rapoport <rppt@kernel.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, damon@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 2, 2023 at 3:30=E2=80=AFAM Ryan Roberts <ryan.roberts@arm.com> =
wrote:
>
> It is racy to non-atomically read a pte, then clear the young bit, then
> write it back as this could discard dirty information. Further, it is
> bad practice to directly set a pte entry within a table. Instead
> clearing young must go through the arch-provided helper,
> ptep_test_and_clear_young() to ensure it is modified atomically and to
> give the arch code visibility and allow it to check (and potentially
> modify) the operation.
>
> Fixes: 3f49584b262c ("mm/damon: implement primitives for the virtual memo=
ry address spaces").

Just to double check: was "Cc: stable@vger.kernel.org" overlooked or
deemed unnecessary?

> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> Reviewed-by: Zi Yan <ziy@nvidia.com>
> Reviewed-by: SeongJae Park <sj@kernel.org>
> Reviewed-by: Mike Rapoport (IBM) <rppt@kernel.org>
