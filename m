Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFC466CD8C4
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 13:52:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbjC2LwR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 07:52:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjC2LwP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 07:52:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F976180
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 04:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680090687;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hsG/IsiG3YfNPPudBRiL48bBj3TG6pU/JFoXkZ4JFlI=;
        b=V5s16p5omT819YV7VbzbUvlIvc6SgDRhzVLTcwVYUcOPSl4tEZtMh5dJcbww6H4IAwPjpq
        NoxGbKhp+r5WpllmWMl4oFNDWXm0olLFQcu3+2hPsStzhcEbpkOIY+Z7izQm3lmMesMvYf
        HDh3FSB4bMekqb/VAJou3a1ftRxd8ZM=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-308-H2wzhA86NeyKgJ6Y5x6M1Q-1; Wed, 29 Mar 2023 07:51:25 -0400
X-MC-Unique: H2wzhA86NeyKgJ6Y5x6M1Q-1
Received: by mail-ed1-f71.google.com with SMTP id j21-20020a508a95000000b004fd82403c91so21833548edj.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 04:51:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680090684; x=1682682684;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hsG/IsiG3YfNPPudBRiL48bBj3TG6pU/JFoXkZ4JFlI=;
        b=Z7W6rgHKDsICMQ71ZUbupmI4VmaNIryzbhotbzVlRxi43JIb4Wk86N1CGNGsi2kL3v
         nBHBCREyWt4MQ3aL2V3fjxrPSFnAZFW+eJr3Cj2MBq2hTIGAzTz89H5SAnXsiATqNVbb
         jDepcdKBh63obzqwboKXR1ryM+AM/3vyQGxVdGJAx3Tt64N4F9Nw2k5chfhOk0WheoKp
         CQba7XYOzky9Fu2fiF1xmCMsOXG+24dZBAvbYMR2lPUgPE9nqR/l8P0pZh6paF02sBqF
         xdDj8R9K8GSm+itFrh6xMD8LNga7xgYGd8lWrEiNp651TQP9cwEZY1VDSyzTvvYD/c6a
         OsXQ==
X-Gm-Message-State: AAQBX9dXNvujlkrorJjr+d0HxZ0xSrdFn6aigrcLXlcuUijNt2mKqcMb
        be7bx/INJHBjMk3dQCn62bO3Q4QufCccafCBf59SR/BbNSRbBQJhCpxpmcHu36WiNP2+eg/As1E
        Dyk/TBEtOIFP59kGNE60ebGb5
X-Received: by 2002:a17:907:1628:b0:88f:8a5:b4cd with SMTP id hb40-20020a170907162800b0088f08a5b4cdmr26306271ejc.1.1680090684788;
        Wed, 29 Mar 2023 04:51:24 -0700 (PDT)
X-Google-Smtp-Source: AKy350Y+Qr69YtNXE48+iPelapxA7fisyf2qbyc27fubwM9iEFn6cFwHXzyyCcqd+msXRQS/S5HrGQ==
X-Received: by 2002:a17:907:1628:b0:88f:8a5:b4cd with SMTP id hb40-20020a170907162800b0088f08a5b4cdmr26306251ejc.1.1680090684535;
        Wed, 29 Mar 2023 04:51:24 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:9af8:e5f5:7516:fa89? ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
        by smtp.googlemail.com with ESMTPSA id f3-20020a17090624c300b0092a59ee224csm16331051ejb.185.2023.03.29.04.51.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Mar 2023 04:51:24 -0700 (PDT)
Message-ID: <75ae80f7-b86e-3380-b3da-0e2201df4b7f@redhat.com>
Date:   Wed, 29 Mar 2023 13:51:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Content-Language: en-US
To:     Yan Zhao <yan.y.zhao@intel.com>,
        Sean Christopherson <seanjc@google.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230313111022.13793-1-yan.y.zhao@intel.com>
 <ZB4uoe9WBzhG9ddU@google.com> <ZCOaHWE6aS0vjvya@yzhao56-desk.sh.intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v3] KVM: VMX: fix lockdep warning on posted intr wakeup
In-Reply-To: <ZCOaHWE6aS0vjvya@yzhao56-desk.sh.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/29/23 03:53, Yan Zhao wrote:
> Yes, there's no actual deadlock currently.
> 
> But without fixing this issue, debug_locks will be set to false along
> with below messages printed. Then lockdep will be turned off and any
> other lock detections like lockdep_assert_held()... will not print
> warning even when it's obviously violated.

Can you use lockdep subclasses, giving 0 to the sched_in path and 1 to 
the sched_out path?

Paolo

