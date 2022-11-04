Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37AFD619490
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 11:38:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231776AbiKDKiF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 06:38:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230474AbiKDKiD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 06:38:03 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C0152B24D
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 03:38:02 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-367b8adf788so39823637b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 04 Nov 2022 03:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gcUeaG6JKzsxRdmnLqdsuH4lvt90A/Xm+f8OuGUNx2g=;
        b=lifVXrJ64+/dFQ55o6QJG9bfmyr5u1WHnkUjB/BEPp4bwyLC2jsd5Ot2P7Kq+afJQD
         Su0nuZxTHwBvDImCVCFEUtmaSnZKHxvLUHGDg58RQELH++HOTW8K0QWx36LjdYCFjf4F
         2UF7qvnOssOdri7mk5daZe3qHYZiwwMpGyBKrmebxK/Oz60Fqe70R1pq7upF2TlYexiH
         KB4vaNLdgkNBsy0kOhH8cJKMXvp5T+wKt9Np/jANdxkDAJzzyxO+J/PUiAeGgpYOi25z
         EpBKclOxzzWRyLeZk5Zf3z7F6Dg1Z/BHhgZie9HUPmLsHUlMH97pTYmYY502125s1qbP
         SP8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gcUeaG6JKzsxRdmnLqdsuH4lvt90A/Xm+f8OuGUNx2g=;
        b=vWD3n5kwa5pXMnBeMOJu2EmY4NRqbw8oeTOzFngStuDOs1oQLrt3wjISw000SE3WeI
         SJbbx4uuX+CrPAqVoaMunctWSAfYbpPP7RaR3tPrX98/B5Vq08H8OKSr8iIFITUd7+Wy
         33V2hTuMJsZ9MkHEd0toCK8ZUFRHAgfHnLtX8Cp1qj5a3kz8zZRC8gj1LbZfeGp02R0c
         c8OK8lon/oOwo2omUL8BhMDffJ1ipKO+NQY1pkltKqj+xp782lW/HF1OqD4SxJNlmUe4
         jBvSkQfEa8DSrCmPjoOY3pDMmFIVusswunlBrb5ldDk6+0Qd3MqXLCB9F12e1wTWzVf4
         ps+w==
X-Gm-Message-State: ACrzQf2L3Ajc7ykdVNXRV0KBySrva6bRprt7JKXub+Gs+YZ/IHavxOFC
        2NbZS9dNfcNeFTmG5OdoGYx+noWBkuIS/JX3EtgJEg==
X-Google-Smtp-Source: AMsMyM69d9R7kJhwGNFv2ZLuCly3ihyNUT3PUT+aXZiEBSBo7oOnRn4WUjfOdGHH6UBxOLmqozRcyr4tBPT67HdCpD0=
X-Received: by 2002:a81:4811:0:b0:368:e6a7:6b38 with SMTP id
 v17-20020a814811000000b00368e6a76b38mr33471525ywa.20.1667558281502; Fri, 04
 Nov 2022 03:38:01 -0700 (PDT)
MIME-Version: 1.0
References: <20221104103216.2576427-1-glider@google.com>
In-Reply-To: <20221104103216.2576427-1-glider@google.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Fri, 4 Nov 2022 11:37:25 +0100
Message-ID: <CAG_fn=WhGa21EVCPNFp6BO3=CMzHFYNfwpXK+S0m6oxPr9xdrg@mail.gmail.com>
Subject: Re: [PATCH] ipv6: addrlabel: fix infoleak when sending struct
 ifaddrlblmsg to network
To:     glider@google.com
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        davem@davemloft.net, yoshfuji@linux-ipv6.org, dsahern@kernel.org,
        syzbot+3553517af6020c4f2813f1003fe76ef3cbffe98d@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>
> This patch ensures that the reserved field is always initialized.
>
> Reported-by: syzbot+3553517af6020c4f2813f1003fe76ef3cbffe98d@syzkaller.appspotmail.com

My bad, should be:
  Reported-by: syzbot+fa5414772d5c445dac3c@syzkaller.appspotmail.com
