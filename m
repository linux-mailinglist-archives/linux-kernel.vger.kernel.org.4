Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF5E9681A24
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 20:16:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238322AbjA3TP7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 14:15:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238326AbjA3TPy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 14:15:54 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AB7C40EA
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 11:15:53 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id m11so12063035pji.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 11:15:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JWs+dGDpXI1Q6fAmVAS/nI/deuPaTfu+8ky9IoKyCxw=;
        b=ZWa+sI43chmst3aMoIiuzeASbgv5wxw5q/723J/PhkD6Zgx1o13odcWhY5Zc39okx+
         Dv4s1ARkNete6hwGvM/HAADGCUZUZ582xQGFDyxsqWrZK5/jdX1TKbgz72p+j2HWYs8J
         GkBi0RcQRKPlqoIUz8I+uijEF4ZZ2LpQxf9JmrDYzFg2c1jZuAkSfyVHTbuMbF5nWYkz
         jb0kbpbRipRECtkN1EZzl3kxATEa9sN/+rI/IjgtdrFpBHmz9pYD/So50o9+SfTc1+RB
         KeOTYAVz+mL12jfTI0jd23ttbd63lI2fU1H/VWz/bR5GfA/iaNtxkT2lpgM+a/QgTqn0
         USPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JWs+dGDpXI1Q6fAmVAS/nI/deuPaTfu+8ky9IoKyCxw=;
        b=hzY0otXimvt+vXJlThlFb7XLKEGyB7wYg34PjvaRhWlqTy1Av19eF58CEN4XTjemRY
         7AjmaaZ5qIZ3q+9ZWwnGRLSx61eBfz66//PUl3ko8wctkD+A91/sI/JWQxQcub6+3Vd4
         QJsjlsBFxNrLv8Hf704oT7LwHicOPUZBVU4/FM5bDpBzOiP8bYHJkGbrinYmquOg6Tvq
         67gPl5bZrwFAJoQ1k7QzWef7SQi6Qz/vLeuHwqUQGRcwWjRhxCy5lF6Ssf69gf7a0BBT
         ae4A8iOPBRZZsbdG2ahOpRCY9+qFLhvtgAljJAn4/k8+5Ait7Elnl/gNcEH1Yy4W8hKG
         84PQ==
X-Gm-Message-State: AO0yUKXMoL7zV1sITA/VpwL+CGpL7nLtTN7ac0Xdvka7wTlsYj9Cw/kL
        d1tyrgdJxw/T7Q2QmwVMWwD9dw==
X-Google-Smtp-Source: AK7set8PsfJJnz16N8IqXYluO7INWz4+j1KLTmGuDt9oewXqwFlLphwVnQOGJysc57+ffTAtrO7TlQ==
X-Received: by 2002:a05:6a20:3d16:b0:bc:3523:13c5 with SMTP id y22-20020a056a203d1600b000bc352313c5mr1056989pzi.3.1675106152498;
        Mon, 30 Jan 2023 11:15:52 -0800 (PST)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id g4-20020a17090a3c8400b0022c326ad011sm6770138pjc.46.2023.01.30.11.15.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 11:15:52 -0800 (PST)
Date:   Mon, 30 Jan 2023 19:15:48 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     "Huang, Kai" <kai.huang@intel.com>
Cc:     "sean.j.christopherson@intel.com" <sean.j.christopherson@intel.com>,
        "dmatlack@google.com" <dmatlack@google.com>,
        "Shahar, Sagi" <sagis@google.com>,
        "isaku.yamahata@gmail.com" <isaku.yamahata@gmail.com>,
        "Aktas, Erdem" <erdemaktas@google.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "zhi.wang.linux@gmail.com" <zhi.wang.linux@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Yamahata, Isaku" <isaku.yamahata@intel.com>
Subject: Re: [PATCH v11 018/113] KVM: TDX: create/destroy VM structure
Message-ID: <Y9gXZBS2zl9nahtt@google.com>
References: <Y8ndcGHUHQjHfbF9@google.com>
 <CALzav=d4vwHTnXP8wetA_Hqd3Tzc_NLp=3M-akwNSN1-ToL+Eg@mail.gmail.com>
 <Y8st2PjGDQ+Q0LlW@google.com>
 <3951e178bc38191074f5cccadc442212ff15c737.camel@intel.com>
 <Y87GzHrx8vxZLBEJ@google.com>
 <e5912f7d04ce7a27a68ce4328fc50ce594295c6c.camel@intel.com>
 <Y9K4Mnx/Je4j+RsD@google.com>
 <144de0bf7cc86dd7807f1b559c3269bccbb56317.camel@intel.com>
 <Y9L31cqsKvr4boGU@google.com>
 <d335eaba5b8235cfc4f8105352bc7fe916b5b309.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d335eaba5b8235cfc4f8105352bc7fe916b5b309.camel@intel.com>
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

On Thu, Jan 26, 2023, Huang, Kai wrote:
> On Thu, 2023-01-26 at 21:59 +0000, Sean Christopherson wrote:
> > Hrm, but even if TDX takes a read-lock, there's still the problem of it needing
> > to walk the upper levels, i.e. KVM needs to keep mid-level page tables reachable
> > until they're fully removed.  Blech.  That should be a non-issue at this time
> > though, as I don't think KVM will ever REMOVE a page table of a live guest.  I
> > need to look at the PROMOTE/DEMOTE flows...
> 
> In this series, if I read correctly, when slot is removed/moved, private
> mappings are zapped too.  It's kinda buried in:
> 
> [PATCH v11 043/113] KVM: x86/tdp_mmu: Don't zap private pages for unsupported
> cases

That should be ok, only leaf SPTEs will be zapped in that case.
