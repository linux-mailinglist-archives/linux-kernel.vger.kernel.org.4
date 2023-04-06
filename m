Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C75A96DA232
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 22:07:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238444AbjDFUH1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 16:07:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236697AbjDFUHY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 16:07:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B9AD83F2
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 13:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680811600;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UhmlLvqF6da/QeN+M/XiLghLgzDAr8RSwO2FXFQLnAM=;
        b=fo+s4t3gHydQtSYukR101dvYEjiPtJ11UYRHI7eJum/+q5r5qacYSxpbcVYudPIM755f1b
        bwnRL3XjTQr4bMDxIGVJ/TKMnqb1JEYD965h7i+hYEogE8GRUU48yK4OEga0kctUfXYn1s
        7unWkZEP3DOUmYt3bXoIPYTD1AHc5yU=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-658-hJbmPxKSNKu6dn7Sfg1rew-1; Thu, 06 Apr 2023 16:06:39 -0400
X-MC-Unique: hJbmPxKSNKu6dn7Sfg1rew-1
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-3e385709826so3669131cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 13:06:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680811598; x=1683403598;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UhmlLvqF6da/QeN+M/XiLghLgzDAr8RSwO2FXFQLnAM=;
        b=A5Wjs3Fds6zHfBao1GbnxjVlZgcV/O8gNFSHEd/MX9nxba1aEnCSt/snllMaGGDH2B
         uvMODG643oRT2PwttiBhSAH8w99snK2bcHMwPKik2t+E07ezah+Li3Jk07lXgTGwR48e
         bZH7oFDYyraYhsfuEFBKxtvH+l4nfNCYS80aH95B39MMnR/bsBVELUaU5jpZhjqlI9oK
         P6zHR8gBtVLkhun9wiplxgYfFGeDOxRyOT5lVV4A0D0UlHgLb/Dm5Sb/V85grQxvw4xX
         UKKHnP7lPFEDrspe7alPtaE3Z1DISCPNZVHQLQwLtYwWyduc/XvKsS7BmMz28Us6ntAD
         WAiw==
X-Gm-Message-State: AAQBX9f3l081WnTgF/57d1gpSe4O0BgZUgcsKZRYEXNwQHlCe9dxBRLt
        QMquKEWcrayex+B2jhr402q9fw4zMgQ0WZndpzbTfGoq1WauWg1nRd2cdxyMseYELxop2CtIx+g
        Bb2/TzCITmx2x9MEpvtpcA5K1
X-Received: by 2002:ac8:4e81:0:b0:3e6:707e:d3b1 with SMTP id 1-20020ac84e81000000b003e6707ed3b1mr367779qtp.0.1680811598752;
        Thu, 06 Apr 2023 13:06:38 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZPAT8/mfBeygZApOE+HH1z1q+F581N5hs+GA2lzop1GnVCSbhthuavSrBaVKK/62Zf7anwGQ==
X-Received: by 2002:ac8:4e81:0:b0:3e6:707e:d3b1 with SMTP id 1-20020ac84e81000000b003e6707ed3b1mr367746qtp.0.1680811598535;
        Thu, 06 Apr 2023 13:06:38 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-227-151.dyn.eolo.it. [146.241.227.151])
        by smtp.gmail.com with ESMTPSA id m8-20020ac866c8000000b003e398d00fabsm647030qtp.85.2023.04.06.13.06.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 13:06:38 -0700 (PDT)
Message-ID: <7ab4950ea08e89fe0481a08a8b49de4291b9451f.camel@redhat.com>
Subject: Re: [PATCH net-next 2/3] ksz884x: remove unused #defines
From:   Paolo Abeni <pabeni@redhat.com>
To:     Simon Horman <horms@kernel.org>, Jakub Kicinski <kuba@kernel.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Date:   Thu, 06 Apr 2023 22:06:35 +0200
In-Reply-To: <ZC7vgRFmqAjGQyss@kernel.org>
References: <20230405-ksz884x-unused-code-v1-0-a3349811d5ef@kernel.org>
         <20230405-ksz884x-unused-code-v1-2-a3349811d5ef@kernel.org>
         <454a61709e442f717fbde4b0ebb8b4c3fdfb515e.camel@redhat.com>
         <20230406090017.0fc0ae34@kernel.org> <ZC7vgRFmqAjGQyss@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2023-04-06 at 18:12 +0200, Simon Horman wrote:
> On Thu, Apr 06, 2023 at 09:00:17AM -0700, Jakub Kicinski wrote:
> > On Thu, 06 Apr 2023 15:37:36 +0200 Paolo Abeni wrote:
> > > On Wed, 2023-04-05 at 10:39 +0200, Simon Horman wrote:
> > > > Remove unused #defines from ksz884x driver.
> > > >=20
> > > > These #defines may have some value in documenting the hardware.
> > > > But that information may be accessed via scm history. =20
> > >=20
> > > I personally have a slight preference for keeping these definitions i=
n
> > > the sources (for doc purposes), but it's not a big deal.=20
> > >=20
> > > Any 3rd opinion more then welcome!
> >=20
> > I had the same reaction, FWIW.
> >=20
> > Cleaning up unused "code" macros, pure software stuff makes perfect
> > sense. But I feel a bit ambivalent about removing definitions of HW
> > registers and bits.
>=20
> I guess that it two down-votes for removing the #defines.
>=20
> Would it be acceptable if I reworked the series to only remove
> the dead code - which would leave only subset of patch 3/3 ?

I would be fine with that.

Thanks!

Paolo

