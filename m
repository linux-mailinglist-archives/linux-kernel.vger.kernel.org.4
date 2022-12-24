Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5516D655992
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Dec 2022 10:13:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229473AbiLXJNP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Dec 2022 04:13:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiLXJNM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Dec 2022 04:13:12 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61B93624B
        for <linux-kernel@vger.kernel.org>; Sat, 24 Dec 2022 01:12:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671873144;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=K/8A/i9y6rIvKCnypgiTdopbEh62sIZ4224f2Kvswms=;
        b=fCEgmAYkIn2Rb15FU0PNY4V1KOchtXjhe3CNWAfJmkgZ81vBE68sTkCSdpRVyw0NQh6fum
        pGbhuRwMd7/C6XGkUDU66PBCpGt08YaDzY35Dl3OWY5YmCfVIhG/HsH2Kp7RvXOrY5YFEI
        9mdfdGB6KPbTHBMFKU4poz6d/V3nJl0=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-226-iCznOVSZMZuDwCN0IL5KwA-1; Sat, 24 Dec 2022 04:12:22 -0500
X-MC-Unique: iCznOVSZMZuDwCN0IL5KwA-1
Received: by mail-ej1-f69.google.com with SMTP id ga21-20020a1709070c1500b007c171be7cd7so4724014ejc.20
        for <linux-kernel@vger.kernel.org>; Sat, 24 Dec 2022 01:12:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K/8A/i9y6rIvKCnypgiTdopbEh62sIZ4224f2Kvswms=;
        b=RLmXcqEOST+zw45ZGYQiQO5Xpp0SoSFQGhgsWSYdI+y1y0WD6ERjapZFYnRDCYP76m
         RiHY07yqVU1SMI7087BGGsUlweNtY1K3oOHl/T/+X9WmXu14fKpt3E3c8M+BTfFCfUXB
         IUWgZ1feRmUdVwRdoJ/n7Em4MaXlMGLI7zkZp8JLtW5qanfu+2VQO66kQhaDRmnMCk9u
         RrPkGk4ory1KafVpmCAjWBcIgFD9aJ0bL7rG3DH/qvaLcQQvu8SvEUh2lUi1NBG7Ah9R
         s4/BsU5OkbK7Nc88JSv7YoYy+A9wxHTE9rwrXFeHvSkuDnrXHfQqN2YvYPj4rC04b+BS
         BUZQ==
X-Gm-Message-State: AFqh2kpaSNP1zK5LbQB6LtrngEnfQDWo2Txx+hqK49EQpzzmxESfkyfU
        CaQF91ilkYujFyBQzFAVboZBQFJt5C4TnjjHXRd3GHlMOfySCazfTgH+gdrT+V9UQheS3BVVDk4
        V4iSu0Z+ngBKp0bQogcXSNTgm
X-Received: by 2002:a17:906:4894:b0:7c0:beee:2f06 with SMTP id v20-20020a170906489400b007c0beee2f06mr10450196ejq.52.1671873141004;
        Sat, 24 Dec 2022 01:12:21 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvlm/vA6G01U45Ww3rRE/hpJxyrrrVFeI3NtGzIAEN1d8PbapEpyn4qgCdB7ow6B9vpaz9eng==
X-Received: by 2002:a17:906:4894:b0:7c0:beee:2f06 with SMTP id v20-20020a170906489400b007c0beee2f06mr10450165ejq.52.1671873140745;
        Sat, 24 Dec 2022 01:12:20 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:63a7:c72e:ea0e:6045? ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
        by smtp.googlemail.com with ESMTPSA id 10-20020a170906218a00b0073d796a1043sm2321829eju.123.2022.12.24.01.12.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Dec 2022 01:12:19 -0800 (PST)
Message-ID: <a03fb002-ef66-e9ea-7447-baf3d3aff1d9@redhat.com>
Date:   Sat, 24 Dec 2022 10:12:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH 06/14] KVM: selftests: Rename UNAME_M to ARCH_DIR, fill
 explicitly for x86
Content-Language: en-US
To:     Sean Christopherson <seanjc@google.com>,
        Marc Zyngier <maz@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Cc:     James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Oliver Upton <oliver.upton@linux.dev>,
        Tom Rix <trix@redhat.com>, kvm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        kvmarm@lists.cs.columbia.edu, linux-riscv@lists.infradead.org,
        llvm@lists.linux.dev, linux-kernel@vger.kernel.org,
        Ricardo Koller <ricarkol@google.com>,
        Aaron Lewis <aaronlewis@google.com>,
        Raghavendra Rao Ananta <rananta@google.com>
References: <20221213001653.3852042-1-seanjc@google.com>
 <20221213001653.3852042-7-seanjc@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20221213001653.3852042-7-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/13/22 01:16, Sean Christopherson wrote:
> -ifeq ($(ARCH),riscv)
> -	UNAME_M := riscv
> +ifeq ($(ARCH),x86)
> +	ARCH_DIR := x86_64
> +else ifeq ($(ARCH),arm64)
> +	ARCH_DIR := aarch64
> +else ifeq ($(ARCH),s390)
> +	ARCH_DIR := s390x
> +else ifeq ($(ARCH),riscv)
> +	ARCH_DIR := riscv
> +else
> +$(error Unknown architecture '$(ARCH)')
>   endif

$(error) would break compiling via tools/testing/selftests/Makefile, so 
I am squashing this:

diff --git a/tools/testing/selftests/kvm/Makefile 
b/tools/testing/selftests/kvm/Makefile
index d761a77c3a80..59f3eb53c932 100644
--- a/tools/testing/selftests/kvm/Makefile
+++ b/tools/testing/selftests/kvm/Makefile
@@ -13,10 +13,8 @@ else ifeq ($(ARCH),arm64)
  	ARCH_DIR := aarch64
  else ifeq ($(ARCH),s390)
  	ARCH_DIR := s390x
-else ifeq ($(ARCH),riscv)
-	ARCH_DIR := riscv
  else
-$(error Unknown architecture '$(ARCH)')
+	ARCH_DIR := $(ARCH)
  endif

  LIBKVM += lib/assert.c

Then the aarch64 and s390x directories can be renamed---x86 too, but the 
ifeq needs to stay (just changed to do x86_64->x86 instead of the other 
way round).

Paolo

