Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10FA26B967B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 14:40:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231944AbjCNNjo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 09:39:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230370AbjCNNjO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 09:39:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 781CF8ABE6
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 06:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678800901;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pzh0yS1EOl7eL13/TE9MCKPwcnxS3SeO9TF3mrNv8VQ=;
        b=do4nPnUk6DH1NQQpvGl0hkJ0gBHwqdjfen/cbguDBJDrPc9FtFaFSQUD2u5iRDlMWkF4YX
        1Q66Vrw4dZ7O2T/5iDoI0oboqIxHKVGe+Oep+HdZen7u1eVd0ssYxyg+QedPSA+PSETQva
        KELElotRfgakXbgampD1S6zxCd1CunU=
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-644-zan_rhLAObSzlLNo9arQ0Q-1; Tue, 14 Mar 2023 09:28:07 -0400
X-MC-Unique: zan_rhLAObSzlLNo9arQ0Q-1
Received: by mail-ua1-f70.google.com with SMTP id e21-20020ab01695000000b0068fb160ab81so7714693uaf.17
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 06:28:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678800487;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pzh0yS1EOl7eL13/TE9MCKPwcnxS3SeO9TF3mrNv8VQ=;
        b=sEeEJRW9225OhcDvUdAvKxKKsqp7rVL4PcnerQkGjaHwZayp7Y9osh/PvNnoNR+sbO
         uNTz89/446jU84MU7tdj/Gx33gDg0Vqujgwujd7t+/gwVD8SrMOexJaB7V5yk/cRw6F7
         VrbzphOoWFVjEbHsz7JqKiGfeKeMNmiRvjrrTXyCELMCWDb6MQ4mQjY9OCjX13HnqR+H
         wiSuRBuXFOaHOsAuwYrp2WKeuhHUPdca8lLex949VASGblHXkpX5HiqqqcRQ8nHEvQFA
         XHQNtJqhNBG6A6c+9tR+p8WUGijrgTnPNsCfrHLpXLpuhWJmEN6KpJxdQZTf9m0Ik2LC
         hTMA==
X-Gm-Message-State: AO0yUKXi9m1+TOHZNc8EwsGGMr4BqdAmMpEpSOqeTdcd8HJRiBIGt3ac
        igCjyV5kW8pHEfdDiArBc3CueSZWb2JREmNM+eM1Cl9bkDp/EJhrXTKGqxQDMUlxhMThBOgKmg1
        rFWi4aG2pZ5K1aEBT5awL9L43d7WrK35JFY84Iw2j
X-Received: by 2002:ab0:54c5:0:b0:68a:702a:2494 with SMTP id q5-20020ab054c5000000b0068a702a2494mr23083640uaa.0.1678800486851;
        Tue, 14 Mar 2023 06:28:06 -0700 (PDT)
X-Google-Smtp-Source: AK7set90x/ZkPrrtllGR6El3BbbBqXs0RjXdLKFJ734H/MtZzJ5jjNEj1fnpHVkraA+k0LRaRQ1muXOO9PNdW4zv+J0=
X-Received: by 2002:ab0:54c5:0:b0:68a:702a:2494 with SMTP id
 q5-20020ab054c5000000b0068a702a2494mr23083630uaa.0.1678800486601; Tue, 14 Mar
 2023 06:28:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230131181820.179033-1-bgardon@google.com>
In-Reply-To: <20230131181820.179033-1-bgardon@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Date:   Tue, 14 Mar 2023 14:27:55 +0100
Message-ID: <CABgObfaP7P7fk66-EGF-zPEk0H14u3YkM42FRXrEvU=hwFSYgg@mail.gmail.com>
Subject: Re: [PATCH V5 0/2] selftests: KVM: Add a test for eager page splitting
To:     Ben Gardon <bgardon@google.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Peter Xu <peterx@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        David Matlack <dmatlack@google.com>,
        Vipin Sharma <vipinsh@google.com>,
        Ricardo Koller <ricarkol@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 31, 2023 at 7:18=E2=80=AFPM Ben Gardon <bgardon@google.com> wro=
te:
>
> David Matlack recently added a feature known as eager page splitting
> to x86 KVM. This feature improves vCPU performance during dirty
> logging because the splitting operation is moved out of the page
> fault path, avoiding EPT/NPT violations or allowing the vCPU threads
> to resolve the violation in the fast path.
>
> While this feature is a great performance improvement, it does not
> have adequate testing in KVM selftests. Add a test to provide coverage
> of eager page splitting.
>
> Patch 1 is a quick refactor to be able to re-use some code from
> dirty_log_perf_test.
> Patch 2 adds the actual test.

I have finally queued it, but made a small change to allow running it
with non-hugetlbfs page types.

Also, see the "KVM: selftests: skip hugetlb tests if huge pages are
not available" patch I have just sent, which makes the test not fail
in a default kernel configuration.

Thanks,

Paolo

