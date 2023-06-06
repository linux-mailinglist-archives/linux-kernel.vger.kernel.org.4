Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EA477250AE
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 01:20:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239819AbjFFXUO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 19:20:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240321AbjFFXT1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 19:19:27 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EF982102
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 16:18:51 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-565ba2c7554so66762377b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 16:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686093530; x=1688685530;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9wMQpL8mT6QlCCs1bXrVw+rZK5wYXsmA2UlxqlGl7R0=;
        b=KLfXcWyrdR+obKSMHxp4g6iQaKYQlgTEDHnSvEqd1pr5TquZGqzxtQH7J0TtNrk9t9
         wSC1wIZPg1Y7kJBFH4wCkk9fmF7+dRl1AhQA8+s1UdIRvrXCNBFeFfckgm6QE4lMZlE8
         7xNxP+/xT9Hodt7l6CLuplh42dj7XGAVN8qoGAIItLVvIYl74Jluk/rJcWCGzFOFH7Qe
         8cayTUAf71/QVjLKPsLixZFvLBnERD2oXEEAhfHTSKgOqENgOdwRbKjgDfgTex6odnGp
         KPnHV5HqHjwMLZniSQpKrASM337DwMbF4olR9iDRllw+6epc1QMpo8+70hdqIY8c9Kcy
         4R+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686093530; x=1688685530;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9wMQpL8mT6QlCCs1bXrVw+rZK5wYXsmA2UlxqlGl7R0=;
        b=haOI8TPtprpMBfOa43M8MEmplEdq6n/fq72DNVrmCeDT1eM64zQde91i5JqHz+c+Ra
         Bl+IxiLZbR+3mhrJXxTRXM7pya4fttDNqgiPx/dbOpcFg57pOHzwl8yWPfeiBRi2/aih
         xpBEbOzC1HGGmWS/0Y8XHl1ZpXto1YIEgNkCVaMASM03u05Ml3/Sax4qkzPiI5UDeJZN
         rK4ViKX2YXM7bNsVducCafYOszbMB5P/sITSOx8xAYyB58YRt9k2S5s9K41mzQxFftNc
         /CsNEXARjrDrRuU3qpinckeA+yxmAugMNy2beaqLg3mqvjxe0fOihgbnvCLqTrkU9o06
         tSzg==
X-Gm-Message-State: AC+VfDz3kqhzETIZ5luX1q6dqk96xC/EtRBVHE0g8hSsI1+DmDjyYUWR
        SNwlQCknqPG5ph057/gAlD33phORT9Pt0dA8X8f2lw==
X-Google-Smtp-Source: ACHHUZ4fHV4VNm6Tfuv+XZiih6LcClaZx9DkWIWYCsJ5GbObBBmqd3RvGzBQucPMEtOuwSefaUouhx1Rv5K7nhN0pVo=
X-Received: by 2002:a25:ad66:0:b0:b99:53e9:ba97 with SMTP id
 l38-20020a25ad66000000b00b9953e9ba97mr3440908ybe.43.1686093530541; Tue, 06
 Jun 2023 16:18:50 -0700 (PDT)
MIME-Version: 1.0
References: <CA+EESO4uO84SSnBhArH4HvLNhaUQ5nZKNKXqxRCyjniNVjp0Aw@mail.gmail.com>
 <ZC8BgFSFC3cDcAcS@x1n> <27ac2f51-e2bf-7645-7a76-0684248a5902@redhat.com>
 <ZDbVMk0trT5UaqaA@x1n> <3059388f-1604-c326-c66f-c2e0f9bb6cbf@redhat.com>
 <ZDghhTH2KtCeAwcZ@x1n> <6403a950-7367-0b00-8cd5-2f0a32dac953@suse.cz>
In-Reply-To: <6403a950-7367-0b00-8cd5-2f0a32dac953@suse.cz>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Tue, 6 Jun 2023 16:18:39 -0700
Message-ID: <CAJuCfpFddcMRH8pNOE816ZrQr5qvrccxFjJqNj5JRPWkv+u=uA@mail.gmail.com>
Subject: Re: RFC for new feature to move pages from one vma to another without split
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
        Lokesh Gidra <lokeshgidra@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Brian Geffon <bgeffon@google.com>,
        Kalesh Singh <kaleshsingh@google.com>,
        Nicolas Geoffray <ngeoffray@google.com>,
        Jared Duke <jdduke@google.com>,
        android-mm <android-mm@google.com>,
        Blake Caldwell <blake.caldwell@colorado.edu>,
        Mike Rapoport <rppt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 6, 2023 at 1:15=E2=80=AFPM Vlastimil Babka <vbabka@suse.cz> wro=
te:
>
> On 4/13/23 17:36, Peter Xu wrote:
> > On Thu, Apr 13, 2023 at 10:10:44AM +0200, David Hildenbrand wrote:
> >> So instead, we consider the whole address space as a virtual, anon fil=
e,
> >> starting at offset 0. The pgoff of a VMA is then simply the offset in =
that
> >> virtual file (easily computed from the start of the VMA), and VMA merg=
ing is
> >> just the same as for an ordinary file.
> >
> > Interesting point, thanks!
>
> FYI, I've advised a master thesis exploring how to update page->index dur=
ing
> mremap() to keep things mergeable:
>
> https://dspace.cuni.cz/bitstream/handle/20.500.11956/176288/120426800.pdf
>
> I think the last RFC posting was:
> https://lore.kernel.org/all/20220516125405.1675-1-matenajakub@gmail.com/
>
> It was really tricky for the general case. Maybe it would be more feasibl=
e
> for the limited case Lokesh describes, if we could be sure the pages that
> are moved aren't mapped anywhere else.

Lokesh asked me to pick up this work and prepare patches for
upstreaming. I'll start working on them after I finish with per-vma
lock support for swap and userfaultd (targeting later this week).
Thanks for all the input folks!
