Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6110971A2DE
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 17:40:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231348AbjFAPkn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 11:40:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234509AbjFAPkk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 11:40:40 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13594F2
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 08:40:39 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id ca18e2360f4ac-77700d5a176so123639f.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 08:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1685634036; x=1688226036;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vZ+EiS+GQTo9AhoMTu3o3MEzgb5CpypJEioCqg0kvwY=;
        b=mUwKms3MQB40gOnUj9w/LsDIifBL4E72NvbbTbjieV6RnMe6YUevOcGljDQCmBbIHG
         YjPASne2HN0sCyaEnoemFzJIl/ednz3wIoiwjjsnz/mhfBabJT7Zp4lRzyP7Z/LCmxB1
         61ecMUlvEEtsSEQ0YfsJGo3VNd6MAqHYVNUUY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685634036; x=1688226036;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vZ+EiS+GQTo9AhoMTu3o3MEzgb5CpypJEioCqg0kvwY=;
        b=Ur0kFnr8QpMSV4WdJY6R4UGiIBdmGOiCleJZhrk92XyaHlOjnxW8ZcH7C3ym2vPYkc
         xXRYjKCyDGew3R+dmnwtQjsNKqv/ualwEPSL8mPSBpp49dKAXGOVWuKLvrQnBPjp7888
         IS0cK0HKRLuXIkvcGPVYwn07z1hDaKz+UcruKb24t5VESxruHZbTxAHcmcdjSbziJ0vv
         QNt6x2DnWn5aAhWnDDTV78yVfE5TNcO7xbiKssvr3ID9PUnYYsifh9+VI9R696jBZ5fk
         Ict5HpWvKvdabvhcgfXIcWAnEt3577CgjkMgMRGhrUs7o6qDOf0ojPpWTtM1mSw1LAKV
         6NqQ==
X-Gm-Message-State: AC+VfDyjm5FM7fKjc1suhXz+0N7h2p3LKD3tXz5cWb4Xsv5CDMMBy+oc
        T7YTbDzy5Ul0DGRFHi8WGIBEFTrRvLQLxV+s3CM=
X-Google-Smtp-Source: ACHHUZ4xguYEObOx6CGxZ+n2zaXYPoMo8//NhrmZyhqrq4iJBa7WlXdlnIAcgMWz//gRQ6NUISEhwg==
X-Received: by 2002:a6b:6216:0:b0:776:feaf:8cef with SMTP id f22-20020a6b6216000000b00776feaf8cefmr7499898iog.2.1685634036257;
        Thu, 01 Jun 2023 08:40:36 -0700 (PDT)
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com. [209.85.166.174])
        by smtp.gmail.com with ESMTPSA id x5-20020a056638248500b003c4f35c21absm2184936jat.137.2023.06.01.08.40.35
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Jun 2023 08:40:35 -0700 (PDT)
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-33bf12b5fb5so128405ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 08:40:35 -0700 (PDT)
X-Received: by 2002:a05:6e02:180c:b0:33b:3d94:afb5 with SMTP id
 a12-20020a056e02180c00b0033b3d94afb5mr191613ilv.25.1685634034756; Thu, 01 Jun
 2023 08:40:34 -0700 (PDT)
MIME-Version: 1.0
References: <CAD=FV=VYfPSwar2AXBxB3vX0dV1kjQ5bZMxsEBFhUnMNRXbBCw@mail.gmail.com>
 <20230520050649.2494497-1-yangcong5@huaqin.corp-partner.google.com>
 <20230520050649.2494497-3-yangcong5@huaqin.corp-partner.google.com>
 <CAD=FV=Wm_SK0V6WJUkuvu8yFfiP60JBuOdw9cy=0Ck2Jbn-X2A@mail.gmail.com>
 <bd19f71b-59ee-80e7-9ff1-1cc26ecc49a7@kernel.org> <CAD=FV=WaVXUr8=4MrZQgA7t=yUBDt-iMvOFSeWhsKZ8XHJAREA@mail.gmail.com>
 <CAHwB_N+ZpCAYftCLRwyNo2wCca+JHfGJc0_rJ=jwJcU0mbG=Dw@mail.gmail.com>
In-Reply-To: <CAHwB_N+ZpCAYftCLRwyNo2wCca+JHfGJc0_rJ=jwJcU0mbG=Dw@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 1 Jun 2023 08:40:23 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XBwZmJUVKqX5XOrgJB-VYPgJP=HKr+DoFRFu3C3tGq2w@mail.gmail.com>
Message-ID: <CAD=FV=XBwZmJUVKqX5XOrgJB-VYPgJP=HKr+DoFRFu3C3tGq2w@mail.gmail.com>
Subject: Re: [v2 2/2] dt-bindings: input: touchscreen: Add ilitek 9882T
 touchscreen chip
To:     cong yang <yangcong5@huaqin.corp-partner.google.com>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        benjamin.tissoires@redhat.com, devicetree@vger.kernel.org,
        dmitry.torokhov@gmail.com, hsinyi@google.com, jikos@kernel.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        mka@chromium.org, Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, May 31, 2023 at 8:06=E2=80=AFPM cong yang
<yangcong5@huaqin.corp-partner.google.com> wrote:
>
> Thanks, I'll keep an eye on that next time. This patch can be discarded,.=
After adding this series https://lore.kernel.org/r/20230523193017.4109557-1=
-dianders@chromium.org=EF=BC=8C

Thanks! I'll see if I can give that series a spin soon and then see
how we can make progress to getting it landed.


> using ekth6915  also can meet my needs.

Even if using ekth6915 can meet your needs, it's still better to
actually add the right compatible string. Putting in the device tree
that you have an "elan6915" and that you're providing "vcc33" isn't
the best when you actually have a different touchscreen and are
providing a very different voltage. Adding the proper bindings is
definitely preferred.


> On Wed, May 31, 2023 at 12:58=E2=80=AFAM Doug Anderson <dianders@chromium=
.org> wrote:
>>
>> Hi,
>>
>> On Tue, May 30, 2023 at 4:56=E2=80=AFAM Krzysztof Kozlowski <krzk@kernel=
.org> wrote:
>> >
>> > On 22/05/2023 17:33, Doug Anderson wrote:
>> > > Hi,
>> > >
>> > > On Fri, May 19, 2023 at 10:07=E2=80=AFPM Cong Yang
>> > > <yangcong5@huaqin.corp-partner.google.com> wrote:
>> > >>
>> > >> Add an ilitek touch screen chip ili9882t.
>> > >>
>> > >> Signed-off-by: Cong Yang <yangcong5@huaqin.corp-partner.google.com>
>> > >> ---
>> > >>  .../devicetree/bindings/input/elan,ekth6915.yaml         | 9 +++++=
++--
>> > >>  1 file changed, 7 insertions(+), 2 deletions(-)
>> > >
>> > > I'm curious about the DT maintainers opinion here. Should this be a
>> > > new bindings file, or should it be together in the elan file. If
>> > > nothing else, I think the secondary voltage rail name is wrong. I to=
ok
>> > > a quick peek at a datasheet I found and I don't even see a 3.3V rail
>> > > going to the ili9882t. That makes it weird to reuse "vcc33-supply" f=
or
>> > > a second supply...
>> >
>> > It's easier if they are CCed...
>>
>> Crud. I just assumed and didn't check the CC list. Cong: can you
>> resend and make sure you're CCing the people that get_maintainers
>> points at. One way to find that would be:
>>
>> ./scripts/get_maintainer.pl -f
>> Documentation/devicetree/bindings/input/elan,ekth6915.yaml
