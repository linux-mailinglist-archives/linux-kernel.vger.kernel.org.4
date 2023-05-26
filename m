Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 368BC712CFB
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 21:02:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243728AbjEZTCh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 15:02:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242443AbjEZTCf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 15:02:35 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 284B2135
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 12:02:35 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id 98e67ed59e1d1-25345ca8748so1163218a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 12:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1685127754; x=1687719754;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UMwMRcIZeKbdrJXUxH3m9J74leHfxE/0WKjt5sRobV0=;
        b=aiqwBwqwsrm/rMZ51l/9ygYns9+x9tM6DU0Iw5Qq0nBaiRPMxACuKpGCS1NpoAOp8h
         s6wxVmIuae/6Knp/4r1BhR6x8F4OnKjaBNYiNplMg2FkZFuvG0iPyfXJawwRjR9PfkTR
         84Dm0cdDHlbGspsvagKILpuAbTe4axrJuQWEI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685127754; x=1687719754;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UMwMRcIZeKbdrJXUxH3m9J74leHfxE/0WKjt5sRobV0=;
        b=IFYscqqdAYU2SsPK70YSw3onR1iJX+R2qndBxr4vPyhxQFg+PLbduU8zEnPZ6k/Epp
         F951OAY9o//HLh5ITDBMjv+sFQHspCv99wB/DPqugvgZmULldLx7GUoRgTIblUQFHXiC
         T2znfUH7AicFx7LX9L3khaRZBfFClgLrxbqBkmNyBgy1iujuS8ZF3lJlY4hHpBwsSA/Y
         rfOtWr8MxZCvoTPeANlmdHevVmA6e/297auSZFHKlyJZof1hfbfbWOAHZlG2dgVa25Fg
         6GRQQwoN6WJAQ0SajM661yib9qD3g2TCqqzxETOEjJBJF82RlY17jMH9jmj6V6Vdd6Yz
         2w9g==
X-Gm-Message-State: AC+VfDyjSwhaduTUySS3YOL48sPI5Qdmmne6qZdMZDvIM6xLhH4HJfDz
        6owlvOiKtUImIu09hq5rficE8h1Id2H13w2/jL2Nnw==
X-Google-Smtp-Source: ACHHUZ7geWCwb3ENIFVOneteTZlOy6VBf70sBMnKUGwOrh6hBi6QO/f2irhb8ZzJ+DjSQ/W3Jmz5KuBlemGG4W7voWo=
X-Received: by 2002:a17:90b:24c:b0:255:5d65:3a86 with SMTP id
 fz12-20020a17090b024c00b002555d653a86mr3603844pjb.8.1685127754610; Fri, 26
 May 2023 12:02:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230517150321.2890206-1-revest@chromium.org> <20230517150321.2890206-4-revest@chromium.org>
 <bb08b91c-6c7b-a7a0-d4a7-68ddea46277f@redhat.com> <884d131bbc28ebfa0b729176e6415269@ispras.ru>
 <d7e3749c-a718-df94-92af-1cb0fecab772@redhat.com> <3c2e210b75bd56909322e8a3e5086d91@ispras.ru>
In-Reply-To: <3c2e210b75bd56909322e8a3e5086d91@ispras.ru>
From:   Florent Revest <revest@chromium.org>
Date:   Fri, 26 May 2023 21:02:23 +0200
Message-ID: <CABRcYmJDwAuu4_puc43DpzqaA0g9sqGTduDqhnBZBw9BTBtdqA@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] mm: Make PR_MDWE_REFUSE_EXEC_GAIN an unsigned long
To:     Alexey Izbyshev <izbyshev@ispras.ru>
Cc:     David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, akpm@linux-foundation.org,
        catalin.marinas@arm.com, anshuman.khandual@arm.com,
        joey.gouly@arm.com, mhocko@suse.com, keescook@chromium.org,
        peterx@redhat.com, broonie@kernel.org, szabolcs.nagy@arm.com,
        kpsingh@kernel.org, gthelen@google.com, toiwoton@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 22, 2023 at 8:58=E2=80=AFPM Alexey Izbyshev <izbyshev@ispras.ru=
> wrote:
>
> My preference would be to keep checking the upper 32 bits. Florent, what
> do you think?

I don't mind. I can do this as part of v3. :)

> > Which raises the question if we want to tag this here with a "Fixes"
> > and eventually cc stable (hmm ...)?
>
> Yes, IMO the faster we propagate this change, the better.

Okay, will do
