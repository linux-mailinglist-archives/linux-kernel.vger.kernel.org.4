Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0C076ACCD6
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 19:42:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbjCFSm3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 13:42:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjCFSm2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 13:42:28 -0500
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D51A65116
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 10:42:27 -0800 (PST)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-536af432ee5so202017967b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Mar 2023 10:42:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678128146;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ngEGOQ5LH5Ca87/RzyGzlZeBinyJ/MngnZ8MYK7ebfA=;
        b=OkT4Bj9Z0TehomdKv19DYXF35jcxaz6UKe9zC/6aAKXVfCe/IsKqN7paabT+Ug9qKg
         zxtbbvQ18j1OIA/hGzpOboQ8nrgaWyMHudXYhyFGFky0Kk+3B1T/Z32HHqnVWmCpPou/
         YiiGegPoI65A293D9hI70EDBfbLxv8J6IZADCiEyrNCC2E/PTWpUmQuCCWetGNOyQt5Z
         xpGxeNWEe0iLSwy2+xaiO5qi/R+JJZg1WIYWlTWnCSBHTQdi73hk+tIfLDsKYvvc+GYh
         yWs1ok3/XLu/v3bvdjodgikz/Wdzh0Rc6fAhLaPiuBrBEvvHys94++syqIdBfK976igf
         Wc4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678128146;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ngEGOQ5LH5Ca87/RzyGzlZeBinyJ/MngnZ8MYK7ebfA=;
        b=chSH8uVLaVufFvcW15v7sr7IaehUOdIJfC1DX62FXWwULzvWjQ97JHG4b1PYya6aMP
         wAkiXCBUMXPCnQHvnCbGtWcNnpe1HBbB2qkIYK7Zei8qZjahS3FoSOigYIpZNlw1vp4u
         mYAAg6AinAvDr7aJwQ2pWPs5qK6Y0TARkIigxRJd3q1FgT9EwXPcsWB6vpLkVYN8NrrV
         0nzLvZlkCaEP2EOEdANQwAwCqXZra02hQ/I1PkVaWSy42b3O9w8nN0WPyBJm8N4uOftr
         OPRzOM6+b4pYlAAMeQ0HiB6XsAIinq+9efO0m+dwSQRLfKbhXhZXmBwcRUcXW3bo8pn/
         7wzQ==
X-Gm-Message-State: AO0yUKUUnlYJg31PoQaor/jvyved9+jAHEpKtVquQEM2XPe+e79LEdeH
        Mr7VWLo1KaPLGUBUZVpJpUxlnUZgnsiIaWM9t5G1iQ==
X-Google-Smtp-Source: AK7set8M00ZKGa/Z6gExCxHwgZnLO9Ec15wOR2BKAuJ7UZnHwr8H2R46yNYEtvxgXLd0/fKqQyxPpIlndMTCwGkWl/g=
X-Received: by 2002:a81:4422:0:b0:534:eef8:caa9 with SMTP id
 r34-20020a814422000000b00534eef8caa9mr7040273ywa.8.1678128145947; Mon, 06 Mar
 2023 10:42:25 -0800 (PST)
MIME-Version: 1.0
References: <20230204014547.583711-1-vipinsh@google.com>
In-Reply-To: <20230204014547.583711-1-vipinsh@google.com>
From:   Vipin Sharma <vipinsh@google.com>
Date:   Mon, 6 Mar 2023 10:41:50 -0800
Message-ID: <CAHVum0dHKAxqm3zk7zCdmY=BTFZYyOS-nGqH4WbYcuoVXDqjWw@mail.gmail.com>
Subject: Re: [Patch v2 0/4] Common KVM exit reason test assertions and exit
 reason sync
To:     seanjc@google.com, pbonzini@redhat.com, maz@kernel.org,
        james.morse@arm.com, suzuki.poulose@arm.com,
        oliver.upton@linux.dev, yuzenghui@huawei.com,
        borntraeger@linux.ibm.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, david@redhat.com
Cc:     dmatlack@google.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Fri, Feb 3, 2023 at 5:45=E2=80=AFPM Vipin Sharma <vipinsh@google.com> wr=
ote:
>
> Hi,
>
> This patch seris is extracted from
> https://lore.kernel.org/lkml/20221212183720.4062037-1-vipinsh@google.com/
> series.
>
> Specifically, patch 12 is taken out from there and now expanded in to
> this series.
>
> This patch series contains following changes:
>
> Patch 1 & 2:
>   Make a macro to clean up all KVM exit reason test assertion.
>
>   There are few places where explicit run->exit_reason are used but they
>   cannot be replaced with current macro.
>
>   I used following command KVM selftests directory and changed each
>   occurrence:
>     grep "run->exit_reason" -nir ./
>
> Patch 3:
>   This is from Sean Christopherson. Adding a macro to generate KVM
>   exit strings.
>
> Patch 4:
>   Sync KVM_EXIT_* reasons to sefltests. Many reasons are not present in
>   selftest code.
>
> v2:
> - Improve test assert message.
> - Add macro to generate KVM_EXIT_* reason strings.
> - Update selftests KVM_EXIT_ reasons to latest version.
>
> v1: https://lore.kernel.org/lkml/20221212183720.4062037-13-vipinsh@google=
.com/

Any update/feedback on this series?
