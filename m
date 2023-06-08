Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37547728B01
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 00:14:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236697AbjFHWOZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 18:14:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232715AbjFHWOX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 18:14:23 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 399B212E
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 15:14:22 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id e9e14a558f8ab-33bf12b5fb5so154425ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 15:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686262461; x=1688854461;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3VvOVkeoZOg8bLOTHO/XPAd+duFpOWtxmm7bgNMjwIY=;
        b=SMu023XUb3hUwIzFGWt7VF8BORxCe6qv0OHg6vdrhD5Q4hLPfovNAjr0cpYZV8z2I/
         qHID6Y26hyv84vgV4sRxmcjOHqHB9zneqOuERsO+QZqGoJD6EuPi/tCWSD6tbQaA3fou
         PwdFkNkXuG3YYckZyScVzMBNineCRvCgVZisP4yKzy8widSfC3WO5Rdswlha0rTnzQ5x
         lApzjhUZW0UOMN1V5LrmyLByurKV6qUtslTaxRWs0xEvEXHZg8EXB/xjasb5LBpcVLJj
         MnAkI+Foz+xbPY49w7StsDbIO5zpJ8/FSA44sxcMv/ksNtaKeDsul2wT1XNl9XBpGcC8
         /O2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686262461; x=1688854461;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3VvOVkeoZOg8bLOTHO/XPAd+duFpOWtxmm7bgNMjwIY=;
        b=gQaN0ZSZToAmZwMvZXpL1m2kDdqC6F1bOOwsUbePYUgRBq79+CKyf7iOCZVEgQXXaT
         0KhISup/CUrToj5Xf2TwHfQtFhB65a0h3uXPEeJ+n5PVZHPk6RhRcjuU01/N1sXySCC4
         wgtVd2hA16wgeg5w8neZ+p1WIqVfAub4XXq5/ZeJUfCxYHfPZjtrcmVcrujDqOiln4JD
         cANEnpxPyL+apJA1SMYjzQu3a+ECi5GMR9FJKaS9sA9NKCKXXLnj9+0PgFytbxPyccVb
         ihDQGY9BhT/6bVQO2mWUg1/WWZZPYrF4GQbXLslz/Kr+hqLcbbZZxm1Qbv5wO0za+gFN
         eHDw==
X-Gm-Message-State: AC+VfDyvuj0o8x94Kb2XwX1Of0NGzb+PNAkW2fs0Bzzn0jz3OZDV/wG5
        eZE1oZf7RX4JfHfQ4aELW6LHcTNALl9EP8yElch/ag==
X-Google-Smtp-Source: ACHHUZ5SxX7JBSREEC9RUhJHHbRZp5/FKA22DLCloyyUQOmkMcWK0C3/vAV2Gz47nH3Lc8iVEjZJCz7r4IZtJz/+T4g=
X-Received: by 2002:a05:6e02:1bac:b0:33b:5343:c1d6 with SMTP id
 n12-20020a056e021bac00b0033b5343c1d6mr215059ili.21.1686262461249; Thu, 08 Jun
 2023 15:14:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230608220558.39094-1-ctshao@google.com>
In-Reply-To: <20230608220558.39094-1-ctshao@google.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Thu, 8 Jun 2023 16:13:44 -0600
Message-ID: <CAOUHufbik3N9+K78=yGMZyERfD2o1o3kNgVoR73qKxWyQ2_3VQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] KVM: arm64: Consistently use free_removed_table()
 for stage-2
To:     Chun-Tse Shao <ctshao@google.com>
Cc:     linux-kernel@vger.kernel.org, oliver.upton@linux.dev,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Ben Gardon <bgardon@google.com>,
        Gavin Shan <gshan@redhat.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Thu, Jun 8, 2023 at 4:06=E2=80=AFPM Chun-Tse Shao <ctshao@google.com> wr=
ote:
>
> From: Oliver Upton <oliver.upton@linux.dev>
>
> free_removed_table() is essential to the RCU-protected parallel walking
> scheme, as behind the scenes the cleanup is deferred until an RCU grace
> period. Nonetheless, the stage-2 unmap path calls put_page() directly,
> which leads to table memory being freed inline with the table walk.
>
> This is safe for the time being, as the stage-2 unmap walker is called
> while holding the write lock. A future change to KVM will further relax
> the locking mechanics around the stage-2 page tables to allow lock-free
> walkers protected only by RCU. As such, switch to the RCU-safe mechanism
> for freeing table memory.
>
> Signed-off-by: Oliver Upton <oliver.upton@linux.dev>
> Signed-off-by: Chun-Tse Shao <ctshao@google.com>

Acked-by: Yu Zhao <yuzhao@google.com>
