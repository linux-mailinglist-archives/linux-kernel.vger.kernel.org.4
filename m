Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEB576C2120
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 20:18:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230144AbjCTTSJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 15:18:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229937AbjCTTRQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 15:17:16 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FAB5497D0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 12:09:21 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id p36-20020a056a000a2400b005f72df7d97bso6687749pfh.19
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 12:09:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679339360;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=HUPvCK3ymy0+cnyobGRdsYJBcqoJwtjACAhIOqCIVHU=;
        b=SDv4oGqnSHYEYEtm5hQgLXiorBu/02OCRZuU/AaNAm3ry0Z6K85YGDlNwDyVSgt7V2
         kch1+bYJQLOHK7easWhw8xQqaY9jciwLQdU5k1sy0qPfuJS6rn9dWcR6N+C0RynY7gjD
         WmMJDCj8hXNzkzSYbq9B1sMH92GfoLkwHZVs2qqzcK5mrIr3F0z8g6IgDAWj7TRSnXRb
         wYEw70Rd5KrlPpnUqn2DeWJ4ycQysKFZmTGKkPuQHEUupC4nrc2mcSuxIljZtFS5F7Ws
         C48ynkDgi2qfL0U3x2h+k/Z7Zsj8fIu5SkjMS/0qpdJrAvh71fOgStI0YSdqoUuENV0n
         eJ9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679339360;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HUPvCK3ymy0+cnyobGRdsYJBcqoJwtjACAhIOqCIVHU=;
        b=lDLacsUqxBe/gKGaiwRxolyGDFCdSDZ/UUnIi/UNcsp3a8IMODbzKY1cRdS5o7tYvS
         RIQWnmqy5InZOXuONJX1bUoY56g/f+qTbGilRvrSt/rhxKUyCLo8/n2BkrPuQO4H/jvZ
         o7WqTlXKV5Zv5pINGqHX6YzQo0FvEoB1r5fhFrp9cXwoisnTLDDYdNxHf/pQeDRDQvtX
         WItqeABf3KLUUxH06rOLCAc3qaZBmpjq/C3nBNZrYRDyFXcPOlGOfFA/gZa2vN2uJmRC
         uqm12tdg/SrRiVg9zqlb60MeF5/1Yg2DGYfaDP1C9IZI+x9K/xYF/fAsS1kp1ie1O6QB
         7PaQ==
X-Gm-Message-State: AO0yUKWY5FbWn6ooa19bianPtwI9qmdIdhLfCLa8qPXVFW8bLiZkbfel
        L2txhFvRfy8ww1v2KmjZmS7Ua/f1nMQ=
X-Google-Smtp-Source: AK7set/AxeSv8Y4jLii27wD+Ebg5sYFCgiwV3KArRehi+kLLw6P9E/Gh3Qez3ZQdbqZXFjXvezfamCQSi/k=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:903:41cc:b0:1a0:440e:ecf9 with SMTP id
 u12-20020a17090341cc00b001a0440eecf9mr7752314ple.5.1679339359650; Mon, 20 Mar
 2023 12:09:19 -0700 (PDT)
Date:   Mon, 20 Mar 2023 12:09:18 -0700
In-Reply-To: <20230202182809.1929122-1-bgardon@google.com>
Mime-Version: 1.0
References: <20230202182809.1929122-1-bgardon@google.com>
Message-ID: <ZBivXk5O316fChmi@google.com>
Subject: Re: [PATCH 00/21] KVM: x86/MMU: Formalize the Shadow MMU
From:   Sean Christopherson <seanjc@google.com>
To:     Ben Gardon <bgardon@google.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Peter Xu <peterx@redhat.com>,
        David Matlack <dmatlack@google.com>,
        Vipin Sharma <vipinsh@google.com>,
        Ricardo Koller <ricarkol@google.com>
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

On Thu, Feb 02, 2023, Ben Gardon wrote:
> Patches 4-6 prepare for the refactor by adding files and exporting
> functions.

For future reference, please do not conflate "export" with "make globally visible"
(here and in many of the changelogs).  The distinction matters, especially for
modules, as an exported symbol is quite different than a globally visible symbol.

We (sadly) lose sight of this in KVM far too often due kvm.ko exporting an asburd
number of symbols for kvm-{amd,intel}.ko, and as a result we've ended up with
non-KVM code using helpers that realy should be KVM-only.  This is something I
hope to remedy in the near-ish future, and so I want us to start getting the
terminology right.
