Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E632D636072
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 14:51:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234875AbiKWNvT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 08:51:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236651AbiKWNun (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 08:50:43 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 639B98FF99
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 05:40:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669210809;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SNHhmVfjWC62dBHkktz2lKH8qamIk/lczkSRmxlEqVI=;
        b=LUnliWDdooJ2wf6J00FUL9tsssMDpwd7sFDUT+/6iTT7kw1eVErSLlfDmUTV56mo2P6/cK
        lVJkpG4ZwRnXgYrzH7bb+1Jn7y/PZEIO2BDbyOsh8ydzdwFPDm/tSC/JW9YL41detXammd
        tJ5FeTf9RecfRGB1vAk4g5a5yXPApoM=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-654-3RHsdkQYPCeXkQk45cC3rA-1; Wed, 23 Nov 2022 08:40:08 -0500
X-MC-Unique: 3RHsdkQYPCeXkQk45cC3rA-1
Received: by mail-ej1-f71.google.com with SMTP id nb1-20020a1709071c8100b007ae4083d6f5so9942072ejc.15
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 05:40:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SNHhmVfjWC62dBHkktz2lKH8qamIk/lczkSRmxlEqVI=;
        b=SloIIfQR+tUXJBlo/OoB8Te5xxoTEVjJW61SagfcXYBqJnPvOKaeJDXqyihhlyStNl
         ZK5A/hnPi4bfIjDzesJdEBSORldESVVA7zbcmtcsG0WGGKtTfX/KuXNPp6NuLo1QnRgy
         Isnlhy/VojqvQdo6UZWL8SCKodifCytTTX1ysBSB1+iHOxtdxiU4EnoajCx+5JzU+PU4
         RN8sveW9sDu/NKxhYQWDAX01XrlKDD9+jQpEX/UIvo/kxu3ARyNJSaLmksVX4wRbPaCQ
         eVGqly192D2iq8b1IjeWY6SjjkpSXCFSSHw0pJCetja4qhY2zSe88yuwLZDjZY86gakn
         8hWA==
X-Gm-Message-State: ANoB5pmT34c+nRt6f+BvkY7AO6064zYvc2vH+22CkfUJjMbIXGoNuBCd
        fRiW1B1bBZAmXCTv370e5Bfwe07mgozCJHovZS1z01hJAbaP2GV4B/CC+pyeMzPUqGk0lOlnvL1
        fGMHW7LWW2P3d195QQ2hMAot7MwFKHeQw3qBziJpe
X-Received: by 2002:aa7:dd45:0:b0:45a:3c66:b0e4 with SMTP id o5-20020aa7dd45000000b0045a3c66b0e4mr26301512edw.33.1669210807041;
        Wed, 23 Nov 2022 05:40:07 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7gzZQFA230BeIin7j0qKxuZe3sbEXZICJfqwgbe50BaZYLtBE6/nZoPy4vtGYoisx+/mQFisC850w0rm+Qf4I=
X-Received: by 2002:aa7:dd45:0:b0:45a:3c66:b0e4 with SMTP id
 o5-20020aa7dd45000000b0045a3c66b0e4mr26301496edw.33.1669210806830; Wed, 23
 Nov 2022 05:40:06 -0800 (PST)
MIME-Version: 1.0
References: <20221123065319.56756-1-zhengyongjun3@huawei.com>
In-Reply-To: <20221123065319.56756-1-zhengyongjun3@huawei.com>
From:   Alexander Aring <aahringo@redhat.com>
Date:   Wed, 23 Nov 2022 08:39:55 -0500
Message-ID: <CAK-6q+gWK3g-g+6ox240hEmVQu2xjq4ZfxGdO9AHoqKG-5Myfw@mail.gmail.com>
Subject: Re: [Cluster-devel] [PATCH -next] fs: dlm: Fix build error without DEBUG_LOCK_ALLOC
To:     Zheng Yongjun <zhengyongjun3@huawei.com>
Cc:     cluster-devel@redhat.com, linux-kernel@vger.kernel.org,
        zhengbin13@huawei.com
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

Hi,

On Wed, Nov 23, 2022 at 8:37 AM Zheng Yongjun <zhengyongjun3@huawei.com> wrote:
>
> If CONFIG_DLM is y, DEBUG_LOCK_ALLOC is n, building fails:
>
> fs/dlm/lowcomms.o: In function `lowcomms_queue_rwork':
> lowcomms.c:(.text+0x2ac): undefined reference to `lockdep_is_held'
> lowcomms.c:(.text+0x308): undefined reference to `lockdep_is_held'
> fs/dlm/lowcomms.o: In function `lowcomms_queue_swork':
> lowcomms.c:(.text+0x3e0): undefined reference to `lockdep_is_held'
> fs/dlm/lowcomms.o: In function `restore_callbacks':
> lowcomms.c:(.text+0xd8c): undefined reference to `lockdep_is_held'
> lowcomms.c:(.text+0xdcc): undefined reference to `lockdep_is_held'
>
> Make DLM select DEBUG_LOCK_ALLOC to fix this.
>

Thanks, there is a different approach already in dlm/next and I think
we don't want to have dlm selecting a debug option.

- Alex

