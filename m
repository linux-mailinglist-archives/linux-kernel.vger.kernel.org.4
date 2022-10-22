Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5B5C608F7C
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 22:00:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbiJVUAO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 16:00:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiJVUAL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 16:00:11 -0400
Received: from mail-vk1-xa34.google.com (mail-vk1-xa34.google.com [IPv6:2607:f8b0:4864:20::a34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5646B5A14A
        for <linux-kernel@vger.kernel.org>; Sat, 22 Oct 2022 13:00:09 -0700 (PDT)
Received: by mail-vk1-xa34.google.com with SMTP id y129so3007091vkg.8
        for <linux-kernel@vger.kernel.org>; Sat, 22 Oct 2022 13:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oCc6fCDBvainHyxcsWfWzc9zC2rNiGmKs3GME/+sOgY=;
        b=fVR2/grxqt7bRXxWMaVwi4cf8jCYMukFdRGbhVkhbFp6kKPkdpz1xAYE+eanuh8YiM
         R/rrLqcT+TC8p7uNhLeBpzpiOfb4tW+XhAkOmka1foCM3Qwh3CDRa6RdI+jJWYEZbm5P
         s44MaOZuqbKAJby4Xafout/ZTPZ562ngXpn0hR+TXsgkRdryqYpOU8qMCuW0TlCkaih3
         QE6pgOCxpzTqlj1SyokVNgoB3XPwPtc6M5y6nWzpyybtGx9g1N7Gwj1ERqmkNvvgMTAQ
         ebG4Cw7O7LfcCBQ8fnA+8LkO5V2WeDjFIRSrXE7tpBd2NyZufjcWnIkJxpAdnLdnQn7u
         15hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oCc6fCDBvainHyxcsWfWzc9zC2rNiGmKs3GME/+sOgY=;
        b=6pHpp4on1zyfRj85V8KE5xUE9x5c0HivZr1DvEmh327eZgrA0ClNGAVVffHuJJxhP/
         tNpCbLXIFKFMI7ar1tWg4QMpg/KEX9DlJuNVTih/rzO9joUcNjiKlbt7TnUDZPrI4tfU
         drgOoHZhNSWMSlkTi35vKAjPqzkvQoIxjyBS2lRtGoDM3hsZsXlsBlItIPx1gqLROnQI
         3Cz5/USY22DojLcoQQ471OGVTDSZPAsI6o/ZQbuscQ4k7smOS1GttUuAhgYVWR5p0DVM
         LLwt+UnGztG5XweIzKJGyJ2hKSk2hr7Wp/rqpWFzqUECaEdKyem0zXyZQHQHXhEGluc1
         /deA==
X-Gm-Message-State: ACrzQf1FPWzcDsdvfsJUtLp1GLDoq+zFAtHhp7IeFFjJnHS/4lNomY2V
        K6tpXXAkPgh24p0FjmbMduo0JkkjUDUkf/76cXXyEg==
X-Google-Smtp-Source: AMsMyM5R7wJkJY47oWSGLG3+XPHJI1satIgi1THu/sUcJKJfxUksdiKmnecYsRKQNWcKFFIOjh6zYJAxmp6NkkNc0m4=
X-Received: by 2002:ac5:c969:0:b0:3b6:2a34:a26b with SMTP id
 t9-20020ac5c969000000b003b62a34a26bmr765722vkm.30.1666468808375; Sat, 22 Oct
 2022 13:00:08 -0700 (PDT)
MIME-Version: 1.0
References: <20221022111403.531902164@infradead.org> <20221022114425.298833095@infradead.org>
In-Reply-To: <20221022114425.298833095@infradead.org>
From:   Yu Zhao <yuzhao@google.com>
Date:   Sat, 22 Oct 2022 13:59:32 -0600
Message-ID: <CAOUHufZo=fB2HcaCrj2aidLJ2zEhOpi7ou5M_7qOQiuQq8+wTQ@mail.gmail.com>
Subject: Re: [PATCH 13/13] mm: Remove pointless barrier() after pmdp_get_lockless()
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, willy@infradead.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, aarcange@redhat.com,
        kirill.shutemov@linux.intel.com, jroedel@suse.de, ubizjak@gmail.com
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

On Sat, Oct 22, 2022 at 5:48 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> pmdp_get_lockless() should itself imply any ordering required.

There are three remaining barriers that should be removed as well.
