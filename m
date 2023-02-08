Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2428A68E5C7
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 03:05:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229745AbjBHCFt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 21:05:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbjBHCFq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 21:05:46 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0656E2941A
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 18:05:46 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id m12-20020a1709026bcc00b001963da9cc71so9009831plt.11
        for <linux-kernel@vger.kernel.org>; Tue, 07 Feb 2023 18:05:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C1W8e11im7COQXBJnvVmMysSW4KfN0tM7IqSdIDRp54=;
        b=GyOes+YDy29rdHNacHKCOsLgWTuPjcft9gzmj1CSD0fYoZtkBZRw6MfzMhzHtTtvXW
         0ACoWjacVRjE32wx2fmKQq+NM1lprfRrWzw5W1aCJxVNuOjw5qqPDdoQ+KQ95LR4HgYF
         Od+r6Kp898m4XJaDG5OoYjn0l1/2f+J5gfvK7LPW1PbWuPaF6G8pDLcs9TdBiovhMih8
         n3Li8x8ElcLZzP/yMY6eR/g1dm85oSCfyCGK3oRsInbMr+4ZCZOElUIPH6hPQnfP4TvJ
         0td8Ri+Q+hX2LpWFnCxoZazDQeAXlV4LkxXGEfDsDMhHkcCSIjSBu2W5wNsy66wc1LMc
         NrkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=C1W8e11im7COQXBJnvVmMysSW4KfN0tM7IqSdIDRp54=;
        b=CL+1B4o1829vIR7xdxVXM5DBFhO1MuakgG8lp3nP2DdNo7oV4I5FzGts8zoKJNhUg4
         6HFPNFx8qDJ90KUTKkypP3yNvDLBiMm0WKLx5RpIFxQEa9S8oqxe4MBHmreK+StwYWfl
         6us+ykHrJk0QvkZKItZ8M7iuh1I76lZW9vNS/rpSt+aDOqDErEYG5G1rM4egVZ6aDP51
         run7w5vLbAlDRTBunOE5C465QBNGyBdUiw8cGI6UdWTa4ZL9cPvWxhlHEI7VWctRH/A4
         X2LOWrL+s0hWiP16/sMEz2V2DX1as7biBzL2mDqad9uZzz4AaLdTsZLhBncA9hEjtsia
         39GA==
X-Gm-Message-State: AO0yUKXZGwvWkXGez5Hkm+z44ijFOCU/AFIevLqOWpwqKBkQm6j6sRtT
        Prx7r5LX+VJDQfxWKHcv05ejbUxpDFc=
X-Google-Smtp-Source: AK7set8h7vg7Fygf93+/g0admCY65Yv10Gg1rk5tlNHFygfvVto8XDhbTJp0RKDyJBkrR2LjGb206VOwc6Y=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90a:c202:b0:230:ee6f:28bc with SMTP id
 e2-20020a17090ac20200b00230ee6f28bcmr37728pjt.1.1675821945088; Tue, 07 Feb
 2023 18:05:45 -0800 (PST)
Date:   Wed,  8 Feb 2023 02:02:39 +0000
In-Reply-To: <20221109075413.1405803-1-yu.c.zhang@linux.intel.com>
Mime-Version: 1.0
References: <20221109075413.1405803-1-yu.c.zhang@linux.intel.com>
X-Mailer: git-send-email 2.39.1.519.gcb327c4b5f-goog
Message-ID: <167573583777.163276.8920768819160007143.b4-ty@google.com>
Subject: Re: [PATCH v2 0/2] Cleanup VMFUNC handling in KVM.
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>, pbonzini@redhat.com,
        kvm@vger.kernel.org, Yu Zhang <yu.c.zhang@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 09 Nov 2022 15:54:11 +0800, Yu Zhang wrote:
> Since VMFUNC is not supported for non-nested guests, and executing VMFUNC
> can cause a #UD directly, if the =E2=80=9Cenable VM functions=E2=80=9D VM=
-execution control
> is 0, KVM can just disable it in VM-exectution control, instead of taking
> pains to trap it and emulate the #UD for L1 guests.
>=20
> Also, simplified the process of setting SECONDARY_EXEC_ENABLE_VMFUNC for
> nested VMX MSR configurations.
>=20
> [...]

After much waffling, applied to kvm-x86 vmx.  I ended up keeping the logic =
to
inject #UD on now-unexpected VMFUNC exits from L1, i.e. patch one does noth=
ing
more than clear the control bit.  I like the idea of clearing the control b=
it as
it more explicitly documents what's going on, but killing the VM on an unex=
pected
exit that KVM can gracefully handle seemed unnecessary.

Thanks!

[1/2] KVM: VMX: Do not trap VMFUNC instructions for L1 guests.
      https://github.com/kvm-x86/linux/commit/41acdd419735
[2/2] KVM: nVMX: Simplify the setting of SECONDARY_EXEC_ENABLE_VMFUNC for n=
ested.
      https://github.com/kvm-x86/linux/commit/496c917b0989

--
https://github.com/kvm-x86/linux/tree/next
https://github.com/kvm-x86/linux/tree/fixes
