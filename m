Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25BC7665B06
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 13:08:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229501AbjAKMIX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 07:08:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231514AbjAKMIK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 07:08:10 -0500
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5123B92
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 04:08:08 -0800 (PST)
Received: by mail-yb1-xb2a.google.com with SMTP id 188so14759067ybi.9
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 04:08:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kmJ3yYULDZh/n/Ts/CIw+F5G8M6+xd7o3i732aR8bfU=;
        b=Huh5mGKh/5kG5fJLMYNPH7N0pSWybZghPelk0NUdJxECQjfmL+QRCFnkVZYZ4p+6iD
         U+QihvuYLnC/fu4YtVobiKMfwnj89zGyUkxMQNLkIvXiiPlansCrF7ZPHS4XRej3DbV6
         fdWAbhsdr/nCOV/rntZFIEmSK949BWpA3v5Sw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kmJ3yYULDZh/n/Ts/CIw+F5G8M6+xd7o3i732aR8bfU=;
        b=QPAc+hAOtnNC5HiKSkc5Fxt9KtQs5PKgnqwXH9nSrOKWI7Ybnz29EPUfmdW3HQe67L
         GfSaF9ociS+rGlbOjxXgoF1PsC1FfLGRRVrUcfmZmRMiEOOMLTWsW8zhSHjnfARi/0hM
         O2qmn2Yiws7mZsqhQBBoextk76gDqfIh0i9UM2N6GIRVXHNyowfwjhprwpLAPbOEv5L6
         uGD4YVLJ2fXJSpvJ/JcXE9sQAH4guQp1iDd6JuY1YEOcbcVM2G1yuLa+4SyBUuYz7yQq
         I6jyETcM1boUS6SfYnBhdBUeR4OQ25+WU7jzki8lWfgUTf90+V0GNiFhJ80ZiNGjWTpz
         pOSw==
X-Gm-Message-State: AFqh2krEU0rZmsF1PirQgxXMhNKMWh/MYGAkx58+9ckVVHM5t/uzhgb9
        OCzXFfB1dq91GPX2JhPfbT6UBFiViQ9J5qIp8M8=
X-Google-Smtp-Source: AMrXdXvmzEvgis5Of6Pt7Xh0a/z6pLQw3QUy93aWK32yWeLm89ANhS2n/0zTM2s9cNRSDg08HA71jg==
X-Received: by 2002:a05:6902:15cf:b0:798:e789:5996 with SMTP id l15-20020a05690215cf00b00798e7895996mr33459986ybu.46.1673438887765;
        Wed, 11 Jan 2023 04:08:07 -0800 (PST)
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com. [209.85.160.173])
        by smtp.gmail.com with ESMTPSA id o5-20020a05620a2a0500b006fcc437c2e8sm9004642qkp.44.2023.01.11.04.08.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Jan 2023 04:08:07 -0800 (PST)
Received: by mail-qt1-f173.google.com with SMTP id e22so1061129qts.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 04:08:06 -0800 (PST)
X-Received: by 2002:a05:622a:2598:b0:3ae:db1:185f with SMTP id
 cj24-20020a05622a259800b003ae0db1185fmr412604qtb.436.1673438886653; Wed, 11
 Jan 2023 04:08:06 -0800 (PST)
MIME-Version: 1.0
References: <20230101162910.710293-1-Jason@zx2c4.com> <20230101162910.710293-3-Jason@zx2c4.com>
 <Y7QIg/hAIk7eZE42@gmail.com> <CALCETrWdw5kxrtr4M7AkKYDOJEE1cU1wENWgmgOxn0rEJz4y3w@mail.gmail.com>
 <CAHk-=wg_6Uhkjy12Vq_hN6rQqGRP2nE15rkgiAo6Qay5aOeigg@mail.gmail.com>
 <Y7SDgtXayQCy6xT6@zx2c4.com> <CAHk-=whQdWFw+0eGttxsWBHZg1+uh=0MhxXYtvJGX4t9P1MgNw@mail.gmail.com>
 <874jt0kndq.fsf@oldenburg.str.redhat.com> <CAHk-=wg7vMC2VmSBdVw7EKV+7UDiftQEg3L+3Rc0rcjjfsvs5A@mail.gmail.com>
 <Y75k2KaDz2WdcXLk@sol.localdomain>
In-Reply-To: <Y75k2KaDz2WdcXLk@sol.localdomain>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 11 Jan 2023 06:07:50 -0600
X-Gmail-Original-Message-ID: <CAHk-=wga2A0T8a3L6KHPrxjShU5-m6t7t71RfHHLnFmA0__wtQ@mail.gmail.com>
Message-ID: <CAHk-=wga2A0T8a3L6KHPrxjShU5-m6t7t71RfHHLnFmA0__wtQ@mail.gmail.com>
Subject: Re: [PATCH v14 2/7] mm: add VM_DROPPABLE for designating always
 lazily freeable mappings
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Florian Weimer <fweimer@redhat.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, tglx@linutronix.de,
        linux-crypto@vger.kernel.org, linux-api@vger.kernel.org,
        x86@kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>,
        "Carlos O'Donell" <carlos@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>,
        Christian Brauner <brauner@kernel.org>, linux-mm@kvack.org,
        mlichvar@redhat.com
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

On Wed, Jan 11, 2023 at 1:27 AM Eric Biggers <ebiggers@kernel.org> wrote:
>
> How would userspace decide when to reseed its CRNGs, then?

.. and that is relevant to all the VM discussions exactly why?

                Linus
