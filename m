Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03A64622F8E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 17:01:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230443AbiKIQBr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 11:01:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230031AbiKIQBo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 11:01:44 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88DDB213
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 08:00:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668009647;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rxaPjG6OItFswovLs9/tKd4BEce49DAd1HWNvmXM51Q=;
        b=PdyVzINs/h8XepMsm7lN8kzeEEOq8wxuvENm1fZEtlrOsei4e8JPvLe24RxNqGPsSAjWIL
        FjVltDKToG4YY+4j7aiLsY0Jco3HszOfsvZUkGAmEYU7+A/DZXA4t8QOBqNw9Xfh1Ot4no
        HuTmXOQP+7oaDDSY7af4FgyrVJ6NL3g=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-613-_zkuW6BHOamCF2BW1uPLuA-1; Wed, 09 Nov 2022 11:00:46 -0500
X-MC-Unique: _zkuW6BHOamCF2BW1uPLuA-1
Received: by mail-wm1-f72.google.com with SMTP id v188-20020a1cacc5000000b003cf76c4ae66so1215486wme.7
        for <linux-kernel@vger.kernel.org>; Wed, 09 Nov 2022 08:00:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rxaPjG6OItFswovLs9/tKd4BEce49DAd1HWNvmXM51Q=;
        b=RLB08yXS+dG2bsbQoy9JsYpOTHtzbUrMLp4EF6L4Fr53OhnRtpFXB5yqL4kIyHx6u+
         WlgfyxA3Q+Hu3pg5Eva/c5oLjWd3wFwgManV9UVfHhN+LABjUXLqF/vh9Hd/I81jDLmv
         NjGEwIxRsw6pmyjLypDuDe2yhqc2d9sDOllGZ2DYik0lt7chyAzPljQr65SkaSVK33ro
         sJ9Pl2MxCkpbNkJSnHb5fu2oMBkXLiksJWQ7y3aELuHkH62ntZ5PW8OXOtKGszcPIrgc
         Q6EQp+rqa5vKXTdCx7nFtNk8WsEYh9efEjkzBjQhlCFVArpLcaDDd5po1E7VNaMbRqJ0
         YzoQ==
X-Gm-Message-State: ACrzQf36nwj+XPu72BBfSZZbcMHmBz+lGZssXDkpjWYb5L2ZTRFZsJNm
        skfYVVBsbpDCFqPqE0Bz/5aFKMKGtW14BTilo1lZWdRbcaa0EfW9d2VJu3/Zv65YOR93n9aViY3
        wRAS2PRGSsvENYugtQ1Nch4fY
X-Received: by 2002:a5d:5d87:0:b0:22a:bbc5:5afe with SMTP id ci7-20020a5d5d87000000b0022abbc55afemr38780210wrb.235.1668009645030;
        Wed, 09 Nov 2022 08:00:45 -0800 (PST)
X-Google-Smtp-Source: AMsMyM7Dbm4ElXICqWUfwTCQpO3eKpk/li4KpKb46iTDW7C9OI3JxhQpR5RK/+b9DlLq/UDO0ZEopQ==
X-Received: by 2002:a5d:5d87:0:b0:22a:bbc5:5afe with SMTP id ci7-20020a5d5d87000000b0022abbc55afemr38780188wrb.235.1668009644750;
        Wed, 09 Nov 2022 08:00:44 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:9af8:e5f5:7516:fa89? ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
        by smtp.googlemail.com with ESMTPSA id v13-20020adfe28d000000b0022e3538d305sm15950500wri.117.2022.11.09.08.00.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Nov 2022 08:00:44 -0800 (PST)
Message-ID: <56cf95b1-68b9-8685-e5af-67eebf046686@redhat.com>
Date:   Wed, 9 Nov 2022 17:00:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH 07/11] KVM: SVM: do not allocate struct svm_cpu_data
 dynamically
Content-Language: en-US
To:     Sean Christopherson <seanjc@google.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        thomas.lendacky@amd.com, jmattson@google.com
References: <20221109145156.84714-1-pbonzini@redhat.com>
 <20221109145156.84714-8-pbonzini@redhat.com> <Y2vOEkJDwlmJ2hv9@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <Y2vOEkJDwlmJ2hv9@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/9/22 16:58, Sean Christopherson wrote:
> At some point we should replace the vcpu->cpu usage with this_cpu_ptr().  All of
> the code that does per_cpu_ptr(&svm_data, vcpu->cpu) is doomed if vcpu->cpu isn't
> the current CPU.

Yes, I agree with all your other comments but I think they're better 
done in next.

Paolo

