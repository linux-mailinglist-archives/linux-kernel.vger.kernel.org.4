Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4613573B522
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 12:22:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231522AbjFWKWT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 06:22:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230196AbjFWKWR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 06:22:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCB88170C
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 03:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687515683;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OeJXYDNz0Ya5c8KMAm3ynsmsenQLqIdnXaadOKfnelU=;
        b=TCZVIiQTobch5j6R8t/qtQutzJAwKXuw5Dr3EHKpKmDpO8lzI+QImO8IgKPIc7rqLjTy9g
        t5NJKxXbacADm3oBJqpsFTELsg8xbgYkvDtCLC0xrg9U0PYgqeqT86o43lWYf75vM6ItMd
        aKiRrDQjvlDZ7SFARKGW47oVg4Og6kk=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-227-ui8Udd4ROhSaNa3t9b59UQ-1; Fri, 23 Jun 2023 06:21:21 -0400
X-MC-Unique: ui8Udd4ROhSaNa3t9b59UQ-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-76248f3057bso9657085a.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 03:21:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687515681; x=1690107681;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OeJXYDNz0Ya5c8KMAm3ynsmsenQLqIdnXaadOKfnelU=;
        b=d/Uo3EdPl70K6zKU+12uNSsTA90fkiByJPEuAHQ8iWrJc/cdzXxZbq/tp6Vw+i8Fcu
         om1IBK70gyyS9uox2wvkXSrpilWz3DVPWZFnQy08Cd5bwRJ/o7UkMTxVTGtfzpXrICyL
         TVSmuxd4e8BvwCofjiSf5kg85c8Tj/7Ti3L0aq/fGNX0QnQcCzfHfy9L+Lz+TsXWFGYY
         IcSk6spwE/VafmRbCzcffRi4DEIuWg1N75yYykpsy3yIuhQbTa35l7oo8CW96UjU/12T
         a6CBS6hOwMt4PaB6DQS+m8SefwYT7CO8+pm1JM+t9smP8jto3ljs6nLNlHMuSwYqN45G
         40zQ==
X-Gm-Message-State: AC+VfDxaWLZD6B0+ZpRA/1dSacywpYie8I05QmSe3FfMiSWCM1LBiXau
        bJsHptVdkaruJTZN1VH2l2Hp4WCpjG4Ib1E352M902oXB5csCCf5K6CTAnwdee4HbT16lCcDXVe
        QNqTcRVIp6Sga8OLnsFwVRw+D
X-Received: by 2002:a05:6214:401a:b0:62d:eda3:4333 with SMTP id kd26-20020a056214401a00b0062deda34333mr24730668qvb.0.1687515681005;
        Fri, 23 Jun 2023 03:21:21 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6GxEMCHUc8rROPzQ+6vAoGuDCswIguG8uTkvkLs5Wjm+76AjXJxAgdJPe/v4Nwk/b4qpXo1w==
X-Received: by 2002:a05:6214:401a:b0:62d:eda3:4333 with SMTP id kd26-20020a056214401a00b0062deda34333mr24730644qvb.0.1687515680708;
        Fri, 23 Jun 2023 03:21:20 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-231-243.dyn.eolo.it. [146.241.231.243])
        by smtp.gmail.com with ESMTPSA id v14-20020a0cdd8e000000b005dd8b9345b9sm4898755qvk.81.2023.06.23.03.21.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jun 2023 03:21:20 -0700 (PDT)
Message-ID: <c6f16229c7b84ff953120a12005c9397e572aa0d.camel@redhat.com>
Subject: Re: [PATCH net-next v3 01/18] net: Copy slab data for
 sendmsg(MSG_SPLICE_PAGES)
From:   Paolo Abeni <pabeni@redhat.com>
To:     David Howells <dhowells@redhat.com>
Cc:     Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
        Alexander Duyck <alexander.duyck@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        David Ahern <dsahern@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Menglong Dong <imagedong@tencent.com>
Date:   Fri, 23 Jun 2023 12:21:16 +0200
In-Reply-To: <2048548.1687514811@warthog.procyon.org.uk>
References: <ccf93f92b2539c9dddd1c45fcfa037bb21ccd808.camel@redhat.com>
         <20230622191134.54d5cb0b@kernel.org> <20230622132835.3c4e38ea@kernel.org>
         <20230622111234.23aadd87@kernel.org>
         <20230620145338.1300897-1-dhowells@redhat.com>
         <20230620145338.1300897-2-dhowells@redhat.com>
         <1952674.1687462843@warthog.procyon.org.uk>
         <1958077.1687474471@warthog.procyon.org.uk>
         <1969749.1687511298@warthog.procyon.org.uk>
         <2048548.1687514811@warthog.procyon.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2023-06-23 at 11:06 +0100, David Howells wrote:
> Paolo Abeni <pabeni@redhat.com> wrote:
>=20
> > I'm unsure I follow the above ?!? I *thought* sendpage could be killed
> > even without patch 1/18 and 2/18, leaving some patches in this series
> > unmodified, and mangling those explicitly leveraging 1/18 to use
> > multiple sendmsg()s with different flags?
>=20
> That's what I meant.
>=20
> With the example, I was showing the minimum needed replacement for a call=
 to
> sendpage.

Thank LGTM!

Thanks,

Paolo

