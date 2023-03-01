Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E07A86A69AC
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 10:20:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbjCAJUe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 04:20:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbjCAJUc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 04:20:32 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3D882E827
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 01:20:30 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id m14-20020a7bce0e000000b003e00c739ce4so7392088wmc.5
        for <linux-kernel@vger.kernel.org>; Wed, 01 Mar 2023 01:20:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677662429;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ksdV4yO+/ccC87yK6osO5dTNtiRfrlYmNqnr+scBfFo=;
        b=R4M5oYOcaqThwAC3+Mi3wP1Z5kZ5o+33EOc8N+bdvkNjAjTjnuZfS9F3eLsUisC1Hm
         hC0r5T4FZaQ+H3XBnz+SX24rnbELRy8DFVpt7cdQzKzTqmPM5Azz5yO3OdF7jxeYPuyK
         Ycszux1MDO7EiNUxaLiES0djq0YU/7XugDADt+Fo6WOpJ44a8ugyFLWilbUHDD34C21n
         rilDqiCPmzSXUYEXP3N63l6k9+eqMPQPaXEIgj7J/hTQkewr91AEHeB4hmj6cTyb8XZT
         53be0KEbxw9PrPU+Flik8vQJhYEDs8Od5R7d4po8qokM4CtgV8HOHI3/7CtYXTL1x/z5
         qYVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677662429;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ksdV4yO+/ccC87yK6osO5dTNtiRfrlYmNqnr+scBfFo=;
        b=A+V8cdx+LdqC7UbtJWghDkRxhpB5ceYv+gkfZ26C2ElkhGiMfrMXPFlAmbnM8B7nIi
         DOhd6AHQ00euZas+Dr89XVP5XXwio/yhAacZIQW/rT1cdWCV6te0/3VHbSv43Iy01TT/
         mPAfVz5Yk8Vyv/JpgL9UcqvcHoWQ4AWuX3wwA0zXsH10pJOyLbwlHV5LAh5j0n2D3G3Y
         o0xejs6gqNSwC39gWF6ehesi3ImtRdntz1I0yjkd3U70tCKMScu/VL95W6B2p3hfpsCu
         r4oBhA0h0H8LRkAwf89/nvAH6ZLuWQeUFwGwUAHN5TzbQCUqXmO7XvohgyzPElctXOmb
         n/JQ==
X-Gm-Message-State: AO0yUKVDN5zL6YinqBkPc7q9EA87tMggLkQNmbSCus3jR1yv0/Vi1M9S
        TFYLgpN9UeZN4vDlNJDqC6BozA==
X-Google-Smtp-Source: AK7set90Ie+ijBFqKBrmMowRejIpuYczAUvaNPGHR/JgrcHLFFLzdHVU7dNTDOpzYjquvTEFuwnCFg==
X-Received: by 2002:a05:600c:714:b0:3eb:29fe:70df with SMTP id i20-20020a05600c071400b003eb29fe70dfmr4155693wmn.35.1677662429259;
        Wed, 01 Mar 2023 01:20:29 -0800 (PST)
Received: from myrica (054592b0.skybroadband.com. [5.69.146.176])
        by smtp.gmail.com with ESMTPSA id y2-20020a1c4b02000000b003e203681b26sm14703927wma.29.2023.03.01.01.20.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Mar 2023 01:20:28 -0800 (PST)
Date:   Wed, 1 Mar 2023 09:20:29 +0000
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Itaru Kitayama <itaru.kitayama@gmail.com>
Cc:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, kvmarm@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Andrew Jones <andrew.jones@linux.dev>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Chao Peng <chao.p.peng@linux.intel.com>,
        Christoffer Dall <christoffer.dall@arm.com>,
        Fuad Tabba <tabba@google.com>,
        James Morse <james.morse@arm.com>,
        Joey Gouly <Joey.Gouly@arm.com>, Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Oliver Upton <oliver.upton@linux.dev>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Quentin Perret <qperret@google.com>,
        Sean Christopherson <seanjc@google.com>,
        Steven Price <steven.price@arm.com>,
        Thomas Huth <thuth@redhat.com>, Will Deacon <will@kernel.org>,
        Zenghui Yu <yuzenghui@huawei.com>, kvmarm@lists.cs.columbia.edu
Subject: Re: [RFC] Support for Arm CCA VMs on Linux
Message-ID: <Y/8Y3WLmiw6+Z5AS@myrica>
References: <20230127112248.136810-1-suzuki.poulose@arm.com>
 <Y9PtKJ3Wicc19JF1@myrica>
 <CANW9uyud8RTkqgiL=64wV712QMxtAyubqeyCJ0vpcADJ42VqJA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANW9uyud8RTkqgiL=64wV712QMxtAyubqeyCJ0vpcADJ42VqJA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Itaru,

On Wed, Mar 01, 2023 at 08:35:05AM +0900, Itaru Kitayama wrote:
> Hi Jean,
> I've tried your series in Real on CCA Host, but the KVM arch init
> emits an Invalid argument error and terminates.

Do you know which call returns this error?  Normally the RMEGuest support
should print more detailed errors. Are you able to launch normal guests
(without the rme-guest object and confidential-guest-support machine
parameter)?  Could you give the complete QEMU command-line?

> I configure it with the aarch64-softmmu target only and built, any
> other steps I should worry?

No, that should be enough

Thanks,
Jean
