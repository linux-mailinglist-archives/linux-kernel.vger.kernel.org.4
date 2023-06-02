Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D43871F7D0
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 03:25:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231468AbjFBBZ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 21:25:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231407AbjFBBZY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 21:25:24 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F88618D
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 18:25:22 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id 41be03b00d2f7-53feeb13906so1420036a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 18:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685669122; x=1688261122;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=aAeX2x25IEnYqDcyaaeygr5j/RLaW3VmX83LOkBX62w=;
        b=jbC28+Kk7+GbdZAD1n0cOFaoxamdpSTEFpFL9n6fWhGNd1eXtqCZy2GPO3UhLfuIso
         LuZVH1bk1JFiY6VmkOkHSSi653/6qASI6QLZfEy+l1C/wavY06zJ3PiiSblOYtplHFhY
         qpsSlMydNAkrd276ftCjEEKJi1Mc0C/EEKEA36lb5b9bg+CILb6fMxzFfnmG8MmClm/j
         erSCxIS8XEoxtisxmddOCQooO7I0zCsAw6TnFywGnDoOCDxHCRgRFLt0L2DE9SqJzkc4
         3nJ+NacV4wGU2jVrarcjaCoTLIhoystDqFgsTRU8dbZW5mF7io3jMH2SA62O37Fd/Dlz
         yVNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685669122; x=1688261122;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aAeX2x25IEnYqDcyaaeygr5j/RLaW3VmX83LOkBX62w=;
        b=cFdHNTkyaHhAJJDPsvZHjCGifZcND7xwpcfhC6tfaJbTyVbrQriWPHbEP3qFuk/Qo+
         jqhMswA/v61YWT3AA8eiR5QA59Iw7XSS6/SrFFjX4V1hYgqEpUuz4KRFnlsFh7luWzTQ
         FI97AnEil6fTE/97TLPaqq/dfQIBMLe6ixwFfCZ22qTXpAUurvlZlaaj/twZScmmadE1
         838+4NlDFV5eSYPU0aXdDD+tKNIBcPWJWx868UWvZn/mtEcUljSh0zUxbMCqm6M6SUP9
         WBIOY3LVZouwQGv6UM2huKC/96qF6IpJnqh7/gS4HefLrYdjAkEAGtk+HNZ17aoaFRiv
         ir/w==
X-Gm-Message-State: AC+VfDzJZ6qDG1D58E+W63NB3QElGpB/bp4Yq3wnsylj0lMF2PEpujiT
        5tsed5hQvl8LReubXqZ650kdXPnMg/Q=
X-Google-Smtp-Source: ACHHUZ6mdPKFdzG/VCK/fOCRl3UFXp7GQZZehhCor8qs5f4C1fSI7fJE390vyhN3BSJmeej6Dj75Gdm96tQ=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a63:4450:0:b0:51b:2805:6d43 with SMTP id
 t16-20020a634450000000b0051b28056d43mr418215pgk.1.1685669121776; Thu, 01 Jun
 2023 18:25:21 -0700 (PDT)
Date:   Thu,  1 Jun 2023 18:23:36 -0700
In-Reply-To: <20230412200913.1570873-1-pbonzini@redhat.com>
Mime-Version: 1.0
References: <20230412200913.1570873-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0.rc2.161.g9c6817b8e7-goog
Message-ID: <168565340740.666768.10463587554285914493.b4-ty@google.com>
Subject: Re: [PATCH] selftests/kvm: touch all pages of args on each memstress iteration
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     vipinsh@google.com, bgardon@google.com
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Apr 2023 16:09:13 -0400, Paolo Bonzini wrote:
> Access the same memory addresses on each iteration of the memstress
> guest code.  This ensures that the state of KVM's page tables
> is the same after every iteration, including the pages that host the
> guest page tables for args and vcpu_args.
> 
> This difference is visible on the dirty_log_page_splitting_test
> on AMD machines.
> 
> [...]

Applied to kvm-x86 selftests, thanks!

[1/1] selftests/kvm: touch all pages of args on each memstress iteration
      https://github.com/kvm-x86/linux/commit/07b4b2f4047f

--
https://github.com/kvm-x86/linux/tree/next
https://github.com/kvm-x86/linux/tree/fixes
