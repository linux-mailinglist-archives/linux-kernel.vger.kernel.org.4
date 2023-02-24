Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20F4E6A23F3
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 22:49:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbjBXVrJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 16:47:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjBXVrI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 16:47:08 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0730666976
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 13:47:07 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id ck15so2996717edb.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 13:47:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LsTViMz2hRqetPY4sQxKqb1vlEy1xBU8MeejgMSjr1c=;
        b=gkf8frOWVmniar7ngn/Zq33yG209HWEzVqAr1yTwb3Gui4OURdAjyWRJP9b3m76d8n
         hnifc+WqEM1GMnUvW9ndHnJ6Q2cuKJ0hZCHkFclGxYTSDlypyNkzOru+VCjyGH1Fr0zo
         6Vx8hCsgiWNvsQnTUtamL5i3qi4sFqBggvjUs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LsTViMz2hRqetPY4sQxKqb1vlEy1xBU8MeejgMSjr1c=;
        b=di4br32KHS1WO4ChHxBMCDtKiju8F32PLMqkU1etg2XF7vcz8fUoc/UKZPTPfS9lCn
         SXccmYph6dZHcpzOZnHPkPgQXrMqcKecQCu//NAMSYZYnliU133X2gpAzxlcb6nJhG/o
         YKeG2AxyzURfwF6RwLkJyFaZUKS5kkp4T1RUwmFXg1adti9L8fFUQX7Walh5MOqGV2nP
         7/4BXcbFxp060GsIQu/W92rmRGTl0VdsTX6MMSlxWrqKEGQa/c/H6h2HLOa4Pins4WYq
         cqjKfy7c4sfJQL4tZLoV5J9j6RoQr80ODo2y/vvYkvsiwYxu/F+IQlmx4G44MKbdg9xP
         rMDw==
X-Gm-Message-State: AO0yUKWd99Tzw7yik/c65mqiPtoQ1Qpy9e7QqvfzhBZ9xh1eD6jwAJsp
        OX0ye9eh1GwDU7FS/X7LCPqv9Y6rPnM8adwCZsAfMQ==
X-Google-Smtp-Source: AK7set9JVnCIX9ZgM5ELnZv2kYq8Mi/GD2Df8wXvRkgF4eVmTu++3YN8a/1s8LU9kOyFbekg5MWDfA==
X-Received: by 2002:a17:906:4909:b0:8af:2191:89a6 with SMTP id b9-20020a170906490900b008af219189a6mr22134771ejq.72.1677275225124;
        Fri, 24 Feb 2023 13:47:05 -0800 (PST)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com. [209.85.208.53])
        by smtp.gmail.com with ESMTPSA id o5-20020a17090611c500b008b907006d5dsm27325eja.173.2023.02.24.13.47.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Feb 2023 13:47:04 -0800 (PST)
Received: by mail-ed1-f53.google.com with SMTP id o15so263479edr.13
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 13:47:04 -0800 (PST)
X-Received: by 2002:a50:8e51:0:b0:4af:70a5:4408 with SMTP id
 17-20020a508e51000000b004af70a54408mr3218039edx.5.1677275224153; Fri, 24 Feb
 2023 13:47:04 -0800 (PST)
MIME-Version: 1.0
References: <Y/SGAafMEGBn4fWy@8bytes.org>
In-Reply-To: <Y/SGAafMEGBn4fWy@8bytes.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 24 Feb 2023 13:46:47 -0800
X-Gmail-Original-Message-ID: <CAHk-=wg71g9S0F8V-=97XQsaf6Edbxhfx-xS+x894w8sMZW+=w@mail.gmail.com>
Message-ID: <CAHk-=wg71g9S0F8V-=97XQsaf6Edbxhfx-xS+x894w8sMZW+=w@mail.gmail.com>
Subject: Re: [git pull] IOMMU Updates for Linux v6.3
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev
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

On Tue, Feb 21, 2023 at 12:51 AM Joerg Roedel <joro@8bytes.org> wrote:
>
> Please note the first item in the tag-message, there is some potential
> for conflicts between these changes and other trees due to changed
> function signatures.

Ok. I wil be doing x86-64 and arm64 allmodconfig builds, but if there
are any cases outside of that set that triggers, I won't norice.

That _should_ certainly cover the majority of any new code that might
have a semantic conflict, though.

             Linus
