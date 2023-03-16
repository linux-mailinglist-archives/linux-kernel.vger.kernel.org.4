Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 630C76BD346
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 16:21:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231340AbjCPPVW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 11:21:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230215AbjCPPVU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 11:21:20 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A21810273
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 08:21:19 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id e65so2317575ybh.10
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 08:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1678980078;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3EyPva+NA58QOv4uevl1RDj2mZqkbablGEN+XHX1jCs=;
        b=gKLRzsZlI3+oOD2jZ8em011yiVLt5iQXxPBDzIvp8J5VctyS6LaRL+Ga5Qq9WlLSVp
         jf29DhB2ousYJcf9Q670B8d7wyLuyCXm+bBUFAL/X7MZEhWmR7R4xD67bd8fe2vg9DkT
         YOrkdKSNIAfLQm7Pvee+xFIjtEtuIuXq3Z3fE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678980078;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3EyPva+NA58QOv4uevl1RDj2mZqkbablGEN+XHX1jCs=;
        b=acHsU2+gWpRDk6KXFV1Qqpd5K19ZbYon/BCLoYcEHX4aHz12npcX5sTGXWvxFOmNyi
         Ot0jJtNy7RWhrz0V0aI3iBy+ebq+2YZiTxUh0bhivAUCM2ZWkplvhL7V8ZGaKeicpENG
         UQVSgmfHq/nEKkny9Lz5ajPow3Gn0tQprAbHcm4tvs8myUMa9zaBDCN0jU4kEZQNleX8
         X37Qohuv5LFhEDToBy7es0amHlQZ8PC1UU+CKJeGVgsC62w03/yTv85XtwTXzaZUVepY
         w2zQc2ZJ7+GeSCaxARLzpiFh9+RAHg5w7+qN/ndeWfF335hdlurHyhVtffYu9d3qS7OR
         xrKA==
X-Gm-Message-State: AO0yUKXRge17jC6U+WxFyBEnhaLJ/nmIxFb5BFK1qMGqFocehsAlNxHG
        mdIGwe39g56ZbBriMI7297dkpI1D6V+NKaY9QEkX2FYy/UYNHG3L3R4=
X-Google-Smtp-Source: AK7set8w62orB5NBC7nsC9ESkTg0CuRiwAd1lddbe0/+hmWu8PeEzQUwtfya4+r7r/efUDQ8cZMQ1XIEcPMKjsFLjgQ=
X-Received: by 2002:a05:6902:18ce:b0:b4d:ee98:4ff7 with SMTP id
 ck14-20020a05690218ce00b00b4dee984ff7mr4464595ybb.2.1678980078546; Thu, 16
 Mar 2023 08:21:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230315181902.4177819-1-joel@joelfernandes.org>
 <20230315181902.4177819-2-joel@joelfernandes.org> <ZBK8O5tKj0PPM1co@kroah.com>
In-Reply-To: <ZBK8O5tKj0PPM1co@kroah.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Thu, 16 Mar 2023 11:21:07 -0400
Message-ID: <CAEXW_YS=ApOpXwdgnP-Aq=xD_pvYhZWPOF=U19LqbVjjn=eROg@mail.gmail.com>
Subject: Re: [PATCH v2 02/14] misc: vmw_vmci: Rename kvfree_rcu() to kvfree_rcu_mightsleep()
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Bryan Tan <bryantan@vmware.com>, Vishnu Dasa <vdasa@vmware.com>,
        VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLACK autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 16, 2023 at 2:50=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Wed, Mar 15, 2023 at 06:18:49PM +0000, Joel Fernandes (Google) wrote:
> > From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
> >
> > The kvfree_rcu() macro's single-argument form is deprecated.  Therefore
> > switch to the new kvfree_rcu_mightsleep() variant. The goal is to
> > avoid accidental use of the single-argument forms, which can introduce
> > functionality bugs in atomic contexts and latency bugs in non-atomic
> > contexts.
> >
> > Cc: Bryan Tan <bryantan@vmware.com>
> > Cc: Vishnu Dasa <vdasa@vmware.com>
> > Reviewed-by: Vishnu Dasa <vdasa@vmware.com>
> > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > ---
> >  drivers/misc/vmw_vmci/vmci_context.c | 2 +-
> >  drivers/misc/vmw_vmci/vmci_event.c   | 2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
>
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Thanks!

- Joel
