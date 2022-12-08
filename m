Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE91E646C60
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 11:04:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229863AbiLHKEj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 05:04:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbiLHKEf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 05:04:35 -0500
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBB6A532E9
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 02:04:33 -0800 (PST)
Received: by mail-yb1-xb32.google.com with SMTP id o127so1042056yba.5
        for <linux-kernel@vger.kernel.org>; Thu, 08 Dec 2022 02:04:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=P6pNB2x50dYwPB4We2hSd93Dmio7/AlO8hDxzk/4tCw=;
        b=ak/RkejmjE9qBHSNqj/DVX7HZMtXL36JXOtFhwWu/JegmQD5w0URdN8S69uKLMYnTl
         32DfDuzhOp5MycxVprxksq/02jDMd4Yd1dtC1bQ1MtHktvY8N9v7e+ke4xsrTceVjy7c
         7DaMql3hHig3FJIY2t1meg5htoSlQOHUA36Z00lA/x1l6N4en3qYeVnvpkW9IMDC7lj5
         Y3hr+VtDVB1Y33PNnMMpMvB59JzkvmJoLDKGXHDDmukaLenn/0VO+ln1+Zv9eKUfqM3/
         qSpeNxphxSjPN57+2PAet1DN6hD3vHFvkRcpG98N2r9vrCQowaBDb2t/9LwXgNS4jJaD
         AspQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P6pNB2x50dYwPB4We2hSd93Dmio7/AlO8hDxzk/4tCw=;
        b=H7PtudBLjHZsciYkS6ubNqMvsaKaz00Y/X3udBN83ZSdFsPOWJwiWN+wYLmkghIKM5
         bdfXX5WxO6Dmyrw0lYindVw6lfixGBM7Sgmros+MNbqF7V4KNBZQQeGo/W8SfLghWQGH
         RePfEfNG3e3SyefJ3MR6MqrOTBjo5TGOy1VIfVOz169mjYCVj2/mngS98/YZZ8p1SUks
         LW8UaMt7vsVx6jA4NpS62m0tI/GcDlYnvtkL72BAcq1U4ljH3LV74Z7sB6edNJPYlCyu
         ntVI5FQD1CmLxIpNwxJqxtHm2evgyM61G2SjeQr0/kmEKT4RfwFvBgM2I+BTaNhiMqoq
         a6rg==
X-Gm-Message-State: ANoB5plN+9p1zJPLOyVI6yFtuY8L9jd8pOT5hQ2J8uEgt6kKp/I6ne9y
        iXzySb5Gl/By9Ogw+FJ7FbekYjWtK4N18eCym4q3WQ==
X-Google-Smtp-Source: AA0mqf4eZVNGlgZIdiUtND41JUQrlm5oKjuVTxRxxzMNvTPgG17Y1ecwI7iAhpp3TmQNYu3caFXAjIB50joBvV45NLU=
X-Received: by 2002:a25:bc8f:0:b0:6fc:8f79:2368 with SMTP id
 e15-20020a25bc8f000000b006fc8f792368mr28510597ybk.399.1670493873037; Thu, 08
 Dec 2022 02:04:33 -0800 (PST)
MIME-Version: 1.0
References: <20221207112924.3602960-1-peternewman@google.com> <f58e6af2-aa16-9461-d40d-1e4e52ee6943@intel.com>
In-Reply-To: <f58e6af2-aa16-9461-d40d-1e4e52ee6943@intel.com>
From:   Peter Newman <peternewman@google.com>
Date:   Thu, 8 Dec 2022 11:04:22 +0100
Message-ID: <CALPaoCiB-vOuXJYkaLLsxSKHcjT55q1RSNBjhHUWmPL9rFdF8A@mail.gmail.com>
Subject: Re: [PATCH] x86/resctrl: Fix event counts regression in reused RMIDs
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        James Morse <james.morse@arm.com>,
        Shaopeng Tan <tan.shaopeng@fujitsu.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        linux-kernel@vger.kernel.org, eranian@google.com,
        Babu Moger <Babu.Moger@amd.com>
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

Hi Reinette,

On Wed, Dec 7, 2022 at 8:48 PM Reinette Chatre
<reinette.chatre@intel.com> wrote:
>
> To get back to the original behavior before the refactoring it also seems
> that __mon_event_count() needs to return right after calling
> resctrl_arch_reset_rmid(). The only caller with rr->first set is when
> the mon directory is created and the returned values are not used,
> it is just run to get prev_msr set. This also avoids unnecessarily reading
> the counters twice.
>
> So, how about:
>
> static int __mon_event_count(u32 rmid, struct rmid_read *rr)
> {
>
> ...
> if (rr->first) {
> resctrl_arch_reset_rmid(rr->r, rr->d, rmid, rr->evtid);
> return 0;
> }
> ...
>
> }

Avoiding the double-read sounds good, but...

>
> Also ... there appears to be a leftover related snippet in __mon_event_count()
> that does not belong anymore and may still cause incorrect behavior:
>
> static int __mon_event_count(u32 rmid, struct rmid_read *rr)
> {
> ...
> if (rr->first) {
> memset(m, 0, sizeof(struct mbm_state));
> return 0;
> }
> ...
> }

I'm less sure about removing (or skipping) this. mbm_state::mbm_local
still seems to be used by the mba_sc code. That might be why James
left this code in.

I was sort of confused about the new role of mbm_state following the
refactoring when reviewing Babu's change. (which reminds me that I
should have CC'ed him on this patch)

-Peter
