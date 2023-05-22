Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C234470C311
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 18:13:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232416AbjEVQNY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 12:13:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbjEVQNX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 12:13:23 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D32DFB6
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 09:13:21 -0700 (PDT)
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com [209.85.218.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 66DC941B54
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 16:13:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1684771996;
        bh=125o6Ozycv6hr1/Xmw5xSDqLfuhzE74ZgK6ojkSnDGM=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type;
        b=UvFHhEyg4/XCKEDPG2ezX83cIz7czHqh9SspohVZqZbYBuGsZ/SH9PuTjpXHeFANR
         djJexfIHWINv9ZEFlMcKAO5yTS01fcUSKRDIXl8/Frr0iTpFmkq1mpan/S2KagaccX
         rJxGAsTyZZ7vZGl1gNPl4oUylsWFKpobH9EhhDZecb15vjjNEMfSdO9NakeJEUFuIt
         /SUvOWbcQqw9lfe//jLkHeMwNILbedPWGM8/wLeDLW03A/ESvZXV6FrcUrvorBFm3j
         183On2Jp6P2GwNzcB763nKLLJGyybzHjyItvshakYd3kI+iTyejLlTeEnGVuP7/J3f
         RH0ADQtC79lFw==
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-96f6e83685eso394272966b.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 09:13:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684771993; x=1687363993;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=125o6Ozycv6hr1/Xmw5xSDqLfuhzE74ZgK6ojkSnDGM=;
        b=gLEDX2Kx5g4AigNNVScToCTtyw4SpECniofyIU5ZXBeu13MDQ44mMI+gM0LSCFshZm
         zpBkcdQ2mZq5QZlOtOxpoTJy5JdCP8KZYJjZxcv4HE27vVs8yAB+s7CEG9YTnNS3oQQk
         o9kILpaIQkEzCGw34jBtjaa6T47JHXRWwlD9By2ppV4QgG5uqDwWc4QBk0J/rcBBHOYF
         WG+5lp0njWe+nJXX4mBuL7Jt8pQltp8b5kOyFDcT7CvCZcHZD1ly5rEgvPowQomfitnU
         Khop8jbeqpDWJJOHTUBuk0UL9m7UQh046aFgXI+VqcJRz7fgEqWwdS+rUqmUmoFBiJ+M
         jCgg==
X-Gm-Message-State: AC+VfDxxcWOpmtG/GK8lqXyfBZgUy28IpmYyACy81k/J/qiqAG2YX/+s
        +gT5CRNrb4NEO9nRPvkCBt8OEhGdUc5E/mc4meMg/yMOs4lvsKcC9NQymqf2jh+D/LT4SblHkan
        MdgFVGqooxXmnWsfYDi3dY9bDK3FwafqZqPPTP5pBsQ==
X-Received: by 2002:a17:907:1b24:b0:96a:7196:6e2b with SMTP id mp36-20020a1709071b2400b0096a71966e2bmr10253674ejc.14.1684771993792;
        Mon, 22 May 2023 09:13:13 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6JhXod18v9tx/IMD9T4ikV8Z2+zzpkEtqWBU2p4/F0aROYYH+dRjw49JIvOk5T3iEmefxvpg==
X-Received: by 2002:a17:907:1b24:b0:96a:7196:6e2b with SMTP id mp36-20020a1709071b2400b0096a71966e2bmr10253660ejc.14.1684771993509;
        Mon, 22 May 2023 09:13:13 -0700 (PDT)
Received: from amikhalitsyn.local (dslb-088-074-206-207.088.074.pools.vodafone-ip.de. [88.74.206.207])
        by smtp.gmail.com with ESMTPSA id a7-20020a17090682c700b009658475919csm3225039ejy.188.2023.05.22.09.13.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 09:13:12 -0700 (PDT)
From:   Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To:     pbonzini@redhat.com
Cc:     Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
        Sean Christopherson <seanjc@google.com>,
        =?UTF-8?q?St=C3=A9phane=20Graber?= <stgraber@ubuntu.com>,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH v2 0/2] KVM: SVM: small tweaks for sev_hardware_setup
Date:   Mon, 22 May 2023 18:12:46 +0200
Message-Id: <20230522161249.800829-1-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

KVM: SVM: enhance info printk's in SEV init

Let's print available ASID ranges for SEV/SEV-ES guests.
This information can be useful for system administrator
to debug if SEV/SEV-ES fails to enable.

There are a few reasons.
SEV:
- NPT is disabled (module parameter)
- CPU lacks some features (sev, decodeassists)
- Maximum SEV ASID is 0

SEV-ES:
- mmio_caching is disabled (module parameter)
- CPU lacks sev_es feature
- Minimum SEV ASID value is 1 (can be adjusted in BIOS/UEFI)

==
   
KVM: SVM: free sev_*asid_bitmap init if SEV init fails

If misc_cg_set_capacity() fails for some reason then we have
a memleak for sev_reclaim_asid_bitmap/sev_asid_bitmap. It's
not a case right now, because misc_cg_set_capacity() just can't
fail and check inside it is always successful.

But let's fix that for code consistency.

Cc: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Stéphane Graber <stgraber@ubuntu.com>
Cc: kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>

Alexander Mikhalitsyn (2):
  KVM: SVM: free sev_*asid_bitmap init if SEV init fails
  KVM: SVM: enhance info printk's in SEV init

 arch/x86/kvm/svm/sev.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

-- 
2.34.1

