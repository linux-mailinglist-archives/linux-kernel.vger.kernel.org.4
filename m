Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 163E16CC1D2
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 16:15:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233065AbjC1OPY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 10:15:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233100AbjC1OPO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 10:15:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60A183A84
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 07:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680012824;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+E8HtZqTun8UNt8XZcvENJSCBWpeQntcGXMLkFXrU3g=;
        b=h7ZwJ+bkLupsPQhmuRzYNKRgKgd9LpwVQuA6IxM+HS3SoEFvB7JsoSRrSquhic8i4qo1pp
        TfBeJxAtm4NleARp8MJcYbDuNPwfKHb1Ab7x4oPEGy6f0Cb45JcOsJ3IEoV+1qshsjVFgR
        HS2bt3lXhU3XRShN7rnirXvV5+mfRi4=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-96-p3yKgtI4Nra8qaRWlOH1_w-1; Tue, 28 Mar 2023 10:13:43 -0400
X-MC-Unique: p3yKgtI4Nra8qaRWlOH1_w-1
Received: by mail-ed1-f69.google.com with SMTP id k30-20020a50ce5e000000b00500544ebfb1so17633480edj.7
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 07:13:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680012822;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+E8HtZqTun8UNt8XZcvENJSCBWpeQntcGXMLkFXrU3g=;
        b=hoBtBDtkiY3vmYseIR/lkz6IxoVFOIDDiTFSKag44z4zbivf9FKwE/44tChcfkrOJa
         RPw9xzS3qNX3pGfmZg7CXjfnZLPsve7UJcdYQ8JbealrSbYTyKEX8fYFbPCvrGnAbIJC
         VlIBse4aKzIF+39uhGF76Z48Rg5iUGoUxi39e2CCrfitGGCPni7WdFC9PfdEaWWmYYCG
         MghCG6XwkRMpZjQtPa52pwPpJ8KKJrjOln7+MPR3y8gm8+LvuQ37z3PTnNZt8mOtF2Iw
         LABq+/Y6jsWzfuo7CoVXi+VhB4Lbj70v0GmlCNCTrO597Gn1B+NyUoNDMj6uXdDLm4ew
         0zfA==
X-Gm-Message-State: AAQBX9cnnVtulFCvj636z3ncS+uxa8acXE0SyO0n0+JdFGKMi29EVMV+
        3s2TCfMvb8sbAupbLfQzx9GuUoGpaVRzYCxxmnlhLp1o5ZExSf59Ni8hGvKxSNSCr5cfSIXhHtw
        u8th/6+kV61xics/EMFIyCoEj
X-Received: by 2002:a17:907:8a08:b0:944:44d:c736 with SMTP id sc8-20020a1709078a0800b00944044dc736mr12059618ejc.64.1680012821895;
        Tue, 28 Mar 2023 07:13:41 -0700 (PDT)
X-Google-Smtp-Source: AKy350bq4jWUmHpYItDc9v2j+gaXcLGVHaVKbHyNxW/udCKRUqQ5mrD9MVmzHsiurNkpWO6mf3ruIQ==
X-Received: by 2002:a17:907:8a08:b0:944:44d:c736 with SMTP id sc8-20020a1709078a0800b00944044dc736mr12059587ejc.64.1680012821634;
        Tue, 28 Mar 2023 07:13:41 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:1c09:f536:3de6:228c? ([2001:b07:6468:f312:1c09:f536:3de6:228c])
        by smtp.googlemail.com with ESMTPSA id u23-20020a170906409700b009334a6ef3e8sm13334074ejj.141.2023.03.28.07.13.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Mar 2023 07:13:41 -0700 (PDT)
Message-ID: <55c79f33-2549-38eb-f868-8e6141d7d322@redhat.com>
Date:   Tue, 28 Mar 2023 16:13:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PING PATCH v4 27/29] LoongArch: KVM: Implement vcpu world switch
Content-Language: en-US
To:     Tianrui Zhao <zhaotianrui@loongson.cn>
Cc:     Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Mark Brown <broonie@kernel.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Oliver Upton <oliver.upton@linux.dev>, maobibo@loongson.cn,
        Xi Ruoyao <xry111@xry111.site>
References: <20230328123119.3649361-1-zhaotianrui@loongson.cn>
 <20230328123119.3649361-28-zhaotianrui@loongson.cn>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20230328123119.3649361-28-zhaotianrui@loongson.cn>
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

On 3/28/23 14:31, Tianrui Zhao wrote:
> + * prepare switch to guest
> + * @param:
> + *  KVM_ARCH: kvm_vcpu_arch, don't touch it until 'ertn'
> + *  GPRNUM: KVM_ARCH gpr number

Stale comment (should be "a2: kvm_vcpu_arch, don't touch it until 'ertn'").

Since you are at it, I noticed now that tmp and tmp1 aren't too useful 
because all registers will be overwritten before the end of the macro. 
You choose whether to keep or remove them.

Paolo

> + *  tmp, tmp1: temp register
> + */

