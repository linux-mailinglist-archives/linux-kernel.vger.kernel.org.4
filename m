Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E85A36533D9
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 17:16:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233998AbiLUQQo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 11:16:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234116AbiLUQQl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 11:16:41 -0500
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D375222A7
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 08:16:40 -0800 (PST)
Received: by mail-qt1-x82f.google.com with SMTP id c11so6134632qtn.11
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 08:16:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Hsa6T3GulZ+3V9yadTNjqSGffTKaOIWWpdQCi5qCyYQ=;
        b=L/DfgXegMdR/EV/AaMV4u/NVGnEQaXOgFHypZOdnIsfFew73CI/qPbpNneTYaRR9UY
         atbbDIh3qekit0O5oviVJlLf8AczqZdbosdc2t+YE/eif2gRRSJXXRAu3NKsTh3lFjit
         QDtM56khL1hVvtaStQLRu8DxrVnl4dCaZ7BEI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Hsa6T3GulZ+3V9yadTNjqSGffTKaOIWWpdQCi5qCyYQ=;
        b=YBsH6o0QjkuNIHEdOP6qQ8mVgch3gayKhil44/tqG7ccjpJ4qlGX41kHxvSey6mzuf
         2Ri/0POqmeiD4fLKo5X6Oyhum8ABn8IlGlcq89G4Wd1OI7n2U1Lhj0qFPjlQpxWQDwlG
         1EjuwnP3vJX+0mdMHEVhuYFxp3dIwOycc3SeTQCldnf7u9CNKJm5OZl5iMG43BQ62fxM
         MufGY6XtuBAeI/nRY7wMJad/Z9ME49KYMZvRl402PRzzu2DSBJxtgaeJV/Iip8KMExSK
         yvWi3u40x9LfjnEnFZd74a7wWxBKHaE0OV+WccxKJHyLhmCK0ojy4MTRQ4y8WWbaDJiX
         iVGA==
X-Gm-Message-State: AFqh2ko0iyvjSD3VIt4VUXfpy+AmlZ02vt1lGN7wZ/7YhmDtMNWOUbHw
        q8XrHVDzTkDNADE034q0D+xjxJHptvXbewDr
X-Google-Smtp-Source: AMrXdXv0NyU0AcpZZbfSeXYvUOr49creSV4/REWnnBUiPWihPTcc37l89FtBK8Bqe1AzKYygJE5ZvQ==
X-Received: by 2002:a05:622a:2612:b0:3a8:3058:db43 with SMTP id ci18-20020a05622a261200b003a83058db43mr2977966qtb.57.1671639398153;
        Wed, 21 Dec 2022 08:16:38 -0800 (PST)
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com. [209.85.222.180])
        by smtp.gmail.com with ESMTPSA id h26-20020ac8745a000000b00399fe4aac3esm9435168qtr.50.2022.12.21.08.16.32
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Dec 2022 08:16:32 -0800 (PST)
Received: by mail-qk1-f180.google.com with SMTP id pj1so7007619qkn.3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 08:16:32 -0800 (PST)
X-Received: by 2002:a05:620a:674:b0:6ff:a7de:ce22 with SMTP id
 a20-20020a05620a067400b006ffa7dece22mr76603qkh.72.1671639392425; Wed, 21 Dec
 2022 08:16:32 -0800 (PST)
MIME-Version: 1.0
References: <20221220141743.813176-1-brauner@kernel.org>
In-Reply-To: <20221220141743.813176-1-brauner@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 21 Dec 2022 08:16:16 -0800
X-Gmail-Original-Message-ID: <CAHk-=winz9C7v81xSboTO6P0H8aF8wAjM5vK6n2pKO2FmS5d7A@mail.gmail.com>
Message-ID: <CAHk-=winz9C7v81xSboTO6P0H8aF8wAjM5vK6n2pKO2FmS5d7A@mail.gmail.com>
Subject: Re: [GIT PULL] vfsuid fix for v6.2-rc1
To:     Christian Brauner <brauner@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Seth Forshee <sforshee@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 20, 2022 at 6:18 AM Christian Brauner <brauner@kernel.org> wrote:
>
> This moves the ima specific vfs{g,u}id_t comparison helpers out of the header
> and into the one file in ima where they are used. We shouldn't incentivize
> people to use them by placing them into the header. As discussed and suggested
> by Linus in [1] let's just define them locally in the one file in ima where
> they are used.
>
> Link: https://lore.kernel.org/lkml/CAHk-=wj+tqv2nyUZ5T5EwYWzDAAuhxQ+-DA2nC9yYOTUo5NOPg@mail.gmail.com [1]

That wasn't actually the correct link...

              Linus
