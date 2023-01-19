Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5300C6743A8
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 21:47:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbjASUr4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 15:47:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbjASUrs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 15:47:48 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28EA84EEA
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 12:47:45 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id mp20so8872870ejc.7
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 12:47:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Auj6XCXOBwJJlVzevyyph1mYwbHw+mWksSnSvNFWQIg=;
        b=oL1bfvLo7cVGrIodoE9TXFo/GXsYhB75CDKi5NHFRobQvCVDPdFvcqng76CFYfj7x7
         yESJQqZs7YS/2pFaLuWLPiRv5C68yK4jt4D7RT01k7fSjCgwoFJm1A3M2mwPc4vH2qQG
         Cgeet1dTTQrj6ajl4sWnUqbBKGUBiGhSOLFccD111UYFpk1zNdY6g0EBYzSZlLM3/vCm
         Ef89nDDn/DMCm3CcnNS8GIVqyHz6lsrwkztEHu5YxKcjpU68JQVGy5yImv+HmAdbKDtA
         6YrvLwAkHL/Y+vx0D26a4LjqMTAM4dkAq5j1R2zsBOptljdA6gobYq+lbGWtidFqDEqf
         G0Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Auj6XCXOBwJJlVzevyyph1mYwbHw+mWksSnSvNFWQIg=;
        b=FhKUBgFqdwOUD2EtqxnvpzLwsc61wuY4WDchN86BHNOSv/P6kI7AOmp7Jg+u9IaKCG
         O2gCXt0962mpw1LUV9eC9JNkEYG33rznsi7WEx5rM7URfAIJBgAz5uTBQwnfSlEWjxmq
         CGP72gSs64foHrPt056mNVXk1bZhnJJPD3NJvrL12Ed6dlqKSW4PQohjIejZYaDbXwGY
         vz9I1LwOK3469DRf/2mgKFSjWL61CBOosVt/TbKflQhHsi++PY0Fr14rwIVo1QCFeU7n
         r4gi+gF5cdLUwYTHebdpX2g1FdMU6GiUrzrWJ8OpuQ6dv+OOaBPr3k3BOe0CdY+z4LaU
         Fq+g==
X-Gm-Message-State: AFqh2kpmfr3gyWskz5avovbJDu7JboJYR3khOJ1cy73IDjZVM6l1mOgB
        QoF9CY1iHROpcTUQeC4ih8sA4Ak3kF9eTi8cZbT7hw==
X-Google-Smtp-Source: AMrXdXvcGdPvGop4M3UQ0q7VaEQzCiFuc+nu85C71F04aC54bS0mY807Xoqo4SvoTwiC5lNh34RsC9rkQ3ubzPrZXWU=
X-Received: by 2002:a17:906:37d4:b0:854:cd76:e982 with SMTP id
 o20-20020a17090637d400b00854cd76e982mr1048141ejc.364.1674161263571; Thu, 19
 Jan 2023 12:47:43 -0800 (PST)
MIME-Version: 1.0
References: <20230119200553.3922206-1-bgardon@google.com> <Y8mqd7HUzXDnhXLV@google.com>
In-Reply-To: <Y8mqd7HUzXDnhXLV@google.com>
From:   Ben Gardon <bgardon@google.com>
Date:   Thu, 19 Jan 2023 12:47:31 -0800
Message-ID: <CANgfPd902Sd+LCd61D8=ba2ZTbJCRu3emLXtE212_8NWW6c3Pw@mail.gmail.com>
Subject: Re: [RFC 1/2] selftests: KVM: Move dirty logging functions to memstress.(c|h)
To:     Sean Christopherson <seanjc@google.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Peter Xu <peterx@redhat.com>,
        David Matlack <dmatlack@google.com>,
        Vipin Sharma <vipinsh@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Woops! I did not mean to tag this RFC. Sorry about that. I will
include a cover letter in the future and can resend these with one if
preferred.

On Thu, Jan 19, 2023 at 12:39 PM Sean Christopherson <seanjc@google.com> wrote:
>
> Please provide cover letters for multi-patch series, regardless of how trivial
> the series is.
>
> This series especially needs a cover explaining why it's tagged "RFC".
