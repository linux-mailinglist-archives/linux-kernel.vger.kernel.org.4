Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C69176921E4
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 16:19:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232663AbjBJPTq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 10:19:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232563AbjBJPTm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 10:19:42 -0500
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACF217535F
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 07:19:33 -0800 (PST)
Received: by mail-il1-x12a.google.com with SMTP id v13so726268iln.4
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 07:19:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+prPUEDKBZV26g1PJl0vKX9uUayVwVitovpOEbZlSvc=;
        b=Ul8IjIvBIcwfXYjwbbKYYZhh1P8rfCEAfML+tLEzEeWOZCPj8LnmeGVgyXfqOIpx+2
         3jJYveTOxb0zFbF5ww6k8j7wF5AWZTw/rcabFfUYsXgHkok9IYB2ciDpM/JF5QvKZOLr
         08CyABsWdz0/uqnGatyvoq19/msiud4Lm308Tn3QsdN2c1Ug3pkEGmEEeu7X10Z8Jwx5
         NacQyN1vw5/TDgOYJtfgXZ2tflNPdj8GySGFLeITUi5+SJLL48QcbeUdH3lDH8h/eb86
         vSJF27RFZat3dyP9weu43mbvE+IuaRcRk8Qspp2Bx11MQC5MXD4BVRXuBhMA2/6nt3Hy
         7VMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+prPUEDKBZV26g1PJl0vKX9uUayVwVitovpOEbZlSvc=;
        b=mlSiMAm9Z17YTTEkNUI8jjOgZeLicet8jDcUaEbcQk/ibZyh2DS/FhLDlsbQyWBqrL
         0vZHqVejczQu/RTaucnmYwEZvpuhIux8kvbHqbHSBOhCCv42AI/3h9BqM8VJv77Xqhsv
         fy83jbzrFPzmM3JEYBpkiu6SroEu/CyPHU4UiHXuFZm+nbOuQ1lszMtu/6bMli0tCqUy
         Fvjght/fvNCZyPmjMgstRKlf3CSDO1xmWq8NBzmQdoRBxtqHtvMNJV7hhjcolBqFZCW7
         Lt9mmnsg8gqnhOrgMqCOsRJJPGvC+Z6d5E6Lymbk06G0E0qpLAEjEv07/8oEakLAcC4J
         pQ6w==
X-Gm-Message-State: AO0yUKWF0wx/r5Ln1JBSGUfBuRugkSY47Il3bIcXELs/EiQ41mNY8KkQ
        5gELhmV0zYnZwLRQaiD+f7zmR/0PXB9BKWv+q3Vmgg==
X-Google-Smtp-Source: AK7set/9VUMRT57YqU0uMnTiXRs9tDahoi41gTOJhOZKAoAiE1mGXeBWi4Fxly09ZQ7BqgkUrJJZSqotfQl1cZMaSkg=
X-Received: by 2002:a92:7010:0:b0:313:c1fa:fda0 with SMTP id
 l16-20020a927010000000b00313c1fafda0mr9259122ilc.83.1676042372924; Fri, 10
 Feb 2023 07:19:32 -0800 (PST)
MIME-Version: 1.0
References: <20230123220500.21077-1-kirill.shutemov@linux.intel.com> <20230123220500.21077-7-kirill.shutemov@linux.intel.com>
In-Reply-To: <20230123220500.21077-7-kirill.shutemov@linux.intel.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Fri, 10 Feb 2023 16:18:56 +0100
Message-ID: <CAG_fn=UVa=x+idoHoHjfe+ASsT30aQGHLW3KkEgfmsOcwh_fQA@mail.gmail.com>
Subject: Re: [PATCHv15 06/17] x86/uaccess: Provide untagged_addr() and remove
 tags before address check
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        Kostya Serebryany <kcc@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Taras Madan <tarasmadan@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Bharata B Rao <bharata@amd.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +#define untagged_addr_remote(mm, addr) ({                              \
> +       u64 __addr = (__force u64)(addr);                               \
> +       mmap_assert_locked(mm);                                         \
> +       __addr = __untagged_addr(__addr, (mm)->context.untag_mask);     \
> +       (__force __typeof__(addr))__addr;                               \
> +})
> +
> +#else
> +#define untagged_addr(addr)    (addr)
Could you please use tabs for indentation here?
