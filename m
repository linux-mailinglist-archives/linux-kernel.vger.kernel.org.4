Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8714D6C9D6F
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 10:17:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232732AbjC0IRD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 04:17:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232667AbjC0IRA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 04:17:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC6355255
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 01:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679904973;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dqM4HxKTQa8CAlzTf6R5B7JwdVrZ3pTGuhEoPvMHOiA=;
        b=ire0i4u5UjASnCxnWJzk82t7I8oiDhk5QbsRdp8zt0TUpozFsVNwB5Xub2C6qvYD19ZHZN
        ltrNWqTYAgQC3oyUP1NTTY+0vJHRzRQ55SUJdhkYBVrPetxpXvxStuTK6q4kcPn0MUVkVn
        m0AVqRY8NTkdcydpgCfg4x9XzQJxqUo=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-208-NpnutbZtNu25V9jXgiH7YQ-1; Mon, 27 Mar 2023 04:16:11 -0400
X-MC-Unique: NpnutbZtNu25V9jXgiH7YQ-1
Received: by mail-wr1-f70.google.com with SMTP id d18-20020adfa412000000b002d43970bb80so611415wra.6
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 01:16:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679904970;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dqM4HxKTQa8CAlzTf6R5B7JwdVrZ3pTGuhEoPvMHOiA=;
        b=daYNmCSCfKTWpQbRluaxDFN79e0XC2DYjf8UdCYGU26Y+dYWNBL/DGdgPOflw8FyFH
         JHEngupK9RjzfjjxMI9+6eqaPtBSMmMNTz32bhZpxFgmsait32nVXsKEc4X2SxJIfOBT
         cGIJS+I5ePBRyBxdNrtP7uEHrNDKioQdEaRa1HtlVuttCmhIAb2pF8k5aiVwUd4XgWth
         X4dm3cSgtf+nOR0AMdyJ1+K2qcOlOilRoK6hShhjwQSkGeeajBgD0yDOJhrqR6suup2d
         gnn4xdlQyKMzqnU0dnbGCF4hPIwhtJzF3w1UNLq650wyUrVfFZxxeVJcdr0xpwzFZyZO
         totA==
X-Gm-Message-State: AO0yUKUu1H8FSskJ0t13rscLZmGZufScuqbu3iy7cMuQA+arsCo/WLAW
        Dbq/PHWku5ptTWvgpq1x1qNKH5VZGxhOa7A8H591JUYva94+ZLmkeKjdufZ4Dgi9t5ykiNrJbeB
        eqOvbpkbAF1t6BM8XTDyDl3E4hv+hO0Oi
X-Received: by 2002:a1c:7318:0:b0:3ed:3cec:d2ec with SMTP id d24-20020a1c7318000000b003ed3cecd2ecmr9224591wmb.15.1679904969985;
        Mon, 27 Mar 2023 01:16:09 -0700 (PDT)
X-Google-Smtp-Source: AK7set8ZUoTXxMxtwd0sU6jQR8jMhRDwPLktCNTgCwqGs+AGnExW7nkz8pp+TofqXoPOE6jQzeNX9w==
X-Received: by 2002:a1c:7318:0:b0:3ed:3cec:d2ec with SMTP id d24-20020a1c7318000000b003ed3cecd2ecmr9224554wmb.15.1679904969577;
        Mon, 27 Mar 2023 01:16:09 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id t14-20020a05600c198e00b003ef66c89af0sm7017891wmq.0.2023.03.27.01.16.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 01:16:09 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Jarrah <kernel@undef.tools>, linux-kernel@vger.kernel.org
Cc:     Robert Mader <robert.mader@collabora.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Peter Robinson <pbrobinson@gmail.com>,
        Jacopo Mondi <jacopo.mondi@ideasonboard.com>,
        Ondrej Jirman <megi@xff.cz>, Martijn Braam <martijn@brixit.nl>,
        Kamil =?utf-8?Q?Trzci=C5=84ski?= <ayufan@ayufan.eu>,
        Caleb Connolly <kc@postmarketos.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Tom Fitzhenry <tom@tom-fitzhenry.me.uk>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v2] arm64: dts: rk3399-pinephone-pro: Add internal
 display support
In-Reply-To: <e4f82c1e-621e-7e94-497d-8c579264f996@undef.tools>
References: <20230327074136.1459212-1-javierm@redhat.com>
 <e4f82c1e-621e-7e94-497d-8c579264f996@undef.tools>
Date:   Mon, 27 Mar 2023 10:16:08 +0200
Message-ID: <87edpatxrr.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jarrah <kernel@undef.tools> writes:

> Hi Javier,
>
> On 3/27/23 18:41, Javier Martinez Canillas wrote:
>> From: Ondrej Jirman <megi@xff.cz>
>>
>> The phone's display is using a Hannstar LCD panel. Support it by adding a
>> panel DT node and all needed nodes (backlight, MIPI DSI, regulators, etc=
).
>>
>> Signed-off-by: Ondrej Jirman <megi@xff.cz>
>> Co-developed-by: Martijn Braam <martijn@brixit.nl>
>> Co-developed-by: Kamil Trzci=C5=84ski <ayufan@ayufan.eu>
>> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
>> ---
>>
>> Changes in v2:
>> - Drop touchscreen node because used the wrong compatible (Ondrej Jirman=
).
>
>
> Any reason not to include this with the correct compatible string? It's=20
> been available since=20
> https://lore.kernel.org/all/20220813043821.9981-1-kernel@undef.tools/.=20
> Swapping out gt917s for gt1158 in the node from your previous patch=20
> should be enough.
>

Yes, but I didn't know that the driver already had the compatible string
so I just dropped it for now and was meaning to take a look to that later.

Adding the touchscreen node can be done as a follow-up though in another
patch.

--=20
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

