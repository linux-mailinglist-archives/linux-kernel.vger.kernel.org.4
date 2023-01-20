Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5E72675BA0
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 18:34:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbjATReu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 12:34:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbjATRes (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 12:34:48 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53CC9D0D9A;
        Fri, 20 Jan 2023 09:34:26 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id dw9so6252974pjb.5;
        Fri, 20 Jan 2023 09:34:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3Qce6k9mwqU5NepWopiJstouIyBahOLCg81PX5JZd30=;
        b=ZPDBONsa4pvvRK5jyivblqdBW+xQdjUEPbjs7JXsNwiVlHcJ3tL3gbywzoJJ/O2uhw
         i7pvVM7hGn+zQTy+0Fg48O1bikjvnNmGGPPn1RDkyBVKC4Q/6wv1kof5efl2WbbMhM2x
         BomDsKoFMuyEsQiOb8Ws0hcri0T0tTPSopg0O1fqjkxrP8U3IbxRrRM3me8hO79pvo8t
         7zMn5NCYQHfnHr1wx8IMdptfIc8zS1IDj1RpRICWKPoLIzA2mOS4vqnezJZXc2EXynhv
         STzsCf+UthobniN2ZlbBOjzy/n6XUq/SqdvgzemVPeAdcMh2LFgVSFfObLmG+5v8u/VI
         TspQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3Qce6k9mwqU5NepWopiJstouIyBahOLCg81PX5JZd30=;
        b=Z+ILxifTY458eVv93bNXsha0SlinyUPTaXMin8Z+gXTGW6xkBnSARvMwygLBa51vem
         +tTXqzrFiIEdIXbJocPSzc5LYqE05f/lPlBFjlall41eEDHT0LFVNUZ4AsGmV96/YVPs
         K9/pbP4wtqGDQIdsWlrLDfHRmHw8CNVcUBVbthmH46Ka9jFFw/GySY+tgVp/hXQZGapn
         Ef+7JSVXQwAZw8wVVO8OeFzfm1lZB6oRGib94+Qbm9T2nhDhwpeENulw0AwD0BCkLncR
         0UxRiktx3qGU1ewSavMus0YCyI9VIXfJpRv2vWWN4NgwxuLZTC5Q9qTGK9v1M1ki/O5j
         DCRQ==
X-Gm-Message-State: AFqh2krMf+0PL6kNixDjhkFBILKkfQRpQWpQyngJ7qruKldKYni8mjwc
        ot0e03ywli9BiGkze7teq/s=
X-Google-Smtp-Source: AMrXdXsH7iofW0AYixH1DqxtihjqFnYzTUw4bqjfk+uyoNypBz1JULxrgW1Gn+t76PeQxZdIovQLZw==
X-Received: by 2002:a17:90b:1652:b0:22b:b6b0:788f with SMTP id il18-20020a17090b165200b0022bb6b0788fmr1964438pjb.14.1674236063174;
        Fri, 20 Jan 2023 09:34:23 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:3bfe:a22:9187:ed3b])
        by smtp.gmail.com with ESMTPSA id z17-20020a17090abd9100b00219752c8ea5sm1760839pjr.37.2023.01.20.09.34.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jan 2023 09:34:22 -0800 (PST)
Date:   Fri, 20 Jan 2023 09:34:19 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     =?utf-8?B?am9ld3Uo5ZCz5Luy5oyvKQ==?= <joewu@msi.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Xiang wangx <wangxiang@cdjrlc.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Prashant Malani <pmalani@chromium.org>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "chrome-platform@lists.linux.dev" <chrome-platform@lists.linux.dev>,
        Benson Leung <bleung@chromium.org>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Guenter Roeck <groeck@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Daisuke Nojiri <dnojiri@chromium.org>,
        Derek Huang <derekhuang@google.com>,
        "Dustin L . Howett" <dustin@howett.net>,
        Furquan Shaikh <furquan@chromium.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lee Jones <lee.jones@linaro.org>,
        Tzung-Bi Shih <tzungbi@kernel.org>
Subject: Re: [PATCH v2] cros_ec_keyb: Add 3 buttons for monitor function
Message-ID: <Y8rQmxpmf47v7pyS@google.com>
References: <e23628e2cb464d238eb1c33a9e1e516b@msi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e23628e2cb464d238eb1c33a9e1e516b@msi.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 23, 2022 at 07:18:06AM +0000, joewu(吳仲振) wrote:
> Add 3 extra buttons: 'brightness up', 'brightness down'
> and 'screen lock' to support monitor manipulating function.
> 
> Signed-off-by: Joe Wu <joewu@msi.com>

Applied, thank you.

-- 
Dmitry
