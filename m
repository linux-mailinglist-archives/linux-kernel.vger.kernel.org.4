Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 127AC6F0C2F
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 20:57:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244346AbjD0S46 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 14:56:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243881AbjD0S44 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 14:56:56 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAD24420C
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 11:56:55 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id d2e1a72fcca58-63b5a2099a6so5962744b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 11:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682621815; x=1685213815;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p9U1SOsooYSm5KCVEU0yHDPxyWSN0e4LiuZonUnfDNQ=;
        b=zMSmc1aF1XSfdbFL9HyL9CCLydy6DCbFGZA1Fx3wFEhk6SvhtmFqDmo+JPEA6HACbb
         bFeiiFjVM+v+eJ1GHEIabtFjYtvaGKO+3U1/sZUBkssmoAoM3aGshZDRps+5cnDHQQFx
         84l0q+F5R/KTDUZcKKcRQAtY7ADo5KGcNvilWMeZw6t4mLahC302CxuXP2Y3kEp/ZLem
         PD9VktrgE1Au0nnNYrBb1FNgPkg1P5ndcLOOksuVLSajr4bQqD1DVG8rTbYCPqLisWis
         aiSgtSNs6JeqHssCoGvc+N1TbWmYvtVAfoqVwrgRw42nrFezkt2fU50nZVbF8rkLY0xO
         MfMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682621815; x=1685213815;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=p9U1SOsooYSm5KCVEU0yHDPxyWSN0e4LiuZonUnfDNQ=;
        b=LnFZCQqZWUm9v/2EjnvhEuesBcGdwKz+A5QpDtIaHek3f0BITYFVGVPdYEoOd9XtK8
         gkqV3Hkf/S9mc5Heeg+s7p3GIGjjM4DasvqFAHZdxgu2D6MRNSIrYA2y15eQosmiUwOs
         wbtbA+6QNdj0RHgMm5N12rQ/CzmGzXhTr1LvXVwMDGNg27tifZnhBw7G4oeLIU0hip1k
         aAQR0xIzkiKQE/14duejiPZoY7RjOgrLD3Kr4dI81pZ2VppB6rnDu+jvga70fUTs3iEG
         AGg7Ws9B8vf22JYfe6tUOad4suVpeLX811g2TXP4yT4r+KbSPpMRcIWlgbAs1RyUo8Yw
         7CRA==
X-Gm-Message-State: AC+VfDyzpBOMQv3+3z8OeV4YV8XeqDYFopmOmOnbXFR1bgvL4LZD7V/t
        dFQv7iPqY0KIogE8A/akkGLrpFU=
X-Google-Smtp-Source: ACHHUZ5nGhgEBGdm63F/rJ/qLbWgsbXGL2u6FeIYbcLBgTogbeWWOa9cLRA4k/cg98EGDX5Q/DFhtdI=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a05:6a00:80de:b0:63b:234e:d641 with SMTP id
 ei30-20020a056a0080de00b0063b234ed641mr729757pfb.4.1682621815279; Thu, 27 Apr
 2023 11:56:55 -0700 (PDT)
Date:   Thu, 27 Apr 2023 11:56:53 -0700
In-Reply-To: <CABRcYm+O-_GGhnAmJW6_=9vKeKSvzVLcxBRq3Pfjb3W0_HNjhw@mail.gmail.com>
Mime-Version: 1.0
References: <20230427143207.635263-1-revest@chromium.org> <CABRcYm+O-_GGhnAmJW6_=9vKeKSvzVLcxBRq3Pfjb3W0_HNjhw@mail.gmail.com>
Message-ID: <ZErFdVXHhEdJ/m3G@google.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: Update the aarch64 tests deny list
From:   Stanislav Fomichev <sdf@google.com>
To:     Florent Revest <revest@chromium.org>
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, kpsingh@kernel.org,
        mykolal@fb.com, martin.lau@linux.dev, song@kernel.org,
        xukuohai@huaweicloud.com, mark.rutland@arm.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/27, Florent Revest wrote:
> On Thu, Apr 27, 2023 at 4:32=E2=80=AFPM Florent Revest <revest@chromium.o=
rg> wrote:
> >
> > This patch updates the list of BPF selftests which are known to fail so
> > the BPF CI can validate the tests which pass now.
>=20
> Note: I tested this denylist a few months back by sending a manual PR
> to https://github.com/kernel-patches/bpf.
> At the time, it worked
> https://github.com/kernel-patches/bpf/actions/runs/4106542133/jobs/708551=
4761
> (even though there seemed to be a known flake in the gcc variant but
> unrelated to the new arch support)
>=20
> Every time I wanted to have the CI run on my PRs, I had to annoy Manu
> by email (I wouldn't have the rights to trigger the CI by myself
> otherwise). So I haven't tested this *actual* patch rebased on the
> current CI before sending it to the list. (e.g. the
> module_fentry_shadow test has been added since then and I just assumed
> it would pass in CI like the rest)
>=20
> My understanding is that this patch should soon be picked up by the
> testing bot and we can use that CI run to check that everything works
> as intended. Let's wait for a CI green light before merging this! :)
> If there are errors I'll send a v2

Looks green now:

Acked-by: Stanislav Fomichev <sdf@google.com>

https://github.com/kernel-patches/bpf/actions/runs/4822595792/jobs/85907322=
78
