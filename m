Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 096AA6D0477
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 14:18:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231391AbjC3MSs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 08:18:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbjC3MSq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 08:18:46 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 326FD76A2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 05:18:45 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id v20-20020a05600c471400b003ed8826253aso3331513wmo.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 05:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20210112.gappssmtp.com; s=20210112; t=1680178723;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=Wyt/QKbfFqwXxgXngsVcjXvUcjSi2SpEjcCROkpNZHw=;
        b=Eqmfhnq5IEFLLhAjAZRIobhW/2B13mAKES+/WX/G7vJ9k6+u98ggyXukQa0h3R3Pf3
         hjsG7bZivizU1puj66d5NNFYaW+jHoYbxNV/lTSLJgMMevl4Go5+ZPboncgUDRXv+Pb5
         GkG6JqvpkWG3I7zPRYUM/oVw8aPAfOctlVnYhW3XV6iph4MfSFnbNkEfkkUtUh3+FKZp
         d9vZsJt5qH/TE/5iu76QwFEFI3Y6o0Et9QWOv86TCtRi04gMXrYrQfxpDNocZPH0N5AI
         +FBeoAHbfb91soVmz+IvymSJvF+YbDnt0hX2v2zuIdsuZ1JNTbWQnLcpZ2QItLZ9R6eX
         MdDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680178723;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wyt/QKbfFqwXxgXngsVcjXvUcjSi2SpEjcCROkpNZHw=;
        b=j6pYC8GWpejEh9QOemJG6d01yoKxZc1aCFNsfZ1vEcHWQ+kh005CTZ8YOGCfO5lQ80
         inyAzdzWkHUhkuW5mf0y7WJNcfjPnqPtyb51JLTV0bzK3DY6ToAsyCEfuOGe01o2z8sP
         CMagFOPTrTTeE8v9jHuOjGi5eJPGhWadaM5Zr88xt+rja/Qn5oivva3XezXfZh88RRNt
         iu/+pFaY8W/Od/rCw7xILi5XYcsVmMP6I+wDQW4CEp3w2wUipbugsql6WaHTGTn64jZj
         Ig+ijg4WxamcRAzWnc9R0FTP6nGF9nGZMBM9wQporK94y/0B+G4z9aLGDCznXbujHkOK
         th1Q==
X-Gm-Message-State: AO0yUKVOJUNVIaB8Y84l/IjJuRBtew/SMeAnWmhVtRjannSzoyY2eVTd
        N86jeSCalpCDWGuficMZq3xRbA==
X-Google-Smtp-Source: AK7set8KZRCKiYFEeuKZGefi283mvYKlXVix1qHiiGvficshl2fwJ0ohFCGwM+wM6kXCzp8F9AjUWQ==
X-Received: by 2002:a7b:cbc2:0:b0:3df:de28:f819 with SMTP id n2-20020a7bcbc2000000b003dfde28f819mr18146008wmi.15.1680178723657;
        Thu, 30 Mar 2023 05:18:43 -0700 (PDT)
Received: from localhost ([165.225.194.194])
        by smtp.gmail.com with ESMTPSA id n23-20020a05600c3b9700b003ede04deb14sm5744936wms.48.2023.03.30.05.18.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 05:18:43 -0700 (PDT)
References: <20230329223239.138757-1-y86-dev@protonmail.com>
 <20230329223239.138757-3-y86-dev@protonmail.com>
User-agent: mu4e 1.9.18; emacs 28.2.50
From:   Andreas Hindborg <nmi@metaspace.dk>
To:     y86-dev@protonmail.com
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?utf-8?Q?Bj=C3=B6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        Alice Ryhl <alice@ryhl.io>, rust-for-linux@vger.kernel.org,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev
Subject: Re: [PATCH v3 02/13] rust: sync: add `assume_init` to `UniqueArc`
Date:   Thu, 30 Mar 2023 14:18:06 +0200
In-reply-to: <20230329223239.138757-3-y86-dev@protonmail.com>
Message-ID: <87y1ne4el9.fsf@metaspace.dk>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


y86-dev@protonmail.com writes:

> From: Benno Lossin <y86-dev@protonmail.com>
>
> Adds the `assume_init` function to `UniqueArc<MaybeUninit<T>>` that
> unsafely assumes the value to be initialized and yields a value of type
> `UniqueArc<T>`. This function is used when manually initializing the
> pointee of an `UniqueArc`.
>
> Signed-off-by: Benno Lossin <y86-dev@protonmail.com>
> ---

Reviewed-by: Andreas Hindborg <a.hindborg@samsung.com>

