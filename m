Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D1EF6B97E4
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 15:25:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231356AbjCNOZv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 10:25:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231578AbjCNOZi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 10:25:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2E41A0B2A
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 07:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678803821;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Jx4JVPY896aCKLGwQPeuaMvO9tkn3iw26/kjnwKQS2Q=;
        b=fEeymHWEwFUWAK+SL/ts4ij9qGWmP7E9PIbk/X9e8LIjLBCtBKJT/c9XFt18YOZHFXeaJg
        qmkRYWbhhBeElB2otKSuZWGQb73NfW7vMjeK7bXOPlsZu8WGW3XlCT/t8mSWSvWl03e5+l
        0o08idk3C50VsgWZc7Bipai7HAyL+ZQ=
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com
 [209.85.222.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-335-Tf5v3-jrOqeQy-wnAv7B_g-1; Tue, 14 Mar 2023 10:23:20 -0400
X-MC-Unique: Tf5v3-jrOqeQy-wnAv7B_g-1
Received: by mail-ua1-f71.google.com with SMTP id b7-20020ab030a7000000b00748d9ab97ffso4035128uam.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 07:23:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678803793;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jx4JVPY896aCKLGwQPeuaMvO9tkn3iw26/kjnwKQS2Q=;
        b=XkBGDjxS9+xvKJYQhnCZfUiXP+sb3sSp88zrG/7sPn79s7aPMtwpfAlF9S7O0uVhMN
         iZqYSd7h6DHYqbhl0BMgUT2vLYHQ0bLGIh4zNgA4Xb/Ti5sDGZQ+BnYM2MY7mws3sObB
         P/+qiEEznEx0nsjbRGLQpt6yihtwE+xBWRKkooOcZbbUG7FPTeWP9szE69Z4Vt0+otWl
         U0nw8hEz3A29SHl+OFwmUbfxWVXjpHX0enBmtRZe0V/7NvphG3eLpX3BBKLNjRhWunvI
         AdJ/uFP48ujKLHQ1bOnswIM8RL7Ug8fYejxN1U9f5GqlnPB9DEK6oq2yWrkN1QSzUN8u
         4daw==
X-Gm-Message-State: AO0yUKWKr7XHi8b4EusSfvUb2WwRuYPck+1dFiIERw5XAFqq9goKJ+8A
        FNu5b2cej9QHHATanx0Gmu35LFbuDT5epS/DILm8Zgw6aiBIjawdGFjKIQYs+Y+W7tzXDwaaLIx
        hbuMVE+X9Yv4Xb/4IOtGH4XRzqxqtv4akY/8rjRQA
X-Received: by 2002:a67:e05b:0:b0:425:a606:e3f4 with SMTP id n27-20020a67e05b000000b00425a606e3f4mr1397196vsl.1.1678803792953;
        Tue, 14 Mar 2023 07:23:12 -0700 (PDT)
X-Google-Smtp-Source: AK7set8OP0lYxIV15A1h0gT3msH7c8mvZy2vE2+353B52ysHZ5f4XcuBW6k9OoR5b4o5wpO6YpSwM41YvAF4syER+6c=
X-Received: by 2002:a67:e05b:0:b0:425:a606:e3f4 with SMTP id
 n27-20020a67e05b000000b00425a606e3f4mr1397179vsl.1.1678803792660; Tue, 14 Mar
 2023 07:23:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230131181820.179033-1-bgardon@google.com> <CABgObfaP7P7fk66-EGF-zPEk0H14u3YkM42FRXrEvU=hwFSYgg@mail.gmail.com>
In-Reply-To: <CABgObfaP7P7fk66-EGF-zPEk0H14u3YkM42FRXrEvU=hwFSYgg@mail.gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Date:   Tue, 14 Mar 2023 15:23:01 +0100
Message-ID: <CABgObfYAStAC5FgJfGUiJ=BBFtN7drD+NGHLFJY5fP3hQzVOBw@mail.gmail.com>
Subject: Re: [PATCH V5 0/2] selftests: KVM: Add a test for eager page splitting
To:     Ben Gardon <bgardon@google.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Peter Xu <peterx@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        David Matlack <dmatlack@google.com>,
        Vipin Sharma <vipinsh@google.com>,
        Ricardo Koller <ricarkol@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 14, 2023 at 2:27=E2=80=AFPM Paolo Bonzini <pbonzini@redhat.com>=
 wrote:
> I have finally queued it, but made a small change to allow running it
> with non-hugetlbfs page types.

Oops, it fails on my AMD workstation:

$ tools/testing/selftests/kvm/x86_64/dirty_log_page_splitting_test
Testing guest mode: PA-bits:ANY, VA-bits:48,  4K pages
guest physical test memory: [0x7fc7fe00000, 0x7fcffe00000)
=3D=3D=3D=3D Test Assertion Failure =3D=3D=3D=3D
  x86_64/dirty_log_page_splitting_test.c:195: __a =3D=3D __b
  pid=3D1378203 tid=3D1378203 errno=3D0 - Success
     1    0x0000000000402d02: run_test at dirty_log_page_splitting_test.c:1=
95
     2    0x000000000040367c: for_each_guest_mode at guest_modes.c:100
     3    0x00000000004024df: main at dirty_log_page_splitting_test.c:245
     4    0x00007f4227c3feaf: ?? ??:0
     5    0x00007f4227c3ff5f: ?? ??:0
     6    0x0000000000402594: _start at ??:?
  ASSERT_EQ(stats_populated.pages_4k, stats_repopulated.pages_4k) failed.
    stats_populated.pages_4k is 0x413
    stats_repopulated.pages_4k is 0x412

Haven't debugged it yet.

Paolo

