Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6E4073FDCB
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 16:26:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231476AbjF0O01 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 10:26:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231165AbjF0O0V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 10:26:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A0712726
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 07:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687875930;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vGSc4mdTDNNjtXngrQkAE2Vk0OODhwWQe551QFWP1tI=;
        b=EVkoLytFYy0mqJNyHjPP134Jtenk6/4ws5mh3ON6tJw/nBSuZt6fnH1TyBjT9V2MwyY0xx
        v/PKnG2HbClxx6YTmZ4MndPBl1cnqemCzCVS/xl8/T1CfXaBJfauywm7XoiBlUa5z8ao7O
        KAgJV73IAtI0EKTdVgDkwYMnSc17i4M=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-132-QHwrs4MWNLqzQbNk9xZKBw-1; Tue, 27 Jun 2023 10:25:19 -0400
X-MC-Unique: QHwrs4MWNLqzQbNk9xZKBw-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-94a348facbbso273769766b.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 07:25:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687875915; x=1690467915;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vGSc4mdTDNNjtXngrQkAE2Vk0OODhwWQe551QFWP1tI=;
        b=Wpa1gO1FJ69uOBwAYUeflVtO33ypMlO4L6YYAfJU2hC71QHDa33BaGf6tihtWkJJ2j
         NkBs+s3fcbfazvIOfidkKEuQ4wW3eXiXHXVWKPg3cG9Rh//F2PhgyIQo1/IDX/tF0/ek
         pQOH8QoOEfVQNUjsLMV0PeuwsjaBaU1PznpQMRughKSjOSZpqJ6DnG6ocBCl9rbkrIUZ
         C50WdTyz+G5+SWfZ7mRoXO9nrKiz/k148J789oRM5srgsJSyaSMEjM0YRO5uWZBPMJjA
         NpSmzUJgkm9G+RdoTkSrkdMNpgWSZLgcKyyzBm9EkHgS5oAS8l5XjkOnTnuyXw+m8AjC
         7E3w==
X-Gm-Message-State: AC+VfDwJdfVS5wpFMPb4V822eHzH2dzA6r+Vh52PAUL9x6UfdV4x33sV
        hhYL4+hLx48qPmeBEyWRz+eSQqAZf5Adt3zDjz9epHWrLd/95JioizRB4M7cGCNEWQBuk64cEcv
        MuM+7C+FZOwz4ETvt6p2jmbcF
X-Received: by 2002:a17:906:da8b:b0:982:26c5:6525 with SMTP id xh11-20020a170906da8b00b0098226c56525mr32188641ejb.60.1687875914703;
        Tue, 27 Jun 2023 07:25:14 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6i5PkNbA3Uw3V9yHzNgEF6zgc+6XvzXai4Ju+na594EFjrV8ZjoKAuLT8tuRH4vcpCqG3Dfw==
X-Received: by 2002:a17:906:da8b:b0:982:26c5:6525 with SMTP id xh11-20020a170906da8b00b0098226c56525mr32188620ejb.60.1687875914199;
        Tue, 27 Jun 2023 07:25:14 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id qn1-20020a170907210100b0098e42bef731sm3234766ejb.169.2023.06.27.07.25.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jun 2023 07:25:13 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 2921ABBFF6C; Tue, 27 Jun 2023 16:25:13 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Daniel Xu <dxu@dxuuu.xyz>, bpf@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, coreteam@netfilter.org,
        netfilter-devel@vger.kernel.org, fw@strlen.de, daniel@iogearbox.net
Cc:     dsahern@kernel.org
Subject: Re: [PATCH bpf-next 0/7] Support defragmenting IPv(4|6) packets in BPF
In-Reply-To: <cover.1687819413.git.dxu@dxuuu.xyz>
References: <cover.1687819413.git.dxu@dxuuu.xyz>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Tue, 27 Jun 2023 16:25:13 +0200
Message-ID: <874jmthtiu.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> The basic idea is we bump a refcnt on the netfilter defrag module and
> then run the bpf prog after the defrag module runs. This allows bpf
> progs to transparently see full, reassembled packets. The nice thing
> about this is that progs don't have to carry around logic to detect
> fragments.

One high-level comment after glancing through the series: Instead of
allocating a flag specifically for the defrag module, why not support
loading (and holding) arbitrary netfilter modules in the UAPI? If we
need to allocate a new flag every time someone wants to use a netfilter
module along with BPF we'll run out of flags pretty quickly :)

-Toke

