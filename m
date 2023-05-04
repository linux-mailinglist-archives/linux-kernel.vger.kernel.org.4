Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A8D56F71F1
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 20:27:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbjEDS1K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 14:27:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbjEDS1I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 14:27:08 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83BC165BF
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 11:27:07 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id e9e14a558f8ab-33124b0dd85so591425ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 May 2023 11:27:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683224827; x=1685816827;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ikJLj9UcZMZg1J2stu5wI6bhIEl+t7Zsf0nTDY3caoE=;
        b=EZPArdHukXu5W/pYa8vFfG/PWnoZ0IyWqqb7mVWfoCHOqqfPXfoDVf7QoCTJ1ksTQc
         107SD0StxNzFc1Z7FC4+BsXY3TGiEoIeoSGNNdh4s+BzBd5ELVf9iw+i8uh3yilDpr3v
         LJl5vSudldj9Vws/6OVaqAmpbWeCt3bDvo3WrdfR2PrYaQK/Fq6pAerYXytGe4DOKmHL
         SKCXp21iLL4DaDLO0k0vFMke50hpL0mZZosioUkQyFzKWEkv9z8Pzz4sBPz/wIr3hiPd
         JmljBoyTbobx9V3y5c2W1qdspSVAkacM2yzf1SGUJh5QM6Su9GA3UZBW8JjAKz9ei4lt
         b9RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683224827; x=1685816827;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ikJLj9UcZMZg1J2stu5wI6bhIEl+t7Zsf0nTDY3caoE=;
        b=hw4ZadQsS/MNSeTS0rsSRU2yBGurSSw/eiBKApgQJjbmj5csrbDLS4SUeeGxhngPkV
         GpU8/h3JLt99bfai0OFPJhTNuIFd93htqVyhoXkWCQ4gXHUVD9EO8SefSaX/TbO2fxbT
         aO9gTTfc6nuD1fKcJeJJlGJTTASbuIApa1FShvEvoDYRwBjPAJcyuyErp6zb3dRxdY0n
         DH7ItFJRXOQORfFZcrchYmUrcRTm1nfYfJIU7RlhU1mR7gEfiOBdJczvZtSg/mHCpNHW
         6a3tAqqv3yPxd9b3tGndE9erVoFdhboygjPw9g1d6V28o6q/GlHlYUbb0Zb3y+WXLFYG
         xv5Q==
X-Gm-Message-State: AC+VfDw7QxzbYlIK5A5B+C6YFdAU6uAo788MFSHmFlWwdSCyPsyz1BEm
        kb3iv0oXesKFP2+a195HSrUTgKDILsgGRWxv6jvXzg==
X-Google-Smtp-Source: ACHHUZ6HQCdVSvYjHE6dxuc8pZ903Fq+99b6WDsuKo2BI4pyzTS1H9h7u31RIiw3QXPwJmhLlsyljMAK+cZPJPri0VM=
X-Received: by 2002:a05:6e02:12ce:b0:322:848b:6c53 with SMTP id
 i14-20020a056e0212ce00b00322848b6c53mr18499ilm.14.1683224826598; Thu, 04 May
 2023 11:27:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230504181827.130532-1-mizhang@google.com>
In-Reply-To: <20230504181827.130532-1-mizhang@google.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Thu, 4 May 2023 11:26:55 -0700
Message-ID: <CALMp9eStwQAznFpNnAnNXzcj+4Gev3hP-XtAeUWqpJdtY5tShA@mail.gmail.com>
Subject: Re: [PATCH v2] KVM: VMX: add MSR_IA32_TSX_CTRL into msrs_to_save
To:     Mingwei Zhang <mizhang@google.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 4, 2023 at 11:18=E2=80=AFAM Mingwei Zhang <mizhang@google.com> =
wrote:
>
> Add MSR_IA32_TSX_CTRL into msrs_to_save[] to explicitly tell userspace to
> save/restore the register value during migration. Missing this may cause
> userspace that relies on KVM ioctl(KVM_GET_MSR_INDEX_LIST) fail to port t=
he
> value to the target VM.
>
> In addition, there is no need to add MSR_IA32_TSX_CTRL when
> ARCH_CAP_TSX_CTRL_MSR is not supported in guest. So add the checking in
> kvm_probe_msr_to_save().
>
> Fixes: b07a5c53d42a ("KVM: vmx: use MSR_IA32_TSX_CTRL to hard-disable TSX=
 on guest that lack it")
> Reported-by: Jim Mattson <jmattson@google.com>
> Signed-off-by: Mingwei Zhang <mizhang@google.com>
Reviewed-by: Jim Mattson <jmattson@google.com>
