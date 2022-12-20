Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6BDB651F35
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 11:48:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230132AbiLTKsB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 05:48:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230189AbiLTKr6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 05:47:58 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAF10B5E
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 02:47:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671533245;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BtcNXhVAF5Mh5/Biw8m1gljXz/koZEnrJ8YAHCfLSVg=;
        b=Z1TZBCI3zN9PU4yrFqRqXxPmBSMvy7+/p/iyD1RGTQ/pN4JiNk8Mxn4JsN6SmobIhhDxdO
        kvzbPEke9izlKV3qEsUnSPhyxPSSY6kxkx52PIGM3OVss+lL8RfwNC0IY2hVQCiIzk1thQ
        +3HRK9izcHmPh2cUDv6Wm+sTBGmhEUY=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-180-LtCS5ra5N9ObXhog-4_yBg-1; Tue, 20 Dec 2022 05:47:23 -0500
X-MC-Unique: LtCS5ra5N9ObXhog-4_yBg-1
Received: by mail-il1-f199.google.com with SMTP id l13-20020a056e021c0d00b003034e24b866so8275342ilh.22
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 02:47:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BtcNXhVAF5Mh5/Biw8m1gljXz/koZEnrJ8YAHCfLSVg=;
        b=coke4S1/8CX/VUpWVjie6Q6lB8ZT4anHzlRl8kVZfSV3xnLacvHl69mEHCOr+j5lzJ
         Nkutf7l+3NxGC8pIyWUzHiHL+1rWrNBdnnbwSVwNWTVwFT8g8Hn5HBPLBjhLGJWa+02n
         gLvstRmOugZvemHOvesuLWzcfN7K07+74ESVOuSbbIAFGjQMqJEkVfdxe2RQOq5pRh++
         Sw3h1X/zxY5UoEsR0yLsxlp/ahZdjbs7Xgu6A5tEbm4gs3Z7QQ9Rumz6E4t5mhsZSRMf
         ZFKwpuiUyYBwtOtc/3Dh/Jm6gAzND7QihulBZbFBP2XpCMp1RWKKBYa/+j7MlMCzZN6Y
         2yRg==
X-Gm-Message-State: ANoB5pnijkX4Zu05joLV5Sz6muZBfJuzPsSfICOE+jKvEUht1ym12K+0
        6iSxg4/Z43sBMQ4yUqHjCz+DVtwjW3ZQata+RPpJc4NuCHcnpmuzDq7SIygbJ6t75arnRkW/54q
        /5n4BMFaYwCq9S2O+HVbVD0DsZ+sCST20y3t0GL4E
X-Received: by 2002:a02:a089:0:b0:375:2a78:73fd with SMTP id g9-20020a02a089000000b003752a7873fdmr46525967jah.217.1671533242986;
        Tue, 20 Dec 2022 02:47:22 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7JBXJpg6qNm9SgzBNzQZEfnJaZx37hGB0TWVUAAFj/Mc2O387CUR2IQywQyTtLbStHSDLWatI/4QD3XC8tKTg=
X-Received: by 2002:a02:a089:0:b0:375:2a78:73fd with SMTP id
 g9-20020a02a089000000b003752a7873fdmr46525962jah.217.1671533242764; Tue, 20
 Dec 2022 02:47:22 -0800 (PST)
MIME-Version: 1.0
References: <20221220024921.21992-1-jiasheng@iscas.ac.cn> <035598f0-3174-9677-0b53-f3ccbfb54155@amd.com>
In-Reply-To: <035598f0-3174-9677-0b53-f3ccbfb54155@amd.com>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Tue, 20 Dec 2022 11:47:11 +0100
Message-ID: <CAO-hwJ++Dr94062SPnbqRJ33yJ5qB48--rnGyNQ12d6VvsCRUA@mail.gmail.com>
Subject: Re: [PATCH] HID: amd_sfh: Add missing check for dma_alloc_coherent
To:     Basavaraj Natikar <bnatikar@amd.com>
Cc:     Jiasheng Jiang <jiasheng@iscas.ac.cn>, basavaraj.natikar@amd.com,
        jikos@kernel.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 20, 2022 at 7:53 AM Basavaraj Natikar <bnatikar@amd.com> wrote:
>
>
> On 12/20/2022 8:19 AM, Jiasheng Jiang wrote:
> > Add check for the return value of the dma_alloc_coherent since
> > it may return NULL pointer if allocation fails.
> >
> > Fixes: 4b2c53d93a4b ("SFH:Transport Driver to add support of AMD Sensor Fusion Hub (SFH)")
> > Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
> > ---
> >  drivers/hid/amd-sfh-hid/amd_sfh_client.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/drivers/hid/amd-sfh-hid/amd_sfh_client.c b/drivers/hid/amd-sfh-hid/amd_sfh_client.c
> > index 8275bba63611..ab125f79408f 100644
> > --- a/drivers/hid/amd-sfh-hid/amd_sfh_client.c
> > +++ b/drivers/hid/amd-sfh-hid/amd_sfh_client.c
> > @@ -237,6 +237,10 @@ int amd_sfh_hid_client_init(struct amd_mp2_dev *privdata)
> >               in_data->sensor_virt_addr[i] = dma_alloc_coherent(dev, sizeof(int) * 8,
> >                                                                 &cl_data->sensor_dma_addr[i],
> >                                                                 GFP_KERNEL);
> > +             if (!in_data->sensor_virt_addr[i]) {
> > +                     rc = -ENOMEM;
> > +                     goto cleanup;
> > +             }
> >               cl_data->sensor_sts[i] = SENSOR_DISABLED;
> >               cl_data->sensor_requested_cnt[i] = 0;
> >               cl_data->cur_hid_dev = i;
>
> looks good to me.
>
> Acked-by: Basavaraj Natikar <Basavaraj.Natikar@amd.com>

Thanks.

I have now applied this patch to hid.git branch for-6.2/upstream-fixes.

Cheers,
Benjamin

