Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCB5872448C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 15:36:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237722AbjFFNgR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 09:36:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237609AbjFFNgN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 09:36:13 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9859C10D1
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 06:36:12 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id d75a77b69052e-3f9a81da5d7so235331cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 06:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686058572; x=1688650572;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jlVR62cA6mu9AUFB8C/tzofTcjJ3I5Rt6AhVQL0tGc0=;
        b=vdxwTxoflDna2Zhs+mQuJbCevS8VechxmXlE/1SUqb8U5LL9ixzfQocOFrQhhkOIOD
         /LR2KJzVWTf519t/JrI4DmMuXSuJPejdbvChBQTt6tnMHb6Bn4sLZw8HSr9zKtqrl+xw
         8K0Y97moSACxTFlguufITAeSGmLhqPtS6biv+gP5t7EWVDY5ntjuTOscvmKJP+ELVJaQ
         nGrKxnxSWtjt/m5jZrFfRqH5rx5W03AEztVsjgzea/Z5auvw+GIDFo2CO3vtIgexXZKV
         Ew5q/XYAbLmIjhmQZH8UvPLUEoZLjyGuMRT+jRTnG/TpeA76oiiZdvFDbj4E5i6VX2Ko
         GVvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686058572; x=1688650572;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jlVR62cA6mu9AUFB8C/tzofTcjJ3I5Rt6AhVQL0tGc0=;
        b=BxM6Ks80I6hZerfkZ31A2q7bsr+nildDTli9xbT58uRGGE8ZwFN072j1vxn/R16bgM
         dFFYoTYdV2hEYG785acf2OYZxqM38/IJi1HYNNeYKMtE0jENLZPTBMD5ZBebnKc1eDeV
         r/8Dsd31JxJpd12Qcc6InJOO51Nuns7VZwyB6lRGOyvTpGa2hK6V4Ug8UKGXNm0s88xT
         oFaIvpRwDVEarSqPfWFKqdR85CUQW6s0FU5HMCv1WggYf3za245tKk6MpMTmyrg0tAs1
         igEod2++spxugm8ybrv0VbJiRLAC7fiD1m6alvgA1/DB3Hw5lNAo45R1HiTuOQbIxPvZ
         8rrw==
X-Gm-Message-State: AC+VfDzYVtOTn5GEbcIndCghamVou4RLMRg6JKsEZsOCMltQTeidYuoS
        SFJKhzvJPYZ3c95yQ3nKRC1lqZjJWeeMOZDlqzt8Vg==
X-Google-Smtp-Source: ACHHUZ6GX/U5Qh0RCiW2I8umCHsTaWvxU6NXVJ7f1nFmu9duL9A57HAgFKfM1x97nvyXMUlkE4dNcYRX1cq1PE3vhjs=
X-Received: by 2002:a05:622a:1a9f:b0:3e0:c2dd:fd29 with SMTP id
 s31-20020a05622a1a9f00b003e0c2ddfd29mr200195qtc.4.1686058571603; Tue, 06 Jun
 2023 06:36:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230421141723.2405942-1-peternewman@google.com> <20230421141723.2405942-8-peternewman@google.com>
In-Reply-To: <20230421141723.2405942-8-peternewman@google.com>
From:   Peter Newman <peternewman@google.com>
Date:   Tue, 6 Jun 2023 15:36:00 +0200
Message-ID: <CALPaoCgF25n-Rnxxd-Pwo+675LLdSGt-sC2d7C2voS6ueNnL2A@mail.gmail.com>
Subject: Re: [PATCH v1 7/9] x86/resctrl: Assign HW RMIDs to CPUs for soft RMID
To:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>
Cc:     Babu Moger <babu.moger@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Stephane Eranian <eranian@google.com>,
        James Morse <james.morse@arm.com>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 21, 2023 at 4:18=E2=80=AFPM Peter Newman <peternewman@google.co=
m> wrote:
>  static void clear_closid_rmid(int cpu)
>  {
>         struct resctrl_pqr_state *state =3D this_cpu_ptr(&pqr_state);
> @@ -604,7 +636,12 @@ static void clear_closid_rmid(int cpu)
>         state->default_rmid =3D 0;
>         state->cur_closid =3D 0;
>         state->cur_rmid =3D 0;
> -       wrmsr(MSR_IA32_PQR_ASSOC, 0, 0);
> +       state->hw_rmid =3D 0;
> +
> +       if (static_branch_likely(&rdt_soft_rmid_enable_key))
> +               state->hw_rmid =3D determine_hw_rmid_for_cpu(cpu);

clear_closid_rmid() isn't run at mount time, so hw_rmid will be
uninitialized on any CPUs which were already enabled. The static key
was originally set at boot.

(the consequence was that domain bandwidth was the amount recorded on
the first CPU in the domain multiplied by the number of CPUs in the
domain)
