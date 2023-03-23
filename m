Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41ED06C6D55
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 17:24:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231926AbjCWQYn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 12:24:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230435AbjCWQYl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 12:24:41 -0400
Received: from mail-ua1-x92d.google.com (mail-ua1-x92d.google.com [IPv6:2607:f8b0:4864:20::92d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF60F1FE7
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 09:24:40 -0700 (PDT)
Received: by mail-ua1-x92d.google.com with SMTP id r7so15388202uaj.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 09:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679588680;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wE7wxRuLK08uzH1OcaWrx6WAEK1JsYpETenvKCrBuDY=;
        b=dytsPW6O6Ddrj6PQWy2KkcUkauZpXxyOIlxEk3OZkBuwER8pipyV4s45Kp3CGEAXLq
         RJE3EJbltfHpQCWmyv8DrxgBS1c7j5z4yvw4cO/wo3cVfbHgdIGJinImIU45zlEMQCnz
         5mR3mpdCbDxugrxmB2n+S9NNXHaezpq1njC2IhG+RXZUQGduGpFgmVlP7wqM0rdu8BWB
         OKjNtAwz5WXHfMgKLgUum++BToklgHD6jcb39SeWmOV5w5mcy1et3NUPGbqKrx6/4e9w
         99YsMvE2KPzD24W/r8pni5RgSKULyAdpJQ1i2VMCZXrZmopNUMp+J8Gm6VY7xZAntsd8
         Dt5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679588680;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wE7wxRuLK08uzH1OcaWrx6WAEK1JsYpETenvKCrBuDY=;
        b=2OSTK7BA2Z4RU0krgz5iFKJ1EvnZbr3ZrRhWcwwHp3RIOZTzhPlNoJfby5MMVwrN/E
         JgRgLdjkv1XCUpAAWZhSts0q8JKJckGyF5TQHZA/mNdghv/yN+6/niQNgAEotZlSQd5G
         Pyd1rHgTOGv4sBzb/neZwWs9c6fqWbxzA5JXRdoPhrFXkOT3cPSq38slAM6VYOpfRYUA
         kUCqgYSj5BEmwBacwnwfchCYYNdALMzIzbTUqzrfnVuIZrpSeyHlXqh9lfw+8YtjjQik
         ReRyTM1fWCsXFemaIWW5LIBN1WlbhcExs+Fu6NHCIDoR88Hya6dy28sdU2s4NqN/kHxt
         ML6A==
X-Gm-Message-State: AAQBX9eXdKSX5w4MhDCw5oBnOpbVjwkC+zquatTxc5U8+DatQzon0Rt8
        uKq2UVlSvZ1bIqGD/XfOxPD4IaCd4y+MMQzNjTmuxw==
X-Google-Smtp-Source: AKy350Z8YUE+obVnmjQnaYwHv5YkjlneimQhoHxq0khWsZTwqllQpf1C39UQJ3j4/SzZnhQWrziTeM3yQEJNs22itOc=
X-Received: by 2002:ab0:6c44:0:b0:68a:6c1e:1aab with SMTP id
 q4-20020ab06c44000000b0068a6c1e1aabmr7290926uas.2.1679588679806; Thu, 23 Mar
 2023 09:24:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230322233823.1806736-1-vladimir.oltean@nxp.com>
In-Reply-To: <20230322233823.1806736-1-vladimir.oltean@nxp.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Thu, 23 Mar 2023 09:24:28 -0700
Message-ID: <CANn89iKOrYUjY=aNkFFoDnq_XTQMGOajACMyd9+_gp8NNgz=-g@mail.gmail.com>
Subject: Re: [PATCH net-next 0/9] Remove skb_mac_header() dependency in DSA
 xmit path
To:     Vladimir Oltean <vladimir.oltean@nxp.com>
Cc:     netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 22, 2023 at 4:38=E2=80=AFPM Vladimir Oltean <vladimir.oltean@nx=
p.com> wrote:
>
> Eric started working on removing skb_mac_header() assumptions from the
> networking xmit path, and I offered to help for DSA:
> https://lore.kernel.org/netdev/20230321164519.1286357-1-edumazet@google.c=
om/
>
> The majority of this patch set is a straightforward replacement of
> skb_mac_header() with skb->data (hidden either behind skb_eth_hdr(), or
> behind skb_vlan_eth_hdr()). The only patch which is more "interesting"
> is 9/9.
>

SGTM, thanks a lot !

For the whole series :

Reviewed-by: Eric Dumazet <edumazet@google.com>
