Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97BF3737D04
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 10:08:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230501AbjFUHz4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 03:55:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230187AbjFUHzy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 03:55:54 -0400
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B778FE41
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 00:55:52 -0700 (PDT)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-1a998a2e7a6so5800780fac.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 00:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687334152; x=1689926152;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=chdbH7mNzgkmuCyhA12j8pNPXGXQu3niNcq2qlGIJcs=;
        b=LbxvhVwpNqssBmWSmVTSBoOqM3MlXb7DhtqbUE7LEO6cnbME5IpO64HbS9T7taeDtX
         ailK4VhS9N0EesSXQmFC2QE4SQ5fNtqKFY+87AtZ9U8ZOskme0FDpgkPTSs5lr+hUyTe
         /Qgvw0ssaER5tRu6uE15GBqc/dQxMJ55TBZdwRPyB3zbeMf7Q6bRTMeZwu/GgnYrbhr7
         3sLqgkfyMTQCMhfCqGuLSseBFInIkpKzb76bqT5LDq7xMCwTcqeAGPmEB0OZZt+xemG0
         Hrlyp5maNwnixWVnA2DEu7A7EBtV9+EE+D94ZZ0WxqnqI5Tfbf1qH/2/HAGL8ZztSsCu
         HyXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687334152; x=1689926152;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=chdbH7mNzgkmuCyhA12j8pNPXGXQu3niNcq2qlGIJcs=;
        b=JFECeH81grroXzmwLXCOKbH4FSx13O3yCJ9AiUDM/M/LlxE5Qx74aWwIo3wP0yCQbY
         kbBaMvLTVHK/mVcDKQYN6+2ck9z4bpLVuKh+KWrr9MpNBTN8+ldlwhu7CSmMsd8HLqUv
         41P7kaSMlsi1ej+ECzFmnRt/7WhSwEQ+8MvARC3cAp6+cUO1fAmMkcALK+FGFlbT5t1S
         g3qsHE7SJes0cVhDK48MKGZwtowFYZgBEgbHyd0+cCxd84Nr11nRuajEimSBI0h9Yu+n
         lxL9hzGsexRqetRP09oUgjXrYPROFdkn0UyaoCztJrAcXqhIBUmiez0zaZnzJybdOSdR
         ppBg==
X-Gm-Message-State: AC+VfDwnxQDG710pbEsw1db0mOgJxkG1HtwNTrivT1kQs0ovz+YzGjW1
        BFIsMfM38d+ZK9YuGeUVJQRz2DIiH3WILwcMcEk=
X-Google-Smtp-Source: ACHHUZ6hf43JL8/RjRnBEVRErt7bEY91oQCXLhTfpmTCVuL+A1sbzEX1l/BiasLu5n6sDvOOkVw+A4kp6AMZvTIKafo=
X-Received: by 2002:a05:6870:343:b0:1aa:1c3f:4e7 with SMTP id
 n3-20020a056870034300b001aa1c3f04e7mr4918564oaf.57.1687334151934; Wed, 21 Jun
 2023 00:55:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230620094716.2231414-1-18949883232@163.com>
In-Reply-To: <20230620094716.2231414-1-18949883232@163.com>
From:   Christian Gmeiner <christian.gmeiner@gmail.com>
Date:   Wed, 21 Jun 2023 09:55:40 +0200
Message-ID: <CAH9NwWdfK0DkDA-Fi6TRrS4orm-HbAqBLDpYcMKd69dU6Jh+CA@mail.gmail.com>
Subject: Re: [PATCH v10 00/11] drm/etnaviv: Add pci device driver support
To:     Sui Jingfeng <18949883232@163.com>
Cc:     Lucas Stach <l.stach@pengutronix.de>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org,
        etnaviv@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        Sui Jingfeng <suijingfeng@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

>
> From: Sui Jingfeng <suijingfeng@loongson.cn>
>
> There is a Vivante GC1000 (v5037) in LS2K1000 and LS7A1000, this GPU is a
> PCI device, and it has 2D and 3D cores in the same core. This series is
> trying to add PCI device driver support to drm/etnaviv.
>

Is it possible to get the lspci output for the GPU? Something like
this: sudo lspci -vvv -s ...


thanks
--
Christian Gmeiner, MSc

https://christian-gmeiner.info/privacypolicy
