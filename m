Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E85A68D56A
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 12:28:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231379AbjBGL2X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 06:28:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230445AbjBGL2T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 06:28:19 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18285E398
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 03:27:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675769251;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NjK2kZBOicICFKKeKjHG/kRG3ABMzmNQEsUkC1U+ZhY=;
        b=iFa8euGOZsmuDzIXX/Ju2TUj27vmZ1BuVpP4YA7WQznjgFgBqnI1dR1M0NvAuA/mk6XJYU
        YfBd3V6eg8of5oIzL8TDut8ybrbtZjhUaRCtTxRhlfor4KnhwySkjqCDYhWIav2GNfCrH0
        FwGMwPjyNpqccqWy49BT1o0VnSxxGuk=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-629-nKD3i5BTMg-0RXVjPKzrdw-1; Tue, 07 Feb 2023 06:27:30 -0500
X-MC-Unique: nKD3i5BTMg-0RXVjPKzrdw-1
Received: by mail-qv1-f72.google.com with SMTP id b19-20020a0ccd13000000b005374d115edbso7461658qvm.19
        for <linux-kernel@vger.kernel.org>; Tue, 07 Feb 2023 03:27:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NjK2kZBOicICFKKeKjHG/kRG3ABMzmNQEsUkC1U+ZhY=;
        b=ogITOP0HnPGOBM5L7/6G9cUeIzpU7lcVHBdc6kpxkb2dFw6scyAazeGSSkCItAPPGV
         cpEXQJZsrB+U7Zk5GG2AA+jj7bYzeNkCNQLDQX7u6kTQnR16FoWsJZ8XmJcmKno9DDUT
         Pwu7pUaFc8owkyA1po+Ysz1QLH5mtKb11McJUWxZI0eamojp4bp8covSX91BzABr+JsN
         s79T9YOZ2+Id3QPBWhZQpc4XmCHmBhI7vrgm9ke9SXDS5yxuzX+qOcZQjSS0Pbape1BB
         xMftQklTj0ZTOhok4qcRB0UefRST4u3X3dG1XDI9OP7NYc0LGnCHRt4jdqMAE4cVECF1
         UxPA==
X-Gm-Message-State: AO0yUKWRm05dBAt/5R0HNg9nLxSNugvSZVnTymWphojjQh1R2u4+kWu1
        9fl3nSGiMl07OpkVU5R/WhAsH1mVPkb9Ncz+bsHA/8Q1s1akxO2L+sCyvs9HIbdDxlOiyBoj6vp
        sR0i11mjCaz38xuPvZS6w3YxM
X-Received: by 2002:a0c:f587:0:b0:538:a431:8630 with SMTP id k7-20020a0cf587000000b00538a4318630mr3558217qvm.1.1675769249869;
        Tue, 07 Feb 2023 03:27:29 -0800 (PST)
X-Google-Smtp-Source: AK7set/UomiMZJq0DCZT+ohWr7e/c9M7OAp5dyxgo1bvtA3OuUL0OCSJ2+9BVBbxQJwAvBRDKfrIVg==
X-Received: by 2002:a0c:f587:0:b0:538:a431:8630 with SMTP id k7-20020a0cf587000000b00538a4318630mr3558188qvm.1.1675769249547;
        Tue, 07 Feb 2023 03:27:29 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-113-28.dyn.eolo.it. [146.241.113.28])
        by smtp.gmail.com with ESMTPSA id br34-20020a05620a462200b0071d7ade87afsm9482828qkb.67.2023.02.07.03.27.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 03:27:28 -0800 (PST)
Message-ID: <5314e0ba3a728787299ca46a60b0a2da5e8ab23a.camel@redhat.com>
Subject: Re: [PATCH net v2 1/2] net: ll_temac: Fix DMA resources leak
From:   Paolo Abeni <pabeni@redhat.com>
To:     Jonas Suhr Christensen <jsc@umbraculum.org>, netdev@vger.kernel.org
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Harini Katakam <harini.katakam@amd.com>,
        Haoyue Xu <xuhaoyue1@hisilicon.com>,
        huangjunxian <huangjunxian6@hisilicon.com>,
        Wang Qing <wangqing@vivo.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        Esben Haabendal <esben@geanix.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Date:   Tue, 07 Feb 2023 12:27:25 +0100
In-Reply-To: <20230205201130.11303-2-jsc@umbraculum.org>
References: <20230205201130.11303-1-jsc@umbraculum.org>
         <20230205201130.11303-2-jsc@umbraculum.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.3 (3.46.3-1.fc37) 
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

Hi,

On Sun, 2023-02-05 at 21:11 +0100, Jonas Suhr Christensen wrote:
> Add missing conversion of address when unmapping dma region causing
> unmapping to silently fail. At some point resulting in buffer
> overrun eg. when releasing device.
>=20
> Fixes: fdd7454ecb29 ("net: ll_temac: Fix support for little-endian platfo=
rms")
>=20
> Signed-off-by: Jonas Suhr Christensen <jsc@umbraculum.org>

I'm sorry for nit-picking, but you must avoid empty lines in the tag
area. Please post a v2 avoiding the empty line between the Fixes and
sob tags (both here and in the next patch).

You can retain (include in the tag area) the already collected
reviewed-by/acked-by tags.

Thanks,

Paolo

