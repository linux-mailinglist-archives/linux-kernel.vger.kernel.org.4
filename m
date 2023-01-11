Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 247EE665088
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 01:47:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233179AbjAKAq6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 19:46:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235804AbjAKAqb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 19:46:31 -0500
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13D10140E0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 16:46:01 -0800 (PST)
Received: by mail-yb1-xb35.google.com with SMTP id g4so13532748ybg.7
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 16:46:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=l2ougN5/x15gvCtB3Pw8MVzkBzGrQBzCTZO1MDJna3U=;
        b=dqxMAaWtssx9K1H5FX09pFzD9GoIHzU/dheRbWMZaWJya7zGwdkYL3CHFEn+ryHeYp
         ilftBXKVBTQFDzZFMxCiHAtJVbQufVydT1BnrQSwFygY1PrmSNCPVVPuJlvxPi5NbAM2
         vJSjgkbUB4emZNgp138Sn1IrdVuF6SkgLJDDi9s1ISBKjsjWJnhSTNQj4bXlOp+USLkJ
         23QhQm2V+VUoyXLatB3rmLOwXUwd6FfFb+gV6fpldIjsBlQ85yN8S+h5k2TH52hKHjap
         LLCX9YXPirD+NXKTG87arOQJOhccbPO4Bdjtg0hCSB7QeEBymmBhapSdSgNvb77Ykjmk
         hrZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l2ougN5/x15gvCtB3Pw8MVzkBzGrQBzCTZO1MDJna3U=;
        b=pNSrobDj4Q1bd92Kdo6mGqY65J7kVo561tv01JjzY3o8RweYiqoEJp/HCzjrdxE31y
         AMDGp/dYNzOg93t1LuSPF8YjD2mNUjIlZguaF4/5RgUnJJSm3cRBNKTQFWgVbAwXCP+a
         kT9GeZExS3BEsSfDbCpnyXagfLbDynSJRmk3D2wtZlUU+wWOAB4HUEymcJlE78DH8MnP
         q5bJoe5jqGMvusc0GMz2DVlx56nsw1Pj6xRoBDvWs/Jq2oiBlPAjpHjqW+yoYyuFaxxG
         sc46EFowWb3tQIXHp78qP2Eva7WrkoWU+0w78ezSCeIHnG+anh4/U10j9CUgJ4MVZe5N
         Ik/Q==
X-Gm-Message-State: AFqh2kouNVpEVP8GZNlnlSUf0vDYq87wHbwWtSsq4utukWVu66s8BL17
        15gadNpyOzHgLWRdUuus4PNqf00TAnl0LHfk/pGfMg==
X-Google-Smtp-Source: AMrXdXvdkiDzfqLeCw6NlC0GVoM6hUnBCNWCQzEgrFtLCaiTjm2bldy5ouIi3fiALXyjDX48W5xOfDOnAEkbU/9bqnE=
X-Received: by 2002:a5b:c12:0:b0:7ba:3553:61f8 with SMTP id
 f18-20020a5b0c12000000b007ba355361f8mr1188591ybq.123.1673397960755; Tue, 10
 Jan 2023 16:46:00 -0800 (PST)
MIME-Version: 1.0
References: <20230110215203.4144627-1-vipinsh@google.com> <CANgfPd8g+-QiNr-m4uS-=_baWwOT8gMvTedR-cDJud7_aWK-yQ@mail.gmail.com>
In-Reply-To: <CANgfPd8g+-QiNr-m4uS-=_baWwOT8gMvTedR-cDJud7_aWK-yQ@mail.gmail.com>
From:   Vipin Sharma <vipinsh@google.com>
Date:   Tue, 10 Jan 2023 16:45:24 -0800
Message-ID: <CAHVum0dvHP3hACsWpXZ9h-agTBqbhCB5YzJkXbO332xKxhzwag@mail.gmail.com>
Subject: Re: [Patch] KVM: selftests: Make reclaim_period_ms input always be positive
To:     Ben Gardon <bgardon@google.com>
Cc:     seanjc@google.com, pbonzini@redhat.com, kvm@vger.kernel.org,
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

On Tue, Jan 10, 2023 at 2:19 PM Ben Gardon <bgardon@google.com> wrote:
>
> On Tue, Jan 10, 2023 at 1:52 PM Vipin Sharma <vipinsh@google.com> wrote:
> >
> > reclaim_period_ms used to be positive only but the commit 0001725d0f9b
> > ("KVM: selftests: Add atoi_positive() and atoi_non_negative() for input
> > validation") incorrectly changed it to non-negative validation.
> >
> > Change validation to allow only positive input.
> >
> > Signed-off-by: Vipin Sharma <vipinsh@google.com>
> > Reported-by: Ben Gardon <bgardon@google.com>
>
> Please add a Fixes: tag:
> Fixes: 0001725d0f9b ("KVM: selftests: Add atoi_positive() and
> atoi_non_negative() for input validation")

Forgot this, I will send v2. Thanks.

>
> But otherwise,
> Reviewed-by: Ben Gardon <bgardon@google.com>
>
> > ---
> >  tools/testing/selftests/kvm/x86_64/nx_huge_pages_test.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/tools/testing/selftests/kvm/x86_64/nx_huge_pages_test.c b/tools/testing/selftests/kvm/x86_64/nx_huge_pages_test.c
> > index ea0978f22db8..251794f83719 100644
> > --- a/tools/testing/selftests/kvm/x86_64/nx_huge_pages_test.c
> > +++ b/tools/testing/selftests/kvm/x86_64/nx_huge_pages_test.c
> > @@ -241,7 +241,7 @@ int main(int argc, char **argv)
> >         while ((opt = getopt(argc, argv, "hp:t:r")) != -1) {
> >                 switch (opt) {
> >                 case 'p':
> > -                       reclaim_period_ms = atoi_non_negative("Reclaim period", optarg);
> > +                       reclaim_period_ms = atoi_positive("Reclaim period", optarg);
> >                         break;
> >                 case 't':
> >                         token = atoi_paranoid(optarg);
> > --
> > 2.39.0.314.g84b9a713c41-goog
> >
