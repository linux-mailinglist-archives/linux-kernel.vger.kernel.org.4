Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05F456EAEE5
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 18:16:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230255AbjDUQP6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 12:15:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233017AbjDUQP4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 12:15:56 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2488FA253
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 09:15:54 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id d75a77b69052e-3ef31206cbdso10841161cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 09:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1682093752; x=1684685752;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9QZZtA/5NWdnQgb0jJuRZbKZ4eCkzSLiidtnIgHAhGA=;
        b=a8+2RGUw/TaJ1yL8knlBFv1az7Sde7vE9Um7l8X8hnraVntQeEDOmTPUq4cBwy10nl
         ht6bdf5QBolNl6OCsiQAjKO5usbzJzBJ73Wz3GIlU6D3T4FNQnl5oXK/tgqQExyXBr0w
         m6Do+pnoWLYaOPd+dhruikgxz2HXFf/QQLLY4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682093752; x=1684685752;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9QZZtA/5NWdnQgb0jJuRZbKZ4eCkzSLiidtnIgHAhGA=;
        b=XZzeU+TEe/7/qsYTlAZ2tBdaqlD5GL3WIkqi55MXri5/P3355KP12EE3el28pHt7np
         lvMQSYAX74kd45VVNjoHyRLK0URUBPN2SoeUGUaZ67MGlF7RdPaxZ9DVz8pSw5g1dufR
         CKoACqVYKGy67QQ/ge8IHiyKDvvtiVuK/FkABfWwBzL+QGZyFHhIdDWmVWIxOPuLD0HN
         zGHkaeX87CqjfXVLdKPdB33yk1Bm/E3SthWTRgPjb6XRPbyPbxky/UzLB0UX2+ACiIR4
         hV4HuE5BLWMfv/EGXZKU4FczpCC0jc0rShGyV/XIx2ZmKnhOzl7M5iTrPXDXQS5ZHkW4
         RPqg==
X-Gm-Message-State: AAQBX9eR1KMRujRKLKTaTc/Ni0xWFA2lpjcfD7CMyXJh8t4EaedxGRhb
        uzT9YWICjyyu2zq6UI5Ky2CgNvVsbXIyQbC33cA=
X-Google-Smtp-Source: AKy350bA1N89qRtv9AGvkH4ueZyjps8/qJrNbmELBuF5bvafH0vMOvP/X1DglVTJIlugDMc4hUnuPw==
X-Received: by 2002:a05:622a:1102:b0:3ef:371b:3ca2 with SMTP id e2-20020a05622a110200b003ef371b3ca2mr9128655qty.11.1682093752205;
        Fri, 21 Apr 2023 09:15:52 -0700 (PDT)
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com. [209.85.160.178])
        by smtp.gmail.com with ESMTPSA id p13-20020a0cf54d000000b005ea34e69373sm1270526qvm.37.2023.04.21.09.15.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Apr 2023 09:15:51 -0700 (PDT)
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-3ef34c49cb9so1167751cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 09:15:50 -0700 (PDT)
X-Received: by 2002:a05:622a:1906:b0:3db:1c01:9d95 with SMTP id
 w6-20020a05622a190600b003db1c019d95mr440522qtc.4.1682093750390; Fri, 21 Apr
 2023 09:15:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230201-innolux-g070ace-v2-0-2371e251dd40@skidata.com> <20230201-innolux-g070ace-v2-1-2371e251dd40@skidata.com>
In-Reply-To: <20230201-innolux-g070ace-v2-1-2371e251dd40@skidata.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 21 Apr 2023 09:15:37 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XJCtqep+92h3gLfs4o2TwvL4MORjc9ydTSpZiZ0dsR0w@mail.gmail.com>
Message-ID: <CAD=FV=XJCtqep+92h3gLfs4o2TwvL4MORjc9ydTSpZiZ0dsR0w@mail.gmail.com>
Subject: Re: [PATCH RESEND v2 1/2] dt-bindings: display: simple: add support
 for InnoLux G070ACE-L01
To:     richard.leitner@linux.dev
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Richard Leitner <richard.leitner@skidata.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Mar 13, 2023 at 12:51=E2=80=AFAM <richard.leitner@linux.dev> wrote:
>
> From: Richard Leitner <richard.leitner@skidata.com>
>
> Add Innolux G070ACE-L01 7" WVGA (800x480) TFT LCD panel compatible
> string.
>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Richard Leitner <richard.leitner@skidata.com>

nit: as I understand it, ordering of tags is usually supposed to be
chronological. You signed off on this patch before Krzysztof acked it,
so the SoB should be above. I'll fix that when applying.

> ---
>  Documentation/devicetree/bindings/display/panel/panel-simple.yaml | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/display/panel/panel-simple=
.yaml b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
> index 18241f4051d2..fd3e5ad769dc 100644
> --- a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
> +++ b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
> @@ -174,6 +174,8 @@ properties:
>        - innolux,at043tn24
>          # Innolux AT070TN92 7.0" WQVGA TFT LCD panel
>        - innolux,at070tn92
> +        # Innolux G070ACE-L01 7" WVGA (800x480) TFT LCD panel
> +      - innolux,g070ace-l01

I think panel-simple currently has no active maintainers. Given that
I've touched all these files in the past, I don't mind applying.

Pushed to drm-misc-next:

4b4b96826ba9 dt-bindings: display: simple: add support for InnoLux G070ACE-=
L01
