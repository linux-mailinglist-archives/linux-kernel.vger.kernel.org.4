Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3305E674144
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 19:50:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229518AbjASSuR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 13:50:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230213AbjASSt6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 13:49:58 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A57295140
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 10:49:55 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id 7so2285891pga.1
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 10:49:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xNVXfWTFHPUTtkdhJd1rvFQYW6suzNo+IYrlxBerVjw=;
        b=JCfzsF2f0L14x6DnDb97ikzDMd+kmDUm+hY4g0ikovS6VCInjBWJHaf/91emjlkbvv
         7wIBq95BwSi0sYX+qpZD/SDvgq6Rh0mChGWHNsKn3x3hLmQ8FzFzJ8/ZbJBpvglwgQ4P
         DCgQbf4DC/hZmnSwoV0J3qJIQ2CUCL3azLbW7iE8ZYMMJf7aB+WsETKfdqrzzfEJ6ojU
         vsPAh6PoOnotNaQto+c0+ylg5pDTEUWQjzlqfqHA4n+xq9Aj/eYU3tjl8BclPsCxy96X
         tvpdUK9qzbs7kasSXAsdoo6MSNp8cPe7grioN6SM05rjDR6+YxuYdpreH2mSGn1YnH2i
         7GNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xNVXfWTFHPUTtkdhJd1rvFQYW6suzNo+IYrlxBerVjw=;
        b=pXnkzZlAmkV/oUZjeSyqdXWa9zd02EYSuaCHeQaPQCTkcDAJ64fB9If4JBXWsyoWDJ
         oSvyEHyJV8eiN2cx8Fq2PduFUYjON4ag2pvnchFqS6c5UqTo+oMAME3BqzqWXyNl/lT8
         fEsl/yTKp+2o1+MHZjrDelkIG32/xeFIngPN1WRCON/VFXPU0e8Y6892dviOdcigwPEa
         ksPfc0rjCzJm3EWsaO6QTUTEs5M3cIeW5sn7F4RVvwDamnRyGgmZZZdpTvJ9NYSiIcI7
         V6A2MIlvlSEQtJtgLJplWjjYBadQcJyDQiabi/aA6QZo3ylaWmn2/6KTLBleXIqe+XGv
         kQZg==
X-Gm-Message-State: AFqh2kqLaDLUpK9ZaVrkLpRDKTo8xgO+ZUxY+/P2SAPxW2Ewbrhvw7ak
        VIiPPsZNJOHT+79NUTXu2RyK4x6ySj1rpVyHKR+Saw==
X-Google-Smtp-Source: AMrXdXs6HTI9i0wEtQHX5RB47auesuGHCq06fYXVQ7aeMwYLK4yjX/E0p+7CcZlE0F4L6rvrtuk8H7gqPyauTnlR1T4=
X-Received: by 2002:a63:d455:0:b0:478:ae53:a299 with SMTP id
 i21-20020a63d455000000b00478ae53a299mr956491pgj.260.1674154194728; Thu, 19
 Jan 2023 10:49:54 -0800 (PST)
MIME-Version: 1.0
References: <20221214194056.161492-1-michael.roth@amd.com> <20221214194056.161492-63-michael.roth@amd.com>
In-Reply-To: <20221214194056.161492-63-michael.roth@amd.com>
From:   Dionna Amalie Glaze <dionnaglaze@google.com>
Date:   Thu, 19 Jan 2023 10:49:43 -0800
Message-ID: <CAAH4kHZVaeL57bGAzeDjJDTumsnb96iAYBdhm7cs_8TjBg+v3w@mail.gmail.com>
Subject: Re: [PATCH RFC v7 62/64] x86/sev: Add KVM commands for instance certs
To:     Michael Roth <michael.roth@amd.com>
Cc:     kvm@vger.kernel.org, linux-coco@lists.linux.dev,
        linux-mm@kvack.org, linux-crypto@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        jroedel@suse.de, thomas.lendacky@amd.com, hpa@zytor.com,
        ardb@kernel.org, pbonzini@redhat.com, seanjc@google.com,
        vkuznets@redhat.com, wanpengli@tencent.com, jmattson@google.com,
        luto@kernel.org, dave.hansen@linux.intel.com, slp@redhat.com,
        pgonda@google.com, peterz@infradead.org,
        srinivas.pandruvada@linux.intel.com, rientjes@google.com,
        dovmurik@linux.ibm.com, tobin@ibm.com, bp@alien8.de,
        vbabka@suse.cz, kirill@shutemov.name, ak@linux.intel.com,
        tony.luck@intel.com, marcorr@google.com,
        sathyanarayanan.kuppuswamy@linux.intel.com, alpergun@google.com,
        dgilbert@redhat.com, jarkko@kernel.org, ashish.kalra@amd.com,
        harald@profian.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +
> +       /* Page-align the length */
> +       length = (params.certs_len + PAGE_SIZE - 1) & PAGE_MASK;
> +

I believe Ashish wanted this to be PAGE_ALIGN(params.certs_len)

-- 
-Dionna Glaze, PhD (she/her)
