Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E020687276
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 01:41:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbjBBAli (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 19:41:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbjBBAlh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 19:41:37 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ADE510CF
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 16:41:36 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id q130-20020a632a88000000b004a03cfb3ac6so156808pgq.6
        for <linux-kernel@vger.kernel.org>; Wed, 01 Feb 2023 16:41:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ki4d1amc34jkc//m/AGYcKlSJMLDGM1z24weSMYegUw=;
        b=lAC5IQfuVVYZaNvem1btGD4sQHpdFvpjfm/4DkyoF9BMpfeeI5F0VcT2jZAUkFMaCe
         4VdU+GZgPVmB13xUo8iLbjX3ABIxkXK2/lWIlQSxSHf8EtjutPt/C3gvjZzZJdmMDU/P
         YXG5xXahFBOHdPPcZCEfnIq4TGllzWQuFuksb5ELSwcqMPX+6777p6+oFR3sjQD90b9j
         wvxEaiaIH/dBDz0xPRN1AYH4j1gxpYBYUWrspjKFoVF7xj32L4ln0+iRTt6zOIQXlKE4
         8QuAFgecCfbKF+LsJYTqd9a8gO3j3Tcv2Hq/EOcCQqU3K9wTgU5uLJkIpkkp/Fvzpvrb
         x+kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ki4d1amc34jkc//m/AGYcKlSJMLDGM1z24weSMYegUw=;
        b=JQHtGvBVk/2lCllkLT4oqUhdLGyI/91kTlUtLLYa86vE7f7+MX9jgoaabNOP84unKE
         n/f+4TgLqVeao9/FRLcg2oaNWYW5E2z0r7RV1MoXH0cAjaSTXyPIMOgwiYTO9asjtf3N
         sd+CH90UJ55F4sVf+aciBZuwnbEtcsZV6fvBRZAETQ65HTK0wBRxh2oqX6CbXZG09SB7
         ZW4foG7p3xQu1LHCCvVGuqoJu0mKPhaUvvaphSLzZOeOGFsr2OHa4JdpLw87+Eg0d9z2
         lVfs5fZ6zxsNbVEa462kc2hl7cwjz8NyfZ8iTXztTBDudTSSYM4rccLjnyOGGHjKTF3N
         5FxA==
X-Gm-Message-State: AO0yUKXwCfL2Ek15bKngaewuYMJc7L16JciueG5JKwbmk+E0i5k33kWw
        X302wOc/Xth0AXFvxYTjrYGocPabBtM=
X-Google-Smtp-Source: AK7set/ibaTucj5S+2mLkylmGNw0rkLHvVYpLtEbd/aGJVXbT1V8ve15HpfxeHvJnLpTUO6Iehbx+4iuQrI=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90a:14c2:b0:22b:fcb6:c7c9 with SMTP id
 k60-20020a17090a14c200b0022bfcb6c7c9mr173163pja.8.1675298495668; Wed, 01 Feb
 2023 16:41:35 -0800 (PST)
Date:   Thu,  2 Feb 2023 00:40:33 +0000
In-Reply-To: <20230109130605.2013555-1-eesposit@redhat.com>
Mime-Version: 1.0
References: <20230109130605.2013555-1-eesposit@redhat.com>
X-Mailer: git-send-email 2.39.1.456.gfc5497dd1b-goog
Message-ID: <167529475172.840042.11178742445383557195.b4-ty@google.com>
Subject: Re: [RFC PATCH 0/2] xapic: make sure x2APIC -> xapic transition correctly
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org,
        Emanuele Giuseppe Esposito <eesposit@redhat.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Shuah Khan <shuah@kernel.org>,
        Gautam Menghani <gautammenghani201@gmail.com>,
        Zeng Guang <guang.zeng@intel.com>,
        Krish Sadhukhan <krish.sadhukhan@oracle.com>,
        Jim Mattson <jmattson@google.com>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 09 Jan 2023 08:06:03 -0500, Emanuele Giuseppe Esposito wrote:
> The root cause is kvm_lapic_set_base() failing to handle x2APIC -> xapic ID
> switch, which is addressed by patch 1.
> Patch 2 provides a selftest to verify this behavior.
> 
> This serie is an RFC because I think that commit ef40757743b47 already tries to
> fix one such effect of the error made in kvm_lapic_set_base, but I am not sure
> how such error described in the commit message is triggered, nor how to
> reproduce it using a selftest. I don't think one can enable/disable x2APIC using
> KVM_SET_LAPIC, and kvm_lapic_set_base() in kvm_apic_set_state() just takes care
> of updating apic->base_address, since value == old_value.
> The test in patch 2 fails with the fix in ef40757743b47.
> 
> [...]

Applied to kvm-x86 apic, with the tweak of only stuffing the APIC_ID if the
APIC is enabled.  I also heavily reworked the testcase (see feedback on that
patch).

Thanks!

[1/2] KVM: x86: Reinitialize xAPIC ID when userspace forces x2APIC => xAPIC
      https://github.com/kvm-x86/linux/commit/052c3b99cbc8
[2/2] KVM: selftests: Verify APIC_ID is set when forcing x2APIC=>xAPIC transition
      https://github.com/kvm-x86/linux/commit/eb9819257631

--
https://github.com/kvm-x86/linux/tree/next
https://github.com/kvm-x86/linux/tree/fixes
