Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D43F15E6885
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 18:35:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230398AbiIVQfK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 12:35:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229926AbiIVQfC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 12:35:02 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3C121CFF0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 09:35:00 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id r18so22234052eja.11
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 09:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=80Ysi9BOZsUySgtl5w14oQyBL/DjQ2nqgskjrFp2JKY=;
        b=Rf0lLgIXWgX+pNVKvIfdMFHSwK8n4MRrg8lOYn4mYs0RStvSNUJolq7PD9kx6Ye+Vh
         no06ijhZ9UM00OyLJ6ER2BeaANafwHEHMY6xQsvbsSdhyhy2Cy57SB/cxL+hxvfJDZJs
         dV/zhPHh6AH9bFZu5TPA+YupsESJPwFFoTdlc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=80Ysi9BOZsUySgtl5w14oQyBL/DjQ2nqgskjrFp2JKY=;
        b=xN1fDe8zPIPrm8dcz2/Speu6ro1snYhRWTIy0C3Sf2sQR2OZnn0G0KcPJrteGIjwqW
         5cNEQ5x+5aj1+JnQHrdm/768Ncpnc2yuEdqcYP7ri2PVsKTAe86+PAZnVS/3JBERUE4u
         9VmWuA0th/d+njlZad/aZ3uw2JlTgKAHKCeDoC7lusGr/UrZstdep4nVj73+L05SZRyV
         m8E7S2DKAnMD8TmJxxHrpj1gXLqMUj4KZMBahUNFbAzGMJTXJCG/H9iYWkIzVq3TxrsA
         SkmLH+AI7Wm1iRkaC34yT8tc//PG7KV1vq/684ejWKYPW6OhE1KMMjak7znDH4FtBRWt
         v8Fg==
X-Gm-Message-State: ACrzQf39gMmKoI0OFLLGSWL1pGYNnZ+Ze7tfx//ME9BEUHDZtG5wOBWh
        MDN1ttijbkfZiJ8StjQrt0/i0/NCK7fQqm3o
X-Google-Smtp-Source: AMsMyM5yojqj5codNcim4zZKmJYjz0tqUgXfeFzvTeqxkHu6BnOjLS3EAnEjBJyIMhHT6fus63RsOg==
X-Received: by 2002:a17:907:b15:b0:782:f8:8695 with SMTP id h21-20020a1709070b1500b0078200f88695mr3411876ejl.693.1663864498799;
        Thu, 22 Sep 2022 09:34:58 -0700 (PDT)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com. [209.85.128.46])
        by smtp.gmail.com with ESMTPSA id lh7-20020a170906f8c700b0073d6d6e698bsm2788764ejb.187.2022.09.22.09.34.57
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Sep 2022 09:34:57 -0700 (PDT)
Received: by mail-wm1-f46.google.com with SMTP id ay36so7180785wmb.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 09:34:57 -0700 (PDT)
X-Received: by 2002:a05:600c:1e18:b0:3b3:b9f8:2186 with SMTP id
 ay24-20020a05600c1e1800b003b3b9f82186mr3148288wmb.151.1663864496688; Thu, 22
 Sep 2022 09:34:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220922101813.v4.1.I3aa360986c0e7377ea5e96c116f014ff1ab8c968@changeid>
 <20220922101813.v4.3.Ic4e8f03868f88b8027a81bc3d414bae68978e6b7@changeid>
In-Reply-To: <20220922101813.v4.3.Ic4e8f03868f88b8027a81bc3d414bae68978e6b7@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 22 Sep 2022 09:34:44 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WvagXMojeQJW-uzy59Q0m0oQpjopNwPkupDq4gGJoQgw@mail.gmail.com>
Message-ID: <CAD=FV=WvagXMojeQJW-uzy59Q0m0oQpjopNwPkupDq4gGJoQgw@mail.gmail.com>
Subject: Re: [PATCH v4 3/4] dt-bindings: input: touchscreen: elants_i2c: Add
 eth3915n touchscreen chip
To:     Yunlong Jia <ecs.beijing2022@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Yunlong Jia <yunlong.jia@ecs.com.tw>,
        Henry Sun <henrysun@google.com>,
        Bob Moragues <moragues@chromium.org>,
        David Heidelberg <david@ixit.cz>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Sep 22, 2022 at 3:23 AM Yunlong Jia <ecs.beijing2022@gmail.com> wrote:
>
> Add an elan touch screen chip eth3915n.
>
> Signed-off-by: Yunlong Jia <ecs.beijing2022@gmail.com>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>

You should have left my Reviewed-by off in this case. I haven't
actually seen this patch. You could have possibly added "Suggested-by"
or just left me off entirely until I gave you the tag.


> ---
>
> (no changes since v1)

I probably would have added this in patman:

Series-changes: 4
-  eth3915n dt bindings added in v4.

Without that you get the "(no changes from v1)" which is always weird
since this patch is new for v4.


>  .../devicetree/bindings/input/touchscreen/elan,elants_i2c.yaml   | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/input/touchscreen/elan,elants_i2c.yaml b/Documentation/devicetree/bindings/input/touchscreen/elan,elants_i2c.yaml
> index a9b53c2e6f0ab..d28625372f5ac 100644
> --- a/Documentation/devicetree/bindings/input/touchscreen/elan,elants_i2c.yaml
> +++ b/Documentation/devicetree/bindings/input/touchscreen/elan,elants_i2c.yaml
> @@ -17,6 +17,7 @@ properties:
>      enum:
>        - elan,ektf3624
>        - elan,ekth3500
> +      - elan,ekth3915

This is not quite right because for elan,ekth3915 you're expecting
device trees to have:

compatible = "elan,ekth3915", "elan,ekth3500"

In other words it's actually a 3915 but the 3500 driver should work
fine. I believe a reasonable syntax is:

  compatible:
    oneOf:
      - enum:
          - elan,ektf3624
          - elan,ekth3500
      - items:
          - const: elan,ekth3915
          - const: elan,ekth3500

-Doug
