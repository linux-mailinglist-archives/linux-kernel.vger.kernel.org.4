Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 829DD614D2C
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 15:55:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230186AbiKAOzb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 10:55:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230111AbiKAOz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 10:55:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4487E2DDF
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 07:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667314466;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UpfQYVzMIcuMXx56DkvqTXydEG0Wdlj350I7KRytfvw=;
        b=hyqrnk5KOZGGUOP7rDSltT+yMb+hYiL1dY9CyEmhxtaVUqUZNSnkFQus+ClkvCYI+UoN2z
        aZZm4wOwhBbbTKOsD+91JMzt2I6eTb/USCsgOC1Y+KAsVeoRJ5Lay4fYK5Ej9JT8YCKvEa
        TVS7AJ4cxmhKZ7LsD/E6obuSAFcTAiA=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-433-uPdlOkmqOI-pcAtL680Dlg-1; Tue, 01 Nov 2022 10:54:25 -0400
X-MC-Unique: uPdlOkmqOI-pcAtL680Dlg-1
Received: by mail-ej1-f72.google.com with SMTP id sd8-20020a1709076e0800b007ac2e1693abso7952849ejc.13
        for <linux-kernel@vger.kernel.org>; Tue, 01 Nov 2022 07:54:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UpfQYVzMIcuMXx56DkvqTXydEG0Wdlj350I7KRytfvw=;
        b=1Zmf8e2OcyUEycBL7dvr7kQZ1X+iCi4MYrLtbGXykMbtAjs929T7nDWJIv/l3JzDlS
         Xvcy2lTO8k/Q6SOCiu6kLc2ezu5vqfJsAO5XgMcI/toGCLslfRd0unVBApseGYfEvHi0
         oRfMv3iONBS/JVhu/YzT+vW31pHHzsBNikOMCJKikv6ykbhzZysNsyJ8K+i3SrAKCN+D
         PQn3LGo2L+J/IPtV+J3puK3MmvcrkKNErcH5XhQXOphOoYqG9CFJVSgCzn8as5IdqeRq
         QMiYQtxxag++r9JSunpDPGbiVO0YYOjioUS9nVWePDL1ws3m1uqiFxan8dBKNpps9tIi
         HnvQ==
X-Gm-Message-State: ACrzQf3yCIZ2TkPXTXvaKsA9pHHbk7pmTGhMBAaNSGp5HbTxhGunLUO0
        q7nuxmj8n1iEIGZ55B+hOkQ6etkH6/cvbAQkD8zVxwL43oEKyXMcPeSIQErHUe8T9SLPwjfElmI
        pf9UroIA7ofR7nzyB/n/G3nPej7N1LrmhdhBrQXMiuehNEv4chV1bWtEUgXXqLvkfbR0w+nN/AT
        6+
X-Received: by 2002:a17:907:8a24:b0:795:bb7d:643b with SMTP id sc36-20020a1709078a2400b00795bb7d643bmr19113949ejc.115.1667314464135;
        Tue, 01 Nov 2022 07:54:24 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6cO4rk8NeV9RvMCaBS52ImLLAf4ZLqcdpiLZqjgPxz3IJI9NfZXhSLsdW9KGQGq3mQMXBZDg==
X-Received: by 2002:a17:907:8a24:b0:795:bb7d:643b with SMTP id sc36-20020a1709078a2400b00795bb7d643bmr19113910ejc.115.1667314463791;
        Tue, 01 Nov 2022 07:54:23 -0700 (PDT)
Received: from ovpn-194-149.brq.redhat.com (nat-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id m23-20020a170906849700b0079e11b8e891sm4207005ejx.125.2022.11.01.07.54.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 07:54:23 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>
Cc:     kvm@vger.kernel.org, Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Siddharth Chandrasekaran <sidcha@amazon.de>,
        Yuan Yao <yuan.yao@linux.intel.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v12 00/46] KVM: x86: hyper-v: Fine-grained TLB flush +
 L2 TLB flush features
In-Reply-To: <87zgdcs65g.fsf@ovpn-194-149.brq.redhat.com>
References: <20221021153521.1216911-1-vkuznets@redhat.com>
 <Y1m0ef+LdcAW0Bzh@google.com> <Y1m1Jnpw5betG8CG@google.com>
 <87zgdcs65g.fsf@ovpn-194-149.brq.redhat.com>
Date:   Tue, 01 Nov 2022 15:54:21 +0100
Message-ID: <87h6zisp2a.fsf@ovpn-194-149.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Vitaly Kuznetsov <vkuznets@redhat.com> writes:

>
> Paolo,
>
> do you want to follow this path or do you expect the full 'v13' from me? 

v13 it is :-) I've added all the tags and addressed the remaining
feedback (a typo fixed + a comment added).

-- 
Vitaly

