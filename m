Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19FA6623784
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 00:34:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbiKIXei (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 18:34:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231544AbiKIXe0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 18:34:26 -0500
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DC1D13FBE
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 15:34:25 -0800 (PST)
Received: by mail-ot1-x330.google.com with SMTP id br15-20020a056830390f00b0061c9d73b8bdso262936otb.6
        for <linux-kernel@vger.kernel.org>; Wed, 09 Nov 2022 15:34:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sWbjRDR7oEfTFipQemNFQRb8BL0viMnAylQw4SRSH5I=;
        b=7ojs9K9EuWYPxw5quIjTs4on2c9ylenKWtN6r/s2Wqkx56dsAnmF/LCwOGLhEfwstN
         xuPtTSyT2rfM8/e+MDbe+b/dJi63f8QjxBwI5w5ILMeztHqSkBs34zEvBJcXRFVMVpYZ
         EgoS8RV6bZ715KKBRo2zWawX5eUx9/ONXst7eXricfQLP4KXGb1NA201bRXlYGAJw//u
         n+NQeQ3LRgjIezLRvfdS22j9ofAlVhtckEM5uKulw2L4z+eEhC5Srf5sz143Lzfs7zZQ
         jttqTEZecftkrvGEnGxBhE/CABkq9OEYjsnecgH6TfnRIZn47WJMPEjxCZv/4GxMQwiq
         ttSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sWbjRDR7oEfTFipQemNFQRb8BL0viMnAylQw4SRSH5I=;
        b=M07rWMeqdrOS3/Y63pNU5SoqCakp4SS6rCgp+M8yjN9ww+WB0iPp3tBuu1AH1tpfgP
         91txMWMyAM/j2xdtNDakUvUeIs2+vzmCl8xeh1wkO9zUK7yaByyQXQIhlfXIO3HWsBzt
         WZtT9tLW/StYGcl2UVVXFTZkcGuFvTwN+x7ajXr5BkeYoJ3NvE7/vS8HjANR/qSPmCI0
         d/9JJiG6Hq7D8tcJbtWd7EkscYMYEuXq3AKK8ODBUEzFPMYOpQTBk6/4h4j2PfG3pbbQ
         +og16e7qgNoq5+nHCumfXcGIW6NhnBhlXRLbyS2A258i0TW3mV9vYiAvgVS9XH0VC6tB
         vvDA==
X-Gm-Message-State: ACrzQf2V9Xfz1Cj++v9ju8jod7hGAG3CKxzomGcIcg0LRXGCmSZnkcxu
        nYmOcbb51SJTSQrl6JA1rFxzFQqVCcOP5x/TvE2qcXnNxg==
X-Google-Smtp-Source: AMsMyM6EYxXXLjYag46U/qRTjGODzHhgNYuenbATBWMFT4HBwhpOqAzYqwjgoyxzBTRIst+9dQ4yGQPsJ1j8jnyqcT4=
X-Received: by 2002:a9d:7f84:0:b0:66c:53ef:e555 with SMTP id
 t4-20020a9d7f84000000b0066c53efe555mr25368433otp.34.1668036864745; Wed, 09
 Nov 2022 15:34:24 -0800 (PST)
MIME-Version: 1.0
References: <20221025184519.13231-1-casey@schaufler-ca.com>
 <20221025184519.13231-5-casey@schaufler-ca.com> <Y1jNGMKfb+NUPrJS@kroah.com> <e3949b66-26fe-807e-a626-79ca78396e8a@schaufler-ca.com>
In-Reply-To: <e3949b66-26fe-807e-a626-79ca78396e8a@schaufler-ca.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 9 Nov 2022 18:34:14 -0500
Message-ID: <CAHC9VhQzP0Fz4O9dJLy2hQrMK-2gDjEDBsJw=-2Fvr9jiva1Hg@mail.gmail.com>
Subject: Re: [PATCH v1 4/8] LSM: Maintain a table of LSM attribute data
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-audit@redhat.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 26, 2022 at 8:38 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
> On 10/25/2022 11:00 PM, Greg KH wrote:
> > On Tue, Oct 25, 2022 at 11:45:15AM -0700, Casey Schaufler wrote:
> >> As LSMs are registered add their lsm_id pointers to a table.
> >> This will be used later for attribute reporting.
> >>
> >> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> >> ---
> >>  include/linux/security.h | 17 +++++++++++++++++
> >>  security/security.c      | 18 ++++++++++++++++++
> >>  2 files changed, 35 insertions(+)
> >>
> >> diff --git a/include/linux/security.h b/include/linux/security.h
> >> index ca1b7109c0db..e1678594d983 100644
> >> --- a/include/linux/security.h
> >> +++ b/include/linux/security.h
> >> @@ -138,6 +138,23 @@ enum lockdown_reason {
> >>
> >>  extern const char *const lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX+1];
> >>
> >> +#define LSMID_ENTRIES ( \
> >> +    1 + /* capabilities */ \
> > No #define for capabilities?
>
> Nope. There isn't one. CONFIG_SECURITY takes care of it.

I guess we might as well use the existing pattern just in case this
header ever gets pulled into somewhere unexpected.

  (IS_ENABLED(CONFIG_SECURITY) ? 1 : 0) + ...

--
paul-moore.com
