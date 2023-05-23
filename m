Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F321370CFE5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 02:57:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233958AbjEWA5p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 20:57:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235199AbjEWA5S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 20:57:18 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69E0E270A
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 17:53:13 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1ae3f74c98bso40955ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 17:53:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684803121; x=1687395121;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=0t+3evlCLlh8Vv6Mnjo2JSq0Q8GfskIouq/uyhSRTHA=;
        b=l0s1tfsBkLul0R6dsA3XF8f9SMtZBnuThFwzCYzha5dJkSxN+5/cO73DPsm5Gs+psh
         /PNQHyOsLqxoSCW3GqyV4R6dpa4BX7UiSKkWKNKBZKjwdQLyewJvBTpESXsAUHY9L5HX
         NGn7zMYU7cBaGQH/pLOztrjas6T2eu3BjvTy8MeCa3xXd8fzPPEgOh6YnOEbMlYqHOvU
         aboAd0tWpjiN165/faQOf4W0GXsyLoFZtsSwZd5WUVV10m1vkLtxCRzsmxm51qxscfUC
         9dSkcrdsgWvXmvpk2aqXGvY02KRADCtt3gFRPWrK3O4kpdFgTmtMN2TAN2NEX/vIc7V1
         ZPPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684803121; x=1687395121;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0t+3evlCLlh8Vv6Mnjo2JSq0Q8GfskIouq/uyhSRTHA=;
        b=ZODDEvIPAcnbQSE5UkJr1T6JNKKUUZs+ABkorS6KjT9wUMrT1NHfeZbq2EoHkHMvvn
         UwHJ21wnPqk4nnQp0p+YdtmhzmyQhs4wVWVYUzn/Lx//7XbRYYJ3IjvnQzmY853JYjoC
         60WfiFMZn8ceLjEOhF3rCdLuWPnlWTv1inc3MXxYSIJLUExLK2qFr278MWXUw5q+SEL6
         cM5KcKA7ZeS/tPpMS1olJFaZlvFh83VNQYqH95H3umSw3/zvaRAB0Kc3oIkU5fOwFYYv
         d5qd1piBRLzowRoRy8tnUUq2sQH5FkZl4zSiMEQZRc+pk5oOvBnP0bPen6r82/PteutL
         Uu/g==
X-Gm-Message-State: AC+VfDysKX4Xw9CNkEuNOfL+64hF74XsMqeXAQJZp4mpXXBhq1wZ3feg
        V8ATI83n7fym0FNrwkp8Q6oFfA==
X-Google-Smtp-Source: ACHHUZ4PQwfJjRZAuHW1FOPTNIN+gBe7njrrVyuW9BbXkCLmIROCieXX12Bmtt2AUlqiHDd7O/dfpw==
X-Received: by 2002:a17:902:e74e:b0:1a8:96c:738 with SMTP id p14-20020a170902e74e00b001a8096c0738mr159173plf.2.1684803121320;
        Mon, 22 May 2023 17:52:01 -0700 (PDT)
Received: from [2620:0:1008:11:2b0e:a3da:5943:182] ([2620:0:1008:11:2b0e:a3da:5943:182])
        by smtp.gmail.com with ESMTPSA id h7-20020a170902f7c700b001a19196af48sm5428262plw.64.2023.05.22.17.52.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 17:52:00 -0700 (PDT)
Date:   Mon, 22 May 2023 17:51:59 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>, Alex Shi <alexs@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Matthew Wilcox <willy@infradead.org>,
        Alexander Duyck <alexanderduyck@fb.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [patch] mm, debug: allow suppressing panic on CONFIG_DEBUG_VM
 checks
In-Reply-To: <CAHk-=wg+PHQ9PhTeQOb7Fh5Qf3zkzG5J1h3D=eOY-2AsYXhU4Q@mail.gmail.com>
Message-ID: <b2bf7ae9-983d-6c20-0781-7f37a4454bfd@google.com>
References: <c9abf109-80f2-88f5-4aae-d6fd4a30bcd3@google.com> <b4dce681-e53c-a6fd-2dab-62a82ebc6dff@redhat.com> <53dd9df8-e88f-f466-89f9-3fa141a10267@google.com> <CAHk-=wg+PHQ9PhTeQOb7Fh5Qf3zkzG5J1h3D=eOY-2AsYXhU4Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="2003089352-356300863-1684803120=:4168530"
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--2003089352-356300863-1684803120=:4168530
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Mon, 22 May 2023, Linus Torvalds wrote:

> On Mon, May 22, 2023 at 11:39 AM David Rientjes <rientjes@google.com> wrote:
> >
> > I think VM_BUG_ON*() and friends are used to crash the kernel for
> > debugging so that we get a crash dump and because some variants don't
> > exist for VM_WARN_ON().
> 
> I do think that from a VM developer standpoint, I think it should be
> fine to just effectively turn VM_BUG_ON() into WARN_ON_ONCE() together
> with panic_on_warn.
> 
> Maybe we could even extend 'panic_on_warn' to be a bitmap and
> effectively have a "don't panic on non-VM warnings" option.
> 

I hadn't thought of that approach, it would definitely help us achieve our 
goal of emitting warnings on a small set of production hosts that we don't 
want to crash.  It's also very clean.

Right now kernel.panic_on_warn can either be 0 or 1.  We can keep the 
lowest bit to be "panic on all warnings" and then bit-1 as "panic on debug 
VM warnings."  When CONFIG_DEBUG_VM is enabled, set the new bit by 
default so there's no behavior change.

Then, we can keep VM_BUG_ON*() and friends around and extend them to check 
whether they should BUG() after the WARN_ON(1) or not.

On our production hosts, we'll just set kernel.panic_on_oom to 0.

I'll give it a few days to see if anybody else has any comments or 
concerns; if not, I'll send a v2 based on this.
--2003089352-356300863-1684803120=:4168530--
