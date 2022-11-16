Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 303F262C600
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 18:11:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233843AbiKPRLQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 12:11:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233487AbiKPRLM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 12:11:12 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AE1131DEF
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 09:11:11 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id u2so22654009ljl.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 09:11:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kiC7RcvDp4j1Nywj/I5si8pWeK03C2D9v7OQXcuQlU8=;
        b=fbznQZLOrgbgYH/OdcRO7wFzmzzIM+2dE9dMzTulJf9Da72gim+eUaPuLqfuL+AjlN
         QrSgfzGMgX6QWzU/0aYesFkpfuMZTyCvMS9uQXJ/7IKgtK8+QyD4TQIJgn8eouuZmHnS
         vFrIndtIOwm4koi+hjeInq8MSBzy3icwwQXYLnSKxCwr2muKlT8cAt4V6Kp9JOXYmOJo
         dWMvqZBC3QkBC01HkWKXC2Tc2VF/GymN7EKJsXdqTP8pGKpzILXyfwxIthibAD0J/XxK
         mPKGBTHnUIQ8+VKdSJri5G7dED9zCNQVUXy0JGSVoEgUirL3+hWnHlx2jditJ6GT8S7N
         77Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kiC7RcvDp4j1Nywj/I5si8pWeK03C2D9v7OQXcuQlU8=;
        b=2/gH0DWNDMmwX/BYz6LPsI2jtVAEH/Xei8oK9mLi//+V9hbarqYaRaD+XR9TU4g5uQ
         Fs7j3Lv0IOz/BWOPZpNy2GgjO2kXUum+hcLYYaYKb8rCpTTeCi63V3+96a0dcWQcRLEs
         geFQoJMcXNUPWDoJDyzIlHJXi6oapDaobdECG+OzYbIF2R+yI178werSjyPxUKsssHKq
         30pnLgSaZLG3ss4j1qhN5/wqFtc/LeFM4CcCpBsvPtTh59kydoGqF3Wh8R8K024PoaNV
         iThMy+tkDbpheCoxcE5nuZw7fCTGq/haq5RXD6Zc18hPeMO+fz0RrhzVIyZgpf/bTrjh
         ykHQ==
X-Gm-Message-State: ANoB5pk/RglllFEMAndwPiNlbLC8GnuyVR/tZfIXP4/Pn7MevlhWraC/
        YuSD/4UFtP8Lef6JxEmw5w+QX2cRKlklyrYays6tIA==
X-Google-Smtp-Source: AA0mqf5T2RFObI8itlUC3PibUv8+EsGZJPupUvUjMtBjbytILuxP6y5BYmgIiWpwBopA3nq9dv5pKqHv15/zPTstMv4=
X-Received: by 2002:a2e:a41a:0:b0:278:ebb5:ddd2 with SMTP id
 p26-20020a2ea41a000000b00278ebb5ddd2mr7400827ljn.494.1668618669724; Wed, 16
 Nov 2022 09:11:09 -0800 (PST)
MIME-Version: 1.0
References: <20221103152318.88354-1-pgonda@google.com> <Y258U+8oF/eo14U+@zn.tnic>
 <CAMkAt6o-jcG7u1=zw4jJp5evrO4sFJR-iG_ApF7LhT+7c55_Wg@mail.gmail.com>
 <Y3TVcJnQ/Ym6dGz2@zn.tnic> <CAMkAt6qQmkufbuotzMA4bMJaA4uBFMdk8w7a3X+OH3JaOdFepA@mail.gmail.com>
 <bc070ef7-8168-f1fc-f5ec-aeac204f2ef6@amd.com>
In-Reply-To: <bc070ef7-8168-f1fc-f5ec-aeac204f2ef6@amd.com>
From:   Peter Gonda <pgonda@google.com>
Date:   Wed, 16 Nov 2022 10:10:58 -0700
Message-ID: <CAMkAt6rHTgJX1KTjYmbii6dyG7QMxXJxNy1E_eZ8vRWLK9Vc1g@mail.gmail.com>
Subject: Re: [PATCH V4] virt: sev: Prevent IV reuse in SNP guest driver
To:     Tom Lendacky <thomas.lendacky@amd.com>
Cc:     Borislav Petkov <bp@suse.de>,
        Dionna Glaze <dionnaglaze@google.com>,
        Michael Roth <michael.roth@amd.com>,
        Haowen Bai <baihaowen@meizu.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        Marc Orr <marcorr@google.com>,
        David Rientjes <rientjes@google.com>,
        Ashish Kalra <Ashish.Kalra@amd.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
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

On Wed, Nov 16, 2022 at 9:58 AM Tom Lendacky <thomas.lendacky@amd.com> wrot=
e:
>
> On 11/16/22 10:23, Peter Gonda wrote:
> > On Wed, Nov 16, 2022 at 5:20 AM Borislav Petkov <bp@suse.de> wrote:
> >>
> >> On Tue, Nov 15, 2022 at 02:47:31PM -0700, Peter Gonda wrote:
> >>>>> +      * certificate data buffer retry the same guest request witho=
ut the
> >>>>> +      * extended data request.
> >>>>> +      */
> >>>>> +     if (exit_code =3D=3D SVM_VMGEXIT_EXT_GUEST_REQUEST &&
> >>>>> +         err =3D=3D SNP_GUEST_REQ_INVALID_LEN) {
> >>>>> +             const unsigned int certs_npages =3D snp_dev->input.da=
ta_npages;
> >>>>> +
> >>>>> +             exit_code =3D SVM_VMGEXIT_GUEST_REQUEST;
> >>>>> +             rc =3D snp_issue_guest_request(exit_code, &snp_dev->i=
nput, &err);
> >>>>> +
> >>>>> +             err =3D SNP_GUEST_REQ_INVALID_LEN;
> >>>>
> >>>> Huh, why are we overwriting err here?
> >>>
> >>> I have added a comment for the next revision.
> >>>
> >>> We are overwriting err here so that userspace is alerted that they
> >>> supplied a buffer too small.
> >>
> >> Sure but you're not checking rc either. What if that reissue fails for
> >> whatever other reason? -EIO for example...
> >
> > If we get any error here we have to wipe the VMPCK here so I thought
>
> More accurate to say that you will wipe the VMPCK, since the value of rc
> is checked a bit further down in the code and the -EIO (or other non-zero=
)
> will be result in a call to snp_disable_vmpck() and rc being propagated
> back to the user as an ioctl() return code.
>
> Might be worth a comment above that second snp_issue_guest_request()
> explaining that.

I'll add a comment above the second snp_issue_guest_request(), good idea th=
anks.

I think another comment above the first snp_issue_guest_request()
could help too. Saying once we call this function we either need to
increment the sequence number or wipe the VMPCK to ensure the
encryption scheme is safe.

>
> > this always override @err was OK.
> >
> > I can update this to only override @err if after the secondary
> > SVM_VMGEXIT_GUEST_REQUEST rc and err are OK. Thoughts?
>
> I think it's ok to set it no matter what, but I don't have a strong
> opinion either way.
>
> Thanks,
> Tom
>
> >
> >>
> >> --
> >> Regards/Gruss,
> >>      Boris.
> >>
> >> SUSE Software Solutions Germany GmbH
> >> GF: Ivo Totev, Andrew Myers, Andrew McDonald, Martje Boudien Moerman
> >> (HRB 36809, AG N=C3=BCrnberg)
