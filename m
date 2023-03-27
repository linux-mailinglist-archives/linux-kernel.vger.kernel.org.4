Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6F5B6CA067
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 11:48:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232411AbjC0Jsb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 05:48:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231740AbjC0Js2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 05:48:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F87D358E
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 02:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679910460;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UexsxBht+jxcQGbFpZtHQeoklM+LHfVAC+dy1h7cowM=;
        b=X1zyzkBYyTZbxT5AbIZEx4ZTHDBPTBhUfA8fmKpk3gMXXwlH1tE2LM+dk2YzbevEUmqQm3
        JK4GLBKkyk2pqjx9vrEDJsubtN13kt1OXlMJMYOMPrAqdwJ2u8i3FgBCJI0IpDmxLAb1v/
        hu6+0pPAex7LaVshoVgJanwZjfa4TEk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-52-IJYLeM1MO8SVJkt5WJeBgw-1; Mon, 27 Mar 2023 05:47:38 -0400
X-MC-Unique: IJYLeM1MO8SVJkt5WJeBgw-1
Received: by mail-wm1-f70.google.com with SMTP id n19-20020a05600c3b9300b003ef63ef4519so2928418wms.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 02:47:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679910457;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UexsxBht+jxcQGbFpZtHQeoklM+LHfVAC+dy1h7cowM=;
        b=nxwXXzvbs92PwbN5ueAD0jrUZt8WhXwNnTPeN47paaO4ETBrbYdisHU4TnBAx3apXA
         B2HeOS1mBlXzMHgBCiswEjGV8hctkmWaJ4UsB7cDSEc2GVhlZ+XTRIqq/SvvKWWwrWfj
         HlnzBDZHzlmOEcTctx4+MuqGh9tEsTgwqBgUg8E2nJJ5qw9rbn2DduDMEAooQDjybINE
         A4jy6oeJyvS5cduiJhABCVttoYeRbirF2uVMaYjAxKShkM9bk1FtPglGBvrIzfM8RJwU
         OHpBzAyzaSuRvZ5RN7MYH+rFrrOYdPPj2swBPGixKGHKBgHc1HIbElODfA/NfpB77FOj
         SbPw==
X-Gm-Message-State: AO0yUKUmuRUzjHVcPR7EufDJcglCwJ7jJI8SbX0N8qifBe7VGuPF1XHV
        tEGDUtnPDqDJCvsE7kkGbZlhFypu5EdrPTIutHqQywVYJy9v+EPuGTz9eICE1efH+rqzoGG9Lhw
        FpyhmZukKiNZHN2uNx8z9I1qh
X-Received: by 2002:a7b:ca4a:0:b0:3ed:d64f:ec30 with SMTP id m10-20020a7bca4a000000b003edd64fec30mr8803741wml.33.1679910457672;
        Mon, 27 Mar 2023 02:47:37 -0700 (PDT)
X-Google-Smtp-Source: AK7set+UMdm5OyaHT8e/wc2182TlZp7+1fqvjLjvg3Dk9zSSwByHNG77k78UMNffu150tQK9N3KGLQ==
X-Received: by 2002:a7b:ca4a:0:b0:3ed:d64f:ec30 with SMTP id m10-20020a7bca4a000000b003edd64fec30mr8803729wml.33.1679910457371;
        Mon, 27 Mar 2023 02:47:37 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id g19-20020a05600c311300b003ee74c25f12sm8255428wmo.35.2023.03.27.02.47.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 02:47:37 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Jarrah <kernel@undef.tools>,
        Heiko =?utf-8?Q?St=C3=BCbner?= <heiko@sntech.de>,
        linux-kernel@vger.kernel.org
Cc:     Robert Mader <robert.mader@collabora.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Peter Robinson <pbrobinson@gmail.com>,
        Jacopo Mondi <jacopo.mondi@ideasonboard.com>,
        Ondrej Jirman <megi@xff.cz>, Martijn Braam <martijn@brixit.nl>,
        Kamil =?utf-8?Q?Trzci=C5=84ski?= <ayufan@ayufan.eu>,
        Caleb Connolly <kc@postmarketos.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Tom Fitzhenry <tom@tom-fitzhenry.me.uk>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v2] arm64: dts: rk3399-pinephone-pro: Add internal
 display support
In-Reply-To: <40e61776-bcdd-25ac-286a-1ba0184dbd7e@undef.tools>
References: <20230327074136.1459212-1-javierm@redhat.com>
 <e4f82c1e-621e-7e94-497d-8c579264f996@undef.tools>
 <8197476.T7Z3S40VBb@diego>
 <40e61776-bcdd-25ac-286a-1ba0184dbd7e@undef.tools>
Date:   Mon, 27 Mar 2023 11:47:36 +0200
Message-ID: <878rfittjb.fsf@minerva.mail-host-address-is-not-set>
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

> On 3/27/23 20:11, Heiko St=C3=BCbner wrote:
>> Am Montag, 27. M=C3=A4rz 2023, 09:55:15 CEST schrieb Jarrah:
>>> Hi Javier,
>>>
>>> On 3/27/23 18:41, Javier Martinez Canillas wrote:
>>>> From: Ondrej Jirman <megi@xff.cz>
>>>>
>>>> The phone's display is using a Hannstar LCD panel. Support it by addin=
g a
>>>> panel DT node and all needed nodes (backlight, MIPI DSI, regulators, e=
tc).
>>>>
>>>> Signed-off-by: Ondrej Jirman <megi@xff.cz>
>>>> Co-developed-by: Martijn Braam <martijn@brixit.nl>
>>>> Co-developed-by: Kamil Trzci=C5=84ski <ayufan@ayufan.eu>
>>>> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
>>>> ---
>>>>
>>>> Changes in v2:
>>>> - Drop touchscreen node because used the wrong compatible (Ondrej Jirm=
an).
>>>
>>> Any reason not to include this with the correct compatible string? It's
>>> been available since
>>> https://lore.kernel.org/all/20220813043821.9981-1-kernel@undef.tools/.
>>> Swapping out gt917s for gt1158 in the node from your previous patch
>>> should be enough.
>> Just wondering if I'm blind, Javier's patch doesn't contain any touchscr=
een
>> controller (haven't found neither gt9* or gt11* mentioned there), so
>> I'm inclined to go with the "touchscreen can be added later" thing.
>
>
> I was just commenting on the "Changes in v2" section. v1 had a=20
> touchscreen node in it (assuming I found the right v1).
>
>
> All good, I can follow up with a patch for the touchscreen.
>

That would be great, thanks Jarrah!

--=20
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

