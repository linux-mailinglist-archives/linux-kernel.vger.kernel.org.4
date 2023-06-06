Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ABEA723C28
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 10:49:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237267AbjFFIt4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 04:49:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237287AbjFFItu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 04:49:50 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 991E0EA
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 01:49:49 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id d75a77b69052e-3f9a81da5d7so184971cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 01:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686041389; x=1688633389;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t+giJv4q8xwL1uh7HgsStC/LdZwc68W1gk/9rNonGFk=;
        b=KTDe/AQn2rkST076eM6v5NeyVIkELfJMgLhd3UE6bHtoPCbt4IzKswJOSTnqQah6QY
         DgTQzwoqnlCGth95pAtCNs3GhL0YWPM/JADH3ximdmt3+MgNngoeb/n0EyabLpR5y+71
         HJ0Ek+LuMZ1i9dSmzeug0lH6HGfo0GzP/SOsNgnBznCdblikUrSPDi3X6e+6EfLw+UaU
         qzXxXlFKjF6xZALlNcR/BPqZOlHl176F/srAQwnfSbwUJfEmKP+cRL5OWKLJv6yEyONI
         CK9QelC0zIl/P4767IgxKvMUwyjvJWeauzqoGFqAddn8UbCIa1jIQ0R1fg/OGybu38s+
         4G4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686041389; x=1688633389;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t+giJv4q8xwL1uh7HgsStC/LdZwc68W1gk/9rNonGFk=;
        b=jiNgf/5P048KZCC2i/9XksUUg5JSmxOOpZJU5zwbHjMolGv9ZqEaq90v2OeHMUhx0l
         ia6Z/sJhOUH37TqoO6OGUk+f/H6FUKz22zltP1nnPenq9HZp0Gg/ukXh8wlGX2gDf0aX
         FCl/+RmO7EXid1cSoOyyTy8knpHup7Oy1rpTesGLiFQ0EAmHxX9B3e2/Z+L4F6uz6FFO
         2oYAV/uOtBgliahqw1bNflzELISLj1iSBNPeoDIxta4NUuDd6nh0jA3YiWtbkpJcNZtD
         E4WQ4l/kj9G8fM8W0h/YFcC2mItJfwo5+0lMDkz++h03ZKtQyBSFC6tfs6LtndBlE6I9
         K5lg==
X-Gm-Message-State: AC+VfDyE1uHkRRFo2kM3UQcW551cpyAUJwWm2vUrHOhhRlTXt6S72tOK
        p6vCB1EYnOiwnGJHuwYvvh2NI44sBqqYE4jgPcrRgw==
X-Google-Smtp-Source: ACHHUZ6b9tVGLdvTytPaGPfvkZkX+F8ZZu9njisW9Mx1IQ18P7+fYLdg7lRbhYivfjwhC7Jy88/quTQtkOvdWpTm0Bc=
X-Received: by 2002:ac8:7f03:0:b0:3f4:f841:df89 with SMTP id
 f3-20020ac87f03000000b003f4f841df89mr119162qtk.1.1686041388686; Tue, 06 Jun
 2023 01:49:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230525180209.19497-1-james.morse@arm.com> <20230525180209.19497-13-james.morse@arm.com>
In-Reply-To: <20230525180209.19497-13-james.morse@arm.com>
From:   Peter Newman <peternewman@google.com>
Date:   Tue, 6 Jun 2023 10:49:37 +0200
Message-ID: <CALPaoCjLjngabG32m4X8sSwK-bbZ28oL6BVKSn_dFnDwPzkDkg@mail.gmail.com>
Subject: Re: [PATCH v4 12/24] x86/resctrl: Make resctrl_arch_rmid_read() retry
 when it is interrupted
To:     James Morse <james.morse@arm.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Babu Moger <Babu.Moger@amd.com>,
        shameerali.kolothum.thodi@huawei.com,
        D Scott Phillips OS <scott@os.amperecomputing.com>,
        carl@os.amperecomputing.com, lcherian@marvell.com,
        bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
        xingxin.hx@openanolis.org, baolin.wang@linux.alibaba.com,
        Jamie Iles <quic_jiles@quicinc.com>,
        Xin Hao <xhao@linux.alibaba.com>, dfustini@baylibre.com
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

Hi James,

On Thu, May 25, 2023 at 8:03=E2=80=AFPM James Morse <james.morse@arm.com> w=
rote:
> +interrupted:
> +       am =3D get_arch_mbm_state(hw_dom, rmid, eventid);
> +       if (am)
> +               start_msr_val =3D atomic64_read(&am->prev_msr);
> +
>         ret =3D __rmid_read(rmid, eventid, &msr_val);
>         if (ret)
>                 return ret;
>
>         am =3D get_arch_mbm_state(hw_dom, rmid, eventid);
>         if (am) {
> -               am->chunks +=3D mbm_overflow_count(am->prev_msr, msr_val,
> -                                                hw_res->mbm_width);
> -               chunks =3D get_corrected_mbm_count(rmid, am->chunks);
> -               am->prev_msr =3D msr_val;
> +               old_msr_val =3D atomic64_cmpxchg(&am->prev_msr, start_msr=
_val,
> +                                              msr_val);
> +               if (old_msr_val !=3D start_msr_val)
> +                       goto interrupted;
> +
> +               chunks =3D mbm_overflow_count(start_msr_val, msr_val,
> +                                           hw_res->mbm_width);
> +               atomic64_add(chunks, &am->chunks);
> +
> +               chunks =3D get_corrected_mbm_count(rmid,
> +                                                atomic64_read(&am->chunk=
s));
>         } else {
>                 chunks =3D msr_val;
>         }

It looks like if __rmid_read() is interrupted by an occupancy counter
read between writing QM_EVTSEL and reading QM_CTR, it will not perform
any update to am->prev_msr, and the interrupted read will return the
same counter value as in the interrupting read.

Maybe there's something you can create to check that's updated unconditiona=
lly?

-Peter
