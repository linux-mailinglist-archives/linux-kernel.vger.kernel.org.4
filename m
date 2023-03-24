Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2D276C7D8B
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 12:59:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230071AbjCXL7T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 07:59:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbjCXL7Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 07:59:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A83589760
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 04:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679659113;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WFRhAEW+lBgl4z20TkQtu5IaRn9JzQcLohklOWmxl9I=;
        b=d7hRzQbRpzZ8C+Rtg9VqU7HdRPZ1yovNk9JQ8Fyy18G0AbdMtJx/ppMJb80QUp+zuJoa3E
        AtlprhuTogUsyMIOgL/KFEbyLTQteeQVM6+dNqUy+lsZlXt1DV07xDd0XfmaE01ekZ09jn
        Qqc4vyevsK7ofq7KLOae1dnNBbvX6Ro=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-115-bCYLnX55PW2XuHSJbxzhdw-1; Fri, 24 Mar 2023 07:58:32 -0400
X-MC-Unique: bCYLnX55PW2XuHSJbxzhdw-1
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-536a5a0b6e3so16354947b3.10
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 04:58:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679659112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WFRhAEW+lBgl4z20TkQtu5IaRn9JzQcLohklOWmxl9I=;
        b=xurisevkVbPOX/YdwCBx+hjrF/dwQNhiz0DCFkGSB6A72s1z+Eq/3c0gYmsF6Wbd3m
         CvgIyRESnxpn9wbFQstOKb7YfRVZtishedD9RvU2sdQ1FHtlOiwxqXczE1HljemX/vfy
         6y93N1rd77jDnBrd7ry4l2A6G3/O35ckukE9CgFJ+kIClBtadFAImnZJESCCLbJLMb0V
         LcgSZu/2cTmT8T/fOJvgGhKTdeFb9DqOwjY3MHPKhpD8QuNvlskOBHJp4YgvNug/vz07
         N5arBaf2VZOjftdHeS2VuJzScMd/wiQcsRdVg2qHIv5YtsU7vsLkaLy50wJGZb/eE3QG
         gzkA==
X-Gm-Message-State: AAQBX9e3/uEJiEjQILqe0w5dtCggyDBdlI8MO4ZvCQmfkkC3jTh/1Bk9
        OWEdX1pIhkXJplSRBGRNNUtt+sbw5nVN20Chq4j4jQJaLv1/cZoJdvzQwMjmEZkL7jgGI5xFf+3
        i09IkVyJBU2VrSYJPlu6T1J8gHYRhZ5oschBYWIsk
X-Received: by 2002:a81:ed08:0:b0:545:624a:874f with SMTP id k8-20020a81ed08000000b00545624a874fmr1127705ywm.3.1679659112406;
        Fri, 24 Mar 2023 04:58:32 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZqTA4xw2AJ7nh6DTMfcKRQq3tCXDjfqRBOsmdfigLt1Fagj6zEUmXaVvwqLo5wUZNoPZiX6cX52rWCA91hRqI=
X-Received: by 2002:a81:ed08:0:b0:545:624a:874f with SMTP id
 k8-20020a81ed08000000b00545624a874fmr1127700ywm.3.1679659112185; Fri, 24 Mar
 2023 04:58:32 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000708b1005f79acf5c@google.com> <CAGxU2F4ZiNEyrZzEJnYjYDz6CxniPGNW7AwyMLPLTxA2UbBWhA@mail.gmail.com>
 <CAGxU2F6m4KWXwOF8StjWbb=S6HRx=GhV_ONDcZxCZsDkvuaeUg@mail.gmail.com> <CAGxU2F7XjdKgdKwfZMT-sdJ+JK10p_2zNdaQeGBwm3jpEe1Xaw@mail.gmail.com>
In-Reply-To: <CAGxU2F7XjdKgdKwfZMT-sdJ+JK10p_2zNdaQeGBwm3jpEe1Xaw@mail.gmail.com>
From:   Stefano Garzarella <sgarzare@redhat.com>
Date:   Fri, 24 Mar 2023 12:58:20 +0100
Message-ID: <CAGxU2F5Q09wFbhfoGB-Wa_0xQFoP8Ah34vqf4gG3DRFdPny1fQ@mail.gmail.com>
Subject: Re: [syzbot] [kvm?] [net?] [virt?] general protection fault in virtio_transport_purge_skbs
To:     syzbot <syzbot+befff0a9536049e7902e@syzkaller.appspotmail.com>,
        Bobby Eshleman <bobby.eshleman@bytedance.com>,
        Bobby Eshleman <bobby.eshleman@gmail.com>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, pabeni@redhat.com, stefanha@redhat.com,
        syzkaller-bugs@googlegroups.com,
        virtualization@lists.linux-foundation.org,
        Krasnov Arseniy <oxffffaa@gmail.com>,
        Krasnov Arseniy Vladimirovich <AVKrasnov@sberdevices.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 24, 2023 at 10:06=E2=80=AFAM Stefano Garzarella <sgarzare@redha=
t.com> wrote:
>
> On Fri, Mar 24, 2023 at 9:55=E2=80=AFAM Stefano Garzarella <sgarzare@redh=
at.com> wrote:
> >
> > On Fri, Mar 24, 2023 at 9:31=E2=80=AFAM Stefano Garzarella <sgarzare@re=
dhat.com> wrote:
> > >
> > > Hi Bobby,
> > > can you take a look at this report?
> > >
> > > It seems related to the changes we made to support skbuff.
> >
> > Could it be a problem of concurrent access to pkt_queue ?
> >
> > IIUC we should hold pkt_queue.lock when we call skb_queue_splice_init()
> > and remove pkt_list_lock. (or hold pkt_list_lock when calling
> > virtio_transport_purge_skbs, but pkt_list_lock seems useless now that
> > we use skbuff)
> >
>

Patch posted here:
https://lore.kernel.org/netdev/20230324115450.11268-1-sgarzare@redhat.com/

