Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51D11720CBB
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Jun 2023 02:53:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236961AbjFCAxg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 20:53:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236950AbjFCAx0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 20:53:26 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02DE9E51
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 17:53:24 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-568a8704f6dso36366207b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jun 2023 17:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685753603; x=1688345603;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=n041xAZDVwxiVPMIxRlYBoUvARBDDSPz3idlvcyMyR0=;
        b=vNlzgZX/Q1pYX8oIlG6T3QWVQpDTWxmVtc5SRsF8Bw7uI1yxaXzJabH5fngu8istNQ
         WsDf0m3H61WIneh+nfMgAHDRBOwmlkZjDJA8+eFdeHiaphjR8rxZJYF6atg5QiZ9WuPR
         MRYtcpKpdb54omdSW+iFPYjN1LV36vPTOUKF47cxC0hYYYZHDcf91iF4ESMdf4It6xA+
         3ZIUrnAmQeZM6j2GnioxaSiKuSl6iuogTp+/tOYQvRKAdKZi244l2LqrROU3bhjK2JA2
         LWjapl23jD382839ZmCypu1GARzbiEJBXlUvYQVoVVwRPKFkE2nAgGvPSZLmsP4WTQZM
         G/Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685753603; x=1688345603;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n041xAZDVwxiVPMIxRlYBoUvARBDDSPz3idlvcyMyR0=;
        b=e49uTudUB977LN298OaOMJ/xio415/zGAlVYD/73vfvbYQUjXzjamGobq9fprhtQ0T
         /xXO333I4iq94nmCpqho4TSRheXJga/RfePI8SQYHOJ1IaywrqyB66Jc7v4kaZLwPZi/
         bElEjUA8X+lZX04xZ3KhoeCZgdReEBFD1cUENX4xEAoKoWrSSHf6VGUmaOupc1cZasoh
         zf+lvgHHQqqIJMkRS/LBGX0CiS9HL20OKDbmcxHDC5dNxNq/UBeMFA8oSt+8m5uK5Twz
         R3urHKFiLkEPRCHQQcHgoPlSiV2gYW32u6P0vyXnOHnv6Q9Gk5RaskjTpkKkJpV+YH5z
         rkfg==
X-Gm-Message-State: AC+VfDzVhS6OuqhF1rWN0LZ4XFc5cxH2AmPIVTvc5iD5xX6dRd5wIuRn
        STnE7o+dFHo4z0tyRj570JysowcoCK0=
X-Google-Smtp-Source: ACHHUZ585eGvc+sAPbTEYw2bb6ViWhvFGyNlXQ/c8TVCCzvxYGotGuLp7iqAtgGmF3Mlc5fqrZJo1EISfDE=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a81:b705:0:b0:565:9bee:22e0 with SMTP id
 v5-20020a81b705000000b005659bee22e0mr767492ywh.0.1685753603297; Fri, 02 Jun
 2023 17:53:23 -0700 (PDT)
Date:   Fri,  2 Jun 2023 17:52:30 -0700
In-Reply-To: <20230602233250.1014316-1-seanjc@google.com>
Mime-Version: 1.0
References: <20230602233250.1014316-1-seanjc@google.com>
X-Mailer: git-send-email 2.41.0.rc2.161.g9c6817b8e7-goog
Message-ID: <168575177769.1031331.12817523609044474926.b4-ty@google.com>
Subject: Re: [PATCH v3 0/3] KVM: x86: Out-of-bounds access in kvm_recalculate_phys_map()
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Michal Luczaj <mhal@rbox.co>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 02 Jun 2023 16:32:47 -0700, Sean Christopherson wrote:
> In Michal's words...
> 
> kvm_recalculate_apic_map() creates the APIC map iterating over the list of
> vCPUs twice. First to find the max APIC ID and allocate a max-sized buffer,
> then again, calling kvm_recalculate_phys_map() for each vCPU. This opens a
> race window: value of max APIC ID can increase _after_ the buffer was
> allocated.
> 
> [...]

Applied 1 and 3 to kvm-x86 fixes (for 6.4), figuring out how to deal with the
dependencies get #2 into 6.5 is a future problem.

[1/3] KVM: x86: Bail from kvm_recalculate_phys_map() if x2APIC ID is out-of-bounds
      https://github.com/kvm-x86/linux/commit/4364b287982b
[2/3] ...
[3/3] KVM: selftests: Add test for race in kvm_recalculate_apic_map()
      https://github.com/kvm-x86/linux/commit/47d2804bc99c

--
https://github.com/kvm-x86/linux/tree/next
https://github.com/kvm-x86/linux/tree/fixes
