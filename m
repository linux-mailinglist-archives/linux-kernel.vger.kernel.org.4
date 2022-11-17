Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EBFE62D088
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 02:21:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234544AbiKQBVG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 20:21:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229939AbiKQBVE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 20:21:04 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AA2C21BD
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 17:21:02 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id 62so557359pgb.13
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 17:21:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Z9RXOutukKu5blPlWvexAz9n9/ERlHayplCb37e/A/4=;
        b=BCJ2yFn1tsn53sy1KM+C8Zdkm82sOpVH7Y2IEhdM8rEe13KY0+JzJibXQNw49jtg0F
         YJpEGHLSia5ik4xDLNtUdQIGQn0Mnvq5shG/tD+yC5C36OKusWOkmEEIIWPLzDz+LDeJ
         +EbWB3TGbfUThJkJrUqfMhcfj7xrboNt4Z3Q1/VY4vEMS6ja/gEVrEgQtOn4PLLnvf0+
         Dknem1k3dNWoBkp4GT9fG6BrZjEyaqrE8zcMCpiFHFeZs/CeijWHWxsjzlujxeDGbT4a
         ZNQETjJ5XpC/A7xD7UgpSEMubrDNSt+PhkWikvJsLXLMyToq6DkALWrxQCrz4tbZ83dw
         bSvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z9RXOutukKu5blPlWvexAz9n9/ERlHayplCb37e/A/4=;
        b=1gh8Rn0k9DdAzjigBE2OoENpniJx2rU63oCjQvfknfzBN67Hk2pT8yHW+D19SA8pOz
         repS3o/FAR6OkY0HLI5EZzmdh5sIzg3IAW4G6mz8XaL/xeNRXGPnkUccnU9v3ExnUptC
         uFiFr0v3nny1tSjXTi16GfxuGnBQ7j6AcFNTR2lzZF3Y3r36BW4eAzL916nFWfY8CzUG
         Gjwm0gGe1A4IC9TrNUR8bCXSG182jHZIhXqzmC6cq7/PfYFp/2bGaDuV4v0iCFgdlXhh
         7QUVmWEafbHI7xD3pufMvv+Tj1xdtE5h8UPcEFHsKjd3deEWOfxY4baIeYPhXsH1g1nu
         Y3aw==
X-Gm-Message-State: ANoB5pmlDOXmY3EJ4/z3SfOjfCw2wQtMTrxXnGnorm7PwjLC32EL2Q2w
        V7e5oEmIotcy2w2hv6jR4qVrDQ==
X-Google-Smtp-Source: AA0mqf5o9XatuCWD5GyO3XSpaGxhhYlntr2oFTRpGlCI7pnvkOwR1rcY7hYGwMMPWemsdnVer00SUA==
X-Received: by 2002:aa7:9518:0:b0:56c:8c13:24fd with SMTP id b24-20020aa79518000000b0056c8c1324fdmr778700pfp.2.1668648061959;
        Wed, 16 Nov 2022 17:21:01 -0800 (PST)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id e12-20020a63544c000000b0047048c201e3sm4864960pgm.33.2022.11.16.17.21.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 17:21:01 -0800 (PST)
Date:   Thu, 17 Nov 2022 01:20:58 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Oliver Upton <oliver.upton@linux.dev>
Cc:     Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org,
        Reiji Watanabe <reijiw@google.com>
Subject: Re: [PATCH 2/2] KVM: arm64: selftests: Disable single-step without
 relying on ucall()
Message-ID: <Y3WMeovid9z1qOjD@google.com>
References: <20221117002350.2178351-1-seanjc@google.com>
 <20221117002350.2178351-3-seanjc@google.com>
 <Y3WF8YlvFm8NGYHd@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y3WF8YlvFm8NGYHd@google.com>
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

On Thu, Nov 17, 2022, Oliver Upton wrote:
> On Thu, Nov 17, 2022 at 12:23:50AM +0000, Sean Christopherson wrote:
> > Automatically disable single-step when the guest reaches the end of the
> > verified section instead of using an explicit ucall() to ask userspace to
> > disable single-step.  An upcoming change to implement a pool-based scheme
> > for ucall() will add an atomic operation (bit test and set) in the guest
> > ucall code, and if the compiler generate "old school" atomics, e.g.
> 
> Off topic, but I didn't ask when we were discussing this issue. What is
> the atomic used for in the pool-based ucall implementation?

To avoid having to plumb an "id" into the guest, vCPUs grab a ucall entry from
the pool on a first-come first-serve basis, and then release the entry when the
ucall is complete.  The current implementation is a bitmap, e.g. every possible
entry has a bit in the map, and vCPUs do an atomic bit-test-and-set to claim an
entry.

Ugh.  And there's a bug.  Of course I notice it after sending the pull request.
Depsite being defined in atomic.h, and despite clear_bit() being atomic in the
kernel, tools' clear_bit() isn't actually atomic.  Grr.

Doesn't cause problems because there are so few multi-vCPU selftests, but that
needs to be fixed.  Best thing would be to fix clear_bit() itself.
