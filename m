Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73FC95EBBD9
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 09:46:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230457AbiI0HqX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 03:46:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230469AbiI0HqS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 03:46:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 288F05C9DC
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 00:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664264774;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RtXJbKHZYC18WG/J6u7uWLr7/k/wdJ+NHytl4cI7JSI=;
        b=LGZJPQlKMm8PLVW1tkHX7HSkDJgFLX/6DXqbRqnXXeJoLrza4cc7a0CBiyt5+K//9FzieT
        C1WK93elw7C5VKvet+RbPAoPKrxIl7dPZGNwG4nmBYcXOGSXTq1MDSuQFmmdgWA7ipQLLd
        rw2Frc+bfhWyeaJZhVVBO9PO6CUZkCI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-584-lCj0akHfPwm2CoLPVr-TYQ-1; Tue, 27 Sep 2022 03:46:10 -0400
X-MC-Unique: lCj0akHfPwm2CoLPVr-TYQ-1
Received: by mail-wr1-f71.google.com with SMTP id a13-20020adfbc4d000000b00228631ddfafso1863884wrh.9
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 00:46:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=RtXJbKHZYC18WG/J6u7uWLr7/k/wdJ+NHytl4cI7JSI=;
        b=FYoAMqaCCgIDd4ZOiDqejvh94oPT9H4h0QFGfCHpEb5GrDkDt9w6UsXel6g25U5hij
         C7ZP7/Xewgfh74VeEUfI/JdI8BVSwhtFpYhuX8rjcxfDGCsiKzkdk6sdo94t8VzWxpck
         76ruzjQtdLexJx/y3nl+P88QtlJpkM6A4zJrVP8j+GY5yaw5HzFE+US9vqit3DXsXjaJ
         eHWYzDjBFi9Jw1q7w4md+YIPhVeNw/qcBK7dhxh+TNZYHQSj0zQDYaVvPTWtQpwvIDEP
         ZBqYsl9ecsN5ud38h26Upv9S7j0xHm78hvbz0yDYvmAbY5gUQ2sYIKsBWToUGq5XoPT3
         kJFw==
X-Gm-Message-State: ACrzQf09cux+fSmybp8zkmcQJZGPv8EjplwcEG5SW0JBbnOBSBpTbJ5t
        KYZXM9gKYzQau8caVXwuc5KHZpDj3VxGlQge62yRY+1BJhwm3byrO8ZlYCJw0WkcL6q/fK6Agy3
        2WygkpFDGX7kQ3b6sfxB5+rjn
X-Received: by 2002:adf:d1c6:0:b0:228:dff6:77b8 with SMTP id b6-20020adfd1c6000000b00228dff677b8mr16340439wrd.115.1664264769540;
        Tue, 27 Sep 2022 00:46:09 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4bunfoy5734OJTbsfZfTpHy4tlL9ih2klsLFCB+H1JNbn0jpcRz4odX2r5yC/NMRLe4/9cMQ==
X-Received: by 2002:adf:d1c6:0:b0:228:dff6:77b8 with SMTP id b6-20020adfd1c6000000b00228dff677b8mr16340419wrd.115.1664264769304;
        Tue, 27 Sep 2022 00:46:09 -0700 (PDT)
Received: from ?IPV6:2003:cb:c705:ff00:9ec2:6ff6:11a1:3e80? (p200300cbc705ff009ec26ff611a13e80.dip0.t-ipconnect.de. [2003:cb:c705:ff00:9ec2:6ff6:11a1:3e80])
        by smtp.gmail.com with ESMTPSA id bg42-20020a05600c3caa00b003a5f4fccd4asm14115656wmb.35.2022.09.27.00.46.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Sep 2022 00:46:08 -0700 (PDT)
Message-ID: <cde8be9d-64c0-80e5-7663-4302d075dcbc@redhat.com>
Date:   Tue, 27 Sep 2022 09:46:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [RFC PATCH 9/9] kvm_main.c: handle atomic memslot update
Content-Language: en-US
To:     Emanuele Giuseppe Esposito <eesposit@redhat.com>,
        kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Maxim Levitsky <mlevitsk@redhat.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
References: <20220909104506.738478-1-eesposit@redhat.com>
 <20220909104506.738478-10-eesposit@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220909104506.738478-10-eesposit@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09.09.22 12:45, Emanuele Giuseppe Esposito wrote:
> When kvm_vm_ioctl_set_memory_region_list() is invoked, we need
> to make sure that all memslots are updated in the inactive list
> and then swap (preferreably only once) the lists, so that all
> changes are visible immediately.
> 
> The only issue is that DELETE and MOVE need to perform 2 swaps:
> firstly replace old memslot with invalid, and then remove invalid.
> 

I'm curious, how would a resize (grow/shrink) or a split be handled?

-- 
Thanks,

David / dhildenb

