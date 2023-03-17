Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0154E6BF598
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 23:58:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231292AbjCQW6m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 18:58:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231281AbjCQW60 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 18:58:26 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08FD4DCA7C
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 15:57:53 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5416d3a321eso60693597b3.12
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 15:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679093857;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1wbejF6WrsjCe87RU/Xd7e9XyaptMO+MaTPmYflDm1U=;
        b=bm5wqx0ban4lY8hIwbljSzbz8TfcNuxcuzBm1DdU6Vy8zgql+DvjtdZYHx3B+wGlYF
         WJCZowqfsDnfZ90nQCGu73e1bsJCtrtvYMwECfcEaAYAaNhbCTPmYIEfCpNHR6IApnak
         VmapZFDWlTySnymFyvnfx19NKfULC76Rsvln8pSyKQX27SrpM+z/DU2czDyKxVi+fLG1
         AcVgBz1lNu+9EgSc1KjLJdmqaHq7NcCVNWSelzVrt7QKeuXItlqqmp+6fcDTB6qAjk6A
         bnHeNlVf8zkkowG1kMLI1AIuSgm9kIBJwBRg3jKovEEzajDYRyp65LGb0llsIWU3yq0D
         B+hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679093857;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1wbejF6WrsjCe87RU/Xd7e9XyaptMO+MaTPmYflDm1U=;
        b=L3yWsfJeqfM3tWEp4HtDWMpvQ++5yDVFSf+ldfP1WuKtIW2VUKww0X1Get7yJCJuwS
         6T61KjM0UzJZF9/XdCPzI9gh4TWp6/JYHTdR4vMKGjFBfzrUA71iVMqsSe44xHqDyILQ
         V2EYcXZq6c1UKWcPbogimZ9Hov8i60xoG4AeCJ1Ia48QPyMMDNm5ipf87/iw6aTLyrCS
         4whHxku54hUhDMnfSVv7yJMqociXZxnfkNLnDDS7y7eYQ2pEPCPBG2hPcubcUJResXtz
         qT7M1ovBZL/OruZwCQ9jXvUPWg6Q+uMoQM0STDp3ovCPnF10R9ga2L/VUPleKVyC1aLJ
         ko9Q==
X-Gm-Message-State: AO0yUKULYs9Bv8WwZiHHmG1Eg4aWRkQ3a1MtJ0ZstFmy2ca+Tux5oL9M
        HqcBeBoA6RHjn4r4ysURwWjKwQCcvVc=
X-Google-Smtp-Source: AK7set8q9jbMPRYAhzwVa7g6qA/qgYzUtg6eOkwnDsctJFiRF82CyIrW3bd6I0gwZxJpOZqjrfNoDbV3TG4=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a81:431b:0:b0:544:94fe:4244 with SMTP id
 q27-20020a81431b000000b0054494fe4244mr5755178ywa.10.1679093857310; Fri, 17
 Mar 2023 15:57:37 -0700 (PDT)
Date:   Fri, 17 Mar 2023 15:57:35 -0700
In-Reply-To: <20230211014626.3659152-1-vipinsh@google.com>
Mime-Version: 1.0
References: <20230211014626.3659152-1-vipinsh@google.com>
Message-ID: <ZBTwX5790zwl5721@google.com>
Subject: Re: [Patch v3 0/7] Optimize clear dirty log
From:   Sean Christopherson <seanjc@google.com>
To:     Vipin Sharma <vipinsh@google.com>
Cc:     pbonzini@redhat.com, bgardon@google.com, dmatlack@google.com,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Fri, Feb 10, 2023, Vipin Sharma wrote:
> This patch series has optimized control flow of clearing dirty log and
> improved its performance by ~40% (2% more than v2).
> 
> It also got rid of many variants of the handle_changed_spte family of
> functions and converged logic to one handle_changed_spte() function. It
> also remove tdp_mmu_set_spte_no_[acc_track|dirty_log] and various
> booleans for controlling them.
>
> v3:
> - Tried to do better job at writing commit messages.

LOL, that's the spirit!

Did a cursory glance, looks good.  I'll do a more thorough pass next week and get
it queued up if all goes well.  No need for a v4 at this point, I'll fixup David's
various nits when applying.  I'll also add a link in patch 2 to the discussion
about why we determined that bypassing __tdp_mmu_set_spte() is safe; that's critical
information that isn't captured in the changelog.
