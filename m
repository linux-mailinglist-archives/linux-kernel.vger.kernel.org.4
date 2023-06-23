Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB96A73BB7F
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 17:20:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231830AbjFWPUg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 11:20:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231755AbjFWPTv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 11:19:51 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42FE52112
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 08:19:49 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id d75a77b69052e-40079b6fc56so213701cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 08:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687533588; x=1690125588;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k9o7YVEzoV5lz+8vLzrqhGQ2D/1rlU+02uMgaoqMDIE=;
        b=XOZa9v/7zkAy73pr3ZosKiB+YlVu1jh81K1h3okUGFyHrTz3LBIiwz9T7hZZYuYYoP
         1eJXPInd8MxtXYaRsw3/KyCOmOCEOd4vH//EOjT3V1LeHr9MjT6UKbp9Wz7taUTe9er9
         HvdSX2AdFgfPC1+iC8ASCipcxIuLrvmfGn7ikZ2wffnpoFwOXYpNpkkZeeeiTnHw8UEl
         FuIKXZes0KemJ79vfVC7K8DTPCIJNd0cc8Ml8Ax7SgBqks232XTp2TBiapLSkhzGSvjK
         gO0L5GkCvIadtQSpbolNbX4PFQAuIaaPbCJmPwv2afZ0sDJ+WKTKlaYYJyahHnJOvmAd
         /xWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687533588; x=1690125588;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k9o7YVEzoV5lz+8vLzrqhGQ2D/1rlU+02uMgaoqMDIE=;
        b=gfHQ4R8G1tgZXymsGlvTO8eZnQ1CDrymbTZmHw6zHZ0ITWrKnkZaih6GZfNqi61JkP
         bi5ge1m3tTZb4BbSUNOsawuVJM8oJtqG69oRZZP039/AbNGdJ5rCG26rfTmH41SD1G45
         uhLPk8nAS3Ndu4NGZjHiyGoUgN3WXu0dATqOu1AaRQGJYP2Q3lFXNJGekVl8eiP7QBRV
         xzDPzEMv5jmb4Gn4ASSikHD1utLg3D4nHpQGLDQpaEr1v50PxXUuVa+VIUhdisEqzO05
         KC3BE3R2CnmhgFJs/ppTO6U78rNv9g7fyZp+HPzibBMdKDtkwDPVodVScigRXzepEIj3
         EXOQ==
X-Gm-Message-State: AC+VfDz1sVznnfqZEeWamm93E7/a7EO2Z+oGZrsrt0AmtRcgFfPc9XXw
        YOHwNlxDsvlLapV2MH+TdkTHQAADxe7sgzIc7IpeJg==
X-Google-Smtp-Source: ACHHUZ6CDS5pW+9OsHA6eKMXUWXt6u0FtfKRp+ZdZdMi3tmcJaNbZ2dNV8prqFcjyEwsBEWAfs/EzXe+4ASIB+DlLV8=
X-Received: by 2002:ac8:5952:0:b0:3ef:5f97:258f with SMTP id
 18-20020ac85952000000b003ef5f97258fmr143411qtz.16.1687533588350; Fri, 23 Jun
 2023 08:19:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230621174006.42533-1-tony.luck@intel.com> <20230621174006.42533-8-tony.luck@intel.com>
 <CALPaoCgF04M0Jc-c4VmbKkRSFo677SBGoPHzNCSeQ4S6Bqb60w@mail.gmail.com> <SJ1PR11MB60836CD7493B0EAF0F687051FC22A@SJ1PR11MB6083.namprd11.prod.outlook.com>
In-Reply-To: <SJ1PR11MB60836CD7493B0EAF0F687051FC22A@SJ1PR11MB6083.namprd11.prod.outlook.com>
From:   Peter Newman <peternewman@google.com>
Date:   Fri, 23 Jun 2023 17:19:37 +0200
Message-ID: <CALPaoCiaknUMSU4CunSQrRP=WS8DAbToVo5jibh8TaWNZXGMbQ@mail.gmail.com>
Subject: Re: [PATCH v2 7/7] x86/resctrl: Determine if Sub-NUMA Cluster is
 enabled and initialize.
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     "Yu, Fenghua" <fenghua.yu@intel.com>,
        "Chatre, Reinette" <reinette.chatre@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "x86@kernel.org" <x86@kernel.org>,
        Shaopeng Tan <tan.shaopeng@fujitsu.com>,
        James Morse <james.morse@arm.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Babu Moger <babu.moger@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>,
        "Eranian, Stephane" <eranian@google.com>
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

Hi Tony,

On Thu, Jun 22, 2023 at 6:02=E2=80=AFPM Luck, Tony <tony.luck@intel.com> wr=
ote:
>
> > Unfortunately I'm not getting as good of results with the new series.
> > The main difference seems to be updating the 0xca0 MSR instead of
> > applying the offset to PQR_ASSOC.
>
> I think I may have reversed the actions to update the MSR in one of
> my refactor/rebase. The comment here is correct, but that's not
> what the code is doing :-(
>
> Can you swap the bodies of these two functions and retest?

It's a small improvement, but still not great. Still only node 0
giving believable results, but at least no more empty results from the
second package.

I poked around in /proc/kcore and noticed that my snc_ways is still 1, thou=
gh.

-Peter
