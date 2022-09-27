Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B918E5EC5BF
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 16:18:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231346AbiI0OSS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 10:18:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbiI0OSO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 10:18:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26EB6AF4A0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 07:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664288292;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kJk1wmD2lfaEn2Mk6VfakiGnm87tuqRQXHPFOO58ZMg=;
        b=X7voHBBYen4P/xvxeUajqThubhCn4j40WAS6+yT2pb4bbgb1zBs8/gNy/un21DvdRSLko/
        QOfwiDEvatBJM9wGIHvY/T7cp6DL1D6hF0QTpRf/0NR4TjXXdslvZL9jX1ajmuF0fvsYDU
        TAhKmEQ+DE6lA6UplKI6DSippNoEM7o=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-375-b5IxvjmgPs20MXSJisGj5g-1; Tue, 27 Sep 2022 10:18:04 -0400
X-MC-Unique: b5IxvjmgPs20MXSJisGj5g-1
Received: by mail-ej1-f69.google.com with SMTP id xj11-20020a170906db0b00b0077b6ecb23fcso3902636ejb.5
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 07:18:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=kJk1wmD2lfaEn2Mk6VfakiGnm87tuqRQXHPFOO58ZMg=;
        b=pj2XU6jrbqA7AW1rv/pXShI6Nr7UMdfwZYYVO102woqVvF+mwik8BNCOQdBG82HUdy
         nZNLT5wXGnpnBRbnIWBYF0T+N+XBXC8MfW9cbSjuLJO8NwVAQSu7QwJ5BXjddmz3gwXG
         kQKIjFUK88iP5WgwVgTmcncfZtzsDQrnCj+Nho1Yo02XbjVONLeDlnGZHmoxfUzSL2vH
         mBU7/9izvQhkFyTOxz3o7PGFFQbUy6oNRrSW7nfAJybrjt+QxBH1upuFIUW7qsuXOgVh
         xwwmn14nB88Yvi3S4Psf31oKSq4Prc6p/1VZNzAaxHCBJN+NWp4FWKFDC8Ec0LD5vXMT
         T6/g==
X-Gm-Message-State: ACrzQf0RvugMvdvNf1RP85dEesvyb8fS0tKjrwqCu3QyYHpCneMGdDGA
        4qEXE9B6Sl0p13CZCOTfHWEok/xrOG4ZsF38fRaaol/ch1zsxeuSbwC+/UZdmVzE2TVP6NzSruU
        QpB3uuu8rBXZdIHWX4E0F1mSh
X-Received: by 2002:a05:6402:944:b0:457:6680:a5c0 with SMTP id h4-20020a056402094400b004576680a5c0mr7681373edz.428.1664288283062;
        Tue, 27 Sep 2022 07:18:03 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7ufqXL0VVbBRPd0J0q1sJ7IzkfuTNNTgQ64LWvaA7gx28QGIiw1DadPciAolZpNmZ8U/+v8w==
X-Received: by 2002:a05:6402:944:b0:457:6680:a5c0 with SMTP id h4-20020a056402094400b004576680a5c0mr7681360edz.428.1664288282884;
        Tue, 27 Sep 2022 07:18:02 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:1c09:f536:3de6:228c? ([2001:b07:6468:f312:1c09:f536:3de6:228c])
        by smtp.googlemail.com with ESMTPSA id a16-20020a50c310000000b00452e7ae2214sm1371480edb.42.2022.09.27.07.18.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Sep 2022 07:18:02 -0700 (PDT)
Message-ID: <82711e21-15ce-8361-31b8-bfb1b8017698@redhat.com>
Date:   Tue, 27 Sep 2022 16:18:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [RESEND PATCH v2] kvm: mmu: fix typos in struct kvm_arch
Content-Language: en-US
To:     Hao Peng <flyingpenghao@gmail.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <CAPm50aL=0smbohhjAcK=ciUwcQJ=uAQP1xNQi52YsE7U8NFpEw@mail.gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <CAPm50aL=0smbohhjAcK=ciUwcQJ=uAQP1xNQi52YsE7U8NFpEw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/23/22 17:05, Hao Peng wrote:
> From: Peng Hao<flyingpeng@tencent.com>
> 
> No 'kvmp_mmu_pages', it should be 'kvm_mmu_page'. And
> struct kvm_mmu_pages and struct kvm_mmu_page are different structures,
> here should be kvm_mmu_page.
> kvm_mmu_pages is defined in arch/x86/kvm/mmu/mmu.c.
> 
> Suggested-by: David Matlack<dmatlack@google.com>
> Signed-off-by: Peng Hao<flyingpeng@tencent.com>
> Reviewed-by: David Matlack<dmatlack@google.com>
> ---
> arch/x86/include/asm/kvm_host.h | 12 ++++++------
> 1 file changed, 6 insertions(+), 6 deletions(-)

Queued, but the patch was broken (it had spaces instead of tabs for 
indentation).

Paolo

