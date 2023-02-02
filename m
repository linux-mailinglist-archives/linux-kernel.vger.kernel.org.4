Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0935A6879C0
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 11:05:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232090AbjBBKFR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 05:05:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbjBBKFP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 05:05:15 -0500
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com [IPv6:2607:f8b0:4864:20::e30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1F486EAC2
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 02:04:51 -0800 (PST)
Received: by mail-vs1-xe30.google.com with SMTP id a24so1279271vsl.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 Feb 2023 02:04:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OTOvqWUVVZlijg12oIE77cCshSPOfIDDk+4jVZ655+k=;
        b=Y7i97OuPVRG0MgxTC9jku/WRmfXJzJgR11Xi60ud4fHWkw7cLDQYIdWugE6JNqWnhd
         zxDgruQpaaB4LFUDWXcMSYeomB81VQX+3ATeeEqUeEUcYV0EZUWrjL3wOBJblWbRpVW1
         Gl7h9olEHVokDvWVeTLUZQkKU+OvOIiihhk0mCjAK4uwblHWRLHCA60HwPXBE/iCBa9n
         T8G8wzVtJ2m0TB3qrVKuJgHUhQkbAiqcJmN3TE6i/Qc8nDPNJRvHNU0ZJAANxudkyU5e
         ENdpuQzV9CWdipdZJs1aL1KBjiWwUgH58AUI9/UXDJp506L1+5IF8R62Rtxd6SUf3C9k
         a23Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OTOvqWUVVZlijg12oIE77cCshSPOfIDDk+4jVZ655+k=;
        b=2ZQbe777ZPuqRp2gs7zCyyN3lzlK8KYMa11rnkIB7b/H+oTJX+HyIDndREL3OCI+4D
         65uXiAkTU3TafVJ5+T/h8j2atO3WlX/ra6oVAMVja+Zf9JHs/HKBO+OBlA4ePN0hwxmZ
         ObBS1xd3xmNhMfYWgwXAuJX+2/fCgq2D04flLLOn/IWodzySKRJ3yjw9vJeIp2mCs4tb
         ouLFrV9j+WMqqxiyLAj2OqbaQc1iAgf0DVYri3g1i+zegz9Ok7qFo5yDqUyHRxFojmyY
         bDOrgJrKbjOzN7P2byEmquXlTNdGtGfFG5Put0Mc2SE+9J9yevglzAef/eb1rJTm23OI
         11CA==
X-Gm-Message-State: AO0yUKWewREICtJNyHkChRr8G2lAciwh9Fons7qRBSWTQbRMG9CBq17U
        JZuYbXUnqIklx0vnlN3bF95+veUMfdDtLaEHOIAqFg==
X-Google-Smtp-Source: AK7set+m0o4TzaHt7t+a9/rf2tPz/cn1DFL8um9JSDcZSJY/WerimKLUAL6/+SWq+cj4vMyKkMrrYJIk30w897DMp8k=
X-Received: by 2002:a05:6102:1343:b0:3ed:1e92:a87f with SMTP id
 j3-20020a056102134300b003ed1e92a87fmr927918vsl.1.1675332290796; Thu, 02 Feb
 2023 02:04:50 -0800 (PST)
MIME-Version: 1.0
References: <cover.1675111415.git.andreyknvl@google.com> <fbe58d38b7d93a9ef8500a72c0c4f103222418e6.1675111415.git.andreyknvl@google.com>
 <CANpmjNPakvS5OAp3DEvH=5mdtped8K5WC4j4yRfPEJtJOv4OhA@mail.gmail.com> <CA+fCnZeOs6R_Wk=Da-aC5ZUzz_tOPVQWu1DoPsYVORS=dJ6cQg@mail.gmail.com>
In-Reply-To: <CA+fCnZeOs6R_Wk=Da-aC5ZUzz_tOPVQWu1DoPsYVORS=dJ6cQg@mail.gmail.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Thu, 2 Feb 2023 11:04:14 +0100
Message-ID: <CAG_fn=VVZGc1pyC_zuo3Dzky0rFU_AX2WAWDn2Z98jO61bqvXg@mail.gmail.com>
Subject: Re: [PATCH 15/18] lib/stacktrace, kasan, kmsan: rework extra_bits interface
To:     Andrey Konovalov <andreyknvl@gmail.com>
Cc:     Marco Elver <elver@google.com>, andrey.konovalov@linux.dev,
        Vlastimil Babka <vbabka@suse.cz>, kasan-dev@googlegroups.com,
        Evgenii Stepanov <eugenis@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
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

On Tue, Jan 31, 2023 at 7:58 PM Andrey Konovalov <andreyknvl@gmail.com> wrote:
>
> On Tue, Jan 31, 2023 at 9:54 AM Marco Elver <elver@google.com> wrote:
> >
> > > +depot_stack_handle_t stack_depot_set_extra_bits(depot_stack_handle_t handle,
> > > +                                               unsigned int extra_bits);
> >
> > Can you add __must_check to this function? Either that or making
> > handle an in/out param, as otherwise it might be easy to think that it
> > doesn't return anything ("set_foo()" seems like it sets the
> > information in the handle-associated data but not handle itself ... in
> > case someone missed the documentation).
>
> Makes sense, will do in v2 if Alexander doesn't object to the
> interface change. Thanks!

I do not object. Thanks for doing this!
