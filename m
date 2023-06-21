Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90CAD738585
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 15:42:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231857AbjFUNmh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 09:42:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbjFUNme (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 09:42:34 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F290A1712
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 06:42:32 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-51bcf75c4acso4975a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 06:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687354951; x=1689946951;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=acPAMDZruYemX8TV6cTFFhShCBAic/MFb6BfUxW/eJ8=;
        b=sIctj19+4iS+N71smDAtyzFiXlzPZiOW+G6z39xane6Zv//qrUMsCz6nAa7J6rV7AC
         b9Jkx0V70uzOFA8gjwzskpQqkQ4Ukl3fYwTxBHAEaFMtCEOImHM7hEt+2d/UvfLorHs0
         4E1pwirARjhBK//tyNLrThGOxKwhf8L7gVbhpGvtGoDCGkas9ROaw3nofqrra8OREG1m
         aC+ioXYVUWJA9heR/2mhaSbQMckdie99gPv4K3MUVGFZVhmZLWUa4UscoMWhoa08jzae
         PCAeOpYXF+j2zdZD0b/8Q/x7fn08yK7Tm3Q0H2oFC/DCBLrlrhJpxBsjUT9YlpgTarMt
         d/DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687354951; x=1689946951;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=acPAMDZruYemX8TV6cTFFhShCBAic/MFb6BfUxW/eJ8=;
        b=fxkKbA5Hibhqr7daAjs6bNaS2lYMb+VOBKknWqJ/+Zhdq4nu9B2IhZ8vpSjDaYDej0
         CFcV5Sh0Kaz6cU9WrwOMbfWTLyubDgws+KvU3ufU63X49GkxHNrePVvN6ykexkwlh0MJ
         tbTk/1nVmitp5qERoaYygiiPFGKR3aalPjsGfJen5+5SpkIXPyeaqPfVrOTmlncwz2BU
         3RZO3A694YAweAxZ5q0NfK7uaei6pgLC+GnssLeTV7cicjGasNnCCzi4RWX1nAM069Ck
         edFDOeigzPiAE5wu4w3BXQLIF912ClQFVopW8FtDZJKQsowWXRLR5wuIPqUVKdQU5Tds
         LnxQ==
X-Gm-Message-State: AC+VfDx6JaAixxClTMH1ggbgwxwmlMAXSagac5hjKJu16Pk4xysmzojq
        dq4ZWYBdGb1asg5xBvoEDsWkQQHAXCU24me26anAtQ==
X-Google-Smtp-Source: ACHHUZ5UHF11eJAlQXvvGM7fzyvA2yQYbNg05LXVZvb+ql5FzKqus823wT1co33vViD1konnn7jxrblfw3QsQIOgWL8=
X-Received: by 2002:a50:d59a:0:b0:51a:1fd1:952f with SMTP id
 v26-20020a50d59a000000b0051a1fd1952fmr632263edi.1.1687354951319; Wed, 21 Jun
 2023 06:42:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230621072404.2918101-1-usama.anjum@collabora.com> <20230621072404.2918101-3-usama.anjum@collabora.com>
In-Reply-To: <20230621072404.2918101-3-usama.anjum@collabora.com>
From:   =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <emmir@google.com>
Date:   Wed, 21 Jun 2023 15:42:20 +0200
Message-ID: <CABb0KFGhSLAHAsa3nk-pyMe2j9MU4u3xkQR21HOoS65ZB2dKsw@mail.gmail.com>
Subject: Re: [PATCH v20 2/5] fs/proc/task_mmu: Implement IOCTL to get and
 optionally clear info about PTEs
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc:     Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrei Vagin <avagin@gmail.com>,
        Danylo Mocherniuk <mdanylo@google.com>,
        Paul Gofman <pgofman@codeweavers.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Mike Rapoport <rppt@kernel.org>, Nadav Amit <namit@vmware.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Shuah Khan <shuah@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Yang Shi <shy828301@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Yun Zhou <yun.zhou@windriver.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Alex Sierra <alex.sierra@amd.com>,
        Matthew Wilcox <willy@infradead.org>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        Greg KH <gregkh@linuxfoundation.org>, kernel@collabora.com
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

On Wed, 21 Jun 2023 at 09:24, Muhammad Usama Anjum
<usama.anjum@collabora.com> wrote:
[...]
> +static int pagemap_scan_test_walk(unsigned long start, unsigned long end=
,
> +                                 struct mm_walk *walk)
> +{
> +       struct pagemap_scan_private *p =3D walk->private;
> +       struct vm_area_struct *vma =3D walk->vma;
> +
> +       if ((p->flags & PM_SCAN_REQUIRE_UFFD) && (!userfaultfd_wp_async(v=
ma) ||
> +           !userfaultfd_wp_use_markers(vma)))
> +               return -EPERM;
> +
> +       if (vma->vm_flags & VM_PFNMAP)
> +               return 1;
> +
> +       return 0;
> +}

This could actually short-circuit all vma flags (e.g. IS_FILE): if
(required_mask & IS_FILE && vma is not file-backed) return 0;

Best Regards
Micha=C5=82 Miros=C5=82aw
