Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C52A25FBD8E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 00:01:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229477AbiJKWBL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 18:01:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiJKWBI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 18:01:08 -0400
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC7665FBE
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 15:01:06 -0700 (PDT)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-134072c15c1so14325234fac.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 15:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MLQ5H7VESPaoiRxKUhIPt15sPGVXkePVqvxi8nROcR0=;
        b=fJgT1fNJ1aTxX12kjM1cAQEVjPj1Z/0sqrF8ePDLrQC1i5KTJeRhzvI35WjgpWw2B5
         opEblo3/z61LnB0BaDA9P0Ne5irPXIaqnse07KrqhvExJrCKNJ+21uSW3qy55iQYqc6v
         q+uZmglxGfJw5SPfSGWM/NUXdTY+z/3jdUkJM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MLQ5H7VESPaoiRxKUhIPt15sPGVXkePVqvxi8nROcR0=;
        b=p9GMLLI5ZdVGwXJWpAeIGO1agoWij7H9w9SLQ/OuAWJgFg5Vav1UGCYD6cgpZb1C8P
         7oZbkKZki9/DY8Tkwm+BMNE2xikMMP25BcrzyxV/Mm1zwpgwaVUb1U3Xw8Y3nb+rZ5e2
         wAOYyW11GAVrVQRkzeMtdMrzZi5QNQU+Ea3/avZ/CGEDQcAMHHCXR9oOVw6tSKSRxBDA
         hMapE39Y3Z72x/Z62qi8dAD/Gze276v7PPBLmAnhsPohfQgJfghWm3QPzYly7B45mEhV
         4wcHdyfZl9TA4EixXPk5xayVtiEj8lQTKgtEJkU0e1/EZQZI5tSj1e72EvyE+uz5gD9W
         DO1Q==
X-Gm-Message-State: ACrzQf2uxMGYy0tQvNkl2h28HHxyyZjnBiEJ7qxvackYSHsBwk9iEj+C
        CWgtuC/3YI6PMCP5tR1jGddL6z2Dr8ThVA==
X-Google-Smtp-Source: AMsMyM5u3nuotNbQ9pM7DqoYPCcB6Ct+1pgS+yKgUdw0NlLzwUlu9Bc8z7zZB6B19PBdZ7gTVrRPNQ==
X-Received: by 2002:a05:6870:58a1:b0:130:c1fa:5f77 with SMTP id be33-20020a05687058a100b00130c1fa5f77mr734701oab.223.1665525664681;
        Tue, 11 Oct 2022 15:01:04 -0700 (PDT)
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com. [209.85.167.175])
        by smtp.gmail.com with ESMTPSA id c38-20020a05687047a600b0012779ba00fesm453282oaq.2.2022.10.11.15.01.01
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Oct 2022 15:01:02 -0700 (PDT)
Received: by mail-oi1-f175.google.com with SMTP id w196so10981724oiw.8
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 15:01:01 -0700 (PDT)
X-Received: by 2002:aca:b957:0:b0:351:4ecf:477d with SMTP id
 j84-20020acab957000000b003514ecf477dmr627093oif.126.1665525661470; Tue, 11
 Oct 2022 15:01:01 -0700 (PDT)
MIME-Version: 1.0
References: <20221008132113.919b9b894426297de78ac00f@linux-foundation.org>
 <CAHk-=wigZoriP8ZB+V87Jf+EQV=ka6DQe_HCAQmh3Dmus2FFhw@mail.gmail.com>
 <Y0UoO2+NsJjbZtaf@hirez.programming.kicks-ass.net> <20221011184444.npthr2pmzqb32x6z@treble>
 <20221011185907.s3kakdlrxcqr6boh@treble> <20221011190548.blixlqj6dripitaf@treble>
In-Reply-To: <20221011190548.blixlqj6dripitaf@treble>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 11 Oct 2022 15:00:45 -0700
X-Gmail-Original-Message-ID: <CAHk-=whR5j7e0_w_9Ph9ctEnrYKn6tcPjQRHY=u5B+jxDwHvXQ@mail.gmail.com>
Message-ID: <CAHk-=whR5j7e0_w_9Ph9ctEnrYKn6tcPjQRHY=u5B+jxDwHvXQ@mail.gmail.com>
Subject: Re: [PATCH] kasan: disable stackleak plugin in report code
To:     Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        mm-commits@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
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

On Tue, Oct 11, 2022 at 12:05 PM Josh Poimboeuf <jpoimboe@kernel.org> wrote:
>
> kasan_report() has a uaccess critical section which can't have any
> instrumentation calls in the middle.  Disable the stackleak plugin for
> the report code.

I see Andrew already picked this up, but I can confirm that it
obviously fixes the problem here for me.

I'll get it the usual channels from Andrew.

Thanks,
            Linus
