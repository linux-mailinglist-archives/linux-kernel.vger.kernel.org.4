Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B828B679ED3
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 17:36:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233424AbjAXQgP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 11:36:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229792AbjAXQgH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 11:36:07 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4531D4C0E2
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 08:35:42 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id k13so15317361plg.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 08:35:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=myuCtUOCNwRL65a5NC4kkkdDnCKnQf+202qIqkQ14wM=;
        b=CgINPkv1EzFBUzHKFAM2E6gCeNTtldkFtpYuu4lb9ru/hkyJGZkskDSe37EzfX6PWa
         pOgh8ph+AZ06br1aNHRvBR833veUL3xtrZYZl4ZUsPQrLa0Z8m33uiOJ+0Ld+faI4v3z
         I5t3uwk54EFM4e1hHMniWSHKLZzihLh128Epvy8JWQe3vNMBZD/Nenrpgn2sd1pRXdg8
         VVCmFiQ3oBbARdrvVKAOm0lei/s6FxbHjPkkhVnoTmi2BSkTws8y2B4OdcG+UIdDcb5n
         2zuhaH+e5gP9Y7aAEcJ9wPuwB5ACqvqnjd51kXRxHkAcfPjUL0X12AJG0NnJ+psHDBR0
         gplQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=myuCtUOCNwRL65a5NC4kkkdDnCKnQf+202qIqkQ14wM=;
        b=n8c/7gFQHwsTx5g3YEFDvTaUfi+So39sJHBSZgurBE3Ip9hJlKm/bsxV4zsKHRqyL9
         mii/U7B4CLETEjls6yM+xvGtu2GFZiuCoBxRHwJ2H64iPzX1iCqAf3WnBjZ5PkLiTaHt
         JfEapyIVXmgX5ueibOEX0Zz+rfN0IVoqNU8OBpBvTsclqjfhRZsCXqtAHENidtEiQyIM
         JOrEc7quXdVj2FU6LEywRIxl1dOofwVbGcs3Foo7FdksGxp2T/ALrthpOF36PbNlVE9R
         52jfiun3g0XvBUQ1cDrIQKi9Yc3kouVAaT7NEKNS3lVHP+WXLxBA329iSjm51t4iHsWK
         8LIA==
X-Gm-Message-State: AO0yUKUSOfSZlyVbuqn2KZvhq3apxos+5yhkYjUI7iy+LWPrZSH4YEp9
        Zd4xHwcf3gzGxrAsk+E52UwD3A==
X-Google-Smtp-Source: AK7set/o+kLOthxW6KkL25hhQltt6yuXi9bisbGa6M67GmYA6V/XIgMgDVACRYwB5d7opWgjyDnX2Q==
X-Received: by 2002:a17:902:c9d2:b0:189:6624:58c0 with SMTP id q18-20020a170902c9d200b00189662458c0mr181560pld.3.1674578141120;
        Tue, 24 Jan 2023 08:35:41 -0800 (PST)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id jf1-20020a170903268100b001960690b5d4sm1907686plb.59.2023.01.24.08.35.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 08:35:40 -0800 (PST)
Date:   Tue, 24 Jan 2023 16:35:37 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Dionna Amalie Glaze <dionnaglaze@google.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Tom Lendacky <Thomas.Lendacky@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Joerg Roedel <jroedel@suse.de>,
        Peter Gonda <pgonda@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Venu Busireddy <venu.busireddy@oracle.com>,
        Michael Roth <michael.roth@amd.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Michael Sterritt <sterritt@google.com>
Subject: Re: [PATCH v12 2/3] x86/sev: Change snp_guest_issue_request's fw_err
Message-ID: <Y9AI2eZCCSo3+hYz@google.com>
References: <20230120214857.835931-1-dionnaglaze@google.com>
 <20230120214857.835931-3-dionnaglaze@google.com>
 <Y87s95WNc0QLZ7fn@zn.tnic>
 <CAAH4kHai7oebzWvkKXOU5UatuqF=CiWN32r9bM3Scxnx4P9nhw@mail.gmail.com>
 <Y8/iYyGHiPow20NX@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8/iYyGHiPow20NX@zn.tnic>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 24, 2023, Borislav Petkov wrote:
> On Mon, Jan 23, 2023 at 01:22:07PM -0800, Dionna Amalie Glaze wrote:
> > This isn't the primary problem that needs fixing, although it is part
> > of it.
> 
> I'm replying to the 2/3 patch which is addressing this part.
> 
> > The problem is that the host can provide a throttling error and
> > the guest will need to continue trying the exact same request or else
> > end up locking themself out of the vmpck due to the IV reuse patch
> > Peter sent.
> > 
> > I think Sean's request to keep throttling a host problem in user space
> 
> + Sean.

It was not a request, it was a question[*].  In the same paragraph I even asked
if the guest was expected to schedule out the blocked task.

 : Why does throttling just punt back to the guest?  E.g. why not exit to userspace
 : and let userspace stall the vCPU?  Is the guest expected to schedule out the task
 : that's trying to make the request?

[*] https://lore.kernel.org/all/Y8rEFpbMV58yJIKy@google.com

> > is not the right one in this case. That would avoid scheduling the
> > whole vCPU, but the guest code I'm proposing can do other useful work
> > while waiting. There will be no other code that depends on that
> > particular control flow.

Relying on host behavior for this sort of thing is also a bad idea.   There is no
contract between the guest and host beyond the host being able to say "you've been
throttled".

Similar to Boris's comments about splitting this patch to fix bugs, separate the
handling of SNP_GUEST_VMM_ERR_BUSY from the internal ratelimiting.  For all intents
and purpsoses, gracefully handling SNP_GUEST_VMM_ERR_BUSY is mandatory.  Ratelimiting
requests from the guest side is a completely different story.
