Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 425476A1D8A
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 15:37:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229606AbjBXOhP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 09:37:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229936AbjBXOhN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 09:37:13 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B18F7679B4;
        Fri, 24 Feb 2023 06:37:11 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id gi3-20020a17090b110300b0023762f642dcso2895997pjb.4;
        Fri, 24 Feb 2023 06:37:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GtHGA3HFyOs3Fz5IJ5DexsxarDl9tkHRWlmic7uJ/C4=;
        b=Dx2Grd9BGKbRDkGFAUPYQ8vTzH8QWnDRsrCraVsYxfUEWdevRLBi1R7C5EZoW7zxZ+
         pLz5iJ+OsoHHhgDycBidBpMHnZMuQ8p67MXtb5rU859qW8JxsTxD83dfz2l2zp1PfH7D
         3IpSsiccmyOeXVqk5vpQAbjayRtfEjZ0EtE4NMKFqERzsKFNfDaKZ3V0sS8jVgAMJqXl
         Iqt6vwYqQCLDLJ+/5+bB5BRj73Mi2AjmkamOWkf3SswgDF+YjKKnemJbrIVpmwv8HR+q
         jNdjAHK4HrQm720hJSG9zDcdielgSq66xcEZpQmUoOIX3NNzITIsdDyEDBef5BH5A2Fj
         IYwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GtHGA3HFyOs3Fz5IJ5DexsxarDl9tkHRWlmic7uJ/C4=;
        b=XxzcU/EgMS0GdEy/7uUl5IvaRySUDltAdbwyP4jKvCp6mpfz/tAdGaTuFRizRMS3qU
         oMD3jallG8okoAAXfbLf27Hcu4tIY07EkjpNMWXxozIimdoiCGrseQaGgx1wW7Nhq3Tl
         yTo1s0Cz64Nk2ZYUMLB+3m4hykc4aTUHSlQbSTuJq/8pF9gpywEsrf8uXoCR+auxD+XZ
         4BokvKO4JX1s0Zw/YS6nW43YcV3uuZ2/HDCdrJL8cNscMXawQmExrzKB85dysppm9Mgn
         WtfLftek0IWRNtBk0+Klj+cvA+yCTbrJTMgOxtXqyiKoCpZ/PPodsN9WT9OAzVh14C2y
         VhpA==
X-Gm-Message-State: AO0yUKV0M/scMrblbWG5a8+4GkFqKELzKMD0yFeR3tI8LYCvPYTzdjwu
        J9+am4Y0ps0+2a74lWV3cEg=
X-Google-Smtp-Source: AK7set/ujXfZPMz7EOm7ZILbEIxe4nKgXMWAwvoatB7ZrSFIzQwgPsGrmI4DoRt0El6v7VLELq5Q8w==
X-Received: by 2002:a17:902:f605:b0:19c:dd2e:d4f5 with SMTP id n5-20020a170902f60500b0019cdd2ed4f5mr991892plg.36.1677249431225;
        Fri, 24 Feb 2023 06:37:11 -0800 (PST)
Received: from tx3000mach.io (static.220.238.itcsa.net. [190.15.220.238])
        by smtp.gmail.com with ESMTPSA id k4-20020a170902694400b001963a178dfcsm4047493plt.244.2023.02.24.06.37.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Feb 2023 06:37:10 -0800 (PST)
From:   Martin Rodriguez Reboredo <yakoyoku@gmail.com>
To:     lina@asahilina.net
Cc:     alex.gaynor@gmail.com, asahi@lists.linux.dev,
        bjorn3_gh@protonmail.com, boqun.feng@gmail.com, gary@garyguo.net,
        linux-kernel@vger.kernel.org, ojeda@kernel.org,
        rust-for-linux@vger.kernel.org, wedsonaf@gmail.com
Subject: Re: [PATCH 2/2] rust: sync: arc: Add UniqueArc<MaybeUninit<T>::assume_init()
Date:   Fri, 24 Feb 2023 11:37:01 -0300
Message-Id: <20230224143701.755103-1-yakoyoku@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230224-rust-arc-v1-2-568eea613a41@asahilina.net>
References: <20230224-rust-arc-v1-2-568eea613a41@asahilina.net>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 24, 2023 at 04:59:34PM +0900, Asahi Lina wrote:=0D
> We can already create `UniqueArc<MaybeUninit<T>>` instances with=0D
> `UniqueArc::try_new_uninit()` and write to them with `write()`. Add=0D
> the missing unsafe `assume_init()` function to promote it to=0D
> `UniqueArc<T>`, so users can do piece-wise initialization of the=0D
> contents instead of doing it all at once as long as they keep the=0D
> invariants (the same requirements as `MaybeUninit::assume_init()`).=0D
> =0D
> This mirrors the std `Arc::assume_init()` function. In the kernel,=0D
> since we have `UniqueArc`, arguably this only belongs there since most=0D
> use cases will initialize it immediately after creating it, before=0D
> demoting it to `Arc` to share it.=0D
=0D
Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>=0D
