Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B95265F8731
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Oct 2022 21:44:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbiJHTo3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Oct 2022 15:44:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbiJHTo0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Oct 2022 15:44:26 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B7532EF04
        for <linux-kernel@vger.kernel.org>; Sat,  8 Oct 2022 12:44:26 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id v10-20020a17090a634a00b00205e48cf845so9943050pjs.4
        for <linux-kernel@vger.kernel.org>; Sat, 08 Oct 2022 12:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mAgGQiYibt6/W5CAo+9L5oS3sdpJlLe5MrCeTey7nag=;
        b=J+8YFK6iUM86zYLhmFX3+t7qRzul/K4tXXW0089HqM4aCs4d/CCqPjf7/fv65zexgD
         XdhVVzx+W1tmmk8HUs48KiXHOjR0EtbRpYzJxa511QAN+oE4KpqYCS7blqqBQAVGwfYJ
         iQ5bB4mISKlyHvN15qjmcYHOxWgwHQyArJVN8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mAgGQiYibt6/W5CAo+9L5oS3sdpJlLe5MrCeTey7nag=;
        b=2OFwvwbD8vMJumx42ukjitS0cQwH+tD928x91/hizoohyN/5YQBs/Kf5t49HyoTKh+
         XQXmezCZ8qz1t5GzPyvAiKr1e7i+mljzEmN8/TGy4zHv7hzwBbLG8+jO9QlTNdJFE4Mi
         AuzofVIFLFQbO3CyZSd8xcv4wSpR6ztQaEm6TAHT2Pge2sbZT3TYLxI4d8ZkE6cCMLFk
         VuFaFoVyw19z4FEGqhQMgb+vzdQw0GLYTJV1T9yGT4hPGMoFhTuC1s7CkhbzpeC9Yvy+
         iqiosIB0UnOTfdBdY91qerTf0pRA34ehzHncxUtzS0k8569pzNFgvjyYaSexyJ7DKXOO
         WMxQ==
X-Gm-Message-State: ACrzQf1jhwxYJ3LRomTn8+dRbVpAljbhM2rc03TpyHEzJRgFtRyZIhOI
        rllgR5Yl9tpGD3hde17Ows5Rlg==
X-Google-Smtp-Source: AMsMyM5Z5KYwFCcKEpXGtIhO2+5Vjeb7DMKrGFgP2q/DnCM8F5oFUxdFuQDUtO23wSnmxSQlSSWygA==
X-Received: by 2002:a17:902:e808:b0:17f:92cb:2fdd with SMTP id u8-20020a170902e80800b0017f92cb2fddmr7914995plg.137.1665258265543;
        Sat, 08 Oct 2022 12:44:25 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b1-20020a17090a100100b002005fcd2cb4sm6673353pja.2.2022.10.08.12.44.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Oct 2022 12:44:24 -0700 (PDT)
Date:   Sat, 8 Oct 2022 12:44:23 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        kernel-dev@igalia.com, kernel@gpiccoli.net, anton@enomsg.org,
        ccross@android.com, tony.luck@intel.com
Subject: Re: [PATCH 5/8] pstore: Fix long-term implicit conversions in the
 compression routines
Message-ID: <202210081242.0B0F8B7@keescook>
References: <20221006224212.569555-1-gpiccoli@igalia.com>
 <20221006224212.569555-6-gpiccoli@igalia.com>
 <202210061634.758D083D5@keescook>
 <CAMj1kXF27wZYzXm1u3kKSBtbG=tcK7wOwq6YTwpFg+Z7ic4siQ@mail.gmail.com>
 <202210071234.D289C8C@keescook>
 <11e03e8d-7711-330d-e0d4-808ef9acec3a@igalia.com>
 <CAMj1kXHSSSZ59tihHDNDamczxFCRH8NHzT-eKaZ7xNyqVXW1Hw@mail.gmail.com>
 <dbe57a5e-7486-649f-7093-6da6312a71ee@igalia.com>
 <CAMj1kXHjS+gywpoZ26_Bn76Z_5ohhtoD7ruH0bBYaAQzBY9tuw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXHjS+gywpoZ26_Bn76Z_5ohhtoD7ruH0bBYaAQzBY9tuw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 08, 2022 at 07:52:48PM +0200, Ard Biesheuvel wrote:
> Again, please correct me if I am missing something here (Kees?). Are
> there cases where we compress data that may be compressed already?

Nope, for dmesg, it should all only be text. I'd agree -- the worst case
seems a weird thing to need.

-- 
Kees Cook
