Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B58AB610603
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 00:55:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235465AbiJ0WzL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 18:55:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234947AbiJ0WzH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 18:55:07 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78BC16687C
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 15:54:57 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id c15-20020a17090a1d0f00b0021365864446so2900329pjd.4
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 15:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SqwgVQZrZUOPGCiOP1E8r7GyYT54IzHA4/wQSu9imzU=;
        b=dAgnHky8fBV9dfZplRCyg9mPbzzLEW96lJydXmBspGcabsqRKKFRDitHDlswpGAQaq
         YxxhCuJ1zxsOQt2xWdsFVNwWjV1fieZjVTO9so4nRj9uh1TAN+FwPMJGuWLwh6GWyTop
         0wZiEDTbB4ZALndEZayZtG4PXqlJGKzria0OL92rfdS8m4L7Zpr9laIMQslZXmq9Wmil
         D4HQVh6QhdWvKIFhDIX4hkHHWP1YCvvIKJnZEsjan4I2lv05En9tBCb8IWRbjUfsZQko
         YC8GhUYbj950fDRZjuKQ5gO69TFemAIISJzT+UDNLIp2WjA+Hwpo/V+ck/BWBgB/iSht
         pnTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SqwgVQZrZUOPGCiOP1E8r7GyYT54IzHA4/wQSu9imzU=;
        b=av6F13DK/Q+prK8u5MjxgboEtN103q1puyEWa2qzLbjn8RDzlJvXReCh+KsxbB7fiB
         SEmy1D2/8JBxk7wzU5IavWQ20RvIjF5zPG3n7yngtvFLbkD3y4I/xK/oF03xR1IZNsKG
         gRd1cZTMDaGfYvp8aIlShQdLfYmEYWrnNNO6Bb3RzakTVTi0n3oGBSpN1/ccrlLo1ruo
         9KV4K20CfMjb1XN2KziaqaU1Ep0dKVzgPXkI+Lric/0Gd70taC6fbqQhJlAGqIgESZvH
         w88VGUOIiAFOtLIgwFf9D15JieMXoNPBa48iuzm9mTynmpwtsMynqI1nKOlhQ7kCMC87
         uxbQ==
X-Gm-Message-State: ACrzQf1Ln9WNc86MFJpwxVv7ePp6GCk4vXzq1PkPnSkZckWMZws6GW0C
        +XmCdwxsNuVdS/lDCj1bI8fdtQ==
X-Google-Smtp-Source: AMsMyM562TQTUWbVA62QyB9jvEsewPE++Q0y2tf+d9dzvU8/8Ka/IQcQJy9/4l9DfZdJng4UIlxERQ==
X-Received: by 2002:a17:902:b210:b0:17d:c3ca:4a4f with SMTP id t16-20020a170902b21000b0017dc3ca4a4fmr50441906plr.33.1666911296617;
        Thu, 27 Oct 2022 15:54:56 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id i7-20020a17090332c700b001867851536dsm1684566plr.236.2022.10.27.15.54.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Oct 2022 15:54:56 -0700 (PDT)
Date:   Thu, 27 Oct 2022 22:54:52 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Rong Tao <rtoax@foxmail.com>
Cc:     Rong Tao <rongtao@cestc.cn>, Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kvm: vmenter: Use tabs instead of spaces for indentation
Message-ID: <Y1sMPJvZDj6hGvih@google.com>
References: <tencent_768ACEEBE1E803E29F4191906956D065B806@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_768ACEEBE1E803E29F4191906956D065B806@qq.com>
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

"KVM: VMX:" for the shortlog.

On Fri, Oct 21, 2022, Rong Tao wrote:
> From: Rong Tao <rongtao@cestc.cn>
> 
> Code indentation should use tabs where possible and miss a '*'.
> 
> Signed-off-by: Rong Tao <rongtao@cestc.cn>
> ---

Reviewed-by: Sean Christopherson <seanjc@google.com>
