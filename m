Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6938268E5CF
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 03:07:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230132AbjBHCHd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 21:07:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230011AbjBHCHb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 21:07:31 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBA6642DE3
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 18:07:21 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id ji6-20020a170903324600b00199420887b0so409586plb.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Feb 2023 18:07:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=fjLzNTffPyNKoOpCO+EIjjZIhIIdZ+k/heQ8Ni+Ji9s=;
        b=T/qLoacl4043qKDNr0mWzqcXWDu6+/xWES7FCxj9m+ETC0cQx8gp5SAmSWDEuQ1fKs
         JHCR9RUeUdCQE0KQwBKNfhKXYHdZtGHQPfigAU7w8NKkEWINNqszEspFI4N1OPHpLJri
         jGW8yBAYYPaH4hWZO0YT16h7pRu3K7QJ2QZtr0OLwfSQgFoBwesCHkWwAu4ViXdAykt3
         8lQyR3RVDHOXYPrbD/PNh2QECfcPqcy0KOAxn6JlAf5cXBIyGSWOOz80Xc41y24ouTch
         wHvCCUtHtMSwIIMV1JcpJJLlQvRcwWyAWsVgHqmCO7FIgqKiAD4LcyF92XF3xvp62hun
         5/Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fjLzNTffPyNKoOpCO+EIjjZIhIIdZ+k/heQ8Ni+Ji9s=;
        b=Sr4WeG4fOSBGZp4oHa4xrNz++Ku5eAvGtkang59fq2CHLivXoEB8a2r3rMRtBeAGoj
         pr0v0twVWyqCtfaOAVic9WJmrk9+no3iohpQuKKyxl8blRXN2WDXK2j02PasEGc2TegJ
         BS67ra/gapKrO+NycfxOXClsuN59AxLeRJMNn6T3Ohkgb3ZH9Ja9J0kB4HTggxGu9fzQ
         9IrxLaSYVDf0tlXEu9QDPM3rGID1Y1RpmQbNtQv2QeRMpMsQFgTRXM6AXSP5IkHqbDJj
         aEjmFfGVsqtqGm3nPf3G23VpVy8zSiBiXecIetrbVqgy50jbYdy5PlvYP4z4N6uYboV6
         XFPA==
X-Gm-Message-State: AO0yUKUyVOYr7Y+ak7pDr6rzHo4CeR/VmOL3QTbdO3F/0jPdKiJazste
        oSt6WVx+7tcdkw4u/yO0g8cLWuJSPXI=
X-Google-Smtp-Source: AK7set+DjTRucDhx3PWAF+ihgr95vPESJel7rr9CCKa2wrx0LnOGkfytGz3XKsY7kl68vd4rlYLTEiBrQcU=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:aa7:98db:0:b0:593:f41a:fc78 with SMTP id
 e27-20020aa798db000000b00593f41afc78mr1274746pfm.25.1675822041143; Tue, 07
 Feb 2023 18:07:21 -0800 (PST)
Date:   Wed,  8 Feb 2023 02:07:02 +0000
In-Reply-To: <20230207171354.4012821-1-pgonda@google.com>
Mime-Version: 1.0
References: <20230207171354.4012821-1-pgonda@google.com>
X-Mailer: git-send-email 2.39.1.519.gcb327c4b5f-goog
Message-ID: <167580939268.351288.874111179458946336.b4-ty@google.com>
Subject: Re: [PATCH V2] KVM: sev: Fix potential overflow send|recieve_update_data
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org,
        Peter Gonda <pgonda@google.com>
Cc:     Andy Nguyen <theflow@google.com>,
        Thomas Lendacky <thomas.lendacky@amd.com>,
        David Rientjes <rientjes@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>, stable@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 07 Feb 2023 09:13:54 -0800, Peter Gonda wrote:
> KVM_SEV_SEND_UPDATE_DATA and KVM_SEV_RECEIVE_UPDATE_DATA have an integer
> overflow issue. Params.guest_len and offset are both 32bite wide, with a
> large params.guest_len the check to confirm a page boundary is not
> crossed can falsely pass:
> 
>     /* Check if we are crossing the page boundary *
>     offset = params.guest_uaddr & (PAGE_SIZE - 1);
>     if ((params.guest_len + offset > PAGE_SIZE))
> 
> [...]

Applied to kvm-x86 svm, thanks!

[1/1] KVM: sev: Fix potential overflow send|recieve_update_data
      https://github.com/kvm-x86/linux/commit/f94f053aa3a5

--
https://github.com/kvm-x86/linux/tree/next
https://github.com/kvm-x86/linux/tree/fixes
