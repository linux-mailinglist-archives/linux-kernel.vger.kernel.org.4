Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8906774D99D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 17:12:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233018AbjGJPMG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 11:12:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232378AbjGJPMD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 11:12:03 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 817D1C0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 08:12:02 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-579ef51428eso59653457b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 08:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689001922; x=1691593922;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DbtJOk8oTaRo7QZmrru5UgrEoVaoodoQOwpqijk7rkE=;
        b=jUO56CvxDdxjFKPEDlM0AEJs4lOeOQKnpPbEcr7vVb04NR8ePonvLaDa2Tgei6H1bN
         O+tJyIenwS6T/le6CVjhRc8pxnXHw4toSbOEloMzCSEIdDqIWobBbiH/3YwFSLkt/cik
         oDjhtpscdyeXPvEGw9WvaOXjIx120CSx3nRbo2kecmstqBi3Ne/9Gd3efTJBr9M05E2v
         mTk3+rFaR/4DkbN1RQjYqVV+JMufJ3AIJ2Attv/rsHlH59xefIF+DPP5kqQYhmAZb1j3
         Srkq/dXUBf+6RAtE7DJ2KSzjPEBwgtm2oihnhM76rNllfBckpvLNFTk+a+OgAgerDfJy
         imXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689001922; x=1691593922;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DbtJOk8oTaRo7QZmrru5UgrEoVaoodoQOwpqijk7rkE=;
        b=PZ+NtEi/g6avft+j42adxNWluRLUAl4ys6ozLgF8pktZlGqYWVuUI5oSKtuTLJjQp3
         fwxokubTXkJp6+EZobrbHyZ7PH3aNkEsuM046NoUrKKgAGhRdKXu6iNfVagZlk5qv3mP
         +PToFVSlCozBM9p4nOO8rydPAPmCfRb0EgTYBYd983g0aFbFbv0kTDPTchu3Ns11P7eL
         XefVWCUrwOdnquubG33YnKVKOQ1kgpGou7vuIL+eGb7Y//WptZAXw0lJNr3dzgQwJcB0
         NpGhLakM3HPTWBnSGvm3bFwyzCUNFRBXcHhT2QJG9lDN+AEaZEqcWJashDb8rMMz15aF
         rXSQ==
X-Gm-Message-State: ABy/qLY8iTkJx4DzuViwR8XYSwJbSkZpcjQs33SRDdxxpo42RvDEEb95
        zoj0acI0PU7ZKymTxoGxnnMVNY6CU0UqacHvxFpcVQ==
X-Google-Smtp-Source: APBJJlH4FQYpOEQ3A+1can3H5jmu7RtXcq5Isl9pvfprIvZbCeng7GFvtjUk+WPcMCXUrOipfG5gVdSdLgpX4ZvIl3o=
X-Received: by 2002:a81:6646:0:b0:56f:fa68:2e34 with SMTP id
 a67-20020a816646000000b0056ffa682e34mr14854021ywc.35.1689001921492; Mon, 10
 Jul 2023 08:12:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230707201904.953262-1-jiaqiyan@google.com> <20230707201904.953262-3-jiaqiyan@google.com>
 <ZKh2K7ObVtlXHkTk@casper.infradead.org> <20230710002116.GA1578139@ik1-406-35019.vs.sakura.ne.jp>
In-Reply-To: <20230710002116.GA1578139@ik1-406-35019.vs.sakura.ne.jp>
From:   Jiaqi Yan <jiaqiyan@google.com>
Date:   Mon, 10 Jul 2023 08:11:48 -0700
Message-ID: <CACw3F533yhafvtaEvnk568CnzvOhMFPeDTGtY4eMR=tW3DSL_Q@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] mm/hwpoison: check if a subpage of a hugetlb folio
 is raw HWPOISON
To:     Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        Matthew Wilcox <willy@infradead.org>
Cc:     akpm@linux-foundation.org, mike.kravetz@oracle.com,
        naoya.horiguchi@nec.com, songmuchun@bytedance.com,
        shy828301@gmail.com, linmiaohe@huawei.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, duenwen@google.com,
        axelrasmussen@google.com, jthoughton@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 9, 2023 at 5:21=E2=80=AFPM Naoya Horiguchi
<naoya.horiguchi@linux.dev> wrote:
>
> On Fri, Jul 07, 2023 at 09:31:39PM +0100, Matthew Wilcox wrote:
> > On Fri, Jul 07, 2023 at 08:19:02PM +0000, Jiaqi Yan wrote:
> > > Add the functionality, is_raw_hwp_subpage, to tell if a subpage of a
> >
> > This is incorrect naming.  "subpage" was needed before we had the
> > folio concept, but it should not be used any more.  We have folios
> > and pages now.
>

Thanks for your comment, Matthew.

> I think we can address the raw hwpoison page by the offset in folio/hugep=
age
> to eliminate the concept of "subpage".
>
> >
> > Also, abbreviating "hwpoison" as "hwp" seems like a bad idea to me.
> > hwp is already used as an acronym by acpi, intel_pstate, some clock
> > drivers, an ethernet driver, and a scsi driver.
>
> I originally introduced the abbreviation "hwp" to avoid using a lengthy
> function name such as "folio_test_hugetlb_raw_hwpoison_unreliable()."
> Therefore, I prefer using "rawhwp" instead of a longer form like
> "raw_hwpoison," although I don't expect any confusion between "hwp" and
> "rawhwp."

These are names in my mind, what do you think?
* is_rawhwp_page_in_hugepage
* is_raw_hwpoison_page_in_hugepage // I prefer this one
* folio_test_hugetlb_raw_hwpoison_page

> As for "hwp_walk", another user of "hwp" in in mm/memory-failure.c,
> we can easily substitute it with "hwpoison_walk."

In this "hwp_walk" case, I also prefer "hwpoison" than "hwp". I can
create a separate renaming patch.

>
> Thanks,
> Naoya Horiguchi
