Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B28615BF1AA
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 02:03:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230232AbiIUADC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 20:03:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229971AbiIUAC7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 20:02:59 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91FB45FF44
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 17:02:58 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id 102-20020a9d0bef000000b0065a08449ab3so2875910oth.2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 17:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=8law8D5pcm6I8ecnHk2V8T33DhrE54Khl2jFwyTG1+Y=;
        b=DoU1CkIavINkLQHOAuDkCtgufNCV7SKnx9KvLGtRb18JeX+9n1WSjZdFDa9Q57wciT
         xmTxa2tvdQuSQk93N/zuzntn8kUao4CCpuS2pXk7qFK3Hz8z1lsXohaC6xHVDOku822j
         QDNsNbrLV5HXakO/SHBeCf6vzsGzgWjPRcGrKwXUPryLRBzS//jx75ZXQGENzzdNb1bN
         DYLNHeyt94b7yXjVcrnSubDRFGneFnCxXWuGfM+iAUsq6/belo5q9gwtcKqc/Ykqsjae
         aOw+LmOO9h0AvPnYUCYkjrn4FR44QjyF8j6IW5h3TQULh6cO5nLguv8eWd0PdpXimI9U
         /HWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=8law8D5pcm6I8ecnHk2V8T33DhrE54Khl2jFwyTG1+Y=;
        b=NG+2Fbagxl+Hg01qvTdZCEKpAJZK3KAh2XkGKnLWZI4ItQYQ2GFt5f519fXRrIshSU
         QHyPc0C9UYRWFqHwS10Nnp+mZjxw72wwZ48L0nblPLI43i4wUPBwXBVfxNg/Zxdyq9kh
         njzNkhkZlEqZ9psJ4u87k2QbDK5rwvqeaxpYL1cin1e0nsUY5NUeGgX7gnFKvJlCiVnm
         aKNWX0Zqz8lfl3MVHsLxZaUxPSDIaE+z5NM3YysfFDsCDduqeXfvCS6tJkaOrR6ZoncR
         4+FXNwKDpY9MgfcY3URb0Aj0Azb7zX3GKBJsz4rJ5fD0WSZ0HH3QoaRbSgABiFHNAsgu
         PwcA==
X-Gm-Message-State: ACrzQf0YKAwLAhIs3TObzDzYhrLbsG4kwCeaK0RL8MqxGXxQ5QT+QoCd
        e7vW+9mCORdYpF4sNVY1ojE2ggxeIk2CwkXvMxIQ1Q==
X-Google-Smtp-Source: AMsMyM5T7Al2dm+R48Lk6EPwEL+yNQHSxRv9CXA93YKAt4RR7XKd4ZxdIyBzPusZ6ZdBI4aj2QS9/HEk87iA6KKG3iQ=
X-Received: by 2002:a05:6830:2705:b0:659:ebb0:ecad with SMTP id
 j5-20020a056830270500b00659ebb0ecadmr8739273otu.75.1663718577755; Tue, 20 Sep
 2022 17:02:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220919093453.71737-1-likexu@tencent.com> <20220919093453.71737-4-likexu@tencent.com>
In-Reply-To: <20220919093453.71737-4-likexu@tencent.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Tue, 20 Sep 2022 17:02:46 -0700
Message-ID: <CALMp9eTXRmuBvNNMhPvcwZE3+kFzR8qJYNspB2jjBoaw_EjS2A@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] KVM: x86/cpuid: Add AMD CPUID ExtPerfMonAndDbg
 leaf 0x80000022
To:     Like Xu <like.xu.linux@gmail.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sandipan Das <sandipan.das@amd.com>
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

On Mon, Sep 19, 2022 at 2:35 AM Like Xu <like.xu.linux@gmail.com> wrote:
>
> From: Sandipan Das <sandipan.das@amd.com>
>
> From: Sandipan Das <sandipan.das@amd.com>
>
> CPUID leaf 0x80000022 i.e. ExtPerfMonAndDbg advertises some
> new performance monitoring features for AMD processors.
>
> Bit 0 of EAX indicates support for Performance Monitoring
> Version 2 (PerfMonV2) features. If found to be set during
> PMU initialization, the EBX bits of the same CPUID function
> can be used to determine the number of available PMCs for
> different PMU types.
>
> Expose the relevant bits via KVM_GET_SUPPORTED_CPUID so
> that guests can make use of the PerfMonV2 features.
>
> Co-developed-by: Like Xu <likexu@tencent.com>
> Signed-off-by: Like Xu <likexu@tencent.com>
> Signed-off-by: Sandipan Das <sandipan.das@amd.com>
Reviewed-by: Jim Mattson <jmattson@google.com>
