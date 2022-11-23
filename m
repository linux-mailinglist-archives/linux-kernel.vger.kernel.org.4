Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 921BB636791
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 18:48:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238932AbiKWRsV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 12:48:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236541AbiKWRsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 12:48:17 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4EA65BD4C
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 09:48:15 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id ci10so10284456pjb.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 09:48:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YzrL02JdEOvJNF7Jtm6mOFZtcnU8RnnoI7dq0vaKkEU=;
        b=q1TRSyGvqBioq3tfh3//gpbNDNamy468ziIjM+NNotYgTNywXifLRDACuuBgcbviSt
         mOc4dSkVQTg43f2eBUHNotAE5Yq9dd1TDCEoreLEAyzJyviwYISFJdelynuJyUTYOQPF
         qs6cei0wbTDTaiNggmsYjyCXlRxoywP+pZ/aHeg+CCxTkZciu9wz5pSVW+5G1Wvi2WI+
         S0h3UxSJyIOw/G+BVuQYiFu90inrUGL8n7jth1J6BTFJbo3YKHzZ0XpoJ8ncGMLtJCes
         xb0eelzMTkupcpucjGAJhiaE1wbFBvicACfsCG6tEXiF6XP7pCk66cHdbO/C5VqeLT6a
         TpNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YzrL02JdEOvJNF7Jtm6mOFZtcnU8RnnoI7dq0vaKkEU=;
        b=xMdrwTpPIB63YKNmzv/Tfkxe4IYIQUd8g0UDnT2vk8j7OsZywQWPCceDPportXl7L6
         mgCc+T6uVmhyCb1M4z3JA3H+SMErar9wnY2ZLDNHK49t0fG0m3j1pSS/e58XLDSGoo+n
         cgkcGmJxnaO6pdrH/6D7OQZUzCcn4J/cbfoUDtbTrryKFC5gcMzwXzpDGEZrA+IzOkL4
         0vtm5MMdt1SPl9D05OIKvKPbVs5TmNlGhBXiPLBwNCYe8JCPuq3dDugZIvOMUoAVnI51
         Lp5yWNravHyVWBIJYlCKRjDOr4BujYUn8658xCZ+7AvmyO2MW4JOLBmj0ahrzlZ1TDVG
         KQ+g==
X-Gm-Message-State: ANoB5pkThylXWkUoPjHGHUVAqrgf6R9B9dVGkJuGbOH/7wIOuqRyhbAE
        Vb90fG22OVuBf1CYMTmnY0blHw==
X-Google-Smtp-Source: AA0mqf5owaqykZA0kUarbc6tzXu+YrAUpt94JD9fda07SKqPgLJRkCzpQ+fUQZWZYQyYpEnO2NvbgQ==
X-Received: by 2002:a17:90b:1987:b0:218:d339:1b85 with SMTP id mv7-20020a17090b198700b00218d3391b85mr7792609pjb.122.1669225695255;
        Wed, 23 Nov 2022 09:48:15 -0800 (PST)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id h19-20020a656393000000b0044ed37dbca8sm11169615pgv.2.2022.11.23.09.48.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 09:48:14 -0800 (PST)
Date:   Wed, 23 Nov 2022 17:48:11 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     David Woodhouse <dwmw2@infradead.org>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paul Durrant <paul@xen.org>
Subject: Re: [PATCH] KVM: x86/xen: Make number of event channels defines less
 magical
Message-ID: <Y35c21N1fVI2+FZD@google.com>
References: <20221114181632.3279119-1-seanjc@google.com>
 <629d6d90ce95b9db74f0101a4428be1119c4bfc7.camel@infradead.org>
 <Y3KZVUCCH+YQDbqu@google.com>
 <fde14caa0cf774b2b46f1124644a3b326a0a8f09.camel@infradead.org>
 <Y30xm/y2CKPchObi@google.com>
 <9d0e54e248c740eb52bcaa63764afb99a4dfcde9.camel@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9d0e54e248c740eb52bcaa63764afb99a4dfcde9.camel@infradead.org>
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

On Tue, Nov 22, 2022, David Woodhouse wrote:
> On Tue, 2022-11-22 at 20:31 +0000, Sean Christopherson wrote:
> How's something like this? I did start typing that comment in the
> max_evtchn_port() function in xen.c but moved it over.
> 
> Still not utterly convinced, as it's still somewhat circular — we now
> define NR_CHANNELS as (32*32) with a big comment explaining *why* that
> is, and the reason is basically "because that's the number of bits in
> an array of uint32_t[32]".

Agreed, probably not an improvement across the board.  Consistency with how the
non-compat code declares the fields is also valuable, so unless someone changes
upstream Xen code, let's just leave things as-is.
