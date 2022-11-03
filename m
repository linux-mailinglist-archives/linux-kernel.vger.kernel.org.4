Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE3F7617EDF
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 15:05:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230231AbiKCOFm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 10:05:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230209AbiKCOFi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 10:05:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25E8F11A2F
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 07:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667484273;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2ld7KbWWPpVg/DGXuI3WKVRs5TJPSNq4PfcjQdMphjo=;
        b=KEJc5mWK/XGWIDAdswXjbXXVhcNodZETUC0DjLncFSUJiYaRwGfZdz3ddf9Oyd19MXRNQB
        PF8Dd/Sp3F8oadxGZ+gMW/Uvi+eqZIknjP7HDLbOUfM19qxP2oV/A5FyyyVaEc+XE+HO2A
        YwufaRodatiRBgQuhnMpX8STv4olxLE=
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com
 [209.85.222.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-88-wYYS_yCeP1Wb9w35vcDWNg-1; Thu, 03 Nov 2022 10:04:30 -0400
X-MC-Unique: wYYS_yCeP1Wb9w35vcDWNg-1
Received: by mail-ua1-f69.google.com with SMTP id v15-20020ab0558f000000b003ea524863e4so1480851uaa.0
        for <linux-kernel@vger.kernel.org>; Thu, 03 Nov 2022 07:04:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2ld7KbWWPpVg/DGXuI3WKVRs5TJPSNq4PfcjQdMphjo=;
        b=r0Ekfa13PRPglrex3RQIWqLpkK6RzVLOoeUV+SgjDBmbAmjLoovc7BTd7yxw7mhGXl
         oPNT2ilyhu8HMEg4RVkNGnsDAqbSNdndtfj+IUEfrdQTfxDTmlJRm+58ME4Bf007z+oG
         q++Z4hfzEfXaXhTgXgr05KwlMgDJ+aXo0BrIaw9uMn4J5SB1kJ0IopbqQ+jL21Cubb/m
         VsZE5g5ohq1VHVwtVOWeswRFldY4S/Nr43aZWHkAiFzjJevPRclt9hpAXSrTALEeALct
         GU34/kpgBFsD+DOVcrLbbWD4JGYCO4uO6q3UdEc3zKCfvNKsrD3PXtnC8FAbZnNxpc6+
         THJw==
X-Gm-Message-State: ACrzQf3POgMCGW7i6UEKdNyBWvaZfZy0mN6tLwf27mNpKR+5M8jg5kyT
        Mra2i5kxTVSTZ3GQYq7Xk0TdKfVy+p8VKa3DMM/JqrBsYJk/CC/OC27zxAkb29IGSbpgxD13HbJ
        elBy8ZHH/pZaj5ZBc/YqoM5HNAG5jJv8Z+lhTE5Ma
X-Received: by 2002:a67:c997:0:b0:3aa:1d0c:6bc7 with SMTP id y23-20020a67c997000000b003aa1d0c6bc7mr18114525vsk.16.1667484269585;
        Thu, 03 Nov 2022 07:04:29 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM57ejOKzdNWqeTyWHPkPRmEBqAcfUgljrJu10jVJC1iEGC5QqKTnJr+aHwKv6/RTPPoYaQADtoBOTHZ/wIpPrc=
X-Received: by 2002:a67:c997:0:b0:3aa:1d0c:6bc7 with SMTP id
 y23-20020a67c997000000b003aa1d0c6bc7mr18114480vsk.16.1667484269311; Thu, 03
 Nov 2022 07:04:29 -0700 (PDT)
MIME-Version: 1.0
References: <20221102231911.3107438-1-seanjc@google.com> <20221102231911.3107438-11-seanjc@google.com>
 <d641088f-87d9-da77-7e98-92d1a9de6493@redhat.com>
In-Reply-To: <d641088f-87d9-da77-7e98-92d1a9de6493@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Date:   Thu, 3 Nov 2022 15:04:17 +0100
Message-ID: <CABgObfZDngVgmPetJEQGFW-MZGqYvW9tTa5jzcKheO5EO703Vw@mail.gmail.com>
Subject: Re: [PATCH 10/44] KVM: VMX: Clean up eVMCS enabling if KVM
 initialization fails
To:     Sean Christopherson <seanjc@google.com>,
        Marc Zyngier <maz@kernel.org>,
        Huacai Chen <chenhuacai@kernel.org>,
        Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
        Anup Patel <anup@brainfault.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Eric Farman <farman@linux.ibm.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Oliver Upton <oliver.upton@linux.dev>,
        Atish Patra <atishp@atishpatra.org>,
        David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        kvmarm@lists.cs.columbia.edu, linux-mips@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, kvm-riscv@lists.infradead.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Isaku Yamahata <isaku.yamahata@intel.com>,
        Fabiano Rosas <farosas@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Chao Gao <chao.gao@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yuan Yao <yuan.yao@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 3, 2022 at 3:01 PM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 11/3/22 00:18, Sean Christopherson wrote:
> > +static void hv_cleanup_evmcs(void)
>
> This needs to be __init.

Error: brain temporarily disconnected.

Paolo

