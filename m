Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2FF973FC25
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 14:47:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbjF0Mq7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 08:46:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjF0Mq6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 08:46:58 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 192CC1BCD
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 05:46:53 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id d75a77b69052e-40079620a83so253281cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 05:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687870012; x=1690462012;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rHWMAyFYN06/vLURwyAqsIEhD29kvLpFYLs6Ff1g/oQ=;
        b=t++9dpbBoGL63wjZQOTjGtKNMpVSnLo5qPdpzKTMeJvxNRNh2O4wNhMOI3aamuBB4O
         dCHvg99wWLcGj06p6cP0p6H+UHHCKdxVR5LerOLalFblaUiSTqb2hPMNep8t/C31Ug/j
         nFCtjbNQFq6o3fBPezyYun31HSvGwVeNw1Ryx4/DSYrodfWMhSq4pgo+j9srMLbmKlk6
         LtUXwQzM66jxoBhB0BVsNGBTzUwfZ1rO+YyJKXXB0EDjKZFFcdKGZMABeqEC1NCFbhRv
         17/xy0HbfiHlbhDApn+sgIXhtOWZiGDzaDkfLWQe11jS7zXfWPB2TEC0eKhv2XUt1M98
         lK+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687870012; x=1690462012;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rHWMAyFYN06/vLURwyAqsIEhD29kvLpFYLs6Ff1g/oQ=;
        b=XR4EF16ZxEaFytI7VE5b6Q3Cq4Awbt6cto3wYzobAY+ac18OpB27fbKFCf920PzyWE
         cxFUuzy64d/m12s0RqZcu983PHhJ1ZdRz0sVGxDvad+BHSkrkb2vjCZAU5EhHiinSAJY
         qCXqnIBE3wKU8aEQ2QUQVkpaRKTBS2Oe6DBBSS+d3XajhRpo52sZaLfPW/CiIjBo7UA+
         5aeaF4k+NB847lIS6V5Qeu7q06yXl+IqVTogvtcaJm3tvqxki88bKmHpJZ+nrwK5DBui
         g5161dmLGOiDCySXHoI5A73e9IJrrzmP628Ac3AfkpIu9Rc/CK9ZBc0GXKuH9QYXLDBX
         aH8A==
X-Gm-Message-State: AC+VfDwTUBcfuGgSNuN+EDOzoivBYfCEl9aGD27K2jNQ2YIfxZ00aOWE
        pjGIGFT5R9UYXUSjENAwTm68yy5Aedq88uTALpZufER/hORLwCu1lTNyBQ==
X-Google-Smtp-Source: ACHHUZ4s4ezhzTamKRUakP54YW6/V6w0wkyqlfo1JYN7CRloIMzppKPR7YVLfvBF0exRApXQ1xYYqVVs7+CawDZDqmg=
X-Received: by 2002:a05:622a:153:b0:3f9:ab2c:88b9 with SMTP id
 v19-20020a05622a015300b003f9ab2c88b9mr587235qtw.25.1687870011935; Tue, 27 Jun
 2023 05:46:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230627124332.82758-1-jackmanb@google.com>
In-Reply-To: <20230627124332.82758-1-jackmanb@google.com>
From:   Brendan Jackman <jackmanb@google.com>
Date:   Tue, 27 Jun 2023 14:46:40 +0200
Message-ID: <CA+i-1C1x=po6BVhp0iQ6erGGp9GkruV+90QLL2QC3MhM6dpthA@mail.gmail.com>
Subject: Re: [PATCH] scripts/gdb: Fix importing SB_ constants
To:     linux-kernel@vger.kernel.org
Cc:     jan.kiszka@siemens.com, kbingham@kernel.org, f.fainelli@gmail.com,
        akpm@linux-foundation.org, p.raghav@samsung.com, mcgrof@kernel.org
Content-Type: text/plain; charset="UTF-8"
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

On Tue, 27 Jun 2023 at 14:43, Brendan Jackman <jackmanb@google.com> wrote:
>
> Commit f15afbd34d8f ("fs: fix undefined behavior in bit shift for
> SB_NOUSER") switched these defines over to use BIT which when,
> !__ASSEMBLY__, expands to something equivalent to 1UL << x. The UL
> suffix isn't valid python.
>
> Luckily we already seem to have a facility in the preprocessed code to
> handle cases like this.

Oh. After sending I realised my tree was stale! This was already fixed
by Florian in 6a59cb5158bff1.

Please ignore :)
