Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A72175FAF20
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 11:13:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229966AbiJKJNT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 05:13:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbiJKJNQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 05:13:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F5A2EE18
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 02:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665479592;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VThX7WbifVT6BXrss5grux5JWHQo9lFU0LPJWiFOeu0=;
        b=cQNTw/7yPgY9WnPQyybuLZ/c8xq6kXt1AFvfPoGCjkJi/rOP3kqpmwmzJxlbMDzO4iZH2s
        u+X8A6IqZTg49ElDXW14y1DxQc5WtQUAIvmrsU9DmIM78s5woNCLJFPUFQTdYydd3yBnbY
        /E/Dqvj7yqmzXv4rPEMhovgU9Ni37Bs=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-119-h55QAZnKMdG3M91a2uxnCA-1; Tue, 11 Oct 2022 05:13:11 -0400
X-MC-Unique: h55QAZnKMdG3M91a2uxnCA-1
Received: by mail-ej1-f71.google.com with SMTP id gn33-20020a1709070d2100b00787e6fbcb72so5579268ejc.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 02:13:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VThX7WbifVT6BXrss5grux5JWHQo9lFU0LPJWiFOeu0=;
        b=MY+4zKLCwtyPrNB9IMkaIFdWJ+sGBvUF2DJAzB9+R0v7qKVJNC48z/kcZUey4l8v3G
         7BqEPeMw2r9k4hsbNWU0F33QgCVo6x/9AG/fBVb6y+TzayIyiigTuxzHN4b98tZkmu+s
         VUob7E8ly915Kh2GW563WHKd18jtCZpUSpIPF3vQaY1LW7GxOespNK1nSdg/QhOaWobv
         RzOsAW9yMYikmwTbE03a5c8SvSGiwPvtRPv6vmYWmChgGj9KeWQZ7I3Zy3BOoBMSOvXW
         LTjotd9bHX5DpgOGBTpO3CE4wH0S/BcXPYSri+qg6x0Xf3hzYywOEKsVk53NnpT028x9
         +8Cg==
X-Gm-Message-State: ACrzQf3pvqNb2nY+HDDjpzx96emzTVaqx1rM5ZWkk2Uz72yozzZJ+LrL
        2NF2akjpztUuDezFx70r1wxgKwOaqcgGxBL/T06Ibi/RytdNZU4/RKXkfmM7u5eNplcwy4axZCu
        RvKcO8W0WTTpV9BoorEGwSwgq
X-Received: by 2002:a05:6402:42c3:b0:459:cebb:8d3a with SMTP id i3-20020a05640242c300b00459cebb8d3amr22291458edc.421.1665479589934;
        Tue, 11 Oct 2022 02:13:09 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7rwXi31GTGapUa9CJLiOZ/I3OJKRFG0ol4xHLIaRP/F+ZlHvFBopeGF9Nqar2zmSmyZrZuLw==
X-Received: by 2002:a05:6402:42c3:b0:459:cebb:8d3a with SMTP id i3-20020a05640242c300b00459cebb8d3amr22291444edc.421.1665479589769;
        Tue, 11 Oct 2022 02:13:09 -0700 (PDT)
Received: from ovpn-194-196.brq.redhat.com (nat-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id ti5-20020a170907c20500b0078bfff89de4sm6573881ejc.58.2022.10.11.02.13.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Oct 2022 02:13:08 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     kernel test robot <lkp@intel.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org
Subject: Re: [linux-stable-rc:linux-5.15.y 4542/9999]
 arch/x86/kvm/hyperv.c:2185:5: warning: stack frame size (1036) exceeds
 limit (1024) in 'kvm_hv_hypercall'
In-Reply-To: <202210110411.z2fNZUCa-lkp@intel.com>
References: <202210110411.z2fNZUCa-lkp@intel.com>
Date:   Tue, 11 Oct 2022 11:13:07 +0200
Message-ID: <875ygq910c.fsf@ovpn-194-196.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kernel test robot <lkp@intel.com> writes:

> Hi Vitaly,
>
> FYI, the error/warning still remains.
>
> tree:
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
> linux-5.15.y

...

>
> All warnings (new ones prefixed by >>):
>
>>> arch/x86/kvm/hyperv.c:2185:5: warning: stack frame size (1036) exceeds limit (1024) in 'kvm_hv_hypercall' [-Wframe-larger-than]
>    int kvm_hv_hypercall(struct kvm_vcpu *vcpu)
>        ^
>    1 warning generated.

For the reference, previous discussion of the problem:
https://lore.kernel.org/kvm/87zgg6sza8.fsf@redhat.com/

The patch to fix this:
https://lore.kernel.org/kvm/20221004123956.188909-19-vkuznets@redhat.com/

is part of "KVM: x86: hyper-v: Fine-grained TLB flush + L2 TLB flush
features" series (v11:
https://lore.kernel.org/kvm/20221004123956.188909-1-vkuznets@redhat.com/) 
which I hope to see in 6.2 (fingers crossed!), however, it is unlikely
to go to stable@ unless we know that there's a real problem to fix. I'll
backport it then.

-- 
Vitaly

