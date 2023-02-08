Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDC4468E727
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 05:31:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231126AbjBHEa6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 23:30:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230482AbjBHEaS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 23:30:18 -0500
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E1F341B78
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 20:29:55 -0800 (PST)
Received: by mail-yb1-xb2c.google.com with SMTP id 23so13931550ybf.10
        for <linux-kernel@vger.kernel.org>; Tue, 07 Feb 2023 20:29:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fhzeGnuICiPT2nrHJ6smEzbh41VKTVGE82e8/64PlQM=;
        b=oAKD3y+xr/ym/8alzfe5iPecB5XDrzMt7d+dv9BB/BB7u4F4WzBRW1M29Rev6GNFGn
         QMyM8q9EetdVsfmj+ACA6LwS+cvf0OJjz9vglnImwBdaLI5w+sYM5FSCcCB0YqC0PVvf
         sp/d9nq9slG56HUgVNucOhSOorawa3CvGIxd18q/+FNVa2d/Eb+yCrCV2ZZFuqrBTF1P
         r4bhSjN13EuVwtfnlBjLX+PubODVREgFrs9awGcedSpL6yQDAmqDjzgnBhH8e2SZelxM
         7/IoWZONhPbe7XUDdw4o3FQYTYyAb1VDbK0trsvZGIjYP0meSxx4kooJPFacjtu8Srkh
         C+Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fhzeGnuICiPT2nrHJ6smEzbh41VKTVGE82e8/64PlQM=;
        b=jShTYesZTzglycBQHdzN4Ux7TNoJQc70JiyfQg0Hw0OIoOOV7KuhebimVSibwVl4qC
         44l7b4Wz6RkxTDebg2hs+2C/YzP5Spqs+vL33rSkTt/hgCY1adirFkjA6hRjGNDikaz5
         9ENGeSr09I3tOAcjS3ocZB6su3ckrTH56AdmlnxJZjQdW7BSiktpuFJNm6a2letawJsV
         9ttYsFxBRBJq7DZ0W/p60j5pj0kzGqhCWJHErTAe+hRepfnPfy2QG5IAVvJBzIM4A/Cc
         Xy301druDjQkO9oQDCA6uHm0/z4AI1a9EQI81lzV64GKicsAPbxrlY7NTb+ycmw+xEL9
         NrLA==
X-Gm-Message-State: AO0yUKWhoMYKrYvkb7nUiW9/Ye4M4b3V+qSXgiSMcjccazUlWySsvRcA
        c1JG696iskofVyOvPTCD+m9ofJ2p6L3FsF7izPHjwQ==
X-Google-Smtp-Source: AK7set+LttiKihHYlrzSgPN7LWtawaDSHE8vLY8wcxInWN2E3/8zSOtO95vAG+OOzodb+SbYXZumxfkB/znQ1PqBn1Q=
X-Received: by 2002:a25:fe0c:0:b0:80b:69f5:3966 with SMTP id
 k12-20020a25fe0c000000b0080b69f53966mr717422ybe.519.1675830594250; Tue, 07
 Feb 2023 20:29:54 -0800 (PST)
MIME-Version: 1.0
References: <20230111183408.104491-1-vipinsh@google.com> <167582135970.455074.533102478332510041.b4-ty@google.com>
In-Reply-To: <167582135970.455074.533102478332510041.b4-ty@google.com>
From:   Vipin Sharma <vipinsh@google.com>
Date:   Tue, 7 Feb 2023 20:29:18 -0800
Message-ID: <CAHVum0e0ZL-Q7DwZ-SYSuqX1n_9EU85mYhyvUA=75zpJ6a29ow@mail.gmail.com>
Subject: Re: [Patch v2] KVM: selftests: Make reclaim_period_ms input always be positive
To:     Sean Christopherson <seanjc@google.com>
Cc:     pbonzini@redhat.com, bgardon@google.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

On Tue, Feb 7, 2023 at 6:10 PM Sean Christopherson <seanjc@google.com> wrote:
>
> On Wed, 11 Jan 2023 10:34:08 -0800, Vipin Sharma wrote:
> > reclaim_period_ms use to be positive only but the commit 0001725d0f9b
> > ("KVM: selftests: Add atoi_positive() and atoi_non_negative() for input
> > validation") incorrectly changed it to non-negative validation.
> >
> > Change validation to allow only positive input.
> >
> >
> > [...]
>
> Applied to kvm-x86 selftests, thanks!

Just FYI, this patch has already been applied to kvm/master branch.
https://git.kernel.org/pub/scm/virt/kvm/kvm.git/commit/?id=c2c46b10d52624376322b01654095a84611c7e09

>
> [1/1] KVM: selftests: Make reclaim_period_ms input always be positive
>       https://github.com/kvm-x86/linux/commit/4dfd8e37fa0f
>
> --
> https://github.com/kvm-x86/linux/tree/next
> https://github.com/kvm-x86/linux/tree/fixes
