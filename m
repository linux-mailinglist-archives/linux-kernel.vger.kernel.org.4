Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6B3D670B18
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 23:03:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbjAQWC2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 17:02:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbjAQWAV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 17:00:21 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F0E747EEC
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 12:44:32 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id az20so59167748ejc.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 12:44:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=grsecurity.net; s=grsec;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b6W0pZJ6ERcXnvSOd8zNWpB3EIqXZWM69qX+jHbVTMc=;
        b=er4wt1Svi0Y85oW78y9sl9lSGk+Wf42JAlR88xK4S5USzWsvXKWg+Fkt2qwihepcm4
         SSexx+TegUzDFg7KORa6CLfiI/nc/t5TpZJ+a/G06Gl9t8THrqbYa8kwruCUceUwki2p
         8bA3INfGTW9/zzYJeMpNEnLNb2jPWEdV2QR3IaPeJVNe3qNQlHAeQ41fDTbw7NyS+Rjc
         1AN+PmALVahnZzyIIN/m6bGQRMOjpCRShMsGJC3udNo9D/pZ90Kszp04UaWK9bpYu6Um
         zA5W4+7k5B/6kAyo9t2FqdqFAEaV34LpHZ2jxixoZLi97s779ggPk9ios9hvPMdUQ+Qd
         nBSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b6W0pZJ6ERcXnvSOd8zNWpB3EIqXZWM69qX+jHbVTMc=;
        b=Y8SHCYKTxOP8AR52pIy3dtTjHcPEHLJL7jBWt1g+wZvLd1KK96JMDsBwkecgdYgEqY
         zbA3k2zb1eN781WP5et54x0oegxloId3XYJuAJQKafe6qD+V0uwu2LgJTWFNfudYldE4
         tNi7XEX3yWQ28fPCOAXYGQGU+pbMQBcM2yry12v3EYo03zoyL9lFfkxZzE/Bb7iDlxE4
         abDo0RHB2WmySv2kV9wmytoo7lC6wRch9t123gircqK2rkiPPCFBO2SXahh/jedsW1Ge
         kIophuKYL1qPLbRZcEVHkq5l3nmsS40vYy5zNvrlAt3VwdmUGimXrS+agVaXqqHf8rDy
         opsA==
X-Gm-Message-State: AFqh2ko4tinfUOopS3dMyyPZKnB2wD63cJGIuXgh4nl+pXw9eYMbLLiS
        7Jup+rY6qi/lL2XOPVxfVLUF2A==
X-Google-Smtp-Source: AMrXdXs2Fbfj0IqNlTd1tPNrNN+Q5dOJWuBjOk2uTxTLcCawwkLNAeevJOP2YGOCo7VqLGzs5KaNzw==
X-Received: by 2002:a17:907:8b08:b0:838:9b81:1c98 with SMTP id sz8-20020a1709078b0800b008389b811c98mr4478297ejc.1.1673988270861;
        Tue, 17 Jan 2023 12:44:30 -0800 (PST)
Received: from nuc.fritz.box (p200300f6af098f00245ad18781b5e181.dip0.t-ipconnect.de. [2003:f6:af09:8f00:245a:d187:81b5:e181])
        by smtp.gmail.com with ESMTPSA id k2-20020a170906970200b0073dbaeb50f6sm13477051ejx.169.2023.01.17.12.44.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 12:44:30 -0800 (PST)
From:   Mathias Krause <minipli@grsecurity.net>
To:     kvm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Mathias Krause <minipli@grsecurity.net>
Subject: [PATCH 2/3] KVM: VMX: avoid retpoline call for control register caused exits
Date:   Tue, 17 Jan 2023 21:45:55 +0100
Message-Id: <20230117204556.16217-3-minipli@grsecurity.net>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230117204556.16217-1-minipli@grsecurity.net>
References: <20230117204556.16217-1-minipli@grsecurity.net>
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
SVM may gain from a similar change as well, however, I've no AMD box to
test this on.

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
2.39.0

