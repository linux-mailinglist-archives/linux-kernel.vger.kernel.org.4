Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A61F370459F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 08:53:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230373AbjEPGxr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 02:53:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230083AbjEPGxn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 02:53:43 -0400
Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D7882115
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 23:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
        s=default2211; h=To:References:Message-Id:Content-Transfer-Encoding:Cc:Date:
        In-Reply-To:From:Subject:Mime-Version:Content-Type:Sender:Reply-To:Content-ID
        :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=3g5tO1PVcgvgJYBxdB9pIMzJzUAhoJ/jXAMrZp04LaM=;
        b=v09SLakaPCy0NVJvDbu5wZps1gFsxacCRAmr5z+VBy6X5fm5ok8cMuQR1jNe6kgZrV7NKXm+GwW
        KpITeha+nAWGJTRdmt8QoG1hSUzwV4A8NDuTn/Iw/3o0WRGrqTaTtvBdHTtsBUTgNjakGIuVNvic+
        EjXE+G0TqUPN59f3uwKC0ZVVGDc1g9RpcAQLGjeQ05mGmgWfFggyVk0Zz8XFWHvcsYeDyUKqOqcSy
        yo/xlx9AuNZBGe8hi6LmItEVnagF6zVxcVPa1ZpBnpDMnsCUkn7Jd98Cca5MlCA+puFnOxdbIGX5x
        zGPssTnF7/pRcujSn3l4rtL++1blDjqJl8/Q==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
        by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <sean@geanix.com>)
        id 1pyoYR-000LPi-CK; Tue, 16 May 2023 08:53:03 +0200
Received: from [185.17.218.86] (helo=smtpclient.apple)
        by sslproxy01.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92)
        (envelope-from <sean@geanix.com>)
        id 1pyoYR-000Kie-3r; Tue, 16 May 2023 08:53:03 +0200
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.500.231\))
Subject: Re: [PATCH 1/2] mfd: stpmic1: fixup main control register and bits
 naming
From:   =?utf-8?Q?Sean_Nyekj=C3=A6r?= <sean@geanix.com>
In-Reply-To: <20230515124359.GE10825@google.com>
Date:   Tue, 16 May 2023 08:52:52 +0200
Cc:     p.paillet@st.com, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <96FCF718-4FD8-4679-98DD-DCF0BE9918B7@geanix.com>
References: <20230428112847.2146348-1-sean@geanix.com>
 <20230515124359.GE10825@google.com>
To:     Lee Jones <lee@kernel.org>
X-Mailer: Apple Mail (2.3731.500.231)
X-Authenticated-Sender: sean@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.8/26907/Mon May 15 09:25:12 2023)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lee,

> On 15 May 2023, at 14.43, Lee Jones <lee@kernel.org> wrote:
>=20
> On Fri, 28 Apr 2023, Sean Nyekjaer wrote:
>=20
>> Fixup main control register and bits naming so the match the naming =
from
>> the datasheet.
>=20
> I'm in two minds about this.
>=20
> On one hand using the names from the datasheet in the right thing to
> do, however, on the other hand, the current nomenclature appears =
clearer.

If you like me, tries to understand what=E2=80=99s happening inside the =
PMIC. It=E2=80=99s really nice to have the same naming in the software =
as in the datasheet.

It looks like the naming was updated in the datasheet version 9.

>=20
>> https://www.st.com/resource/en/datasheet/stpmic1.pdf
>>=20
>>=20

[ =E2=80=A6 ]

>>=20
>=20
> --=20
> Lee Jones [=E6=9D=8E=E7=90=BC=E6=96=AF]


/Sean=
