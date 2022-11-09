Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C70E0622EFF
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 16:25:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232047AbiKIPZv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 10:25:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232033AbiKIPZt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 10:25:49 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE3BA2DDB
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 07:25:48 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id u8-20020a17090a5e4800b002106dcdd4a0so2174978pji.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Nov 2022 07:25:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Rp+1lx+FWBGvp1Xrs2hIQiVvxWYkY1FvZMZLEL/FwE0=;
        b=Y77a3zKqdZRf7diXlm3O31pEh/kZgqy7eVWwCKzcuLgQaUuxn5a/pfJYYQS6utyaca
         ppF5vk+V0PwQXTGyqOrdz6ANLgpN2BWwQrBnSoPKYm5GcdNvlkmaWWDab2X/6c+h5Hp8
         IbLz/mRLkeDPKrZbp5LBXTnXcoHhpgZNbet8PC+mddfGgQI9P0dQFnZoRt0Fs4nYDx/t
         QLV0MhuE9WUW86WUmubRN5CCAiVGMKqqg0s5+AbeCg1DXc22KSxrorUvsn3l8Mc9AS6x
         Gk/PDQST2Zu9aSkOktE1QtS0A1vrRg/e3Sj06h0nkhgLdUm4qX9vdq7XQB/47ZV+2RgS
         dYxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rp+1lx+FWBGvp1Xrs2hIQiVvxWYkY1FvZMZLEL/FwE0=;
        b=CJmT2JvJBjNLLF+SH+xdExyH62Ons4OlByv2RIxKyXccMKqjWrJQTFyjewG/N6tBhD
         7c6kmRxZAcS/dIRYKTv09jg1FV5MZd+WgASgI5eZSc4vrd8ONp7Ic/BsiP6+YPM3APii
         cxPH6bEkSOfn6i7X1Hw2cDaayXYS7yYiWOz9pcSSMUXYsHkru+99Aptxm24QMalyTCky
         iZkLAdUoX4Fb8V8z/dgWW0SU/Yp1uF4Svbvpws9onv9iz+8CNMjyTL1gH1PiRc6aJdj0
         ArqxMMz37HebjRkqN6hTYuv8eagwk17/PqdHbmqEKvusqnrKc4Vo9Yld5Gx4QX8tG15R
         Ydjg==
X-Gm-Message-State: ACrzQf3ciji3k500rCAF82WFhKxfR9EWmChjudmb6VcFDyr1wRTHrLia
        jet2pOLUKzKz//0A1rNtO29KGg==
X-Google-Smtp-Source: AMsMyM55pKnPSGRFYNOdBqVC54AssWJl/EMz1je0gdCgBf7K1JU4s7TVylkYFnjJ0F0AxtmfZ7jFYA==
X-Received: by 2002:a17:902:8345:b0:188:5dbc:5c9b with SMTP id z5-20020a170902834500b001885dbc5c9bmr32424205pln.118.1668007548142;
        Wed, 09 Nov 2022 07:25:48 -0800 (PST)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id q17-20020aa79611000000b00565c860bf83sm8453738pfg.150.2022.11.09.07.25.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 07:25:47 -0800 (PST)
Date:   Wed, 9 Nov 2022 15:25:44 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        thomas.lendacky@amd.com, jmattson@google.com,
        stable@vger.kernel.org
Subject: Re: [PATCH 04/11] KVM: SVM: retrieve VMCB from assembly
Message-ID: <Y2vGeFbOI8h/WiUV@google.com>
References: <20221109145156.84714-1-pbonzini@redhat.com>
 <20221109145156.84714-5-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221109145156.84714-5-pbonzini@redhat.com>
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

On Wed, Nov 09, 2022, Paolo Bonzini wrote:
> Continue moving all accesses to struct vcpu_svm directly in vmenter.S.
> This limits the confusion due to different registers used for
> argument passing in 32- and 64-bit ABIs.
> 
> It is not strictly necessary for __svm_sev_es_vcpu_run, but staying

It's not strictly necessary at all ;-)

__svm_sev_es_vcpu_run()

> consistent is a good idea since it makes __svm_sev_es_vcpu_run a

__svm_sev_es_vcpu_run()

> stripped version of _svm_vcpu_run.

Missed an underscore.  And parantheses.

> No functional change intended.
> 
> Cc: stable@vger.kernel.org
> Fixes: a149180fbcf3 ("x86: Add magic AMD return-thunk")
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---

Reviewed-by: Sean Christopherson <seanjc@google.com>
