Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0E185BEF3A
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 23:36:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbiITVg0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 17:36:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229813AbiITVgY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 17:36:24 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4324B54657
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 14:36:23 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id rt12so1988286pjb.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 14:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=lW8FaOqfKG8NiNj+wZ8OWwsYMviJret5ZI7CXSUxiuQ=;
        b=VYjRqHztHWgV7OTwnLUGrZt37xjYnO9Gf9F4kTN1Wh3gf04CaojIvHTEl+AW0ayEAu
         89+s7OTNvRvIYiqbwPcYbnakRMBtUyxMNyPPafpMcc1ohOV1wR7s3DhRTIUh7q4gAdzT
         FSRVbZFQmeWsfaRFR4D90B0rceTKJc5Tmu1RhC8s2XyySXvI8HN1dKXKXb38Vvs7V5wK
         uSW5drdckG+gjMT2hiwqQzb0aoLphZGIlKlsorE8XpCnPfmokVxW435OF7ScX1kbHafo
         XnzNSkODUiicx2PqOQnVpxz0jc/L7YhfQaQu2N84+7Ty6Rfi/GrJrJsEaINF4B7mq+IM
         ZMNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=lW8FaOqfKG8NiNj+wZ8OWwsYMviJret5ZI7CXSUxiuQ=;
        b=tVZkgTbFU9ASOBjF/fRXrQsCg2+f/cVEs4WcNDi0nBTlKa7Ib3Se4d1ShG0O96PtP9
         wTEGvpII4ZxYaoTdNIxYafnHNmbk+h5MlGZyLywbzzcZWJ7jjj2GhXR3rZff0iehtba/
         l50pTT4V9RUdSFg2kj0QuRnbfZhzVOFBgsG2l9y/5/cVsJ4ot9Vo3Ff9W3cPZdtvifPz
         6FixyKHWbGVSAeuXgYUp6uZHqh9OU+Nt1NDpfqM62snDEN3HMdcGbvQkUK0uY2AmJ5Z7
         JKjMljxbicwC4Nk3HA9WTWIJRfRcqcAsWeNVKYvOPZGENcBxeWNgdCnHVKzHOPl2acU7
         QfKQ==
X-Gm-Message-State: ACrzQf0BN0sa+feRyVLcbbBTaWxWhtOZpj86X8JOzmDzMPPyZM4Pu0+Y
        uO1O9muxc1MDz1LdxOKkLyWuXg==
X-Google-Smtp-Source: AMsMyM5KIlE6akR3/LS3Cv/vtp9FYDBTu+R4aKr9iGDjlkkigm/+Tpoa9URwIn8FbClTdnjQD1CMfw==
X-Received: by 2002:a17:90a:ce8a:b0:203:7b48:dcdf with SMTP id g10-20020a17090ace8a00b002037b48dcdfmr6118848pju.12.1663709782560;
        Tue, 20 Sep 2022 14:36:22 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id 4-20020a170902c10400b00168dadc7354sm381057pli.78.2022.09.20.14.36.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Sep 2022 14:36:22 -0700 (PDT)
Date:   Tue, 20 Sep 2022 21:36:18 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Jim Mattson <jmattson@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH v2 0/3] KVM: EFER.LMSLE cleanup
Message-ID: <YyoyUp8QAcyrcq01@google.com>
References: <20220920205922.1564814-1-jmattson@google.com>
 <Yyot34LGkFR2/j5f@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yyot34LGkFR2/j5f@zn.tnic>
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

On Tue, Sep 20, 2022, Borislav Petkov wrote:
> On Tue, Sep 20, 2022 at 01:59:19PM -0700, Jim Mattson wrote:
> > Jim Mattson (3):
> >   Revert "KVM: SVM: Allow EFER.LMSLE to be set with nested svm"
> >   x86/cpufeatures: Introduce X86_FEATURE_NO_LMSLE
> >   KVM: SVM: Unconditionally enumerate EferLmsleUnsupported
> 
> Why do you need those two if you revert the hack? After the revert,
> anything that tries to set LMSLE should get a #GP anyway, no?

Yes, but ideally KVM would explicitly tell the guest "you don't have LMSLE".
Probably a moot point, but at the same time I don't see a reason not to be
explicit.
