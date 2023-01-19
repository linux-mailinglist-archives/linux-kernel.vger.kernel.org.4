Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 070816740B8
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 19:18:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230224AbjASSR6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 13:17:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230146AbjASSRi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 13:17:38 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D8304346A
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 10:16:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674152214;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Q+oPjhxahFRNdh2AOJEQpeD10rNKUEwEjHNdLdR7TwE=;
        b=N5zt35vb0gmkPULGPhwM2D5epK4zUwKrrcI3Ro7WauZtPS+JHeVVSTVs88JNx4lxdZtxcw
        lleJCAo5Els4Li/+6aJXZzrB8TRzex5VEtsToD/WqSYEjrxbv9Yh42QzmIVeOASuouMcAk
        h+h9vW85No6k0O2XJ309SRDh73o530o=
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-634-a8yzd3koNPSE8MJSaPYcVA-1; Thu, 19 Jan 2023 13:16:52 -0500
X-MC-Unique: a8yzd3koNPSE8MJSaPYcVA-1
Received: by mail-ua1-f70.google.com with SMTP id v21-20020ab05595000000b0060b269688fbso780411uaa.6
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 10:16:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q+oPjhxahFRNdh2AOJEQpeD10rNKUEwEjHNdLdR7TwE=;
        b=rh4UVaXahryEjkWTuGShHV5Rd4ZuLQys6T6HUvzfRwmBl0W3pcXY7OAoPhNZ/cq+5G
         nRNLK7GjQntW/qDdTQVdTvQLI5QMRWGpWo5nfBfYxDI8h/zbcXWzRCPE0prIiEDlLCvU
         +pox308eTOOA+hqoHxAq57jHBMY/Wl51yBc/xnRNWExmhJKw5iHeD9vP4objY/qqZG9Y
         ml6tOldgc1UN8vdLAVfiwedihF6q38cgKqVS39e+Q/4k9kXUsW/siRa/gT5LbTPCXzma
         CNEtzR1JbT43lwx8ufHTscHm4hZmgzq83ux9YhEb62FXNw/OdFlI2ynlkl4MBFbopJ/y
         tImA==
X-Gm-Message-State: AFqh2kowsNgTMA3/1WfzwRyI9RtFdcse2b1t0p3+7kBtinIvviWqGlrZ
        lRQuuvd9v8ZZtbLq2dy+gOTcRPnADeXET68LjUBO/4HKH5p0+UBTn8t2w8NZCHhqDBCbfCnaOSY
        3EtWcI8F6XHmMLw1fU307Vol5HnvP02QH90gNML2K
X-Received: by 2002:a05:6102:b09:b0:3d0:f045:c1eb with SMTP id b9-20020a0561020b0900b003d0f045c1ebmr1625581vst.54.1674152209557;
        Thu, 19 Jan 2023 10:16:49 -0800 (PST)
X-Google-Smtp-Source: AMrXdXtthD5MJghyW9vRqY3kw4Xa5W7Er3DFd3yJoQHRfgQ/SGRx//G/5kOA5gfW6jCk/RgHHH9euHP/f7VcqX4SsTw=
X-Received: by 2002:a05:6102:b09:b0:3d0:f045:c1eb with SMTP id
 b9-20020a0561020b0900b003d0f045c1ebmr1625574vst.54.1674152209344; Thu, 19 Jan
 2023 10:16:49 -0800 (PST)
MIME-Version: 1.0
References: <20221228110410.1682852-1-pbonzini@redhat.com> <20230119155800.fiypvvzoalnfavse@linux.intel.com>
 <Y8mEmSESlcdgtVg4@google.com> <CABgObfb6Z2MkG8yYtbObK4bhAD_1s8Q_M=PnP5pF-sk3=w8XDg@mail.gmail.com>
 <Y8mGHyg6DjkSyN5A@google.com> <CABgObfZZ3TLvW=Qqph16T0759nWy0PL_C3w3g=PACj9cpupBQA@mail.gmail.com>
 <Y8mIoUqO8qFgoBZI@google.com>
In-Reply-To: <Y8mIoUqO8qFgoBZI@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Date:   Thu, 19 Jan 2023 19:16:37 +0100
Message-ID: <CABgObfbCjQUZ9ES+vOdW7uZp6QHmz2cYQ=bnytScdcsDStWZ7Q@mail.gmail.com>
Subject: Re: [PATCH] KVM: x86: fix deadlock for KVM_XEN_EVTCHN_RESET
To:     Sean Christopherson <seanjc@google.com>
Cc:     Yu Zhang <yu.c.zhang@linux.intel.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Michal Luczaj <mhal@rbox.co>,
        David Woodhouse <dwmw@amazon.co.uk>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 19, 2023 at 7:15 PM Sean Christopherson <seanjc@google.com> wrote:
> A minor selftest fix
>
>   https://lore.kernel.org/all/20230111183408.104491-1-vipinsh@google.com
>
> and a fix for a longstanding VMX bug that seems problematic enough that it
> warrants going into this cycle.
>
>   https://lore.kernel.org/all/20221114164823.69555-1-hborghor@amazon.de

Ok, I had seen the latter so I'll put together a pull request.

Paolo

