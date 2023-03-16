Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C31956BD69B
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 18:02:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230032AbjCPRCd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 13:02:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbjCPRC3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 13:02:29 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4727E63E4
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 10:02:24 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id j9-20020aa79289000000b00625894ca452so1416042pfa.22
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 10:02:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678986144;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=M6em1sBEzzzNaNnwmbv6HuaUPXjE1w6srV7Vot8YIBY=;
        b=AeHnKBH/IdBug5b16ObDBQWeKj+mfcQAhQp9nm7dk1Y6jtgJMOP2arJaGyL5LR+kIq
         cC0pm5t3OjERhq9V3r+IkR56EOvs8jsf5yYq6I8s59f2wE/N1GPfN9XBfkJt3cC+LfAT
         YaWwIlhdl9HpFI/8Dw/AQY6f4bKyEl4p7jBXGdAzY1zgpqvImMNyb3/uYVHLUplKe3s9
         16kOXsYoP+WTvGAvRDr+l0zP/OxWRV8ew9+PNgsbUwLwRzfwm4P9IHaetde0+JnegAuk
         YiwwMX6TkjeJgr+pJGxiFpJJwQAZ0v/gJAc42vXavmJ1sgwuSmbReM5Q2mU+mJ+/hfWT
         dd9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678986144;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M6em1sBEzzzNaNnwmbv6HuaUPXjE1w6srV7Vot8YIBY=;
        b=vQbHrRgUfdECn2cnUJmSjDqvCkYZZ1vfgzUL4fbUHFGag9DH9ZixcDUgWl9i248cT8
         xGjdcVxcdmb6KHNqAu8bCgC+wOPFnXggslqE4+9jNW4wiXUvo4hm78+oSZ5wI4dMAlZ5
         SfA9UAQFzYYBogOxDTdFStrIRf9nA+t1kqlXVtKi7uTnhvmLSekKc2EVMjUUnrawxAMp
         fryolNVfAWu97H8jMy2o95ZRogcE+tqIDdrK4Jy5hgywErgy7lE6609JwnBIjiurNwJL
         Lxs5/9HeYOlyvegRTyZrNoB2hmrT0BWbJ7Lu2aY4UJzdmODgt/GG6LeKHEfBo2viBkRC
         Ccfw==
X-Gm-Message-State: AO0yUKWhQCgYHFyutdSPGLFM4ah59SN3A1quqRLG0PbPQfO5v1SKq5hJ
        wDFkPxeKNJ33HKIj+vGXhiTdVj/ATqQ=
X-Google-Smtp-Source: AK7set/DzjhQqUZgDVaZkA3+tVBTzqelVV4sL6SfRsjHDtgpoFClkq21reaB5QhzTBjzs6LJKZNGZvetndk=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:301b:b0:625:f78a:56f with SMTP id
 ay27-20020a056a00301b00b00625f78a056fmr43690pfb.3.1678986144275; Thu, 16 Mar
 2023 10:02:24 -0700 (PDT)
Date:   Thu, 16 Mar 2023 10:02:22 -0700
In-Reply-To: <20230316154554.1237-1-shameerali.kolothum.thodi@huawei.com>
Mime-Version: 1.0
References: <20230316154554.1237-1-shameerali.kolothum.thodi@huawei.com>
Message-ID: <ZBNLnp7c1JvDsmHm@google.com>
Subject: Re: [PATCH] KVM: Add the missing stub function for kvm_dirty_ring_check_request()
From:   Sean Christopherson <seanjc@google.com>
To:     Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        gshan@redhat.com, maz@kernel.org
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 16, 2023, Shameer Kolothum wrote:
> The stub for !CONFIG_HAVE_KVM_DIRTY_RING case is missing.

No stub is needed.  kvm_dirty_ring_check_request() isn't called from common code,
and should not (and isn't unless I'm missing something) be called from arch code
unless CONFIG_HAVE_KVM_DIRTY_RING=y.

x86 and arm64 are the only users, and they both select HAVE_KVM_DIRTY_RING
unconditionally when KVM is enabled.
