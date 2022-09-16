Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 075055BADE1
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 15:13:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231583AbiIPNN2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 09:13:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231488AbiIPNNQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 09:13:16 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 090709E6A1;
        Fri, 16 Sep 2022 06:13:11 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id b21so21402458plz.7;
        Fri, 16 Sep 2022 06:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=2x1KQsNKeV0XB9Xv+IrmbO09stNWRLC5Mmb0lQO2Zyo=;
        b=XMZ6sPmKspzAh/mU5BE8oUJga20qrfdpZaI+8ae+Q4PHI2WHvMkjKG8fpn8hrxIgp9
         cZuNYf1iRJgJud6XO0mQQo1P8lkBFiGR1fPPNrYVEYpjw0C78IYAwuhyTPuaxzSyKQQo
         91hH+mHUnMT/Y9e4AkQ7lGoGnwXBcpW6BkQeloJlIIB8oNZh9nsWbYCSZg1bEbCpARL8
         43aqXoNe9c7CCLtGZNB7YW9V52K/83AZQC3A2t40uPBBXfglzDUdbi+/XJmakvpeFzjX
         fmJpwPWdIk+aMICgpl095aNoSe2dI5ExR4pzsIlfExx/7QNs3cm8PjJHOIKr0Ex4L1p/
         7GZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=2x1KQsNKeV0XB9Xv+IrmbO09stNWRLC5Mmb0lQO2Zyo=;
        b=vsv9+mL4+V8gR/+86uRYk0hSfY0PjvhL7zOqsBoKrwR32Ne4li59x2miGIZTxyR0hu
         /Dy2p9GyW1ES5+tttls/qFkSdZsZJTIu0bIcQvSypzst4XvlvIxLESTvaZfscm+u8/ID
         3T0Deu9ky1fl0NIoPfh910qrk11OrzdGt203qUfaOfyaGiWtNuLXa2WGGGGv8sMAF8pd
         B2+uu90gnjvdBrrUj0pVmdWGo0ONzdZ65E3IG5fyJKHM7jNty7f0OaRBnR19W0NS8Baq
         1x0roL8smtHuO6tkdn2QELHpT52ctgibEl9L9IoSUQLYupmcZfd0oOKThspXEnKtruI6
         Wr8g==
X-Gm-Message-State: ACrzQf3iIoivGE+iOn3IbEU5CA5wPzSMQxZgcqm8Tw/Ipr91nSW+WaAR
        EVd2Pkr/+YcEnHTpX76McwjmBYjRPA0Png==
X-Google-Smtp-Source: AMsMyM4RnEFrmXGzY7ZZCp9goYhsxDdfxKrdrGkY/7r9lLag44yDnN1Af/UFYyyNSG+9Kwu0zzVSow==
X-Received: by 2002:a17:90a:f3d3:b0:203:182b:9cd9 with SMTP id ha19-20020a17090af3d300b00203182b9cd9mr5447745pjb.41.1663333990389;
        Fri, 16 Sep 2022 06:13:10 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:4b0f:4d7b:7d46:26aa])
        by smtp.gmail.com with ESMTPSA id q6-20020aa78426000000b0053b9e5d365bsm9620498pfn.216.2022.09.16.06.13.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Sep 2022 06:13:08 -0700 (PDT)
Date:   Fri, 16 Sep 2022 06:13:06 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Michael Walle <michael@walle.cc>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gpiolib: fix OOB access in quirk callbacks
Message-ID: <YyR2Yh9iSOF75/7F@google.com>
References: <20220916110118.446132-1-michael@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220916110118.446132-1-michael@walle.cc>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 16, 2022 at 01:01:18PM +0200, Michael Walle wrote:
> Commit a2b5e207cade ("gpiolib: rework quirk handling in of_find_gpio()")
> introduced an array of quirk functions which get iterated over. But a
> sentinal value is missing. Add it.

Oof... Sorry about that.

> 
> Fixes: a2b5e207cade ("gpiolib: rework quirk handling in of_find_gpio()")
> Signed-off-by: Michael Walle <michael@walle.cc>

Reviewed-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Thanks.

-- 
Dmitry
