Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BADF9705F9A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 07:55:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232426AbjEQFzD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 01:55:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbjEQFzB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 01:55:01 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42DFC10E9
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 22:55:00 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id 41be03b00d2f7-528cdc9576cso196115a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 22:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684302900; x=1686894900;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kD2vjNSX2CRlbQjilqB2EsGGHkDf0f9MkzQEA1smnmg=;
        b=ZSOPGJSOeD+Ae56OftEqSsy+iNquVSksSVB/ubJK8Clb6s26DJWxAN4ZjKGRKPWsNH
         hl8pFLtBCa53OexkTogpIYNx5SzV8qZVyKj/fJ2NxbfSLP7EornT0RO65pvYDiwjhhfj
         SB2gSsqumUWO+hf0eDvZ8SnIivRRnIQJfFoCLNAvRskFVgabOVlm4GhPVoQPVczgjOyd
         7sFkRupkj3WJPB1rTqGbKpBrQe59u0Qr0JGCuA/HOYo/rLStmStiaFY6DJtLLgF+HXWV
         uH563kNHqNmU59PwVPyF170aTb4OmtfDQ9M15VKCIz9OCKPYTK9RjSHP4jbd8ZGcl+Ws
         ZADg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684302900; x=1686894900;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kD2vjNSX2CRlbQjilqB2EsGGHkDf0f9MkzQEA1smnmg=;
        b=Ie8qS7HMc0BTozbdClsGf4IRL9yrnHNKGSd94J+UHEuHJxX43shjPKVBAgOdTzyrKD
         Ta7kEh3eH3f3guBXd6hDswBOjMq/iOp5P7XYGJGJUQ2dFqKFoIIVMkOtQYaaVCin8ER2
         h+dtErD/MPvZKbMMwN9psKXHJcV8Ned2MLD8yyuur04LW5G0q8+JWResHEtP+cl1Cqrl
         LtoVNRXO41ZLNnQhJFoTG5yUTp9XYNHuv37YvFX4EfxeyGLChfxvghxfhwijwYXp9qgp
         tnAEHZc9yRECTob8Zgbp3S/WQKeCs0nO+uh0whEBbYtaMe0DX6eOysSj4UfzXNSa8reD
         Q3VA==
X-Gm-Message-State: AC+VfDwVtGfo/SrGrDMQRsJFqYqiRkDg3GkljcYMKc17B0krWGYjy905
        94aVzvu/G5+3EfT7lIJDT67NoAie047jkF0YoSKrFAL8Fy9V0DGUNYHUDQ==
X-Google-Smtp-Source: ACHHUZ4gyns5hMoFN3qfln2/VRnm31xyk449zYFl++tXnMGWGLqlE5Yh8WF6gO8FvB6bI0mTIt6MLo1/heRK+lY6FlA=
X-Received: by 2002:a05:6a20:2583:b0:106:feff:40ce with SMTP id
 k3-20020a056a20258300b00106feff40cemr5505097pzd.1.1684302899584; Tue, 16 May
 2023 22:54:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230426203256.237116-1-pandoh@google.com> <CAMC_AXXgBoRZOaDpCex+g_YeOdPQpKD3moQ8VMsqVEm2nqSrjg@mail.gmail.com>
 <2023051703-unpaired-phonebook-58e9@gregkh>
In-Reply-To: <2023051703-unpaired-phonebook-58e9@gregkh>
From:   Jon Pan-Doh <pandoh@google.com>
Date:   Tue, 16 May 2023 22:54:48 -0700
Message-ID: <CAMC_AXWqKU1snX7TCQzgpPMPmMWFxYq8-Lyd=KaUGjoF4GBFXA@mail.gmail.com>
Subject: Re: [PATCH] iommu/amd: Fix domain flush size when syncing iotlb
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Nadav Amit <namit@vmware.com>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Sudheer Dantuluri <dantuluris@google.com>,
        Gary Zibrat <gzibrat@google.com>
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

On Tue, May 16, 2023 at 9:38=E2=80=AFPM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> On Tue, May 16, 2023 at 01:59:16PM -0700, Jon Pan-Doh wrote:
> > Hi Joerg,
> >
> > [Cc'ing stable@vger.kernel.org per Nadav's suggestion]
>
> <formletter>
>
> This is not the correct way to submit patches for inclusion in the
> stable kernel tree.  Please read:
>     https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.ht=
ml
> for how to do this properly.
>
> </formletter>

Thanks for the link. Added the Cc tag as a reply to the patch.
Apologies for top-posting previously.
