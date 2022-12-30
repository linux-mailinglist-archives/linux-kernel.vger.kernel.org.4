Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 851FD6559A0
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Dec 2022 10:24:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229445AbiLXJYw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Dec 2022 04:24:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiLXJYt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Dec 2022 04:24:49 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D9CCDECB
        for <linux-kernel@vger.kernel.org>; Sat, 24 Dec 2022 01:24:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671873842;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cQUoO4G6sdzLrmUADt2hv9AJA1j16aHhp8BOh9XyH3Y=;
        b=CZBoYWAy6Z5RBAWnvdnyWFuYL2HcefczTyu05FYC19uc2jlNr+paRq58bkJuJaAuvF2e3I
        R1reaewZCxioBnU2dHsH8dS6QYUSFl4Jk9864ePBdKrNoZMdYGmMfyk71g2byGORYJB+mc
        tvYYGTM3jXQHulCMLta+IdQDIItMIXA=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-20-rIBFpuLCM1iDY5nW2SvEJA-1; Sat, 24 Dec 2022 04:24:01 -0500
X-MC-Unique: rIBFpuLCM1iDY5nW2SvEJA-1
Received: by mail-ed1-f70.google.com with SMTP id y2-20020a056402440200b004779fcdf1baso4916300eda.4
        for <linux-kernel@vger.kernel.org>; Sat, 24 Dec 2022 01:24:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cQUoO4G6sdzLrmUADt2hv9AJA1j16aHhp8BOh9XyH3Y=;
        b=4qLBJ5mUaEh6VF5A/JtHivXcrkATU2yB+HZgNV6buZPiR5j25efUhQVICBMFN2jt63
         lbHRJWHzz2WZLkTk3dH8L6hmSCBNEmfArPKE4banETLcU7E43U184sKfHxuYVPfbQS6X
         rYyuWSfzAm6xF4LLOLvcLD+kRg7DEgN9pAtPymFNbzAJAhinNtOLAGmpyEe48zLiWfz0
         8BDuwtWrymhPtgtIN3RZ6vgQST4XqgSb0n9NETUStaY2eygBtnYLO11YUF6r9u7jxZGg
         bvlKjITOR5tPUnmFBLvieGS6fNCIg3Vkft1/G6krOZucoU70QPfeO9apjK5fnL12oUUB
         YrRw==
X-Gm-Message-State: AFqh2kou3RFkNkK1/i6PCBTyUXO3T80MeQcmKiFpiuIwKWSsYg7JWxXY
        x828SB2Trq9DZOLaICjUtuXkMs0b15MjsDR60Ki2NjsSVrtjx+mXJ7Xius8LdGR2hP6RLFLCgXi
        XgoCcQCORxci6SKPi5qlOHpwK
X-Received: by 2002:a17:907:c084:b0:7c1:22a6:818f with SMTP id st4-20020a170907c08400b007c122a6818fmr9962698ejc.25.1671873840059;
        Sat, 24 Dec 2022 01:24:00 -0800 (PST)
X-Google-Smtp-Source: AMrXdXu5yag+Wn0Qcys8xdIlgtscsBUCyajRo/QuR9Np12zFtuRKH0vsauC+7pwndJ75MH59prtGFQ==
X-Received: by 2002:a17:907:c084:b0:7c1:22a6:818f with SMTP id st4-20020a170907c08400b007c122a6818fmr9962684ejc.25.1671873839849;
        Sat, 24 Dec 2022 01:23:59 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:63a7:c72e:ea0e:6045? ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
        by smtp.googlemail.com with ESMTPSA id u18-20020a1709061db200b007c073be0127sm2305389ejh.202.2022.12.24.01.23.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Dec 2022 01:23:59 -0800 (PST)
Message-ID: <363f4713-6105-82d1-351e-423d07470cdf@redhat.com>
Date:   Sat, 24 Dec 2022 10:23:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH 12/14] KVM: selftests: Use wildcards to find library
 source files
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
 <20221213001653.3852042-13-seanjc@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20221213001653.3852042-13-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/13/22 01:16, Sean Christopherson wrote:
> Use $(wildcard ...) to find the library source files instead of manually
> defining the inputs, which is a maintenance burden and error prone.

No, please don't.  This leads to weird errors, for example when "git 
checkout" is interrupted with ^C.   I have applied patches 1-11.

Paolo

