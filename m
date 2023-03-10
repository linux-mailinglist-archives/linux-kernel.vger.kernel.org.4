Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C218D6B33E2
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 02:58:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbjCJB6e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 20:58:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbjCJB6a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 20:58:30 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01EAC6A2F7
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 17:58:28 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id i10so4062009plr.9
        for <linux-kernel@vger.kernel.org>; Thu, 09 Mar 2023 17:58:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1678413508;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AOHM7hx5EEMDKvTiLCYsUEf17unyK56ZY6RqHsSepXw=;
        b=h2RJEB0oKuuRghDyHy+d9JsKazt80mvgIAKvVN3Z9HYjN0+smoL+JX3Zvs9fzujhA+
         hN8PuMXcAIRBGrmFZG/pC6BHTAopBJOFc3ojdvNTki3xmUxIGS5zKoFQCuBzEMkl6EeM
         4i5pbkQo8OqTvLhaEWVnPdByLr5FDaRVthYEM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678413508;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AOHM7hx5EEMDKvTiLCYsUEf17unyK56ZY6RqHsSepXw=;
        b=FE+PMB3s8W9ikDE6UltBBxSzmmjVod0nF/ATEczYzkuegEsGZUVItm3RWdN+5B125i
         LgUPvBvyE3dTdltxXqhv8FWcIKJxZsxKYADNQGVDXU9cAGBUNRZ7dReQzC+xCgIUwrSj
         pBp66giKDnQKeaX7gOE9OjxlYcm0nDI4csD8+0OyxEmnaTl6tXmEXFvcyX93zxmC8zNC
         o1jOBibnF1t5OBP/WBLm4pJuAz3/pXYlN3SiEqjDx53cblMi9Wr8sEt4tMjRikcttlgO
         xYsLQHQWpV2sxzlQweTcewHxmuJAnBNatKdNUO+DvC2Pc9THJX4vkpNVJl3p26bNagR3
         74Ww==
X-Gm-Message-State: AO0yUKV7GClS6tTCZ99i5fDTOUuYI/uKZ3hAMTf9AFhekNv4NqmaDhzY
        1GmPWEf3h/pYXDDoUn2rtmi1JQ==
X-Google-Smtp-Source: AK7set93GI4rNtTpiCVl8r7LAQjLCFL0zv4sIIg5FGgISkNCVib2TBY+Dhh7jqKYJwndIHdBrjn59Q==
X-Received: by 2002:a17:902:d2cd:b0:19c:e484:b4e with SMTP id n13-20020a170902d2cd00b0019ce4840b4emr29927682plc.59.1678413508503;
        Thu, 09 Mar 2023 17:58:28 -0800 (PST)
Received: from google.com (KD124209188001.ppp-bb.dion.ne.jp. [124.209.188.1])
        by smtp.gmail.com with ESMTPSA id p16-20020a170902ebd000b0019aaba5c90bsm270403plg.84.2023.03.09.17.58.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Mar 2023 17:58:28 -0800 (PST)
Date:   Fri, 10 Mar 2023 10:58:23 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Ricardo Ribalda <ribalda@chromium.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-media@vger.kernel.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        linux-kernel@vger.kernel.org, "hn.chen" <hn.chen@sunplusit.com>
Subject: Re: [PATCH v6 2/5] media: uvcvideo: Quirk for invalid dev_sof in
 Logitech C922
Message-ID: <20230310015823.GF1045797@google.com>
References: <20220920-resend-hwtimestamp-v6-0-c7a99299ec35@chromium.org>
 <20220920-resend-hwtimestamp-v6-2-c7a99299ec35@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220920-resend-hwtimestamp-v6-2-c7a99299ec35@chromium.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (23/03/09 13:55), Ricardo Ribalda wrote:
[..]
> Bus 001 Device 044: ID 046d:085c Logitech, Inc. C922 Pro Stream Webcam
> Device Descriptor:
>   bLength                18
>   bDescriptorType         1
>   bcdUSB               2.00
>   bDeviceClass          239 Miscellaneous Device
>   bDeviceSubClass         2
>   bDeviceProtocol         1 Interface Association
>   bMaxPacketSize0        64
>   idVendor           0x046d Logitech, Inc.
>   idProduct          0x085c C922 Pro Stream Webcam
>   bcdDevice            0.16
>   iManufacturer           0
>   iProduct                2 C922 Pro Stream Webcam
>   iSerial                 1 80B912DF
>   bNumConfigurations      1
> 
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>

Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
