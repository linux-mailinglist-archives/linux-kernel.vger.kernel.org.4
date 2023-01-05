Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C36C65EA8B
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 13:17:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232492AbjAEMRg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 07:17:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233074AbjAEMRW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 07:17:22 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE9F64FCE4
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 04:17:20 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id co23so35948144wrb.4
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jan 2023 04:17:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kwt7t/CJH1y9ow8O0/w8MvRjyKQlEsOGR187S/Ep1Yc=;
        b=EEHa3dsN09ZqzdRIQzB3skfi58Ttb6P5m9dQKWMu4EWf45Ny8zFqRTXKGlnuZuykg1
         53QIwOHCaSXs7PFlifjY/i6VZj9PKxGwMHB/QzMLbX4IkeSLHqovpz1pLJNPxKZ93iPq
         9XJJXV7hVVNb50tQVfE5s4lkaeBMSLkqqCf4oOQ0bC4AzVlJcbXqcqLbZQnnkn1V991b
         tGYPFkSd1NnFPQsKYy0vByVsTECHhBjlh5+47BFuvFqos3s/VWAiHiAws5SyV8Tk7L6X
         xzwm6idQBKh0FnyHFHZ83lYgQNzUq57yW15Epyfzx9L5iDiwcnkTVjBrtp8pGtwUadbu
         1/dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kwt7t/CJH1y9ow8O0/w8MvRjyKQlEsOGR187S/Ep1Yc=;
        b=VHxBF/U06JKFMT+Jqyce6uimzRjsnHyxWsc9EWflud2QSbGGTfpkEcr+xHonYPFLlD
         dBjixN7zaovevQKii8Gt69GnDeVS5hAJ3Ts3W8tr9Zw9N7Q9ZTQpfuZOnSdHcKlnt1vP
         RhD78gRegAx8gr+j0h5qSrIuX7ScWtQE/kXnHHVmrZcbSh/nf0t2MJ8F0v+VTZh6KKfh
         W4LYOgkT4NZpVk/pmzLZjomyC8OyPpkAWzCV/BoVnZmoRuFIydnfQ8O8CgvdUpKjcGzK
         O2YZuw9IxSuW50tP+q67Nl1mKSqAxCHECRb8oHQKu8+fmEoGWFwDZN4WOLVJBVelEXD3
         H/pg==
X-Gm-Message-State: AFqh2kpY1i2HCyX3AOn8iq+9fJFXby5G8FuFP9VpMb/bULj0bnzMUELE
        0HHINWeFVnTZWln12QHINy8=
X-Google-Smtp-Source: AMrXdXtc6CuEAd4hOJmOLbfJkC/PUZxn0pqlC6OaHDUrm2oDJb3Z5ScuShHqV64Hl216ISr93ru+Og==
X-Received: by 2002:adf:e703:0:b0:242:15af:27f with SMTP id c3-20020adfe703000000b0024215af027fmr33092970wrm.28.1672921039487;
        Thu, 05 Jan 2023 04:17:19 -0800 (PST)
Received: from suse.localnet (host-79-56-217-20.retail.telecomitalia.it. [79.56.217.20])
        by smtp.gmail.com with ESMTPSA id y2-20020a5d4ac2000000b0027323b19ecesm34747506wrs.16.2023.01.05.04.17.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jan 2023 04:17:18 -0800 (PST)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Alexander Potapenko <glider@google.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Tony Luck <tony.luck@intel.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH] mm: Remove a sentence from kmap_local_folio() kdocs
Date:   Thu, 05 Jan 2023 13:17:17 +0100
Message-ID: <3474652.iIbC2pHGDl@suse>
In-Reply-To: <Y7WP2gyTRqTZWAQZ@casper.infradead.org>
References: <20230104121845.15770-1-fmdefrancesco@gmail.com>
 <Y7WP2gyTRqTZWAQZ@casper.infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On mercoled=EC 4 gennaio 2023 15:40:26 CET Matthew Wilcox wrote:
> On Wed, Jan 04, 2023 at 01:18:45PM +0100, Fabio M. De Francesco wrote:
> > In the kdocs of kmap_local_folio() there is a an ambiguous sentence
> > which suggests to use this API "only when really necessary".
>=20
> Looks like you removed it from kmap_local_page() docs in 72f1c55adf70
> after I copied it in 53c36de0701f.  That information should probably
> also be in this changelog.
>
Matthew,
=20
I just added that information in v2 (I didn't know that I should have bette=
r=20
added it - thanks for letting me know about this practice):=20
https://lore.kernel.org/lkml/20230105120424.30055-1-fmdefrancesco@gmail.com/
>
> >   * While it is significantly faster than kmap() for the higmem case it
>=20
> Also, s/higmem/highmem/ (both in the kmap_local_page() and
> kmap_local_folio() docs)
>
Since these spelling mistakes are un-related to the purpose of the deletion=
, I=20
fixed them in a separate patch:
https://lore.kernel.org/lkml/20230105121305.30714-1-fmdefrancesco@gmail.com/

Again thanks for commenting my patch and suggesting improvements.

=46abio





