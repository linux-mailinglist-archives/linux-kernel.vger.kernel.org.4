Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BA2A60EB24
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 00:00:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233745AbiJZWAD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 18:00:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbiJZV7z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 17:59:55 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0246A222B5
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 14:59:52 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id l22-20020a17090a3f1600b00212fbbcfb78so4176262pjc.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 14:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nR7s6MCaEHlCMlVxMummbX5Q2r2GgdQOaJT5qk5VOZM=;
        b=CqlBImQlgpjUHO0Rx0GwhsgUlHmg4p7+TZLDG7ab2pLnDCf4XoxoBytUinJVpAsGS7
         SGlwn+ELkfhVBLxn/UtORgFKweK0bFONWynDJ0yID6dsF5AxmnEJX7PLOCOdaRVeREci
         3ISpIUyQ7nL2WmBExE4rV2wPgdKHgCc4CLsfL8El4BmGAUEmeB25K7YvHgF+rhSId4L8
         RaijAmPi34k+krFIkTijdPWTsj6FGHdK85wDlx6y7DpR67/O/6jNkwbnM9EMQ/7zeui/
         Ig1gAMZh1qdU46fru5yksFizzP5cP9+Sw8zTySCh9irsWwLkiCX9pU0Krm0bKfefui0c
         dO0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nR7s6MCaEHlCMlVxMummbX5Q2r2GgdQOaJT5qk5VOZM=;
        b=cB22MCc3DXN83OWgJ0dsLPMclKVrzRZeAXTO8LjUnY9nMQ6eI+JRNMzt5AGSNjrYaX
         Uz0EjNbGEQssPCKJg7u6/1dk4tNiE4utWPgh0I0SPU25WCgMYp0cwnWGeCTJT9jeXDhr
         JeSkQhzPYsTmd/zI281j5ixaPfkkRMezcfDpy8RYa7m7bfLwU0GgS3Am5hsZNR1zTokA
         AEKb7Q/hd/5ENuszBLDBiYm+UX94bX8L2BstMmjtQO2By7loMj4YElTOrPYb63oDjz/X
         rlHVPjL2V9tvaHGOjmycBr8ANUTVT7v7I5ujemGfcGCm3zSy77I7uhhKVADL1GPx9nQd
         C7GQ==
X-Gm-Message-State: ACrzQf3Yn5cOGoNCv3iy8L0x0wqtFn/60TFjxVy9jxsm3YZpZro8L13/
        PUVsm5MCpde3uscLVMrPmxIJCg==
X-Google-Smtp-Source: AMsMyM5SQDNPjD7thnUy1UQuQk1M2SqagZHBjw0JQz6NiII0qQZ/kCP/JGKefog2ciVFBuEb60AoWA==
X-Received: by 2002:a17:902:ee8b:b0:186:a226:7207 with SMTP id a11-20020a170902ee8b00b00186a2267207mr18657114pld.49.1666821592090;
        Wed, 26 Oct 2022 14:59:52 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id ik12-20020a170902ab0c00b00186c9d17af2sm2749143plb.17.2022.10.26.14.59.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 14:59:51 -0700 (PDT)
Date:   Wed, 26 Oct 2022 21:59:48 +0000
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
Subject: Re: [PATCH v12 36/46] KVM: selftests: Drop helpers to read/write
 page table entries
Message-ID: <Y1mt1OSfJ8IGp5BU@google.com>
References: <20221021153521.1216911-1-vkuznets@redhat.com>
 <20221021153521.1216911-37-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221021153521.1216911-37-vkuznets@redhat.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 21, 2022, Vitaly Kuznetsov wrote:
> From: Sean Christopherson <seanjc@google.com>
> 
> Drop vm_{g,s}et_page_table_entry() and instead expose the "inner"
> helper (was _vm_get_page_table_entry()) that returns a _pointer_ to the
> PTE, i.e. let tests directly modify PTEs instead of bouncing through
> helpers that just make life difficult.
> 
> Opportunsitically use BIT_ULL() in emulator_error_test, and use the
> MAXPHYADDR define to set the "rogue" GPA bit instead of open coding the
> same value.
> 
> No functional change intended.
> 
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Missing your SOB, though maybe Paolo will merge my series first and make this a
moot point :-)
