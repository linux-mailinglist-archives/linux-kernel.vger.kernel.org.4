Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F496626491
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 23:21:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234696AbiKKWVQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 17:21:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234685AbiKKWUv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 17:20:51 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D4DE9FC0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 14:19:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668205186;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BAZzp91yWabasniwc4N0s7M5/Ii7ug/2UrAa4xLSvVI=;
        b=YBvd8tgBEGSVcZY8qMuVWboG/ru65VgGfDdFwzRp2k5qLgCIqQu00rwBebVqzK6iBahMzQ
        vaFf8kAe/OP8HHkwVEf8Op1LnXT7G/6gjFoet0QmJQnyOAi+y/S49JmUqZjkfI0oos/ebX
        1mrdlP4Ecx87NVK2RFytS2LdGSL2A8k=
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com
 [209.85.221.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-21-j1jSMJYhNMGUJRRYXKONTg-1; Fri, 11 Nov 2022 17:19:45 -0500
X-MC-Unique: j1jSMJYhNMGUJRRYXKONTg-1
Received: by mail-vk1-f197.google.com with SMTP id v67-20020a1fac46000000b003a2699aa42fso1524258vke.8
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 14:19:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BAZzp91yWabasniwc4N0s7M5/Ii7ug/2UrAa4xLSvVI=;
        b=K2pgIE2NejQzS4gNwVhYPQRRT9rQHCmAHwV7Feb3p2bRqEB23Cgpn4BjJEXQWYdw1P
         qvnLkHLe5vP56e2GPth2mu9vuGnJNuyLIHLkshCZpAySXXV5NXKwyo6mx1bGR7aWQChR
         Wx9GgzpMOju74jUeVJh4cmTDI1E2zxe7j37umRu4ogBRvd/uNgFwGhzqYPNGBDeAWlXQ
         DpR0SvyurOeGjMUQ4kU5KC0lgPl+ckkf2zHNtw40C8vP7tSo6aL/qAwJcV57FrtEsHRV
         tNrhtq6W1ej72FTF4z/bFQQxSpyTbfNmF9A4Hcq9y1B2DpdPutCTC7U2+VMRrSmZ1PhZ
         kFjQ==
X-Gm-Message-State: ANoB5plUlsvYkMtvlnfgATBkzCaklD36AyVU8wtkFtAifl8/n+mtpB/z
        DF0tQISHDinkbI72Mlm7dGBYs4Ny+y+TlD7XNHcpRQoMamUrt/13G1UJcDHtAeEBrOzE90+fJ4A
        dP/yrGt1hvwDYQHHGND1wgSUwi+DiMIAagStqA4BC
X-Received: by 2002:a05:6122:644:b0:3b8:9b88:fd20 with SMTP id h4-20020a056122064400b003b89b88fd20mr2171409vkp.19.1668205184665;
        Fri, 11 Nov 2022 14:19:44 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4KdW3Y1GnVPEPVmuFkScPhalSulvfQloZ6yH+NRBRD1Q6elMvS+prLPLU6pwcAWBm0bRyOJ8T0c61Dh32Lw5k=
X-Received: by 2002:a05:6122:644:b0:3b8:9b88:fd20 with SMTP id
 h4-20020a056122064400b003b89b88fd20mr2171405vkp.19.1668205184392; Fri, 11 Nov
 2022 14:19:44 -0800 (PST)
MIME-Version: 1.0
References: <PH0PR02MB738464CE7E6D9C54D29ED35DF63F9@PH0PR02MB7384.namprd02.prod.outlook.com>
In-Reply-To: <PH0PR02MB738464CE7E6D9C54D29ED35DF63F9@PH0PR02MB7384.namprd02.prod.outlook.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Date:   Fri, 11 Nov 2022 23:19:33 +0100
Message-ID: <CABgObfZjvac5KpdY5MENLjhPuFf_N6+HFbM4DKqE2C+r2p==cg@mail.gmail.com>
Subject: Re: Centos 7(kernel-3.10) guests stuck in recursive asyn faults on
 kernel 5.10
To:     Manish Mishra <manish.mishra@nutanix.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Prerna Saxena <prerna.saxena@nutanix.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Note that the series you linked is not the final one; the final
version disabled asynchronous page faults completely on old guests:

+static inline bool kvm_pv_async_pf_enabled(struct kvm_vcpu *vcpu)
+{
+       u64 mask =3D KVM_ASYNC_PF_ENABLED | KVM_ASYNC_PF_DELIVERY_AS_INT;
+
+       return (vcpu->arch.apf.msr_en_val & mask) =3D=3D mask;
+}

(commit 2635b5c4a0e407b84f68e188c719f28ba0e9ae1b)

Old guests are not deprecated, but the old implementation had issues
that cannot be solved so old guests will not have asynchronous page
faults anymore. For this reason I think it's strange that you still
see async page fault in the guest. What do the stack traces look like?

Thanks,

Paolo

On Tue, Nov 8, 2022 at 2:33 PM Manish Mishra <manish.mishra@nutanix.com> wr=
ote:
>
> Hi Everyone,
>
> We are facing some issues with memory hotplug on Centos 7(kernel-3.10) gu=
ests with kernel-5.10 kvm hosts. I see guest is stuck in recursive async pa=
ge faults for very long hence creating deadlocks on guests. I was looking a=
t changes between kernel 5.2 and 5.10 around async page faults. I see this =
series could be related, https://lore.kernel.org/lkml/20200429093634.151490=
2-7-vkuznets@redhat.com/.
>
>
>
> Have we deprecated older linux guests with 5.10 hosts, after this update =
in async page fault handler mechanism or this issue is unrelated. I do not =
have much idea knowledge of async page faults so wanted to confirm. Any hel=
p will be really appreciated.
>
> Thanks
>
> Manish Mishra

