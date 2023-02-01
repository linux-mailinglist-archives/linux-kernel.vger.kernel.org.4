Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D284368632B
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 10:53:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232107AbjBAJxa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 04:53:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231338AbjBAJx2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 04:53:28 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29F124957D
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 01:52:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675245168;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vBgaG3upaN8ZH2L2HXxEhx4LvqprmznpfZM80Mr8+0s=;
        b=XiF4qbXSx9CZpBFNWeAQrjJARK/Qi1MpcwHekDYtXu+WL6TpkbBjD4wVjz2uldvb9JVq0T
        dxl0afM4CXUAftZByFrQYekLozAfd9OHPqkRCkZrxXY8ktZrUdAH9x6ChDCOauU6Q9Xec4
        9rMLcrPL5z+vnlHgvEYbnNjq7MgFmE4=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-353-Eam-xPA_NzCbiewrQaqDBQ-1; Wed, 01 Feb 2023 04:52:47 -0500
X-MC-Unique: Eam-xPA_NzCbiewrQaqDBQ-1
Received: by mail-ed1-f72.google.com with SMTP id t26-20020aa7d71a000000b004a244cc7ee8so6279067edq.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 Feb 2023 01:52:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vBgaG3upaN8ZH2L2HXxEhx4LvqprmznpfZM80Mr8+0s=;
        b=mwTGW1QMH0Dgo/k6y1CwReGbZTdQsA6PA8/D2m44efxMhqg6UTVFT6EFPMtZ6Tijv3
         Ay6Heq21Qa1jBeushYfI1+l7uqBfRwzZXkHT5lQQyS80817m2p/qDjUzjJAb1qegPusD
         xfKZ9wS7xLhJ2cx+cXnB9bvP2BOL3e1TdFnD3tj9EZ7DSGuLYABx2NoGHlBddvR8hYrM
         Qg2wjdSTRlUFUtGvnMLHyDVFBdEfRRMJFhNiYpa4d8cc2VXnOZbw2Upfk3bcD2ZiWGFn
         YfrY50woYHeX9AD50A/s7pfNde0a+bjni6XbIffLN0K8rMcJZwp0pHdRRG9sar34zWXH
         5c8g==
X-Gm-Message-State: AO0yUKWRH258ImAOmfJ6ASIsT8RKsCH+5m47Wl1gf3W8L1hhHWsknjGI
        3o1WPV05De9zEf+CC1sxymdmFsajLCYqDtjCznDGkpZtx4oskk0DN7MWbjpjTA7jo26r0ok1+jY
        BIwAE2oQXy3zz5gf0GaYI8U9O
X-Received: by 2002:a17:907:8e93:b0:88a:a09d:e650 with SMTP id tx19-20020a1709078e9300b0088aa09de650mr1929679ejc.58.1675245166214;
        Wed, 01 Feb 2023 01:52:46 -0800 (PST)
X-Google-Smtp-Source: AK7set8/yOuSqzuyvTXovWMavMzuz2C5b0h7AtGaOh8NawRgFHEv0K3aCkTPBD9eIQ4u+LCBZuLgRg==
X-Received: by 2002:a17:907:8e93:b0:88a:a09d:e650 with SMTP id tx19-20020a1709078e9300b0088aa09de650mr1929669ejc.58.1675245166056;
        Wed, 01 Feb 2023 01:52:46 -0800 (PST)
Received: from greebo.mooo.com (c-e6a5e255.022-110-73746f36.bbcust.telenor.se. [85.226.165.230])
        by smtp.gmail.com with ESMTPSA id jr23-20020a170906515700b0086f4b8f9e42sm9775974ejc.65.2023.02.01.01.52.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 01:52:45 -0800 (PST)
Message-ID: <bb87534811ecd092bbc6d361df9d02aff35b17ed.camel@redhat.com>
Subject: Re: [PATCH v3 0/6] Composefs: an opportunistically sharing verified
 image filesystem
From:   Alexander Larsson <alexl@redhat.com>
To:     Jingbo Xu <jefflexu@linux.alibaba.com>,
        Amir Goldstein <amir73il@gmail.com>
Cc:     Gao Xiang <hsiangkao@linux.alibaba.com>, gscrivan@redhat.com,
        brauner@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, david@fromorbit.com,
        viro@zeniv.linux.org.uk, Vivek Goyal <vgoyal@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 01 Feb 2023 10:52:44 +0100
In-Reply-To: <ea8819bc-c340-bf4c-ad91-1a520fe3914b@linux.alibaba.com>
References: <cover.1674227308.git.alexl@redhat.com>
         <CAOQ4uxgGc33_QVBXMbQTnmbpHio4amv=W7ax2vQ1UMet0k_KoA@mail.gmail.com>
         <1ea88c8d1e666b85342374ed7c0ddf7d661e0ee1.camel@redhat.com>
         <CAOQ4uxinsBB-LpGh4h44m6Afv0VT5yWRveDG7sNvE2uJyEGOkg@mail.gmail.com>
         <5fb32a1297821040edd8c19ce796fc0540101653.camel@redhat.com>
         <CAOQ4uxhGX9NVxwsiBMP0q21ZRot6-UA0nGPp1wGNjgmKBjjBBA@mail.gmail.com>
         <b8601c976d6e5d3eccf6ef489da9768ad72f9571.camel@redhat.com>
         <e840d413-c1a7-d047-1a63-468b42571846@linux.alibaba.com>
         <2ef122849d6f35712b56ffbcc95805672980e185.camel@redhat.com>
         <8ffa28f5-77f6-6bde-5645-5fb799019bca@linux.alibaba.com>
         <51d9d1b3-2b2a-9b58-2f7f-f3a56c9e04ac@linux.alibaba.com>
         <CAOQ4uxhzGru2Z8tjcAWvKVi0reNeX9SHMi6cwdyA9Vws8c1ppw@mail.gmail.com>
         <ea8819bc-c340-bf4c-ad91-1a520fe3914b@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.2 (3.46.2-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2023-02-01 at 16:59 +0800, Jingbo Xu wrote:
>=20
> I redid the test with suggestion from Amir, with all files inside the
> erofs layer are redirected to the same lower block, e.g.
> "/objects/00/014430a0b489d101c8a103ef829dd258448a13eb48b4d1e9ff0731d1
> e82b92".
>=20
> The result is shown in the fourth line.
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | uncached(ms)| cached(=
ms)
> ----------------------------------|-------------|-----------
> composefs (with digest)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 | 326=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0| 1=
35
> erofs (w/o -T0)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 264=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0| 172
> erofs (w/o -T0) + overlayfs=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 651=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0| 238
> erofs (hacked and redirect to one |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|
> lower block) + overlayfs=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 | 400=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0| 230
>=20
> It seems that the "lazy lookup" in overlayfs indeed optimizes in this
> situation.
>=20
>=20
> The performance gap in cached situation (especially comparing
> composefs
> and standalone erofs) is still under investigation and I will see if
> there's any hint by perf diff.

The fact that plain erofs is faster than composefs uncached, but slower
cached is very strange. Also, see my other mail where erofs+ovl cached
is slower than squashfs+ovl cached for me. Something seems to be off
with the cached erofs case...


--=20
=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D=
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
=3D-=3D-=3D
 Alexander Larsson                                            Red Hat,
Inc=20
       alexl@redhat.com            alexander.larsson@gmail.com=20
He's a sword-wielding alcoholic barbarian She's a pregnant snooty nun
who=20
dreams of becoming Elvis. They fight crime!=20

