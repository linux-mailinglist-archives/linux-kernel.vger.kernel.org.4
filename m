Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE12D7426F5
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 15:06:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbjF2NGb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 09:06:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230463AbjF2NGW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 09:06:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 132C12D78
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 06:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688043931;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RuqwY8/gS82e1/jf17RcGvVlu8cmWt3V0VXO9BfoCxE=;
        b=TK8on7NmB/nKiAfT/O4hHnxKLpSBqiQv0Sy9PoM7cfjPa32NHFduZzaHIY1B4zt+WUCnNV
        um2CMwMf1TkE11E33nT9G1dNu+kEnNChep5PvsozLPEKoafJI/EUHjeCfqA5S8oq2KoShm
        6+Vjhwb+MhGOPVaDs6Ezis5S5W+CtW0=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-206-_p3dVmhMMiO8U9iyiyn_WA-1; Thu, 29 Jun 2023 09:05:27 -0400
X-MC-Unique: _p3dVmhMMiO8U9iyiyn_WA-1
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-76716078e78so14203385a.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 06:05:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688043927; x=1690635927;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RuqwY8/gS82e1/jf17RcGvVlu8cmWt3V0VXO9BfoCxE=;
        b=UC61T5W4vPrvQ0Rz6TqtakUhqeAT3bmzWnFlypjeQbcMh2Fx+xo888evut1WLuC6FT
         z6SXvWy3Z1bKO7nemLXkSK0rLMzNt9jehWwlXKm+WFUal6WQL4hj+ggUjychePpw0W5K
         gFTe2Xg1s+BKLd2Pht34MginEkL+7cqxduAJsugAF1SlFH2q9ZyZbBGnM0IAnX8cixo6
         LLKIMpDcAzw13osavJ/6awlIUDpOZPf9pcce05Whxq9ps5LpSsZqoSisAsnnOeyqakjL
         wEgCz1newuSZIfrdSJC7Xzc5Tijig+15CTVsuI3nQHHdcjVvp07uPkg6XoYvfyK5f81v
         k6Ug==
X-Gm-Message-State: AC+VfDymo05261Z1AlSN7YbkvBXmCxIwWPIIwwuglkXAYYgcaS/2rqJD
        fm/2kb1y78uSAonAZJ2ojWt4qhpAd3obE/6ra46nzb8+NHfSZfcsb8iue3bcYaxmc2HRp5uvYHc
        P5Voe0MOuEtDX7V6x6YzNOdRY
X-Received: by 2002:a05:620a:3955:b0:75b:23a1:82a4 with SMTP id qs21-20020a05620a395500b0075b23a182a4mr3119014qkn.5.1688043927396;
        Thu, 29 Jun 2023 06:05:27 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ53zxq1krSKA1rYCWbi9iXjsVV1RVgAxxlVVAGIM7eh3ieMXpDfidkUyqa/sPpBWwmlyENA3A==
X-Received: by 2002:a05:620a:3955:b0:75b:23a1:82a4 with SMTP id qs21-20020a05620a395500b0075b23a182a4mr3118995qkn.5.1688043927136;
        Thu, 29 Jun 2023 06:05:27 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-231-196.dyn.eolo.it. [146.241.231.196])
        by smtp.gmail.com with ESMTPSA id x13-20020ae9e90d000000b00767291640e8sm1408731qkf.90.2023.06.29.06.05.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jun 2023 06:05:26 -0700 (PDT)
Message-ID: <aa84a2f559a246b82779198d3ca60205691baa94.camel@redhat.com>
Subject: Re: [PATCH] Add MODULE_FIRMWARE() for FIRMWARE_TG357766.
From:   Paolo Abeni <pabeni@redhat.com>
To:     Michael Chan <michael.chan@broadcom.com>,
        Tobias Heider <me@tobhe.de>
Cc:     Siva Reddy Kallam <siva.kallam@broadcom.com>,
        Prashant Sreedharan <prashant@broadcom.com>,
        Michael Chan <mchan@broadcom.com>, netdev@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org
Date:   Thu, 29 Jun 2023 15:05:23 +0200
In-Reply-To: <CACKFLinEbG_VVcMTPVuHeoQ6OLtPRaG7q2U5rvqPqdvk7T2HwA@mail.gmail.com>
References: <ZJt7LKzjdz8+dClx@tobhe.de>
         <CACKFLinEbG_VVcMTPVuHeoQ6OLtPRaG7q2U5rvqPqdvk7T2HwA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-06-27 at 18:31 -0700, Michael Chan wrote:
> On Tue, Jun 27, 2023 at 5:13=E2=80=AFPM Tobias Heider <me@tobhe.de> wrote=
:
> >=20
> > Fixes a bug where on the M1 mac mini initramfs-tools fails to
> > include the necessary firmware into the initrd.
> >=20
> > Signed-off-by: Tobias Heider <me@tobhe.de>
>=20
> Thanks.
> Reviewed-by: Michael Chan <michael.chan@broadcom.com>

This is a borderline situation, but ...=C2=A0

Is there a suitable 'Fixes:' tag we can add here?

Thanks!

Paolo

