Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCD2569B062
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 17:15:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231215AbjBQQPd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 11:15:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230504AbjBQQPI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 11:15:08 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCFA66F7CF
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 08:14:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676650461;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=u7A6kRVX9USFvrSe+YUq3qxqmtep/gOesQK4GbyltR4=;
        b=gVOlzoemAkJh1SvRpFQFK6110NR5uk/PUWYOD2fgXy2HxDq1MMaRCE98/UX3F3s1m9tqRz
        MfhsdXhNjUfnp86wQaSRHkMXy9qT8hgmxHMdE82CEjPaj3LlMa+46Mx0MM62UZbtB2hWvN
        RpOWHj0+Xl9qchNzkmgdmV47q11QMCo=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-664-Ym2dGXiUOzOUnIRXbp709w-1; Fri, 17 Feb 2023 11:14:19 -0500
X-MC-Unique: Ym2dGXiUOzOUnIRXbp709w-1
Received: by mail-pl1-f200.google.com with SMTP id l11-20020a170902cf8b00b0019ab46166a3so1076589ply.5
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 08:14:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u7A6kRVX9USFvrSe+YUq3qxqmtep/gOesQK4GbyltR4=;
        b=jz9cZs9YF6nB2K0nuBvsVK21ZXehgtd/MQMOKMSrZDRlD10gT39jy+Ajp72V0vPjO5
         TTo2R+60hs32W6AzBdioiT3HmksOjFmz57fXgUw+/kwGw2UFP3+kLbJsKjMeNj8AzEYg
         ueXtbKIf1AMOreavFPDSocvv4iChTMcF+OoznGmv8YW96RbJSRvNFyJnW1Ne6YWN/eE4
         xyR1ZkyOeJJ7s2pWs8/28kRHzo1n89vP362ZLdPskQZvQEIxk3QPOmAWOOwCaraCGBM2
         B9QgZvfXHvF8/7ffxL1k3+RWpIo3y8SMC03fxRi3LXRohsPoEd0c7wSman/oH12qSp6R
         qYwg==
X-Gm-Message-State: AO0yUKVJeTnOVH/5uxyG7mZthNmQkihvynNd1hXICq2EVGw1h7Ys4wNw
        QFD+RDDnpdlecKCQ9GvQ5n1DPLjUrGU9HuM9Wxa+9BWhKxhs91ti6gi/J6+z4pJpYbdDsvanABc
        Kor4LkHsRvciKIi3xBKV31ITK8dd66z37KVAtW5zL
X-Received: by 2002:a17:90b:2d86:b0:231:20d9:2f7 with SMTP id sj6-20020a17090b2d8600b0023120d902f7mr1654049pjb.109.1676650458679;
        Fri, 17 Feb 2023 08:14:18 -0800 (PST)
X-Google-Smtp-Source: AK7set8tohgmQvChINWAF1kGtAV+Sq+F9YMF564KXupouv9JfMhUKwddcZOA0loNKhsyYDpLmFpTD2XWH016z1I4u04=
X-Received: by 2002:a17:90b:2d86:b0:231:20d9:2f7 with SMTP id
 sj6-20020a17090b2d8600b0023120d902f7mr1654048pjb.109.1676650458370; Fri, 17
 Feb 2023 08:14:18 -0800 (PST)
MIME-Version: 1.0
References: <20230215131807.293556-1-omosnace@redhat.com> <20230215124747.6f8df3c4675517eacf1e9a39@linux-foundation.org>
In-Reply-To: <20230215124747.6f8df3c4675517eacf1e9a39@linux-foundation.org>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Fri, 17 Feb 2023 17:14:05 +0100
Message-ID: <CAFqZXNsP8zrQ=trMqLE09T5P-poeDPAVLj_YkTc1NpEDn4c_Sw@mail.gmail.com>
Subject: Re: [PATCH] kernel/sys.c: fix and improve control flow in __sys_setres[ug]id()
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

On Wed, Feb 15, 2023 at 9:47 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Wed, 15 Feb 2023 14:18:07 +0100 Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> > 1. First determine if CAP_SET[UG]ID is required and only then call
> >    ns_capable_setid(), to avoid bogus LSM (SELinux) denials.
>
> Can we please have more details on the selinux failures?  Under what
> circumstances?  What is the end-user impact?
>
> Because a fix for "bogus LSM (SELinux) denials" sounds like something
> which should be backported into earlier kernels, but there simply isn't
> sufficient information here for others to decide on this.

Fair point. I will send a v2 with a more detailed explanation.

-- 
Ondrej Mosnacek
Senior Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

