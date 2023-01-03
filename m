Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10B9465C8D3
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 22:20:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232129AbjACVTa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 16:19:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238174AbjACVTH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 16:19:07 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76F1C14090
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 13:19:06 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id n65-20020a17090a2cc700b0021bc5ef7a14so32453137pjd.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jan 2023 13:19:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=c3u4viFf4xTjR77nQ+iN3D/WVZD7odj3dDROxrzHS78=;
        b=dyf43qxv95faYYtccBnBODi9tn+YtYQiEUinhWbNp5MX3EWJhsZ9X15/P/Dt9QWb4N
         hUUpTXEEJfwsqQgKnE/MYcAamYefLp1pkwUpGqnD8Knz7ls/aY+4AmM9gKvLvlmvzkTx
         q3BgHiXoCsUd6x05LXCsLYNBTgu2LPrA7gkiTvupqrKxy+8LVCX9gNp5V3mrj++k/Uoc
         jDIpurpOJtSk3WfA0Xesle/v/SllByEl6pLvTkB1oVFhqtKigbPwsxHY8KSValZf+1w7
         eEBGKcYBblNYQ1vTB1NZMx6eXx1r5g3qh/GKQddP+TS7F5WsR4XAoF1MGPRxeb8hXeA6
         2eug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c3u4viFf4xTjR77nQ+iN3D/WVZD7odj3dDROxrzHS78=;
        b=SwJ4FUSo/fg+yMXOHF8kMWNlS8wgesbnWEmrRzaaG1f1ceda4UV3/MpyzrzurnDgV2
         8Gm/0vpmFn47tAYtCEhiOmC1dUP/M4yP3v/ljw73vFaVgD+drulfRtA4EupDg5ppUdpv
         G74j0Chc9edT4c1dr6+2sQ0T5XG2ySHkdQaFST9X4X816N6iJAJmROQ78ufqsQavAiWB
         6K+DIlsh9SAXB505hQ7pCEpR5JZMC1AIq8orhiNLY2R0yOt+qpdbqZ99IXs5sv+PSv3U
         LN/C0UBBBtu7NOZ/OfSWfIMYowmphI1Emt0Z/eR9mLE+1brfmqwf9n+TrR+nYljPoukv
         pVjg==
X-Gm-Message-State: AFqh2ko7m2TeZ2tFpVsKbc+ToUGOK80eRM5DTbVAd61o7rZl9rIcrSuH
        070/OhYcadpRCP9QpIDFK279ZA==
X-Google-Smtp-Source: AMrXdXsRrvuXTzfkRt6Y5pbAIJNM2f3D+xwjUMpE2J4UbGs3IWYjjgM7o/7PQF5PzULnMVN+gIs1QQ==
X-Received: by 2002:a05:6a20:2a9f:b0:a4:efde:2ed8 with SMTP id v31-20020a056a202a9f00b000a4efde2ed8mr4997943pzh.0.1672780745919;
        Tue, 03 Jan 2023 13:19:05 -0800 (PST)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id k12-20020a6568cc000000b004788780dd8esm19141338pgt.63.2023.01.03.13.19.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jan 2023 13:19:05 -0800 (PST)
Date:   Tue, 3 Jan 2023 21:19:01 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Yan Zhao <yan.y.zhao@intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>, kvm@vger.kernel.org,
        intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Ben Gardon <bgardon@google.com>
Subject: Re: [PATCH 26/27] KVM: x86/mmu: Add page-track API to query if a gfn
 is valid
Message-ID: <Y7SbxcdYa7LKR43f@google.com>
References: <20221223005739.1295925-1-seanjc@google.com>
 <20221223005739.1295925-27-seanjc@google.com>
 <Y6v287BFez8tU43e@yzhao56-desk.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y6v287BFez8tU43e@yzhao56-desk.sh.intel.com>
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

On Wed, Dec 28, 2022, Yan Zhao wrote:
> On Fri, Dec 23, 2022 at 12:57:38AM +0000, Sean Christopherson wrote:
> > +bool kvm_page_track_is_valid_gfn(struct kvm *kvm, gfn_t gfn)
> > +{
> > +	bool ret;
> > +	int idx;
> > +
> > +	idx = srcu_read_lock(&kvm->srcu);
> > +	ret = kvm_is_visible_gfn(kvm, gfn);
> > +	srcu_read_unlock(&kvm->srcu, idx);
> > +
> > +	return ret;
> > +}
> > +EXPORT_SYMBOL_GPL(kvm_page_track_is_valid_gfn);
> This implementation is only to check whether a GFN is within a visible
> kvm memslot. So, why this helper function is named kvm_page_track_xxx()?
> Don't think it's anything related to page track, and not all of its callers
> in KVMGT are for page tracking.

KVMGT is the only user of kvm_page_track_is_valid_gfn().  kvm_is_visible_gfn()
has other users, just not in x86.  And long term, my goal is to allow building
KVM x86 without any exports.  Killing off KVM's "internal" (for vendor modules)
exports for select Kconfigs is easy enough, add adding a dedicated page-track API
solves the KVMGT angle.
