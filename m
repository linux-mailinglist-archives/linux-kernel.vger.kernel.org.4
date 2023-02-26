Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4887C6A2D2B
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Feb 2023 03:44:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbjBZCoL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Feb 2023 21:44:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjBZCoK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Feb 2023 21:44:10 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99056E3AE
        for <linux-kernel@vger.kernel.org>; Sat, 25 Feb 2023 18:44:08 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id da10so12567879edb.3
        for <linux-kernel@vger.kernel.org>; Sat, 25 Feb 2023 18:44:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WxKXjplYACiN9YJ/Px+I865g0ZB/otSoANGJeT3uzhs=;
        b=ZZeR9NrMwOaCFPprgHZ/OmapCRI3dTo+lQYefzW6ZLqWOCyZ3ci6NdLzVqUr/37pxs
         lw/zA0D8WdBuAjR40t4iLU6BduMi7UY53B6jlLq5M8sTPQxgI7SFy0KteypniL5J//QY
         mkd3wwJFchITDtAma/D4k9xVBhfmyDWPtluA0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WxKXjplYACiN9YJ/Px+I865g0ZB/otSoANGJeT3uzhs=;
        b=1QAAow9DExD/ia0WY0226z8fVPYUfmBh26So7Rmoe+Z7w0+YkbPF6+zWXdD4UHX1Rp
         4kPZEO14BSgmAuT/d2eMuPMouqW1CZOFrVNx1q5nmI2S5vhSf25OZmmK6cTun9IYCtyV
         53h/bJXVk3908Y+usZUYZ3nSLaim6Q8RzVgWn+EJc3/aLfhdGTUuluWSvj9seEAzIKlz
         Sut40BqXbQ9CG4yVxEKqj+bWBDDtM28aMuwzGS1RI6Yj27g7Z1WcN8GnOfUeIxZZ0TC6
         v8KFpcjndLgPf0iTDCMIJ5corphcFjLiPkAnmabRiaZIi2QtupkYEkbf0crhzXgdX7Vl
         QG1A==
X-Gm-Message-State: AO0yUKV3ivyAK199VBXifHk5ld/xDu7mY4sACydqD+fBMiKTk6n1LE8H
        roac5//0Oxcdh3cCk0xrkCXEb7IgzEdnVW9/HvxVOg==
X-Google-Smtp-Source: AK7set9ev8eV1S4lObZLYg2j8OlwSKNJ+SoZP8WdSVIUEThtwa6rqpDkpfzjA23wlHWaL0cYvIIq9w==
X-Received: by 2002:a17:906:22ce:b0:8b1:bab0:aa3d with SMTP id q14-20020a17090622ce00b008b1bab0aa3dmr32770102eja.8.1677379446661;
        Sat, 25 Feb 2023 18:44:06 -0800 (PST)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com. [209.85.208.54])
        by smtp.gmail.com with ESMTPSA id os6-20020a170906af6600b008f7f6943d1dsm1450813ejb.42.2023.02.25.18.44.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Feb 2023 18:44:06 -0800 (PST)
Received: by mail-ed1-f54.google.com with SMTP id o12so12444995edb.9
        for <linux-kernel@vger.kernel.org>; Sat, 25 Feb 2023 18:44:06 -0800 (PST)
X-Received: by 2002:a50:d619:0:b0:4ab:3a49:68b9 with SMTP id
 x25-20020a50d619000000b004ab3a4968b9mr9683417edi.5.1677379445707; Sat, 25 Feb
 2023 18:44:05 -0800 (PST)
MIME-Version: 1.0
References: <20230220135225.91b0f28344c01d5306c31230@linux-foundation.org>
In-Reply-To: <20230220135225.91b0f28344c01d5306c31230@linux-foundation.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 25 Feb 2023 18:43:49 -0800
X-Gmail-Original-Message-ID: <CAHk-=whVN2gKO_7UvMqgG8cetrVs3BCTxQovJvhC5x7AcJDJgQ@mail.gmail.com>
Message-ID: <CAHk-=whVN2gKO_7UvMqgG8cetrVs3BCTxQovJvhC5x7AcJDJgQ@mail.gmail.com>
Subject: Re: [GIT PULL] MM updates for 6.3-rc1
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, mm-commits@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 20, 2023 at 1:52=E2=80=AFPM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
>
> Linus, please merge this cycle's MM updates.

Hmm. Just a note to let you know that I'm bisecting google-chrome
dumping core, and it seems to be due to something in this pull.

I've got a couple of hundred commits to go, so let's see what it
bisects to, but right now all the bad state came from this pull,
afaik.

Maybe it's a false alarm, but it seems to be consistent so far.

Will update when I've bisected closer.

                  Linus
