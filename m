Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8AAF6CA8D1
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 17:20:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231834AbjC0PUt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 11:20:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231960AbjC0PUr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 11:20:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47CC11BFB
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 08:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679930402;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kBXULJ0YJW6Vv+dTm+DQzBsn3dK4XBiUD4aYtQvteI8=;
        b=JS7TclyPtK5V7X2lhcZYeBTklmIjVdFWmVCAVLFR7cYPr7xARJ/P2FC5X2xB0DAR/iVB52
        oE9TNgTyLRrnnbHTSFZzEY1A6BhDll5FbFm3D5zviGHFMIqqH7b48cFtL1HccJs3a6U9QY
        KqGHAzNN2mk+ofqbsPhN47vFgeuPBgg=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-493-_E1eDXOuOLam-Ow5sgIi1Q-1; Mon, 27 Mar 2023 11:19:58 -0400
X-MC-Unique: _E1eDXOuOLam-Ow5sgIi1Q-1
Received: by mail-ed1-f72.google.com with SMTP id k14-20020a508ace000000b005024a8cef5cso1771648edk.22
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 08:19:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679930397;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kBXULJ0YJW6Vv+dTm+DQzBsn3dK4XBiUD4aYtQvteI8=;
        b=K135YPKZ7QONW3rH7GE5RbMfzflfVCY/m9E1d1PPEGChG/0P3vQUqoyNUL+ha/Hdmk
         +Td89FeeXWq7BDuOjGG4mHu4vjgs6XUKDM9GRotcn0d0izFyWnUhC/J7E1s+i0bLxYqc
         d1v7NnmpBD8O347yDZJO1DXEeDuWTFhjRjzxAvnvY8CftDH0WxD4fMSeZQCF/XT7TX8k
         Ddet2nZyo5gWHOhD9BefS/xn24AzZJY1K77bZqxr25zZjSCRJn7cSzZYLnBHVNaRx7d0
         o0+ylclqBVmtNte8TDx4soUwLn1aV3TsBx4mn4uvT9SzEQTIvie7EzQI75iciiGuRybK
         70UQ==
X-Gm-Message-State: AAQBX9fFSQiIBZA8fAi6Mms+0p2b2Cnmk9HialvYRQERe4422UNHf/Tb
        EKE9CjaAUG9fcjnqLqsrFC3Xy7ogY0P1FI2y90EhWeuEm/mjZHstDYfYMFmh9WtF/E7ZYMhixMq
        ZXnrP1aoy1Xs3M0abz3n4hiNS
X-Received: by 2002:a17:906:f6cd:b0:92f:b8d0:746c with SMTP id jo13-20020a170906f6cd00b0092fb8d0746cmr12315934ejb.20.1679930397764;
        Mon, 27 Mar 2023 08:19:57 -0700 (PDT)
X-Google-Smtp-Source: AKy350amEJt/4jKby5lbzCbh7fHRRBROfolwArbQtP8/z/b3EANonkAshH00FVXH2WUDdpY6F6QaDQ==
X-Received: by 2002:a17:906:f6cd:b0:92f:b8d0:746c with SMTP id jo13-20020a170906f6cd00b0092fb8d0746cmr12315913ejb.20.1679930397502;
        Mon, 27 Mar 2023 08:19:57 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:9af8:e5f5:7516:fa89? ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
        by smtp.googlemail.com with ESMTPSA id r12-20020a50c00c000000b00501d2f10d19sm10349379edb.20.2023.03.27.08.19.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Mar 2023 08:19:56 -0700 (PDT)
Message-ID: <151c3b04-31db-6a50-23af-c6886098c85c@redhat.com>
Date:   Mon, 27 Mar 2023 17:19:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 0/6] KVM: x86: Unhost the *_CMD MSR mess
Content-Language: en-US
To:     Sean Christopherson <seanjc@google.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Emanuele Giuseppe Esposito <eesposit@redhat.com>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Jim Mattson <jmattson@google.com>
References: <20230322011440.2195485-1-seanjc@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20230322011440.2195485-1-seanjc@google.com>
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

On 3/22/23 02:14, Sean Christopherson wrote:
> Revert the FLUSH_L1D enabling, which has multiple fatal bugs, clean up
> the existing PRED_CMD handling, and reintroduce FLUSH_L1D virtualization
> without inheriting the mistakes made by PRED_CMD.
> 
> The last patch hardens SVM against one of the bugs introduced in the
> FLUSH_L1D enabling.
> 
> I'll post KUT patches tomorrow.  I have the tests written (and they found
> bugs in my code, :shocked-pikachu:), just need to write the changelogs.
> Wanted to get this out sooner than later as I'm guessing I'm not the only
> one whose VMs won't boot on Intel CPUs...

Hi Sean,

did you post them?

Paolo

