Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95C3F66097D
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 23:28:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235973AbjAFW2X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 17:28:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231470AbjAFW2U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 17:28:20 -0500
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7FC085CA8
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 14:28:19 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id h21so3265824qta.12
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jan 2023 14:28:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QXQOUJjcoX1hrsbbTN+Z+gwuy5Yx5WlxprMyzhgXuL0=;
        b=FSwATMmksAKMdpu1wQNSAU4HfcxbtJpqP5jg4jxAia7ZjIAJt4LpHBViEiX5ZkvhWV
         XA077dHR8grrfxkhZnG7h3W83Y6u9reeX0IgVJqi16hhxZZAnt1gx0ImUTDz0+wZcva6
         cB9bwoRmvnDNak/FU5AzQ18NzyvaFmMkZwKoA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QXQOUJjcoX1hrsbbTN+Z+gwuy5Yx5WlxprMyzhgXuL0=;
        b=cNvLH4g20cnf/kUlWYGMzSFtDTcinbHXTGErEBUwmEm3TfvsycwoPTF8EtNR0uMqHw
         ZefZEfxYKJHkN1cK4SEBfyuOh8TyGHEQWoDXHQ4dNAKy2Odnw+Tg7j7E1W1cIMPIym7Y
         fKf/Ln2I92EyAONO3ZCCglkmRNhs8LTs89C8kaZXOHrju18QOx/F6erEmmbVxpT0Q/p+
         aQCBwbOHk1ff6myurn1IGHORG0qDJgOkADJWEVKMRX+o0qViALGKurQtyiCLl50zUwgB
         OTWZbhcwlBJ7DmNo0VXapp4LfcC+F6mpmSs/RNiKXBFOX0gKh4SOhIkAByXHTdV1b5lE
         VD5w==
X-Gm-Message-State: AFqh2krAy4qlbh9V41XSSwBXnTB3qKhpOffCO4A1257R5cmkVWrtbsxr
        CSCSRVRvowcA2fRidMlneCdWgHHggjyt3ZXv
X-Google-Smtp-Source: AMrXdXs6UJGvtVcyw5OnYlPcgTobaYwaHQpVM65X3yTmCHiHvsIOJ8HRQrOQ5vtOg79RlrG5cCyvJg==
X-Received: by 2002:ac8:6f19:0:b0:3a9:84bd:7cc5 with SMTP id bs25-20020ac86f19000000b003a984bd7cc5mr86754918qtb.39.1673044098777;
        Fri, 06 Jan 2023 14:28:18 -0800 (PST)
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com. [209.85.219.53])
        by smtp.gmail.com with ESMTPSA id bj3-20020a05620a190300b00705975d0054sm1241199qkb.19.2023.01.06.14.28.16
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Jan 2023 14:28:17 -0800 (PST)
Received: by mail-qv1-f53.google.com with SMTP id i12so1957616qvs.2
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jan 2023 14:28:16 -0800 (PST)
X-Received: by 2002:a0c:df09:0:b0:4f0:656b:c275 with SMTP id
 g9-20020a0cdf09000000b004f0656bc275mr3791255qvl.129.1673044096460; Fri, 06
 Jan 2023 14:28:16 -0800 (PST)
MIME-Version: 1.0
References: <Y7dPV5BK6jk1KvX+@zx2c4.com> <20230106030156.3258307-1-Jason@zx2c4.com>
 <CAHk-=wjin0Rn6j+EvYV9pzrbA0G2xnHKdp_EAB6XnansQ8kpUA@mail.gmail.com> <CAA25o9Sbkg=qD+DH-aqXY9H5R_oBtePcnqagwAGCgoUk8D-Vyg@mail.gmail.com>
In-Reply-To: <CAA25o9Sbkg=qD+DH-aqXY9H5R_oBtePcnqagwAGCgoUk8D-Vyg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 6 Jan 2023 14:28:00 -0800
X-Gmail-Original-Message-ID: <CAHk-=wi60PhJRzaBJ9uvVCpOpqSsKy=oXkGDq7t844BJ6dRcmA@mail.gmail.com>
Message-ID: <CAHk-=wi60PhJRzaBJ9uvVCpOpqSsKy=oXkGDq7t844BJ6dRcmA@mail.gmail.com>
Subject: Re: [PATCH v2] tpm: Allow system suspend to continue when TPM suspend fails
To:     Luigi Semenzato <semenzato@chromium.org>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>, Jan Dabros <jsd@semihalf.com>,
        regressions@lists.linux.dev, LKML <linux-kernel@vger.kernel.org>,
        linux-integrity@vger.kernel.org,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Johannes Altmanninger <aclopte@gmail.com>,
        stable@vger.kernel.org, Vlastimil Babka <vbabka@suse.cz>,
        tbroch@chromium.org, dbasehore@chromium.org,
        Kees Cook <keescook@chromium.org>
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

On Fri, Jan 6, 2023 at 12:04 PM Luigi Semenzato <semenzato@chromium.org> wrote:
>
> I think it's fine to go ahead with your change, for multiple reasons.

Ok, I've applied the patch (although I did end up editing it to use
dev_err() before doing that just to make myself happier about the
printout).

            Linus
