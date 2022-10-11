Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E4A95FB8F1
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 19:09:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbiJKRJB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 13:09:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbiJKRI4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 13:08:56 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 145B9A8CD6
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 10:08:55 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id u15so10639142oie.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 10:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=J3Fqg+9feMJbILjgk++Bkfbac3ec4L/8fKPKqGtQdGs=;
        b=GlTdZOuh8v9Ksjs86dNpq80JgWCOer6MArumLBeRkLd5PJv7vki/Vwx+VjAQsfVNu6
         h4GqegcDW9PFftM1lZ8QwxD2jF7EivdL5mI6xa+V5EK45papkiZokO1I0lq0Em9XF8zp
         zCjzqEDXLzDrBhiEidB8bVRiD3fZbYaujfhTg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J3Fqg+9feMJbILjgk++Bkfbac3ec4L/8fKPKqGtQdGs=;
        b=foBFMPlbfROOtH1AaZ5Js8VroYux5hZNeysp+FNm5q81KpCTwnYHx/It9lqhbM2MG/
         vRAK1rRk7nXF753Gp2c7RunQehUpXy7fhrjEzalgJD2B0x/uOOVp2pc0svsXvSElytY8
         DnBnBjI1c+nazd5QP5G/IKPCb0mvIExpkFJTdc4jj9JcJYU/JL76CcqsayNi++eSlE/R
         16Z8EKoUI/G2YypfICS4KYKwO8wI9cVarZ2aW0cpJUXHk1xt7Sd7mnYyD6vG+ysplKAO
         yS+rmwl1BHXA35gtkQRzfjfvzReon0biWoWN9YSX3URCiU/35NOHvDaj+i5bGlMIFY9a
         ZvCw==
X-Gm-Message-State: ACrzQf3iZ7zBVbzhRWCChFBViFwwF1VdOHAXFLC3pIsAukXf1idtuaUG
        P4UnUlHNucHz9yOnILphNZjhKlbs9usu+A==
X-Google-Smtp-Source: AMsMyM5ENUHQR1B300XWm8Xpy18GmjWO8rO/uWks7O93v6YBk1DXgWelOKM4U06B52SoMsqSurJ0Fw==
X-Received: by 2002:a05:6808:1a27:b0:354:55e5:9777 with SMTP id bk39-20020a0568081a2700b0035455e59777mr38457oib.267.1665508133611;
        Tue, 11 Oct 2022 10:08:53 -0700 (PDT)
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com. [209.85.160.54])
        by smtp.gmail.com with ESMTPSA id bi35-20020a05680818a300b00354978180d8sm1899050oib.22.2022.10.11.10.08.51
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Oct 2022 10:08:51 -0700 (PDT)
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-132b8f6f1b2so16608417fac.11
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 10:08:51 -0700 (PDT)
X-Received: by 2002:a05:6870:c0c9:b0:127:c4df:5b50 with SMTP id
 e9-20020a056870c0c900b00127c4df5b50mr87866oad.126.1665508131198; Tue, 11 Oct
 2022 10:08:51 -0700 (PDT)
MIME-Version: 1.0
References: <20221008132113.919b9b894426297de78ac00f@linux-foundation.org>
 <CAHk-=wigZoriP8ZB+V87Jf+EQV=ka6DQe_HCAQmh3Dmus2FFhw@mail.gmail.com> <Y0UoO2+NsJjbZtaf@hirez.programming.kicks-ass.net>
In-Reply-To: <Y0UoO2+NsJjbZtaf@hirez.programming.kicks-ass.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 11 Oct 2022 10:08:35 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgGAtKxPNBV+u7+bgNt3g47G+i4CV8dq-s-hExhU68gKQ@mail.gmail.com>
Message-ID: <CAHk-=wgGAtKxPNBV+u7+bgNt3g47G+i4CV8dq-s-hExhU68gKQ@mail.gmail.com>
Subject: Re: [GIT PULL] MM updates for 6.1-rc1
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
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

On Tue, Oct 11, 2022 at 1:24 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> I've not yet tried to reproduce, I'm taking this is allyesconfig or
> something glorious like that? LLVM-15 ?

Just a bog-standard allmodconfig build with gcc 12.2.1 as packaged by Fedora.

               Linus
