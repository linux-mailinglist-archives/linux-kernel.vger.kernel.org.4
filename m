Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E1AE6A0379
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 09:02:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233320AbjBWICT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 03:02:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233369AbjBWICO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 03:02:14 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 498611B30D
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 00:01:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677139286;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KADl7iF50eFDelaiouD1GHHY7J/PM+fwkGcsqKi7oBE=;
        b=X4G8O6xS1c2WcerOZuwLkgJrKdzv3MZjw+zBkS+R+bCvv8odppRvZ1py+8wX8uZE0Fgb5R
        nEc5vG5ELp4MtxpkAMa5SYTa9HICDPlA37NLM11pNSMds2UwuoRNu8dc6Qon3RgY5Y8FOE
        oWTUn2rOcpUsy2XdoSBX3wTvKH3yOfw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-27-ElexRIhFM7iMC5IVDDu8MQ-1; Thu, 23 Feb 2023 03:01:25 -0500
X-MC-Unique: ElexRIhFM7iMC5IVDDu8MQ-1
Received: by mail-wr1-f72.google.com with SMTP id d14-20020adfa34e000000b002bfc062eaa8so2197809wrb.20
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 00:01:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KADl7iF50eFDelaiouD1GHHY7J/PM+fwkGcsqKi7oBE=;
        b=GIAnFrkWEc5bRpGW5FhLGfW5QJ4eVRI0OFNlBnAKCr6JCWHBemxaxpV+7awrt9Zq/J
         htPnwPl7XGtI3WblQgiX+NbRfiKACNT9Ul+292KV+gEkMWBq/FhGoKzrMICr/uT22NJ3
         HS6PoCXaooHdTC7jcBR03YQMqNgVjAoQHpn7Vk3BEM+eXdMFRe9GnVM7bOr8/xrmdEyw
         1OSvSRKteoirDQj9x5DzpR8CnxTJsbgfBUuB05iGyGA9zaHRWqfBuI9OHFS6RqR9K/8H
         koVb3jsgK0XKQjZnaCW87e8+f/7jcq9Oh674CGe3Su38EBmLSB/zA05vPnIiL2lsTOlr
         EMJw==
X-Gm-Message-State: AO0yUKXWu9M6fOJXBtirvZ9ceFqEmmNxssldSPMEP6Nyfd6+plH6luA+
        SBzWLfSKIIEwLpgmfEjfeyvSMR4ZF6FrfLRLZ3Ovbp6SObWq0YqHfPU4CPj6oQxzui+oRbTH09m
        R09iYmKTqillrB/UP6y/Cxt2Z
X-Received: by 2002:a05:600c:4f4e:b0:3d2:231a:cb30 with SMTP id m14-20020a05600c4f4e00b003d2231acb30mr10461536wmq.3.1677139283877;
        Thu, 23 Feb 2023 00:01:23 -0800 (PST)
X-Google-Smtp-Source: AK7set9yFEvdojJtQ+0oAUSIGKgkqkLfZYY6ldKLpCebIZE78amvJQ1PReupx3Vw0IEADOlzU2xbvA==
X-Received: by 2002:a05:600c:4f4e:b0:3d2:231a:cb30 with SMTP id m14-20020a05600c4f4e00b003d2231acb30mr10461508wmq.3.1677139283504;
        Thu, 23 Feb 2023 00:01:23 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-121-8.dyn.eolo.it. [146.241.121.8])
        by smtp.gmail.com with ESMTPSA id o27-20020a05600c511b00b003e21dcccf9fsm11547778wms.16.2023.02.23.00.01.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Feb 2023 00:01:22 -0800 (PST)
Message-ID: <9a2c3c1ef2e879911a1c62a1e8de0ae612727aae.camel@redhat.com>
Subject: Re: [PATCH v2] bnxt: avoid overflow in bnxt_get_nvram_directory()
From:   Paolo Abeni <pabeni@redhat.com>
To:     Simon Horman <simon.horman@corigine.com>,
        Maxim Korotkov <korotkov.maxim.s@gmail.com>
Cc:     Michael Chan <michael.chan@broadcom.com>,
        Pavan Chebbi <pavan.chebbi@broadcom.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
Date:   Thu, 23 Feb 2023 09:01:20 +0100
In-Reply-To: <5ad788427171d3c0374f24d4714ba0b429cbcfdf.camel@redhat.com>
References: <20230219084656.17926-1-korotkov.maxim.s@gmail.com>
         <Y/Iuu9SiAxh7qhJM@corigine.com>
         <5ad788427171d3c0374f24d4714ba0b429cbcfdf.camel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
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

On Tue, 2023-02-21 at 10:34 +0100, Paolo Abeni wrote:
> On Sun, 2023-02-19 at 15:14 +0100, Simon Horman wrote:
> > On Sun, Feb 19, 2023 at 11:46:56AM +0300, Maxim Korotkov wrote:
> > > The value of an arithmetic expression is subject
> > > of possible overflow due to a failure to cast operands to a larger da=
ta
> > > type before performing arithmetic. Used macro for multiplication inst=
ead
> > > operator for avoiding overflow.
> > >=20
> > > Found by Security Code and Linux Verification
> > > Center (linuxtesting.org) with SVACE.
> > >=20
> > > Fixes: c0c050c58d84 ("bnxt_en: New Broadcom ethernet driver.")
> > > Signed-off-by: Maxim Korotkov <korotkov.maxim.s@gmail.com>
> > > Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
> >=20
> > I agree that it is correct to use mul_u32_u32() for multiplication
> > of two u32 entities where the result is 64bit, avoiding overflow.
> >=20
> > And I agree that the fixes tag indicates the commit where the code
> > in question was introduced.
> >=20
> > However, it is not clear to me if this is a theoretical bug
> > or one that can manifest in practice - I think it implies that
> > buflen really can be > 4Gbytes.
> >=20
> > And thus it is not clear to me if this patch should be for 'net' or
> > 'net-next'.
>=20
> ... especially considered that both 'dir_entries' and 'entry_length'
> are copied back to the user-space using a single byte each.

To be clear: if this is really a bug you should update the commit
message stating how the bug could happen. Otherwise you could repost
for net-next stripping the fixes tag.

Thanks,

Paolo

