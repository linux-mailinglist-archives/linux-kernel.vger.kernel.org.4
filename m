Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FFA174005E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 18:08:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232272AbjF0QIr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 12:08:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232137AbjF0QIh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 12:08:37 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3223930FF;
        Tue, 27 Jun 2023 09:08:34 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-98df69cacd1so303552666b.1;
        Tue, 27 Jun 2023 09:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687882111; x=1690474111;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tpd3lAFkgPOZAmtsEdYx4agOG1zhm3c7wmN24nFCRP8=;
        b=q06GNPWOebOMOVK5HxSGaEx7LPlAXSxIc/Aq8MQqa1KOppEIqGqtMhwG4NpjZkOm9S
         AFyR5QRFV5Y4HWjtBCFBNLrJk5S4Lc7K8YZNHrIZdxMmDQA/+lLQ3p8y9UgKzJsIf86A
         6mgRi6asDKOmW/iWnEEaxh6aCjW2wpoxwylPIFbl3o9t7f68PKixGMqc9eY+4A0mQYyK
         /NKPB7mafWWAJMN3H/YcHBf8569Pxbdxn2kFSPB9d/Zx+IZTpfRyXx13QuiKS/N9+aK/
         qXilL+LWm4uaO9ESacaaI9YCZeZXSWrdMC3YtgW+4T2fSzrERUBgn1BaSIhHBSbx3TEd
         2oEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687882111; x=1690474111;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tpd3lAFkgPOZAmtsEdYx4agOG1zhm3c7wmN24nFCRP8=;
        b=Tf7oe1AACsmCnbfhu/0NRKfe6T+07LH+TWtI1Hb1ZRkMsgt+MAFDH5ONX6kWM5fY+f
         QwurXlBnM9tPohvOiiaXrKdvERvCb8vDjE2y2H5sHN/ng2qcAi98AcIOmGMuIxjGxj89
         iLKZLFVRR0khDgi22tdH/G3E7kv3f9Zp/nSPHRAhaZKXh7lXNqPlT6Si14noQfTyA5NC
         Kzm1OwE1WUdHSYqjVv9qCiFp92YIMo1zqcf7mVQa6Y49505FDISnBlq7cYVlsNIgHn3A
         aoet7zhHTYBF+r3W+Zh7Cb9QhI9BNdAcTi5ifaG5a2CqVROkQdMRU3cs7vheCZJ7usEG
         6hbQ==
X-Gm-Message-State: AC+VfDxcAb1/TNIsDbRQ6eLPf/7KGaWqQEce6bu+tutM3BcK0zYiqevB
        tjnYIR/nYocPLLpLTVOkUIi950noMnh5UfQJt1bJ7DX8Zd9ySQ==
X-Google-Smtp-Source: ACHHUZ5eFupuDSzxk+XYCDYxcusnVKqMDv7K7KW/OxsPLBOsMdd40uQa4uFTdLNO9TafVR9bMvBKw7UkvrKS5CDSshk=
X-Received: by 2002:a17:907:803:b0:982:cfe2:32fe with SMTP id
 wv3-20020a170907080300b00982cfe232femr28075108ejb.63.1687882111373; Tue, 27
 Jun 2023 09:08:31 -0700 (PDT)
MIME-Version: 1.0
References: <3199652.1687873788@warthog.procyon.org.uk> <20230627085928.6569353e@kernel.org>
In-Reply-To: <20230627085928.6569353e@kernel.org>
From:   Ilya Dryomov <idryomov@gmail.com>
Date:   Tue, 27 Jun 2023 18:08:19 +0200
Message-ID: <CAOi1vP-ogmcKE3brjEsm+zLvcXJa_5tGjv_XMsrnZuZUhXonhQ@mail.gmail.com>
Subject: Re: [PATCH net-next v3] libceph: Partially revert changes to support MSG_SPLICE_PAGES
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     David Howells <dhowells@redhat.com>, netdev@vger.kernel.org,
        Xiubo Li <xiubli@redhat.com>, Jeff Layton <jlayton@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Matthew Wilcox <willy@infradead.org>,
        ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 27, 2023 at 5:59=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Tue, 27 Jun 2023 14:49:48 +0100 David Howells wrote:
> > Fix the mishandling of MSG_DONTWAIT and also reinstates the per-page
> > checking of the source pages (which might have come from a DIO write by
> > userspace) by partially reverting the changes to support MSG_SPLICE_PAG=
ES
> > and doing things a little differently.  In messenger_v1:
> >
> >  (1) The ceph_tcp_sendpage() is resurrected and the callers reverted to=
 use
> >      that.
> >
> >  (2) The callers now pass MSG_MORE unconditionally.  Previously, they w=
ere
> >      passing in MSG_MORE|MSG_SENDPAGE_NOTLAST and then degrading that t=
o
> >      just MSG_MORE on the last call to ->sendpage().
> >
> >  (3) Make ceph_tcp_sendpage() a wrapper around sendmsg() rather than
> >      sendpage(), setting MSG_SPLICE_PAGES if sendpage_ok() returns true=
 on
> >      the page.
> >
> > In messenger_v2:
> >
> >  (4) Bring back do_try_sendpage() and make the callers use that.
> >
> >  (5) Make do_try_sendpage() use sendmsg() for both cases and set
> >      MSG_SPLICE_PAGES if sendpage_ok() is set.
> >
> > Fixes: 40a8c17aa770 ("ceph: Use sendmsg(MSG_SPLICE_PAGES) rather than s=
endpage")
> > Fixes: fa094ccae1e7 ("ceph: Use sendmsg(MSG_SPLICE_PAGES) rather than s=
endpage()")
> > Reported-by: Ilya Dryomov <idryomov@gmail.com>
>
> Ilya, would you be okay if we sent the 6.5 PR without this and then
> we can either follow up with a PR in a few days or you can take this
> via your tree?
>
> Or you could review it now, that'd also work :)
>
> In hindsight we should have pushed harder to make the FS changes as
> small as possible for sendpage removal, so that they can go in via
> the appropriate tree with an appropriate level of scrutiny for 6.6,
> lesson learned :(

Hi Jakub,

This patch looks good to me.  I have been meaning to actually test
it, but, if time is of the essence, I'm OK with it being merged via
the networking tree now.

Reviewed-by: Ilya Dryomov <idryomov@gmail.com>

Thanks,

                Ilya
