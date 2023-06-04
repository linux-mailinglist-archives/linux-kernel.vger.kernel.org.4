Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 645C97214DC
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Jun 2023 07:38:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbjFDFih (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jun 2023 01:38:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjFDFif (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jun 2023 01:38:35 -0400
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com [IPv6:2607:f8b0:4864:20::e2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3142D2;
        Sat,  3 Jun 2023 22:38:34 -0700 (PDT)
Received: by mail-vs1-xe2b.google.com with SMTP id ada2fe7eead31-43b2fb0afa6so533444137.1;
        Sat, 03 Jun 2023 22:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685857114; x=1688449114;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8PHXdu5IuMrhkPlZ7jqUlnArsh/HLu2zKdX3eKzfIWU=;
        b=gLP5T0OQMp3gO9YWCKM6+qd9BnIxh2hbeYrY03B8nb784BwZACjvw+UXid8jx3Yhxl
         E6HuTYoe8mpvT6UCR0bX+eV1P/xteBXFk584hnZ5XQyP1bD8RTGw58d2Yy6ovymfYoFr
         KpZ7o2wn+vp+d1x4n8URjw3XX5pWuzUtZNbmyX3jnMFTRgFQPHPSu7qe9OVXWtU9cIWr
         tVtBWYx08d4/dz5CBNpJzsWG6bo4E7xFsFUowooLsCgWnUQIRJT/q0cq1Xe3GWwt5Nbr
         L3/QVv0NhHjsmbSJjGmji1ApiDqYx9fYZiVgxOVjy7peas5zpAdNA5z6UIvDG2fwTJ+3
         Ugvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685857114; x=1688449114;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8PHXdu5IuMrhkPlZ7jqUlnArsh/HLu2zKdX3eKzfIWU=;
        b=HkWr0WumT0XuhfNBi3dYN7frnPKvSaize+QcuxHP+m/xrhVkMSrwttUa+oV0nF6JvS
         GtrRq1rpKmcO7EerZF0T4qxMOSLdwUbVn7fLAXTg0/9Z1EB9JzAI2rqz0FYso131ysyU
         PcRDlflWjG3JBg3FMEUkA02C0lcSIZPJhZ4Zu/OIVu2nu0qtOHjyUsbYQxjL98cHpBQH
         MWpdSUb6q2zYwJPWKXbkK5/nRk5/c9QRZcbIjJhcsdkVTrPGG5rQVhosAEsdAWg4w8j9
         3FaDHU7U2t4OaXSGnlLb+KBqzAQ3NugvvnqaOpylB9iLAPiSyDc8ko1/1akn80lHM/ne
         PP1g==
X-Gm-Message-State: AC+VfDyQP0uWPmqw5xBCEpvq6brMcaCEnQfw+3zkZPIlw9fB4wifvTKw
        hgW5aJEc/4Ls+6XdYm3iWjE8F94EkaDONAxLGFs=
X-Google-Smtp-Source: ACHHUZ7fz05Hg2Epz6uS6kQXNmnGIP8uJfN9ah6Sr67+nSTy5NfAXYjQQF5/447KPRKXfpRbmOsLU3S8MVotWdgKV70=
X-Received: by 2002:a05:6102:40e:b0:43b:4542:2262 with SMTP id
 d14-20020a056102040e00b0043b45422262mr205508vsq.13.1685857113791; Sat, 03 Jun
 2023 22:38:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230601164439.15404-1-listdansp@mail.ru> <20230601164439.15404-2-listdansp@mail.ru>
 <2023060127-flick-velcro-ca45@gregkh>
In-Reply-To: <2023060127-flick-velcro-ca45@gregkh>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Sun, 4 Jun 2023 08:38:22 +0300
Message-ID: <CAOQ4uxh_Q7o_Ln1YAJdNyoXuid+p+SBAkmXVUfDbd-sZHX-qOA@mail.gmail.com>
Subject: Re: [PATCH 5.10 1/1] xfs: verify buffer contents when we skip log replay
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Darrick J. Wong" <djwong@kernel.org>
Cc:     Danila Chernetsov <listdansp@mail.ru>, stable@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dave Chinner <dchinner@redhat.com>,
        Dave Chinner <david@fromorbit.com>,
        Leah Rumancik <lrumancik@google.com>,
        Chandan Babu R <chandan.babu@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 1, 2023 at 8:20=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Thu, Jun 01, 2023 at 04:44:39PM +0000, Danila Chernetsov wrote:
> > From: "Darrick J. Wong" <djwong@kernel.org>
> >
> > commit 22ed903eee23a5b174e240f1cdfa9acf393a5210 upstream.
> >
> > syzbot detected a crash during log recovery:
>
> XFS patches for stable come from the XFS maintainers, so please work
> with them if you feel any specific patch is missing from a stable tree.
>

Danila,

Thanks for bringing this to our attention.
I've tested this fix for 6.1.y and Leah will test it for 5.15.y
thereafter I will test and post it for 5.10.y.

FYI, the MAINTAINERS file in each LTS kernel has an extra
xfs maintainer listed for backporting fixes for that LTS, however
6.1.y is still waiting for an assigned backporting maintainer.

Thanks,
Amir.
