Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 276F25FD22E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 03:06:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230122AbiJMBGb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 21:06:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230307AbiJMBGF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 21:06:05 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3BC910CFB7
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 18:03:49 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id fy4so752106ejc.5
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 18:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=f5ZmeOrNRxVSdEs7wj3cmQBKG+t/B2W0NUATSDD3gSw=;
        b=J/NycGcrdiTqo/XljHd+9KZjgUiAYm0uWAEoNrhmlV4LxzHOpIYRETVS+GdoCnqH+b
         N0jY+TdEk8jmVwce3L3Nh8UM7zG7rTIgLhowKgqMveHiyJ0zMmPXKr+Fdvir7bZK5CVW
         tGE5BITfHUr+YJyXV0UtLE1V88a99e0Md28UNo83N6WtQJ+PmjFEMjdgh9yciNxrQPKe
         NiTSTwMFxc1lQU9Mf+86o+4ozh6AQtMEPAc0bAcRKeZi/hT5V0o83/Vq8ksiAg6xHNyn
         OYvJsSVmZisV6IetombbYqi+c/kJSCzAOJ8LmBed8oXxUUUBg7+7uUOK0w9y6GvnWHya
         UPGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f5ZmeOrNRxVSdEs7wj3cmQBKG+t/B2W0NUATSDD3gSw=;
        b=bm+Cq1sn/5XE1TOUtLFfYy40Ou63Ly8Y4irH8GrLzOXtWKFs7AHewe6HHnd8D0h5IR
         9E76XPlAAoV+UNk3xF86WrHPfqAChtiBs3az1gjBwy8knVWuEO+BTkIsSRWDCVbymLOq
         8li7flW7JyrfPHds146NN6kLQA7xGG/oG701/XjFn3MlKDlbcGE6ag8DnpMMY8BgSkfX
         Hrw30RTJ/UHhzBH54W2vgQzpyj7lsjvRJGxNGCURVhIcRzB2UI1XC+r0DvU0nirpNju6
         rNdCvBhCQNaeEKoebMiwXn8FioLwMHh7OGo4N275dMTQC3P87ZrcWva43C2km44gfKxG
         KjOA==
X-Gm-Message-State: ACrzQf2xX09KOFkCAElksaCLzhHDCU3GUFJQvQjBZqy3jLW+48fso+Zo
        m2zQKKGoKoSvwy93FW7EQ+aL64Y8G0jN3rAmZK1KBLC6/qQ=
X-Google-Smtp-Source: AMsMyM6acAuS/QhwPAJT34l2+m20AmcKih0Fi0tmvSIsO3GxqwpNAHOC4DOiz4sAceqQwWVHspjhkRBZUuVR9VpmwPE=
X-Received: by 2002:a17:907:2c44:b0:78d:4e67:ca5d with SMTP id
 hf4-20020a1709072c4400b0078d4e67ca5dmr24564212ejc.397.1665622932198; Wed, 12
 Oct 2022 18:02:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220902000439.875476-1-dionnaglaze@google.com>
 <669cedbc-e127-92ba-2e98-e0460b45bd4d@amd.com> <554407c3-197b-0e52-fc92-9c383a37175b@amd.com>
In-Reply-To: <554407c3-197b-0e52-fc92-9c383a37175b@amd.com>
From:   Dionna Amalie Glaze <dionnaglaze@google.com>
Date:   Wed, 12 Oct 2022 18:02:01 -0700
Message-ID: <CAAH4kHacW+hd8vB8QgkTjdw6+z-0ngjCqgr=zuGTwqqRnqUPQw@mail.gmail.com>
Subject: Re: [PATCH 1/2] x86/sev: Add KVM commands for instance certs
To:     "Kalra, Ashish" <ashish.kalra@amd.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Tom Lendacky <Thomas.Lendacky@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>
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

> >> +    /* Page-align the length */
> >> +    length = (params.certs_len + PAGE_SIZE - 1) & PAGE_MASK;
> >
> > Probably can use PAGE_ALIGN() here.
> >

Ah, thanks. Will add in v2.

>
> Though, one thing i don't understand is that why do we need to issue
> the SNP_GUEST_REQUEST to FW if we are going to return the VMM
> overriden certs back to the guest ?
>
> Thanks,
> Ashish

If I'm reading the spec right, certs are supposed to come along with
the guest request when the user issues an extended guest request. If
the length is correct, we issue the command to get the report and we
simply override what the psp returns for the certs.

Is that your understanding too? If so, are you saying there's a bug in
this implementation?


-- 
-Dionna Glaze, PhD (she/her)
