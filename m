Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E7A75FE692
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 03:27:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbiJNB1N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 21:27:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbiJNB1J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 21:27:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 149D71911DD;
        Thu, 13 Oct 2022 18:27:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BFC8461653;
        Fri, 14 Oct 2022 01:27:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEF97C43140;
        Fri, 14 Oct 2022 01:27:04 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="ULQYOrpv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1665710821;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=24hdqD0o9zuDN3qzzz04fhNACVqMbgxctFebht0Nkqg=;
        b=ULQYOrpvWep7AVJrOmQDPKEnWc2JHNzyvRH3NjYWdFNDowy20wa2garFzEB7HBiKiKUcS/
        Qez2+7iC4mF4Phywtf5M8gzy3Gkz+doXiU3BCoExOp5jntErCjOobO2TcDuPSAN0axSn5Q
        c1paAVn8dcqpZNixxRvUO8pXtbXeHQQ=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 16393373 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Fri, 14 Oct 2022 01:27:00 +0000 (UTC)
Received: by mail-vs1-f41.google.com with SMTP id v68so3556736vsb.1;
        Thu, 13 Oct 2022 18:27:00 -0700 (PDT)
X-Gm-Message-State: ACrzQf0Whsro83QiREOanNFUZzmGGXOmlGALN8KhjAFpekAMujeJOFdm
        hv30zadIok3aRTSYZgYrNZRiD2/NX6Py+4vGe28=
X-Google-Smtp-Source: AMsMyM4WzrspvZdHMowjkDqM7Ase6R9hQqfRRh+Uqfmu6p67ZhXqoVg8umT4I0FlTeOaGocwA++n8f2DTf/34Q9vmEo=
X-Received: by 2002:a05:6102:7c9:b0:3a7:6261:935 with SMTP id
 y9-20020a05610207c900b003a762610935mr1488462vsg.73.1665710818672; Thu, 13 Oct
 2022 18:26:58 -0700 (PDT)
MIME-Version: 1.0
References: <20221006223151.22159-1-elliott@hpe.com> <20221012215931.3896-1-elliott@hpe.com>
 <20221012215931.3896-10-elliott@hpe.com> <Y0ddUkGg15kHCIiB@zx2c4.com> <MW5PR84MB18427894BEF615BD08F4603EAB259@MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM>
In-Reply-To: <MW5PR84MB18427894BEF615BD08F4603EAB259@MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Thu, 13 Oct 2022 19:26:47 -0600
X-Gmail-Original-Message-ID: <CAHmME9p7SQv=iay3QujFU7jGaNXmhYhU9TWPobERBXQ1xNVV5g@mail.gmail.com>
Message-ID: <CAHmME9p7SQv=iay3QujFU7jGaNXmhYhU9TWPobERBXQ1xNVV5g@mail.gmail.com>
Subject: Re: [PATCH v2 09/19] crypto: x86 - use common macro for FPU limit
To:     "Elliott, Robert (Servers)" <elliott@hpe.com>
Cc:     "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "tim.c.chen@linux.intel.com" <tim.c.chen@linux.intel.com>,
        "ap420073@gmail.com" <ap420073@gmail.com>,
        "ardb@kernel.org" <ardb@kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 13, 2022 at 3:48 PM Elliott, Robert (Servers)
<elliott@hpe.com> wrote:
> Perhaps we should declare a time goal like "30 us," measure the actual
> speed of each algorithm with a tcrypt speed test, and calculate the
> nominal value assuming some slow x86 CPU core speed?

Sure, pick something reasonable with good margin for a reasonable CPU.
It doesn't have to be perfect, but just vaguely right for supported
hardware.

> That could be further adjusted at run-time based on the supposed
> minimum CPU frequency (e.g., as reported in
> /sys/devices/system/cpu/cpufreq/policy0/scaling_min_freq).

Oh no, please no. Not another runtime knob. That also will make the
loop less efficient.
