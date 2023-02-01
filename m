Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94B80686F20
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 20:45:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232129AbjBAToe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 14:44:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232094AbjBATo2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 14:44:28 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C877A7BE6F
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 11:44:27 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id p26so43432882ejx.13
        for <linux-kernel@vger.kernel.org>; Wed, 01 Feb 2023 11:44:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=grsecurity.net; s=grsec;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SwDZjz3R/xUrA9TRfuAPMHW2TTSVBtiLMqPJ61VaYAk=;
        b=RaxIe/1DMFnMimcNs7o86F/NH2QJAimOB2DuKkM8Rlp3M6jd8ZwN2g3mowK0Iz+Pqg
         bYC5ACF10ECbb0drnKJUP3eHL/RHsNmek0qc7K+fOTMcmg7/SFSpv2rJKMJEx3GdsV07
         rT9ycN16bqmTAY+53MXGTPGDbAMHlLjodfIG0FT7QxHQpmyYi2igCaIjsIehkX2f4CCl
         4qjCG11Xd6eatyCxEBzgvTJT5UBgwiW3lcZf46NgbwCU5LLkDkuZAUX0KTkWTcmt4Otn
         zwrh/hdBGwSjBdsza6opiEjbdZvqe+jcqP9ZK9WfeWU1nlFVG97Ldwg+a19E3iJeccod
         1Fmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SwDZjz3R/xUrA9TRfuAPMHW2TTSVBtiLMqPJ61VaYAk=;
        b=7NWDBTGQ14qzJKNgSw7EqvXEkp8Nw7KgG56QRPfTgFCuZj4FG37J6okB5tVZZH50l/
         7ElhovdD/p0XSMpmotBx1DqO5XaH8iJoSqiE87n6JJqaddvM3i7qvyv6SCRCIDN3x6Xj
         E9Wxel5HvAYPTPZZrgfC3AXKlEcIHMpN1AfA8cBIRxk2oMH1zn+DQzeHj4IEDjTcAwKK
         4unfPEkNG7qMnX5BB4y4g2aUAMJIXAYnPHevLEZimCx+yKHvY1NOIELixK3+CVu80W/7
         aMQ3SUpfmyRKuBRyldvGJTswX1PG8HnPg/DDktM97qlD+gORGAQ66nApJ7axe7agvdXz
         d0Aw==
X-Gm-Message-State: AO0yUKXWRrcgUcBAdzpLkjCclDb9PtlBEM3oxdo8lqS36Uja32kVw9BC
        J8m9SRvajz5l4eZveyc8Gwt4gQ==
X-Google-Smtp-Source: AK7set9WlNbz3bkf6/JRn2TnBfZf0ctA61mbKzUuRSsK5tJf/PCFFaf38agpEEofskCEfNIoGDqsOw==
X-Received: by 2002:a17:906:3a91:b0:88b:a30:25f0 with SMTP id y17-20020a1709063a9100b0088b0a3025f0mr3397279ejd.32.1675280666358;
        Wed, 01 Feb 2023 11:44:26 -0800 (PST)
Received: from nuc.fritz.box (p200300f6af111a00277482c051eca183.dip0.t-ipconnect.de. [2003:f6:af11:1a00:2774:82c0:51ec:a183])
        by smtp.gmail.com with ESMTPSA id c23-20020a170906155700b00869f2ca6a87sm10397579ejd.135.2023.02.01.11.44.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 11:44:26 -0800 (PST)
From:   Mathias Krause <minipli@grsecurity.net>
To:     kvm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Mathias Krause <minipli@grsecurity.net>
Subject: [PATCH v3 2/6] KVM: VMX: Avoid retpoline call for control register caused exits
Date:   Wed,  1 Feb 2023 20:46:00 +0100
Message-Id: <20230201194604.11135-3-minipli@grsecurity.net>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230201194604.11135-1-minipli@grsecurity.net>
References: <20230201194604.11135-1-minipli@grsecurity.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Complement commit 4289d2728664 ("KVM: retpolines: x86: eliminate
retpoline from vmx.c exit handlers") and avoid a retpoline call for
control register accesses as well.

This speeds up guests that make heavy use of it, like grsecurity
kernels toggling CR0.WP to implement kernel W^X.

Signed-off-by: Mathias Krause <minipli@grsecurity.net>
---

Meanwhile I got my hands on a AMD system and while doing a similar change
for SVM gives a small measurable win (1.1% faster for grsecurity guests),
it would provide nothing for other guests, as the change I was testing was
specifically targeting CR0 caused exits.

A more general approach would instead cover CR3 and, maybe, CR4 as well.
However, that would require a lot more exit code compares, likely
vanishing the gains in the general case. So this tweak is VMX only.

 arch/x86/kvm/vmx/vmx.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index c788aa382611..c8198c8a9b55 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -6538,6 +6538,8 @@ static int __vmx_handle_exit(struct kvm_vcpu *vcpu, fastpath_t exit_fastpath)
 		return handle_external_interrupt(vcpu);
 	else if (exit_reason.basic == EXIT_REASON_HLT)
 		return kvm_emulate_halt(vcpu);
+	else if (exit_reason.basic == EXIT_REASON_CR_ACCESS)
+		return handle_cr(vcpu);
 	else if (exit_reason.basic == EXIT_REASON_EPT_MISCONFIG)
 		return handle_ept_misconfig(vcpu);
 #endif
-- 
2.39.1

