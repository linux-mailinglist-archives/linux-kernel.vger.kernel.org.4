Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C86F7648A5B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 22:50:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbiLIVum (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 16:50:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiLIVuh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 16:50:37 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41FD0389ED
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 13:50:36 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id p24so6277705plw.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Dec 2022 13:50:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1KXfcXEfVxvgm+oQbytsHY5YjsBZNYLTbS+S3BxyMLA=;
        b=GdjsIlJUWfNEz8Epwr/QnK5UdJnSF8Rjpz9WWneF+NFgU+gtTlFuhjS2ESINR++Va9
         u8suQjTAaiUxxthysQaONBDcWcqwvF2EZT6J84aBnGgeTUXUjFjzu6c3IbC1+mN/2B/x
         wEgdCX1901VLSL0EuvhtwTgEBW3g9S8pllxLaMfO7M4KX8DCb+YF7qOWhzhGMYqcGZEZ
         1w+KqubNJXnOx3o2iyIeGZWItB2GmwB+jorgFiYgr4vLkP8cN8Kfw3QBfIm8iXs0Avje
         FiWwD0g9stEi388+2JcsdU3B8Zp8WIscWGw26dg4gF3/kUgzco4FrMC/VDa5zNhE/1Mc
         Vxmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1KXfcXEfVxvgm+oQbytsHY5YjsBZNYLTbS+S3BxyMLA=;
        b=QC4v6uiJYRFycrs0GWstYFtrEVzXeEMGpU6WaHJW6ZOobJfqVwUBPDLplPDIIxjcB+
         5Rm7hI+AWy8T+yUgk66OMAsdLNGgDt+7NNnHHwBW5gW3T4Bg9P/XVEqklOjurBNvMbgz
         y4WKwJeXDsNT7Ho7I3z5RO9rERRzmua2BxQvu0q5zFuqNs/b6abzczWofMltpqmvUyRe
         un9V4W9fFX6rYwy3Mx8M25iDHJv4TevmopQdXn2wZgVnDytCiZETSULVmmDRkYyxoeEz
         ShMd/m7X+IPh2hL/ddmXuJEVWjae9cGL3uwESaGJqmKriq+ZgUrAdVX2/ywQmOLlqjMm
         TQTA==
X-Gm-Message-State: ANoB5ploCTf+3VkZTTb3xTh1Pq0MZUoQW7ecSGaDHctMFDiLcxfGbWwC
        K99MOt0DdrkTs6u6OWsle3anjQ==
X-Google-Smtp-Source: AA0mqf40xGv5D/JuEy8B6vP2aTk5IUpJC7Nb6dCoeaQj6Hoi+MEv3Wr2qQomxW/IjAp5ZX4YGzueag==
X-Received: by 2002:a17:903:41c5:b0:189:cec6:7ac5 with SMTP id u5-20020a17090341c500b00189cec67ac5mr10112836ple.44.1670622635503;
        Fri, 09 Dec 2022 13:50:35 -0800 (PST)
Received: from google.com (223.103.125.34.bc.googleusercontent.com. [34.125.103.223])
        by smtp.gmail.com with ESMTPSA id b6-20020a170903228600b00188f6cbd950sm1760045plh.226.2022.12.09.13.50.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Dec 2022 13:50:35 -0800 (PST)
Date:   Fri, 9 Dec 2022 13:50:31 -0800
From:   David Matlack <dmatlack@google.com>
To:     Vipin Sharma <vipinsh@google.com>
Cc:     seanjc@google.com, pbonzini@redhat.com, vkuznets@redhat.com,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [Patch v3 12/13] KVM: selftests: Make vCPU exit reason test
 assertion common.
Message-ID: <Y5OtpwM8ue8nZwG/@google.com>
References: <20221205191430.2455108-1-vipinsh@google.com>
 <20221205191430.2455108-13-vipinsh@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221205191430.2455108-13-vipinsh@google.com>
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

On Mon, Dec 05, 2022 at 11:14:29AM -0800, Vipin Sharma wrote:
> Make ASSERT_EXIT_REASON() macro and replace all exit reason test assert
> statements with it.
> 
> No functional changes intended.
> 
> Suggested-by: David Matlack <dmatlack@google.com>
> Signed-off-by: Vipin Sharma <vipinsh@google.com>

Reviewed-by: David Matlack <dmatlack@google.com>

> ---
>  .../testing/selftests/kvm/aarch64/psci_test.c |  4 +--
>  .../testing/selftests/kvm/include/test_util.h | 10 ++++++++
[...]
>  .../selftests/kvm/x86_64/xapic_ipi_test.c     |  6 +----
>  .../selftests/kvm/x86_64/xen_shinfo_test.c    |  7 +-----
>  .../selftests/kvm/x86_64/xen_vmcall_test.c    |  5 +---
>  44 files changed, 71 insertions(+), 293 deletions(-)

Nice diff stat :)
