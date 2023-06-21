Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2123C73930B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 01:37:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229898AbjFUXhg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 19:37:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229852AbjFUXhe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 19:37:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98E2F1995;
        Wed, 21 Jun 2023 16:37:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1A698616E6;
        Wed, 21 Jun 2023 23:37:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 760F7C433C0;
        Wed, 21 Jun 2023 23:37:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687390649;
        bh=SlrtOKaBV5alDYQ4Siuq31ol42DR3ATKRgXSKmZ5qlg=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=P7VxAKRGP30ucAQrjJyZK5GBL/XuyMWIhXtJ7YOJGT28caZoZqLMV0aJv1YuVXRck
         YUGpU+LEgMHeyIUsa79Q9EpQfZN7ULgofi4ZLOnTmRo5+EccgELIsRNzEFf3L9KSTR
         TN61o1EnhWtpRXsVm0jYMCwHJdxsfsbqqG0d60uGfajj+KnCopDCbm/UUR+S9zSSBb
         Utp5XzYfHWRHFfqfc6CJpnVjVly90pPGLQ+K5WijKNSqPeaLJo5Q4dg/xV0lQyi1Fl
         edMNWvbzXOr+eSPdyqfGw5/LtcaCCPMlixDcrvzcwE7Dok3IQKzyrYFnj8e+Uctt8b
         P7QjbaP68IQ4g==
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-1a1fa977667so6554692fac.1;
        Wed, 21 Jun 2023 16:37:29 -0700 (PDT)
X-Gm-Message-State: AC+VfDzDPEipRSjnSHMB0rtea3tpr09Hmava5T0HstBzwmg0Ilzkd2K5
        gOqW3KB4gom9krbVkoK6co8hE3w+oWvQlQicF+U=
X-Google-Smtp-Source: ACHHUZ575bQBXLzzx1qjVcU7DBted5N06GRzW3Z3zlVaLsHVOf7PmmaMGZoyh3HyeFRSgrwlUc7KmxkW3mocnttY9Ko=
X-Received: by 2002:a05:6870:ab89:b0:1a6:9da8:b66e with SMTP id
 gs9-20020a056870ab8900b001a69da8b66emr17374693oab.13.1687390648670; Wed, 21
 Jun 2023 16:37:28 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac9:5e18:0:b0:4df:6fd3:a469 with HTTP; Wed, 21 Jun 2023
 16:37:28 -0700 (PDT)
In-Reply-To: <ZJNnynWOoTp6uTwF@work>
References: <ZJNnynWOoTp6uTwF@work>
From:   Namjae Jeon <linkinjeon@kernel.org>
Date:   Thu, 22 Jun 2023 08:37:28 +0900
X-Gmail-Original-Message-ID: <CAKYAXd-hDG2w=oibjjctJr_Lsf-AH=6K-j5WioVQE771j_4m8Q@mail.gmail.com>
Message-ID: <CAKYAXd-hDG2w=oibjjctJr_Lsf-AH=6K-j5WioVQE771j_4m8Q@mail.gmail.com>
Subject: Re: [PATCH][next] smb: Replace one-element array with flexible-array member
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Steve French <sfrench@samba.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Tom Talpey <tom@talpey.com>, linux-cifs@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2023-06-22 6:12 GMT+09:00, Gustavo A. R. Silva <gustavoars@kernel.org>:
> One-element arrays are deprecated, and we are replacing them with flexible
> array members instead. So, replace one-element array with flexible-array
> member in struct smb_negotiate_req.
>
> This results in no differences in binary output.
>
> Link: https://github.com/KSPP/linux/issues/79
> Link: https://github.com/KSPP/linux/issues/317
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>

Thanks!
