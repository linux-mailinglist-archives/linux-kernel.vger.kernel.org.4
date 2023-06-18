Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 130CE73491B
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 00:24:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229456AbjFRWYJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jun 2023 18:24:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjFRWYH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jun 2023 18:24:07 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DFF919C
        for <linux-kernel@vger.kernel.org>; Sun, 18 Jun 2023 15:24:05 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2b46cfde592so15654461fa.0
        for <linux-kernel@vger.kernel.org>; Sun, 18 Jun 2023 15:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687127044; x=1689719044;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IGdcR2/d0+3rc+OiyAKdP9KYbhKKRRe9CJ1vDIWe/OA=;
        b=L/+pHhikGb3fu7JoSb9U5gzBMLNjlSKN9MSnT6DuWetOm73Hxq6KXrZr7L723dW+Yd
         AYKTny4BPTN7r9h2Ql4UPgNPi+329bpN+PbHGDWDBJFMVPlHbrEC5g3EhBp/M4UO6spB
         z/rHwcTzyOdTh/gcET5hLM6l/W7DO3uxvkolVw5k5RcWZ90nwaAT12c+zu6OzWLQiJqc
         2sUi43/mmPz+CP8LKXsUo4619UW+hAL9gxTkRz2mP8j8ISKztqhT+R2QL8SR+kqnbFyE
         IfgZzYJBL7Z2L4YkvELN0e8iyYGbqaSsDaj5M+r0JSUauI/QZuoK+1+NcCD2DLbnebCP
         0XbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687127044; x=1689719044;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IGdcR2/d0+3rc+OiyAKdP9KYbhKKRRe9CJ1vDIWe/OA=;
        b=gkPsDtgT6jeI1GXAXjXruMiXZzVjIJmxZc0XVKJdLm05R+3I8C+VCqfWmIUbnWuaCA
         N5DIRXT14aN9MslbN2+INODw64rjRggDAkQnlt/2QHFgkJJjl9k6jpW4Ft3ZIvmBf4FU
         K/yEHb6iA2PlHvbi0RROWU2oyq33FWjHorVOM69ywBxQXl3Hgh0ysJxcYp9B1/fO/soI
         kgepm5fBwZ4Ntq40Y26UOO4sRXHKso+Qu1JG29U5iidlJqTOSG4RDQbCAVUV26aEEbD8
         zRAIkdo9mgcWbpAOBz2I9DzoiZO0hRirLBpFW88+vCUMhMfvrr2FE0PNUioASSsKhfZH
         budw==
X-Gm-Message-State: AC+VfDwo7mjdjnM1VEKT3oQNMqA/0BisyerSBL6d98yMu7jpurRe7eV9
        yCFJZRI6LYwiy5s3PaZjkbE=
X-Google-Smtp-Source: ACHHUZ48MOvC1IhJGjqg9nkbGX+9GiTeGQIShAUC6FzL+eOnIFEKs5OTiQRsv+d9TqB4x6787tqRIw==
X-Received: by 2002:a2e:9542:0:b0:2ad:a78a:df0d with SMTP id t2-20020a2e9542000000b002ada78adf0dmr4137875ljh.44.1687127043555;
        Sun, 18 Jun 2023 15:24:03 -0700 (PDT)
Received: from grain.localdomain ([5.18.251.97])
        by smtp.gmail.com with ESMTPSA id x13-20020a2e9c8d000000b002ad9a1bfa8esm4895891lji.1.2023.06.18.15.24.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jun 2023 15:24:02 -0700 (PDT)
Received: by grain.localdomain (Postfix, from userid 1000)
        id E29E55A0033; Mon, 19 Jun 2023 01:24:01 +0300 (MSK)
Date:   Mon, 19 Jun 2023 01:24:01 +0300
From:   Cyrill Gorcunov <gorcunov@gmail.com>
To:     Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, suresh.b.siddha@intel.com,
        Kishon Vijay Abraham I <kvijayab@amd.com>,
        Vasant Hegde <vasant.hegde@amd.com>
Subject: Re: [PATCH v1] x86/apic: Fix kernel panic when "intremap=off" and
 "x2apic_phys" are set
Message-ID: <ZI+EARkh3xsvkRfA@grain>
References: <20230616212236.1389-1-dheerajkumar.srivastava@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230616212236.1389-1-dheerajkumar.srivastava@amd.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 17, 2023 at 02:52:36AM +0530, Dheeraj Kumar Srivastava wrote:
> x2APIC mode requires "Interrupt Remapping" to be enabled and the
> "physical x2apic" driver can be used only when x2APIC mode is enabled.
> However when "intremap=off" and "x2apic_phys" kernel command line
> parameters are passed, "physical x2apic" driver is being used even when
> x2APIC mode is disabled ("intremap=off" disables x2APIC mode).
> This results in the below kernel panic:
...

Hi! Good catch! In long term I think we could switch to use x2apic_state variable
instead since at the moment the code is somehow hard to read and remember which exactly
deps are to be satisfied to enable x2apic mode.

Reviewed-by: Cyrill Gorcunov <gorcunov@gmail.com>
