Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A8FC7414B0
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 17:15:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231296AbjF1PPo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 11:15:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:29490 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231439AbjF1PPk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 11:15:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687965292;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=No+atwHziLwh2Mwoi0urFa3UAgrtvH7xWcC0P7lfeTw=;
        b=JBeLERylEkGUhrOvdg9oN5+CDTM7/LG2PviP189y5DDEPmW6HW8eRlxGPU80zaHb4TKo22
        H011XVGfMhjiJuoU7tPP6zm8D7C5vVfMcn1V/gBZgJKUjaX4bwjBgeKGRoy/qW6ejvyA/i
        KVHuNZgZ7u4vfRNzOefcq0sqDWxjk2c=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-317-CUbxFDIkPFiPEA83um3wgg-1; Wed, 28 Jun 2023 11:14:50 -0400
X-MC-Unique: CUbxFDIkPFiPEA83um3wgg-1
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-3f8283a3a7aso15882581cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 08:14:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687965289; x=1690557289;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=No+atwHziLwh2Mwoi0urFa3UAgrtvH7xWcC0P7lfeTw=;
        b=Dbj3c1YRiBYR2F1JB8OuC/pJ2RkxCDsILvZRdmcKav38UnDihYZYz7GBXO5moZfNoI
         +0NIq2sl1Cb6EgCOMup7D0G+DrUSfQwfj8grhwd0bzsMRiGsknstByPcX61DloHNsE6R
         D+y6/bzP0f2gd7TPIbr62mYOP+pk9aaYXy5vp9RUXusNXXlB82xSuPJYw5ieqycd28qD
         Ue+4JZipNIgVV7tEQESaO/Vmkf9rS1Z02cLX3585tVXWJgMxWSL3yW2jiPf3pSm7RxWg
         L9T71yRPKphS13nuGPGTkF94S7vzgE1MTe8Ajor4JXyjs4G6WVr3YYM1xZxk89pzv3wK
         08XA==
X-Gm-Message-State: AC+VfDw8P7rG6onA/pObI7aFiapbvC4t2mfYm5+UP1D/PY7uwcQEn1X4
        qUro9cYJBdEuaYA+K1esg8uilumhG59Vaf5n0iKcyPi9/jXghoAt62kKxgibRDcNruE7re97aiZ
        o7sHXscRjYXbyHSLEitRR/0w/
X-Received: by 2002:a05:622a:1896:b0:3f6:a8e2:127b with SMTP id v22-20020a05622a189600b003f6a8e2127bmr46136qtc.5.1687965289133;
        Wed, 28 Jun 2023 08:14:49 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5HF4kf3dF/wJd/JhG2BMQuizzHpnpWbJZjxT53l4SvDgK1eWSqKwllWtY5fNhmd2RvU2RI8g==
X-Received: by 2002:a05:622a:1896:b0:3f6:a8e2:127b with SMTP id v22-20020a05622a189600b003f6a8e2127bmr46114qtc.5.1687965288898;
        Wed, 28 Jun 2023 08:14:48 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-226-127.dyn.eolo.it. [146.241.226.127])
        by smtp.gmail.com with ESMTPSA id a3-20020a05622a02c300b00400e687174csm3560628qtx.54.2023.06.28.08.14.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 08:14:48 -0700 (PDT)
Message-ID: <5688456234f5d15ea9ca0f000350c28610ed2639.camel@redhat.com>
Subject: Re: [Intel-wired-lan] bug with rx-udp-gro-forwarding offloading?
From:   Paolo Abeni <pabeni@redhat.com>
To:     Ian Kumlien <ian.kumlien@gmail.com>
Cc:     Alexander Lobakin <aleksander.lobakin@intel.com>,
        intel-wired-lan <intel-wired-lan@lists.osuosl.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Wed, 28 Jun 2023 17:14:45 +0200
In-Reply-To: <CAA85sZs4KkfVojx=vxbDaWhWRpxiHc-RCc2OLD2c+VefRjpTfw@mail.gmail.com>
References: <CAA85sZukiFq4A+b9+en_G85eVDNXMQsnGc4o-4NZ9SfWKqaULA@mail.gmail.com>
         <CAA85sZvm1dL3oGO85k4R+TaqBiJsggUTpZmGpH1+dqdC+U_s1w@mail.gmail.com>
         <e7e49ed5-09e2-da48-002d-c7eccc9f9451@intel.com>
         <CAA85sZtyM+X_oHcpOBNSgF=kmB6k32bpB8FCJN5cVE14YCba+A@mail.gmail.com>
         <22aad588-47d6-6441-45b2-0e685ed84c8d@intel.com>
         <CAA85sZti1=ET=Tc3MoqCX0FqthHLf6MSxGNAhJUNiMms1TfoKA@mail.gmail.com>
         <CAA85sZvn04k7=oiTQ=4_C8x7pNEXRWzeEStcaXvi3v63ah7OUQ@mail.gmail.com>
         <ffb554bfa4739381d928406ad24697a4dbbbe4a2.camel@redhat.com>
         <CAA85sZunA=tf0FgLH=MNVYq3Edewb1j58oBAoXE1Tyuy3GJObg@mail.gmail.com>
         <CAA85sZsH1tMwLtL=VDa5=GBdVNWgifvhK+eG-hQg69PeSxBWkg@mail.gmail.com>
         <CAA85sZu=CzJx9QD87-vehOStzO9qHUSWk6DXZg3TzJeqOV5-aw@mail.gmail.com>
         <0a040331995c072c56fce58794848f5e9853c44f.camel@redhat.com>
         <CAA85sZuuwxtAQcMe3LHpFVeF7y-bVoHtO1nukAa2+NyJw3zcyg@mail.gmail.com>
         <CAA85sZurk7-_0XGmoCEM93vu3vbqRgPTH4QVymPR5BeeFw6iFg@mail.gmail.com>
         <486ae2687cd2e2624c0db1ea1f3d6ca36db15411.camel@redhat.com>
         <CAA85sZsJEZK0g0fGfH+toiHm_o4pdN+Wo0Wq9fgsUjHXGxgxQA@mail.gmail.com>
         <CAA85sZs4KkfVojx=vxbDaWhWRpxiHc-RCc2OLD2c+VefRjpTfw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2023-06-28 at 14:04 +0200, Ian Kumlien wrote:
> So have some hits, would it be better without your warn on? ... Things
> are a bit slow atm - lets just say that i noticed the stacktraces
> because a stream stuttered =3D)

Sorry, I screwed-up completely a newly added check.

If you have Kasan enabled you can simply and more safely remove my 2nd
patch. Kasan should be able to catch all the out-of-buffer scenarios
such checks were intended to prevent.

Cheers,

Paolo

