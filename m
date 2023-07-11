Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C892874F158
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 16:13:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233423AbjGKOMy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 10:12:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230402AbjGKOMv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 10:12:51 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3D14B0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 07:12:50 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id d9443c01a7336-1b8a4571c1aso61993695ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 07:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689084770; x=1691676770;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DKmedfgd+4jxvzKfHiDgc5mFmW2U0cgt9mxgBtCMeQU=;
        b=jQEYS4cWMvSpAE60WURba81hHYw9L68nNA4P8uyOv4r4C/Cc32KDCJgdeT8sfaqmEt
         WGG+cOZWeHAYiU/MI1l15/+sIqBCdts+B6D53RbyeuoDGbt+HDViBapsAwWUHBi0Zk3/
         dxE8vgj6BHzixqyqY41R59IXNsvVJ3+GC7JnyQ29gV4AHD4btjbaPTfVtBtkhKG3hJfK
         2ZhSnd8NQV1n/6LtnGYL1FtePvKrA3Kf/GqrqY/Rx34aITmRMSzsDa++4VtNkBpT+rpV
         ZteK8e1HHtO+jrNS9wFkdzKgKYULF8ijqfxAjJG6yuv8qcFyEuA9ZGT+WurAks53i7l5
         GhrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689084770; x=1691676770;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DKmedfgd+4jxvzKfHiDgc5mFmW2U0cgt9mxgBtCMeQU=;
        b=bm8BIvsVaRFNFpBUIk/txjUJV8dNxncxQaa8M2Tu0AdaP5BT6UXtM4ss2/1uuGba9K
         Kv+mxw8VtT7c3uMF4NURh41K40FRKrAojq0Ubdx86CxkHu1AGEBsMnc7Swk3486/p64j
         HSIeOdTLr3PFPlkNx8a8BUyhUFAWmlqo9/OebXqfrlYjTwoQnJGpRf7MmdEF35mNrx5W
         wQq453Sn4/JHtCvGpbGW7T2KctNFsJ52bTtdVSjgIv7hVW0elCClq/3+IWDXRbCveCWs
         tObcMGyTT7K3gkrKWz4MA7YGIw6NMDWfk/gOAKnBGnSTxZyxknFxwL/qLD8z0PiVZoKy
         hTbA==
X-Gm-Message-State: ABy/qLb3+OqhW1T1yBbV+M5AdYbJhiv5jil8zcGuHeLMh6alVP7a/iSr
        WF27oPnY0UoBcv2qs/F84Yn1bIWEK1s=
X-Google-Smtp-Source: APBJJlE8y6yedrUFAfVOuSm3aMTvdZrtcnPSOCAlg5L1LYZDN+BCXVDzZfkatvUWj3oc0M7vuOjwXa/J5GA=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:ba8c:b0:1ae:6895:cb96 with SMTP id
 k12-20020a170902ba8c00b001ae6895cb96mr11931957pls.5.1689084770417; Tue, 11
 Jul 2023 07:12:50 -0700 (PDT)
Date:   Tue, 11 Jul 2023 07:12:48 -0700
In-Reply-To: <a1679697-827b-0e3a-0948-c84510fcbecc@web.de>
Mime-Version: 1.0
References: <20230710170652.473788-1-seanjc@google.com> <a1679697-827b-0e3a-0948-c84510fcbecc@web.de>
Message-ID: <ZK1jYI/wyaxWnXrz@google.com>
Subject: Re: [cocci] [PATCH] Revert "debugfs, coccinelle: check for obsolete
 DEFINE_SIMPLE_ATTRIBUTE() usage"
From:   Sean Christopherson <seanjc@google.com>
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     cocci@inria.fr, kernel-janitors@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Julia Lawall <Julia.Lawall@inria.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 11, 2023, Markus Elfring wrote:
> > Remove coccinelle's recommendation to use DEFINE_SIMPLE_ATTRIBUTE()
> > instead of DEFINE_SIMPLE_ATTRIBUTE().
>=20
> I find this wording inappropriate for a change request
> because of an undesirable term duplication.
> Would you like to refer to the identifier =E2=80=9CDEFINE_DEBUGFS_ATTRIBU=
TE=E2=80=9D here?

Doh, copy+paste fail on my part.

> >                                        Regardless of whether or not the
> > "significant overhead" incurred by debugfs_create_file() is actually
> > meaningful, warnings from the script have led to a rash of low-quality
> > patches that have sowed confusion and consumed maintainer time for litt=
le
> > to no benefit.  There have been no less than four attempts to "fix" KVM=
,
> > and a quick search on lore shows that KVM is not alone.
>=20
> Will such information trigger any further clarification?

I don't quite follow the question.  What information, and what clarificatio=
n?
