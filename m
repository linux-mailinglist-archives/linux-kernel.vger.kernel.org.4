Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B1036D9CF8
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 18:04:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239823AbjDFQEV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 12:04:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbjDFQET (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 12:04:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C31929773
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 09:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680797020;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nhE+sw2nPXqC1UJ8AXPzZyQsVdsNsrouSAWZ5kkzANM=;
        b=dWws3ReVzaf1vuJLdCY8Y8YDsdV6j5W90zazengWjjtfrxrMsym80MBtH/+3Gaq/Ynd04F
        +7AbQkm0N4aWGnWEi/5dDl52SqVBbOEw5PUasPAksp333kCd10hmkh/4koO1bXIVQOfISM
        3BuIZZZFv8SD+YCzzkLeCaQHfFT+GrU=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-240-wWM0zfQGPaqtdJojOinElg-1; Thu, 06 Apr 2023 12:03:39 -0400
X-MC-Unique: wWM0zfQGPaqtdJojOinElg-1
Received: by mail-ej1-f71.google.com with SMTP id hy11-20020a1709068a6b00b0093994122eddso436944ejc.17
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 09:03:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680797018;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nhE+sw2nPXqC1UJ8AXPzZyQsVdsNsrouSAWZ5kkzANM=;
        b=4ypp6541i/zo4uNJhUrtTwF0H5L/eUrG9YlY0e8TnNJIXCDcZTE+Z3aCBq80najmyJ
         pMe6yumI7+nA9/NykmKA21NTfPb25drQJDh13rcysxvlReqOp2cuwZQjrfrvagubzK6K
         mv/BM50l9LuLDqt9RC6MF8TX9rb/X3vNoPEXGcS3ussEn0ov5Up8LTxp6S0LAY/0Z8YC
         RdIvEWqxoQW29JAxM0neaLfso8Q5gRmDUkDfX+gCJwBnhtBJI/dAAUMNipSvRpGEkf2e
         q5++pad2cAxKWzalos4anymJogWwDRY1ODwj+tDYZ8s2ELf71A/Ungd/j6veJAzBzkMw
         OzXQ==
X-Gm-Message-State: AAQBX9cPbKvT6Ae+1J2tpMIFgr5kLq3fIWyZb2gYsYKfP+i8MahIFlld
        jE706KbkSBLAQy9bMD/hVDQg++JjurXTkkLj7EuB1YOougJpPEghIcs+g1uWzy9dzTSulZlsJ4/
        hBhw96Vqao82XPPvJ01B53lamyGXEOUm85IHnA2fC
X-Received: by 2002:a17:907:7f0b:b0:8b1:7569:b526 with SMTP id qf11-20020a1709077f0b00b008b17569b526mr3699965ejc.11.1680797017899;
        Thu, 06 Apr 2023 09:03:37 -0700 (PDT)
X-Google-Smtp-Source: AKy350bj25JTqlPH4xO7mSRLb2uiNpfWZQ6CHwGpry0pz+NotDKptf776qNa/IjvZu9utWI9ekaWvAw2s40+5EjYFv8=
X-Received: by 2002:a17:907:7f0b:b0:8b1:7569:b526 with SMTP id
 qf11-20020a1709077f0b00b008b17569b526mr3699956ejc.11.1680797017538; Thu, 06
 Apr 2023 09:03:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230404084701.2791683-1-ryasuoka@redhat.com> <e51e9fb1-ad5c-5cf8-fa04-4e3a10023739@sandeen.net>
In-Reply-To: <e51e9fb1-ad5c-5cf8-fa04-4e3a10023739@sandeen.net>
From:   Ryosuke Yasuoka <ryasuoka@redhat.com>
Date:   Fri, 7 Apr 2023 01:03:26 +0900
Message-ID: <CAHpthZrcegPXhti5tDdb=_nwafWnU-FXmtc6aRU7juowMpOnUQ@mail.gmail.com>
Subject: Re: [PATCH] xfs: Use for_each_perag() to iterate all available AGs
To:     Eric Sandeen <sandeen@sandeen.net>
Cc:     djwong@kernel.org, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Eric,

I failed to reply to you since I got some mistakes.
Let me re-send my reply just in case.

Thank you for reviewing my requests.

> Can you explain what goes wrong if it is zero? Is there a test for this?
>
> If it's a general problem, what if the other 2 callers pass in the variable
> start_agno with a value of 0?

Sorry I couldn't prepare any tests to confirm what happens if it is zero
because it is a kind of general problem.

IIUC, passing zero to for_each_perag_wrap() is not problematic.

As the comment describes, this macro iterates all AG from start_agno through
wrap_agno, then wrap to restart_agno, and then iterates again toward to
start_agno - 1. It looks like some issue occurs when start_agno is zero.
However, for_each_perag_wrap() actually won't wrap if start_agno is zero.

static inline struct xfs_perag *
xfs_perag_next_wrap(
struct xfs_perag *pag,
xfs_agnumber_t *agno,
xfs_agnumber_t stop_agno,
xfs_agnumber_t restart_agno,
xfs_agnumber_t wrap_agno)
{
struct xfs_mount *mp = pag->pag_mount;

*agno = pag->pag_agno + 1;
xfs_perag_rele(pag);
while (*agno != stop_agno) {
if (*agno >= wrap_agno) {
if (restart_agno >= stop_agno) <<<--- HERE
break;
*agno = restart_agno;
}

pag = xfs_perag_grab(mp, *agno);
if (pag)
return pag;
(*agno)++;
}
return NULL;
}

/*
* Iterate all AGs from start_agno through wrap_agno, then restart_agno through
* (start_agno - 1).
*/
#define for_each_perag_wrap_range(mp, start_agno, restart_agno,
wrap_agno, agno, pag) \
for ((agno) = (start_agno), (pag) = xfs_perag_grab((mp), (agno)); \
(pag) != NULL; \
(pag) = xfs_perag_next_wrap((pag), &(agno), (start_agno), \
(restart_agno), (wrap_agno)))
...
#define for_each_perag_wrap_at(mp, start_agno, wrap_agno, agno, pag) \
for_each_perag_wrap_range((mp), (start_agno), 0, (wrap_agno), (agno), (pag))
...
#define for_each_perag_wrap(mp, start_agno, agno, pag) \
for_each_perag_wrap_at((mp), (start_agno), (mp)->m_sb.sb_agcount, \
(agno), (pag))

OTOH, since we have already a for_each_perag() macro, which just iterates all AG
from 0 and doesn't wrap, I think it is simpler to use for_earch_perag().

Regards,
Ryosuke

