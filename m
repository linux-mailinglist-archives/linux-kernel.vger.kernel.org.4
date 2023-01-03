Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B0F365C3F5
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 17:34:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238107AbjACQdr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 11:33:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237968AbjACQdp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 11:33:45 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E96D2FF0
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 08:33:43 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id d9so16377477pll.9
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jan 2023 08:33:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nxAHMDQT/P2eg+f7Cm5OGuXZMkCMjC71997rJ4P3nT8=;
        b=NkkpWvLiGCWwEWtdFNgZMlLl6SuN6b1fOfrXz8Nft9/sSVPGeXt+egW2lrlO7blYAg
         KLXLCg/6j8/ugTdMcQ1WIKO335jkmhkWbSsGLb53x9n3725BXF1D5jcyUSB2QkObhWq1
         kGzsnUhfbjNZMuV5XSdlgIPUT5zfSyh990yw+Dkvnz7acOn4H2NxEX4est65WKbZ+8Tj
         H3+7T/V/uyUgknQpN+XJpN3kDPXECHcDSdej9NjONYpdmfO0bhgjD9JcFY/5mtMe2C9z
         EWoi4D+uF/IEcbQ3EFhtIv+XZeXTHcS9WmQkA7UctFMfBktqDYT4d4YNmREZeXf2Pt/o
         2rjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nxAHMDQT/P2eg+f7Cm5OGuXZMkCMjC71997rJ4P3nT8=;
        b=yE/BRslhFy4mSGOl72sARFS/4yVNslPATiebbMoqN4rgQPsVjMw8wOLZqH3aNkc0ZO
         4wBXNqZxgOOjDIRTtqAeJZJSUCUmOg7eyAysWd9Mff0cOam0fRLyQT1S08TQF9hN6ILj
         aOah1HiF7hOFdXySj94njUNzbh8f41gRD7BbZmMY8MG7BDuxVubfvVRWNpHSxNKEvNeM
         MSEwtP6Qz4vL3nyjN1o+ejofS69jIgcg6D1SjlWTqyFv6BpJ3CQ0zu/prrRjnFTxdgt9
         VBqT9A98ryhK//w3zk1vycaFjSsgpM3eBRAmVCYzjmzTyJ2gosKJ3sjaydS4aydR7rue
         n+Hw==
X-Gm-Message-State: AFqh2kqy/dhhg7Y07EM2EHRRSUdE6zGjaK9oV4aDOJwCWCTaoyDnQx8W
        cnpUw2DphW2kQH8Fqron3/P+PCLNFIQIFoAs
X-Google-Smtp-Source: AMrXdXtMAYqeKr1lWN9L/imh2jf7Tiyl9w4Jhh7cwxN2tPn/dWssQQX9/CX/Lljkv8ISXvvPHPlMhA==
X-Received: by 2002:a17:902:eb0a:b0:192:6bff:734 with SMTP id l10-20020a170902eb0a00b001926bff0734mr2428937plb.2.1672763623335;
        Tue, 03 Jan 2023 08:33:43 -0800 (PST)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id s4-20020a170902ea0400b00192850277fcsm16271457plg.146.2023.01.03.08.33.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jan 2023 08:33:42 -0800 (PST)
Date:   Tue, 3 Jan 2023 16:33:39 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     "Wang, Wei W" <wei.w.wang@intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?utf-8?B?5p+z6I+B5bOw?= <liujingfeng@qianxin.com>
Subject: Re: [PATCH] KVM: Destroy target device if coalesced MMIO
 unregistration fails
Message-ID: <Y7RY40+tAUOq97MQ@google.com>
References: <20221219171924.67989-1-seanjc@google.com>
 <DS0PR11MB637301E9103F92EE5617D5B2DCEA9@DS0PR11MB6373.namprd11.prod.outlook.com>
 <84acd990-3040-c3ee-c56f-6647900ca30f@redhat.com>
 <DS0PR11MB6373F27D0EE6CD28C784478BDCEC9@DS0PR11MB6373.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DS0PR11MB6373F27D0EE6CD28C784478BDCEC9@DS0PR11MB6373.namprd11.prod.outlook.com>
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

On Mon, Dec 26, 2022, Wang, Wei W wrote:
> On Saturday, December 24, 2022 1:14 AM, Paolo Bonzini wrote:
> > On 12/20/22 04:04, Wang, Wei W wrote:
> > > Another option is to let kvm_io_bus_unregister_dev handle this, and no
> > > need for callers to make the extra kvm_iodevice_destructor() call.
> > > This simplifies the usage for callers (e.g. reducing LOCs and no leakages like
> > this):
> > 
> > Can you send this as a patch?  Thanks!
> 
> Sure. I can do it. I'm also fine if Sean would be interested in taking over the
> code 

No thanks.

> (or anything I should do to keep his credits for the original fixing?)

No need.  If anything, take my patch first so that the fix for stable kernels is
trivial.  That's Paolo's call though.
