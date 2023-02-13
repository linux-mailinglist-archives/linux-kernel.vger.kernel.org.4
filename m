Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB5D1694945
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 15:58:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230109AbjBMO6C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 09:58:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230384AbjBMO5y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 09:57:54 -0500
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDEDC1CAFC;
        Mon, 13 Feb 2023 06:57:08 -0800 (PST)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-16346330067so15450061fac.3;
        Mon, 13 Feb 2023 06:57:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KYi6IQy326urI0Fok5Qrbgz/41khhOHXThMT8WCNr48=;
        b=Uj3OyN2VBji0hBiXFC/tby9P1n9upeaCSSpnie140UHk8TJka8WEXPLzq2BMlTNrh9
         hWDLwQbF1VUV1Viv9sB3SHJmOgMfjCGjjyYPWGmLUMQZpulGngmeBsaiKg+HtTiiPhrB
         nynf+urdAzizsRT0jnrc6YixE7WCa2yOkUJvXM3lO+WXsK3UzVfHqMh0NU+6ekkVU1IZ
         26dDy2iIoaQ9iF+fGZ5vK3ePK50cSxRuy6dmDJFdf1dlARuC/A6OA9BcOTy3b7RKKAYS
         QLn0/I8xI4PAUlyKjw0+TFi+sVLCLAi6Fgl7VS9AGaPu12AdpjPWk8/OqsSQ7/jHlL31
         7Iuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KYi6IQy326urI0Fok5Qrbgz/41khhOHXThMT8WCNr48=;
        b=zMyRTWyvX3zwEZNgITvioRy7jHmwgQnJcHTlPfXqFJnwo/a+ciO1mRSra6b/7ntufn
         Zr99vFABVKi2SDiA7MT6Hfa/e5zIl4N0i2Bhz6CtC9YVvVSMUzpxJIEv5Qlyuj4JqVtj
         ZKE0LSGocHzp3Qhq+RTpD+QQnnY/Dl+Xtok+jZFwcGGooaKcbUwoPHKse8RNhuqUx2kc
         NomR6nROA0XF4HE3eKzqwGtm8RGXyhfFN0/98KYt3cmPNnYYFpcZ4JGpr1X7F2FlSoM3
         yAam9L+afYPXDy7fRwPP0qhOlr2P7RHnfEfyEmeukBYG8pyJypNZRbNWlwum2jouqIjs
         yM1A==
X-Gm-Message-State: AO0yUKXwzby7CATlBzVdVg/wWNcwCx8rpTAkVPwZdW91+ur3hE35dodQ
        WaRryi3A4EOfKZwunFzp1EL4hXqKcWM=
X-Google-Smtp-Source: AK7set/fiwZyYDI2RhKo9qMonspxlbiz9/Tjv69f8bkNVJZN4/Vlx5ZmzjdCMd8QqIxJg5BEIwxeWw==
X-Received: by 2002:a05:6870:a446:b0:16d:e12c:fa67 with SMTP id n6-20020a056870a44600b0016de12cfa67mr6054826oal.1.1676300227296;
        Mon, 13 Feb 2023 06:57:07 -0800 (PST)
Received: from tx3000mach.io (static.220.238.itcsa.net. [190.15.220.238])
        by smtp.gmail.com with ESMTPSA id h4-20020a056870d34400b00144e18d8525sm4868366oag.25.2023.02.13.06.57.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Feb 2023 06:57:06 -0800 (PST)
From:   Martin Rodriguez Reboredo <yakoyoku@gmail.com>
To:     andrea.righi@canonical.com
Cc:     alex.gaynor@gmail.com, bjorn3_gh@protonmail.com,
        boqun.feng@gmail.com, gary@garyguo.net,
        linux-kernel@vger.kernel.org, ojeda@kernel.org,
        rust-for-linux@vger.kernel.org, wedsonaf@gmail.com
Subject: Re: [PATCH] rust: fix regexp in scripts/is_rust_module.sh
Date:   Mon, 13 Feb 2023 11:56:59 -0300
Message-Id: <20230213145659.656514-1-yakoyoku@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230210152622.92912-1-andrea.righi@canonical.com>
References: <20230210152622.92912-1-andrea.righi@canonical.com>
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

On Fri, Feb 10, 2023 at 4:26 PM Andrea Righi <andrea.righi@canonical.com> w=
rote:=0D
> nm can use "R" or "r" to show read-only data sections, but=0D
> scripts/is_rust_module.sh can only recognize "r", so with some versions=0D
> of binutils it can fail to detect if a module is a Rust module or not.=0D
=0D
As __IS_RUST_MODULE can be a dynamic symbol too this change seems=0D
reasonable to merge.=0D
=0D
Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>=0D
