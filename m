Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 121B863EF4A
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 12:18:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229975AbiLALSm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 06:18:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbiLALRq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 06:17:46 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 666D8B2B59
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 03:12:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669893123;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hSpcoi42VLcc/zf5D12uItqsofact4/D/isv3xkhS+A=;
        b=ItVOQPEhroBASnwyLGGi6B0Y/4A1h+XCp1DmF7rgkWAQT6fH9wTo/etc+4BlQL3osdx4Br
        AJ3OkyLegkxO40FVsr/Nihi24tOl+02NANItw+p5m7ladzi3KyeKjjxWSuqX3LJ7wkLJoA
        w4Mg9Vxy3RJFnJ+lwJen9gPI3X3IuqI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-597-xvcHUMAzN1udQhI-OAripQ-1; Thu, 01 Dec 2022 06:12:02 -0500
X-MC-Unique: xvcHUMAzN1udQhI-OAripQ-1
Received: by mail-wr1-f70.google.com with SMTP id e7-20020adf9bc7000000b00242121eebe2so311583wrc.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 03:12:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hSpcoi42VLcc/zf5D12uItqsofact4/D/isv3xkhS+A=;
        b=fS9SbMGsDpoFPcMAwT6lTgxsJaVWLBto5LgCfWC2AwKjPswrluwtvcOyHhQK7KDN5V
         WFuGITytQB8zj98SwTcr3LzhvzgpEMmWXj1N4e0VCbW2FC6UA6Xxo3bkfn34TL0Tx3ZH
         qJDSyEja/kwg2SsgEvuI8Tjo19ZEZG0Hajcf4yIaIEuLcxKxRyVFHBvdR9pGm4qZnFWH
         RAwxXzvsqLnOa136vKHl45f2vCFECW6oZwbJjeNWIkc4PsqmpdC8CI0jV2spmVR4ZNOu
         yNQqisiAvMfXu66hTluzqfWK1atTBR5BdCuHRvv3ADoWWTYUcL/web6kvWRVIcckTf27
         UwZw==
X-Gm-Message-State: ANoB5plCCVaOH5rS1DcxCTbU+LN+ipCRP42G8VGcMQ8Yd5lAQBbNf2Yu
        0GBulKfC0fOQMorN8pndZ+VISrc85ELlY3Qde9t7rCUtjZdMjdPeEZkjuOH3qEVHYV9ggY0HkVg
        77dvGYHbbTJWlp4CmCWdWDCn+
X-Received: by 2002:a5d:430e:0:b0:241:bfb6:c6da with SMTP id h14-20020a5d430e000000b00241bfb6c6damr29646834wrq.204.1669893121123;
        Thu, 01 Dec 2022 03:12:01 -0800 (PST)
X-Google-Smtp-Source: AA0mqf75D43ftxl96kEFfG/CqGh57ZhqsLRUYWismk0mz5HWJ61yRM5mhJrzWvYKcwtXRSFWy2vHrQ==
X-Received: by 2002:a5d:430e:0:b0:241:bfb6:c6da with SMTP id h14-20020a5d430e000000b00241bfb6c6damr29646818wrq.204.1669893120905;
        Thu, 01 Dec 2022 03:12:00 -0800 (PST)
Received: from [192.168.149.123] (58.254.164.109.static.wline.lns.sme.cust.swisscom.ch. [109.164.254.58])
        by smtp.gmail.com with ESMTPSA id p33-20020a05600c1da100b003d070e45574sm5237751wms.11.2022.12.01.03.11.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Dec 2022 03:12:00 -0800 (PST)
Message-ID: <2f13db3f-76bb-26c1-34e3-17c97106095c@redhat.com>
Date:   Thu, 1 Dec 2022 12:11:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 0/2] KVM: selftests: Fixes for access tracking perf test
Content-Language: en-US
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Matlack <dmatlack@google.com>
References: <20221129175300.4052283-1-seanjc@google.com>
From:   Emanuele Giuseppe Esposito <eesposit@redhat.com>
In-Reply-To: <20221129175300.4052283-1-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Am 29/11/2022 um 18:52 schrieb Sean Christopherson:
> Fix an inverted check in the access tracking perf test, and restore the
> assert that there aren't too many dangling idle pages when running the
> test on x86-64 bare metal.
> 
> Sean Christopherson (2):
>   KVM: selftests: Fix inverted "warning" in access tracking perf test
>   KVM: selftests: Restore assert for non-nested VMs in access tracking
>     test
> 
>  .../selftests/kvm/access_tracking_perf_test.c | 22 ++++++++++++-------
>  .../selftests/kvm/include/x86_64/processor.h  |  1 +
>  2 files changed, 15 insertions(+), 8 deletions(-)
> 
> 
> base-commit: 3e04435fe60590a1c79ec94d60e9897c3ff7d73b
> 

Makes sense, apologies for inverting the check.

Reviewed-by: Emanuele Giuseppe Esposito <eesposit@redhat.com>

