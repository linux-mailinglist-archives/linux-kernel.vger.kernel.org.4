Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A56EE6C1D10
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 18:00:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233126AbjCTRAt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 13:00:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233450AbjCTRAM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 13:00:12 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 404A57DA2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 09:53:53 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id y184so9166503oiy.8
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 09:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679331168;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1e5Rkc1xXZveL9YUdD5abhg2y+JLZGAXin0mZccVnf4=;
        b=gnrwM3rvK6ih7m2hFKr6/1HS4fFHd+7OczbqHtTjdR+JtNAAXC3z4igtpKPqyzQ9a9
         /trz7ALGddy8zPVv6jGjZOHsKSwiA2ApBybwwu8oElO2uSgu3gA/l4F8gfPfaRM3r8FO
         3xwMU04R9iIyQCLsPBsFxYtFQbjTk60+b8yObejJG+eW8aFemnsaWigr6yLs06pgGCR6
         4Js2WeqnD4viBqbTecDW3U/0x/KyK7ykP6iXNkJGnlI5gK6i5lGU38mIqSzXWz/5NJoL
         k2t6Szw3YaFqOfyTEXrJDxAehDmIu+VRpZyeEA2GG+WWbbnJ7QW9S9jwcNpOiot7jtpP
         QQFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679331168;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1e5Rkc1xXZveL9YUdD5abhg2y+JLZGAXin0mZccVnf4=;
        b=TlqmfInqeF6lHectd9Kz1JpJJdEiyamq4Z/jJQqhNWPn4LwJ39rQhQD0NIIxqNNlKv
         8FsuaE5TShOpSP46PZE/Dw0JIuZchNLK63GN5bUPJZzY/zyWu9cPaV2/P6Tb00PrH4mc
         ShU40x3o/ZSLhBwmzc3WmPZkwzXTHXIOC8OCLeumdFLZNwx/BD8gwKhsmMu0AGOX+Ewi
         J0R1YLOCzr1VXPB4uwT88N9OMgMucM/Tzf31D+Xv/jdmhi2nTflU/FNEQhxnxrQVCUJb
         gpEZuAl/H/N8QJyNrFs1WNbkApcDaloPr/uTf5G8MaSAfyvCAJv/CJTAkKA5Y6V5LTng
         X0Ow==
X-Gm-Message-State: AO0yUKVru8WLC/BHI3Do4tHdHtlvn7Jy6VFdX+yvYXXIhuPBSDMgSWEU
        v69A7apAtPgnFnObulAu9Jc5FzG7JpsLjPnmdD512g==
X-Google-Smtp-Source: AK7set8/xrKGP6VMJRGxUiZj3oCNJdRO+eVrkzyh8Cbf4EwHf1wuzOrN2vO5hdvEeEmad7EPGQ3SjWkVqUDaseF2zpI=
X-Received: by 2002:aca:2b16:0:b0:384:27f0:bd0a with SMTP id
 i22-20020aca2b16000000b0038427f0bd0amr139057oik.9.1679331166593; Mon, 20 Mar
 2023 09:52:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230201132905.549148-1-eesposit@redhat.com>
In-Reply-To: <20230201132905.549148-1-eesposit@redhat.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Mon, 20 Mar 2023 09:52:35 -0700
Message-ID: <CALMp9eTt3xzAEoQ038bJQ9LN0ZOXrSWsN7xnNUD+0SS=WwF7Pg@mail.gmail.com>
Subject: Re: [PATCH 0/3] KVM: support the cpu feature FLUSH_L1D
To:     Emanuele Giuseppe Esposito <eesposit@redhat.com>
Cc:     kvm@vger.kernel.org, Ben Serebrin <serebrin@google.com>,
        Peter Shier <pshier@google.com>,
        Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Maxim Levitsky <mlevitsk@redhat.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
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

On Wed, Feb 1, 2023 at 5:29=E2=80=AFAM Emanuele Giuseppe Esposito
<eesposit@redhat.com> wrote:
>
> As the title suggest, if the host cpu supports flush_l1d flag and
> QEMU/userspace wants to boot a VM with the same flag (or emulate same
> host features), KVM should be able to do so.
>
> Patch 3 is the main fix, because if flush_l1d is not advertised by
> KVM, a linux VM will erroneously mark
> /sys/devices/system/cpu/vulnerabilities/mmio_stale_data
> as vulnerable, even though it isn't since the host has the feature
> and takes care of this. Not sure what would happen in the nested case tho=
ugh.
>
> Patch 1 and 2 are just taken and refactored from Jim Mattison's serie tha=
t it
> seems was lost a while ago:
> https://patchwork.kernel.org/project/kvm/patch/20180814173049.21756-1-jma=
ttson@google.com/
>
> I thought it was worth re-posting them.

What has changed since the patches were originally posted, and Konrad
dissed them?
