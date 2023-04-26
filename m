Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28D1F6EFB60
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 21:54:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233680AbjDZTx7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 15:53:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233643AbjDZTx5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 15:53:57 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCB6919B7
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 12:53:54 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id 98e67ed59e1d1-2473f8329f7so7055433a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 12:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682538834; x=1685130834;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=UcyBowT/7snrKRgrt26A0bjGirGSsCbvk5IYXN32HYY=;
        b=CuidvLgO7z5aVRbyi2cxF8vMwPPNTmcByG3DJ8NEOcVe3pCT0eXWZCsKQGraTkbjGb
         4hbjD82vdnbjArnYR0vPXmtn/K2NYzEIa6GZk3RYRZcQ86pEsJEOILpvt0zH+DdIh86M
         ffZ931f+gaGp84zpzHvRMCo3GvNBJkjL+UCbYgWEmDmR7lYZ+8mTq1o6ejVruQisWeC9
         lRVgdjaN7rDBJhYqvaod9OTfpzYSt3rTCMpPj1f8ZXA0CQIkcinSLPYutZ8SgksXJbS5
         TllB/S+PKzuHiyv/7x/yV/hviGV1R0FcgfZ0iJ3AFMVJ/2sK/o88ygPxT19/fSVM6uxR
         bwjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682538834; x=1685130834;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UcyBowT/7snrKRgrt26A0bjGirGSsCbvk5IYXN32HYY=;
        b=EoUM0m4m6dN9p4bccx7q5Uf72cygPwBwJjNxcEDWKJCjdoDodpU7gmvrbHWA1Bd6Q7
         z6JJpHsvRcdJYaJSXdjxUlpx8qw0UO9Ak8yB6lCFRd2o+0X8mRFIFNzDWg6Mqd1oyEdw
         yxlH6Lc35cGbq+e7rcTe6UBUdNYXWOF1yTGGFkSFpQ+2kQQ1u4uLTVYuNXr1e+2XwuIA
         eYaL7okgbEhefmKLkf0gPIp5yqhewwDeQmtkddp/F4HUWVppKzkgonBdUKtWnvl3yLQj
         UV1Rp6GQ+XVknbrx22mbqUOiK/MEOiDiNWfUtFPuGNyve8BdQjDd0HLTN/P/LXRticRU
         GYcA==
X-Gm-Message-State: AC+VfDyOiKfJOxe2O5OoIR7/B8SOGVOyohgot8VZ9UbNdhuAZE9LDe40
        Do/7sqnWyOIR3fQsHLFF8msKZIrxrMM=
X-Google-Smtp-Source: ACHHUZ7RI4MX7FcPrIeTC5Ho80NQDYQuerP8eAeDqvdf0/r1i6zP/B09U0lrSgLPqQyKFDHUPKT0f/XOgrU=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90a:2c82:b0:24b:dbeb:d3b4 with SMTP id
 n2-20020a17090a2c8200b0024bdbebd3b4mr1869198pjd.0.1682538834276; Wed, 26 Apr
 2023 12:53:54 -0700 (PDT)
Date:   Wed, 26 Apr 2023 12:53:52 -0700
In-Reply-To: <9021d861-cde6-a51a-7d8c-b3f67eaa01d8@amd.com>
Mime-Version: 1.0
References: <20230327141816.2648615-1-carlos.bilbao@amd.com>
 <ZEfrjtgGgm1lpadq@google.com> <DM8PR11MB575046B6DAA17B41FFED8080E7659@DM8PR11MB5750.namprd11.prod.outlook.com>
 <9fa5ce43-584d-878d-227a-fb458254c00a@amd.com> <ZElIjw7Ca6N2mYHe@google.com> <9021d861-cde6-a51a-7d8c-b3f67eaa01d8@amd.com>
Message-ID: <ZEmBULXp24oMxaUH@google.com>
Subject: Re: [PATCH] docs: security: Confidential computing intro and threat model
From:   Sean Christopherson <seanjc@google.com>
To:     Carlos Bilbao <carlos.bilbao@amd.com>
Cc:     Elena Reshetova <elena.reshetova@intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ardb@kernel.org" <ardb@kernel.org>,
        "kraxel@redhat.com" <kraxel@redhat.com>,
        "dovmurik@linux.ibm.com" <dovmurik@linux.ibm.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "Dhaval.Giani@amd.com" <Dhaval.Giani@amd.com>,
        "michael.day@amd.com" <michael.day@amd.com>,
        "pavankumar.paluri@amd.com" <pavankumar.paluri@amd.com>,
        "David.Kaplan@amd.com" <David.Kaplan@amd.com>,
        "Reshma.Lal@amd.com" <Reshma.Lal@amd.com>,
        "Jeremy.Powell@amd.com" <Jeremy.Powell@amd.com>,
        "sathyanarayanan.kuppuswamy@linux.intel.com" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "dgilbert@redhat.com" <dgilbert@redhat.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "dinechin@redhat.com" <dinechin@redhat.com>,
        "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
        "berrange@redhat.com" <berrange@redhat.com>,
        "mst@redhat.com" <mst@redhat.com>, "tytso@mit.edu" <tytso@mit.edu>,
        "jikos@kernel.org" <jikos@kernel.org>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "leon@kernel.org" <leon@kernel.org>,
        "richard.weinberger@gmail.com" <richard.weinberger@gmail.com>,
        "lukas@wunner.de" <lukas@wunner.de>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "cdupontd@redhat.com" <cdupontd@redhat.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "sameo@rivosinc.com" <sameo@rivosinc.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "security@kernel.org" <security@kernel.org>,
        Andrew Bresticker <abrestic@rivosinc.com>,
        Rajnesh Kanwal <rkanwal@rivosinc.com>,
        Dylan Reid <dylan@rivosinc.com>,
        Ravi Sahita <ravi@rivosinc.com>
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 26, 2023, Carlos Bilbao wrote:
> On 4/26/23 10:51 AM, Sean Christopherson wrote:
> > This document is named confidential-computing.rst, not tdx-and-snp.rst.  Not
> > explicitly mentioning SEV doesn't magically warp reality to make descriptions like
> > this one from security/secrets/coco.rst disappear:
> > 
> >   Introduction                                                                    
> >   ============                                                                    
> >                                                                                 
> >   Confidential Computing (coco) hardware such as AMD SEV (Secure Encrypted        
> >   Virtualization) allows guest owners to inject secrets into the VMs              
> >   memory without the host/hypervisor being able to read them.
> > 
> > My complaint about this document being too Intel/AMD centric isn't that it doesn't
> > mention other implementations, it's that the doc describes CoCo purely from the
> > narrow viewpoint of Intel TDX and AMD SNP, and to be blunt, reads like a press
> > release and not an objective overview of CoCo.
> 
> Be specific about the parts of the document that you feel are too
> AMD/Intel centric, and we will correct them.

The whole thing?  There aren't specific parts that are too SNP/TDX centric, the
entire tone and approach of the document is wrong.  As I responded to Dave, I
would feel differently if the document were named tdx-and-snp-threat-model.rst,
but this patch proposes a generic confidential-computing.rst and presents the
SNP+TDX confidential VM use case as if it's the *only* confidential computing use
case.
