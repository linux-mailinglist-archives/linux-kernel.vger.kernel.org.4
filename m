Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29AE36DF541
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 14:30:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230236AbjDLMaU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 08:30:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230009AbjDLMaR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 08:30:17 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B131769D
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 05:29:57 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-94a34a0fc1dso271242166b.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 05:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dectris.com; s=google; t=1681302596; x=1683894596;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MLp10WEiVKKRfi0jPvUlHAptfbcw1jdZpFv7p0ceEMc=;
        b=fiko1kujM9EMpsIe8pKAFagHh9m6DO8hXPnkE34F9JJw1ZVbWKnzhuIyigxPgIe9bT
         mOdzvQtIqivAXnuTeumInAjKSXDkOsSdZDehT/8eRRNBp5trxGtLENMCpd0VDwd7LJjs
         hdWzdfn2cCG7Bhchj82AqR6FmV2J5ydn8Amo4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681302596; x=1683894596;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MLp10WEiVKKRfi0jPvUlHAptfbcw1jdZpFv7p0ceEMc=;
        b=BQ4o3nr3d+OW1To923EZ+x/Vg12AddrD4mOIN5CSYjCgq65v5uMG7Rb+b7y+mJzjPz
         oMiF/3zQH5KKrZFtaYtCfU6ozSZhEz3lqihw/lgaTYa2BxfHsdzNGHkEyV37JgAAGYwr
         BRIPYyDjjiUnIvqPsAJ1nFLEc8jqysR/hP2My0cxaap2GDhwOJb5137AudbVTa8/nMpO
         EKpnmJEWpiku0x+lbs9RdjYm3dIuxz65z16nxWH0XTX2hGRAf0LvkwLev0LO1mRdGuYL
         yYvaCPNDWC+L3RDO0nnqVCLDiP9UIyJuXTP11ip6M4FRWR4WCSuksJnPe9a5BoF3prMm
         wZqg==
X-Gm-Message-State: AAQBX9dImJ2UwUVlEBAE7gaH3BuEMvUb2z17gXLtouHMxuPQVrHh0XHP
        +fVdtuidba8m3r2AXUm7+BCVihOK833GjomzGOuQNA==
X-Google-Smtp-Source: AKy350YPuGvkISg3PavQb5IzwqvaGQHEAA7hmVuaX4QKgwnId8gqLgjbIJzsOQ/V96GwAbNVO0EJS8n4ceBOQPz/GfA=
X-Received: by 2002:a50:d71e:0:b0:504:9c1f:1c65 with SMTP id
 t30-20020a50d71e000000b005049c1f1c65mr5431631edi.6.1681302596073; Wed, 12 Apr
 2023 05:29:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230410121841.643254-1-kal.conley@dectris.com> <CAJ8uoz11tOSUK0+45K=L9q-yj3gyMCDJVPsOjawE+Wjbe2FSTQ@mail.gmail.com>
In-Reply-To: <CAJ8uoz11tOSUK0+45K=L9q-yj3gyMCDJVPsOjawE+Wjbe2FSTQ@mail.gmail.com>
From:   Kal Cutter Conley <kal.conley@dectris.com>
Date:   Wed, 12 Apr 2023 14:34:40 +0200
Message-ID: <CAHApi-n9Vv-RvK-byG_hBiEqE+Apqb_Hvq-L1-yq3Q0LTtQDbQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next] xsk: Simplify xp_aligned_validate_desc implementation
To:     Magnus Karlsson <magnus.karlsson@gmail.com>
Cc:     =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
        Magnus Karlsson <magnus.karlsson@intel.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Jonathan Lemon <jonathan.lemon@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > Perform the chunk boundary check like the page boundary check in
> > xp_desc_crosses_non_contig_pg(). This simplifies the implementation and
> > reduces the number of branches.
>
> Thanks for this simplification Kal. Just to check, does your change
> pass the xsk selftests, especially the INV_DESC test? If so, then you
> have my ack below.
>
> Acked-by: Magnus Karlsson <magnus.karlsson@intel.com>

Yes, I ran the XSK selftests and they all PASSED.
