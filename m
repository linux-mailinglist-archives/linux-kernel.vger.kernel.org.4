Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B1FE61A222
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 21:27:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230005AbiKDU10 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 16:27:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbiKDU1X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 16:27:23 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A185F1F2D1
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 13:27:19 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id v28so5441585pfi.12
        for <linux-kernel@vger.kernel.org>; Fri, 04 Nov 2022 13:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TzyhTv3BAtgpGpRr8HnNLx/d2zCvSqkboAFtik4Imo0=;
        b=q/PTXKQj3ArVm2XzZe97QeFygVMm1eXh+9AVtXcJ75aOhS7rpOmmmorCukrcxmTsXJ
         xtHpP7JyICLKwJpO4UdyBCOfADg9j8qWzQtBsGyOUBj4dtUE2hEcaa0M2lJNL2RYHNdm
         t9CE40syL4mSgI+9axRmHRY3m49U53Bcc5xsUL4w5HmCnvq3rZFCi8RspoeZ0S4Nhg0P
         dklWYN0e+iqclhNFPVLNqLlrIm4bRgIuUSiy6nVFx0aKBZbtXqUzzmm+oTu43A9TiINS
         r9mhyi03/1kAIfHUOzdEnLew/bMGSFKH13ZsSBoEdZkxO+PvUKRhjXGV6DaJ6ZELthJK
         tWVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TzyhTv3BAtgpGpRr8HnNLx/d2zCvSqkboAFtik4Imo0=;
        b=HuehxHET4iPiQem9yLxviGGtSujAicct1hdYBUAZ9LogzIrpP0tj1bhEuQeqy4Eqe2
         I7hjLElKLFOS7BS/qCzI8pzDbuuA7lsHP+7/yJMVmQtKJYytexprYJt6omv2607b2UxO
         JVkJSz7wbdSFOMhu0PwesB6GPvCr8/K86iDHba1zlUqTdEmk1usYT33DzLUHLQsuXtGB
         7BWC+qZUj4R7tnW3IisgUoIVjq2BbHsghwzkCQBdJZd3jBSyI4EtgFvn6ehHq5oVTKF+
         6muqRhyjXMlYg0ERpsfJFs43Ydg2ctMtGScROu9p2/aNQzsp44CjX+QYyR7b14Ohszkq
         eFNw==
X-Gm-Message-State: ACrzQf1m/d5tNDK4BKG20APJ0oHYLKvJDMmBq5Ofnq9p0Y9x5wqg1tyW
        C8VFMeRugYKkO9oSsI/xjNHo9Q==
X-Google-Smtp-Source: AMsMyM6nILnCIcSIsk5JMrE+WRVnxFnaYDn7QGx3yWf1KAa3dZc7TNSn3aZcg19Xay3NbhiF32a9mw==
X-Received: by 2002:a05:6a00:1781:b0:561:7f7f:dc38 with SMTP id s1-20020a056a00178100b005617f7fdc38mr38037687pfg.42.1667593638927;
        Fri, 04 Nov 2022 13:27:18 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id u8-20020a1709026e0800b0018863e1bd3csm159522plk.134.2022.11.04.13.27.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 13:27:18 -0700 (PDT)
Date:   Fri, 4 Nov 2022 20:27:14 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Isaku Yamahata <isaku.yamahata@gmail.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, Marc Zyngier <maz@kernel.org>,
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
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        James Morse <james.morse@arm.com>,
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
Subject: Re: [PATCH 00/44] KVM: Rework kvm_init() and hardware enabling
Message-ID: <Y2V1oslbw24/2Opd@google.com>
References: <20221102231911.3107438-1-seanjc@google.com>
 <20221104071749.GC1063309@ls.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221104071749.GC1063309@ls.amr.corp.intel.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,FSL_HELO_FAKE,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 04, 2022, Isaku Yamahata wrote:
> Thanks for the patch series. I the rebased TDX KVM patch series and it worked.
> Since cpu offline needs to be rejected in some cases(To keep at least one cpu
> on a package), arch hook for cpu offline is needed.

I hate to bring this up because I doubt there's a real use case for SUSPEND with
TDX, but the CPU offline path isn't just for true offlining of CPUs.  When the
system enters SUSPEND, only the initiating CPU goes through kvm_suspend()+kvm_resume(),
all responding CPUs go through CPU offline+online.  I.e. disallowing all CPUs from
going "offline" will prevent suspending the system.

I don't see anything in the TDX series or the specs that suggests suspend+resume
is disallowed when TDX is enabled, so blocking that seems just as wrong as
preventing software from soft-offlining CPUs.
