Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCCAD6CEF5A
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 18:29:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbjC2Q3F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 12:29:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjC2Q3C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 12:29:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16E9391
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 09:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680107298;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8RNV3SNYYIlFYMBuhq2GEFacMvzVUMzJmv6WI/yLqIc=;
        b=bAlc681hfP1LsrVRWkP/OXQ6Xr80mLuMceYv9LWqpxIwW4cYUazx/9AmKr+Lg1NbdEw0iT
        /5XE3YeRbzb7eI9KEGJ+uRf+igVVkAMopxMsvU14KfBDkC8b1TSubVGTCTn1goZ1C33ZH0
        ZPXo2AQ7yXjr3J/iEx7gTMplw1f4+XY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-63-Jsu-N1qCPqKLpXil03qKAw-1; Wed, 29 Mar 2023 12:28:16 -0400
X-MC-Unique: Jsu-N1qCPqKLpXil03qKAw-1
Received: by mail-wm1-f71.google.com with SMTP id o37-20020a05600c512500b003edd119ec9eso8117963wms.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 09:28:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680107296;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8RNV3SNYYIlFYMBuhq2GEFacMvzVUMzJmv6WI/yLqIc=;
        b=6d2vN8LHFTSk8pEw6fsVF5f1/fBRqnqiX8UvMBf0xaH143dxXTw1GZZblmiJdKTl75
         1rwOvG+Z4iHIe6CQcCXaR4hMkBRfOGnkRoI/G3S/X44+cVu61tkZwsRV9BEbCQ+DlWT0
         rAMJJB59OomG9TaUsAzWUt3oVmwaoAJT7+4GoXcnmkD4hkJoIbozOr71P4fqzzqIyjqH
         kkuKxkZh8wjK4Otopul+hIY8n9CTvfyUnxPuJSDdXhpPL59NMYWX/Wpk/uZOM61KSmVo
         RmiSnHT7iYnWu/u+I4BjI4x/jCFD9zOQX4dv26mWKl2kXq4uthpvmlJdLEkr1FaJWQdl
         EOEw==
X-Gm-Message-State: AO0yUKWe9lKOZ0vc/PW21v/9nUyRixiAig0k5tbSpVX47czF12W284tk
        N3KlKlzAmet/26jcv4qPBUUcT3sHUzuNhrSg1GDKlmNa35kTpqW5yktsIemHMlw+KthKupchVfZ
        qnNfrvIKZxh86zBlzlda+K2oL
X-Received: by 2002:a7b:c7d1:0:b0:3ed:8bef:6a04 with SMTP id z17-20020a7bc7d1000000b003ed8bef6a04mr15658429wmk.27.1680107295866;
        Wed, 29 Mar 2023 09:28:15 -0700 (PDT)
X-Google-Smtp-Source: AK7set90/PaRSiGbUWRt/zderMMHrDvZtjT5MLaNI2vgj2wXzhqKQt862wm81Ijxg7RKvcOyXxWThw==
X-Received: by 2002:a7b:c7d1:0:b0:3ed:8bef:6a04 with SMTP id z17-20020a7bc7d1000000b003ed8bef6a04mr15658418wmk.27.1680107295568;
        Wed, 29 Mar 2023 09:28:15 -0700 (PDT)
Received: from redhat.com ([2.52.18.165])
        by smtp.gmail.com with ESMTPSA id k20-20020a7bc414000000b003ede3e54ed7sm2767779wmi.6.2023.03.29.09.28.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 09:28:15 -0700 (PDT)
Date:   Wed, 29 Mar 2023 12:28:11 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc:     Albert Huang <huangjie.albert@bytedance.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH v3] virtio_ring: interrupt disable flag updated to vq
 even with event_triggered is set
Message-ID: <20230329122727-mutt-send-email-mst@kernel.org>
References: <20230325105633.58592-1-huangjie.albert@bytedance.com>
 <ZCJNTBQLZeyLBKKB@codewreck.org>
 <CACGkMEt29t9CK2Muiuyb1s6p2AzgcMiD_z0NVFn1d+KEqBydug@mail.gmail.com>
 <CABKxMyPwuRb6p-oHxcQDhRtJv04=NDWvosNAp=epgvdrfCeveg@mail.gmail.com>
 <CACGkMEuukvjXBTDX2K9YLYmpHsqK96AiMK39gbm3+f_+kUydMQ@mail.gmail.com>
 <CABKxMyN0598wA6wHv5GkZC14znwp=OPo7u71_BizJfR+gUx4_w@mail.gmail.com>
 <20230329012908-mutt-send-email-mst@kernel.org>
 <20230329072135.44757-1-huangjie.albert@bytedance.com>
 <1680074823.805977-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1680074823.805977-1-xuanzhuo@linux.alibaba.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 29, 2023 at 03:27:03PM +0800, Xuan Zhuo wrote:
> Maybe one new thread is better.
> 
> Thanks.

I don't know but do not post same message twice please
without explanation. if you repost put "PATCH repost" in
the subject.

