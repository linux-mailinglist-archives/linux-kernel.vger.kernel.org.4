Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 187FF6D9869
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 15:38:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238659AbjDFNit (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 09:38:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238640AbjDFNio (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 09:38:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB3296592
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 06:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680788262;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ug0yLlYuZVuJbOjWeIVJpNIZdkAxhZuiOq+dou/hw8A=;
        b=YxC6Pomk15o6C6K2htFr1y2WW94xIi+oedFlTbMyUUdKBNYK/m26SrYCftkblAgp2Y7b63
        BW80qS0+gvoR0/qBYrCWfcKBLO8vqLnEfUev9WU9D7Of/OhX3v+PcdVvMMfXcwjRZGXMlo
        N1xkDhtvsy4lxqBKKl2hyx5s1Up1TE4=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-454-cy_2ZCD8P6qWZYiObcNXrw-1; Thu, 06 Apr 2023 09:37:40 -0400
X-MC-Unique: cy_2ZCD8P6qWZYiObcNXrw-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-74678af9349so122359085a.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 06:37:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680788260;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ug0yLlYuZVuJbOjWeIVJpNIZdkAxhZuiOq+dou/hw8A=;
        b=2T2UwGJZksAuGhfDbBcL0Vp91psN3R/X9UndxBBP4tDGUHHYYSoucB0h9RedeyKwG8
         hvjurwppoVMykiDlFH4XrFP/BArEUxgVz7lQnBtYxLf8PMOwAMH60puMhEthsaqN+xyx
         haXDYGSMSUFCOEDOoLGpFgNunoFDJf9EpbKttnPUlnxv4Fqyhz2msrYiOagtUXEOEJOA
         RENchqBfnUvJKNhiHaofraUtTEA61tkc8cEjNQM3OxevAvoenaDApcLvmNy3/13Eqn7f
         +XWjLvJ2A3N376Pwz+ADBqs3MNJDKG1C2VPJu4TMED6SCWCFWIYatjs/n8b2pRJzvjpk
         /bZQ==
X-Gm-Message-State: AAQBX9esc0N4yq1JkH9X4zNKNvjCWpfc3c++RYysKMjd2crNfJvXNsH9
        yOzKCoXRar4MvIm7jXF4XobTX8mpOm0sAjFehEkQjJ8GgJ+xEo1gOzy0YjIACpYmNAMoMxpz3h6
        zo2+U0gCv0u2JCiDSQA25wUoMG1dtAKVZRaA=
X-Received: by 2002:a05:622a:1a24:b0:3e6:707e:d3c2 with SMTP id f36-20020a05622a1a2400b003e6707ed3c2mr12279750qtb.0.1680788260025;
        Thu, 06 Apr 2023 06:37:40 -0700 (PDT)
X-Google-Smtp-Source: AKy350bl0coyuBidkvHOT2/BIT7X0OyQAMODwQcShZMFhboQW68IVl2ZVchaTloj3/oC6ckiUmHLyA==
X-Received: by 2002:a05:622a:1a24:b0:3e6:707e:d3c2 with SMTP id f36-20020a05622a1a2400b003e6707ed3c2mr12279705qtb.0.1680788259720;
        Thu, 06 Apr 2023 06:37:39 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-227-151.dyn.eolo.it. [146.241.227.151])
        by smtp.gmail.com with ESMTPSA id 10-20020a370a0a000000b007422fa6376bsm470773qkk.77.2023.04.06.06.37.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 06:37:39 -0700 (PDT)
Message-ID: <454a61709e442f717fbde4b0ebb8b4c3fdfb515e.camel@redhat.com>
Subject: Re: [PATCH net-next 2/3] ksz884x: remove unused #defines
From:   Paolo Abeni <pabeni@redhat.com>
To:     Simon Horman <horms@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Date:   Thu, 06 Apr 2023 15:37:36 +0200
In-Reply-To: <20230405-ksz884x-unused-code-v1-2-a3349811d5ef@kernel.org>
References: <20230405-ksz884x-unused-code-v1-0-a3349811d5ef@kernel.org>
         <20230405-ksz884x-unused-code-v1-2-a3349811d5ef@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2023-04-05 at 10:39 +0200, Simon Horman wrote:
> Remove unused #defines from ksz884x driver.
>=20
> These #defines may have some value in documenting the hardware.
> But that information may be accessed via scm history.

I personally have a slight preference for keeping these definitions in
the sources (for doc purposes), but it's not a big deal.=20

Any 3rd opinion more then welcome!

Paolo

