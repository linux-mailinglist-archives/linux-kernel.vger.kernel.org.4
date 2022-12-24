Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D4DC65599C
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Dec 2022 10:19:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230442AbiLXJTi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Dec 2022 04:19:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiLXJTg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Dec 2022 04:19:36 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F31FADEF7
        for <linux-kernel@vger.kernel.org>; Sat, 24 Dec 2022 01:18:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671873528;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QxublDXwR8D5DtOHl7/e/B0PH3ei1t0qPkoztnwEfr0=;
        b=YckDRl4pP5qwwXpncp/C5tiOFvGB5uIAqZ+vmAgd90CBt/Y6pOD96/XhivMRpckjpFO/Bm
        voTLHnv9RCbYMh69oDY6Q9SJZdDA7r3FSojFUHSndV9PBUFffwLtcqGOJI/rUBtAO6gJLY
        24MFjN/dbUIgs43r1bsZAj/GOTWpdRY=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-392-R7vz1YLbP-61hN5nFDdP9g-1; Sat, 24 Dec 2022 04:18:38 -0500
X-MC-Unique: R7vz1YLbP-61hN5nFDdP9g-1
Received: by mail-ed1-f70.google.com with SMTP id c12-20020a05640227cc00b00482f50927bcso991886ede.6
        for <linux-kernel@vger.kernel.org>; Sat, 24 Dec 2022 01:18:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QxublDXwR8D5DtOHl7/e/B0PH3ei1t0qPkoztnwEfr0=;
        b=0W0NvOW7UstMzArthWWUIGsqutEGGLm6xMdjECY9HPk5IG2D3LADZPjdW3or8foUXs
         Bx1oY3iUvbci6cJkDZbLn0irRGWON/MJFS/QKQ3iMlHF9tUUdMh70vSQvM1QzygBM38y
         8SxSC4JItvJwbyrflyyvVsxymMb4Ji+X3XrNkpUDz98jaPnFpoZKJL/6qiAyarM4e5xA
         +5tQyW60RpdMgPHLZ+UVNnAKdhIfPsPpdVqHIjYzOuigEL4MguPXoBLBwhphgoiO75NF
         ep/am3TaHoqV6jLM/1mCorQ58pS01ohs/Iom2MzzFP6y99szvKtjO1rm/BFF2z2H35JE
         v9xg==
X-Gm-Message-State: AFqh2kojwtxishqB2JP3BiFkk9mTUC/Q9kh+LoWcYwTyGqJphDJEfuEP
        m4GSNRk16FSf3s1UhrO03/rdG8ou/wMYheiJEWlAALRZUv5pLau9O4rCuCYgtf76Q62Uv01TIUI
        WYPRBg1En6ucTJJNLK3CIxqIT
X-Received: by 2002:a17:907:20b0:b0:7d3:8159:f361 with SMTP id pw16-20020a17090720b000b007d38159f361mr10353250ejb.36.1671873517897;
        Sat, 24 Dec 2022 01:18:37 -0800 (PST)
X-Google-Smtp-Source: AMrXdXuzaX4Vch7tXx6y3KWiTjg6uUOEDxqKJ4lnD0J2K3STImlt9Y+l7L7jqIYGtkrdkVnkKuq68w==
X-Received: by 2002:a17:907:20b0:b0:7d3:8159:f361 with SMTP id pw16-20020a17090720b000b007d38159f361mr10353228ejb.36.1671873517691;
        Sat, 24 Dec 2022 01:18:37 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:63a7:c72e:ea0e:6045? ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
        by smtp.googlemail.com with ESMTPSA id kx20-20020a170907775400b0078d3f96d293sm2338931ejc.30.2022.12.24.01.18.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Dec 2022 01:18:37 -0800 (PST)
Message-ID: <4f789996-28aa-1d9c-f918-03de663d28b8@redhat.com>
Date:   Sat, 24 Dec 2022 10:18:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH 10/14] KVM: selftests: Include lib.mk before consuming
 $(CC)
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
 <20221213001653.3852042-11-seanjc@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20221213001653.3852042-11-seanjc@google.com>
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
> Include lib.mk before consuming $(CC) and document that lib.mk overwrites
> $(CC) unless make was invoked with -e or $(CC) was specified after make
> (which apparently makes the environment override the Makefile?!?!).

Yes, it does.  In projects that don't use configure or similar, you 
might have seen

CFLAGS = -O2 -g

to be overridden with "make CFLAGS=-g" if optimization is undesirable.

Paolo

> Including lib.mk after using it for probing, e.g. for -no-pie, can lead
> to weirdness.

