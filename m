Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D50C71A35A
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 17:56:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233215AbjFAPzT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 11:55:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233747AbjFAPzP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 11:55:15 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B29C13D
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 08:55:14 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id e9e14a558f8ab-33bf12b5fb5so130255ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 08:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685634913; x=1688226913;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bcFHd8KydoGNMakaE+r7qYK2+GReJfjjugBl3aXp89w=;
        b=SL4pYfDecbcOQkLFjRrzaszytlRsjWKv7TXKTPpEmnZ9TgXq7iMK+eafFvYnAdwqyf
         khkp8jY4HdOj858ecpc//lBwBZQ9HaDdJDXhMGcv3+TX+3Pb6JgkQjZ3inwHO7oc4Jwg
         AuWqT/OtAdR2BnrbPMjpEVG2O99/JKUdiCG9MIUGtw/Sa+gGMeIY9QX5pOZQ4+qKKGJE
         /A0xipy6hgP60ktzPzZC2X6LVAFHEhVPZlFSMYOvtg4GHPxZFNCBSk/rkGu9smkfEVUX
         HfDzMvEKffXF7ZdX/cjhRyfz4m++ppbKQAKiHMYcAjEsA9goCz5oPxHRi4K0a45a6ogR
         8Z2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685634913; x=1688226913;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bcFHd8KydoGNMakaE+r7qYK2+GReJfjjugBl3aXp89w=;
        b=Wbh9e3Ip/iMP0HW6UzDkULp3yB6ObfjJsBE8WmqmWaFG4nrr38NMZK+PaWtbBc49U+
         mfP8a6v8j4RZTznSmy22MdMqNAqOyPSUj/YXl2l1B9Q27SsjIPa+7xjxcAvrn0KzFoC5
         1Wt03WlS9xrHZZZntFK3CeLjAdjj9T6wcu160SpgV6FS27WHuVsfmRItjtFQKXCM1x6U
         1TlmnShevg9TqzkaO4lmdvgVzYmGUZmvpFqh0HdNXkieCtNQGm473zxCucqRc8UNYw3Y
         aNZ734AQMyMEevHBli/rmCNARS2h46WDLzqmR3lrJrbYLQePbiF8XwEF+CgR2PUL/oem
         vU/A==
X-Gm-Message-State: AC+VfDx/x4jGoNfB4+Py3Zo/3y+czb7jZRYQcLO4th1V7mMasURcezDR
        ZOew1gyNSSTcWZP14aPtd6x/NP3OcS2SLzXhCBfKvg==
X-Google-Smtp-Source: ACHHUZ5tNrISHWhGI3VKmvsVJdzk5rApIA+ScRjMOFK6/ERy49AFcEHGdmb5Lbwbk7kHe7mdIy4KMUAybF/WWAmQhng=
X-Received: by 2002:a05:6e02:b2c:b0:32a:642d:2a13 with SMTP id
 e12-20020a056e020b2c00b0032a642d2a13mr248297ilu.6.1685634913599; Thu, 01 Jun
 2023 08:55:13 -0700 (PDT)
MIME-Version: 1.0
References: <1adda828-cf35-fb2c-6db5-f9ca91b5b62a@linaro.org>
 <20230525093151.2338370-1-yangcong5@huaqin.corp-partner.google.com> <20230525093151.2338370-2-yangcong5@huaqin.corp-partner.google.com>
In-Reply-To: <20230525093151.2338370-2-yangcong5@huaqin.corp-partner.google.com>
From:   Doug Anderson <dianders@google.com>
Date:   Thu, 1 Jun 2023 08:55:02 -0700
Message-ID: <CAD=FV=UduUjeG0ZPFm6QMpRE0+wJpbwTue9xprSTd2fPK2oyZA@mail.gmail.com>
Subject: Re: [v4 1/4] dt-bindings: display: panel: Add compatible for Starry himax83102-j02
To:     Cong Yang <yangcong5@huaqin.corp-partner.google.com>
Cc:     daniel@ffwll.ch, neil.armstrong@linaro.org, sam@ravnborg.org,
        airlied@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, hsinyi@google.com,
        conor+dt@kernel.org, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Conor Dooley <conor.dooley@microchip.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, May 25, 2023 at 2:32=E2=80=AFAM Cong Yang
<yangcong5@huaqin.corp-partner.google.com> wrote:
>
> The STARRY himax83102-j02 is a 10.51" WUXGA TFT LCD panel,
> which fits in nicely with the existing panel-boe-tv101wum-nl6
> driver. Hence, we add a new compatible with panel specific config.
>
> Signed-off-by: Cong Yang <yangcong5@huaqin.corp-partner.google.com>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> ---
>  .../devicetree/bindings/display/panel/boe,tv101wum-nl6.yaml     | 2 ++
>  1 file changed, 2 insertions(+)

Applied to drm-misc-next:

06c3269cd574 dt-bindings: display: panel: Add compatible for Starry
himax83102-j02
