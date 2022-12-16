Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31E4764F1A5
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 20:19:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231642AbiLPTTV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 14:19:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229896AbiLPTTS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 14:19:18 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72FAE2D1C4;
        Fri, 16 Dec 2022 11:19:15 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id a9so3249563pld.7;
        Fri, 16 Dec 2022 11:19:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Ugxhu4FBglbjLikh6uPAoaI4HXZLlk6yZaGG1+Cep5g=;
        b=KpRVudeGJv5pInD4KE6reKMeoy7bEoFZkTE5+v0monRQ3zmXFq5dovn8JOTOOJ3T5F
         7pdEOoZ/ewKwnFVRu67o5PjkXZ7aAgNqcKBC2WcYae4d33643212lNx+hz/BVCX5LP6r
         XC2Jr17sgy+Dwech521QgenQokCQjWBxZtdEyD8/ZJZmrNg9jvgLh6FXLgtAFQwcI0/5
         dqhE9RKq6vKsgwlyuFwFQ9Iq0epO6Bcw+AjFB8mV7N6GeOaDY4v7RZOHXjb+AR1Dn0Js
         3334OqgTu7HcG5QFf3am08OWTyDRzph8NZFekyTxPP50Bgvorb1QiMg1yOzN5emwz+JE
         OPTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ugxhu4FBglbjLikh6uPAoaI4HXZLlk6yZaGG1+Cep5g=;
        b=X2NXMsC15Dq3x/20CZhfIm2rAeXBE7kDVbhgbqypt/iNtqFugAYpkOh9DfqsqpH8ee
         2vnJQTy6ekq7sUpO6Vf5Aq0ju47vHKiUdcGVqo4PRYD34vtDrOlTeiu46NM2NASa/Cv1
         v6j8MhwvsnQuBPDuAhK3CPDfPuPf6Nk4u+fJWlFMrOfnvBJDZpxDkmKV0MnI5L1tOvIv
         1hHByp4ymr2pB52SOh1HzQm1oL6+zum1w0MmCbSREyxmnSQ2/N7ENNv59cIYNqQSD7tF
         gqLlkrpn2+VbANT6qsjm10qzJ6QsTl27q+/qVxO307DXroJUuokatrsb/bcuBGZwBzgu
         yjGA==
X-Gm-Message-State: ANoB5pkdXXDj5koFyqtU5ZcXYr7eL91+VW5CHH2oP+4etNhjM2ddjj5I
        Hv4ymqPJIujPgGMmlBPar+s=
X-Google-Smtp-Source: AA0mqf5ys3ffyGNG5TUwnGwvLlXiSwadMSQRypX2wPbuEjQZOw8vjGmraT9nAai3RFFJWPDspwGNzg==
X-Received: by 2002:a17:903:1302:b0:189:7e2f:d64c with SMTP id iy2-20020a170903130200b001897e2fd64cmr33022272plb.55.1671218354525;
        Fri, 16 Dec 2022 11:19:14 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:211:6b31:5f6:6aef])
        by smtp.gmail.com with ESMTPSA id o9-20020a170903210900b00186b138706fsm2013870ple.13.2022.12.16.11.19.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Dec 2022 11:19:13 -0800 (PST)
Date:   Fri, 16 Dec 2022 11:19:10 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     =?utf-8?B?am9ld3Uo5ZCz5Luy5oyvKQ==?= <joewu@msi.com>
Cc:     Joe Wu <joewu@msi.corp-partner.google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Xiang wangx <wangxiang@cdjrlc.com>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        Derek Huang <derekhuang@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Benson Leung <bleung@chromium.org>,
        Daisuke Nojiri <dnojiri@chromium.org>,
        Prashant Malani <pmalani@chromium.org>,
        Furquan Shaikh <furquan@chromium.org>,
        Tzung-Bi Shih <tzungbi@kernel.org>,
        "chrome-platform@lists.linux.dev" <chrome-platform@lists.linux.dev>,
        Douglas Anderson <dianders@chromium.org>,
        "Dustin L . Howett" <dustin@howett.net>,
        Guenter Roeck <groeck@chromium.org>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: Re: [PATCH] cros_ec_keyb: Add 3 buttons for monitor function
Message-ID: <Y5zErm1YuXlBBHYw@google.com>
References: <20221215061550.18993-1-joewu@msi.corp-partner.google.com>
 <Y5uZNVzEgsKzlPD0@google.com>
 <5f36a68518ca44aa9566a5df801bccaa@msi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5f36a68518ca44aa9566a5df801bccaa@msi.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 16, 2022 at 01:36:24AM +0000, joewu(吳仲振) wrote:
> Hi Dmitry,
> 
> Thank you for comments. I will try to give a clear description and sent the patch again.
> Actually, the function of "leave PC(cros) mode" button is to implement 'lock the screen' in chromeOS.
> Google suggests us to sent 'F13' key to lock the screen, could we do it or do you have any suggestion? 

Is this different from the normal power button? If it is the key with
"padlock" glyph you want to map it to KEY_SLEEP or KEY_SCREENLOCK.

We should no longer use or recommend overriding F13 for this.  Is there
an internal Google bug for this? Could you add dtor@google.com there?

Thanks.

-- 
Dmitry
