Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 139E667207C
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 16:04:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231599AbjARPE1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 10:04:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230410AbjARPD6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 10:03:58 -0500
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93652658F
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 07:02:23 -0800 (PST)
Received: by mail-qv1-xf2a.google.com with SMTP id m12so21897539qvt.9
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 07:02:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4+fJwlk16Zd5YKVL2Mq5ebFB+FCSi11Z9DNVGCEEgBI=;
        b=pSDnmoWudr37hWRG2OAmB7PzheSpU8qtllgEpPNxTSn9qsp4QhwGnjzJwB/IkcC/m1
         Klo+Vg0ROcz3560T7mPYdl3jSutyaaldf21kH5EmixuHcrIR5Ae4kBqI3hLwCdz7TQ/y
         rhjYFDIJANmNr2LTdeWXiug8bToml0PjMnR9+ikcR8wEJuN/Ald3rNRPwWwwrwrPUKj2
         U+PorV1hJniW5/ut5oB6smCurs1igrh6QMUGu1CxCO8ejK7QVVaEvzp13ler5US5pBG7
         QQO4TJA4S6I02aqUqR2k6q5N5d35J4+HPHH0AUdVUS28BIon9iPGHGFAJ7S7C4aZhk14
         tLaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4+fJwlk16Zd5YKVL2Mq5ebFB+FCSi11Z9DNVGCEEgBI=;
        b=cbVcKhmOF50QAhJvdQWRzlANEcoV9eRY1G7PRTnx5IK4Az92+uUF0s77vzb3UtDw3i
         T5LizkZMKbGBjH0KuJwQb7uy/HB+XYDShaADwmDdKOLU/f1RCnHXYvVgMM8UxfUgIQRX
         gTpfIhpafR3gsHM6+YG0KtSvzgTGxste2d08MHv6V0mh6W6ybwgGcv8OToo9KHSVX2dz
         VPzJKE4BKIyFqXknCJrgvORB350G2khYUVMCkAEXOoeG4FmyJxaeHUqREQspRllIoB5Z
         +Jv9w/YwkUNQ1MS8/W6a1LoCUjrZ1yu/8U0KD0SCBC/Q29O5tVQJygcVxIw7+AtOtoly
         DinQ==
X-Gm-Message-State: AFqh2koxPLl4eib5lbHsO6+9cB2seHfH/gKnzVVHuXSLCybO/sOkDbld
        EsJumsh0DNH1ge5Q8awGMbTgHt3+wG1lRsy9uLIf/jj9lQyIDw==
X-Google-Smtp-Source: AMrXdXukP752xWBOKIBJdMCs9ebOZmMBMSzNKL6esC87+UJjFfhWNj7iv4rrRer1S0Cd8tHf5mbss9zfEKMzT7CxZVA=
X-Received: by 2002:ad4:4242:0:b0:4d4:de23:9203 with SMTP id
 l2-20020ad44242000000b004d4de239203mr432972qvq.48.1674054142683; Wed, 18 Jan
 2023 07:02:22 -0800 (PST)
MIME-Version: 1.0
References: <20230117204617.1553748-1-pasha.tatashin@soleen.com> <20230117171312.13bdb3b2673bdac3c93c2ab7@linux-foundation.org>
In-Reply-To: <20230117171312.13bdb3b2673bdac3c93c2ab7@linux-foundation.org>
From:   Pasha Tatashin <pasha.tatashin@soleen.com>
Date:   Wed, 18 Jan 2023 10:01:46 -0500
Message-ID: <CA+CK2bCsYp839RVFLYTjx-NSwUxMJ9xG9Z=DDy7hgGn72+aMdw@mail.gmail.com>
Subject: Re: [PATCH] mm/page_ext: init page_ext early if there are no deferred
 struct pages
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     rppt@kernel.org, mhocko@suse.com, vbabka@suse.cz, david@redhat.com,
        quic_charante@quicinc.com, lizhe.67@bytedance.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 17, 2023 at 8:13 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Tue, 17 Jan 2023 20:46:17 +0000 Pasha Tatashin <pasha.tatashin@soleen.com> wrote:
>
> > page_ext must be initialized after all struct pages are initialized.
> > Therefore, page_ext is initialized after page_alloc_init_late(), and
> > can optionally be initialized earlier via early_page_ext kernel
> > parameter which as a side effect also disables deferred struct pages.
> >
> > Allow to automatically init page_ext early when there are no deferred
> > struct pages in order to be able to use page_ext during kernel boot
> > and track for example page allocations early.
>
> Compilation blows up with CONFIG_PAGE_EXTENSION=n.  I did

Thanks, I will update the patch and send it soon.

Pasha
