Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2D7867896E
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 22:22:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232040AbjAWVWX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 16:22:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231836AbjAWVWV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 16:22:21 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBA802B2BB
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 13:22:19 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id z1-20020a17090a66c100b00226f05b9595so12225643pjl.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 13:22:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GsEJ7CwCvCeGI7VFV30rwIRMLqhVo1Bn5kka2yYiLaY=;
        b=maEvox0ocR/hghSzh2W05yfICLCTZdbuPZTZJYwcbeNiaMMG8104qQFPzOAI1yiASj
         yxtqq6NBeO/uk7X0Fg+jLynoNf2oCk0U6B58YwmXcQnZQQuOUFIABN2liUJNRfAzf2h3
         rBWu5pMy0IxnrKXt5fJPCd6RxDMs04zlH9IDHIFWAH84Bf8iktB2WZbxXSnHPvuUM+KS
         99Tn+Ejzjc6/DhJeXPAvFR5LGbM/BuCN6XN4jHfRs2zZUqer0Pv5nxU8h7gUzDqnvZKG
         02kj4kSvzEHNitwq6iGbkGciMj/W9YTs1CAqcjGN47eMKpmCB63xv/1uRjDe0dFLQFUd
         aRkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GsEJ7CwCvCeGI7VFV30rwIRMLqhVo1Bn5kka2yYiLaY=;
        b=fHperFUHPPK+RHFQ4TKyGOYNgpAUhi6wGsRkfoo3KiybSOiOWTqq440DTzMZhOVLHU
         9FSreGNTckS/lyBEt/V35x7riOeed8U4d1mX8h0FFAnzgpiOr1tKG98ydX6PHO/CBEiD
         PABdUQeu1nkoVoLs5Nph5IsFgyD1IuW1fBfXPzSa2J0sTwg8O9zOdqlAulp/3SOlIA7+
         6+7nZ2aPeH08sqY6biNTlUxGErmA2HnuwqBBPNBqcbe/c1cGKVFRdu4HWy1aw9RrM5y+
         lNTKijV+yL3oD++8J4Sa1URqkjHPHhYZcnNhEXX8ggGuFv40IAlX2g29de2nUKxYmMsn
         Myug==
X-Gm-Message-State: AFqh2kqC0A4HLtvs5FMOxpNAWsYgrGyL5ao1NvTRBncsCCOHttf3dtr8
        JMwpPeq1Gu+RyxgtUnw3r8iesyX8DpmUG74TNYMToQ==
X-Google-Smtp-Source: AMrXdXvD2duNKN9iwafYh5PUilb1p6UalWBgBwgOb0rwlIAbRrJiec6QAuaUp6a2r3tvPprzW5isy34GQYmZI9nSQQI=
X-Received: by 2002:a17:90b:904:b0:229:ee76:74c5 with SMTP id
 bo4-20020a17090b090400b00229ee7674c5mr1949673pjb.134.1674508939108; Mon, 23
 Jan 2023 13:22:19 -0800 (PST)
MIME-Version: 1.0
References: <20230120214857.835931-1-dionnaglaze@google.com>
 <20230120214857.835931-3-dionnaglaze@google.com> <Y87s95WNc0QLZ7fn@zn.tnic>
In-Reply-To: <Y87s95WNc0QLZ7fn@zn.tnic>
From:   Dionna Amalie Glaze <dionnaglaze@google.com>
Date:   Mon, 23 Jan 2023 13:22:07 -0800
Message-ID: <CAAH4kHai7oebzWvkKXOU5UatuqF=CiWN32r9bM3Scxnx4P9nhw@mail.gmail.com>
Subject: Re: [PATCH v12 2/3] x86/sev: Change snp_guest_issue_request's fw_err
To:     Borislav Petkov <bp@alien8.de>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
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
Content-Type: text/plain; charset="UTF-8"
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

>
> Anyway, that's a lot of changes for a fix which needs to go to stable. I don't
> mind them but not in a minimal fix.
>

> So how is this for a minimal fix to go in now, ontop of your first patch? The
> cleanups can then go later...
>
> ---
> diff --git a/drivers/virt/coco/sev-guest/sev-guest.c b/drivers/virt/coco/sev-guest/sev-guest.c
> index 4ec4174e05a3..20b560a45bc1 100644
> --- a/drivers/virt/coco/sev-guest/sev-guest.c
> +++ b/drivers/virt/coco/sev-guest/sev-guest.c
> @@ -322,7 +322,7 @@ static int handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code, in
>                                 u8 type, void *req_buf, size_t req_sz, void *resp_buf,
>                                 u32 resp_sz, __u64 *fw_err)
>  {
> -       unsigned long err;
> +       unsigned long err = SEV_RET_NO_FW_CALL;
>         u64 seqno;
>         int rc;
>

This isn't the primary problem that needs fixing, although it is part
of it. The problem is that the host can provide a throttling error and
the guest will need to continue trying the exact same request or else
end up locking themself out of the vmpck due to the IV reuse patch
Peter sent.

I think Sean's request to keep throttling a host problem in user space
is not the right one in this case. That would avoid scheduling the
whole vCPU, but the guest code I'm proposing can do other useful work
while waiting. There will be no other code that depends on that
particular control flow.

If we call this one-liner the fix, then the VM guest still has the IV
reuse problem unless it can guarantee that globally no other thread
than the one requesting an attestation report will continue to retry
upon a throttling error in the exitinfo2 value. I wouldn't call that a
fix.

-- 
-Dionna Glaze, PhD (she/her)
