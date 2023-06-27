Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F28A073F0FB
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 04:55:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbjF0Czh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 22:55:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjF0Czc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 22:55:32 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 725CF19A1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 19:55:31 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id d75a77b69052e-401d1d967beso136301cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 19:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687834530; x=1690426530;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K6m+wEFcEkBY8kPY3Kx1wllLpYaRIsGxbOUyAAHvddU=;
        b=ExOjo+32OkxgczlDHvAA93Sbizsv21cvgNnqKyveTvbuoZMVxqcmZEgPgSllcehguu
         dbX+ENH+6Ay2FKPsfQQPRgwk9gig7UN/Bqn5dy0/3Lt52aEGpC6a0CWZuDlLqxGVuynQ
         ePD+CMarbkoMLKhi58XFMsuv2TxpZMqD4UY8o5PNiJT66wQAkDvlNiFFn0BYTqgMvXPt
         9NcqlCm40PM9effdAviY9KeE8HRGVu4E/rigBJg7RATr+OyC7hI4fz3nHHxtdPodsK9Y
         PNjY12fUxpUwZPWspB5JgiUTyLdHqVtoy8OZEW6quF96sK7Xy1kFz342QD8ZJJbxbPpN
         +zpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687834530; x=1690426530;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K6m+wEFcEkBY8kPY3Kx1wllLpYaRIsGxbOUyAAHvddU=;
        b=GYEkHHHyYE+sBbgKkaOcWW6BK2YeMKYixksHiwtlnSK9ADHqTxDPsrxJ0PzyPbiQNx
         O8JGvWoIXdJQq54nsuXJ9pS1SG6daBsk7BeSop3iax3dPmApHvanr+gsOKE6pR6+yhAP
         sKiEdmClP+i0kEwnmepJ+V7zAJzZOtQ0uN/Sc3g4FS2XFDz4K1cFt6vTkmGpaGAqINkZ
         zXjkIETkQ9qKFoSmwug4lfx6M7zTk1cPg5oFFpt4SdA4JDAnRen4UEn04qYitn9EpbQ2
         mSpPP+IjCWhxVJ/CxBg63W7qyy9GIp47XxRmimZrF+xsvIaOf908F5Su1SvC6Sc/9O/Y
         YpJw==
X-Gm-Message-State: AC+VfDwZfhftNqo6DM+Bd1T0BD9xwXB65kYYboUGqfBlnUzp3AS2Yga/
        6HKPAY82gfVmk3WRb/vw3nqlVTSbrqQ7DwDRfHerZg==
X-Google-Smtp-Source: ACHHUZ4HHpDDlpCkNylVwPD6Vtl3Tw7Wkd/6GWnr7BTs/XNVIfH6MktIHos0KxldS43iWx3GtWhQNV7SWLRv/Puj8+4=
X-Received: by 2002:a05:622a:d1:b0:3f0:af20:1a37 with SMTP id
 p17-20020a05622a00d100b003f0af201a37mr70012qtw.15.1687834530512; Mon, 26 Jun
 2023 19:55:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230626171430.3167004-1-ryan.roberts@arm.com> <20230626171430.3167004-7-ryan.roberts@arm.com>
In-Reply-To: <20230626171430.3167004-7-ryan.roberts@arm.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Mon, 26 Jun 2023 20:54:54 -0600
Message-ID: <CAOUHufYBSc=RKpPg4PuHduJiWKOe+vpA_rZVo-9-gFvVue0huQ@mail.gmail.com>
Subject: Re: [PATCH v1 06/10] mm: Allow deferred splitting of arbitrary large
 anon folios
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
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 26, 2023 at 11:15=E2=80=AFAM Ryan Roberts <ryan.roberts@arm.com=
> wrote:
>
> With the introduction of large folios for anonymous memory, we would
> like to be able to split them when they have unmapped subpages, in order
> to free those unused pages under memory pressure. So remove the
> artificial requirement that the large folio needed to be at least
> PMD-sized.
>
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>

Reviewed-by: Yu Zhao <yuzhao@google.com>
