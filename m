Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D485A6A2255
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 20:28:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229584AbjBXT2i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 14:28:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjBXT2g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 14:28:36 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A87B241ED
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 11:28:35 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id p5-20020a056a0026c500b005cbeecd5c0dso52466pfw.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 11:28:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t9//kZJYNl4izvytHF7z7Dnucu90xh6NKNXZlIG10fQ=;
        b=N4uMwwIz4FqjJ9FM8/Jp2dnnYhdKN41elaX5w3ce3TcrdJG/W8EzXo3Yi6XXAApxat
         80fUNj04Wt0Mse771QGq815Duvq4PiqIinQw/9T4b5o/7Ab8ktWzMNfcd0O2NPP4q1EJ
         h5GkgGVtdvXGynoBCOACvKv3NzUhoCRL3v01WsRueoyIDKdEzrr+AYcnm7F0S7TWrn5d
         nqMdz+krg34hQNLWGqMUn5qdkBNA96qSIj4DHhKD8xVs+B70heBy/Tc4xGa6Vs694+ne
         sX+45w5v0A2FobeG0JGG06WeLYgYsoaAbeGOHTuZMyhtpbEJ68nOgL84y1o4B5I/UTLO
         86Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=t9//kZJYNl4izvytHF7z7Dnucu90xh6NKNXZlIG10fQ=;
        b=h2jpjmDBWNwVYtfQsk5SQtkx8/e/Vwieu07UMQ6GWYCebTPB4Oi3TPyTEa/HbT+jaz
         TuLe8mgTOEr2B25WsomLR/mEI2er9crJd0d0OX/gxlCyVq0Vi0pzbJ6Fp7dknE8OSH83
         namqlmDNKVeTVDNu0QeKvJkVXzMWx1n4IHcm6MwMQRzn6ievNhcqr9pUv2s6s64HB+9B
         6l90pa2xC3FHTiYbvmfTBWtTCVe1Q6OeBt3ei+tfwTIFLkdyzzkE63RzRJrETkPIXadF
         EXoe/2vIRgTLUQnJoUufHBDCdp3wBTx/K1Kg/db8tAm6qkt7fc6fPooz2BqKaXqbDnai
         Fi/A==
X-Gm-Message-State: AO0yUKXfX9zUNhoNHsGJH6aSKE+vOqujwTJxHCszwGjANgHT3blQBmC9
        UwYO1m/DFfCwFJ/zdt9ylP3fdo9iE70=
X-Google-Smtp-Source: AK7set8gQnDgd8AG5QXkVWmuSwCeOQmUnx+cCbmPxxPkcEWiuy9vkA0Ac3gAhRdY8KBGrIYdYWvh2l2spTc=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a02:241:b0:502:f8a4:86db with SMTP id
 bi1-20020a056a02024100b00502f8a486dbmr333807pgb.1.1677266914636; Fri, 24 Feb
 2023 11:28:34 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 24 Feb 2023 11:28:32 -0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.2.722.g9855ee24e9-goog
Message-ID: <20230224192832.1286267-1-seanjc@google.com>
Subject: [PATCH] KVM: MIPS: Make kvm_mips_callbacks const
From:   Sean Christopherson <seanjc@google.com>
To:     Huacai Chen <chenhuacai@kernel.org>,
        Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Cc:     linux-mips@vger.kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=" <philmd@linaro.org>,
        Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"
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

Make kvm_mips_callbacks fully const as it's now hardcoded to point at
kvm_vz_callbacks, the only remaining the set of callbacks.

Link: https://lore.kernel.org/all/beb697c2-dfad-780e-4638-76b229f28731@lina=
ro.org
Suggested-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/mips/include/asm/kvm_host.h | 2 +-
 arch/mips/kvm/vz.c               | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/include/asm/kvm_host.h b/arch/mips/include/asm/kvm_h=
ost.h
index 2803c9c21ef9..957121a495f0 100644
--- a/arch/mips/include/asm/kvm_host.h
+++ b/arch/mips/include/asm/kvm_host.h
@@ -757,7 +757,7 @@ struct kvm_mips_callbacks {
 	int (*vcpu_run)(struct kvm_vcpu *vcpu);
 	void (*vcpu_reenter)(struct kvm_vcpu *vcpu);
 };
-extern struct kvm_mips_callbacks *kvm_mips_callbacks;
+extern const struct kvm_mips_callbacks * const kvm_mips_callbacks;
 int kvm_mips_emulation_init(void);
=20
 /* Debug: dump vcpu state */
diff --git a/arch/mips/kvm/vz.c b/arch/mips/kvm/vz.c
index dafab003ea0d..3d21cbfa7443 100644
--- a/arch/mips/kvm/vz.c
+++ b/arch/mips/kvm/vz.c
@@ -3305,7 +3305,7 @@ static struct kvm_mips_callbacks kvm_vz_callbacks =3D=
 {
 };
=20
 /* FIXME: Get rid of the callbacks now that trap-and-emulate is gone. */
-struct kvm_mips_callbacks *kvm_mips_callbacks =3D &kvm_vz_callbacks;
+const struct kvm_mips_callbacks * const kvm_mips_callbacks =3D &kvm_vz_cal=
lbacks;
=20
 int kvm_mips_emulation_init(void)
 {

base-commit: 3ad108511e1c19ff3a3fcb9a39b3eaebf4dd4054
--=20
2.39.2.722.g9855ee24e9-goog

