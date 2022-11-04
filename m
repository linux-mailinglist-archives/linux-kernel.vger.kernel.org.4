Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49DA3619DC2
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 17:51:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230153AbiKDQvd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 12:51:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232038AbiKDQvM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 12:51:12 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF9483E080
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 09:49:14 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id bs21so7878156wrb.4
        for <linux-kernel@vger.kernel.org>; Fri, 04 Nov 2022 09:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=aAs5rZHSGSQsXlUwWbd8TyKLYelB2yi0ItHv5X13qbU=;
        b=M2bRgeY24u7TyRQlXnsLbPyjNfu+Ho/7yCycn1LnhjTiP/Kn7MtXJNNZIucexBpkgM
         kugoRmyeiSyzRwVufXD5+3JxB8uD3E/pSb4JrkX7t234NhKqRAQx9jsNFWv5VeU//6WE
         zUrHh9HELZrcK+LbDkaBZw/l/D/Sq4jDE+QhJu+1qG6tQ0fi2BRToFbyYKa9ETZT+2k0
         4TjtuB/+e+hrdE0Kt92kdTQ2Z7gm7wwvlUpRREzryiSTgSACz/ayMZzEYR6ez3csscke
         rG4ActMX68WWhhnGSZYuaUR+cwoukPwjU0nKGIUIZwbZXIAfESeByERFq1Ncu3UX8a9V
         T9Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aAs5rZHSGSQsXlUwWbd8TyKLYelB2yi0ItHv5X13qbU=;
        b=Dop8TsFj0tk0UeDDc3DSZ6kD/6ggWQkFZRy/RAU2ZTrTfs1jbI+IJFXkqdw0ckPFf5
         YZ0o1jrroatlPxtD5//sJpIX+ITydq4J/tYGj0LtS6DjF6Zrdn0W+0Lh43fV0TIIoOcg
         Q/DRLd0MCis3CkXnULh/3X4wiDtLBYmc8FgKZ38SfeEYwghIhVxQtLWV9r+PxG0bRVsb
         vJCiAD1nqS0ZDq1TwIIJwjJe7acZZN1/feVldJlqEE69prDTkXV8+Hkoi5S+gTfkZFte
         JS1dMxtMtzHXscXLq5e5DRaEX6PNSf37gj7INXiFc0Y+u/3sSqNKnw6P1dolaZVwGovl
         O+Mg==
X-Gm-Message-State: ACrzQf2vXybOGqur9BtIk+bzTsFf/x8728Be524eaMcAguHE9CkWW3dH
        g8yXm/aCRA4bl+9/56X25A4MpzAug0pXnc+NMqU5xQ==
X-Google-Smtp-Source: AMsMyM7ncoUzg0qMJCCZdGfdxqGh69tHn8ZNDQ8QawadI4ZYCCzWRf+eIJsaO6bZQF0G4b5xqy0iA9qzYotAVvcOHjs=
X-Received: by 2002:a05:6000:22f:b0:236:4f8e:a913 with SMTP id
 l15-20020a056000022f00b002364f8ea913mr22746689wrz.240.1667580552893; Fri, 04
 Nov 2022 09:49:12 -0700 (PDT)
MIME-Version: 1.0
References: <20221019202843.40810-1-helgaas@kernel.org> <Y2RlxvPAvzVXtw9t@google.com>
 <8a23b1d3ee853cee73385e8144338f399cbe3165.camel@perches.com>
 <CAMn1gO7tEF+VioB8n0=8vQ4gRPKqSSfPwmbX8ci82D=hBbcfyw@mail.gmail.com> <5f982ebd7223369362e6e27d111704883c4d7e44.camel@perches.com>
In-Reply-To: <5f982ebd7223369362e6e27d111704883c4d7e44.camel@perches.com>
From:   Peter Collingbourne <pcc@google.com>
Date:   Fri, 4 Nov 2022 09:49:01 -0700
Message-ID: <CAMn1gO5Q=kcDwEnNhothZiRfMi09X0jTTmTbm7qrvSFQ6a7ivg@mail.gmail.com>
Subject: Re: [PATCH] checkpatch: add warning for non-lore mailing list URLs
To:     Joe Perches <joe@perches.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Whitcroft <apw@canonical.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset="UTF-8"
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

On Thu, Nov 3, 2022 at 6:41 PM Joe Perches <joe@perches.com> wrote:
>
> On Thu, 2022-11-03 at 18:34 -0700, Peter Collingbourne wrote:
> > On Thu, Nov 3, 2022 at 6:27 PM Joe Perches <joe@perches.com> wrote:
> > >
> > > On Thu, 2022-11-03 at 18:07 -0700, Peter Collingbourne wrote:
> > > > On Wed, Oct 19, 2022 at 03:28:43PM -0500, Bjorn Helgaas wrote:
> > > > > From: Bjorn Helgaas <bhelgaas@google.com>
> > > > >
> > > > > The lkml.org, marc.info, spinics.net, etc archives are not quite as useful
> > > > > as lore.kernel.org because they use different styles, add advertising, and
> > > > > may disappear in the future.  The lore archives are more consistent and
> > > > > more likely to stick around, so prefer https://lore.kernel.org URLs when
> > > > > they exist.
> > > >
> > > > If the commit message contains a line like:
> > > >
> > > > Cc: linux-arm-kernel@lists.infradead.org
> > > >
> > > > this patch causes checkpatch.pl to complain. Would it be possible to
> > > > restrict this to URLs?
> > >
> > > Yes, I believe this would probably work well enough:
> > > ---
> > >  scripts/checkpatch.pl | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> > > index 7be93c3df2bcb..fe25642d8bacc 100755
> > > --- a/scripts/checkpatch.pl
> > > +++ b/scripts/checkpatch.pl
> > > @@ -3336,7 +3336,8 @@ sub process {
> > >                 }
> > >
> > >  # Check for mailing list archives other than lore.kernel.org
> > > -               if ($rawline =~ m{\b$obsolete_archives}) {
> > > +               if ($rawline =~ m{\b$obsolete_archives} &&
> > > +                   $rawline !~ /^\s*cc:/i) {
> >
> > Can we make this (to|cc): instead? Otherwise developers (like me) who
> > use custom scripts to add To: headers to their patches before passing
> > them to checkpatch.pl will also hit this warning if their patch is
> > being sent To: one of these mailing lists.
>
> I think adding "To:" would be odd and unnecessary as it's not
> something that would actually be in a patch.
>
> You could use another front-end script to strip those "To:" from
> checkpatch inputs.

OK, I made that work, so I guess I don't mind much what we do here.

Peter
