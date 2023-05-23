Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5340770E3E4
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 19:47:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238254AbjEWRoQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 13:44:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237501AbjEWRoM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 13:44:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6988490;
        Tue, 23 May 2023 10:44:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EE0756355A;
        Tue, 23 May 2023 17:44:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59C74C4339B;
        Tue, 23 May 2023 17:44:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684863846;
        bh=rFkmvkO0OpsALLfe8oNx4FG/ovMg2iAu1RwUUNxXPOk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=P1G5Bggfei3jyT4cBhkFKbGmpWhjxNa6mc9jYXeQzxNn8WmCrcdc+HCKddBnO8mUP
         sShp2kKTJk6gWyhVLLCdl16VvhUUnhqim+omtCICUtyA+A+A7P12Cl/Tu3EKXHKmXU
         RacbOqavhH0QMZYR5BiNbc7yWqtj1fJYD+RImi0DGtKlAqcuFyOa2tQdjlHKfpEDIl
         i6DRD2DcNw18izG2+a1yMpBViqbBd7SQw0bdfGVP+vCXHaU2Bq6SA6vqe0o93GwoIN
         NgHMlUDmjmuvr7x0VB2tF52q5uwaZXTR0zxOlo1npN42vPW06a7kfqBM3EJ0yM6Ot+
         Ritn8eeVXa0dA==
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-4f3b39cea1eso163440e87.3;
        Tue, 23 May 2023 10:44:06 -0700 (PDT)
X-Gm-Message-State: AC+VfDxMVLAdYpYfsZSHmuI5gZOvVmhsYT6O1vQ0aiO/l+TRkmhM2jnP
        d4EYVdpJEqL1+f1bRkO5LtTQEJmekMeAl0totVE=
X-Google-Smtp-Source: ACHHUZ4DbuIfaUp1u6uliqoitws7+tPxKJaq+XmWOizvJLUvMg2ZyqPNF4XDkghkzwObqfKkvrOlK9KCdBIRIFnzJkg=
X-Received: by 2002:a05:6512:922:b0:4eb:1361:895c with SMTP id
 f2-20020a056512092200b004eb1361895cmr5457525lft.55.1684863844325; Tue, 23 May
 2023 10:44:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230522212114.gonna.589-kees@kernel.org>
In-Reply-To: <20230522212114.gonna.589-kees@kernel.org>
From:   Song Liu <song@kernel.org>
Date:   Tue, 23 May 2023 10:43:52 -0700
X-Gmail-Original-Message-ID: <CAPhsuW5ibONdyyJq0zVCEHuM38GUocn8A1abi4mTa9gUHH1hHQ@mail.gmail.com>
Message-ID: <CAPhsuW5ibONdyyJq0zVCEHuM38GUocn8A1abi4mTa9gUHH1hHQ@mail.gmail.com>
Subject: Re: [PATCH v2] md/raid5: Convert stripe_head's "dev" to flexible
 array member
To:     Kees Cook <keescook@chromium.org>
Cc:     Christoph Hellwig <hch@infradead.org>, linux-raid@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 22, 2023 at 2:21=E2=80=AFPM Kees Cook <keescook@chromium.org> w=
rote:
>
> Replace old-style 1-element array of "dev" in struct stripe_head with
> modern C99 flexible array. In the future, we can additionally annotate
> it with the run-time size, found in the "disks" member.
>
> Cc: Christoph Hellwig <hch@infradead.org>
> Cc: linux-raid@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
> It looks like this memory calculation:
>
>         memory =3D conf->min_nr_stripes * (sizeof(struct stripe_head) +
>                  max_disks * ((sizeof(struct bio) + PAGE_SIZE))) / 1024;
>
> ... was already buggy (i.e. it included the single "dev" bytes in the
> result). However, I'm not entirely sure if that is the right analysis,
> since "dev" is not related to struct bio nor PAGE_SIZE?
>
> v1: https://lore.kernel.org/all/20230517233313.never.130-kees@kernel.org/
> v2: use new struct_size_t() helper from
>     https://lore.kernel.org/lkml/20230522211810.never.421-kees@kernel.org=
/

LTGM. Thanks!

I will hold this for a while until struct_size_t() merged.

Song
