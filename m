Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4884E60EB0B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 23:57:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233765AbiJZV5j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 17:57:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233692AbiJZV5e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 17:57:34 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E7A5EAC8D
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 14:57:27 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id f9so11934571pgj.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 14:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yBCqQl7C95Ae609/pKLQsFkiyQPPBReFiNcdK7bH4Gs=;
        b=BXULZMO54vlQmWlTrlAqUQPxVI28yZu/zUlJZ+d6dQecwjkpAs8nKBcHe2eV3051y5
         DuifxTkBZm/NLh70EEZBv+vlGL9i/VHaqoGUt63ywP3X2I+De9SUo8SfUYFhBdiywJob
         Y1JGy8J2cABrMNQ4ZRJyAa0p/UfQs260GuP4KYlyj0PLdLwbLbvbUHWZcldhhc/A0fQr
         0IEc7tiuC4zaFFEQyNB3FlNE4fiVAKsjn0QC2Ah68CVtAtrrZ4S2SMXw211rGY/yKJUE
         Vmj7JjyzG1E/hnwv+rpBx4tJwqajsrH/sgg9WFzEjRnfBlF8BoMLE2TBslcH/oVr8wf/
         WLPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yBCqQl7C95Ae609/pKLQsFkiyQPPBReFiNcdK7bH4Gs=;
        b=ydr8KceoN3LjqRjJOQXEZjm2eRKtrucw7L0AVdxFqBsk9pDEPRgQrZYr4E0DAy06tM
         JyQtzjrf0QBt45wox9GMMvv8F6srxhWzOQZ4cZ5ZEo2YrOXMhCCpkrBgnLf6JvXrEurS
         QIoniJsqOSb3JZjOfgBCbKpC7y54EDruy+vfJBdiRagrA+AZw3o6NxazhgzZvXAs5+mP
         hMQgMtznK3TGA3+t8joqmTw0/KdWol78E6nXNq4mAyVorVM0OGfHKYz6zE0dS4jPGAyK
         HvSBEkXHHHVTZJlSTCpNH+j/yG5TUx16ZPVjXsDdh1Lvf5qy0pZNG7ljsqCci5zM5cCd
         PZjA==
X-Gm-Message-State: ACrzQf3N9s5t/H41LqaS+Um5KR6OmrSUXQBXOnOxGzB47KrepBLtzBaG
        6HNSS15usEc2//eJV+yzZypXkA==
X-Google-Smtp-Source: AMsMyM6EZ5sH/GDkOk4kvDNrmXrcm6xvFxNi3qJDwSKxyp3sFIo4IjKKB+ChUJ/BIfBdJeEeiHHDlQ==
X-Received: by 2002:a62:7b0f:0:b0:56b:e472:9e81 with SMTP id w15-20020a627b0f000000b0056be4729e81mr16296269pfc.13.1666821446468;
        Wed, 26 Oct 2022 14:57:26 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id i12-20020a63220c000000b0046270ad651bsm3179016pgi.94.2022.10.26.14.57.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 14:57:26 -0700 (PDT)
Date:   Wed, 26 Oct 2022 21:57:22 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Siddharth Chandrasekaran <sidcha@amazon.de>,
        Yuan Yao <yuan.yao@linux.intel.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v12 34/46] KVM: selftests: Fill in vm->vpages_mapped
 bitmap in virt_map() too
Message-ID: <Y1mtQkW6mcduQqNP@google.com>
References: <20221021153521.1216911-1-vkuznets@redhat.com>
 <20221021153521.1216911-35-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221021153521.1216911-35-vkuznets@redhat.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 21, 2022, Vitaly Kuznetsov wrote:
> Similar to vm_vaddr_alloc(), virt_map() needs to reflect the mapping
> in vm->vpages_mapped.
> 
> While on it, remove unneeded code wraping in vm_vaddr_alloc().

"wrapping", this is dangerously close to getting someone fired ;-)
