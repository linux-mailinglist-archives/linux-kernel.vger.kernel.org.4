Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23ED26A4F6D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 00:03:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbjB0XDa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 18:03:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjB0XD2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 18:03:28 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5008A248
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 15:03:24 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id q23so4568386pgt.7
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 15:03:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Pg8jLCETrGkaL4VJFja7UtTlA/JJG8XOO2LhkC01X9c=;
        b=bsG+3jnQABLG/bbMBh9XjeX88bwj0SQ9Jx5uEJhWlMr1tpY8WoEdbEE3Pr3JQQF3RV
         b+MquoPqUZlakvxWscfmUggSBaVALuqQMwvDr24dwQoKpxZVB2dSHQNmH4SU2hpLiefC
         ZuGAMlK8YfKdgeFNOo5FJHkeS+wCud+0B1fFXpjfBtQVP3+BW522wIZurQCYhaPy4ZiQ
         Q/EiX/QQHYfJEINrAUJc1lnQQ7kTSEY3tllwzt6EmR7PgMn0G2EYR9Go7rhdjBV+AylT
         pF+mzkkoRGK20ybR508t9437vk5pwwk3DkToO7W29vcAEEgg8odGV/IpyBZ2OroTovFX
         Feiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Pg8jLCETrGkaL4VJFja7UtTlA/JJG8XOO2LhkC01X9c=;
        b=MmAFgEt04w6gsXXZB4ctULfNBai64Xr82o6IFdu3yGw6ZTkqYujivlej/g7JfFDPgL
         sspw8DUpwM2vz6o2zY3cu44b5j2A5yPe5epzK6UCI28Wy0IACu0fVKBmhS5tPhxEbWgz
         FIq1UY7vE+e6l8pF3Q0cKZT1EdLyEO9L4zZOS57E0WtFCkrZZNzwG8vcolaV/43yEGsA
         i0IrvQeKIxlrAozrkmJDLzs6LxRRZ3s9eHBEP/8ksmAoOlNKtF5XpUL3AJhHXfnqldJz
         5opE2xau4Zpuuiwi8+5hJSJdUwEDknhtgYt3Uah73kY5LxrjPGT8/0AYICZg5TBUSvyC
         ZDpA==
X-Gm-Message-State: AO0yUKWXT1ycsQXYzcS+LKXjr+0WtlLnaCrLpJxKZadnX3li5rS4wQnZ
        JtQ80KmFrjIwiQQwd7GPALfpULyvl2QNMQ6kL8nUng==
X-Google-Smtp-Source: AK7set/fd9hoddiJWkR+2I3PuNhNzBSMhE/0+J/LoWTvdfY2Nxv2qR4uxnorljhiprYWSqvXEZFZkgPE4WAPbMdg5aA=
X-Received: by 2002:a63:8c1d:0:b0:503:354c:41ad with SMTP id
 m29-20020a638c1d000000b00503354c41admr43761pgd.11.1677539003795; Mon, 27 Feb
 2023 15:03:23 -0800 (PST)
MIME-Version: 1.0
References: <20230221113428.19324-1-bp@alien8.de> <20230221113428.19324-12-bp@alien8.de>
 <3cb5d149-699a-b649-1986-23d7f6783e6f@amd.com>
In-Reply-To: <3cb5d149-699a-b649-1986-23d7f6783e6f@amd.com>
From:   Dionna Amalie Glaze <dionnaglaze@google.com>
Date:   Mon, 27 Feb 2023 15:03:12 -0800
Message-ID: <CAAH4kHaH=Xpnq48LtwPra=Mhu=110oFzs=dv40vsZT7WOAvDqw@mail.gmail.com>
Subject: Re: [PATCH -v2 11/11] x86/sev: Change snp_guest_issue_request()'s
 fw_err argument
To:     Tom Lendacky <thomas.lendacky@amd.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <jroedel@suse.de>,
        Michael Roth <michael.roth@amd.com>,
        Nikunj A Dadhania <nikunj@amd.com>,
        Peter Gonda <pgonda@google.com>, linux-coco@lists.linux.dev,
        x86@kernel.org
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
> Should this be?
>
>         input.exitinfo2 = SEV_RET_NO_FW_CALL;
>
> or make it part of patch #1?
>

This is something I'm not fully 100% on. You said that there's not
that many bits for firmware errors, so -1 or 0xff are fine by me so
long as neither are possible results from the firmware. I don't recall
the details on that, so if we go back to 0xff for SEV_RET_NO_FW_CALL,
I'd want a clearer explanation for why 0xff is sufficient.

Apart from the other comments from Tom which are a matter of style and
not semantics,

Tested-by: Dionna Glaze <dionnaglaze@google.com>

-- 
-Dionna Glaze, PhD (she/her)
