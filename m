Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59F5B6B326C
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 00:53:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231347AbjCIXxy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 18:53:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230467AbjCIXxu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 18:53:50 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 434005ADD8
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 15:53:49 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id u3-20020a17090a450300b00239db6d7d47so3532755pjg.4
        for <linux-kernel@vger.kernel.org>; Thu, 09 Mar 2023 15:53:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678406029;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/B2yLiGeFDGVh+t6RbXU5CzGX5dV3zO3e2nniLJhd38=;
        b=o/5aWfB4irgyF4/g2aXzQjyWUkO6bB9wgIQoZ5SMykPvTJ+pMxuxXq9q4ZoYxYATaA
         +GRXOPZYaOcOaJaMdYCRLApGu9ks9SWAmTl/vhSjE+ZeNtDnAfQCT1vhLC1d+ichFWhx
         iaEes2RvW0+OX2B/LHe3/68egvG24Vb5MmFCIMXHXmC7dW80+b2fFUF8GW/U/GDLvG8C
         e8tAmxegZF8Q6K/vwHfBuVuCkZrk4XmBs2l14HOOh0T67sy7+GximF4ggEAe7j+DThY1
         N0u9BKwg4vUwYN9sgaaNiSqcH9+xbi3ufMsF7XI7akOOziybYFjnItssWp5AcHuR7p8U
         GNVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678406029;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/B2yLiGeFDGVh+t6RbXU5CzGX5dV3zO3e2nniLJhd38=;
        b=Zf2+qvuO9RfVvsOaK+vbRZSJQgkkJDCo0MBU48ag31j2BLk8BZUUW0QzZ+U/ci1UAM
         ErSy9CFT6x8Bf7NpkKTsrN+S/k4vNm/7gSXQM200lZYelY3OmR0KPE589Wcx6JxMPdJm
         o2B9jsM5atv1at/e2GZuAIH2WkbyUS1V8HFjEDomqf9F73grOXI2fyXRnJaDWyDynh8b
         Cgpm9kX7C23N+y+cPWTJbET0/mwxO/6Sz6VtmKOYGvlIUvfNmf4/4tXdY8N1X5+QbesD
         MQAYVSiuOwbyhnkyWceSJpGzjX5qBuiQWXXCeACJc6j/5dRwortipk6AbiU+SkqPgqyo
         3ovg==
X-Gm-Message-State: AO0yUKWj9BtH+DCmoBYfmkFZQuvnP3+F/jTLWjKLmfk7xbe7awjOqYG4
        yWt8TGKBvBOHqcsW4XjeG7upqBwxDRjg9orqqMOUhQ==
X-Google-Smtp-Source: AK7set+XQad+rlik254MTP1MVfd/TT90vMsn7uqie0O+bd2RtGV5RLgMDJAF0Blyl0x61OqFu+meeg==
X-Received: by 2002:a17:90b:33d1:b0:238:13cb:7d4d with SMTP id lk17-20020a17090b33d100b0023813cb7d4dmr23854130pjb.16.1678406028632;
        Thu, 09 Mar 2023 15:53:48 -0800 (PST)
Received: from google.com (223.103.125.34.bc.googleusercontent.com. [34.125.103.223])
        by smtp.gmail.com with ESMTPSA id gq22-20020a17090b105600b002376d85844dsm116873pjb.51.2023.03.09.15.53.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Mar 2023 15:53:47 -0800 (PST)
Date:   Thu, 9 Mar 2023 15:53:43 -0800
From:   David Matlack <dmatlack@google.com>
To:     Vipin Sharma <vipinsh@google.com>
Cc:     seanjc@google.com, pbonzini@redhat.com, bgardon@google.com,
        jmattson@google.com, mizhang@google.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [Patch v4 03/18] KVM: x86/mmu: Track count of pages in KVM MMU
 page caches globally
Message-ID: <ZApxh/GYfqev7sHA@google.com>
References: <20230306224127.1689967-1-vipinsh@google.com>
 <20230306224127.1689967-4-vipinsh@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230306224127.1689967-4-vipinsh@google.com>
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

On Mon, Mar 06, 2023 at 02:41:12PM -0800, Vipin Sharma wrote:
> Create a global counter for total number of pages available
> in MMU page caches across all VMs. Add mmu_shadow_page_cache
> pages to this counter.

I think I prefer counting the objects on-demand in mmu_shrink_count(),
instead of keeping track of the count. Keeping track of the count adds
complexity to the topup/alloc paths for the sole benefit of the
shrinker. I'd rather contain that complexity to the shrinker code unless
there is a compelling reason to optimize mmu_shrink_count().

IIRC we discussed this at one point. Was there a reason to take this
approach that I'm just forgetting?
