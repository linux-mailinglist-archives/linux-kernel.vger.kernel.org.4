Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8F56712A1F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 18:00:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243777AbjEZQAS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 12:00:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236220AbjEZQAQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 12:00:16 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54E5A18D
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 09:00:15 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3f5dbd8f677so60985e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 09:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685116814; x=1687708814;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xkU55uqzq+ekvAZs1dNWqR5r1+9lSZcOTbRvaL+8zq8=;
        b=hBlcOZEbxJxr/uZ7ExB4Ijf6sDeFpdS+91daVKdRfd4tC2i6rfOq8hNIdhnbPMQjd/
         0hbo/3YPl4iZfgszqgewLAHSpVuHtNQOMV0qZHNRaH/ySrwBpfTjWRnOFkSPgY9Bnt/0
         7gZmY2g1tPX3jDxOONBzcJxlrMxrfJxDD/r0olxEQ6x1slRCycZebagXpIEQHkua9st1
         Izu0v0sRzIiWzO8tNHLWUVfajkF0eNXG/lpzXVvrDoEgicZC+/6AjK8/13Ad3TGw9MKA
         laWYCnOo+fBsQdcYzeKjPZgt+i4kwkS1oS3SiuMPfXqA8pwJAfB7fxVPwRk6lLrhjGIH
         ZpCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685116814; x=1687708814;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xkU55uqzq+ekvAZs1dNWqR5r1+9lSZcOTbRvaL+8zq8=;
        b=lYdVEZ7yT79JkmbHXYhMM4afyW3LLJMC0gnk+5zXHaM0HbJjc24aXNy8maGYpccx1V
         QKagdrA77wUR7CsjXVuIsrj9F7m70I3asH/WygDNTVeOvHL+pY7YZ8LFf+xGZp848NlN
         pJCWS5VFEu11Vh8LfIfOrWcQzXsWjM9c9ki0Pp06sytrnZ1MbnlhABQLuQA63so1UATS
         T1dwiQd1hYTZAdIaZGzYYPsL+F0grneeADu/JIEomjyQrTj0VUW54EJ52TEHZlpHweN2
         HFcRiL819vuUn9BTMZYowN3HZFJitiZlWNPY8xC6Cq2S69jgwAu/hzb/HBljotSAbmXT
         70Wg==
X-Gm-Message-State: AC+VfDwZag01mLrfYo5c6a5JyTBiT3SVUOZEVj7KCfHyeJYafElbtQR6
        pWP+woG0u/kXqJa/GbUeldgft7qMhWI2RLHWPeXsiQ==
X-Google-Smtp-Source: ACHHUZ6XtQA8ACi3DtsPxc19flWObiDAt96Wd0LOg+dJc6I+OFPcxRFZEks8pe8qaFLfXVuDuxzzc3sw/eebnQLlKx8=
X-Received: by 2002:a05:600c:4f4a:b0:3f4:2736:b5eb with SMTP id
 m10-20020a05600c4f4a00b003f42736b5ebmr103572wmq.1.1685116813579; Fri, 26 May
 2023 09:00:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230526150806.1457828-1-VEfanov@ispras.ru> <27614af23cd7ae4433b909194062c553a6ae16ac.camel@redhat.com>
 <027d28a0-b31b-ab42-9eb6-2826c04c9364@ispras.ru>
In-Reply-To: <027d28a0-b31b-ab42-9eb6-2826c04c9364@ispras.ru>
From:   Eric Dumazet <edumazet@google.com>
Date:   Fri, 26 May 2023 18:00:01 +0200
Message-ID: <CANn89iLGOVwW-KHBuJ94E+QoVARWw5EBKyfh0mPkOT+5ws31Fw@mail.gmail.com>
Subject: Re: [PATCH] udp6: Fix race condition in udp6_sendmsg & connect
To:     =?UTF-8?B?0JXRhNCw0L3QvtCyINCS0LvQsNC00LjRgdC70LDQsiDQkNC70LXQutGB0LDQvdC00YDQvtCy0Lg=?=
         =?UTF-8?B?0Yc=?= <vefanov@ispras.ru>
Cc:     Paolo Abeni <pabeni@redhat.com>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        David Ahern <dsahern@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
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

On Fri, May 26, 2023 at 5:58=E2=80=AFPM =D0=95=D1=84=D0=B0=D0=BD=D0=BE=D0=
=B2 =D0=92=D0=BB=D0=B0=D0=B4=D0=B8=D1=81=D0=BB=D0=B0=D0=B2 =D0=90=D0=BB=D0=
=B5=D0=BA=D1=81=D0=B0=D0=BD=D0=B4=D1=80=D0=BE=D0=B2=D0=B8=D1=87
<vefanov@ispras.ru> wrote:
>
> Paolo,
>
>
> I don't think that we can just move sk_dst_set() call.
>
> I think we can destroy dst of sendmsg task in this case.
>

dst are RCU protected, it should be easy to make sure we respect all the ru=
les.
