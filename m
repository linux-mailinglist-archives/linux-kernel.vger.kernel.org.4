Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DBBE6BB990
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 17:21:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229751AbjCOQVl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 12:21:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbjCOQVh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 12:21:37 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8696A49C4
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 09:21:36 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id bc19-20020a656d93000000b005072b17a298so4646974pgb.14
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 09:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678897296;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=JKTk6fHXe0DcBHYZ7abQpFccg4odhIWL73B59FNN1Xk=;
        b=JIJTtqfS3TMGnsbFa8g96atWXLD9Hi639HJF8P22QUC+Vb51Lk9yNCn5QWlUY59BCc
         eptR4lQ3acknGb4WF8ZXNG89vGlBbvoMQqwd4R1MrcO5psAhmtkSb7k4gnVzvgudFdTw
         avYKauJrNh6tEZckc8zEeWTVtIy4somJPyM0y/bW71369Y2Dua/19SsouijpZn+b4kCl
         a6qBe1NKaQljePkV/vaMJuAMUt72wGV0sPX9AavXH6ip5x9HhVeK72lING95SHW3UOvC
         2C4gFKhFmy95spZV+N9HSrT1LGnLu6EO5NNtqJ9hYJYUO3Wu5+0pRtSlgJOXOldW5Jb6
         dK6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678897296;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JKTk6fHXe0DcBHYZ7abQpFccg4odhIWL73B59FNN1Xk=;
        b=MsHLaPS2qlwFN6+7f6hREJajYnxzw9ggJ9PQRu9X7eyDZOQ/s8wk4uBdIgH90Aik3k
         Pih1qp83V8Pq7Q2b08JhpTsYDkIkUMABSCOFFvZXyY9YAGL8j32leqZbhgn70odVX+Om
         QjITiFiVxKaxAxLiTCO7FfY3kVWwiMPZwrJJ3W81N3Z6UZYcOibJwdC7/RU8c4AoWwgw
         b3UHWu2XxzD7DfC7coCm/1o3XqENaIahqMMSVxnq5df2vk60KhPkRDHYKA3NEmvbTyxL
         yL8W4lpCT+C0gAq5mb/j6M0ay5GD3wMGwFqJ4nd0/ezeW+yxKOYJ2PVy55l5hZ6ux4XH
         D8Og==
X-Gm-Message-State: AO0yUKU+VKZlt2ER4o0d9j23PSSyCKx0rJfH39m3Sl63oV8gH08PsnZm
        +beAUYE0MMO2EouEUAgem+ULpCffEdc=
X-Google-Smtp-Source: AK7set8gPm4g/NvRUZwmci48nYogYWiDAtlDOVIipuNXOmnGWoPg5uKaBoV4za1AXTOtQ2HQrJ0TchlLCME=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:903:2344:b0:1a0:561c:7276 with SMTP id
 c4-20020a170903234400b001a0561c7276mr84640plh.1.1678897295968; Wed, 15 Mar
 2023 09:21:35 -0700 (PDT)
Date:   Wed, 15 Mar 2023 09:21:34 -0700
In-Reply-To: <ZBGRJaV3tDTVyE/q@yzhao56-desk.sh.intel.com>
Mime-Version: 1.0
References: <20230311002258.852397-1-seanjc@google.com> <20230311002258.852397-21-seanjc@google.com>
 <ZBGRJaV3tDTVyE/q@yzhao56-desk.sh.intel.com>
Message-ID: <ZBHwjm2heYeE40xl@google.com>
Subject: Re: [PATCH v2 20/27] KVM: x86/mmu: Use page-track notifiers iff there
 are external users
From:   Sean Christopherson <seanjc@google.com>
To:     Yan Zhao <yan.y.zhao@intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>, kvm@vger.kernel.org,
        intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Ben Gardon <bgardon@google.com>
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 15, 2023, Yan Zhao wrote:
> Nit: there is a typo in the commit header: "iff" -> "if"
> 
> > -void kvm_page_track_write(struct kvm_vcpu *vcpu, gpa_t gpa, const u8 *new,
> > -			  int bytes)
> > +void __kvm_page_track_write(struct kvm *kvm, gpa_t gpa, const u8 *new, int bytes)
> Line length is 81 characters. A little longer than 80 :)
> 
> > +static inline bool kvm_page_track_has_external_user(struct kvm *kvm) { return false; }
> This line is also too long.

The 80 character limit is a "soft" limit these days, e.g. checkpatch only complains
if a line is 100+.  In KVM x86, the preferred style is to treat the 80 char limit
as "firm", for lack of a better word.  E.g. let a line run over if it's just a
char or two and there's no other wrapping in the declaration, but don't create long
lines just because checkpatch no longer yells.

There's obviously a fair bit of subjectivity, but the guideline has worked well
so far (hopefully I didn't just jinx us).
