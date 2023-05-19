Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB2B1709E6E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 19:42:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231403AbjESRmy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 13:42:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230110AbjESRmt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 13:42:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F90E107
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 10:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684518122;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IPvHfXA4AeF8oU0t2aOUngrckD2YwBip/YH9aUYlKr0=;
        b=hwkF5lJeno24HZFcpavdHnvouPTX3ri/HzUpNchagHqZvjcFsplG1AcKVdTaLQYibcf7zv
        ptPOCoP+q+/XQpYGxyfzPRRR2hmK4CCEZNNuGDn44j/nUZDefi9v2rpXooidCygDVpGq1m
        hxSzG0PRTdsssJrnCNVegXvTSe+1NkY=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-146-ECupW8CpNauYbPUvP5XjZw-1; Fri, 19 May 2023 13:42:00 -0400
X-MC-Unique: ECupW8CpNauYbPUvP5XjZw-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-96f4f1bb838so170008366b.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 10:42:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684518119; x=1687110119;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IPvHfXA4AeF8oU0t2aOUngrckD2YwBip/YH9aUYlKr0=;
        b=Vg10aKS704yeu7mvoh9P1QzO61dT0COTpyeqI8GEhItUuXkrKYMcqm3xWxJ2TQhjOc
         KDq5tkx5gSviM8b8Svfc6Sk8UVBjZMK4u+SHcNmhWM92q7/vzRD/82NpzUz+SRKh6ADA
         TjlJLVdUprKntTtZClHvN/XH1NhXUDnYSh7GWlPr+smO5z0lbhXu21CBk6drfx7idM8B
         EauJK/zUvflnyDDLEmysMnY7XhIu93vgmveTROZCT+ikDU2LUHGlNiIFLS1GmKpOc3eL
         WqA5W++tTXQhRMRT02FIVicogOag70hcUd2PbgPGAcqU5mVkz9jRLF5wDnKJ5nZHBB5S
         8xUA==
X-Gm-Message-State: AC+VfDwW+odpq9u5Jm8LUAbmem4Mwj0zl/SqtgQj1Q+uAtuvf/V+OMIM
        fqmFsq33OuaWXhp+tCZKwwLW2lUhtZAD/HXMuvw107sF+N+xtvodRnv0G7ouiv8zJhYxoG0rL4X
        v4HUdyR9Qi1eHhg9hieXCp84S
X-Received: by 2002:a17:907:7f26:b0:966:4e84:d82d with SMTP id qf38-20020a1709077f2600b009664e84d82dmr2635888ejc.3.1684518119334;
        Fri, 19 May 2023 10:41:59 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4OyOatoK1f1B3VZIVP533ki2ItaPx3mIwrd17+o/dg6ejlgF+lc7kz4qMM3KmEXtzZ1sXGew==
X-Received: by 2002:a17:907:7f26:b0:966:4e84:d82d with SMTP id qf38-20020a1709077f2600b009664e84d82dmr2635866ejc.3.1684518119017;
        Fri, 19 May 2023 10:41:59 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:9af8:e5f5:7516:fa89? ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
        by smtp.googlemail.com with ESMTPSA id p16-20020a170906a01000b00965e68b8df5sm2530428ejy.76.2023.05.19.10.41.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 May 2023 10:41:58 -0700 (PDT)
Message-ID: <c4d8e54e-28da-f788-5569-e5274b19c34e@redhat.com>
Date:   Fri, 19 May 2023 19:41:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 0/2] KVM: Fix race between reboot and hardware enabling
Content-Language: en-US
To:     Sean Christopherson <seanjc@google.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>, kvmarm@lists.linux.dev,
        Huacai Chen <chenhuacai@kernel.org>,
        Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
        Anup Patel <anup@brainfault.org>,
        Atish Patra <atishp@atishpatra.org>,
        kvm-riscv@lists.infradead.org
References: <20230512233127.804012-1-seanjc@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20230512233127.804012-1-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/13/23 01:31, Sean Christopherson wrote:
> Fix a bug where enabling hardware virtualization can race with a forced
> reboot, e.g. `reboot -f`, and result in virt hardware being enabled when
> the reboot is attempted, and thus hanging the reboot.
> 
> Found by inspection, confirmed by hacking the reboot flow to wait until
> KVM loads (the problematic window is ridiculously small).
> 
> Fully tested only on x86, compile tested on other architectures.
> 
> v2:
>   - Rename KVM's callback to kvm_shutdown() to match the hook. [Marc]
>   - Don't add a spurious newline. [Marc]
> 
> v1: https://lore.kernel.org/all/20230310221414.811690-1-seanjc@google.com
> 
> Sean Christopherson (2):
>    KVM: Use syscore_ops instead of reboot_notifier to hook
>      restart/shutdown
>    KVM: Don't enable hardware after a restart/shutdown is initiated
> 
>   virt/kvm/kvm_main.c | 43 +++++++++++++++++++++++++++----------------
>   1 file changed, 27 insertions(+), 16 deletions(-)
> 
> 
> base-commit: b3c98052d46948a8d65d2778c7f306ff38366aac

Queued, thanks.

Paolo

