Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41CE17346EE
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Jun 2023 18:10:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229514AbjFRQKH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jun 2023 12:10:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjFRQKF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jun 2023 12:10:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25C8EE54
        for <linux-kernel@vger.kernel.org>; Sun, 18 Jun 2023 09:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687104558;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=w2INyO+y8xDXiMBhrjMvHN1J2A6ehB/rv2/0JiFPr5c=;
        b=Ks7B6qBNZmTwgxvXf5OKeymBY+uGt4YZJi0fStO7GYyytWJUcG9dFf0oef/Jy/LxULzyES
        RderjYsnfdBMxK1k4HlXKertoErEAtgJuoaygMOAmp5PwFTSoukEcx2QOlnndRnV0cVivT
        1+fSfP+azJIu+S7PGyBVw4seRg7Mn+c=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-482-ipGhJ5iZNNK00PulEVdVqA-1; Sun, 18 Jun 2023 12:09:16 -0400
X-MC-Unique: ipGhJ5iZNNK00PulEVdVqA-1
Received: by mail-oo1-f70.google.com with SMTP id 006d021491bc7-55e3a8dfe62so779035eaf.0
        for <linux-kernel@vger.kernel.org>; Sun, 18 Jun 2023 09:09:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687104556; x=1689696556;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w2INyO+y8xDXiMBhrjMvHN1J2A6ehB/rv2/0JiFPr5c=;
        b=i6G22QVbSoJV/2kEzf5aO9mW9PVtKrzGqGn31Kd7q1IQVOmixtGbXFfKoxLcwQdfw8
         3HMnqksKURafBf6Aw3pAdCLJoX1hIZ45h7UvBqq8uGtzBRTWHKRMbsNjOZH5JjKUu2aq
         UAIyOZoT7G/KWNHsl04YpYfTPUwJV5VpBJO0aiud2MLBEJhqAte6PEWWW6saNeqXk6rl
         ++LHCD3OSJ8pVy9heIiKrSDNv1HKwOkkshUJqCbjTdBe/AT6IfnHqnfXy4uFqmOToFUU
         XZFcntRxGNZ8FlNc6+xGKFAqWN7fAOueL5xu5CUCEYRW1AawzhA0BjYum0GLvZNyAL5T
         zy+g==
X-Gm-Message-State: AC+VfDxKDtK076Vurh+0LXoj+3/TWMD6v1dzzPf7qrNc6rJhZt1D9t6T
        dp6UmDKMr8TiB3htnFjmjYSM2wWQU00MunT2cwgnW3OHdPqOY2H4EQs2ZvIQRwXrrG4juUIOn1+
        3XYpUptEprDibjF6Zt6b+UqQrYbSj27s58f5Rg/uI
X-Received: by 2002:a4a:a551:0:b0:558:b386:7a78 with SMTP id s17-20020a4aa551000000b00558b3867a78mr5064726oom.5.1687104556049;
        Sun, 18 Jun 2023 09:09:16 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4qdlYRunIz+0lrWIGBkf2nmP2roOaQDa3a49rkAc6u+/xrdNaMJmxnVwol++Y4Uk/TyDPCixp2Z7ft29OIHFw=
X-Received: by 2002:a4a:a551:0:b0:558:b386:7a78 with SMTP id
 s17-20020a4aa551000000b00558b3867a78mr5064714oom.5.1687104555727; Sun, 18 Jun
 2023 09:09:15 -0700 (PDT)
MIME-Version: 1.0
References: <87h6rhoyag.fsf@meer.lwn.net> <20230618062937.481280-1-costa.shul@redhat.com>
 <c0c44b35-b55d-6965-7103-76d9a9bf5c0d@infradead.org>
In-Reply-To: <c0c44b35-b55d-6965-7103-76d9a9bf5c0d@infradead.org>
From:   Costa Shulyupin <costa.shul@redhat.com>
Date:   Sun, 18 Jun 2023 19:09:04 +0300
Message-ID: <CADDUTFzBYtLbC5fGa7bA1LXXgNAEfHzueS9oO93r6WNtM2TYXw@mail.gmail.com>
Subject: Re: [PATCH v4] docs: consolidate storage interfaces
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 18 Jun 2023 at 18:20, Randy Dunlap <rdunlap@infradead.org> wrote:
> What does the TCM Virtual Device comment refer to?

TCM stands for Target Core Mod.
It is configured by CONFIG_TARGET_CORE.
The moved doc is https://docs.kernel.org/target/. Good example to not
name directories.
It says "TCM is another name for LIO, an in-kernel iSCSI target (server)."
LIO stands for Linux-IO: https://en.wikipedia.org/wiki/LIO_(SCSI_target)

Thank you.

