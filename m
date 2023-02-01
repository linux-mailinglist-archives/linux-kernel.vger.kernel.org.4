Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70747686F7E
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 21:02:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231463AbjBAUCk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 15:02:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbjBAUCi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 15:02:38 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90CA7BB8D
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 12:02:37 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id d3so19551331plr.10
        for <linux-kernel@vger.kernel.org>; Wed, 01 Feb 2023 12:02:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Kr9wNeu+9zMbp947lD+6b8hMxHEqrpimcBPK+zq5B9E=;
        b=ds4dsJWeCOK3T39vv1XbULKGx6HG5Ep+PbmOPBoO0z+GGkBSAyfBygba3hsDBWQBW8
         1fXRwcSWseSYWToOsjvojXvvxi7WvPIUEYNfF7sgHZ0Zd66Zm86zWJtX0UQjqRBNDC/P
         ZFl+i4PLgGcdMUqrNRSZ9slRmlbSWUoBsIkTyMibCdPIkN7hC8MoMuLa5QBr9MlmCG0o
         sZSYLrYAs6IBHhPe11DdCe1xiJxCp8QZ2iqcOevgjBtWPlwb8BpnVRUGvfc9fFPXgWz7
         n2/swEO7KPlADIC8Bzrt8Dv/jgi+DeUbji7rLTBgftH2U5d5iyEuXBYJmi2bqb9UvRmI
         7//g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kr9wNeu+9zMbp947lD+6b8hMxHEqrpimcBPK+zq5B9E=;
        b=pqO1Lu/TfGGOWltiopLQKYciSfGxLnVXQ3Kp/AUEDerNjW55TlMmrae9WiQirHurKx
         JlFlWtLfAEjRhmxybger6lqCMTQ3/oH00OVtMohF1dA95r5uOj+VzM/rbKlnFzykwhIv
         g7pp9TRVY1JazNpAqTZBgqQRq5ggfr6GltDdYV28Aj6VvpZsx9e8EPQiSI2OEbSm8ktJ
         QHK5IAhzxMPSZItiZ7fc3kPXsxABGtzPHb/8ojawRSbIowEP8r3MARX8UP++rTeOoKXx
         UDXmpMw3oZgeEYJeRPG/Xx640PuTNaJbkiRm4DDBBLy7OTTxDILXRpzfNJf9zTlpoFUE
         H5Yw==
X-Gm-Message-State: AO0yUKWsd88AlvOiMLhcpImLPhrJRifLsd0G3SKVxa8TQGPgww8qoADW
        3PhpxI3MFuVpTRHwTEhIny7ixw==
X-Google-Smtp-Source: AK7set8nnzc5/5usrRzjiFXV3Nb3vuTPy73aG7xAyJCvFYhiMXCSq529FDxGIZ8+qoZ75tX62xFO9A==
X-Received: by 2002:a17:902:f549:b0:198:af4f:de07 with SMTP id h9-20020a170902f54900b00198af4fde07mr71711plf.7.1675281756943;
        Wed, 01 Feb 2023 12:02:36 -0800 (PST)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id 138-20020a621790000000b0059312530b54sm9734999pfx.180.2023.02.01.12.02.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 12:02:36 -0800 (PST)
Date:   Wed, 1 Feb 2023 20:02:32 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Ben Gardon <bgardon@google.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Peter Xu <peterx@redhat.com>,
        David Matlack <dmatlack@google.com>,
        Vipin Sharma <vipinsh@google.com>,
        Nagareddy Reddy <nspreddy@google.com>
Subject: Re: [RFC 00/14] KVM: x86/MMU: Formalize the Shadow MMU
Message-ID: <Y9rFWP7b/j25IjtZ@google.com>
References: <20221221222418.3307832-1-bgardon@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221221222418.3307832-1-bgardon@google.com>
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

On Wed, Dec 21, 2022, Ben Gardon wrote:
> This series builds on 9352e7470a1b4edd2fa9d235420ecc7bc3971bdc.

Before you send the next version, can you tweak your workflow to generate the
base commit via `git format-patch --base`?  That makes it much easier for humans
and scripts to find the base commit, and saves you from having to remember to
manually specify the base.  Because of the code movement, applying this series
without the precise base is an exercise in frustration.

E.g. my workflow does

	git format-patch --base=HEAD~$nr <more crud>

where $nr is the number of patches to generate.  There's also an "auto" option,
but IIRC that only works if you have the upstream pointing at the base, e.g. it
falls apart if upstream points at your own remote "backup" repo.
