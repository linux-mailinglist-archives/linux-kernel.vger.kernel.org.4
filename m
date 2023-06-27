Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7C887405AB
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 23:34:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230284AbjF0Ve0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 17:34:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbjF0VeY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 17:34:24 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E00A297C;
        Tue, 27 Jun 2023 14:34:18 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-67ef5af0ce8so755409b3a.2;
        Tue, 27 Jun 2023 14:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687901658; x=1690493658;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5KvC6gSHm3Mnr+8G5W9klezbIpsKfd6ztL0rbeRtQI0=;
        b=QPENOK5BbSgG8l9bmuhRH+rRSXkVXZE9b+o5uwlbBR3yXJ09bzX6WDbaj1CCC1ChLP
         c6OKfXtEmBYAca1VZX18/F7teg1cUXhVcpy5M5omOUSy9DPPXe6if4h8n9pcDmL43GJj
         lHJ7lzGUWRd0U4NGHmxvbKU2AgldNhTo7ltWDT1fUO6uAeyDMy+/dDKV3nIN4vwz1rJM
         yUI8oNTeJ+XDDGpaO71dwDjuqGWhenWc/8gU1E//MouLq5kBf+Fg0o29yzYLAOwWc8Ww
         j6RChgjrRn1x2yKAIBAwl+S+ALj8quy6SNI5BVzmQuqeb/kJksBTMA9sqyMvvS1aXitX
         yx/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687901658; x=1690493658;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5KvC6gSHm3Mnr+8G5W9klezbIpsKfd6ztL0rbeRtQI0=;
        b=EGm6EDdEBGEpohtPmN6RDOBvqWuu/doDm3IVUX/OpjP/P0xXPi4yzNUUoM63EQUwOf
         kWCR1JKFTg63zx15WpaSEkjqjuAkoX7ZGmOs8kemJIuisx7+IpzMyFR9eJRmIEPKx+WP
         qVybjg06jQGCKVsXi1cBlV/ByALv5cCSPWXKmMtzmTAQFfC3skVbJUAhf0EctNzQw68Y
         UrLLT47GwT9UWXzGgH81L+fDdZHc8NNR45guA7/Fmk0WbEFogIvY4Bc1wuTlLBrqQJBU
         ASc3kXfAU4GDBR9U/TZeOIorcAN4pwip2PtgBuM6r7NstbLFEwOzBrlrllogi7VUL8xB
         u0yA==
X-Gm-Message-State: AC+VfDxVjn7JeD9K930ruX9qnSiTlnosZfXdppPcdgwvZaKq4VZY8IoB
        TPPLvvL8dnMTPscwXCzT0H4=
X-Google-Smtp-Source: ACHHUZ7kpqShW/z488sGKO53Orw6gnSjl2YVClGn6LZJIHDUsOoWyzYi3JGhkv3V1AbWx50+Y54CfA==
X-Received: by 2002:a17:903:1208:b0:1b5:54cc:fcb8 with SMTP id l8-20020a170903120800b001b554ccfcb8mr14429663plh.19.1687901657929;
        Tue, 27 Jun 2023 14:34:17 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id h12-20020a170902f7cc00b001b8229942a0sm1588253plw.34.2023.06.27.14.34.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jun 2023 14:34:17 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 27 Jun 2023 14:34:16 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: Re: [PATCH 5.15 00/96] 5.15.119-rc1 review
Message-ID: <82f3c033-4f69-4fbc-a497-942c99fe9406@roeck-us.net>
References: <20230626180746.943455203@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230626180746.943455203@linuxfoundation.org>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 26, 2023 at 08:11:15PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.119 release.
> There are 96 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 28 Jun 2023 18:07:23 +0000.
> Anything received after that time might be too late.
> 

Build results:
	total: 160 pass: 160 fail: 0
Qemu test results:
	total: 499 pass: 499 fail: 0

Tested-by: Guenter Roeck <linux@roeck-us.net>

Guenter
