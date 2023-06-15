Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B433E731EE3
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 19:26:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238797AbjFOR0V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 13:26:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236338AbjFOR0S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 13:26:18 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DC282728
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 10:26:17 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id e9e14a558f8ab-33b7f217dd0so10195ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 10:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686849976; x=1689441976;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cRdXnKf8UMK6tMvS0Fe+HRivY9zJhDo1MyqxnJgwxrw=;
        b=5dDLBI9MJ7+J3F+/51Jk1eM2fTbc71jazwc/vjucLDniC6v5D8G2m/r+D9PTqTg2Sx
         eg+Mda1zhKn1qCptaIExp9uboTwFeaGNh5b1+9ZlipMZWGhu8neyraXj2gk3cIfJILip
         mTdY1fqzoPFX7qrKZCDIoVRONKO+aBHWBBLnP0z8cT3QWE0yM/CkxnrBvEbmltkKmhiW
         ZOsEAgPxj4F2IYcB6AypIb12ZA0iDuwjTIuDt1Eavf/6zWdpVgh0C8KTCZue2TmIK8rr
         yG/Rr5sBVEWJ9gP81wH5Ulc0dlczEFzlfEu1G7foz9U6hAAjG1+NJCUFZ4ePs1yKFLAx
         jX1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686849976; x=1689441976;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cRdXnKf8UMK6tMvS0Fe+HRivY9zJhDo1MyqxnJgwxrw=;
        b=KJCTV0tJDZxfWhFUqnC/71K86zjxaFq0JfIaAkZpPtwAuYEo87ibK8TrZx3dMlgm96
         7JZCNbLhU0wTgEHsuxmhPO1DovJvDvdzU9Cyn6FXcVtGk7yQvD7a5VITkEL/C1pLiAQC
         3Sn8uKinsrBn/UZMuRuNq3blbL6px98otGLCVYLfdF6R3Zb4rcKo4ZUu4qsJDMyBE6bt
         S+WLD+IU3+VMvCs4kkucgiEAU/DmiAbp55CBJDpbS38Uo9Gyx/06Hw86zzNfK7hWdLEx
         y5H6xBN3dtoU4yxRPI/kcp0nSgzdGShWXRRarvxAQJAsj0agt42VEQ5Z/7KlKRJc4Zg+
         OKyQ==
X-Gm-Message-State: AC+VfDypc8qxpgT1djaBWTwItqSJC6ytl7HOupzJfyrCVeR2dfF2c/at
        cgNgTEYyoQWwKhAFxQtmxjgOFmnP2ULz+8/EjPu//w==
X-Google-Smtp-Source: ACHHUZ7i+zVDOKsralxa6sy+kgOs0tNjf0DvhW9vYedUAncnrn7M3olVN0eC2JjpQTd12kzS61i4W579j0NcVfgOLfQ=
X-Received: by 2002:a92:ca4f:0:b0:337:c28c:3d0f with SMTP id
 q15-20020a92ca4f000000b00337c28c3d0fmr110575ilo.6.1686849976378; Thu, 15 Jun
 2023 10:26:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230606192858.3600174-1-rananta@google.com> <ZImwRAuSXcVt3UPV@linux.dev>
 <CAJHc60wUSNpFLeESWcpEa5OmN4bJg9wBre-2k8803WHpn03LGw@mail.gmail.com>
 <ZIrONR6cSegiK1e2@linux.dev> <ZIscwv1NABW+wZ4J@google.com>
In-Reply-To: <ZIscwv1NABW+wZ4J@google.com>
From:   Raghavendra Rao Ananta <rananta@google.com>
Date:   Thu, 15 Jun 2023 10:26:05 -0700
Message-ID: <CAJHc60y523wJ0gZBm0o6vkYXdyus3QQC3t5W44LPDE+rN6CLzA@mail.gmail.com>
Subject: Re: [PATCH v5 0/7] KVM: arm64: Add support for FEAT_TLBIRANGE
To:     Sean Christopherson <seanjc@google.com>
Cc:     Oliver Upton <oliver.upton@linux.dev>,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jing Zhang <jingzhangos@google.com>,
        Colton Lewis <coltonlewis@google.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
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

Allright, I'll resend the series along with David's patches.

Thank you.
Raghavendra

On Thu, Jun 15, 2023 at 7:14=E2=80=AFAM Sean Christopherson <seanjc@google.=
com> wrote:
>
> On Thu, Jun 15, 2023, Oliver Upton wrote:
> > +cc Sean
> >
> > On Wed, Jun 14, 2023 at 06:57:01PM -0700, Raghavendra Rao Ananta wrote:
> > > On Wed, Jun 14, 2023 at 5:19=E2=80=AFAM Oliver Upton <oliver.upton@li=
nux.dev> wrote:
> > > >
> > > > Hi Raghavendra,
> > > >
> > > > On Tue, Jun 06, 2023 at 07:28:51PM +0000, Raghavendra Rao Ananta wr=
ote:
> > > > > The series is based off of upstream v6.4-rc2, and applied David
> > > > > Matlack's common API for TLB invalidations[1] on top.
> > > >
> > > > Sorry I didn't spot the dependency earlier, but this isn't helpful =
TBH.
> > > >
> > > > David's series was partially applied, and what remains no longer cl=
eanly
> > > > applies to the base you suggest. Independent of that, my *strong*
> > > > preference is that you just send out a series containing your patch=
es as
> > > > well as David's. Coordinating dependent efforts is the only sane th=
ing
> > > > to do. Also, those patches are 5 months old at this point which is
> > > > ancient history.
> > > >
> > > Would you rather prefer I detach this series from David's as I'm not
> > > sure what his plans are for future versions?
> > > On the other hand, the patches seem simple enough to rebase and give
> > > another shot at review, but may end up delaying this series.
> > > WDYT?
> >
> > In cases such as this you'd typically coordinate with the other
> > developer to pick up their changes as part of your series. Especially
> > for this case -- David's refactoring is _pointless_ without another
> > user for that code (i.e. arm64). As fun as it might be to antagonize
> > Sean, that series pokes x86 and I'd like an ack from on it.
> >
> > So, please post a combined series that applies cleanly to an early 6.4
> > rc of your choosing, and cc all affected reviewers/maintainers.
>
> +1
