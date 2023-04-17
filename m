Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 681116E3DF3
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 05:25:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbjDQDZV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 23:25:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjDQDZQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 23:25:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 765E61FDB
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 20:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681701869;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zKGM0UuJktFVFn7nlGHkLlmdThLbMLf0gM6cQd9y1wc=;
        b=Mk6Q/6vnpo1NfdCcdIpMCQcu6bCQ7kymSBYZdSajBLShebzalUFZ+9O9Ew5AJqQpAc+/Ne
        C8skxbVxbVORfXb1uaHS+hRmVT26atEpqBR1sXpfuTmjA+8KQbfmF8UM7S8epbS3Rw5aWc
        BCI2n1zNOR3n7pEfwO4LcX9/6Vv6H34=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-294-wqCpdPr3MDydb8R1syel1w-1; Sun, 16 Apr 2023 23:24:28 -0400
X-MC-Unique: wqCpdPr3MDydb8R1syel1w-1
Received: by mail-ot1-f70.google.com with SMTP id d13-20020a9d51cd000000b006a5d7617b15so770501oth.10
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 20:24:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681701867; x=1684293867;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zKGM0UuJktFVFn7nlGHkLlmdThLbMLf0gM6cQd9y1wc=;
        b=kZF/Fbx4IbhxOAIlfpeP8tWGIVIwrVrnlZks708WobpCyRwvuMyXKC1bA+2ZeZKmat
         jKm2FpWtmVZBVzilGF8zqcJDiYP6V2vA+5w2xRTHVymyD5Cn5dlih1IyTeyrbqcu6WjH
         VbibOuu8DzD96jrFg/h+vq+y3FF8dO9Cmtid3YKKTKow/HRMffqVMBKZ+7oXvvoVGmQ8
         pcVfSAoWxT5yuPHrTi4MkdkINa9wSPsyqgKRI/bCXx/Gh0ePPxcSjRNHTONWW0mNWfGb
         a6MKwwc9IUvts2+12cjeuObWDdSJclMOdtBUqx64DglRvnf7wmVLtjPm7gKXRpIt1YxK
         AiCA==
X-Gm-Message-State: AAQBX9ettNc1jI8ohTkxIZ6bFPtWBQ/N3iOdXhXLXpRwCxvDt5eQ9FUH
        SkR7QetoShPreJCN8fqBpa5pDf0Ftsx/POfW7NtuR9XdDw78+O3JkJ/MSwEgcpLg5BMOOkrCIz3
        5Q6UBUpgv6tpd0ZZXJagdRfsGh+Duvr9dDRc01BpvgF6pd/16GVo=
X-Received: by 2002:a05:6870:3489:b0:187:7f2e:98d6 with SMTP id n9-20020a056870348900b001877f2e98d6mr5063277oah.9.1681701867756;
        Sun, 16 Apr 2023 20:24:27 -0700 (PDT)
X-Google-Smtp-Source: AKy350btdvSh+yfsA0KDTP5tl/3eCzJUDrZFp6vNFLcoded+JiAPxym7277acm9HPgpEBflChrr5DV/GvuTzFRR65KI=
X-Received: by 2002:a05:6870:3489:b0:187:7f2e:98d6 with SMTP id
 n9-20020a056870348900b001877f2e98d6mr5063275oah.9.1681701867587; Sun, 16 Apr
 2023 20:24:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230416074607.292616-1-alvaro.karsz@solid-run.com>
 <AM0PR04MB4723C6E99A217F51973710F5D49F9@AM0PR04MB4723.eurprd04.prod.outlook.com>
 <20230416164453-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230416164453-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Date:   Mon, 17 Apr 2023 11:24:16 +0800
Message-ID: <CACGkMEvFhVyWb5+ET_akPvnjUq04+ZbJC8o_GtNBWqSMGNum8A@mail.gmail.com>
Subject: Re: [PATCH net] virtio-net: reject small vring sizes
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Alvaro Karsz <alvaro.karsz@solid-run.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 17, 2023 at 4:45=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Sun, Apr 16, 2023 at 04:54:57PM +0000, Alvaro Karsz wrote:
> > After further consideration, other virtio drivers need a minimum limit =
to the vring size too.
> >
> > Maybe this can be more general, for example a new virtio_driver callbac=
k that is called (if implemented) during virtio_dev_probe, before drv->prob=
e.
> >
> > What do you think?
> >
> > Thanks,
> > Alvaro
>
> Let's start with what you did here, when more than 2 drivers do it we'll
> move it to core.

I wonder how hard it is to let virtio support small vring size?

Thanks

>
> --
> MST
>

