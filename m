Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3DCB6B6DC8
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 04:05:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbjCMDFn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 23:05:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjCMDFZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 23:05:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7E2127988
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 20:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678676680;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AQANVrvaj9/B2WSrHSzaItV2LmCoP7qwGr+9zKi06ow=;
        b=gV5nfgQcY2t+5q9xafnrC8wyaqh+Rs87zFLiRGmyrA+blUpLeABk2GRf+eaweEj7WCPUSN
        5GLSJ3ZbmomKlXDQg9vCujGZwvvfT14qfpxziXT9hQ3SoMUA4WybMoAfWB1Zb5e7U2Aj6H
        AsetDE+rkYj1CBllBsZj2uTd+7hsDDc=
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-447-6F31cFwaM02ri9VHzJ4R3Q-1; Sun, 12 Mar 2023 23:04:31 -0400
X-MC-Unique: 6F31cFwaM02ri9VHzJ4R3Q-1
Received: by mail-ua1-f70.google.com with SMTP id j20-20020ab06014000000b00445260e9ad6so5536256ual.13
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 20:04:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678676671;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AQANVrvaj9/B2WSrHSzaItV2LmCoP7qwGr+9zKi06ow=;
        b=ECvlHNsgUBseNKAsvGyEKDQEDz8E59cWnaYGCcZM8CGY2R/goXUiSM28CeJxU6Cja3
         hUiLQ8yo0UXgyU6q0822stKbmr6aNdIcsLFjuJWcoE4LMUDVbdMn6D7whwJRlcLwXznc
         78pLCD/l1tzrb+lPk8zeoD9gW5RPN/XjMNTb2OFB6SryuM4PzvmCDrYWdMXDQ6zH8P0A
         Fs/c74AvDQtcdC0sGB95yRZQ/n+tuo880lsxLFxa9MVgqQCDWVAS6ORHbvZda7N+go6r
         JBE/si5k1bzS1A6Fm9dTVx22VxS1BBgpyBHfXKOjix2URByNukPipvMkUzHLXsD3V1CD
         /RXg==
X-Gm-Message-State: AO0yUKX+Eom9fp0a02TYeZ9lKfJOqGWyhDZV+UG62HoMEI5J3ygPhkaX
        VHC78SbpTiEV7sdA7vIYqM6Vct1vM09AIKmdLPs4F5A4jfM4qZEXoTYbhAc4XyMAUh8JzKLcJhE
        urFzY1XuVseQebSnary4C7oQ7wZ9Vip3cI65NU21r
X-Received: by 2002:a1f:4b01:0:b0:401:8898:ea44 with SMTP id y1-20020a1f4b01000000b004018898ea44mr18555379vka.3.1678676671151;
        Sun, 12 Mar 2023 20:04:31 -0700 (PDT)
X-Google-Smtp-Source: AK7set83d8dKkzLeJ9M1ow+hnonqiyLfMHFAS+UySCvJj8sJK2fNKWzzVwX2uSVj8vcnI9W5BAG2+1uG1juFgoNFqic=
X-Received: by 2002:a1f:4b01:0:b0:401:8898:ea44 with SMTP id
 y1-20020a1f4b01000000b004018898ea44mr18555374vka.3.1678676670837; Sun, 12 Mar
 2023 20:04:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230310201525.2615385-1-eblake@redhat.com> <20230310201525.2615385-2-eblake@redhat.com>
In-Reply-To: <20230310201525.2615385-2-eblake@redhat.com>
From:   Ming Lei <ming.lei@redhat.com>
Date:   Mon, 13 Mar 2023 11:04:19 +0800
Message-ID: <CAFj5m9JmwYn9BTYEWWFykC_20rDVXfENKRbD2A=G=DmM4ni1-g@mail.gmail.com>
Subject: Re: [PATCH 1/3] uapi nbd: improve doc links to userspace spec
To:     Eric Blake <eblake@redhat.com>
Cc:     josef@toxicpanda.com, linux-block@vger.kernel.org,
        nbd@other.debian.org, philipp.reisner@linbit.com,
        lars.ellenberg@linbit.com, christoph.boehmwalder@linbit.com,
        corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 11, 2023 at 4:17=E2=80=AFAM Eric Blake <eblake@redhat.com> wrot=
e:
>
> The uapi <linux/nbd.h> header intentionally documents only the NBD
> server features that the kernel module will utilize as a client.  But
> while it already had one mention of skipped bits due to userspace
> extensions, it did not actually direct the reader to the canonical
> source to learn about those extensions.
>
> While touching comments, fix an outdated reference that listed only
> READ and WRITE as commands.
>
> The documentation file also had a stale link to sourceforge; nbd
> ditched that several years ago in favor of github.
>
> Signed-off-by: Eric Blake <eblake@redhat.com>

Reviewed-by: Ming Lei <ming.lei@redhat.com>

