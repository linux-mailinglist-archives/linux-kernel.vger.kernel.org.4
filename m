Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23A51712C47
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 20:14:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236964AbjEZSO1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 14:14:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbjEZSOW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 14:14:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4572612A
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 11:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685124810;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7YqrTfPHvU/4ASCCEEgua/Tzk3hxyao1PjTjuEQJVK4=;
        b=eTNdKaa+R/IgdM+BH8efgCo1B4ANjOKEv8a0pfBWW0hSNfQk4LUOYf2VN0FsPL9sJpY6Bi
        p7Nx5SudnwvYV8iCWf0ot4sjHgrVubZGajuNcZ0YeIYCjUb53rKjPSS9XM8nYfLS+rxjjP
        Sj1bqaL2l/JtyQl7hF6V8CHROjuAD94=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-344-hJ6e-NAVO82CY52f_ubwmA-1; Fri, 26 May 2023 14:13:28 -0400
X-MC-Unique: hJ6e-NAVO82CY52f_ubwmA-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-3f4fffe7883so992705e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 11:13:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685124807; x=1687716807;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7YqrTfPHvU/4ASCCEEgua/Tzk3hxyao1PjTjuEQJVK4=;
        b=iX52Pk7FxqZiHkcQOoBKmv0xH/fFesmLhKqkBIgGXAPH5YLahOnllZO/WXCQyiBLtO
         ajkFWJzxZy7qBtHyQFTHJn64Yc1KvGjrMFiHAMbGN2sLKbgM0Y7NFzmsnRc2bu7kWy8n
         2FUsCz3t7vIAh3MbKXt8FAV50boD4ziWNUWxVrXq+KC32klfUxoiQ+Tb8KR0hPF+luFC
         aktaWCLT6Q4Gg9267CF3vTdPNzPWuJG2dFIJb7NaYXUxzCESaJYJR7Wa+mZJizefhn54
         mcb6sNEuCfO9vDabc5OXTJCHrbECorcxC+o7deqRNp9ZjvV9BPoQtxSanbp++7tAdzpJ
         fecQ==
X-Gm-Message-State: AC+VfDyH+hAzlZTg1n87Z9IOK+9rIVgHQzWYKLVxuFx3c6Y4n+7WrgqO
        hGvgM7qdmvZrntNlYqyH4bZ4iQqRsKtaClxWspN5BFIVRn/hwQAu4WQoWd2dr6zObtAxPJVHqAs
        OiFGemDOHydbSGKeZFNMB4mi9
X-Received: by 2002:a05:600c:5027:b0:3f6:5dc:59f6 with SMTP id n39-20020a05600c502700b003f605dc59f6mr2386437wmr.4.1685124807842;
        Fri, 26 May 2023 11:13:27 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4lxnZT2eYP/BCIcXpgusjrXGQt4s7zCyCTGNaTw52E+GCphviq7a6Xr4+C6qEQuNaQ3OcQmQ==
X-Received: by 2002:a05:600c:5027:b0:3f6:5dc:59f6 with SMTP id n39-20020a05600c502700b003f605dc59f6mr2386427wmr.4.1685124807565;
        Fri, 26 May 2023 11:13:27 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-241-255.dyn.eolo.it. [146.241.241.255])
        by smtp.gmail.com with ESMTPSA id n11-20020a05600c294b00b003f6129d2e30sm9559138wmd.1.2023.05.26.11.13.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 May 2023 11:13:27 -0700 (PDT)
Message-ID: <815ce4d97f6d673799ee7a94d90eeda58b1e51e4.camel@redhat.com>
Subject: Re: [PATCH] udp6: Fix race condition in udp6_sendmsg & connect
From:   Paolo Abeni <pabeni@redhat.com>
To:     =?UTF-8?Q?=D0=95=D1=84=D0=B0=D0=BD=D0=BE=D0=B2_?=
         =?UTF-8?Q?=D0=92=D0=BB=D0=B0=D0=B4=D0=B8=D1=81=D0=BB=D0=B0=D0=B2_?=
         =?UTF-8?Q?=D0=90=D0=BB=D0=B5=D0=BA=D1=81=D0=B0=D0=BD=D0=B4=D1=80=D0=BE?=
         =?UTF-8?Q?=D0=B2=D0=B8=D1=87?= <vefanov@ispras.ru>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        David Ahern <dsahern@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
Date:   Fri, 26 May 2023 20:13:25 +0200
In-Reply-To: <027d28a0-b31b-ab42-9eb6-2826c04c9364@ispras.ru>
References: <20230526150806.1457828-1-VEfanov@ispras.ru>
         <27614af23cd7ae4433b909194062c553a6ae16ac.camel@redhat.com>
         <027d28a0-b31b-ab42-9eb6-2826c04c9364@ispras.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2023-05-26 at 18:58 +0300, =D0=95=D1=84=D0=B0=D0=BD=D0=BE=D0=B2 =D0=
=92=D0=BB=D0=B0=D0=B4=D0=B8=D1=81=D0=BB=D0=B0=D0=B2 =D0=90=D0=BB=D0=B5=D0=
=BA=D1=81=D0=B0=D0=BD=D0=B4=D1=80=D0=BE=D0=B2=D0=B8=D1=87
wrote:
> I don't think that we can just move sk_dst_set() call.
>=20
> I think we can destroy dst of sendmsg task in this case.

AFAICS ip6_sk_dst_lookup_flow tries to acquire a reference to the
cached dst. If the connect() clears the cache, decreasing the refcnt,
the counter of the dst in use by sendmsg() must still be non zero.

IMHO the problem you see is that sk_setup_caps() keeps using the dst
after transferring the ownership to the dst cache, which is illegal.
The suggested patch addressed that.

If I'm wrong your syzkaller repro will keep splatting. Please have just
have a spin, thanks.

Paolo

