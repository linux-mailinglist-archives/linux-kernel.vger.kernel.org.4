Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACD4467C030
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 23:53:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235331AbjAYWxv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 17:53:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbjAYWxu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 17:53:50 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20CF645F77
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 14:53:49 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id t12-20020a17090aae0c00b00229f4cff534so4660789pjq.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 14:53:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pzKJd/pAr8vlH5fq51CxhfYmuwDJzJDL/ZN0MVn2ctw=;
        b=N8qZ3TIjLd1a1cyOwf5gSPSSoGeQOP1dsNx4uUe2iAmggItX87WNxmDbTDqyeVffl2
         ohOD5WmwPSmpgrUeP7JIs3zqBdDbegt64g9rht2hiS6y82dDW+DAxPzC8OYK+5PCR1BN
         aNSfLZRnJOKoDKCi4DvtcRAWEH2RaSukX5O6FfUthDhH3vLPaPFrHlIFr82p2DKPoJ5q
         AuyRPt6en5R2iaevUBEa0D0xFzLd6VyAVmJu/FCBPVTyPAjKz1nY5u2cxDKqWQGwBUln
         q7aIDu67F+R+Z9PyxYhVeIeGX8cDoHxyOWChbAuPhkrCCRX6XZXHcD0vA3mH8NIGWOGw
         /mEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pzKJd/pAr8vlH5fq51CxhfYmuwDJzJDL/ZN0MVn2ctw=;
        b=KtWP8W68bJIlCVPtHqeWvspR+tBPmy4T5v9fQREjy9Zgx9NLi4OJeQFYfDfUrqlf6o
         cRp2wuYQNyuasMtQKFFQwxY9BhKtJ2YbMDHnajayBWe9XcoKPiuGziGycwbYyv5qwrg9
         GXPzZE2RBlo8lHdEVfpAOJMcL9qq5mLe4cY2iqdDG9wgMmpVEO8clVXljW78a1Zb6CQA
         LKwr4NE3y4UWAb/m25iC/tseNVdicLKIl9cg+KrJrBfv5p6ewsSUYIsvprLDe1fkZC2O
         P+YP2wsXw5CbffpBwDLzbOmFsWbKECDTPrfnLn8rsUclQnFfc3XGFnyRFVb5P6Ruxqe6
         5d4g==
X-Gm-Message-State: AO0yUKUBrqT42ZIEd8OTgofjfUYY2HdA54lAdmLi+AuPR6eHh/cy5fdT
        NxHf6d+kNlLS6/GfBRGyAulqvGiIqnA19DvvQv957g==
X-Google-Smtp-Source: AK7set+D/kkg3tME1AaRlECOzc1VlwZnKyZA5Duza9+E/vvU/S92E7RSlmhiVDLZ9NqaZuvI9LXL+0T6TqrlsWzS9uY=
X-Received: by 2002:a17:90a:6e4d:b0:22b:ee57:725b with SMTP id
 s13-20020a17090a6e4d00b0022bee57725bmr1486529pjm.159.1674687228484; Wed, 25
 Jan 2023 14:53:48 -0800 (PST)
MIME-Version: 1.0
References: <20230124095653.6fd1640e@gandalf.local.home> <Y9AG63mgkyzSEbSa@FVFF77S0Q05N>
 <20230124140617.4a4fe106@gandalf.local.home>
In-Reply-To: <20230124140617.4a4fe106@gandalf.local.home>
From:   Chris Li <chriscli@google.com>
Date:   Wed, 25 Jan 2023 14:53:35 -0800
Message-ID: <CAF8kJuNXo+cDTVWY+pDa-Py3zAbQCi3gs=M0UX2AsEPDyKrC2g@mail.gmail.com>
Subject: Re: [PATCH] ftrace: Show a list of all functions that have ever been enabled
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
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

On Tue, Jan 24, 2023 at 11:06 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> No problem. This was more to help us debug something, and we are currently
> just backporting it for now to our kernels in order to help with the
> crashes we are seeing. No rush to get it upstream. But I figured that if it
> can help us, it can also help others.

I just tested it against the tip of the kernel git repo. Works fine for me.
Feel free to add:

Tested-by: Chris Li <chriscli@google.com>

Chris
