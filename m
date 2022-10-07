Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F12FA5F7284
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 03:25:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbiJGBXs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 21:23:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbiJGBXp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 21:23:45 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CFB6C4C1D
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 18:23:43 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id x6so3224685pll.11
        for <linux-kernel@vger.kernel.org>; Thu, 06 Oct 2022 18:23:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=stxK5eytfi7UYuaTvPr6AF15rib5TqQ7VohLY8AETTo=;
        b=BAMPgHgcFnz0m5pv8ALZ2vuDAV8Wc9woff48oOK4K3VMoOPH9YWc5vnpQ7Heyj2BBG
         nErfRvGZFFrVBxkfN8+u3Skf3cCa62PrOw7iLZw5DPICoO1zvKaRXjGHEa+qKJZHKG3t
         v6jrPuKfQbzGgsIL98V9SzitClNrxXtr5Gl7Sd71SrKOP7n2Rd9wK0KZVm6KQaVHa+jL
         W4RdSyoaZbbXNRucpHlJ8Z9EtmwXiSNUZOncYy2CsQdKY2C1QH8456f9SnWskshsgZNT
         uFOOkktZooPW0OQIjY9chxvRV0u/OC8K1zp8E3PO+lokUwafNUUGnxxbUIrlANr3bloM
         GSLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=stxK5eytfi7UYuaTvPr6AF15rib5TqQ7VohLY8AETTo=;
        b=XlyDHcSped+5YNVTjIHdLEZn+H8iTERhcmwzSrNmcYKcAsFu3qRHmDcO5rGTiJeIFt
         3R5eSux6a/UuPdZoRXnH3Xl1Yx2B31gSo5YffsFRPpostBJ0rr2L91B/uE3LBicnIjDR
         S4k2dT2sRFiJwj0ZiSihAtXARcuLxcWGOTcrSKEX7Efx1/mXhFUKpgR4Py3GvWD65THU
         vIKecOq9DM9meTcL731kOj4aPDPq4WsfkE9RIwvFZXSmnLrSqWnL5NF99u8+9wXJ471V
         2NwELJRl6WaMzkX1C9kS+RPYbWCEWh/LI/nMR95Hx6WHia2YLgluT5Y9LnzOB8nVjNOL
         XoXA==
X-Gm-Message-State: ACrzQf2XFdlodFNxsMzHYoqxKa0os7LNRalQaGiAhL0JNUH2C4zp07Uk
        P5NRxEQ9zRva266GU8/Pv6TiPQ==
X-Google-Smtp-Source: AMsMyM4PWFE5pVw18NO2lbdt/TsjQ6FJS7+cij5WQtyZmovc7uLcrH3PCdFglUP7Tg7u6mRpJ23L7A==
X-Received: by 2002:a17:90b:3d89:b0:20b:201e:9d with SMTP id pq9-20020a17090b3d8900b0020b201e009dmr3592539pjb.11.1665105823006;
        Thu, 06 Oct 2022 18:23:43 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id k3-20020a632403000000b00439920bfcbdsm395764pgk.46.2022.10.06.18.22.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 18:23:11 -0700 (PDT)
Date:   Fri, 7 Oct 2022 01:22:26 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Andrew Jones <andrew.jones@linux.dev>
Cc:     Thomas Huth <thuth@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] KVM: selftests: Use TAP interface in the
 kvm_binary_stats_test
Message-ID: <Yz9/UsWtYimt2T1D@google.com>
References: <20221004093131.40392-1-thuth@redhat.com>
 <20221004093131.40392-2-thuth@redhat.com>
 <20221005083312.dnblbpe6wabspkzk@kamzik>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221005083312.dnblbpe6wabspkzk@kamzik>
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

On Wed, Oct 05, 2022, Andrew Jones wrote:
> On Tue, Oct 04, 2022 at 11:31:29AM +0200, Thomas Huth wrote:
> > The kvm_binary_stats_test test currently does not have any output (unless
> > one of the TEST_ASSERT statement fails), so it's hard to say for a user
> > how far it did proceed already. Thus let's make this a little bit more
> > user-friendly and include some TAP output via the kselftest.h interface.
> 
> I like the idea of switching the entire kvm selftests framework and all
> tests to the ksft TAP interface. But, if we want to do that, then the
> question is whether we should start by partially using it for some tests,
> and then eventually switch over the framework, or whether we should try to
> switch everything at once.
> 
> I think I prefer the latter, because without changing the framework we
> can't provide full TAP anyway as TEST_ASSERT exits with 254 instead of 1
> for a fail-exit and it doesn't output a final TAP test summary either.

I would much prefer the latter, e.g. with common entry/exit points[*], much of the
boilerplate can be done once in common code.  I bet we could even figure out a way
to have tests default to setting a plan of '1' so that simple tests don't need to
care about TAP at all.

[*] https://lore.kernel.org/all/20220915000448.1674802-2-vannapurve@google.com
