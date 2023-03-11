Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B61B6B5D1D
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 16:01:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230167AbjCKPBI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 10:01:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjCKPBG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 10:01:06 -0500
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2D81E503E
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 07:01:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=YBUynlOgBjxt0gAz68NH0YicKE7loSO8V0u9I7YN1Es=;
  b=eTeZwr7PtjHXE7dM/E9YuM00QTvMzyhs+uJe6TFMuqrlxG6TwugZsj+N
   P+tmFLA6wLSFS04HeenButOp928cENkhmF92KZfCXtonIH5jBgmKfa5cl
   GNVLwgRzi/PbCJC/Ouh2p8NEEF3URDPepWfwRV+00POF+gvQ4Yr6JoxHm
   8=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="5.98,252,1673910000"; 
   d="scan'208";a="96650250"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2023 16:00:58 +0100
Date:   Sat, 11 Mar 2023 16:00:59 +0100 (CET)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Menna Mahmoud <eng.mennamahmoud.mm@gmail.com>
cc:     Dan Carpenter <error27@gmail.com>, outreachy@lists.linux.dev,
        pure.logic@nexus-software.ie, johan@kernel.org, elder@kernel.org,
        gregkh@linuxfoundation.org, greybus-dev@lists.linaro.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: greybus: eclose macro in a do - while loop
In-Reply-To: <c9ae27dc-3538-5432-6a6d-3e2ff034f467@gmail.com>
Message-ID: <alpine.DEB.2.22.394.2303111600330.2802@hadrien>
References: <20230311135919.9129-1-eng.mennamahmoud.mm@gmail.com> <10d2c15b-ff9f-4634-a013-7640c93435a7@kili.mountain> <c9ae27dc-3538-5432-6a6d-3e2ff034f467@gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1157779403-1678546859=:2802"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1157779403-1678546859=:2802
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Sat, 11 Mar 2023, Menna Mahmoud wrote:

>
> On ١١/٣/٢٠٢٣ ١٦:٠٦, Dan Carpenter wrote:
> > On Sat, Mar 11, 2023 at 03:59:19PM +0200, Menna Mahmoud wrote:
> > > " ERROR: Macros with multiple statements should be enclosed in a do -
> > > while loop"
> > >
> > > Reported by checkpath.
> > >
> > > do loop with the conditional expression set to a constant
> > > value of zero (0).This creates a loop that
> > > will execute exactly one time.This is a coding idiom that
> > > allows a multi-line macro to be used anywhere
> > > that a single statement can be used.
> > >
> > > So, enclose `gb_loopback_stats_attrs` macro in do - while (0) to
> > > fix checkpath error
> > >
> > > Signed-off-by: Menna Mahmoud <eng.mennamahmoud.mm@gmail.com>
> > > ---
> > This breaks the build.  You need to compile the code before sending a
> > patch.
> >
> > regards,
> > dan carpenter
>
>
> I see, I thought building the file only enough. appreciate your feedback.

The outreachy tutorial explains how to compile everything in a
subdirectory.

julia
--8323329-1157779403-1678546859=:2802--
