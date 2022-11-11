Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AFE36260F8
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 19:19:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232851AbiKKSTY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 13:19:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232004AbiKKSTV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 13:19:21 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D0B118F
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 10:19:20 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id 6so4985893pgm.6
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 10:19:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=E/joC3rBRu6szzAGRTFTKxdLKepicTRIoPul13yjtyo=;
        b=XeJT6PZtgqR21XiJLI4nL1rULhXugV6G1Aak5971SzkfNU+Yve4TGSaM3c1rXphMJq
         UNq8HXQJ9aI09BO/HX+6xKh6RC8IvrjlK0RuGIaeBkfCvEUYI70a9Ux0Kh8ybQchY2B2
         zA9L3w0F+Kj39RljYeEuJqoaAjnuNXOAv+p9tWkbEa75m3I+k66/Y+sVdF5CWt+bKSI3
         rJFhdjE792ZFpMf5YJjeDzj8zde8jaspzGHNLXGmqKn1lTKSj3TvMrCoZUiB6zC4shd6
         XvTNZVwLvIIlCO2hPdCnYq6WMP+IW85H5uuwStvr2mZRwdrimn1rc1ANrx69zoVug5v+
         K8Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E/joC3rBRu6szzAGRTFTKxdLKepicTRIoPul13yjtyo=;
        b=6pLUsB1miD22dku6qsQIcHl7SnLX150UfBEKDrFZUl7BdfFFA8mjOZEkcKzKf6sUFc
         flBtW3tOs6XVGL/nG9HKz/DfryJHLKB21SPEiYv4McjoqUh/cIObLGd/QP0IaUo3D/UQ
         OVjqRofAYI/RYPJ8pzjfS7cHq5gpLT76GbtU34Nj2YckM2m5G7Yb8wDbzatkG8IVjosD
         /sI6QEkBATfTXA/z0W38ZozXYrEXmOzly1Ms1N5wUX7sOjnKfurxaakseU0pSkTA0wTF
         ie+okY4RiSQ1mkFJSvObsLhsZ276KRpEnWq66vczqKN5fftq0kr2RiNLyaoNki3QY68N
         CvKQ==
X-Gm-Message-State: ANoB5pmks5qDul6RPK3QuxsKyHwNeRtPSgObb4BpJehEhM5fzI8rvhNZ
        DJzOh1C72eMUMjZ/ZZXlNTWuww==
X-Google-Smtp-Source: AA0mqf7HFVgDPir8+MW/ttweKldJ4iGrAcZDLN5q/SpYzFAno64kC//kH/RNaqrmyuvit8zaDFItUg==
X-Received: by 2002:a05:6a00:3022:b0:560:e4d1:8df5 with SMTP id ay34-20020a056a00302200b00560e4d18df5mr3945850pfb.39.1668190759766;
        Fri, 11 Nov 2022 10:19:19 -0800 (PST)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id q19-20020aa78433000000b0056bcfe015c9sm1865286pfn.204.2022.11.11.10.19.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Nov 2022 10:19:18 -0800 (PST)
Date:   Fri, 11 Nov 2022 18:19:15 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Yan Zhao <yan.y.zhao@intel.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        pbonzini@redhat.com, intel-gfx@lists.freedesktop.org,
        intel-gvt-dev@lists.freedesktop.org, zhenyuw@linux.intel.com
Subject: Re: [PATCH v2 1/3] KVM: x86: add a new page track hook
 track_remove_slot
Message-ID: <Y26SI3uh8JV0vvO6@google.com>
References: <20221111103247.22275-1-yan.y.zhao@intel.com>
 <20221111103350.22326-1-yan.y.zhao@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221111103350.22326-1-yan.y.zhao@intel.com>
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

TL;DR: I'm going to try to add more aggressive patches for this into my series to
clean up the KVM side of things, along with many more patches to clean up the page
track APIs.

I'll post patches next week if things go well (fingers crossed), and if not I'll
give an update 

On Fri, Nov 11, 2022, Yan Zhao wrote:
> Page track hook track_remove_slot is used to notify users that a slot
> has been removed and is called when a slot DELETE/MOVE is about to be
> completed.

Phrase this as a command, and explain _why_ the new hook is being added, e.g.

  Add a new page track hook, track_remove_slot(), that is called when a
  memslot DELETE/MOVE operation is about to be committed.  The "remove"
  hook will be used by KVMGT and will effectively replace the existing
  track_flush_slot() altogether now that KVM itself doesn't rely on the
  "flush" hook either.

  The "flush" hook is flawed as it's invoked before the memslot operation
  is guaranteed, i.e. KVM might ultimately keep the existing memslot without
  notifying external page track users, a.k.a. KVMGT.

> Users of this hook can drop write protections in the removed slot.

Hmm, actually, on second thought, after thinking about what KVGT is doing in
response to the memslot update, I think we should be more aggressive and actively
prevent MOVE if there are external page trackers, i.e. if KVMGT is attached.

Dropping write protections when a memslot is being deleted is a waste of cycles.
The memslot and thus gfn_track is literally being deleted immediately after invoking
the hook, updating gfn_track from KVMGT is completely unecessary.

I.e. if we kill off the MOVE path, then KVMGT just needs to delete its hash table
entry.

Oooh!  Looking at this code again made me realize that the larger page track cleanup
that I want to do might actually work.  Long story short, I want to stop forcing
KVMGT to poke into KVM internals, but I thought there was a lock inversion problem.

But AFAICT, there is no such problem.  And the cleanup I want to do will actually
fix an existing KVMGT bug: kvmgt_page_track_write() invokes kvmgt_gfn_is_write_protected()
without holding mmu_lock, and thus could consume garbage when walking the hash
table.

  static void kvmgt_page_track_write(struct kvm_vcpu *vcpu, gpa_t gpa,
		const u8 *val, int len,
		struct kvm_page_track_notifier_node *node)
  {
	struct intel_vgpu *info =
		container_of(node, struct intel_vgpu, track_node);

	if (kvmgt_gfn_is_write_protected(info, gpa_to_gfn(gpa)))
		intel_vgpu_page_track_handler(info, gpa,
						     (void *)val, len);
  }

Acquiring mmu_lock isn't an option as intel_vgpu_page_track_handler() might sleep,
e.g. when acquiring vgpu_lock.

Let me see if the clean up I have in mind will actually work.  If it does, I think
the end result will be quite nice for both KVM and KVMGT.
