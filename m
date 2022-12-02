Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E116640D22
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 19:28:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234291AbiLBS2F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 13:28:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234327AbiLBS2C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 13:28:02 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C65ECD9697
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 10:27:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670005623;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=33ZyAUYenMjlLRX8QFd49i1YF8RHArF5TDtZ248qOZs=;
        b=hq6HTZ0dTxE3uQ3mmJXJsfUB6Wp2mHuJQZ1sUl84HnooBw4WZzk/Rj00MXoYClMlSrBMYd
        7CPOWnFNsRGbLIB/z7WHvf+7445EpQ54cj0462hYEZG7ok7YUv6Qj510FJaFpI+4gTxqKo
        Joh1sLaI7fJXiRgvaQ9YjXeiLXFwoa0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-492-hJbUHyphOtiXi1ev0jQyDg-1; Fri, 02 Dec 2022 13:27:02 -0500
X-MC-Unique: hJbUHyphOtiXi1ev0jQyDg-1
Received: by mail-wm1-f69.google.com with SMTP id c187-20020a1c35c4000000b003cfee3c91cdso2865595wma.6
        for <linux-kernel@vger.kernel.org>; Fri, 02 Dec 2022 10:27:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=33ZyAUYenMjlLRX8QFd49i1YF8RHArF5TDtZ248qOZs=;
        b=akJjDuLk6ebpE8IhBv2n0phHeKc7nwpALR+OO4qOH8091f+9/1PUlhcirl6+28/2fB
         9GvsDekEHX9gGWppLftuy173vtCFDzY9QmIpZtqhbyiO4VMEqKAUBdWgVXh0NvPK6w6h
         pTT+rs3Xbhth0fWp7Mpv9YxXdd9bWeeRylTKYTPuNSoqRFXwbfgM+jYN6Kmnhs/4NnKq
         +44YROU4fBgbhw5TxvsJn2SPjaIo2sPINHWg+pFE1LSZitOpMQCJ/d4BUED6UtNanYDy
         J/djaucu1n1gEVIjsf4Q9Xu6aumHk5J3NvkkFNX9voU3KqhHL4nJcdTP3Ew8Nsuw49tR
         12wg==
X-Gm-Message-State: ANoB5pkPVriY1b1Go8V2Laeu1FIdGdb3PvNBvI4ef0PwH6rzkUqSQjvP
        iX83JVdVkBF+ZLs3zY3tex10AzXhPks7DQn3NnSqigTCcZywvZ3YEKwqzWoC4xpj3M1d3PRXBA/
        w7MCGNHvmNYFXmQo/+WAQHv9d
X-Received: by 2002:a05:600c:4e4b:b0:3cf:7624:5fcd with SMTP id e11-20020a05600c4e4b00b003cf76245fcdmr52102166wmq.195.1670005621430;
        Fri, 02 Dec 2022 10:27:01 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7yV3q4cofRV+TOuSntrtid+pPem3DasxYocHnzyyHvYi0JJq2f7eoPijhRXyKG/bNkn/lg7g==
X-Received: by 2002:a05:600c:4e4b:b0:3cf:7624:5fcd with SMTP id e11-20020a05600c4e4b00b003cf76245fcdmr52102158wmq.195.1670005621205;
        Fri, 02 Dec 2022 10:27:01 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:9af8:e5f5:7516:fa89? ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
        by smtp.googlemail.com with ESMTPSA id n10-20020adffe0a000000b00241bd7a7165sm7382927wrr.82.2022.12.02.10.27.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Dec 2022 10:27:00 -0800 (PST)
Message-ID: <8e8217f6-4eec-4793-637d-436a429c9aad@redhat.com>
Date:   Fri, 2 Dec 2022 19:26:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] KVM: Deal with nested sleeps in kvm_vcpu_block()
Content-Language: en-US
To:     Space Meyer <spm@google.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        kpsingh@kernel.org
References: <20221130161946.3254953-1-spm@google.com>
 <CABgObfby+9JNwrJnjPRp6pty05CqRUfKBA3AB=TNwq4q0KjBTg@mail.gmail.com>
 <CAOLenvZm4aPJAv5O+iybMxJoD-ZeytbJ=9o1nLVSh+84uj2U8g@mail.gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <CAOLenvZm4aPJAv5O+iybMxJoD-ZeytbJ=9o1nLVSh+84uj2U8g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 12/2/22 16:52, Space Meyer wrote:
> The bug doesn't seem to be easily reproducible, but looking at the
> code this should also be applicable for the upstream 6.0, 5.15, 5.10,
> 5.4, 4.19 and 4.14 branches, which have not received a backport of
> 26844fe.
> 
> Do you think this is all we should do? My conclusion from the LWN
> article was, that we should avoid the set_current_state ->
> conditional -> schedule pattern when possible as well.

Yes, the bug is there but unfortunately the backport is not easy.  I 
don't really feel confident backporting the fix to older kernels; even 
if it is apparently just a couple lines of code, event handling is very 
delicate and has had a lot of changes recently.

Paolo

