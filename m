Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 539A26568F0
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 10:38:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbiL0Jic (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 04:38:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbiL0Ji3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 04:38:29 -0500
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AA2725F9
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 01:38:28 -0800 (PST)
Received: by mail-qt1-f174.google.com with SMTP id j16so10069720qtv.4
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 01:38:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=siFqAc8jSxdLv2WV3aOXYztZ7rcB86DU4foFECsxEtc=;
        b=oZa93YKisJiLHL/AqFEhxYxkFtxUaKJkqPrVIXy+Zyo1BeC+jctGzM2bpGYLcvozer
         9wpnVbMjtrKhPk+okXsxSJTQbUtU/lXuO84dF1ewjFGzpiGgT/k3lMIrbnanvOg1D3qm
         5pkIsrdJQgxGkd3FYIO4MT30t+xQ1D3nA11ul/IYhSTd8wgzCDa8fLgmviAaKtbyC3MK
         HRtsMySiD6PGcddz46+s/Gn3SZ0x8bSGEd2KbzDHLzHMQBEf5ZusCATrHlyRyQ9cFRU3
         3zxYU2Q0nRzWdyeMN+9gVbHjtVVPRrfZNm03/aXi5f/4Ela5Q7J/uVGpKFslsGnTpDfL
         zewA==
X-Gm-Message-State: AFqh2kpy6wT5iahk72ZEY+1OpLeyYbejKkVTiqLQJ2VKGrLDPANKgvTN
        7isViVZ36gaTJMCjIw90hS1sE9VrxkCTQw==
X-Google-Smtp-Source: AMrXdXuj1MQ9HfAuHyn5jmvorcmsiNLL09ncXikEEqjf1P+oHh6P3KkpcEaNleNow07sAm69xMP4zg==
X-Received: by 2002:ac8:5f0f:0:b0:3a6:2170:b089 with SMTP id x15-20020ac85f0f000000b003a62170b089mr37653456qta.12.1672133907483;
        Tue, 27 Dec 2022 01:38:27 -0800 (PST)
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com. [209.85.128.173])
        by smtp.gmail.com with ESMTPSA id fc16-20020a05622a489000b003a6a7a20575sm8122780qtb.73.2022.12.27.01.38.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Dec 2022 01:38:26 -0800 (PST)
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-46198b81e5eso177508567b3.4
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 01:38:26 -0800 (PST)
X-Received: by 2002:a81:356:0:b0:478:831e:454e with SMTP id
 83-20020a810356000000b00478831e454emr596721ywd.384.1672133906056; Tue, 27 Dec
 2022 01:38:26 -0800 (PST)
MIME-Version: 1.0
References: <cover.1672043615.git.lstoakes@gmail.com> <4b59f47ff4cd89ff76a5b6edbef6e8e0b37046f1.1672043615.git.lstoakes@gmail.com>
In-Reply-To: <4b59f47ff4cd89ff76a5b6edbef6e8e0b37046f1.1672043615.git.lstoakes@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 27 Dec 2022 10:38:12 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUeLjcXPr0QgOWs6zo9KPu0p9E0tjndcWG0K9Vr_gBDkg@mail.gmail.com>
Message-ID: <CAMuHMdUeLjcXPr0QgOWs6zo9KPu0p9E0tjndcWG0K9Vr_gBDkg@mail.gmail.com>
Subject: Re: [PATCH v3 3/5] m68k/mm/motorola: specify pmd_page() type
To:     Lorenzo Stoakes <lstoakes@gmail.com>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        Hugh Dickins <hughd@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Liam Howlett <liam.howlett@oracle.com>,
        William Kucharski <william.kucharski@oracle.com>,
        Christian Brauner <brauner@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mike Rapoport <rppt@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 26, 2022 at 9:45 AM Lorenzo Stoakes <lstoakes@gmail.com> wrote:
> Failing to specify a specific type here breaks anything that relies on the type
> being explicitly known, such as page_folio().
>
> Make explicit the type of null pointer returned here.
>
> Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
