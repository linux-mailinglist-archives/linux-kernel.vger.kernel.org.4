Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC796730CF5
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 03:57:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237931AbjFOB5R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 21:57:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237966AbjFOB5O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 21:57:14 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5428A1720
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 18:57:13 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1b3e3f33e33so96965ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 18:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686794233; x=1689386233;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FMLY1axQ9dhHgS2evzrC32ToK9p7zpIVVjZVrkVP9Q4=;
        b=JgGHVcV8/EOlg76CXREOFygRfcPLh0TvPl2YGB0VlwURFpypN66Kb1alr53MRziI0e
         HBYWPc90/oiaA7G6zUyWrl/uxY/oAhW9DKtoyE8Ho3PoorWVYZdX4w3Fxq1OcnWLaBu6
         0LKDTDBzdo+KJIsG26awIGClEZe4bI/iRsZu0tmLTBVPsEH5a72580lO+Sy8YC0GOW6g
         o08HyBosEsk2I2G38RG0zWToRkkdp29E/XznTlNmnTiVzEmZY/AWdY+4p3O/H67u6ndI
         38FJWCrJAW8asX0QUo3w9AW+tptp2b5A3zCqQDu8DCVyosUvLpbpp5JXKWyLmpsPZkbg
         VkUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686794233; x=1689386233;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FMLY1axQ9dhHgS2evzrC32ToK9p7zpIVVjZVrkVP9Q4=;
        b=SUOpfZ+m33xGzl/QlbX5q9R1Wt/BmbJGwgA/GFxQR5SKLR4HDtEWGCkFKn+QsL1iar
         6Uz7QGEBmFCsRAXoGpf3bykxlXQ9zEKN1Yja470vuIv1DWIlqA3nfXsYKaD4HyklbQF9
         fIcMtC7RxXiLyUE4PPGqXbVDgmpLpYvX1ONj859qTtA68JY9g1GfL/ZWHBFXRRdQOv39
         sjGp9a9rOCRngvdPTn9dgOTMysIJcEDZ1dJnE1TuO7R+eMh9qVvZvZa3YcAeDUMKmmg1
         b6ak5nrRHOlFyoGu/vmQ4MDIW3H07VDVKfjM/RlW18DRNNLm0ZWDIaaTqyqMwE2SBdFA
         JqRQ==
X-Gm-Message-State: AC+VfDweiAqoSREw6TSELaUjWPO+wWX2lUXLWd0lmSU6dTSQRxlWsLpw
        5LIVT/RWaGXjP6H0c5ALys9IUfKBEn7zh6cLgCGsUg==
X-Google-Smtp-Source: ACHHUZ7k0wQBEo+NKxdCH3hP8L0i+8TYR5xJPePgVUW4Nh6Q7s/Lv/FmuVPnnao1IQ/tXOiUiu+GK3HzgdtUQbbtnqs=
X-Received: by 2002:a17:902:f684:b0:1b3:a195:12d4 with SMTP id
 l4-20020a170902f68400b001b3a19512d4mr124232plg.12.1686794232483; Wed, 14 Jun
 2023 18:57:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230606192858.3600174-1-rananta@google.com> <ZImwRAuSXcVt3UPV@linux.dev>
In-Reply-To: <ZImwRAuSXcVt3UPV@linux.dev>
From:   Raghavendra Rao Ananta <rananta@google.com>
Date:   Wed, 14 Jun 2023 18:57:01 -0700
Message-ID: <CAJHc60wUSNpFLeESWcpEa5OmN4bJg9wBre-2k8803WHpn03LGw@mail.gmail.com>
Subject: Re: [PATCH v5 0/7] KVM: arm64: Add support for FEAT_TLBIRANGE
To:     Oliver Upton <oliver.upton@linux.dev>
Cc:     Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>,
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

On Wed, Jun 14, 2023 at 5:19=E2=80=AFAM Oliver Upton <oliver.upton@linux.de=
v> wrote:
>
> Hi Raghavendra,
>
> On Tue, Jun 06, 2023 at 07:28:51PM +0000, Raghavendra Rao Ananta wrote:
> > The series is based off of upstream v6.4-rc2, and applied David
> > Matlack's common API for TLB invalidations[1] on top.
>
> Sorry I didn't spot the dependency earlier, but this isn't helpful TBH.
>
> David's series was partially applied, and what remains no longer cleanly
> applies to the base you suggest. Independent of that, my *strong*
> preference is that you just send out a series containing your patches as
> well as David's. Coordinating dependent efforts is the only sane thing
> to do. Also, those patches are 5 months old at this point which is
> ancient history.
>
Would you rather prefer I detach this series from David's as I'm not
sure what his plans are for future versions?
On the other hand, the patches seem simple enough to rebase and give
another shot at review, but may end up delaying this series.
WDYT?

Thank you.
Raghavendra

> > [1]:
> > https://lore.kernel.org/linux-arm-kernel/20230126184025.2294823-1-dmatl=
ack@google.com/
>
> --
> Thanks,
> Oliver
