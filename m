Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74F2361FB1F
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 18:21:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232344AbiKGRVh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 12:21:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231767AbiKGRVg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 12:21:36 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A474814D16
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 09:20:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667841635;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=W/RetZ1GSClvSmEVsreiUXtKscEDL2whf8S9HCXvlE4=;
        b=Lclm74Dt8BsnaS7xgKQfnrqCa4M8O4jon1qdBe5MRKBG4x9u8A2eBjGOof9I5usP4w5ZEq
        4LBMhmHnpTzVQVc2tTUdoeeaPVy0x0ktujsgvXysiBtOPUQ4gA2B19R3FwCXtVwOZ9DXOm
        ZMKhOTC8mizGoECjogRI8hNK2sF1Gbg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-631-sDBypvV-OJSAZ5jVyifhBg-1; Mon, 07 Nov 2022 12:20:29 -0500
X-MC-Unique: sDBypvV-OJSAZ5jVyifhBg-1
Received: by mail-wm1-f71.google.com with SMTP id u9-20020a05600c00c900b003cfb12839d6so589454wmm.5
        for <linux-kernel@vger.kernel.org>; Mon, 07 Nov 2022 09:20:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W/RetZ1GSClvSmEVsreiUXtKscEDL2whf8S9HCXvlE4=;
        b=sIU2lzGPyAqGAfangaGwAETbc8yx7nPeT9Br1K/x5F+PLzschxbgkNpIqXDcq5/lWU
         3j9h5TlOUMcY95z8WOewe5rHgbAGqDMN1lbrBtzsC40WbWGmdmg0lbOFu6z8elytSD7l
         RJAmE9o42Akp+V+UEifktIiF45EJj7GsC+R6+4JeE5X3AEZ7bZR/4CyAYI4NUpsYnDGj
         OitVcHzkDjwFtujn5pxRrd+rXI+FgZ7kCl+m0lTCWk4+uJdwWuweUReUZsWtSkwsjzGG
         rLjDx9vpWrMTjM4RlvuyohBwZ3LFruF8zb7/bA7b4gRpVkLWBTogQarM16/QD5z3FoIZ
         mTsw==
X-Gm-Message-State: ACrzQf2fut4mskPKZbN6N9egp2Ucak718wT8bwYYgYUQmhpUIV5bDmMi
        7DgI/pwP/hbtmFeZ1Uprt0YeIuRyDZAw2rUwzgJWjKbdG+Gl3vJsx4SKxp9yMWsOAeocxH1CEmB
        kXi/t3CzIK11C3ZPc+Kzqz7TJ
X-Received: by 2002:a5d:6385:0:b0:22e:3498:9adb with SMTP id p5-20020a5d6385000000b0022e34989adbmr640374wru.335.1667841627276;
        Mon, 07 Nov 2022 09:20:27 -0800 (PST)
X-Google-Smtp-Source: AMsMyM7PifGCw22NSPEedADMFQmmHbUq0+zu0QT1d0ArAWKERGor4bClObxFnriwdXEkbdF9zYKBaQ==
X-Received: by 2002:a5d:6385:0:b0:22e:3498:9adb with SMTP id p5-20020a5d6385000000b0022e34989adbmr640372wru.335.1667841627053;
        Mon, 07 Nov 2022 09:20:27 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:9af8:e5f5:7516:fa89? ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
        by smtp.googlemail.com with ESMTPSA id s25-20020adfa299000000b00236b2804d79sm8294132wra.2.2022.11.07.09.20.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Nov 2022 09:20:25 -0800 (PST)
Message-ID: <c8f036f4-6ab1-efbe-dd60-b934c21cb21d@redhat.com>
Date:   Mon, 7 Nov 2022 18:20:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH] KVM: VMX: Do not trap VMFUNC instructions for L1 guests.
Content-Language: en-US
To:     Yu Zhang <yu.c.zhang@linux.intel.com>, seanjc@google.com,
        kvm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
References: <20221107082727.1355797-1-yu.c.zhang@linux.intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20221107082727.1355797-1-yu.c.zhang@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/7/22 09:27, Yu Zhang wrote:
> VMFUNC is not supported for L1 guests, and executing VMFUNC in
> L1 shall generate a #UD directly. Just disable it in secondary
> proc-based execution control for L1, instead of intercepting it
> and inject the #UD again.
> 
> Signed-off-by: Yu Zhang<yu.c.zhang@linux.intel.com>

Is this for TDX or similar?  The reason for a patch should be mentioned 
in the commit message.

Paolo

