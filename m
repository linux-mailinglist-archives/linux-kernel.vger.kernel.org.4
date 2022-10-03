Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0F385F2D10
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 11:25:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229501AbiJCJZZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 05:25:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbiJCJZW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 05:25:22 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE081DE8A
        for <linux-kernel@vger.kernel.org>; Mon,  3 Oct 2022 02:25:15 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id nb11so20805818ejc.5
        for <linux-kernel@vger.kernel.org>; Mon, 03 Oct 2022 02:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=KH5kXMx1j/oTNNhZRKuODb/UQfipuwMsr2taHr2n3iI=;
        b=MmSSF88PGb0kNZlcZGhq52Bln8W5vNyi0KvF80KuX6npiDSOE7/4FnctaORCS+EP3Y
         1OS/SRivnCENR642EbNLY3/UYA0kSouSO04VN9n8sbHHeD9bg3XZG1quagTYEeYMpqxo
         urQkf3hUQfleMBqJAZaDEtZqae74T+ZW8C3TabFy2V7r6TxjHMaknJFqCrCn02cmwsgQ
         osBKwqEn4oHbZbKqwXKc4GHi3JQTAqPwcVAArrF3EOXq4LWfXcrKIbO5qWA/Z7/Ob321
         ArS5hBaNeR6PNBOMhcfmnKhSmUFIoWP43ohGlswMBLfh4foJE/cUVu3UfWLd+6ed7gkV
         EczA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=KH5kXMx1j/oTNNhZRKuODb/UQfipuwMsr2taHr2n3iI=;
        b=46UJN2za5lu0O3FXS8hGJwFrpFIwf6YJBW1x9cJPVUoyrWgk/+eDhO50xeS9+clabm
         giqj91QrQ2NSK7pbaLbnn/J4nl0gKBjuDcGZlUuE4W9XIqovTy5PbF8qMoMaclyI7MJt
         tfNhjqfDNqc/mtiNwiWzYSKK0yvQaKGtdl5HwwCb0J7XrL9CUXoOm6qelsJIB9krwDhP
         aCgMTA3fYIkjic447/pvVHJq//ejuanVOpRvTEYgN3UpZucFcZSi0A18AUPu/Nzy5hBh
         PsOZp8H1YcH01GHmryIibVE+nyB5MtbjGQLDYWLBIoXamCN49Ggoa6rdNgB9cnoRO8G4
         c3nw==
X-Gm-Message-State: ACrzQf0CA9n+/mfX4HJfYpSiMDpmviWeLIWDwYT9b85sBzchYFu/DbFP
        Fl3aVwFtFW56b+jObyQZv/2E7rxbzniH5lthIGRO1i5fZozcIg==
X-Google-Smtp-Source: AMsMyM6Q5krj64ZwrrjyF8pYM/58fjn7PE8pPyyPsvJWpsZaFJN1Vu02ABADXWgBqI4+3kYK5WRyxUmHsWFnHn8xRMc=
X-Received: by 2002:a17:906:7304:b0:6ff:a76:5b09 with SMTP id
 di4-20020a170906730400b006ff0a765b09mr14178256ejc.193.1664789114197; Mon, 03
 Oct 2022 02:25:14 -0700 (PDT)
MIME-Version: 1.0
References: <20221002002326.946620-1-ira.weiny@intel.com>
In-Reply-To: <20221002002326.946620-1-ira.weiny@intel.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Mon, 3 Oct 2022 14:55:02 +0530
Message-ID: <CAFA6WYN+3inY6MYrMFY0qhmifCYtj_immFMFN6jC1BamQCYGWQ@mail.gmail.com>
Subject: Re: [PATCH 0/4] Remove get_kernel_pages()
To:     ira.weiny@intel.com
Cc:     Jens Wiklander <jens.wiklander@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ira,

On Sun, 2 Oct 2022 at 05:53, <ira.weiny@intel.com> wrote:
>
> From: Ira Weiny <ira.weiny@intel.com>
>
> get_kernel_pages() only had one caller [shm_get_kernel_pages()] which did not
> need the functionality it provided.  Furthermore, it called kmap_to_page()
> which we are looking to removed.
>
> Alter shm_get_kernel_pages() to no longer call get_kernel_pages() and remove
> get_kernel_pages().  Along the way it was noted that shm_get_kernel_pages()
> does not have any need to support vmalloc'ed addresses either.  Remove that
> functionality to clean up the logic.
>
> This series also fixes and uses is_kmap_addr().

From the above description, I am failing to see the motivation behind
this change. Can you elaborate here?

Also, since you are targeting to remove kmap_to_page(), is there any
alternative way to support highmem for future TEE bus drivers? As I
can see higmem being enabled for multiple Arm defconfigs [1] which can
also support TEE (an example which already does it:
arch/arm/configs/imx_v6_v7_defconfig).

[1] git grep CONFIG_HIGHMEM arch/arm/

-Sumit

>
> Ira Weiny (4):
>   highmem: Enhance is_kmap_addr() to check kmap_local_page() mappings
>   tee: Remove vmalloc page support
>   tee: Remove call to get_kernel_pages()
>   mm: Remove get_kernel_pages()
>
>  drivers/tee/tee_shm.c            | 41 ++++++++++++--------------------
>  include/linux/highmem-internal.h |  5 +++-
>  include/linux/mm.h               |  2 --
>  mm/swap.c                        | 30 -----------------------
>  4 files changed, 19 insertions(+), 59 deletions(-)
>
>
> base-commit: 274d7803837da78dfc911bcda0d593412676fc20
> --
> 2.37.2
>
