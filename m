Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2E4B67DC2C
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 03:09:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232939AbjA0CJf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 21:09:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232959AbjA0CJa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 21:09:30 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B09220D12
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 18:09:25 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id 5so3638422plo.3
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 18:09:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sZWjoy5ITWduM3HQPZ6ehf+xisI9RMToBBdRYssmoV8=;
        b=XKGVkYb13CxNZM7SaAKdglWy4rp4mdw9zerMpl2cilYjOkfPjf50MVJIPin69EcMEC
         cwmglXZCmjdfigdBcdeuINhM5MMeBys5vJB3UnhZK0LDJ5XYwY2k8+FQWikXEQR0DOCC
         VOuj+9u7py3TJPEMXANp2mLTRh2oBfVvhuPF4oMhLZp2tMOsfTVfeEtzojfOZ65g+J1y
         gq+yRc+Vka3tPf7PMmcoCHBK8pQmPmb4CsuBw7vznCjGvLyaXX6puv807Bgsxu8EPRUH
         0LsAvP/jAv+dHqufpjXf19/flMtJ8n7ObcwJR5s5Td12ZS2orqZUIUht6CYDLgUvJVr3
         maTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sZWjoy5ITWduM3HQPZ6ehf+xisI9RMToBBdRYssmoV8=;
        b=AM1/uiXTpfF4jhSdYWz7G0EHYMDA4VJLrp0s95YBDL2SHAvo2Tl7FID0kD5UCn1U2o
         vjJ3FGrcYEpPxZqXq8zGdHYULukWN43gVBVoxquSQVsEXQBacUsHRjhJpKQrKAu0Yupw
         S/wN6/GDYU5DUMpfh28V862apkvFx23dg4tz/ozY/MoyMG+LNnmEp5iI8/Hr0E2gS2kl
         zTj0cZfDe3voSGbV1ntenMl0GJBgk2irZLAwSpuH9yiz2j0kYu/KXntlsSjQ4hyY2FMJ
         YeF4Gg8JSl2Br0KElD/ZPSIwl1lGrlScNMnUreS5NEUisavnu1h9gpu/Lh/76F9I90ml
         nRrQ==
X-Gm-Message-State: AO0yUKXMFvppAlINxc0DrNL9hc1Ktx0vtaMxkckxzywHcTQkmJHP96tj
        xkZa6wGxsCadc13u0JtCXwPa0A==
X-Google-Smtp-Source: AK7set+HJAFTEeH9uMJcKCtLAA9S8UYbohXeK9A8lVz8w0XDyLOrm+OyTtCOQrwpmNaOSiRLNCVbZA==
X-Received: by 2002:a17:902:f550:b0:191:1543:6b2f with SMTP id h16-20020a170902f55000b0019115436b2fmr1176430plf.3.1674785364947;
        Thu, 26 Jan 2023 18:09:24 -0800 (PST)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id 19-20020a170902c11300b0018911ae9dfasm1613111pli.232.2023.01.26.18.09.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jan 2023 18:09:24 -0800 (PST)
Date:   Fri, 27 Jan 2023 02:09:20 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Like Xu <like.xu.linux@gmail.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/8] KVM: VMX: Refactor intel_pmu_set_msr() to align
 with other set_msr() helpers
Message-ID: <Y9MyUHhIRtImjoyd@google.com>
References: <20221111102645.82001-1-likexu@tencent.com>
 <20221111102645.82001-3-likexu@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221111102645.82001-3-likexu@tencent.com>
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

On Fri, Nov 11, 2022, Like Xu wrote:
> From: Sean Christopherson <seanjc@google.com>
> 
> Invert the flows in intel_pmu_set_msr()'s case statements so that they
> follow the kernel's preferred style of:
> 
> 	if (<not valid>)
> 		return <error>
> 
> 	<commit change>
> 	return <success>
> 
> which is also the style used by every other set_msr() helper (except
> AMD's PMU variant, which doesn't use a switch statement).
> 
> Opportunstically move the "val == current" checks below the validity
> checks.  Except for the one-off case for MSR_P6_EVNTSEL2, the reserved
> bit checks are extremely cheap, and the guest is unlikely to frequently
> write the current value, i.e. avoiding the reserved bit checks doesn't
> add much (any?) value.
> 
> No functional change intended.
> 
> Signed-off-by: Sean Christopherson <seanjc@google.com>

FYI, I'm going to post this separately and extend it to give the get_msr() flow
the same treatment.  I'll plan on getting it queued sooner than later so that
this series can use it as a base.
