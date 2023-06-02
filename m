Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0804972057E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 17:09:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236475AbjFBPJT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 11:09:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236443AbjFBPJM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 11:09:12 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EE61E4D
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 08:09:10 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id 41be03b00d2f7-53425d37f33so1015255a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jun 2023 08:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685718549; x=1688310549;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Nm6pXa+HYoxt2r3AeUI919wrQrfzAxz3+IaYjnh25eI=;
        b=CR6zAayusmivzJXEJTT4xo41SprWgGVKmqxFpPcnXXCOZwv7rQ9YKugBL49IUmT5H/
         PXmEs2DPAZMaS5HhhZJNSemLJtYyT8LFyswtbyKobbyBSQbTUfYwPaWZucrdpIHB8+c4
         SLyxcE4ec5RHEi3fRT1aB/W8mhIACorI2bWFhs5OWRBJ76EkoLy/6OsSnETFnMXt8LAe
         m5EUq+h3s0MoRf31rqQh7zeEaNqNc1hchJ9rOYTXf3a3HKjTr+jqZ2Lp+657W1rE58AT
         gYnO93OXQM7Qx9RQvDEV4jqFXRVNQU5JUNumZCgMzg+MMzETwv6b3lf8tAxd5C9lQ+ZK
         Hs4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685718549; x=1688310549;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Nm6pXa+HYoxt2r3AeUI919wrQrfzAxz3+IaYjnh25eI=;
        b=bk4+tXxxB29WXTRJBHFvtBLzQ5t125U34+eFX6LN/XAUvb/83+fNfH4NgLN88pmWW3
         QHhsic4dRYCgwj4tx/dlpJrgm3Met3CKNcZGXqYRKiAB3Mk3G96fJOoif0UOUv2IiFl1
         FjiSViDFlZT+/VbExEVm6VhZ785G50D+6LFNGya3LE81ROfr69xOz3Xgqg1ISltZZcDy
         /7KlH8C7okCLj5J1sIGco8CZXNSr9q2RMfvJUxOp7kWbg54TFdLnBuEKkNBZNiLG7aiv
         p1JLqbLAyw1GhT2JkA6w9D01M8vOlKopiGJN3RmKHCds530aQBiVky6X4KmpwsslIa+5
         etEQ==
X-Gm-Message-State: AC+VfDwSzHB5SpiCq6eBMfZu9h7/BZOjILcap6IIpYpxHTov3B+ue3iR
        CpEfve5Fg+18O3XgNuYoN3H8xV2VjDU=
X-Google-Smtp-Source: ACHHUZ7ehZqOGi5yJHK/JvfEtptjcWfG6fH6aJR6XDnDzGuMkl2AI1NWWTXlsI4ACXb4SljxOgCrMzGnjr4=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a63:5f16:0:b0:52c:8878:65dd with SMTP id
 t22-20020a635f16000000b0052c887865ddmr2374005pgb.0.1685718549518; Fri, 02 Jun
 2023 08:09:09 -0700 (PDT)
Date:   Fri, 2 Jun 2023 08:09:07 -0700
In-Reply-To: <28bd9d11-282f-bb22-66f5-d3d9165d4adf@gmail.com>
Mime-Version: 1.0
References: <20230602005859.784190-1-seanjc@google.com> <28bd9d11-282f-bb22-66f5-d3d9165d4adf@gmail.com>
Message-ID: <ZHoGEwFqx3kJrmJe@google.com>
Subject: Re: [PATCH] KVM: x86/mmu: Add "never" option to allow sticky
 disabling of nx_huge_pages
From:   Sean Christopherson <seanjc@google.com>
To:     Robert Hoo <robert.hoo.linux@gmail.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Li RongQing <lirongqing@baidu.com>,
        Yong He <zhuangel570@gmail.com>,
        Kai Huang <kai.huang@intel.com>
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 02, 2023, Robert Hoo wrote:
> On 6/2/2023 8:58 AM, Sean Christopherson wrote:
> > @@ -6860,15 +6871,29 @@ static int set_nx_huge_pages(const char *val, const struct kernel_param *kp)
> >   	bool old_val = nx_huge_pages;
> >   	bool new_val;
> > +	if (nx_hugepage_mitigation_hard_disabled)
> > +		return -EPERM;
> > +
> >   	/* In "auto" mode deploy workaround only if CPU has the bug. */
> > -	if (sysfs_streq(val, "off"))
> > +	if (sysfs_streq(val, "off")) {
> >   		new_val = 0;
> > -	else if (sysfs_streq(val, "force"))
> > +	} else if (sysfs_streq(val, "force")) {
> >   		new_val = 1;
> > -	else if (sysfs_streq(val, "auto"))
> > +	} else if (sysfs_streq(val, "auto")) {
> >   		new_val = get_nx_auto_mode();
> > -	else if (kstrtobool(val, &new_val) < 0)
> > +	} else if (sysfs_streq(val, "never")) {
> > +		new_val = 0;
> > +
> > +		mutex_lock(&kvm_lock);
> > +		if (!list_empty(&vm_list)) {
> > +			mutex_unlock(&kvm_lock);
> > +			return -EBUSY;
> > +		}
> > +		nx_hugepage_mitigation_hard_disabled = true;
> > +		mutex_unlock(&kvm_lock);
> > +	} else if (kstrtobool(val, &new_val) < 0) {
> >   		return -EINVAL;
> > +	}
> > 
> 
> IIUC, (Initially) "auto_off"/"off" --> create some VM --> turn to "never",
> the created VMs still have those kthreads, but can never be used, until
> destroyed with VM.

Shouldn't be able to happen.  The above rejects "never" if vm_list isn't empty,
i.e. if there are any VMs, and sets nx_hugepage_mitigation_hard_disabled under
kvm_lock to ensure it can't race with KVM_CREATE_VM.  I forgot to call this out
in the changelog though.
